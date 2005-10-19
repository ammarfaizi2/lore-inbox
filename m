Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVJSVDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVJSVDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 17:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVJSVDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 17:03:22 -0400
Received: from [203.171.93.254] ([203.171.93.254]:21707 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1751344AbVJSVDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 17:03:22 -0400
Subject: Re: [linux-pm] [PATCH] Threads shouldn't inherit PF_NOFREEZE
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0510181515450.4518-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0510181515450.4518-100000@iolanthe.rowland.org>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1129755676.4577.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 20 Oct 2005 07:01:17 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan.

On Wed, 2005-10-19 at 05:29, Alan Stern wrote:
> The PF_NOFREEZE process flag should not be inherited when a thread is 
> forked.  This patch (as585) removes the flag from the child.
> 
> This problem is starting to show up more and more as drivers turn to the
> kthread API instead of using kernel_thread().  As a result, their kernel
> threads are now children of the kthread worker instead of modprobe, and
> they inherit the PF_NOFREEZE flag.  This can cause problems during system
> suspend; the kernel threads are not getting frozen as they ought to be.
> 
> Alan Stern

I have this in kthread instead, so that multithreaded userspace
processes only need to have NOFREEZE set once (before forking). Yes, I
have one that fits this scenario - I'm working on a userspace storage
maanger, which will setup and tear down a network connection at
appropriate times during a suspend-to-disk cycle. The initial version is
based on nbd and uses two threads because the one that sets up storage
blocks in a syscall as Pavel & others have written it.

Anyway, I agree that the general need you're trying to address is real.

Regards,

Nigel

> 
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> What I said above may not be quite true.  For all I know, there may be
> threads which rely on inheriting PF_NOFREEZE from their parent.  But it
> should not be inherited by default.
> 
> Index: usb-2.6/kernel/fork.c
> ===================================================================
> --- usb-2.6.orig/kernel/fork.c
> +++ usb-2.6/kernel/fork.c
> @@ -848,7 +848,7 @@ static inline void copy_flags(unsigned l
>  {
>  	unsigned long new_flags = p->flags;
>  
> -	new_flags &= ~PF_SUPERPRIV;
> +	new_flags &= ~(PF_SUPERPRIV | PF_NOFREEZE);
>  	new_flags |= PF_FORKNOEXEC;
>  	if (!(clone_flags & CLONE_PTRACE))
>  		p->ptrace = 0;
> 
> 
> ______________________________________________________________________
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
-- 


