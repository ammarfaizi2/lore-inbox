Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbTLaTIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 14:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbTLaTIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 14:08:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:37342 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265244AbTLaTIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 14:08:32 -0500
Date: Wed, 31 Dec 2003 11:08:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       manfred@colorfullife.com, rusty@au1.ibm.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: BUG in x86 do_page_fault?  [was Re: in_atomic doesn't count
 local_irq_disable?]
In-Reply-To: <20031231185959.A9041@in.ibm.com>
Message-ID: <Pine.LNX.4.58.0312311104180.2065@home.osdl.org>
References: <3FF044A2.3050503@colorfullife.com> <20031230185615.A9292@in.ibm.com>
 <20031231185959.A9041@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Dec 2003, Srivatsa Vaddagiri wrote:
>
> 	in_atomic() doesn't seem to return true
> in code sections where IRQ's have been disabled (using 
> local_irq_disable).
> 
> As a result, I think do_page_fault() on x86 needs to 
> be updated to note this fact:

NO. 

Please don't do this, it will result in some _really_ nasty problems with 
X and other programs that potentially disable interrupts in user space.

Also, there are broken old drivers that potentially have interrupts 
disabled, and we shouldn't just oops them. We should have a warning, but 
we already do have that: that's what "might_sleep()" does.

So something like this may be appropriate at some point, but not in this 
format. At the very least you absolutely _have_ to check for user mode 
(possibly in the same place where we now have that

	/* It's safe to allow irq's after cr2 has been saved */

comment).

		Lnus

> --- fault.c.org Wed Dec 31 18:34:18 2003
> +++ fault.c     Wed Dec 31 18:35:02 2003
> @@ -259,7 +259,7 @@
>          * If we're in an interrupt, have no user context or are running in an
>          * atomic region then we must not take the fault..
>          */
> -       if (in_atomic() || !mm)
> +       if (in_atomic() || irqs_disabled() || !mm)
>                 goto bad_area_nosemaphore;
> 
>         down_read(&mm->mmap_sem);
