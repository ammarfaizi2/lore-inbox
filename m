Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVEWLSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVEWLSZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 07:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVEWLSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 07:18:25 -0400
Received: from berlioz.imada.sdu.dk ([130.225.128.12]:25242 "EHLO
	berlioz.imada.sdu.dk") by vger.kernel.org with ESMTP
	id S261163AbVEWLRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 07:17:40 -0400
From: Hans Henrik Happe <hhh@imada.sdu.dk>
Subject: Issues with INET sockets through loopback (lo)
Date: Mon, 23 May 2005 13:17:43 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YvbkCpanfoBiFUS"
Message-Id: <200505231317.44716.hhh@imada.sdu.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_YvbkCpanfoBiFUS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

During development of a token-based distributed mutual exclusion algorithm I 
observed some odd behavior when testing the code locally on one machine. 

When multiple processes communicate through INET sockets in an irregular 
pattern Linux goes into the idle state even though there always are data to 
be delivered. It doesn't stop, it just doesn't use all the available CPU 
time.

To test this further i wrote a program (attach: random-inet.c) that shows this 
behavior. It starts a number processes and connects them with INET sockets. 
Then n startup messages are sent. When a process receives a message it 
randomly selects a destination to forward it to. This way there will always 
be n messages in transit. The issues can be observed with just 3 processes 
and 1 message. Usage:

random-init <# processes> <# messages>

I.e. with 16 processes and 1 message the CPU utilization is only 20% on a 
1.6GHz Celeron M.

I have tried more regular communication patterns but this gives full CPU 
utilization as expected. For instance sending messages in a ring (attach: 
ring-inet.c). 

I discovered another issue when using many messages (i.e. 16 processes and 16 
messages). The responsiveness of the system degrades massively. It takes 
seconds before keyboard input are displayed. Of cause there are many very IO 
bound processes, but I'm not sure if the impact should be that high.   

I have observed the issues with many kernel versions (uniprocessor): 2.4.24, 
2.6.3-7mdk, 2.6.11-gentoo-r6 and 2.6.12-rc4. 

As a sanity check I have also tried with UNIX sockets (socketpair(2)). This 
shows none of the above issues. 

I believe that the problem must be somewhere in the INET socket 
implementation. The reason that I don't think it is in the loopback, is that 
when run in a cluster there seam to be more latency than one would expect. I 
haven't tested this thoroughly, though.

I have tried to look at the kernel code in order to find the reason for this 
behavior, but I must admit that my knowledge of the inner workings of the 
kernel is not that great.

I hope that others can comfirm that this is an issue or otherwise explain why 
it is supposed behave this way.

Regards
Hans Henrik Happe

--Boundary-00=_YvbkCpanfoBiFUS
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="random-inet.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="random-inet.c"

/* 
 * usage: random-inet <# processes> <# messages>
 */

#include <asm/msr.h>

#include <stdio.h>
#include <poll.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/tcp.h>
#include <fcntl.h>
#include <netdb.h>


int do_connect(int port) {
   int n, sock, on=1;
   struct addrinfo hints, *res;
   char str[6];
   void *adr;
    
   memset(&hints, 0, sizeof(struct addrinfo));
    
   hints.ai_flags    = AI_PASSIVE;
   hints.ai_family   = PF_UNSPEC;
   hints.ai_socktype = SOCK_STREAM;

   sprintf(str, "%d", port);
   n = getaddrinfo("localhost", str, &hints, &res);

   if (n != 0) {
       fprintf(stderr,
               "getaddrinfo error: [%s]\n",
               gai_strerror(n));
       return -1;    
   }
   
   sock = socket(AF_INET, SOCK_STREAM, 0);
   if (sock == -1) {
       perror("socket");
       return -1;
   }

    
   if (setsockopt(sock, SOL_TCP, TCP_NODELAY, &on, sizeof(on)) == -1) {
       perror("setsockopt");
       return -1;
   }
   
   if (connect(sock, (struct sockaddr *)res->ai_addr, sizeof(*res->ai_addr)) == -1) {
       perror("connect");
       return -1;
   }
   
   freeaddrinfo(res);

   return sock;
}

int start_listen(int port) {
    int n, on=1;
    int sock;    
    struct sockaddr_in name;
   
        
    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock == -1) {
        perror("socket");
        return -1;
    }

    if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on)) == -1) {
        perror("setsockopt");
        return -1;
    }
        
    name.sin_family = AF_INET;
    name.sin_port = htons (port);
    name.sin_addr.s_addr = htonl (INADDR_ANY);
    
    if (bind (sock, (struct sockaddr *) &name, sizeof (name)) == -1) {
        perror("bind");
        return -1;
    }      
    
    if (listen(sock, 10) == -1) {
        perror("listen");
        return -1;
    }
    
    return sock;  
}
        
