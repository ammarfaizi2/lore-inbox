Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbRDJSsf>; Tue, 10 Apr 2001 14:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbRDJSs0>; Tue, 10 Apr 2001 14:48:26 -0400
Received: from pixar.pixar.com ([138.72.10.20]:54181 "EHLO pixar.pixar.com")
	by vger.kernel.org with ESMTP id <S131626AbRDJSsO>;
	Tue, 10 Apr 2001 14:48:14 -0400
Date: Tue, 10 Apr 2001 11:48:07 -0700
From: Audrey Wong <awong@pixar.com>
To: linux-kernel@vger.kernel.org
cc: Kiril Vidimce <vkire@pixar.com>, Audrey Wong <awong@pixar.com>
Subject: out-of-band message causing read on socket to be corrupted.
Message-ID: <Pine.SGI.4.21.0104101131210.534654-100000@vernal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is my problem:

My server program is continually sending the client a whole lot of
messages. 

The client sends the server an MSG_OOB(out-of-band) message, goes to
sleeps in a loop and waits for the server to reply.  

The server's reply to this message will raise the signal SIGURG, which
wakes up the client. 

The client then proceeds to read the reply and continues to process the 
rest of the messages. But the messages that it reads after that are all
corrupted. 

Does anyone know why this is?  This only happens on linux (2.2.16, 2.2.17,
2.4.1) but not irix or suns.


thanks
audrey

ps: i've enclosed my simple test case below.
-----------------------------------
/* client.c */


#include "tcpDefs.h"

static void
sigUrgHandler(int sig)
{
    fprintf(stderr, " \n!!!sigUrgHandler!!!!\n");
    signal(SIGURG, sigUrgHandler);
}

static int
getOOBReply( int sd ) {

    int rv;
    char msg;

    fprintf(stderr, " -> getOOBReply! ");
    for (;;) {
	
	rv = recv( sd, &msg, sizeof( msg ), MSG_OOB );
	fprintf(stderr, ".");
	if (rv == sizeof(msg)) {
	    fprintf(stderr, " rv= %d \n", rv);
	    return msg;
	}
	sleep(1);
    }
}

void sendOOBMsg(int sd) {

    fprintf(stderr, " -> SendOOBMsg \n");
    if (!SendMsg( sd, CP_EH_DELETEQ ))
	return;
    getOOBReply(sd);
}

void getNextMsg(int sd) {

    int cnt=0;
    int br, rr, flag;
    CpMsg msg;
    fd_set fdset;
    struct timeval timeout;

    fprintf(stderr, " ------ GetNextMsg! ------ \n");
    for (;;) {

	FD_ZERO(&fdset);
	FD_SET(sd, &fdset);
	timeout.tv_sec = 0;
	timeout.tv_usec = 0;

	/* see if there are any events to read. */
	flag = select(sd+1, &fdset, 0, 0, &timeout);
	if (flag <= 0)
	    continue; /* no events to read, sorry. */
	
	if (ReadMsg(sd, &msg)) {
	    fprintf(stderr, " Msg= (%s %c)\n", PrintMsgId(msg.id), msg.data);

	    if (msg.id == CP_EH_LUXO_DONE) {
		fprintf(stderr, " quitting!\n");
		return;
	    }

	    if (msg.id == CP_EH_HELLO) {
    	    	SendMsg(sd, CP_EH_HELLO);
		continue;
  	    }
	    cnt++;
	    if ( cnt >= 5) 
		sendOOBMsg(sd);
	}
    }

}

