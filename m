Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268304AbUJJNt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268304AbUJJNt1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 09:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268300AbUJJNt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 09:49:27 -0400
Received: from gprs214-186.eurotel.cz ([160.218.214.186]:60544 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268306AbUJJNtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 09:49:11 -0400
Date: Sun, 10 Oct 2004 15:48:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>,
       agruen@suse.de
Subject: Re: swsusp: 8-order memory allocations problem (was: Re: Fix random crashes in x86-64 swsusp)
Message-ID: <20041010134846.GD19831@elf.ucw.cz>
References: <200410052314.25253.rjw@sisk.pl> <200410062346.29489.rjw@sisk.pl> <20041006220600.GB25059@elf.ucw.cz> <200410082259.43627.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410082259.43627.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > fix_processor_context was calling functions marked __init on x86-64;
> > bad idea. Maybe we should memset freed memory to zero so such bugs are
> > prevented?
> > 
> > Thanks to Rafael for keeping notifying me about this bug, and someone
> > get me yet another brown paper bag.
> > 
> > Anyway, this should fix it, please apply,
> [-- snip --]
> 
> The patch apparently fixes the problem that I have reported, so thanks a lot, 
> Pavel.  After it's been fixed, however, I often get things like that:
> 
> PM: snapshotting memory.
> swsusp: critical section:
> ..<7>[nosave pfn 
> 0x58b]...........................................................................
> ............................................swsusp: Need to copy 31927 pages
> suspend: (pages needed: 31927 + 512 free: 98952)
> hibernate.sh: page allocation failure. order:8, mode:0x120
> Oct  8 14:15:57 albercik kernel:
> Call Trace:<ffffffff8016eb2d>{__alloc_pages+749} 
> <ffffffff8016ebd1>{__get_free_pages+33}
>        <ffffffff80161a23>{suspend_prepare_image+531} 
> <ffffffff8026d7a7>{pci_device_suspend+71}
>        <ffffffff80161cb6>{swsusp_swap_check+22} 
> <ffffffff802ea112>{suspend_device+50}
>        <ffffffff80120d0c>{swsusp_arch_suspend+124} 
> <ffffffff801610cc>{swsusp_suspend+12}
>        <ffffffff8016222a>{pm_suspend_disk+90} 
> <ffffffff8015fe04>{enter_state+68}
>        <ffffffff802adc0d>{acpi_system_write_sleep+100} 
> <ffffffff80193914>{vfs_write+228}
>        <ffffffff80193a53>{sys_write+83} <ffffffff80110c72>{system_call+126}
> Oct  8 14:16:05 albercik kernel:
> suspend: Allocating pagedir failed.
> 
> It's sort of strange, because there were 250 meg of RAM available, out of 500, 
> at that time.

Well, you have 250MB free, but apparently not enough contignuous free pages...

You may try this one, it may reduce probability of this kind of
failure...

							Pavel

--- clean/kernel/power/disk.c	2004-10-01 00:30:32.000000000 +0200
+++ linux/kernel/power/disk.c	2004-10-02 19:43:06.000000000 +0200
@@ -85,13 +89,26 @@
 
 static void free_some_memory(void)
 {
-	printk("Freeing memory: ");
-	while (shrink_all_memory(10000))
-		printk(".");
-	printk("|\n");
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
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(HZ/5);
+	}
 }
 
-
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
