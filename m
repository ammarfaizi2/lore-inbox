Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSDGVcy>; Sun, 7 Apr 2002 17:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313480AbSDGVcx>; Sun, 7 Apr 2002 17:32:53 -0400
Received: from stingr.net ([212.193.32.15]:39046 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S313477AbSDGVcv>;
	Sun, 7 Apr 2002 17:32:51 -0400
Date: Mon, 8 Apr 2002 01:32:44 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][CLEANUP] task->state cleanups part 2
Message-ID: <20020407213244.GH839@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	William Lee Irwin III <wli@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2Marcelo: the whole cleanup tree derived from yours available at
linux-stingr.bkbits.net/taskstate

2others: people says that it is nice patch, howewer it is completely
untested. But I dunno what can be broken such way so ...

This is task->state cleanup. Big part seems to be eaten my Matti Aarnio so
splitted goes below. Starting from part 2.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.311   -> 1.312  
#	drivers/block/swim_iop.c	1.2     -> 1.3    
#	 drivers/cdrom/mcd.c	1.7     -> 1.8    
#	drivers/atm/atmtcp.c	1.2     -> 1.3    
#	drivers/block/ll_rw_blk.c	1.31    -> 1.32   
#	drivers/block/paride/pf.c	1.7     -> 1.8    
#	drivers/atm/firestream.c	1.10    -> 1.11   
#	drivers/cdrom/cdu31a.c	1.5     -> 1.6    
#	drivers/cdrom/sbpcd.c	1.9     -> 1.10   
#	drivers/acorn/char/mouse_ps2.c	1.3     -> 1.4    
#	drivers/block/paride/pt.c	1.6     -> 1.7    
#	drivers/block/paride/pg.c	1.5     -> 1.6    
#	drivers/cdrom/sonycd535.c	1.4     -> 1.5    
#	drivers/block/swim3.c	1.4     -> 1.5    
#	   drivers/acpi/os.c	1.8     -> 1.9    
#	drivers/block/paride/pcd.c	1.6     -> 1.7    
#	drivers/bluetooth/hci_vhci.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/08	stingray@stingr.net	1.312
# task->state cleanup part 2
# --------------------------------------------
#
diff -Nru a/drivers/acorn/char/mouse_ps2.c b/drivers/acorn/char/mouse_ps2.c
--- a/drivers/acorn/char/mouse_ps2.c	Mon Apr  8 01:23:39 2002
+++ b/drivers/acorn/char/mouse_ps2.c	Mon Apr  8 01:23:39 2002
@@ -191,12 +191,12 @@
 			return -EAGAIN;
 		add_wait_queue(&queue->proc_list, &wait);
 repeat:
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		if (queue_empty() && !signal_pending(current)) {
 			schedule();
 			goto repeat;
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&queue->proc_list, &wait);
 	}
 	while (i > 0 && !queue_empty()) {
diff -Nru a/drivers/acpi/os.c b/drivers/acpi/os.c
--- a/drivers/acpi/os.c	Mon Apr  8 01:23:39 2002
+++ b/drivers/acpi/os.c	Mon Apr  8 01:23:39 2002
@@ -261,7 +261,7 @@
 void
 acpi_os_sleep(u32 sec, u32 ms)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(HZ * sec + (ms * HZ) / 1000);
 }
 
@@ -796,7 +796,7 @@
 
 			ret = down_trylock(sem);
 			for (i = timeout; (i > 0 && ret < 0); i -= quantum_ms) {
-				current->state = TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				schedule_timeout(1);
 				ret = down_trylock(sem);
 			}
diff -Nru a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
--- a/drivers/atm/atmtcp.c	Mon Apr  8 01:23:38 2002
+++ b/drivers/atm/atmtcp.c	Mon Apr  8 01:23:38 2002
@@ -77,7 +77,7 @@
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&vcc->sleep,&wait);
 	return error;
 }
diff -Nru a/drivers/atm/firestream.c b/drivers/atm/firestream.c
--- a/drivers/atm/firestream.c	Mon Apr  8 01:23:38 2002
+++ b/drivers/atm/firestream.c	Mon Apr  8 01:23:38 2002
@@ -1719,7 +1719,7 @@
 		}
 
 		/* Try again after 10ms. */
-		current->state = TASK_UNINTERRUPTIBLE;
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout ((HZ+99)/100);
 	}
 
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Mon Apr  8 01:23:38 2002
+++ b/drivers/block/ll_rw_blk.c	Mon Apr  8 01:23:38 2002
@@ -541,7 +541,7 @@
 		spin_unlock_irq(&io_request_lock);
 	} while (rq == NULL);
 	remove_wait_queue(&q->wait_for_requests[rw], &wait);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	return rq;
 }
 
diff -Nru a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
--- a/drivers/block/paride/pcd.c	Mon Apr  8 01:23:39 2002
+++ b/drivers/block/paride/pcd.c	Mon Apr  8 01:23:39 2002
@@ -588,7 +588,7 @@
 
 static void pcd_sleep( int cs )
 
