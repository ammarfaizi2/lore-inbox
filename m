Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265848AbUATWxm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265854AbUATWxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:53:41 -0500
Received: from gprs214-112.eurotel.cz ([160.218.214.112]:56963 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265848AbUATWwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:52:32 -0500
Date: Tue, 20 Jan 2004 23:52:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: More cleanups for swsusp
Message-ID: <20040120225219.GA19190@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes codingstyle a bit, converts "can not happen" panic into
BUG_ON (fill_suspend_header() allocates no memory so panic is
meaningless) and adds check for sizeof (struct link) [if that is not
PAGE_SIZE, we have *bad* problem, better check early]. Please apply,

								Pavel

Index: linux/kernel/power/swsusp.c
===================================================================
--- linux.orig/kernel/power/swsusp.c	2004-01-13 22:52:40.000000000 +0100
+++ linux/kernel/power/swsusp.c	2004-01-09 20:33:05.000000000 +0100
@@ -340,14 +344,14 @@
 	printk("H");
 	BUG_ON (sizeof(struct suspend_header) > PAGE_SIZE-sizeof(swp_entry_t));
 	BUG_ON (sizeof(union diskpage) != PAGE_SIZE);
+	BUG_ON (sizeof(struct link) != PAGE_SIZE);
 	if (!(entry = get_swap_page()).val)
 		panic( "\nNot enough swapspace when writing header" );
 	if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
 		panic("\nNot enough swapspace for header on suspend device" );
 
 	cur = (void *) buffer;
-	if (fill_suspend_header(&cur->sh))
-		panic("\nOut of memory while writing header");
+	BUG_ON (fill_suspend_header(&cur->sh));
 		
 	cur->link.next = prev;
 
@@ -856,23 +837,23 @@
 
 static int sanity_check_failed(char *reason)
 {
-	printk(KERN_ERR "%s%s\n",name_resume,reason);
+	printk(KERN_ERR "%s%s\n", name_resume, reason);
 	return -EPERM;
 }
 
 static int sanity_check(struct suspend_header *sh)
 {
-	if(sh->version_code != LINUX_VERSION_CODE)
+	if (sh->version_code != LINUX_VERSION_CODE)
 		return sanity_check_failed("Incorrect kernel version");
-	if(sh->num_physpages != num_physpages)
+	if (sh->num_physpages != num_physpages)
 		return sanity_check_failed("Incorrect memory size");
-	if(strncmp(sh->machine, system_utsname.machine, 8))
+	if (strncmp(sh->machine, system_utsname.machine, 8))
 		return sanity_check_failed("Incorrect machine type");
-	if(strncmp(sh->version, system_utsname.version, 20))
+	if (strncmp(sh->version, system_utsname.version, 20))
 		return sanity_check_failed("Incorrect version");
-	if(sh->num_cpus != num_online_cpus())
+	if (sh->num_cpus != num_online_cpus())
 		return sanity_check_failed("Incorrect number of cpus");
-	if(sh->page_size != PAGE_SIZE)
+	if (sh->page_size != PAGE_SIZE)
 		return sanity_check_failed("Incorrect PAGE_SIZE");
 	return 0;
 }

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
