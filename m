Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTJAVwk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbTJAVwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:52:40 -0400
Received: from gprs150-56.eurotel.cz ([160.218.150.56]:21889 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262223AbTJAVwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:52:34 -0400
Date: Wed, 1 Oct 2003 23:51:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] Some typos
Message-ID: <20031001215110.GA5289@elf.ucw.cz>
References: <Pine.LNX.4.44.0310011217380.23925-100000@cherise> <Pine.LNX.4.44.0310011236130.23925-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310011236130.23925-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'll fix my scripts.
> > > Did you apply this and "add initcall" patches?
> > 
> > Yes.
> 
> Though, it produces a warning on compile: 
> 
> kernel/power/swsusp.c:1089: warning: initialization from incompatible pointer type
> 
> ..which is because software_resume() returns void. Could you please fix 
> this? 

Yep. (Cc-ed to list in case I made some stupid mistake). Also added
check: buffer allocation might fail. Please apply,
								Pavel

--- tmp/linux/kernel/power/swsusp.c	2003-10-01 23:24:42.000000000 +0200
+++ linux/kernel/power/swsusp.c	2003-10-01 23:18:27.000000000 +0200
@@ -283,6 +283,9 @@
 	unsigned long address;
 	struct page *page;
 
+	if (!buffer)
+		return -ENOMEM;
+
 	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
 	for (i=0; i<nr_copy_pages; i++) {
 		if (!(i%100))
@@ -1046,23 +1051,23 @@
  *	scheduled program.
  *
  */
-static void __init software_resume(void)
+static int __init software_resume(void)
 {
 	if (num_online_cpus() > 1) {
 		printk(KERN_WARNING "Software Suspend has malfunctioning SMP support. Disabled :(\n");	
-		return;
+		return -EINVAL;
 	}
 	/* We enable the possibility of machine suspend */
 	software_suspend_enabled = 1;
 	if (!resume_status)
-		return;
+		return 0;
 
 	printk( "%s", name_resume );
 	if (resume_status == NORESUME) {
 		if(resume_file[0])
 			read_suspend_image(resume_file, 1);
 		printk( "disabled\n" );
-		return;
+		return 0;
 	}
 	MDELAY(1000);
 
@@ -1071,7 +1076,7 @@
 
 	if (!resume_file[0] && resume_status == RESUME_SPECIFIED) {
 		printk( "suspension device unspecified\n" );
-		return;
+		return -EINVAL;
 	}
 
 	printk( "resuming from %s\n", resume_file);
@@ -1082,7 +1087,7 @@
 
 read_failure:
 	pm_restore_console();
-	return;
+	return 0;
 }
 
 late_initcall(software_resume);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
