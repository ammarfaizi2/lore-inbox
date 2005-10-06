Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVJFTzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVJFTzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVJFTzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:55:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3499 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751333AbVJFTzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:55:22 -0400
Date: Thu, 6 Oct 2005 12:54:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Robert Derr <rderr@weatherflow.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Alexander Nyberg <alexn@telia.com>
Subject: Re: 2.6.13.3 Memory leak, names_cache
In-Reply-To: <434579DD.3000104@weatherflow.com>
Message-ID: <Pine.LNX.4.64.0510061242580.31407@g5.osdl.org>
References: <43456E31.8000906@weatherflow.com> <Pine.LNX.4.64.0510061150290.31407@g5.osdl.org>
 <434579DD.3000104@weatherflow.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Oct 2005, Robert Derr wrote:
> > 
> > Just out of interest, do you have CONFIG_AUDIT_SYSCALL enabled? Does it go
> > away if you disable it?
>   
> It looks like it is enabled.  CONFIG_AUDITSYSCALL=y in .config, right?

Yes. My bad. 

That would be the prime suspect, especially as you don't seem to have any 
strange filesystems. Syscall auditing delays releasing filenames until the 
system call exits, and I wouldn't be at all surprised if it might leak.

I doubt you depend on the syscall auditing, so the easiest thing to try is 
to just disable it and see if the behaviour goes away. At that point, if 
it does, we have people we can ping to look more closely into what causes 
it.

> I'm not sure if I can find the action or behavior causing the problem.  The
> server is the master node on a 14 computer cluster running a mesoscale weather
> forecasting package so there's a million things going on all the time.  I
> guess I could write a program to compare all the processes running against the
> names_cache and look for any correlation.

Ahh, never mind. It sounds like the best thing to do is to first try the 
simple audit test, and if the problem remains, just apply one of the slab 
debugging patches.

There's one by Alexander Nyberg at least, which would probably show the 
likely leak site immediately since it tracked allocators. Alexander, do 
you have a recent version of that to send to Robert?

		Linus
