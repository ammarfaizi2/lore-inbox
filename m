Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275526AbRJAUx3>; Mon, 1 Oct 2001 16:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275529AbRJAUxU>; Mon, 1 Oct 2001 16:53:20 -0400
Received: from [194.213.32.141] ([194.213.32.141]:2308 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S275526AbRJAUxE>;
	Mon, 1 Oct 2001 16:53:04 -0400
Message-ID: <20010930212331.A301@bug.ucw.cz>
Date: Sun, 30 Sep 2001 21:23:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>
Cc: seasons@falcon.sch.bme.hu, Swsusp mailing list <swsusp@lister.fornax.hu>
Subject: swsusp: fix realtime processes, work around random memory corruption with DMA, do not trigger oom-killer
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Yep, it fixes all of above.

Most "interesting" is stuff that prevents usb controller from
scribling over memory. cli() and msleep(1000) should do the trick ;-).

Also you can now trigger it by echo 4 > /proc/acpi/sleep. Usefull for
testing.

							Pavel
PS: (Patch is relative to my 2.4.10 port, which I mailed just about
everywhere.)



--- /elf/big/2.4.10-swsusp.2/drivers/acpi/ospm/system/sm_osl.c	Sun Sep 23 23:05:21 2001
+++ linux-swsusp/drivers/acpi/ospm/system/sm_osl.c	Sun Sep 30 12:04:00 2001
@@ -140,7 +140,10 @@
 	if (system->states[value] != TRUE)
 		return -EINVAL;
 	
-	sm_osl_suspend(value);
+	if (value != ACPI_S4)
+		sm_osl_suspend(value);
+	else
+		software_suspend();
 	
 	return (count);
 }
@@ -685,6 +688,9 @@
 	 */
 	if (state == ACPI_S2 || state == ACPI_S3) {
 #ifdef DONT_USE_UNTIL_LOWLEVEL_CODE_EXISTS
+		/* That && trick is *not going to work*. Read gcc
+		   specs. That explicitely says: jumping from other
+		   function is *not allowed*. */ 
 		wakeup_address = acpi_save_state_mem((unsigned long)&&acpi_sleep_done);
 
 		if (!wakeup_address) goto acpi_sleep_done;
@@ -692,11 +698,12 @@
 		acpi_set_firmware_waking_vector(
 			(ACPI_PHYSICAL_ADDRESS)wakeup_address);
 #endif
-	} else if (state == ACPI_S4)
+	} else if (state == ACPI_S4) {
 #ifdef DONT_USE_UNTIL_LOWLEVEL_CODE_EXISTS
 		if (acpi_save_state_disk((unsigned long)&&acpi_sleep_done)) 
-			goto acpi_sleep_done;
+			goto acpi_sleep_done
 #endif
+	}
 
 	/* set status, since acpi_enter_sleep_state won't return unless something
 	 * goes wrong, or it's just S1.
diff -urN -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak /elf/big/2.4.10-swsusp.2/kernel/swsusp.c linux-swsusp/kernel/swsusp.c
--- /elf/big/2.4.10-swsusp.2/kernel/swsusp.c	Sat Sep 29 10:34:23 2001
+++ linux-swsusp/kernel/swsusp.c	Sun Sep 30 21:04:02 2001
@@ -222,6 +222,12 @@
 /* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(void)
 {
+#define CORRECT
+	/* You need correct to work with real-time processes.
+	   OTOH, this way one process may see (via /proc/) some other
+	   process in stopped state (and thereby discovered we were
+	   suspended. We probably do not care. 
+	 */
 #ifdef CORRECT
 	long save;
 	save = current->state;
@@ -708,7 +714,7 @@
 	void **c= eaten_memory, *m;
 
 	printk("Eating pages ");
-	while ((m = (void *) get_free_page(GFP_HIGHMEM))) {
+	while ((m = (void *) get_free_page(GFP_HIGHUSER))) {
 		memset(m, 0, PAGE_SIZE);
 		eaten_memory = m;
 		if (!(i%5000))
@@ -749,6 +755,10 @@
 	pages = shrink_mem();
 	PRINTS( "Freed pages: %u\n", pages );
 #endif
+#if 1
+	eat_memory();
+	free_memory();
+#endif
 	/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway.
 	 *
 	 * We sync here -- so you have consistent filesystem state when things go wrong.
@@ -942,8 +952,13 @@
 #ifdef CONFIG_SMP_DISABLED
 	prepare_suspend_smp ();
 #endif
-	eat_memory();
-	free_memory();
+
+#if 0
+	printk("Freeing memory: ");
+	while (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
+		printk(".");
+	printk("\n");
+#endif
 
 	spin_lock(&suspend_lock);
 	PRINTP( "Test local var: %08lx\n", local_var);
@@ -977,6 +992,11 @@
 	/* Critical section here: noone should touch memory from now */
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 
+	printk( "Waiting for disks to settle down...\n");
+	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
+			   Do it with disabled interrupts for best effect. That way, if some
+			   driver scheduled DMA, we have good chance for DMA to finish ;-). */
+
 	/* This works, because loop and loop2 are nosavedata */
 	for (loop=0; loop < nr_copy_pages; loop++) {
 		/* You may not call something (like copy_page) here:
@@ -1399,8 +1419,6 @@
 	error = 0;
 
 resume_read_error:
-	printk("Error resuming\n");
-	mdelay(1000);
 	switch (error) {
 		case 0:
 			PRINTR("Reading resume file was successful\n");
@@ -1416,9 +1434,9 @@
 		default:
 			printk( "%sError %d resuming\n", name_resume, error );
 	}
+	mdelay(1000);
 	set_fs(orig_fs);
-	set_blocksize(dev, blksize);	/* FIXME: There's something very strange: even after successfull resume,
-					   old blocksize seems to be set. Ouch?! */
+	set_blocksize(dev, blksize);
 	MDELAY(1000);
 	if (different_kernel)
 		panic("Sorry Pavel... I like my filesystem too much.");

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