int main (int argc, char *argv[]) {

    struct sockaddr_in localAddr, servAddr;    
    struct utsname host;
    struct hostent *hp;

    int one = 1;
    int p_proto;
    
    int sd, rc, i, pid;
    
    hp = gethostbyname(argv[1]);
    if(hp==NULL) {
	printf("%s: unknown host'\n");
	return -1;
    } else 
	fprintf(stderr, " Host= %s\n", argv[1]);
    
    /* create socket */
    sd = socket(AF_INET, SOCK_STREAM, 0);
    if(sd<0) {
	perror("cannot open socket ");
	return -1;
    } else
	fprintf(stderr, " creating socket! sd=%d\n", sd);

    /* bind any port number */
    memset((caddr_t) &localAddr, 0, sizeof(localAddr));
    localAddr.sin_family = AF_INET;
    localAddr.sin_addr.s_addr = htonl(INADDR_ANY);
    localAddr.sin_port = htons(0);
  
    rc = bind(sd, (struct sockaddr *) &localAddr, sizeof(localAddr));
    if(rc<0) {
	fprintf(stderr, "%s: cannot bind port TCP \n");
	exit(1);
    }

    servAddr.sin_port = htons(CP_EH_PORT);
    servAddr.sin_family = hp->h_addrtype;
    memcpy((char *) &servAddr.sin_addr.s_addr, hp->h_addr_list[0], hp->h_length);

    /* connect to server */
    rc = connect(sd, (struct sockaddr *) &servAddr, sizeof(servAddr));
    if(rc<0) {
	fprintf(stderr, "cannot connect ");
	return -1;
    }
    
    p_proto = getprotobyname("tcp")->p_proto;
    if ( setsockopt( sd, p_proto, TCP_NODELAY, (char *)&one, sizeof(one) )
	 < 0 ) {
	fprintf(stderr, "cannot setsockopt\n");
	return -1;
    }

    pid = getpid();
    if ( fcntl(sd, F_SETOWN, pid) < 0)
	fprintf(stderr, " fcntl didnt succeed\n");
    
    signal( SIGURG, sigUrgHandler);

    usleep(900);
    getNextMsg(sd);

    return 0;
  
}

---------------------------
/* server.c */


#include "tcpDefs.h"

int client_fd = -1;

int ProcessMsg( int fd, CpMsg *msg) {
    int i;
    char rv = 1;
    switch (msg->id) {
    case CP_EH_LUXO_DONE:
	fprintf(stderr, " quitting!\n");
	return -1;
    case CP_EH_HELLO: {
	fprintf(stderr, "Sending 10 messg!\n");
	for (i=0; i<20; i++) {
	  SendMsg(fd, CP_EH_SEND_EVENT);
	}
	break; }
    case CP_EH_DELETEQ:
	fprintf(stderr, " sending client OOB message!\n");
	send(fd, &rv, sizeof(rv), MSG_OOB);
	break;
    }
	return 1;
}

static void Quit() {
    	fprintf(stderr, " .. quiting .. \n");
	SendMsg(client_fd, CP_EH_LUXO_DONE);
	exit(1);
}


int main (int argc, char *argv[]) {

    CpMsg msg;
    int i, sd, newSd, cliLen, flag;
    int hiFd;
    fd_set fdset, readfdset;
    struct timeval timeout;
    struct sockaddr_in cliAddr, servAddr;
    
    /* create socket */
    sd = socket(AF_INET, SOCK_STREAM, 0);
    if(sd<0) {
	perror("cannot open socket ");
	return -1;
    }
 	hiFd = sd; 
    /* bind server port */
    servAddr.sin_family = AF_INET;
    servAddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servAddr.sin_port = htons(CP_EH_PORT);
  
    if(bind(sd, (struct sockaddr *) &servAddr, sizeof(servAddr))<0) {
	perror("cannot bind port ");
	return -1;
    }

    listen(sd,5);

    printf("waiting for data on port TCP %u\n",CP_EH_PORT);
    signal(SIGQUIT, Quit);
	
    cliLen = sizeof(cliAddr);
	newSd = accept(sd, (struct sockaddr *) &cliAddr, &cliLen);
	if(newSd<0) {
	    perror("cannot accept connection ");
	    return -1;
	} else {
		fprintf(stderr, " NewConnection %d\n", newSd);
    		client_fd = newSd;
		SendMsg(client_fd, CP_EH_HELLO);
		if (newSd > hiFd)
		    hiFd = newSd;
	}

	FD_ZERO(&readfdset);
	FD_SET(client_fd, &readfdset);
    
    while (1) {
	timeout.tv_sec = 0;
	timeout.tv_usec = 0;
	
	/* see if there are any events to read. */
	fdset = readfdset;
	flag = select(hiFd+1, &fdset, 0, 0, &timeout);
	if (flag <= 0) 
    		continue;
	
	if (FD_ISSET(client_fd, &fdset) && ReadMsg(client_fd, &msg)) {
	      if ( ProcessMsg(client_fd, &msg) == -1)
		break;
	}
    } /* while (1) */
}


