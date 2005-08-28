Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVH1Uv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVH1Uv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 16:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVH1Uv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 16:51:57 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:5511 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750732AbVH1Uv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 16:51:57 -0400
Message-ID: <431223DB.1070708@gmail.com>
Date: Sun, 28 Aug 2005 22:51:39 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Micheal Marineau <marineam@engr.orst.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radeonfb acpi vgapost
References: <4310408A.6010701@engr.orst.edu>
In-Reply-To: <4310408A.6010701@engr.orst.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micheal Marineau napsal(a):

>Here is a cleaned up version of the patch to repost radeon cards when
>resuming from acpi s3 suspend.  I've been sitting on it for a while
>hoping that I might be able to gain some insight in how to use the d2
>state instead of this repost as ppc does.  On my x86 laptop with a
>radeon 9000 resuming from d2 does manage to turn on the card/display,
>but it becomes horridly scrambled. But right now I don't have the time
>or the skill to actually get any futher than that.
>
>And btw, posting the card still causes the system to wait for a key
>press.  I don't know if that is solvable with the current post method.
>Getting the existing d2 suspend/resume stuff to work might be the only
>way to clear that up.
>  
>
>------------------------------------------------------------------------
>
>Index: linux-2.6.13-rc3/arch/i386/kernel/acpi/sleep.c
>===================================================================
>--- linux-2.6.13-rc3.orig/arch/i386/kernel/acpi/sleep.c	2005-07-12 21:46:46.000000000 -0700
>+++ linux-2.6.13-rc3/arch/i386/kernel/acpi/sleep.c	2005-07-29 19:03:56.000000000 -0700
>@@ -5,6 +5,7 @@
>  *  Copyright (C) 2001-2003 Pavel Machek <pavel@suse.cz>
>  */
> 
>+#include <linux/module.h>
> #include <linux/acpi.h>
> #include <linux/bootmem.h>
> #include <linux/dmi.h>
>@@ -56,6 +57,34 @@
> 	zap_low_mappings();
> }
> 
>+/*
>+ * acpi_vgapost
>+ */
>+
>+extern void do_vgapost_lowlevel (unsigned long);
>  
>
the comment is for acpi_vgapost, not for some extern somewhat, maybe...

>+
>+void acpi_vgapost (unsigned long slot)
>+{
>+	unsigned long flags, saved_video_flags = acpi_video_flags;
>+	
>+	acpi_video_flags = (slot & 0xffff) << 16 | 1;
>+	
>+	/* Map low memory and copy information */
>+	init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
>+	memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end - &wakeup_start);
>  
>
80 chars on line max, please.

>+	acpi_copy_wakeup_routine(acpi_wakeup_address);
>+	
>+	/* Tunnel thru real mode */
>+	local_irq_save(flags);
>+	do_vgapost_lowlevel(acpi_wakeup_address);
>+	local_irq_restore(flags);
>+	
>  
>
[snip]

> 
> static void radeon_set_suspend(struct radeonfb_info *rinfo, int suspend)
> {
> 	u16 pwr_cmd;
>@@ -2657,6 +2666,8 @@
> 		 */
> 		else if (rinfo->pm_mode & radeon_pm_d2)
> 			radeon_set_suspend(rinfo, 0);
>+		if (rinfo->pm_mode & radeon_pm_post && rinfo->reinit_func != NULL)
>  
>
80 too

>+			rinfo->reinit_func(rinfo);
> 
> 		rinfo->asleep = 0;
> 	} else
>@@ -2777,6 +2788,13 @@
> #endif
> 	}
> #endif /* defined(CONFIG_PM) && defined(CONFIG_PPC_OF) */
>  
>
[snip]

It looks good, otherwise.

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

