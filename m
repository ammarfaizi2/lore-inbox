Return-Path: <linux-kernel-owner+w=401wt.eu-S965122AbXAJW22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbXAJW22 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbXAJW22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:28:28 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:43939 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965122AbXAJW21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:28:27 -0500
Date: Wed, 10 Jan 2007 23:28:20 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@zeniv.linux.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] mm: pagefault_{disable,enable}()
In-Reply-To: <Pine.LNX.4.64.0701101413130.3594@woody.osdl.org>
Message-ID: <Pine.LNX.4.62.0701102324460.3855@pademelon.sonytel.be>
References: <200612071659.kB7GxGHa030259@hera.kernel.org>
 <Pine.LNX.4.64.0701102256410.4331@anakin> <Pine.LNX.4.64.0701101413130.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2007, Linus Torvalds wrote:
> On Wed, 10 Jan 2007, Geert Uytterhoeven wrote:
> > This change causes lots of compile errors of the following form on m68k:
> > 
> > | linux-2.6.20-rc4/include/linux/uaccess.h: In function `pagefault_disable':
> > | linux-2.6.20-rc4/include/linux/uaccess.h:18: error: dereferencing pointer to incomplete type
> > | linux-2.6.20-rc4/include/linux/uaccess.h: In function `pagefault_enable':
> > | linux-2.6.20-rc4/include/linux/uaccess.h:33: error: dereferencing pointer to incomplete type
> 
> Ouch. However, I think your patch is bogus.
> 
> You're fixing somethign that doesn't need fixing: <linux/uaccess.h> 
> already includes <linux/preempt.h> for the preemption functions.

Indeed.

> The REAL problem seems to be that the m68k preempt.h (or rather, to be 
> exact, asm/thread_info.h) doesn't do things right, and while it exposes 
> "inc_preempt_count()", it doesn't expose enough information to actually 
> use it.
> 
> I think your "current_thread_info()" is broken.

But struct task_struct is defined in <linux/sched.h>, which cannot be included
in <asm/thread_info.h> due to include recursion hell.

The alternative is to move struct task_struct to its own file, which may be a
bit too intrusive for 2.6.20.

So I'm afraid my patch is the least intrusive solution. Or am I missing
something?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
