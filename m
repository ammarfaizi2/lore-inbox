Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbTIDMuz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbTIDMuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:50:55 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:35993 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S264959AbTIDMui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:50:38 -0400
Message-ID: <3F573574.5060008@terra.com.br>
Date: Thu, 04 Sep 2003 09:52:04 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Richard Procter <rnp@paradise.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix SMP support on 3c527 net driver, take 2
References: <Pine.LNX.4.21.0309041758250.284-100000@ps2.local>
In-Reply-To: <Pine.LNX.4.21.0309041758250.284-100000@ps2.local>
Content-Type: multipart/mixed;
 boundary="------------030209040602020702020003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030209040602020702020003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Richard,

Richard Procter wrote:
> * mc32_interrupt doesn't acquire the spinlock, rendering the critical
>   sections un-exclusive on SMP. 

	Hmm, you're right here...didn't notice this.

	But I'm not sure on how we should go here: We go get the hold lock 
right after 'status=inb(ioaddr+HOST_CMD)', so we can treat the 
interrupt safely.

	Although, there are some places that we do "wake_up (lp->event)", 
which I *think* will sleep (which is wrong), or will trigger the 
finish of wait_pending (which will try to re-acquire the lcok and will 
deadlock, which is also wrong).

	So, yes, we could release the lock right before we wake_up, but I'm 
not sure if this is the right fix either.

	Furthermore, if we acquire the lock after the "while (inb..)" 
statement, we must release the lock, and re-acquire so we can treat 
tx_ring/rx_ring safely as well...which is damn ugly and probably has 
many races.

	Maybe we could get the lock before 'while'?

	Ideas?

> * sleep_on's remain in mc32_halt_transceiver and mc32_close. I think this 
>   could lead to deadlock on UP --- eg. thread sleeps with spinlock held,
>   subsequent interrupt then waits in vain. Might be less deadly on SMP?
>   (are interrupt handlers reentrant on SMP?) 

	Neh, that was my fault.

	I just didn't switch to wait_pending...this is an easy fix.

> * Just noticed an old error in mc32_close --- sleep_on is called in
>   without first disabling interrupts. 

	This is fixed since we have to hold the device lock before calling 
wait_pending, so it should be fixed too.

> I've had a go at testing it, but ran into troubles with the ibmmca.c
> driver carking on an uninitialised spinlock. Hopefully, I'll find some
> quality time in the weekend to get things going. 

	Great.

	If all works, then we can push to Linus/Andrew/Jeff Garzik for merging.

	Attached is the new patch which fixes the latter 2 problems.

	Feedback welcome.

	Cheers,

Felipe

--------------030209040602020702020003
Content-Type: text/plain;
 name="3c527-cli_sti_removal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3c527-cli_sti_removal.patch"

--- linux-2.6.0-test4/drivers/net/3c527.c	Fri Aug 22 20:56:34 2003
+++ linux-2.6.0-test4-fwd/drivers/net/3c527.c	Thu Sep  4 09:50:03 2003
@@ -17,8 +17,8 @@
  */
 
 #define DRV_NAME		"3c527"
-#define DRV_VERSION		"0.6a"
-#define DRV_RELDATE		"2001/11/17"
+#define DRV_VERSION		"0.6b"
+#define DRV_RELDATE		"2003/09/2"
 
 static const char *version =
 DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " Richard Proctor (rnp@netlink.co.nz)\n";
@@ -100,6 +100,7 @@
 #include <linux/string.h>
 #include <linux/wait.h>
 #include <linux/ethtool.h>
+#include <linux/spinlock.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -157,11 +158,11 @@
 	volatile struct mc32_mailbox *rx_box;
 	volatile struct mc32_mailbox *tx_box;
 	volatile struct mc32_mailbox *exec_box;
-        volatile struct mc32_stats *stats;    /* Start of on-card statistics */
-        u16 tx_chain;           /* Transmit list start offset */
+	volatile struct mc32_stats *stats;    /* Start of on-card statistics */
+	u16 tx_chain;           /* Transmit list start offset */
 	u16 rx_chain;           /* Receive list start offset */
-        u16 tx_len;             /* Transmit list count */ 
-        u16 rx_len;             /* Receive list count */
+	u16 tx_len;             /* Transmit list count */ 
+	u16 rx_len;             /* Receive list count */
 
 	u32 base;
 	u16 exec_pending;
@@ -179,6 +180,7 @@
 	u16 tx_ring_head;       /* index to tx en-queue end */
 
 	u16 rx_ring_tail;       /* index to rx de-queue end */ 
+	spinlock_t lock;
 };
 
 /* The station (ethernet) address prefix, used for a sanity check. */
@@ -197,7 +199,6 @@
 	{ 0x0000, NULL }
 };
 
-
 /* Macros for ring index manipulations */ 
 static inline u16 next_rx(u16 rx) { return (rx+1)&(RX_RING_LEN-1); };
 static inline u16 prev_rx(u16 rx) { return (rx-1)&(RX_RING_LEN-1); };
@@ -536,7 +537,7 @@
  *	command register. This tells us nothing about the completion
  *	status of any pending commands and takes very little time at all.
  */
