Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264618AbTI2TnV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbTI2TnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:43:21 -0400
Received: from gprs144-48.eurotel.cz ([160.218.144.48]:34947 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264618AbTI2TnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:43:17 -0400
Date: Mon, 29 Sep 2003 21:42:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] Make software resume be called at resume
Message-ID: <20030929194248.GA1815@elf.ucw.cz>
References: <20030928222404.GA227@elf.ucw.cz> <Pine.LNX.4.44.0309290955050.968-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309290955050.968-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > [Yes, software_suspend needs to return int and do some error
> > handling. But not today, and this is better than random bit flips.]
> 
> Random bit flips? I have no idea what you're talking about. 

If cpu does not support big pagetables, then, during resume,
pagetables are all around the memory and hardware is setting
"accessed" bits in them. Very bad stuff might happen.

> > --- clean/kernel/power/swsusp.c	2003-09-28 22:06:45.000000000 +0200
> > +++ linux/kernel/power/swsusp.c	2003-09-29 00:19:37.000000000 +0200
> > @@ -5,7 +5,10 @@
> >   * machine suspend feature using pretty near only high-level routines
> >   *
> >   * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
> > - * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
> > + * Copyright (C) 1998,2001-2003 Pavel Machek <pavel@suse.cz>
> > + * Copyright (C) 2003 Patrick Mochel <mochel@osdl.org>
> 
> Please remove this. I want as little correlation between my name and 
> swsusp as possible. 

There are some comments I took from your code, and you have copyright
on them. (I plan to take more of your code.) If you want me not to add
copyright notice next time I copy your code, please say so.

> >  static void do_software_suspend(void)
> >  {
> > -	arch_prepare_suspend();
> > +	if (arch_prepare_suspend())
> > +		panic("Architecture failed to prepare\n");
> 
> For crying out loud, why? WTF is wrong with:
> 
> 
> 		printk("Architecture failed to prepare\n");
> 		return;
> 
> ? Why do that to your users? 

This is changed rather easily...

								Pavel

--- clean/kernel/power/swsusp.c	2003-09-28 22:06:45.000000000 +0200
+++ linux/kernel/power/swsusp.c	2003-09-29 21:39:21.000000000 +0200
@@ -5,7 +5,9 @@
  * machine suspend feature using pretty near only high-level routines
  *
  * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
- * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 1998,2001-2003 Pavel Machek <pavel@suse.cz>
+ *
+ * This file is released under the GPLv2.
  *
  * I'd like to thank the following people for their work:
  * 
@@ -681,7 +678,10 @@
 
 static void do_software_suspend(void)
 {
-	arch_prepare_suspend();
+	if (arch_prepare_suspend()) {
+		printk("%sArchitecture failed to prepare\n", name_suspend);
+		return;
+	}		
 	if (pm_prepare_console())
 		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
 	if (!prepare_suspend_processes()) {
@@ -1031,12 +1031,18 @@
 	return error;
 }
 
-/*
- * Called from init kernel_thread.
- * We check if we have an image and if so we try to resume
+/**
+ *	software_resume - Resume from a saved image.
+ *
+ *	Called as a late_initcall (so all devices are discovered and 
+ *	initialized), we call swsusp to see if we have a saved image or not.
+ *	If so, we quiesce devices, then restore the saved image. We will 
+ *	return above (in pm_suspend_disk() ) if everything goes well. 
+ *	Otherwise, we fail gracefully and return to the normally 
+ *	scheduled program.
+ *
  */
-
-void software_resume(void)
+static void software_resume(void)
 {
 	if (num_online_cpus() > 1) {
 		printk(KERN_WARNING "Software Suspend has malfunctioning SMP support. Disabled :(\n");	
@@ -1075,6 +1081,8 @@
 	return;
 }
 
+late_initcall(software_resume);
+
 static int __init resume_setup(char *str)
 {
 	if (resume_status == NORESUME)



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