int do_accept(int lsock) {
    struct sockaddr addr;
    socklen_t len = sizeof(addr);
    int sock, on=1;


    if ((sock = accept(lsock, &addr, &len)) == -1) {
        perror("accept");
        return -1;
    }

    if (setsockopt(sock, SOL_TCP, TCP_NODELAY, &on, sizeof(on)) == -1) {
        perror("setsockopt");
        return -1;
    }
        
    return sock;
}

int do_read(int fd, void *buf, int n) {
    
    n = read(fd, buf, n);
    if (n == -1) {
        perror("read");    
    }
    return n;
}

int do_write(int fd, void *buf, int n) {
    
    n = write(fd, buf, n);
    if (n == -1) {
        perror("write");    
    }
    return n;
}


int main(int argc, char *argv[]) {
    int i, n, cnt, pid, dest;
    int lsock;
    char data, id, rank;
    int port = 11100;
    
    /* # processes */
    cnt = atoi(argv[1]);
    
    /* # messages */
    n = atoi(argv[2]);

    {
        int socks[cnt];    
        struct pollfd pfds[cnt-1];
           
        /* Create processes */
        rank = 0;
        for (i=1; i<cnt; i++) {
            pid = fork();
            if (pid == 0) {
                rank=cnt-i;
                break;    
            }
        }

        /* Setup connections */
        lsock = start_listen(port+rank);

        
        sleep(2); /* "Ensure" that all processes are listening, HACK!!! */
                
        for (i=0; i<rank; i++) {
            pfds[i].fd = do_accept(lsock);
            do_read(pfds[i].fd, &id, 1);
            do_write(pfds[i].fd, &rank, 1);

            socks[id] = pfds[i].fd;
            pfds[i].events = POLLIN;
        }
        
        for (i=rank; i<cnt-1; i++) {
            pfds[i].fd = do_connect(port+i+1);
            
            do_write(pfds[i].fd, &rank, 1);
            do_read(pfds[i].fd, &id, 1);
            
            socks[id] = pfds[i].fd;
            pfds[i].events = POLLIN;
        }
                
        srandom(rank);        
  
        /* Write startup messages */
        if (rank < n) {
            dest = (rank+1)%cnt;
            do_write(socks[dest], &data, 1);
        }
        
        /* Receive and forward messages to random destinations */
        while (1) {
            if (poll(pfds, cnt-1, -1) == -1) {
                perror("poll");    
            }
            for (i=0; i<cnt-1; i++) {
                if (pfds[i].revents != 0) {
                    do_read(pfds[i].fd, &data, 1);

                    dest = random()%cnt;
                    
                    /* Do not send to self */           
                    if (dest == rank) {
                        dest = (rank+1)%cnt;    
                    }
                    do_write(socks[dest], &data, 1);
                }
            }
        }
    }    
    return 0;
}

--Boundary-00=_YvbkCpanfoBiFUS
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="ring-inet.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ring-inet.c"

/* 
 * usage: ring-inet <# processes> <# messages>
 */

#include <asm/msr.h>

#include <stdio.h>
#include <poll.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/tcp.h>
#include <fcntl.h>
#include <netdb.h>


