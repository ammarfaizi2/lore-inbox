Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264188AbUEDBUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbUEDBUy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 21:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbUEDBUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 21:20:54 -0400
Received: from firewall.conet.cz ([213.175.54.250]:44972 "EHLO conet.cz")
	by vger.kernel.org with ESMTP id S264188AbUEDBUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 21:20:33 -0400
Date: Tue, 4 May 2004 03:19:57 +0200
From: Libor Vanek <libor@conet.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Read from file fails
Message-ID: <20040504011957.GA20676@Loki>
References: <20040503000004.GA26707@Loki> <Pine.LNX.4.53.0405030852220.10896@chaos> <20040503150606.GB6411@Loki> <Pine.LNX.4.53.0405032020320.12217@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0405032020320.12217@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The cludges that work involve creating a "kernel thread" which
> > > has a process context. That thread does the file I/O. However,
> > > it's certainly easier to create a user-mode task (program) that
> > > opens your module and, using an ioctl(), sends it anything from
> > > anywhere in the known universe. You can get data from a file or
> > > from anywhere.
> >
> > OK - so speaking of kernel thread - what function should I use?
> > Or do you think that only the difference of having process context
> > and  pid will cause read to work? (I'm willing to believe it ;-) -
> > I'll try it later)
> >
> 
> Search existing drivers for "kernel_thread"
> 		.../linux/drivers/net/8139too.c is a start.
> 
> And yes, kernel threads work. Pay particular attention to the
> way to run one down before you remove your module. They can
> do everything user-mode code can do and have the priviliges to
> totally screw up anything and everything in the kernel.

I know that kernel threads work. My question was more like: "I'd like to know, whether writing my module as kernel thread will make it able to read/write files".

> > I think there are reasons (speed, speed, speed...)  why some things
> 
> Wrong. The kernel was designed to perform services on behalf of
> a user-mode task. That's how it will function the fastest. There is
> no "speed advantage" to kernel mode, only the lack of memory
> and instruction protection. None of these kernel mode instructions
> have anything to do with speed (except the ability to STOP everything)
> with cli;hlt. Then you have no speed at all.

>From what I know about kernel (which doesn't say I'm correct!) is:
Using kernel module:
- user space process wants to change some file which is in "snapshoted" dir
- my module catches this request, holds it, creates copy of original file and allows original request to proceed

Using user-space approach  my kernel module must call my user space program which causes context switching (which I think is quite expensive and should be avoid). It surely won't matter on some desktop machine but when you need to do snapshots you need it to do it on large file-server with 10s/100s of active users.

Another counter-example I think is LUFS (Linux Userspace FS) - at least last time I've heard about it it was too slow for serious usage.

> > should be done kernel-space. And I think that this is one of them.
> > I know that I'll never want to "send data from anywhere in the known
> > universe" (famous last words?) - I just need to create backup copy of
> > file.
> >
> >
> > Libor
> 
> Common problem when persons first see the kernel code. They say;
> "Oh it's just 'C'! I can write this. I know 'C'! Next thing you

I HATE C - can't a man write a kernel module in PHP please? ;-)

> know, they are trying to read/write files inside the kernel.
> Before you write kernel code, you need to understand what the
> kernel DOES.  Bottom line, it does the stuff that user-mode

Is there any other way how to undestand what kernel DOES except starting hacking it and asking stupid questions like "how can I read file"? :-) I've read 10s papers about kernel design in general and comparison between Linux/Windows NT/HURD/... kernels and taken 2 semesters of "Operating systems" so I got some rought idea how kernel works - now I'm confrontating my idea with reality.

> code isn't allowed to do on its own. For instance, user mode
> code can't be allowed to read/write files on its own because
> (1) it doesn't know how to do it, and (2) it could screw up
> the entire file-system either accidentally or on purpose.
> Therefore the  kernel does it for the user task, but on behalf of the
> user.

There something surely true in your approach. But this approach leads to micro-kernel solutions - "let's make kernel only as small as possible and all else be user-space". Where is line between "too overloaded" and "too small" let's Linus decide ;-)

-- 
Libor
