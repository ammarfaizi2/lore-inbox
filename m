Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265253AbUGCUrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUGCUrL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 16:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUGCUrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 16:47:11 -0400
Received: from gprs214-161.eurotel.cz ([160.218.214.161]:53377 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265253AbUGCUrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 16:47:06 -0400
Date: Sat, 3 Jul 2004 22:46:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Erik Rigtorp <erik@rigtorp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/power/swsusp.c
Message-ID: <20040703204647.GE31892@elf.ucw.cz>
References: <20040703172843.GA7274@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040703172843.GA7274@linux.nu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Swsusp allocates a vt before it nows if it will need it. This interferes
> with bootsplash. Here is a patch that moves the pm_prepare_console() call
> so that its only executed if swsusp finds a valid image to resume.

You are moving it inside function that should have no business doing
this... Would something like this work better? [hand-edited, apply by
hand; untested].

BTW is bootsplash actually used by suse and/or redhat? Suse certainly
has some splashscreen... Perhaps some splash support into swsusp (as
an add on) would be good idea, but it would be good to only code it
once.
								Pavel

--- clean/kernel/power/swsusp.c	2004-06-22 12:36:47.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-07-03 22:40:47.000000000 +0200
@@ -1190,9 +1190,6 @@
 	}
 	MDELAY(1000);
 
-	if (pm_prepare_console())
-		printk("swsusp: Can't allocate a console... proceeding\n");
-
 	if (!resume_file[0] && resume_status == RESUME_SPECIFIED) {
 		printk( "suspension device unspecified\n" );
 		return -EINVAL;
@@ -1201,12 +1198,17 @@
 	printk( "resuming from %s\n", resume_file);
 	if (read_suspend_image(resume_file, 0))
 		goto read_failure;
+
+	if (pm_prepare_console())
+		printk("swsusp: Can't allocate a console... proceeding\n");
+
	device_suspend(4);
 	do_magic(1);
 	panic("This never returns");
 
 read_failure:
-	pm_restore_console();
 	return 0;
 }
 



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
