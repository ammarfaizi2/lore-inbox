Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268243AbUHKUgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268243AbUHKUgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 16:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUHKUgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 16:36:18 -0400
Received: from CS2075.cs.fsu.edu ([128.186.122.75]:18873 "EHLO mail.cs.fsu.edu")
	by vger.kernel.org with ESMTP id S268229AbUHKUdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 16:33:20 -0400
Message-ID: <1092256397.512046f64c822@system.cs.fsu.edu>
Date: Wed, 11 Aug 2004 16:33:17 -0400
From: khandelw@cs.fsu.edu
To: Alex Riesen <fork0@users.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Palmer <nick@sluggardy.net>, netdev@oss.sgi.com
Subject: Re: select implementation not POSIX compliant?
References: <20040811194018.GA3971@steel.home>
In-Reply-To: <20040811194018.GA3971@steel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 12.151.80.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

select should work for any type of socket. Its based on the type of file
descriptor not whether it is stream/dgram.

man recvmsg -

recvmsg() may be used to receive data on a socket whether it
     is in a connected state or not. s is a socket  created  with
     socket(3SOCKET).

so why should recvmsg return error???? upon closing the socket in other thread?
wouldn't the socket linger around for some time...

If no messages are available at the socket, the receive call
     waits  for  a  message  to arrive, unless the socket is non-
     blocking (see fcntl(2)) in which case -1  is  returned  with
     the external variable errno set to EWOULDBLOCK.


Quoting Alex Riesen <fork0@users.sourceforge.net>:

> On linux-kernel, Nick Palmer wrote:
> > I am working on porting some software from Solaris to Linux 2.6.7. I
> > have run into a problem with the interaction of select and/or
> > recvmsg and close in our multi-threaded application. The application
> > expects that a close call on a socket that another thread is
> > blocking in select and/or recvmsg on will cause select and/or
> > recvmsg to return with an error. Linux does not seem to do this. (I
> > also verified that the same issue exists in Linux 2.4.25, just to be
> > sure it wasn't introduced in 2.6 in case you were wondering.)
>
> It works always for stream sockets and does not at all (even with
> shutdown, even using poll(2) or read(2) instead of select) for dgram
> sockets.
>
> What domain (inet, local) are your sockets in?
> What type (stream, dgram)?
>
> There will probably be a problem anyway with changing the behaviour:
> there surely is lots of code, which start complaining about select and
> poll finishing "unexpectedly".
>
> I used this to check:
>
> #include <unistd.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/socket.h>
> #include <sys/wait.h>
> #include <netinet/in.h>
> #include <fcntl.h>
>
> int main(int argc, char* argv[])
> {
>     int status;
>     int fds[2];
>     fd_set set;
> #if 0
>     puts("stream");
>     if (  socketpair(PF_LOCAL, SOCK_STREAM, 0, fds) < 0 )
> #else
>     puts("dgram");
>     if (  socketpair(PF_LOCAL, SOCK_DGRAM, 0, fds) < 0 )
> #endif
>     {
> 	perror("socketpair");
> 	exit(1);
>     }
>     fcntl(fds[0], F_SETFL, fcntl(fds[0], F_GETFL) | O_NONBLOCK);
>     fcntl(fds[1], F_SETFL, fcntl(fds[1], F_GETFL) | O_NONBLOCK);
>     switch ( fork() )
>     {
>     case 0:
> 	sleep(1);
> 	close(fds[0]);
> 	shutdown(fds[1], SHUT_RD);
> 	close(fds[1]);
> 	exit(0);
> 	break;
>     case -1:
> 	perror("fork");
> 	exit(1);
>     }
>     close(fds[1]);
>     FD_ZERO(&set);
>     FD_SET(fds[0], &set);
>     select(fds[0] + 1, &set, NULL, NULL, 0);
>     wait(&status);
>     return 0;
> }
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


