Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSJ2AeS>; Mon, 28 Oct 2002 19:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261668AbSJ2AeS>; Mon, 28 Oct 2002 19:34:18 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:39080 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261689AbSJ2AeO>;
	Mon, 28 Oct 2002 19:34:14 -0500
Date: Tue, 29 Oct 2002 01:40:34 +0100
From: bert hubert <ahu@ds9a.nl>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021029004034.GA32118@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	lse-tech@lists.sourceforge.net
References: <20021029001843.GB31212@outpost.ds9a.nl> <Pine.LNX.4.44.0210281631040.966-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210281631040.966-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 04:32:50PM -0800, Davide Libenzi wrote:

> The code above it's just fine. The "fd" is not lost because the falling
> through :
> 
> do_use_fd(fd);
> 
> will make good use of it.

If that code dares to read immediatly from the fd without having an explicit
POLLIN event, which also means that epoll can only be used in this fashion
with nonblocking sockets. 

The listening socket needs to do that anyhow as the connection may have
vanished anyhow - select has that problem too.

To trigger the problem, see the following very nasty 'exploit'. Telnet to
port 10000 and immediately enter a line of text and press enter. This line
might very well be 'GET / HTTP/1.0'. 

Because of the inserted sleep(2); below, this line will never be reported
by sys_epoll_wait() in its current form. To see it appear, enter an
additional line after a while.

So either fix up sys_epoll_ctl() to insert an edge if there is data at
insertion time (which needs some locking probably to get it right), OR
document the interface that it should only be used with non-blocking sockets
and that the caller should immediately try to read after the initial
sys_epoll_ctl insert call. This last solution sounds very bad and confusing.

Code:

#include <stdio.h>
#include <errno.h>
#include <asm/page.h> 
#include <asm/poll.h> 
#include <linux/linkage.h>
#include <linux/eventpoll.h>
#include <linux/unistd.h>
#include <netinet/in.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>

#define __sys_epoll_create(maxfds) _syscall1(int, sys_epoll_create, int, maxfds)
#define __sys_epoll_ctl(epfd, op, fd, events) _syscall4(int, sys_epoll_ctl, \
int, epfd, int, op, int, fd, unsigned int, events)

#define __sys_epoll_wait(epfd, events, timeout) _syscall3(int, sys_epoll_wait, \
int, epfd, struct pollfd const **, events, int, timeout)

__sys_epoll_create(maxfds)
__sys_epoll_ctl(epfd, op, fd, events)
__sys_epoll_wait(epfd, events, timeout)

// asmlinkage int sys_epoll_wait(int epfd, struct pollfd const **events, int timeout);

int main()
{
	int kdpfd;
	struct pollfd const *pfds;
	int nfds;
	int timeout=2;
	struct sockaddr_in local;
	socklen_t addrlen;
	int s, client;
	int n;
	char line[80];
	int ret;

	if ((kdpfd = sys_epoll_create(10)) < 0) {
        	perror("sys_epoll_create");
                return -1;
        }

	s=socket(AF_INET,SOCK_STREAM,0); 

	memset(&local,0,sizeof(local));
        local.sin_family=AF_INET;
	local.sin_addr.s_addr = INADDR_ANY;
	
	int tmp=1;
	if(setsockopt(s,SOL_SOCKET,SO_REUSEADDR,(char*)&tmp,sizeof tmp)<0) {
	  perror("setsockopt");
	  return 0;
	}
	
	local.sin_port=htons(10000);
	
	if(bind(s, (struct sockaddr*)&local,sizeof(local))<0) {
	  perror("bind");
	  return 0;
	}
	
	if(listen(s,128)<0) {
	  perror("listen");
	  return 0;
	}

        if (sys_epoll_ctl(kdpfd, EP_CTL_ADD, s, POLLIN ) < 0) {
		fprintf(stderr, "sys_epoll set insertion error: fd=%d\n", s);

		return -1;
	}                           
	addrlen=sizeof(local);


	for(;;) {
	  nfds = sys_epoll_wait(kdpfd, &pfds, -1);	
	  fprintf(stderr,"sys_epoll_wait returned: %d\n",nfds);
	  
	  for(n=0;n<nfds;++n) {
	    if(pfds[n].fd==s) {
	      client=accept(s, (struct sockaddr*)&local, &addrlen);
	      sleep(2);      
	      if(client<0){
		perror("accept");
		continue;
	      }
	      if (sys_epoll_ctl(kdpfd, EP_CTL_ADD, client, POLLIN ) < 0) {
		fprintf(stderr, "sys_epoll set insertion error: fd=%d\n", client);
		return -1;
	      }                                        
	    }
	    else {
	      if((ret=read(pfds[n].fd,line,79))>0)
		printf("read from fd %d: '%.*s'\n", pfds[n].fd, ret>2 ? ret-2 : 0,line);
	    }
	  }

	  

	}
	return 0;
}



> 
> 
> 
> - Davide
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
