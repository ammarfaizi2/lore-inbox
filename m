Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267888AbTCBKOK>; Sun, 2 Mar 2003 05:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267890AbTCBKOK>; Sun, 2 Mar 2003 05:14:10 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:48851 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267888AbTCBKOG>;
	Sun, 2 Mar 2003 05:14:06 -0500
Message-ID: <3E61DBAB.1040206@colorfullife.com>
Date: Sun, 02 Mar 2003 11:23:39 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Subject: Re: 2.5.63: 'Debug: sleeping function called from illegal context
Content-Type: multipart/mixed;
 boundary="------------020907010807080802040101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020907010807080802040101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan wrote:

>On Sat, 2003-03-01 at 21:05, Dr. David Alan Gilbert wrote:
>> Hi,
>>   2.5.63 had a good go at trying to boot for me; the only error during
>> boot was 'Debug: sleeping function called from illegal context at
>> mm/slab.c:1617' during the IDE startup.
>
>Known problem. Its a bug in the request_irq code on x86. IDE just
>happens to be a victim of it.
>  
>
I would call it an IDE bug: request_irq is not atomic, there are dozends 
of kmalloc(GFP_KERNEL) calls in the implementation.
And on some archs it might be impossible to implement it without 
sleeping - e.g. on a NUMA arch an IPI to the right node could be necessary.
What about fixing ide? If ide can't handle early interrupts, then it can use

    disable_irq();
    request_irq();
    spin_lock_irq(&ide_lock);
    do_setup();
    spin_unlock_irq(&ide_lock);
    enable_irq();

I've attached a proposal - what do you think?
--
    Manfred

--------------020907010807080802040101
Content-Type: text/plain;
 name="patch-ide"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ide"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 63
//  EXTRAVERSION =
--- 2.5/include/linux/ide.h	2003-02-26 19:08:43.000000000 +0100
+++ build-2.5/include/linux/ide.h	2003-03-02 10:51:19.000000000 +0100
@@ -1730,6 +1730,19 @@
 extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
 
 extern spinlock_t ide_lock;
+extern struct semaphore ide_cfg_sem;
+/*
+ * Structure locking:
+ *
+ * ide_cfg_sem and ide_lock together protect changes to
+ * ide_hwif_t->{next,hwgroup}
+ * ide_drive_t->next
+ *
+ * ide_hwgroup_t->busy: ide_lock
+ * ide_hwgroup_t->hwif: ide_lock
+ * ide_hwif_t->mate: constant, no locking
+ * ide_drive_t->hwif: constant, no locking
+ */
 
 #define local_irq_set(flags)	do { local_save_flags((flags)); local_irq_enable(); } while (0)
 
--- 2.5/drivers/ide/ide-probe.c	2003-02-26 19:08:29.000000000 +0100
+++ build-2.5/drivers/ide/ide-probe.c	2003-03-02 11:15:40.000000000 +0100
@@ -1032,16 +1032,17 @@
  */
 static int init_irq (ide_hwif_t *hwif)
 {
-	unsigned long flags;
 	unsigned int index;
+	int do_enable_irq;
 	ide_hwgroup_t *hwgroup, *new_hwgroup;
 	ide_hwif_t *match = NULL;
 
 	/* Allocate the buffer and potentially sleep first */
 	new_hwgroup = kmalloc(sizeof(ide_hwgroup_t),GFP_KERNEL);
-	
-	spin_lock_irqsave(&ide_lock, flags);
 
+	BUG_ON(in_interrupt());
+	BUG_ON(irqs_disabled());	
+	down(&ide_cfg_sem);
 	hwif->hwgroup = NULL;
 #if MAX_HWIFS > 1
 	/*
@@ -1078,7 +1079,7 @@
 	} else {
 		hwgroup = new_hwgroup;
 		if (!hwgroup) {
-			spin_unlock_irqrestore(&ide_lock, flags);
+			up(&ide_cfg_sem);
 			return 1;
 		}
 		memset(hwgroup, 0, sizeof(ide_hwgroup_t));
@@ -1095,6 +1096,7 @@
 	/*
 	 * Allocate the irq, if not already obtained for another hwif
 	 */
+	do_enable_irq = 0;
 	if (!match || match->irq != hwif->irq) {
 		int sa = SA_INTERRUPT;
 #if defined(__mc68000__) || defined(CONFIG_APUS)
@@ -1112,17 +1114,23 @@
 			/* clear nIEN */
 			hwif->OUTB(0x08, hwif->io_ports[IDE_CONTROL_OFFSET]);
 
+		disable_irq(hwif->irq);
 		if (request_irq(hwif->irq,&ide_intr,sa,hwif->name,hwgroup)) {
 			if (!match)
 				kfree(hwgroup);
-			spin_unlock_irqrestore(&ide_lock, flags);
+			enable_irq(&hwif->irq);
+			up(&ide_cfg_sem);
 			return 1;
 		}
+		do_enable_irq = 1;
 	}
 
 	/*
 	 * Everything is okay, so link us into the hwgroup
 	 */
+	spin_lock_irq(&ide_lock);
+	if(do_enable_irq)
+		enable_irq(hwif->irq);
 	hwif->hwgroup = hwgroup;
 	hwif->next = hwgroup->hwif->next;
 	hwgroup->hwif->next = hwif;
@@ -1135,9 +1143,9 @@
 			hwgroup->drive = drive;
 		drive->next = hwgroup->drive->next;
 		hwgroup->drive->next = drive;
-		spin_unlock_irqrestore(&ide_lock, flags);
+		spin_unlock_irq(&ide_lock);
 		ide_init_queue(drive);
-		spin_lock_irqsave(&ide_lock, flags);
+		spin_lock_irq(&ide_lock);
 	}
 
 	if (!hwgroup->hwif) {
@@ -1148,7 +1156,7 @@
 	}
 
 	/* all CPUs; safe now that hwif->hwgroup is set up */
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irq(&ide_lock);
 
 #if !defined(__mc68000__) && !defined(CONFIG_APUS) && !defined(__sparc__)
 	printk("%s at 0x%03lx-0x%03lx,0x%03lx on irq %d", hwif->name,
@@ -1168,6 +1176,7 @@
 		printk(" (%sed with %s)",
 			hwif->sharing_irq ? "shar" : "serializ", match->name);
 	printk("\n");
+	up(&ide_cfg_sem);
 	return 0;
 }
 
