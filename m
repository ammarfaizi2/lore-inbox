Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316693AbSFJGPo>; Mon, 10 Jun 2002 02:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSFJGPn>; Mon, 10 Jun 2002 02:15:43 -0400
Received: from david.siemens.de ([192.35.17.14]:28637 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S316693AbSFJGPl>;
	Mon, 10 Jun 2002 02:15:41 -0400
Message-ID: <6134254DE87BD411908B00A0C99B044F038E6C3C@mowd019a.mow.siemens.ru>
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'cohen@rafb.net'" <cohen@rafb.net>,
        "'davids@webmaster.com'" <davids@webmaster.com>
Subject: Re: kernel 2.4.18 - select() returning strange value
Date: Mon, 10 Jun 2002 10:22:34 +0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I am replying off web archive; please Cc any response to me. Thank you]

So I am not the only one who noticed it. Good.

On Fri, 7 Jun 2002 13:09:05 -0700, Jacob Cohen wrote: 

>>Summary: when calling select() on a set of file descriptors containing 
>>only the descriptor of a non-connected stream socket, select() returns 
>>1 and marks the FD set as if data were waiting on the socket. 


>This seems correct to me. A read or write will not block and there is 
>nothing to wait for. 

Unfortunately, _any_ attempt to read or write on socket in this state is
meaningless and undefined (see below). For this reason return value of
select is misleading and wrong.


>>According to what I've read in the man pages for select() and 
>>socket(), a nonconnected socket should be unreadable, and therefore 
>>select() should timeout and return 0. I cannot figure out why it is 
>>returning 1. 

>Because the socket is ready for read.

No. It is not. That's the whole point.

> If a read were attempted immediately, 
> it would not block. If a read would result in an error other than 
> 'EWOULDBLOCK', the socket is ready to be read. 

Currently 'read' does not result in any error. That is exactly the problem.
It is not only 'select' that is misbehaving but 'read' as well. 


>>Has something changed in the kernel or the way the select() syscall 
>>behaves on a nonconnected socket that I should be aware of? I cannot 
>>find anything relevant in the recent change logs, but I am probably 
>>missing something. 

> I'm guessing the previous erroneous behavior was fixed.
> When you 'select' on an unconnected socket, what do you expect 
> 'select' to wait for? 


Nobody expects 'select' to wait. As said above 'select should timeout and
return nothing to read/write'.

The problem stems from the fact that Linux does not make distinction between
'not yet connected' and 'already closed' states.

What you say is true and correct for 'already closed' state. In this case
select _must_ return 'ready to read' at least once so that application can
properly sense EOF condition. What happens on subsequent select's/read's is
strictly speaking implementation defined (access to a file after EOF has
been seen is undefined) but natural implementation is "sticky EOF" that
always returns EOF after socket has been closed.

For 'not yet connected' socket situation is different. The problem is not
would operation block or not - the problem is 'read' in this case returns
EOF thus effectively telling application "you must not touch this file any
more" and preventing further access to socket. 

Here is test program from dante SOCKS server configure and output on Linux
and another Unix for comparison. Note that this test program signals error
on Linux ...

========================
/*
 * ftp.inet.no:/pub/home/michaels/stuff/unconnectedsocket-select.c
 * $ cc unconnectedsocket-select.c && uname -a && ./a.out
 * Modified by Eric Anderson <anderse@hpl.hp.com>
 */

#include <sys/types.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>

static int
selectcheck(int s);

int
main(void)
{
        char foo[5];
        int s, p;
        struct sigaction act;
        int res;

        act.sa_handler = SIG_IGN;
        sigaction(SIGPIPE,&act,NULL);
        fprintf(stderr, "testing with a normal, unconnected socket:\n");
        if ((s = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
                perror("socket()");
                exit(1);
        }
        fprintf(stderr, "  created socket, select() returned %d\n",
               selectcheck(s));
        p = read(s, NULL, 0);
        fprintf(stderr, "  read() returned %d, errno = %d (%s)\n", p, errno,
(strerror(errno)));
        p = write(s, foo, 5);
        fprintf(stderr, "  write() returned %d, errno = %d (%s)\n", p,
errno, (strerror(errno)));

        fprintf(stderr, "testing with a non-blocking, unconnected
socket:\n");
        if ((s = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
                perror("socket()");
                exit(1);
        }
        if ((p = fcntl(s, F_GETFL, 0)) == -1
            || fcntl(s, F_SETFL, p | O_NONBLOCK) == -1) {
                perror("fcntl()");
                exit(1);
        }
        res = selectcheck(s);
        fprintf(stderr, "  socket nonblocking, select() returned %d\n",
res);

        p = read(s, NULL, 0);
        fprintf(stderr, "  read() returned %d, errno = %d (%s)\n", p, errno,
(strerror(errno)));
        p = write(s, &foo, 5);
        fprintf(stderr, "  write() returned %d, errno = %d (%s)\n", p,
errno, (strerror(errno)));

        if (res == 0)
                return 0; /* correct behaviour */
        else
                return 1; /* incorrect behaviour */
}

static int 
selectcheck(s)
        int s;
{
        fd_set rset, wset, xset;
        struct timeval timeout;
        int ret,i;

        FD_ZERO(&rset);
        FD_SET(s, &rset);
        wset = xset = rset;

        timeout.tv_sec  = 0;
        timeout.tv_usec         = 0;

        errno = 0;
        ret = select(s + 1, &rset, &wset, &xset, &timeout);
        if (FD_ISSET(s,&rset)) {
            fprintf(stderr, "  socket is readable\n");
        }
        if (FD_ISSET(s,&wset)) {
            fprintf(stderr, "  socket is writeable\n");
        }
        if (FD_ISSET(s,&xset)) {
            fprintf(stderr, "  socket has an exception\n");
        }
        return ret;
}
====================

Linux runs:

bor@cooker% ./a.out
testing with a normal, unconnected socket:
  socket is readable
  socket is writeable
  created socket, select() returned 2
  read() returned 0, errno = 0 (Success)
  write() returned -1, errno = 32 (Broken pipe)
testing with a non-blocking, unconnected socket:
  socket is readable
  socket is writeable
  socket nonblocking, select() returned 2
  read() returned 0, errno = 0 (Success)
  write() returned -1, errno = 32 (Broken pipe)

"Other UNIX" runs:

bor@itsrm2% /tmp/a.out
testing with a normal, unconnected socket:
  created socket, select() returned 0
  read() returned -1, errno = 134 (Transport endpoint is not connected)
  write() returned -1, errno = 134 (Transport endpoint is not connected)
testing with a non-blocking, unconnected socket:
  socket nonblocking, select() returned 0
  read() returned -1, errno = 134 (Transport endpoint is not connected)
  write() returned -1, errno = 134 (Transport endpoint is not connected)

-andrej
