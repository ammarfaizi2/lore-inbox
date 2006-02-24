Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWBXX4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWBXX4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWBXX4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:56:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11457 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964807AbWBXX4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:56:11 -0500
Date: Sat, 25 Feb 2006 00:55:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060224235548.GB1930@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602241158.08306.rjw@sisk.pl> <20060224131206.GB1717@elf.ucw.cz> <200602242122.53763.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602242122.53763.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I did try shrink_all_memory() five times, with .5 second delay between
> > them, and it freed more memory at later tries.
> 
> I wonder if the delays are essential or if so, whether they may be shorter
> than .5 sec.

I was using this with some success... (Warning, against old
kernel). But, as I said, I consider it ugly, and it would be better to
fix shrink_all_memory.
								Pavel

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -84,20 +84,26 @@ static int in_suspend __nosavedata = 0;
 
 static void free_some_memory(void)
 {
-	unsigned int i = 0;
-	unsigned int tmp;
-	unsigned long pages = 0;
-	char *p = "-\\|/";
-
-	printk("Freeing memory...  ");
-	while ((tmp = shrink_all_memory(10000))) {
-		pages += tmp;
-		printk("\b%c", p[i++ % 4]);
+	int i;
+	for (i=0; i<5; i++) {
+		int i = 0, tmp;
+		long pages = 0;
+		char *p = "-\\|/";
+
+		printk("Freeing memory...  ");
+		while ((tmp = shrink_all_memory(10000))) {
+			pages += tmp;
+			printk("\b%c", p[i]);
+			i++;
+			if (i > 3)
+				i = 0;
+		}
+		printk("\bdone (%li pages freed)\n", pages);
+		msleep_interruptible(200);
 	}
-	printk("\bdone (%li pages freed)\n", pages);
 }
 
-
+/* FIXME: Call it when appropriate */
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