--- 2.5/drivers/ide/ide.c	2003-02-26 19:08:29.000000000 +0100
+++ build-2.5/drivers/ide/ide.c	2003-03-02 11:04:16.000000000 +0100
@@ -177,6 +177,7 @@
 static int system_bus_speed;	/* holds what we think is VESA/PCI bus speed */
 static int initializing;	/* set while initializing built-in drivers */
 
+DECLARE_MUTEX(ide_cfg_sem);
 spinlock_t ide_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 static int ide_scan_direction; /* THIS was formerly 2.2.x pci=reverse */
@@ -584,13 +585,15 @@
 	ide_hwif_t *hwif, *g;
 	ide_hwgroup_t *hwgroup;
 	int irq_count = 0, unit, i;
-	unsigned long flags;
 	ide_hwif_t old_hwif;
 
 	if (index >= MAX_HWIFS)
 		BUG();
 		
-	spin_lock_irqsave(&ide_lock, flags);
+	BUG_ON(in_interrupt());
+	BUG_ON(irqs_disabled());
+	down(&ide_cfg_sem);
+	spin_lock_irq(&ide_lock);
 	hwif = &ide_hwifs[index];
 	if (!hwif->present)
 		goto abort;
@@ -605,7 +608,7 @@
 	}
 	hwif->present = 0;
 	
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irq(&ide_lock);
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
@@ -618,7 +621,6 @@
 #ifdef CONFIG_PROC_FS
 	destroy_proc_ide_drives(hwif);
 #endif
-	spin_lock_irqsave(&ide_lock, flags);
 	hwgroup = hwif->hwgroup;
 
 	/*
@@ -633,6 +635,7 @@
 	if (irq_count == 1)
 		free_irq(hwif->irq, hwgroup);
 
+	spin_lock_irq(&ide_lock);
 	/*
 	 * Note that we only release the standard ports,
 	 * and do not even try to handle any extra ports
@@ -813,7 +816,8 @@
 
 	hwif->hwif_data			= old_hwif.hwif_data;
 abort:
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irq(&ide_lock);
+	up(&ide_cfg_sem);
 }
 
 EXPORT_SYMBOL(ide_unregister);
--- 2.5/drivers/ide/ide-io.c	2003-01-03 22:37:31.000000000 +0100
+++ build-2.5/drivers/ide/ide-io.c	2003-03-02 10:32:48.000000000 +0100
@@ -745,8 +745,8 @@
 	/* for atari only: POSSIBLY BROKEN HERE(?) */
 	ide_get_lock(ide_intr, hwgroup);
 
-	/* necessary paranoia: ensure IRQs are masked on local CPU */
-	local_irq_disable();
+	/* caller must own ide_lock */
+	BUG_ON(!irqs_disabled());
 
 	while (!hwgroup->busy) {
 		hwgroup->busy = 1;

--------------020907010807080802040101--

