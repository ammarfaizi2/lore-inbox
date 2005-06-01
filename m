Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVFAJdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVFAJdr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVFAJdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:33:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15236 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261351AbVFAJcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:32:10 -0400
Date: Wed, 1 Jun 2005 11:27:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't explode on swsusp failure to find swap
Message-ID: <20050601092742.GC6693@elf.ucw.cz>
References: <1117523585.5826.18.camel@gaston> <20050531103623.GB1848@elf.ucw.cz> <1117550706.5826.43.camel@gaston> <1117583403.5826.72.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117583403.5826.72.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > If we specify a swap device for swsusp using resume= kernel argument and
> > > > that device doesn't exist in the swap list, we end up calling
> > > > swsusp_free() before we have allocated pagedir_save. That causes us to
> > > > explode when trying to free it.
> > > > 
> > > > Pavel, does that look right ?
> > > 
> > > It looks like a workaround. We should not call swsusp_free in case
> > > device does not exists. Quick look did not reveal where the bug comes
> > > from, can you try to trace it?
> > > 								Pavel
> > 
> > Well, the bug comes from arch code calling swsusp_save() which fails,
> > then we call swsusp_free()
> 
> More specifically, arch suspend calls swsusp_save().
> 
> It fails and returns the error to the arch asm code, which itself
> returns it to it's caller swsusp_suspend(), which does that:
> 
>  	if ((error = swsusp_arch_suspend()))
> 		swsusp_free();

Ugh, swsusp_free should be totally unneccessary at this point; only
error returns are from the time before anything is allocated.

Does something like this help?

diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -975,13 +975,6 @@ extern asmlinkage int swsusp_arch_resume
 
 asmlinkage int swsusp_save(void)
 {
-	int error = 0;
-
-	if ((error = swsusp_swap_check())) {
-		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
-				"swapon -a!\n");
-		return error;
-	}
 	return suspend_prepare_image();
 }
 
@@ -999,12 +992,19 @@ int swsusp_suspend(void)
 	 */
 	if ((error = device_power_down(PMSG_FREEZE))) {
 		local_irq_enable();
-		swsusp_free();
 		return error;
 	}
+
+	if ((error = swsusp_swap_check())) {
+		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
+				"swapon -a!\n");
+		local_irq_enable();
+		return error;
+	}
+
 	save_processor_state();
 	if ((error = swsusp_arch_suspend()))
-		swsusp_free();
+		printk("Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