- 
+
 static void mc32_ready_poll(struct net_device *dev)
 {
 	int ioaddr = dev->base_addr;
@@ -579,6 +580,24 @@
 	return 0;
 }
 
+/**
+ *	wait_pending - sleep until a field reaches a certain value 
+ *	@lp: m32_local structure describing the target card
+ *
+ *	The caller must acquire lp->lock before calling this function, it
+ *	temporarily drops the lock when it sleeps (SMP-safe).
+ */
+
+static inline void wait_pending(struct mc32_local *lp)
+{
+	DEFINE_WAIT(wait);
+
+	prepare_to_wait(&lp->event, &wait, TASK_UNINTERRUPTIBLE);
+	spin_unlock_irq(&lp->lock);
+	schedule();
+	spin_lock_irq(&lp->lock);
+	finish_wait(&lp->event, &wait);
+}
 
 /**
  *	mc32_command	-	send a command and sleep until completion
@@ -619,14 +638,12 @@
 	int ret = 0;
 	
 	/*
-	 *	Wait for a command
+	 *	Wait until there are no more pending commands
 	 */
 	 
-	save_flags(flags);
-	cli();
-	 
-	while(lp->exec_pending)
-		sleep_on(&lp->event);
+	spin_lock_irqsave(&lp->lock, flags);
+	while (lp->exec_pending)
+		wait_pending(lp);
 		
 	/*
 	 *	Issue mine
@@ -634,7 +651,7 @@
 
 	lp->exec_pending=1;
 	
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lp->lock, flags);
 	
 	lp->exec_box->mbox=0;
 	lp->exec_box->mbox=cmd;
@@ -645,13 +662,11 @@
 	while(!(inb(ioaddr+HOST_STATUS)&HOST_STATUS_CRR));
 	outb(1<<6, ioaddr+HOST_CMD);	
 
-	save_flags(flags);
-	cli();
-
-	while(lp->exec_pending!=2)
-		sleep_on(&lp->event);
+	spin_lock_irqsave(&lp->lock, flags);
+	while (lp->exec_pending != 2)
+		wait_pending (lp);
 	lp->exec_pending=0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lp->lock, flags);
 	
 	if(lp->exec_box->mbox&(1<<13))
 		ret = -1;
@@ -735,15 +750,14 @@
 	outb(HOST_CMD_SUSPND_RX, ioaddr+HOST_CMD);			
 	mc32_ready_poll(dev); 
 	outb(HOST_CMD_SUSPND_TX, ioaddr+HOST_CMD);	
-		
-	save_flags(flags);
-	cli();
-		
+
+	spin_lock_irqsave (&lp->lock, flags);
+
 	while(lp->xceiver_state!=HALTED) 
-		sleep_on(&lp->event); 
-		
-	restore_flags(flags);	
-} 
+		wait_pending (lp); 
+
+	spin_unlock_irqrestore (&lp->lock, flags);
+}
 
 
 /**
@@ -1062,12 +1076,11 @@
 
 	netif_stop_queue(dev);
 
-	save_flags(flags);
-	cli();
-		
+	spin_lock_irqsave (&lp->lock, flags);
+
 	if(atomic_read(&lp->tx_count)==0)
 	{
-		restore_flags(flags);
+		spin_unlock_irqrestore (&lp->lock, flags);
 		return 1;
 	}
 
@@ -1098,7 +1111,7 @@
 		
 	p->control     &= ~CONTROL_EOL;     /* Clear EOL on p */ 
 out:	
-	restore_flags(flags);
+	spin_unlock_irqrestore (&lp->lock, flags);
 
 	netif_wake_queue(dev);
 	return 0;
@@ -1386,7 +1399,7 @@
 			case 3: /* Halt */
 			case 4: /* Abort */
 				lp->xceiver_state |= TX_HALTED; 
-				wake_up(&lp->event);
+				wake_up(&lp->event); 
 				break;
 			default:
 				printk("%s: strange tx ack %d\n", dev->name, status&7);
@@ -1435,8 +1448,8 @@
 				   
 				if (lp->mc_reload_wait) 
 					mc32_reset_multicast_list(dev);
-				else 
-					wake_up(&lp->event);			       
+				else
+					wake_up(&lp->event);
 			}
 		}
 		if(status&2)
@@ -1450,7 +1463,6 @@
 		}
 	}
 
-
 	/*
 	 *	Process the transmit and receive rings 
          */
@@ -1492,6 +1504,8 @@
 	struct mc32_local *lp = (struct mc32_local *)dev->priv;
 
 	int ioaddr = dev->base_addr;
+	unsigned long flags;
+
 	u8 regs;
 	u16 one=1;
 	
@@ -1509,9 +1523,11 @@
 	mc32_halt_transceiver(dev); 
 	
 	/* Catch any waiting commands */
-	
+
+	spin_lock_irqsave(&lp->lock, flags);
 	while(lp->exec_pending==1)
-		sleep_on(&lp->event);
+		wait_pending(lp);
+	spin_unlock_irqrestore(&lp->lock, flags);
 	       
 	/* Ok the card is now stopping */	
 	

--------------030209040602020702020003--

