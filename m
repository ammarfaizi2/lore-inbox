Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293544AbSCGHeR>; Thu, 7 Mar 2002 02:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293546AbSCGHeH>; Thu, 7 Mar 2002 02:34:07 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:33029 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293541AbSCGHdt>; Thu, 7 Mar 2002 02:33:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] TRIVIAL II: 2.5.6-pre3. misc_register/request_region
Date: Thu, 07 Mar 2002 18:37:07 +1100
Message-Id: <E16isSZ-0006ad-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply: these are the small subset which were obviously correct.

Evgeniy Polyakov <johnpol@2ka.mipt.ru>:
	Patches check return values for request_region() and misc_register().
	This patches make janitorial project TODO list a bit smaller.

Thanks,
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre3/arch/mips64/sgi-ip27/ip27-rtc.c trivial-2.5.6-pre3/arch/mips64/sgi-ip27/ip27-rtc.c
--- linux-2.5.6-pre3/arch/mips64/sgi-ip27/ip27-rtc.c	Wed Feb 20 17:55:07 2002
+++ trivial-2.5.6-pre3/arch/mips64/sgi-ip27/ip27-rtc.c	Thu Mar  7 18:20:32 2002
@@ -201,7 +201,8 @@
 	    KL_CONFIG_CH_CONS_INFO(nid)->memory_base + IOC3_BYTEBUS_DEV0;
 
 	printk(KERN_INFO "Real Time Clock Driver v%s\n", RTC_VERSION);
-	misc_register(&rtc_dev);
+	if (misc_register(&rtc_dev))
+		return -ENODEV;
 	create_proc_read_entry ("rtc", 0, NULL, rtc_read_proc, NULL);
 
 	save_flags(flags);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre3/arch/ppc/iSeries/rtc.c trivial-2.5.6-pre3/arch/ppc/iSeries/rtc.c
--- linux-2.5.6-pre3/arch/ppc/iSeries/rtc.c	Wed Feb 20 17:57:03 2002
+++ trivial-2.5.6-pre3/arch/ppc/iSeries/rtc.c	Thu Mar  7 18:20:32 2002
@@ -192,7 +192,8 @@
 
 static int __init rtc_init(void)
 {
-	misc_register(&rtc_dev);
+	if (misc_register(&rtc_dev))
+		return -ENODEV;
 	create_proc_read_entry ("driver/rtc", 0, 0, rtc_read_proc, NULL);
 
 	printk(KERN_INFO "iSeries Real Time Clock Driver v" RTC_VERSION "\n");
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre3/drivers/acorn/char/mouse_ps2.c trivial-2.5.6-pre3/drivers/acorn/char/mouse_ps2.c
--- linux-2.5.6-pre3/drivers/acorn/char/mouse_ps2.c	Thu Mar  7 15:13:39 2002
+++ trivial-2.5.6-pre3/drivers/acorn/char/mouse_ps2.c	Thu Mar  7 18:20:32 2002
@@ -271,7 +271,8 @@
 	iomd_writeb(0, IOMD_MSECTL);
 	iomd_writeb(8, IOMD_MSECTL);
   
-	misc_register(&psaux_mouse);
+	if (misc_register(&psaux_mouse))
+		return -ENODEV;
 	queue = (struct aux_queue *) kmalloc(sizeof(*queue), GFP_KERNEL);
 	memset(queue, 0, sizeof(*queue));
 	queue->head = queue->tail = 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre3/drivers/acorn/scsi/ecoscsi.c trivial-2.5.6-pre3/drivers/acorn/scsi/ecoscsi.c
--- linux-2.5.6-pre3/drivers/acorn/scsi/ecoscsi.c	Wed Feb 20 17:55:23 2002
+++ trivial-2.5.6-pre3/drivers/acorn/scsi/ecoscsi.c	Thu Mar  7 18:20:32 2002
@@ -125,7 +125,11 @@
     }
 
     NCR5380_init(instance, 0);
-    request_region (instance->io_port, instance->n_io_port, "ecoscsi");
+    if (request_region (instance->io_port, instance->n_io_port, "ecoscsi") == NULL)
+    	{
+	scsi_unregister(instance);
+	return 0;
+	}
 
     if (instance->irq != IRQ_NONE)
 	if (request_irq(instance->irq, do_ecoscsi_intr, SA_INTERRUPT, "ecoscsi", NULL)) {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre3/drivers/char/acquirewdt.c trivial-2.5.6-pre3/drivers/char/acquirewdt.c
--- linux-2.5.6-pre3/drivers/char/acquirewdt.c	Wed Feb 20 17:55:23 2002
+++ trivial-2.5.6-pre3/drivers/char/acquirewdt.c	Thu Mar  7 18:20:32 2002
@@ -207,7 +207,8 @@
 	printk("WDT driver for Acquire single board computer initialising.\n");
 
 	spin_lock_init(&acq_lock);
-	misc_register(&acq_miscdev);
+	if (misc_register(&acq_miscdev))
+		return -ENODEV;
 	request_region(WDT_STOP, 1, "Acquire WDT");
 	request_region(WDT_START, 1, "Acquire WDT");
 	register_reboot_notifier(&acq_notifier);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre3/drivers/isdn/act2000/act2000_isa.c trivial-2.5.6-pre3/drivers/isdn/act2000/act2000_isa.c
--- linux-2.5.6-pre3/drivers/isdn/act2000/act2000_isa.c	Mon Oct  1 05:26:05 2001
+++ trivial-2.5.6-pre3/drivers/isdn/act2000/act2000_isa.c	Thu Mar  7 18:20:33 2002
@@ -178,7 +178,8 @@
                 card->flags &= ~ACT2000_FLAGS_PVALID;
         }
         if (!check_region(portbase, ISA_REGION)) {
-                request_region(portbase, ACT2000_PORTLEN, card->regname);
+                if (request_region(portbase, ACT2000_PORTLEN, card->regname) == NULL)
+			return -EIO;
                 card->port = portbase;
                 card->flags |= ACT2000_FLAGS_PVALID;
                 return 0;
	

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
