Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTELUFc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 16:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbTELUFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 16:05:32 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:48351 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262303AbTELUF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 16:05:28 -0400
Date: Mon, 12 May 2003 22:15:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] restore sysenter MSRs at resume
Message-ID: <20030512201549.GA4848@elf.ucw.cz>
References: <1052687076.30359.2.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0305111706370.22268-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305111706370.22268-100000@home.transmeta.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Some laptops also lose all the AGP settings in the chipset.
> 
> Well, that's definitely a driver issue, and should be handled that way. I
> suspect even the MTRR's should be handled as a driver, since unlike things
> like the SYSENTER things, it really _is_ a driver already and is
> conditional on kernel configuration etc.

Here's a patch, it simply adds mtrrs into as "sys" device...

Please apply,
								Pavel

Index: linux/arch/i386/kernel/cpu/mtrr/main.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/mtrr/main.c	2003-01-05 22:58:19.000000000 +0100
+++ linux/arch/i386/kernel/cpu/mtrr/main.c	2003-05-12 22:06:05.000000000 +0200
@@ -2,6 +2,7 @@
 
     Copyright (C) 1997-2000  Richard Gooch
     Copyright (c) 2002	     Patrick Mochel
+    Copyright (c) 2003	     Nigel Cunningham & Pavel Machek 
 
     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Library General Public
@@ -35,6 +36,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/smp.h>
+#include <linux/suspend.h>
 
 #include <asm/mtrr.h>
 
@@ -644,6 +646,104 @@
     "write-protect",            /* 5 */
     "write-back",               /* 6 */
 };
+ 
+#ifdef CONFIG_PM
+struct mtrr_suspend_state
+{
+     mtrr_type ltype;
+     unsigned long lbase;
+     unsigned int lsize;
+};
+
+/* We return a pointer ptr on an area of *ptr bytes
+   beginning at ptr+sizeof(int)
+   This buffer has to be saved in some way during suspension */
+static int *mtrr_save_state(void)
+{
+     int i, len;
+     int *ptr = NULL;
+     static struct mtrr_suspend_state *mtrr_suspend_buffer=NULL;
+     
+     if(!mtrr_suspend_buffer)
+     {
+	  len = num_var_ranges * sizeof (struct mtrr_suspend_state) + sizeof(int);
+	  ptr = kmalloc (len, GFP_KERNEL);
+	  if (ptr == NULL)
+	       return(NULL);
+	  *ptr = len;
+	  ptr++;
+	  mtrr_suspend_buffer = (struct mtrr_suspend_state *)ptr;
+	  ptr--;
+     }
+     for (i = 0; i < num_var_ranges; ++i,mtrr_suspend_buffer++)
+	  mtrr_if->get (i,
+		       &(mtrr_suspend_buffer->lbase),
+		       &(mtrr_suspend_buffer->lsize),
+		       &(mtrr_suspend_buffer->ltype));
+     return(ptr);
+}
+
+/* We restore mtrrs from buffer ptr */
+static void mtrr_restore_state(int *ptr)
+{
+     int i, len;
+     struct mtrr_suspend_state *mtrr_suspend_buffer;
+     
+     len = num_var_ranges * sizeof (struct mtrr_suspend_state) + sizeof(int);
+     if(*ptr != len)
+     {
+	  printk ("mtrr: Resuming failed due to different number of MTRRs\n");
+	  return;
+     }
+     ptr++;
+     mtrr_suspend_buffer=(struct mtrr_suspend_state *)ptr;
+     for (i = 0; i < num_var_ranges; ++i,mtrr_suspend_buffer++)     
+	  if (mtrr_suspend_buffer->lsize)	  
+	       set_mtrr(i,
+			mtrr_suspend_buffer->lbase,
+			mtrr_suspend_buffer->lsize,
+			mtrr_suspend_buffer->ltype);
+}
+
+static void *mtrr_state;
+
+static int mtrr_suspend(struct device *dev, u32 state, u32 level)
+{
+	if (level == SUSPEND_SAVE_STATE)
+		mtrr_state = mtrr_save_state();
+	return 0;
+}
+
+static int mtrr_resume(struct device *dev, u32 level)
+{
+	if (level == RESUME_POWER_ON)
+		mtrr_restore_state(mtrr_state);
+	return 0;
+}
+
+static struct device_driver mtrr_driver = {
+	.name		= "mtrr",
+	.bus		= &system_bus_type,
+	.suspend	= mtrr_suspend,
+	.resume		= mtrr_resume,
+};
+
+static struct sys_device device_mtrr = {
+	.name		= "mtrr",
+	.id		= 0,
+	.dev		= {
+		.name	= "mtrr",
+		.driver	= &mtrr_driver,
+	},
+};
 
+static int __init init_mtrr_devicefs(void)
+{
+	driver_register(&mtrr_driver);
+	return sys_device_register(&device_mtrr);
+}
+
+device_initcall(init_mtrr_devicefs);
+#endif
 core_initcall(mtrr_init);
 
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
