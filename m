Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVCaW2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVCaW2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVCaW0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:26:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25570 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262039AbVCaWZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:25:51 -0500
Date: Fri, 1 Apr 2005 00:25:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benoit Boissinot <bboissin@gmail.com>
Cc: romano@dea.icai.upco.es, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: noresume breaks next suspend [was Re: 2.6.12-rc1 swsusp broken]
Message-ID: <20050331222531.GE1802@elf.ucw.cz>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <20050329132022.GA26553@pern.dea.icai.upco.es> <20050329170238.GA8077@pern.dea.icai.upco.es> <20050329181551.GA8125@elf.ucw.cz> <20050331144728.GA21883@pern.dea.icai.upco.es> <d120d5000503310715cbc917@mail.gmail.com> <20050331165007.GA29674@pern.dea.icai.upco.es> <40f323d005033110292934aa1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f323d005033110292934aa1d@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes! With this it works ok.
> > 
> > > Also, could you please try sticking psmouse_reset(psmouse) call at the
> > > beginning of drivers/input/mouse/alps.c::alps_reconnect() and see if
> > > it can suspend _without_ the patch above.
> >
> 
> Both patches are working for me (Dell D600). before i was unable to
> suspend to disk on this laptop (it was stuck in alps code).
> 
> By the way, i have an unrelated problem:
> if the kernel was booted with the "noresume" option, it cannot be
> suspended, it fails with:
> 
> swsusp: FATAL: cannot find swap device, try swapon -a!

Uh, okay, logic error, probably introduced by resume-from-initrd
patch. Does this fix it?

OTOH, perhaps refusing suspend is right thing to do. If user is
running in "safe mode" (with noresume), we don't want him to be able
to suspend...
								Pavel

--- clean/kernel/power/swsusp.c	2005-03-19 00:32:32.000000000 +0100
+++ linux/kernel/power/swsusp.c	2005-04-01 00:23:15.000000000 +0200
@@ -1376,16 +1371,6 @@
 {
 	int error;
 
-	if (!swsusp_resume_device) {
-		if (!strlen(resume_file))
-			return -ENOENT;
-		swsusp_resume_device = name_to_dev_t(resume_file);
-		pr_debug("swsusp: Resume From Partition %s\n", resume_file);
-	} else {
-		pr_debug("swsusp: Resume From Partition %d:%d\n",
-			 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
-	}
-
 	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
--- clean/kernel/power/disk.c	2005-03-19 00:32:32.000000000 +0100
+++ linux/kernel/power/disk.c	2005-04-01 00:23:09.000000000 +0200
@@ -233,6 +237,16 @@
 {
 	int error;
 
+	if (!swsusp_resume_device) {
+		if (!strlen(resume_file))
+			return -ENOENT;
+		swsusp_resume_device = name_to_dev_t(resume_file);
+		pr_debug("swsusp: Resume From Partition %s\n", resume_file);
+	} else {
+		pr_debug("swsusp: Resume From Partition %d:%d\n",
+			 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
+	}
+
 	if (noresume) {
 		/**
 		 * FIXME: If noresume is specified, we need to find the partition


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
