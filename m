Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbSLCBgt>; Mon, 2 Dec 2002 20:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbSLCBgt>; Mon, 2 Dec 2002 20:36:49 -0500
Received: from tantale.fifi.org ([216.27.190.146]:52366 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S265886AbSLCBgs>;
	Mon, 2 Dec 2002 20:36:48 -0500
To: Ivan Pulleyn <ivan@sixfold.com>
Cc: <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: Wierd listen/connect: accept queue never fills up
References: <Pine.LNX.4.33.0211272112200.25730-100000@localhost.localdomain>
From: Philippe Troin <phil@fifi.org>
Date: 02 Dec 2002 17:44:13 -0800
In-Reply-To: <Pine.LNX.4.33.0211272112200.25730-100000@localhost.localdomain>
Message-ID: <874r9vc1w2.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Pulleyn <ivan@sixfold.com> writes:

> What was the sysctl value for net.ipv4.tcp_syn_max_backlog set to
> while running this test? That's the value you are testing, not the
> listen() queue size.

The value of net.ipv4.tcp_syn_max_backlog does not matter. Even if I
set it to zero, I can create several hundred of connections without
accept()'ing any. And netstat show them all in the CONNECTED state.

That looks bad to me.

Phil.

> On 27 Nov 2002, Philippe Troin wrote:
> 
> > [Andi, I've CC'ed you since you're listed as the author of the `new
> > listen' code in net/ipv4/tcp_ipv4.c]
> > 
> > Seen on linux 2.4.20rc2.
> > 
> > This program is always able to establish new connections to itself:
> > the accept queue never fills up and connections always succeed
> > (although they take quite some time after the first four):
> > 
> >   #include <stdio.h>
> >   #include <sys/types.h>
> >   #include <sys/socket.h>
> >   #include <netinet/in.h>
> > 
> >   int main(void)
> >   {
> >     int fd;
> >     struct sockaddr_in sin;
> >     socklen_t sinlen;
> > 
> >     if ((fd = socket(PF_INET, SOCK_STREAM, 0)) == -1)
> >       perror("socket"), exit(1);
> > 
> >     sin.sin_family      = AF_INET;
> >     sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> >     sin.sin_port	      = htons(0);
> >     if (bind(fd, (struct sockaddr*)&sin, sizeof(sin)) == -1)
> >       perror("bind"), exit(1);
> >     if (listen(fd, 1) == -1)
> >       perror("listen"), exit(1);
> > 
> >     sinlen = sizeof(sin);
> >     getsockname(fd, (struct sockaddr*)&sin, &sinlen);
> > 
> >     while (1)
> >       {
> >         int fdc;
> > 
> >         if ((fdc = socket(PF_INET, SOCK_STREAM, 0)) == -1)
> >   	perror("socket"), exit(1);
> >         printf("%c", connect(fdc, (struct sockaddr*)&sin, sinlen) == -1
> >   	     ? 'F' : '.');
> >         fflush(stdout);
> >       }
> > 
> >     exit(0);
> >   }
> > 
> > I've tried enabling and disabling tcp_syncookies, without any effect.
> > 
> > The same program starts returning errors after two successful connects
> > on Solaris and one on HP-UX. Linux keeps returning new connections...
> > 
> > Phil.
