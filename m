Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWEJTtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWEJTtk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 15:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWEJTtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 15:49:40 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:17882 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751250AbWEJTtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 15:49:39 -0400
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0605101506540.22959@gandalf.stny.rr.com>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
	 <1147257266.17886.3.camel@localhost.localdomain>
	 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <1147273787.17886.46.camel@localhost.localdomain>
	 <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com>
	 <20060510162404.GR3570@stusta.de>
	 <Pine.LNX.4.58.0605101506540.22959@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 12:49:37 -0700
Message-Id: <1147290577.21536.151.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's no code increase when you init something to itself . I could
convert all the instance of the warning, that I've investigated, to a
system like this . I think it would be a benefit so we could clearly
identify any new warnings added over time, and quiet the ones we know
aren't real errors .

However, from all the responses I'd imagine a patch like this wouldn't
get accepted ..

Daniel

On Wed, 2006-05-10 at 15:20 -0400, Steven Rostedt wrote:
> Someone emailed me the bug report for gcc:
> 
>  http://gcc.gnu.org/bugzilla/show_bug.cgi?id=5035
> 
> 
> And in this, it showed the trick to initialize self to turn off that
> warning.
> 
> Would it be OK to define a macro like:
> 
> #ifdef CONFIG_SHOW_ALL_UNINIT_WARNINGS
> #  define init_self(x) x
> #else
> #  define init_self(x) x = x
> #endif
> 
> Such that we can at least look at the places of bogus uninitialized
> warnings and do something like:
> 
> Index: ipc/sem.c
> ===================================================================
> --- ipc/sem.c   (revision 796)
> +++ ipc/sem.c   (working copy)
> @@ -809,7 +809,7 @@
>  {
>         struct sem_array *sma;
>         int err;
> -       struct sem_setbuf setbuf;
> +       struct sem_setbuf init_self(setbuf);
>         struct kern_ipc_perm *ipcp;
> 
>         if(cmd == IPC_SET) {
> 
> 
> Seems to work.  And if you want to make sure that a place doesn't need it
> anymore, use -Winit-self and have a script to do a full make once with
> CONFIG_SHOW_ALL_UNINIT_WARNINGS and once with -Winit-self, and make sure
> that all the -Winit-self warnings are in the
> CONFIG_SHOW_ALL_UNINIT_WARNINGS. Otherwise the init_self isn't needed
> anymore.
> 
> -- Steve
> 
> 

