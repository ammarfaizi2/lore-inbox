Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268256AbUHKV5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268256AbUHKV5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268257AbUHKV5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:57:52 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:24558 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S268256AbUHKV5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:57:35 -0400
Subject: Re: select implementation not POSIX compliant?
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Alex Riesen <fork0@users.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Palmer <nick@sluggardy.net>, netdev@oss.sgi.com
In-Reply-To: <20040811194018.GA3971@steel.home>
References: <20040811194018.GA3971@steel.home>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1092261449.4717.65.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 11 Aug 2004 14:57:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You will find poll works as you desire but select does not.  I recommend
porting to poll anyway; select sucks bad.  You might even try out epoll
in 2.6.

Thanks
Good luck

On Wed, 2004-08-11 at 12:40, Alex Riesen wrote:
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