-----------------------------
/* tcpDefs.h  */


#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/utsname.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <netdb.h>
#include <sys/file.h>
#include <string.h>
#include <netinet/in.h>
#include <netdb.h>
#include <fcntl.h>
#include <errno.h>


#define CP_EH_PORT 7012
#define MAX_MSG 100
#define MSGSIZE 8

typedef enum CpMsgId {
    CP_EH_HELLO,	
    CP_EH_EXPRESS_INTEREST,	
    CP_EH_REVOKE_INTEREST,
    CP_EH_SEND_EVENT,	
    CP_EH_POLL,	
    CP_EH_CURSORON,	
    CP_EH_CURSOROFF,
    CP_EH_SETCURSOR,
    CP_EH_SETTABMAP,
    CP_EH_PRINTINTERESTS,	
    CP_EH_GETTABMAP,	
    CP_EH_REGISTER,
    CP_EH_DEREGISTER,	
    CP_EH_DELETEQ,
    CP_EH_DIE,	
    CP_EH_PRINTRESOURCES,	
    CP_EH_SAVE_CANVAS,	
    CP_EH_GET_CANVASES,	
    CP_EH_EVENT,
    CP_EH_GOOD_STATUS,	
    CP_EH_BAD_STATUS,	
    CP_EH_GETTABMAP_REPLY, 
    CP_EH_PRINT_REPLY,    
    CP_EH_GRAB,         
    CP_EH_UNGRAB,       
    CP_EH_READ_CANVAS, 	
    CP_EH_FREE_TEXTURE,  
    CP_EH_LUXO_DONE   
} CpMsgId;


typedef struct {
    CpMsgId id;
    char data;
} CpMsg;


int ReadMsg(int sd, CpMsg *msg) {
    int br, rr;
    char *p = (char*) msg;
    
    br =0;
    fprintf(stderr, " reading msg: %d:", sd);
    while ( br < MSGSIZE ) {
	rr = read(sd, p, MSGSIZE);
	if (rr < 0) {
	    fprintf(stderr, " no mesg read!\n");
	    return -1;
	}
	fprintf(stderr, "%d.", rr);
	br += rr;
	p += rr;
    }
    fprintf(stderr, "\n");
    return 1;
}

char* PrintMsgId(int msgId) {
    switch(msgId)  {
    case CP_EH_HELLO:
	return "CP_EH_HELLO";
    case CP_EH_SEND_EVENT:
	return "CP_EH_SEND_EVENT";
    case CP_EH_DELETEQ:
	return "CP_EH_DELETEQ";
    case CP_EH_LUXO_DONE:
	return "CP_EH_LUXO_DONE";
    default:
	fprintf(stderr, "unknown msg id %d", msgId);
	return "Unknown";	
    }
}

int SendMsg(int sd, int msgId) {
    
    CpMsg msg;
    int bw=0, wr;
    char *p;

    msg.id = msgId;
    msg.data = 'k';

    p = (char*)&msg;
    
    fprintf(stderr, " sending msg (%s,%c) to %d: ", 
	    	PrintMsgId(msgId), msg.data, sd);
    while (bw < sizeof(CpMsg)) {
	wr = write(sd, p, sizeof(msg) -bw);
	fprintf(stderr, ".%d.", wr);
	if (wr < 0) {
	    fprintf(stderr, " write error! \n");
	    return 0;
	}
	bw += wr;
	p += wr;
    }
    fprintf(stderr, "\n");
    return 1;
}
------------

