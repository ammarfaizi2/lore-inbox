Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131237AbRCNCAY>; Tue, 13 Mar 2001 21:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131262AbRCNCAP>; Tue, 13 Mar 2001 21:00:15 -0500
Received: from web11808.mail.yahoo.com ([216.136.172.162]:6661 "HELO
	web11808.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131237AbRCNCAC>; Tue, 13 Mar 2001 21:00:02 -0500
Message-ID: <20010314015921.19287.qmail@web11808.mail.yahoo.com>
Date: Tue, 13 Mar 2001 17:59:21 -0800 (PST)
From: Jeffrey Butler <jeffreymbutler@yahoo.com>
Subject: poll() behaves differently in Linux 2.4.1 vs. Linux 2.2.14 (POLLHUP)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I've noticed that poll() calls on IPv4 sockets do
not behave the same under linux 2.4 vs. linux 2.2.14. 
Linux 2.4 will return POLLHUP for a socket that is not
connected (and has never been connected) while Linux
2.2 will not.
  The following example program demonstrates the
problem when it's run under linux 2.4:

---
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/poll.h>

int main(
  int argc,
  char **argv) 
{
  int s;
  int rv;
  struct pollfd pfd;
  
  s = socket(PF_INET,SOCK_STREAM,0);
  pfd.fd = s;
  pfd.events = 0;
  rv = poll(&pfd,1,1);
  printf("rv = %d
",rv);
  if(pfd.revents&POLLIN) {printf("pollin
");}
  if(pfd.revents&POLLPRI){printf("pollpri
");}
  if(pfd.revents&POLLOUT){printf("pollout
");}
  if(pfd.revents&POLLERR){printf("pollerr
");}
  if(pfd.revents&POLLHUP){printf("pollhup
");}
  close(s);
}

(copy text to file, run 'gcc -o example example.c', to
compile)

Under Linux 2.4 (specifically 2.4.1) this program will
output:
rv = 0
pollhup

Under Linux 2.2.14 it outputs:
rv = 0

Other operating systems (not that they are necessarily
correct) also output the same as Linux 2.2.14.  I
tried this on FreeBSD 4.4.1, Solaris 5.7 (on a SPARC),
and Windows 2000 with Cygwin 1.1.7.

I'm not sure what POSIX says about this behavior...

This can be traced back to the poll implementation in
the Linux kernel:

In 2.2.14:
net/ipv4/tcp.c[line 580]:
	if (sk->shutdown & RCV_SHUTDOWN)
		mask |= POLLHUP;

vs.
In 2.4.1:
net/ipv4/tcp.c[line 586]:
	 * NOTE. Check for TCP_CLOSE is added. The goal is to
prevent
	 * blocking on fresh not-connected or disconnected
socket. --ANK
	 */
	if (sk->shutdown == SHUTDOWN_MASK || sk->state ==
TCP_CLOSE)
		mask |= POLLHUP;

The behavior observed at user-level matches his
comment as POLLHUP is returned for a fresh
not-connected socket.

What's the reasoning for this change in behavior?  I
know of ways of getting around it, but I wanted to
bring this to everyone's attention.

thanks,
-jeff



__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices.
http://auctions.yahoo.com/
