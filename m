Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313254AbSEMNUM>; Mon, 13 May 2002 09:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313264AbSEMNUM>; Mon, 13 May 2002 09:20:12 -0400
Received: from [195.63.194.11] ([195.63.194.11]:34320 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313254AbSEMNUJ>; Mon, 13 May 2002 09:20:09 -0400
Message-ID: <3CDFAEC0.6050403@evision-ventures.com>
Date: Mon, 13 May 2002 14:17:04 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.15 IDE 62
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010003090202080004050801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010003090202080004050801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mon May 13 12:38:11 CEST 2002 ide-clean-62

- Add missing locking around ide_do_request in do_ide_request().

- Check all other places where locks get used for matching pairs in ide.c.

- Streamline device detection reporting to always use ->slot_name.

--------------010003090202080004050801
Content-Type: text/plain;
 name="ide-clean-62.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-62.diff"

diff -urN linux-2.5.15/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.15/drivers/ide/ide.c	2002-05-13 15:13:11.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-13 14:27:39.000000000 +0200
@@ -323,6 +323,7 @@
 	}
 
 	spin_unlock_irqrestore(&ide_lock, flags);
+
 	return ret;
 }
 
@@ -341,6 +342,7 @@
 	ide_hwgroup_t *hwgroup = ch->hwgroup;
 
 	spin_lock_irqsave(&ide_lock, flags);
+
 	if (hwgroup->handler != NULL) {
 		printk("%s: ide_set_handler: handler not null; old=%p, new=%p, from %p\n",
 			drive->name, hwgroup->handler, handler, __builtin_return_address(0));
@@ -349,6 +351,7 @@
 	ch->expiry = expiry;
 	ch->timer.expires = jiffies + timeout;
 	add_timer(&ch->timer);
+
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
@@ -1071,8 +1074,10 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&ide_lock, flags);
+
 	hwgroup->handler = NULL;
 	del_timer(&ch->timer);
+
 	spin_unlock_irqrestore(&ide_lock, flags);
 
 	return start_request(drive, drive->rq);
@@ -1275,10 +1280,12 @@
 			disable_irq_nosync(drive->channel->irq);
 
 		spin_unlock(&ide_lock);
+
 		ide__sti();	/* allow other IRQs while we start this request */
 		startstop = start_request(drive, rq);
 
 		spin_lock_irq(&ide_lock);
+
 		if (masked_irq && drive->channel->irq != masked_irq)
 			enable_irq(drive->channel->irq);
 
@@ -1332,7 +1339,7 @@
 static void ide_do_request(struct ata_channel *channel, int masked_irq)
 {
 	ide_get_lock(&irq_lock, ata_irq_request, hwgroup);/* for atari only: POSSIBLY BROKEN HERE(?) */
-	__cli();	/* necessary paranoia: ensure IRQs are masked on local CPU */
+//	__cli();	/* necessary paranoia: ensure IRQs are masked on local CPU */
 
 	while (!test_and_set_bit(IDE_BUSY, &channel->active)) {
 		struct ata_channel *ch;
@@ -1362,11 +1369,16 @@
 
 		queue_commands(drive, masked_irq);
 	}
+
 }
 
 void do_ide_request(request_queue_t *q)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&ide_lock, flags);
 	ide_do_request(q->queuedata, 0);
+	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
 /*
@@ -1455,7 +1467,9 @@
 					/* reengage timer */
 					ch->timer.expires  = jiffies + wait;
 					add_timer(&ch->timer);
+
 					spin_unlock_irqrestore(&ide_lock, flags);
+
 					return;
 				}
 			}
@@ -1465,7 +1479,9 @@
 			 * the handler() function, which means we need to globally
 			 * mask the specific IRQ:
 			 */
+
 			spin_unlock(&ide_lock);
+
 			ch = drive->channel;
 #if DISABLE_IRQ_NOSYNC
 			disable_irq_nosync(ch->irq);
@@ -1490,7 +1506,9 @@
 			}
 			set_recovery_timer(ch);
 			enable_irq(ch->irq);
+
 			spin_lock_irq(&ide_lock);
+
 			if (startstop == ide_stopped)
 				clear_bit(IDE_BUSY, &ch->active);
 		}
@@ -1621,6 +1639,7 @@
 		printk(KERN_ERR "%s: %s: hwgroup was not busy!?\n", drive->name, __FUNCTION__);
 	hwgroup->handler = NULL;
 	del_timer(&ch->timer);
+
 	spin_unlock(&ide_lock);
 
 	if (ch->unmask)
@@ -1725,7 +1744,9 @@
 	rq->rq_dev = mk_kdev(major,(drive->select.b.unit)<<PARTN_BITS);
 	if (action == ide_wait)
 		rq->waiting = &wait;
+
 	spin_lock_irqsave(&ide_lock, flags);
+
 	if (blk_queue_empty(&drive->queue) || action == ide_preempt) {
 		if (action == ide_preempt)
 			drive->rq = NULL;
@@ -1737,7 +1758,9 @@
 	}
 	q->elevator.elevator_add_req_fn(q, rq, queue_head);
 	ide_do_request(drive->channel, 0);
+
 	spin_unlock_irqrestore(&ide_lock, flags);
+
 	if (action == ide_wait) {
 		wait_for_completion(&wait);	/* wait for it to be serviced */
 		return rq->errors ? -EIO : 0;	/* return -EIO if errors */
@@ -1767,12 +1790,15 @@
 	spin_lock_irqsave(&ide_lock, flags);
 
 	if (drive->busy || (drive->usage > 1)) {
+
 		spin_unlock_irqrestore(&ide_lock, flags);
+
 		return -EBUSY;
 	}
 
 	drive->busy = 1;
 	MOD_INC_USE_COUNT;
+
 	spin_unlock_irqrestore(&ide_lock, flags);
 
 	res = wipe_partitions(i_rdev);
@@ -1789,6 +1815,7 @@
 	drive->busy = 0;
 	wake_up(&drive->wqueue);
 	MOD_DEC_USE_COUNT;
+
 	return res;
 }
 