int do_connect(int port) {
   int n, sock, on=1;
   struct addrinfo hints, *res;
   char str[6];
   void *adr;
    
   memset(&hints, 0, sizeof(struct addrinfo));
    
   hints.ai_flags    = AI_PASSIVE;
   hints.ai_family   = PF_UNSPEC;
   hints.ai_socktype = SOCK_STREAM;

   sprintf(str, "%d", port);
   n = getaddrinfo("localhost", str, &hints, &res);

   if (n != 0) {
       fprintf(stderr,
               "getaddrinfo error: [%s]\n",
               gai_strerror(n));
       return -1;    
   }
   
   sock = socket(AF_INET, SOCK_STREAM, 0);
   if (sock == -1) {
       perror("socket");
       return -1;
   }

    
   if (setsockopt(sock, SOL_TCP, TCP_NODELAY, &on, sizeof(on)) == -1) {
       perror("setsockopt");
       return -1;
   }
   
   if (connect(sock, (struct sockaddr *)res->ai_addr, sizeof(*res->ai_addr)) == -1) {
       perror("connect");
       return -1;
   }
   
   freeaddrinfo(res);

   return sock;
}

int start_listen(int port) {
    int n, on=1;
    int sock;    
    struct sockaddr_in name;
   
        
    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock == -1) {
        perror("socket");
        return -1;
    }

    if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on)) == -1) {
        perror("setsockopt");
        return -1;
    }
        
    name.sin_family = AF_INET;
    name.sin_port = htons (port);
    name.sin_addr.s_addr = htonl (INADDR_ANY);
    
    if (bind (sock, (struct sockaddr *) &name, sizeof (name)) == -1) {
        perror("bind");
        return -1;
    }      
    
    if (listen(sock, 10) == -1) {
        perror("listen");
        return -1;
    }
    
    return sock;  
}
        
int do_accept(int lsock) {
    struct sockaddr addr;
    socklen_t len = sizeof(addr);
    int sock, on=1;


    if ((sock = accept(lsock, &addr, &len)) == -1) {
        perror("accept");
        return -1;
    }

    if (setsockopt(sock, SOL_TCP, TCP_NODELAY, &on, sizeof(on)) == -1) {
        perror("setsockopt");
        return -1;
    }
        
    return sock;
}

int do_read(int fd, void *buf, int n) {
    
    n = read(fd, buf, n);
    if (n == -1) {
        perror("read");    
    }
    return n;
}

int do_write(int fd, void *buf, int n) {
    
    n = write(fd, buf, n);
    if (n == -1) {
        perror("write");    
    }
    return n;
}


int main(int argc, char *argv[]) {
    int i, n, cnt, pid, dest;
    int lsock;
    char data, id, rank;
    int port = 11100;
    
    /* # processes */
    cnt = atoi(argv[1]);
    
    /* # messages */
    n = atoi(argv[2]);

    {
        int socks[cnt];    
        struct pollfd pfds[cnt-1];
           
        /* Create processes */
        rank = 0;
        for (i=1; i<cnt; i++) {
            pid = fork();
            if (pid == 0) {
                rank=cnt-i;
                break;    
            }
        }

        /* Setup connections */
        lsock = start_listen(port+rank);

        
        sleep(2); /* "Ensure" that all processes are listening, HACK!!! */
                
        for (i=0; i<rank; i++) {
            pfds[i].fd = do_accept(lsock);
            do_read(pfds[i].fd, &id, 1);
            do_write(pfds[i].fd, &rank, 1);

            socks[id] = pfds[i].fd;
            pfds[i].events = POLLIN;
        }
        
        for (i=rank; i<cnt-1; i++) {
            pfds[i].fd = do_connect(port+i+1);
            
            do_write(pfds[i].fd, &rank, 1);
            do_read(pfds[i].fd, &id, 1);
            
            socks[id] = pfds[i].fd;
            pfds[i].events = POLLIN;
        }
                
        srandom(rank);        
  
        /* Write startup messages */
        if (rank < n) {
            dest = (rank+1)%cnt;
            do_write(socks[dest], &data, 1);
        }
        
        /* Receive and forward messages to next in ring */
        while (1) {
            if (poll(pfds, cnt-1, -1) == -1) {
                perror("poll");    
            }
            for (i=0; i<cnt-1; i++) {
                if (pfds[i].revents != 0) {
                    do_read(pfds[i].fd, &data, 1);

                    dest = (rank+1)%cnt;
                    
                    do_write(socks[dest], &data, 1);
                }
            }
        }
    }    
    return 0;
}

--Boundary-00=_YvbkCpanfoBiFUS--
