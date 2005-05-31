Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVEaQuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVEaQuq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVEaQuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:50:11 -0400
Received: from berlioz.imada.sdu.dk ([130.225.128.12]:31911 "EHLO
	berlioz.imada.sdu.dk") by vger.kernel.org with ESMTP
	id S261945AbVEaQSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:18:42 -0400
From: Hans Henrik Happe <hhh@imada.sdu.dk>
To: Avi Kivity <avi@argo.co.il>
Subject: Re: Issues with INET sockets through loopback (lo)
Date: Tue, 31 May 2005 18:18:44 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200505231317.44716.hhh@imada.sdu.dk> <1116937382.1848.9.camel@blast.qumranet.com>
In-Reply-To: <1116937382.1848.9.camel@blast.qumranet.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_k5InCbUf8hpnGu2"
Message-Id: <200505311818.44938.hhh@imada.sdu.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_k5InCbUf8hpnGu2
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 24 May 2005 14:23, Avi Kivity wrote:
> On Mon, 2005-05-23 at 13:17 +0200, Hans Henrik Happe wrote:
> 
> > I hope that others can comfirm that this is an issue or otherwise explain 
> > why it is supposed behave this way.
> > 
> 
> you might try using udp instead of tcp. this would help determine
> whether the problem is in the tcp stack or the loopback interface.

Now I have tried with SCTP and it works great (no idle CPU time).
So my guess is still that there is a problem in TCP.

I have attached the SCTP program. It's my first attempt at using SCTP, so it's 
not beautiful. The messages get around as expected though.

TripleH ;-)

--Boundary-00=_k5InCbUf8hpnGu2
Content-Type: text/x-csrc;
  charset="utf-8";
  name="random-sctp.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="random-sctp.c"

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

#include <netinet/sctp.h>

typedef struct {
    struct sockaddr sockadr;
    int len;    
} adr_t;

int get_adr(adr_t *adr, int port) {
   int n;
   struct addrinfo hints, *res;
   char str[6];
    
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
   
   memcpy(&adr->sockadr, res->ai_addr, sizeof(*res->ai_addr));
   adr->len = sizeof(*res->ai_addr);
      
   freeaddrinfo(res);

   return 0;
}

int init_listen(int port) {
    int n, on=1;
    int sock;    
    struct sockaddr_in name;
   
        
    sock = socket(PF_INET, SOCK_SEQPACKET, IPPROTO_SCTP);
    if (sock == -1) {
        perror("socket");
        return -1;
    }
    
    name.sin_family = PF_INET;
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

int do_recv(int sock, void *buf, int n) {
    struct sockaddr sa;
    struct sctp_sndrcvinfo info;
    int slen, flags;
    slen = sizeof(sa);
    
    n = sctp_recvmsg(sock, buf, n, &sa, &slen, &info, &flags);
//    n = sctp_recvmsg(sock, buf, n, &sa, &slen, &info, &flags);
    if (n == -1) {
        perror("recv");    
    }
    return n;
}

int do_send(int sock, adr_t *adr, void *buf, int n) {
    
    n = sctp_sendmsg(sock, buf, n, &adr->sockadr, adr->len, 666, MSG_ADDR_OVER, 0, 0, 444);
    if (n == -1) {
        perror("send");    
    }
    return n;
}


int main(int argc, char *argv[]) {
    int i, n, cnt, pid, dest;
    int lsock;
    char data, id, rank;
    int port = 11100;
    uint64_t t0, t1;
        
    /* # processes */
    cnt = atoi(argv[1]);
    
    /* # messages */
    n = atoi(argv[2]);

    {
        adr_t dests[cnt];
           
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
        lsock = init_listen(port+rank);

        
        sleep(2); /* "Ensure" that all processes are listening, HACK!!! */
                
        
        for (i=0; i<cnt; i++) {
            get_adr(dests+i, port+i);
        }
                
        srandom(rank);        
        /* Write startup messages */
        if (rank < n) {
            do_send(lsock, &dests[(rank+1)%cnt], &data, 1);
        }
        
        sleep(1);
        
        /* Receive and forward messages to random destinations */
        while (1) {
            do_recv(lsock, &data, 1);

            dest = random()%cnt;
                    
            /* Do not send to self */           
            if (dest == rank) {
                dest = (dest+1)%cnt;    
            }
            
            do_send(lsock, &dests[dest], &data, 1);
        }
    }    
    return 0;
}

--Boundary-00=_k5InCbUf8hpnGu2--