-{       current->state = TASK_INTERRUPTIBLE;
+{       set_current_state(TASK_INTERRUPTIBLE);
         schedule_timeout(cs);
 }
 
diff -Nru a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
--- a/drivers/block/paride/pf.c	Mon Apr  8 01:23:38 2002
+++ b/drivers/block/paride/pf.c	Mon Apr  8 01:23:38 2002
@@ -676,7 +676,7 @@
 
 static void pf_sleep( int cs )
 
-{       current->state = TASK_INTERRUPTIBLE;
+{       set_current_state(TASK_INTERRUPTIBLE);
         schedule_timeout(cs);
 }
 
diff -Nru a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c	Mon Apr  8 01:23:39 2002
+++ b/drivers/block/paride/pg.c	Mon Apr  8 01:23:39 2002
@@ -356,7 +356,7 @@
 
 static void pg_sleep( int cs )
 
-{       current->state = TASK_INTERRUPTIBLE;
+{       set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(cs);
 }
 
diff -Nru a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
--- a/drivers/block/paride/pt.c	Mon Apr  8 01:23:39 2002
+++ b/drivers/block/paride/pt.c	Mon Apr  8 01:23:39 2002
@@ -468,7 +468,7 @@
 
 static void pt_sleep( int cs )
 
-{       current->state = TASK_INTERRUPTIBLE;
+{       set_current_state(TASK_INTERRUPTIBLE);
         schedule_timeout(cs);
 }
 
diff -Nru a/drivers/block/swim3.c b/drivers/block/swim3.c
--- a/drivers/block/swim3.c	Mon Apr  8 01:23:39 2002
+++ b/drivers/block/swim3.c	Mon Apr  8 01:23:39 2002
@@ -803,7 +803,7 @@
 			err = -EINTR;
 			break;
 		}
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 	fs->ejected = 1;
@@ -890,7 +890,7 @@
 				err = -EINTR;
 				break;
 			}
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(1);
 		}
 		if (err == 0 && (swim3_readbit(fs, SEEK_COMPLETE) == 0
@@ -988,7 +988,7 @@
 			break;
 		if (signal_pending(current))
 			break;
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 	ret = swim3_readbit(fs, SEEK_COMPLETE) == 0
diff -Nru a/drivers/block/swim_iop.c b/drivers/block/swim_iop.c
--- a/drivers/block/swim_iop.c	Mon Apr  8 01:23:38 2002
+++ b/drivers/block/swim_iop.c	Mon Apr  8 01:23:38 2002
@@ -327,7 +327,7 @@
 			err = -EINTR;
 			break;
 		}
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 	release_drive(fs);
diff -Nru a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
--- a/drivers/bluetooth/hci_vhci.c	Mon Apr  8 01:23:39 2002
+++ b/drivers/bluetooth/hci_vhci.c	Mon Apr  8 01:23:39 2002
@@ -188,7 +188,7 @@
 
 	add_wait_queue(&hci_vhci->read_wait, &wait);
 	while (count) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 
 		/* Read frames from device queue */
 		if (!(skb = skb_dequeue(&hci_vhci->readq))) {
@@ -215,7 +215,7 @@
 		break;
 	}
 
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&hci_vhci->read_wait, &wait);
 
 	return ret;
diff -Nru a/drivers/cdrom/cdu31a.c b/drivers/cdrom/cdu31a.c
--- a/drivers/cdrom/cdu31a.c	Mon Apr  8 01:23:38 2002
+++ b/drivers/cdrom/cdu31a.c	Mon Apr  8 01:23:38 2002
@@ -394,7 +394,7 @@
 	unsigned long flags;
 
 	if (cdu31a_irq <= 0) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(0);
 	} else {		/* Interrupt driven */
 
@@ -737,7 +737,7 @@
 		       res_reg[1]);
 	}
 
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(2 * HZ);
 
 	sony_get_toc();
@@ -968,7 +968,7 @@
 	if (((result_buffer[0] & 0xf0) == 0x20)
 	    && (num_retries < MAX_CDU31A_RETRIES)) {
 		num_retries++;
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ / 10);	/* Wait .1 seconds on retries */
 		goto retry_cd_operation;
 	}
diff -Nru a/drivers/cdrom/mcd.c b/drivers/cdrom/mcd.c
--- a/drivers/cdrom/mcd.c	Mon Apr  8 01:23:38 2002
+++ b/drivers/cdrom/mcd.c	Mon Apr  8 01:23:38 2002
@@ -996,7 +996,7 @@
 		if (st == -1)
 			goto err_out;	/* drive doesn't respond */
 		if ((st & MST_READY) == 0) {	/* no disk? wait a sec... */
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(HZ);
 		}
 	} while (((st & MST_READY) == 0) && count++ < MCD_RETRY_ATTEMPTS);
diff -Nru a/drivers/cdrom/sbpcd.c b/drivers/cdrom/sbpcd.c
--- a/drivers/cdrom/sbpcd.c	Mon Apr  8 01:23:39 2002
+++ b/drivers/cdrom/sbpcd.c	Mon Apr  8 01:23:39 2002
@@ -878,7 +878,7 @@
 static void sbp_sleep(u_int time)
 {
 	sti();
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(time);
 	sti();
 }
diff -Nru a/drivers/cdrom/sonycd535.c b/drivers/cdrom/sonycd535.c
--- a/drivers/cdrom/sonycd535.c	Mon Apr  8 01:23:39 2002
+++ b/drivers/cdrom/sonycd535.c	Mon Apr  8 01:23:39 2002
@@ -339,7 +339,7 @@
 sony_sleep(void)
 {
 	if (sony535_irq_used <= 0) {	/* poll */
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(0);
 	} else {	/* Interrupt driven */
 		cli();
@@ -894,7 +894,7 @@
 						}
 						if (readStatus == BAD_STATUS) {
 							/* Sleep for a while, then retry */
-							current->state = TASK_INTERRUPTIBLE;
+							set_current_state(TASK_INTERRUPTIBLE);
 							schedule_timeout(RETRY_FOR_BAD_STATUS*HZ/10);
 						}
 #if DEBUG > 0
@@ -1515,7 +1515,7 @@
 	/* look for the CD-ROM, follows the procedure in the DOS driver */
 	inb(select_unit_reg);
 	/* wait for 40 18 Hz ticks (reverse-engineered from DOS driver) */
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout((HZ+17)*40/18);
 	inb(result_reg);
 


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