@@ -1950,6 +1977,7 @@
 	 * All clear?  Then blow away the buffer cache
 	 */
 	spin_unlock_irqrestore(&ide_lock, flags);
+
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		struct ata_device * drive = &ch->drives[unit];
 
@@ -1964,6 +1992,7 @@
 			}
 		}
 	}
+
 	spin_lock_irqsave(&ide_lock, flags);
 
 	/*
@@ -2221,11 +2250,14 @@
 	spin_lock_irq(&ide_lock);
 
 	while (test_bit(IDE_BUSY, &drive->channel->active)) {
+
 		spin_unlock_irq(&ide_lock);
+
 		if (time_after(jiffies, timeout)) {
 			printk("%s: channel busy\n", drive->name);
 			return -EBUSY;
 		}
+
 		spin_lock_irq(&ide_lock);
 	}
 
@@ -3455,7 +3487,7 @@
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 # if defined(__mc68000__) || defined(CONFIG_APUS)
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET]) {
-		ide_get_lock(&irq_lock, NULL, NULL);/* for atari only */
+		// ide_get_lock(&irq_lock, NULL, NULL);/* for atari only */
 		disable_irq(ide_hwifs[0].irq);	/* disable_irq_nosync ?? */
 //		disable_irq_nosync(ide_hwifs[0].irq);
 	}
diff -urN linux-2.5.15/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.15/drivers/ide/ide-pci.c	2002-05-13 15:13:11.000000000 +0200
+++ linux/drivers/ide/ide-pci.c	2002-05-13 15:01:41.000000000 +0200
@@ -553,15 +553,14 @@
 			}
 		}
 	}
-
-	printk("ATA: %s: controller on PCI bus %02x dev %02x\n",
-			dev->name, dev->bus->number, dev->devfn);
+	printk(KERN_INFO "ATA: %s: controller on PCI slot %s dev %02x\n",
+			dev->name, dev->slot_name, dev->devfn);
 	setup_pci_device(dev, d);
 	if (!dev2)
 		return;
 	d2 = d;
-	printk("ATA: %s: controller on PCI bus %02x dev %02x\n",
-			dev2->name, dev2->bus->number, dev2->devfn);
+	printk(KERN_INFO "ATA: %s: controller on PCI slot %s dev %02x\n",
+			dev2->name, dev2->slot_name, dev2->devfn);
 	setup_pci_device(dev2, d2);
 }
 
@@ -584,8 +583,8 @@
 		}
 	}
 
-	printk("%s: IDE controller on PCI bus %02x dev %02x\n",
-		dev->name, dev->bus->number, dev->devfn);
+	printk(KERN_INFO "ATA: %s: controller on PCI slot %s dev %02x\n",
+		dev->name, dev->slot_name, dev->devfn);
 	setup_pci_device(dev, d);
 	if (!dev2) {
 		return;
@@ -601,8 +600,8 @@
 		}
 	}
 	d2 = d;
-	printk("%s: IDE controller on PCI bus %02x dev %02x\n",
-		dev2->name, dev2->bus->number, dev2->devfn);
+	printk(KERN_INFO "ATA: %s: controller on PCI slot %s dev %02x\n",
+		dev2->name, dev2->slot_name, dev2->devfn);
 	setup_pci_device(dev2, d2);
 
 }
@@ -623,7 +622,7 @@
 	switch(class_rev) {
 		case 5:
 		case 4:
-		case 3:	printk("%s: IDE controller on PCI slot %s\n", dev->name, dev->slot_name);
+		case 3:	printk(KERN_INFO "ATA: %s: controller on PCI slot %s\n", dev->name, dev->slot_name);
 			setup_pci_device(dev, d);
 			return;
 		default:	break;
@@ -639,17 +638,17 @@
 			pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin2);
 			if ((pin1 != pin2) && (dev->irq == dev2->irq)) {
 				d->bootable = ON_BOARD;
-				printk("%s: onboard version of chipset, pin1=%d pin2=%d\n", dev->name, pin1, pin2);
+				printk(KERN_INFO "ATAL: %s: onboard version of chipset, pin1=%d pin2=%d\n", dev->name, pin1, pin2);
 			}
 			break;
 		}
 	}
-	printk("%s: IDE controller on PCI slot %s\n", dev->name, dev->slot_name);
+	printk(KERN_INFO "ATA: %s: controller on PCI slot %s\n", dev->name, dev->slot_name);
 	setup_pci_device(dev, d);
 	if (!dev2)
 		return;
 	d2 = d;
-	printk("%s: IDE controller on PCI slot %s\n", dev2->name, dev2->slot_name);
+	printk(KERN_INFO "ATA: %s: controller on PCI slot %s\n", dev2->name, dev2->slot_name);
 	setup_pci_device(dev2, d2);
 }
 
@@ -679,6 +678,10 @@
 	}
 
 	if (!d) {
+		/* Only check the device calls, if it wasn't listed, since
+		 * there are in esp. some pdc202xx chips which "work around"
+		 * beeing grabbed by generic drivers.
+		 */
 		if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 			printk(KERN_INFO "ATA: unknown interface: %s, on PCI slot %s\n",
 					dev->name, dev->slot_name);

--------------010003090202080004050801--

