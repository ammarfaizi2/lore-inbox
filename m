Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUELUxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUELUxq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUELUxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:53:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:63683 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263770AbUELUuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:50:12 -0400
Date: Wed, 12 May 2004 13:47:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mingo@elte.hu, davidel@xmailserver.org, jgarzik@pobox.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-Id: <20040512134718.7e55cceb.akpm@osdl.org>
In-Reply-To: <20040512203829.GI1397@holomorphy.com>
References: <20040512020700.6f6aa61f.akpm@osdl.org>
	<20040512181903.GG13421@kroah.com>
	<40A26FFA.4030701@pobox.com>
	<20040512193349.GA14936@elte.hu>
	<Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com>
	<20040512200305.GA16078@elte.hu>
	<20040512132050.6eae6905.akpm@osdl.org>
	<20040512203829.GI1397@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> How about this?
> 
>  #if HZ <= 1000 && !(1000 % HZ)
>  #define MSEC_TO_JIFFIES(m)	((1000/HZ)*(m))
>  #define JIFFIES_TO_MSEC(j)	((j)/(1000/HZ))
>  #elif HZ > 1000 && !(HZ % 1000)
>  #define MSEC_TO_JIFFIES(m)	((m)/(HZ/1000))
>  #define JIFFIES_TO_MSEC(j)	((HZ/1000)*(j))
>  #else
>  #define MSEC_TO_JIFFIES(m)	((HZ*(m) + 999)/1000)
>  #define JIFFIES_TO_MSEC(j)	((1000*(j) + HZ - 1)/HZ)
>  #endif

You promise it's correct and generates good code?




---

 25-akpm/drivers/net/irda/act200l-sir.c |    2 +-
 25-akpm/drivers/net/irda/act200l.c     |   10 +++++-----
 25-akpm/drivers/net/irda/actisys.c     |    2 +-
 25-akpm/drivers/net/irda/girbil.c      |   10 +++++-----
 25-akpm/drivers/net/irda/irda-usb.c    |    6 +++---
 25-akpm/drivers/net/irda/irport.c      |    4 ++--
 25-akpm/drivers/net/irda/irtty-sir.c   |    4 ++--
 25-akpm/drivers/net/irda/ma600-sir.c   |    8 ++++----
 25-akpm/drivers/net/irda/ma600.c       |   16 ++++++++--------
 25-akpm/drivers/net/irda/mcp2120.c     |    8 ++++----
 25-akpm/drivers/net/irda/sir_dev.c     |    2 +-
 25-akpm/drivers/net/irda/sir_kthread.c |    2 +-
 25-akpm/drivers/net/irda/stir4200.c    |    6 +++---
 25-akpm/drivers/net/irda/tekram-sir.c  |    2 +-
 25-akpm/drivers/net/irda/tekram.c      |   12 ++++++------
 25-akpm/include/asm-i386/param.h       |    2 --
 25-akpm/include/linux/time.h           |   10 ++++++++++
 25-akpm/include/net/irda/irda.h        |    2 --
 25-akpm/include/net/sctp/sctp.h        |    5 -----
 25-akpm/kernel/sched.c                 |    7 -------
 25-akpm/net/irda/ircomm/ircomm_tty.c   |    2 +-
 25-akpm/net/irda/irlap_event.c         |    6 +++---
 25-akpm/net/sctp/associola.c           |   10 +++++-----
 25-akpm/net/sctp/chunk.c               |    2 +-
 25-akpm/net/sctp/endpointola.c         |    4 ++--
 25-akpm/net/sctp/socket.c              |   24 ++++++++++++------------
 26 files changed, 81 insertions(+), 87 deletions(-)

diff -puN drivers/net/irda/act200l.c~jiffies-to-msec-borkage-fix drivers/net/irda/act200l.c
--- 25/drivers/net/irda/act200l.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.436171144 -0700
+++ 25-akpm/drivers/net/irda/act200l.c	2004-05-12 13:46:41.482164152 -0700
@@ -148,7 +148,7 @@ static int act200l_change_speed(struct i
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
 
 			/* Give reset 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = MSEC_TO_JIFFIES(1000);
 		}
 		break;
 	case IRDA_TASK_CHILD_WAIT:
@@ -187,7 +187,7 @@ static int act200l_change_speed(struct i
 		/* Write control bytes */
 		self->write(self->dev, control, 3);
 		irda_task_next_state(task, IRDA_TASK_WAIT);
-		ret = MSECS_TO_JIFFIES(5);
+		ret = MSEC_TO_JIFFIES(5);
 		break;
 	case IRDA_TASK_WAIT:
 		/* Go back to normal mode */
@@ -237,14 +237,14 @@ static int act200l_reset(struct irda_tas
 		self->set_dtr_rts(self->dev, TRUE, TRUE);
 
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
-		ret = MSECS_TO_JIFFIES(50);
+		ret = MSEC_TO_JIFFIES(50);
 		break;
 	case IRDA_TASK_WAIT1:
 		/* Reset the dongle : set RTS low for 25 ms */
 		self->set_dtr_rts(self->dev, TRUE, FALSE);
 
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
-		ret = MSECS_TO_JIFFIES(50);
+		ret = MSEC_TO_JIFFIES(50);
 		break;
 	case IRDA_TASK_WAIT2:
 		/* Clear DTR and set RTS to enter command mode */
@@ -253,7 +253,7 @@ static int act200l_reset(struct irda_tas
 		/* Write control bytes */
 		self->write(self->dev, control, 9);
 		irda_task_next_state(task, IRDA_TASK_WAIT3);
-		ret = MSECS_TO_JIFFIES(15);
+		ret = MSEC_TO_JIFFIES(15);
 		break;
 	case IRDA_TASK_WAIT3:
 		/* Go back to normal mode */
diff -puN drivers/net/irda/act200l-sir.c~jiffies-to-msec-borkage-fix drivers/net/irda/act200l-sir.c
--- 25/drivers/net/irda/act200l-sir.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.437170992 -0700
+++ 25-akpm/drivers/net/irda/act200l-sir.c	2004-05-12 13:46:41.486163544 -0700
@@ -178,7 +178,7 @@ static int act200l_change_speed(struct s
 	/* Write control bytes */
 	sirdev_raw_write(dev, control, 3);
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(5));
+	schedule_timeout(MSEC_TO_JIFFIES(5));
 
 	/* Go back to normal mode */
 	sirdev_set_dtr_rts(dev, TRUE, TRUE);
diff -puN drivers/net/irda/actisys.c~jiffies-to-msec-borkage-fix drivers/net/irda/actisys.c
--- 25/drivers/net/irda/actisys.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.439170688 -0700
+++ 25-akpm/drivers/net/irda/actisys.c	2004-05-12 13:46:41.486163544 -0700
@@ -238,7 +238,7 @@ static int actisys_reset(struct irda_tas
 		self->set_dtr_rts(self->dev, TRUE, TRUE);
 		
 		/* Sleep 50 ms to make sure capacitor is charged */
-		ret = MSECS_TO_JIFFIES(50);
+		ret = MSEC_TO_JIFFIES(50);
 		irda_task_next_state(task, IRDA_TASK_WAIT);
 		break;
 	case IRDA_TASK_WAIT:			
diff -puN drivers/net/irda/girbil.c~jiffies-to-msec-borkage-fix drivers/net/irda/girbil.c
--- 25/drivers/net/irda/girbil.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.440170536 -0700
+++ 25-akpm/drivers/net/irda/girbil.c	2004-05-12 13:46:41.478164760 -0700
@@ -119,7 +119,7 @@ static int girbil_change_speed(struct ir
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
 
 			/* Give reset 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = MSEC_TO_JIFFIES(1000);
 		}
 		break;
 	case IRDA_TASK_CHILD_WAIT:
@@ -153,7 +153,7 @@ static int girbil_change_speed(struct ir
 		/* Write control bytes */
 		self->write(self->dev, control, 2);
 		irda_task_next_state(task, IRDA_TASK_WAIT);
-		ret = MSECS_TO_JIFFIES(100);
+		ret = MSEC_TO_JIFFIES(100);
 		break;
 	case IRDA_TASK_WAIT:
 		/* Go back to normal mode */
@@ -194,19 +194,19 @@ static int girbil_reset(struct irda_task
 		self->set_dtr_rts(self->dev, TRUE, FALSE);
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
 		/* Sleep at least 5 ms */
-		ret = MSECS_TO_JIFFIES(20);
+		ret = MSEC_TO_JIFFIES(20);
 		break;
 	case IRDA_TASK_WAIT1:
 		/* Set DTR and clear RTS to enter command mode */
 		self->set_dtr_rts(self->dev, FALSE, TRUE);
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
-		ret = MSECS_TO_JIFFIES(20);
+		ret = MSEC_TO_JIFFIES(20);
 		break;
 	case IRDA_TASK_WAIT2:
 		/* Write control byte */
 		self->write(self->dev, &control, 1);
 		irda_task_next_state(task, IRDA_TASK_WAIT3);
-		ret = MSECS_TO_JIFFIES(20);
+		ret = MSEC_TO_JIFFIES(20);
 		break;
 	case IRDA_TASK_WAIT3:
 		/* Go back to normal mode */
diff -puN drivers/net/irda/irda-usb.c~jiffies-to-msec-borkage-fix drivers/net/irda/irda-usb.c
--- 25/drivers/net/irda/irda-usb.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.442170232 -0700
+++ 25-akpm/drivers/net/irda/irda-usb.c	2004-05-12 13:46:41.481164304 -0700
@@ -268,7 +268,7 @@ static void irda_usb_change_speed_xbofs(
                       speed_bulk_callback, self);
 	urb->transfer_buffer_length = USB_IRDA_HEADER;
 	urb->transfer_flags = URB_ASYNC_UNLINK;
-	urb->timeout = MSECS_TO_JIFFIES(100);
+	urb->timeout = MSEC_TO_JIFFIES(100);
 
 	/* Irq disabled -> GFP_ATOMIC */
 	if ((ret = usb_submit_urb(urb, GFP_ATOMIC))) {
@@ -412,7 +412,7 @@ static int irda_usb_hard_xmit(struct sk_
 	 * This is how the dongle will detect the end of packet - Jean II */
 	urb->transfer_flags |= URB_ZERO_PACKET;
 	/* Timeout need to be shorter than NET watchdog timer */
-	urb->timeout = MSECS_TO_JIFFIES(200);
+	urb->timeout = MSEC_TO_JIFFIES(200);
 
 	/* Generate min turn time. FIXME: can we do better than this? */
 	/* Trying to a turnaround time at this level is trying to measure
@@ -1311,7 +1311,7 @@ static inline struct irda_class_desc *ir
 		IU_REQ_GET_CLASS_DESC,
 		USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
 		0, intf->altsetting->desc.bInterfaceNumber, desc,
-		sizeof(*desc), MSECS_TO_JIFFIES(500));
+		sizeof(*desc), MSEC_TO_JIFFIES(500));
 	
 	IRDA_DEBUG(1, "%s(), ret=%d\n", __FUNCTION__, ret);
 	if (ret < sizeof(*desc)) {
diff -puN drivers/net/irda/irport.c~jiffies-to-msec-borkage-fix drivers/net/irda/irport.c
--- 25/drivers/net/irda/irport.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.443170080 -0700
+++ 25-akpm/drivers/net/irda/irport.c	2004-05-12 13:46:41.484163848 -0700
@@ -452,7 +452,7 @@ int __irport_change_speed(struct irda_ta
 			task->state = IRDA_TASK_WAIT;
 
 			/* Try again later */
-			ret = MSECS_TO_JIFFIES(20);
+			ret = MSEC_TO_JIFFIES(20);
 			break;
 		}
 
@@ -474,7 +474,7 @@ int __irport_change_speed(struct irda_ta
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
 
 			/* Give dongle 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = MSEC_TO_JIFFIES(1000);
 		} else
 			/* Child finished immediately */
 			irda_task_next_state(task, IRDA_TASK_CHILD_DONE);
diff -puN drivers/net/irda/irtty-sir.c~jiffies-to-msec-borkage-fix drivers/net/irda/irtty-sir.c
--- 25/drivers/net/irda/irtty-sir.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.444169928 -0700
+++ 25-akpm/drivers/net/irda/irtty-sir.c	2004-05-12 13:46:41.478164760 -0700
@@ -93,12 +93,12 @@ static void irtty_wait_until_sent(struct
 	tty = priv->tty;
 	if (tty->driver->wait_until_sent) {
 		lock_kernel();
-		tty->driver->wait_until_sent(tty, MSECS_TO_JIFFIES(100));
+		tty->driver->wait_until_sent(tty, MSEC_TO_JIFFIES(100));
 		unlock_kernel();
 	}
 	else {
 		set_task_state(current, TASK_UNINTERRUPTIBLE);
-		schedule_timeout(MSECS_TO_JIFFIES(USBSERIAL_TX_DONE_DELAY));
+		schedule_timeout(MSEC_TO_JIFFIES(USBSERIAL_TX_DONE_DELAY));
 	}
 }
 
diff -puN drivers/net/irda/ma600.c~jiffies-to-msec-borkage-fix drivers/net/irda/ma600.c
--- 25/drivers/net/irda/ma600.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.446169624 -0700
+++ 25-akpm/drivers/net/irda/ma600.c	2004-05-12 13:46:41.480164456 -0700
@@ -184,7 +184,7 @@ static int ma600_change_speed(struct ird
 
 	if (self->speed_task && self->speed_task != task) {
 		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__);
-		return MSECS_TO_JIFFIES(10);
+		return MSEC_TO_JIFFIES(10);
 	} else {
 		self->speed_task = task;
 	}
@@ -202,7 +202,7 @@ static int ma600_change_speed(struct ird
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
 	
 			/* give 1 second to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = MSEC_TO_JIFFIES(1000);
 		} else {
 			irda_task_next_state(task, IRDA_TASK_CHILD_DONE);
 		}
@@ -217,7 +217,7 @@ static int ma600_change_speed(struct ird
 		/* Set DTR, Clear RTS */
 		self->set_dtr_rts(self->dev, TRUE, FALSE);
 	
-		ret = MSECS_TO_JIFFIES(1);		/* Sleep 1 ms */
+		ret = MSEC_TO_JIFFIES(1);		/* Sleep 1 ms */
 		irda_task_next_state(task, IRDA_TASK_WAIT);
 		break;
 
@@ -231,7 +231,7 @@ static int ma600_change_speed(struct ird
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
 
 		/* Wait at least 10 ms */
-		ret = MSECS_TO_JIFFIES(15);
+		ret = MSEC_TO_JIFFIES(15);
 		break;
 
 	case IRDA_TASK_WAIT1:
@@ -258,7 +258,7 @@ static int ma600_change_speed(struct ird
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
 
 		/* Wait at least 10 ms */
-		ret = MSECS_TO_JIFFIES(10);
+		ret = MSEC_TO_JIFFIES(10);
 		break;
 
 	case IRDA_TASK_WAIT2:
@@ -298,7 +298,7 @@ int ma600_reset(struct irda_task *task)
 
 	if (self->reset_task && self->reset_task != task) {
 		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__);
-		return MSECS_TO_JIFFIES(10);
+		return MSEC_TO_JIFFIES(10);
 	} else
 		self->reset_task = task;
 	
@@ -307,13 +307,13 @@ int ma600_reset(struct irda_task *task)
 		/* Clear DTR and Set RTS */
 		self->set_dtr_rts(self->dev, FALSE, TRUE);
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
-		ret = MSECS_TO_JIFFIES(10);		/* Sleep 10 ms */
+		ret = MSEC_TO_JIFFIES(10);		/* Sleep 10 ms */
 		break;
 	case IRDA_TASK_WAIT1:
 		/* Set DTR and RTS */
 		self->set_dtr_rts(self->dev, TRUE, TRUE);
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
-		ret = MSECS_TO_JIFFIES(10);		/* Sleep 10 ms */
+		ret = MSEC_TO_JIFFIES(10);		/* Sleep 10 ms */
 		break;
 	case IRDA_TASK_WAIT2:
 		irda_task_next_state(task, IRDA_TASK_DONE);
diff -puN drivers/net/irda/ma600-sir.c~jiffies-to-msec-borkage-fix drivers/net/irda/ma600-sir.c
--- 25/drivers/net/irda/ma600-sir.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.447169472 -0700
+++ 25-akpm/drivers/net/irda/ma600-sir.c	2004-05-12 13:46:41.487163392 -0700
@@ -192,7 +192,7 @@ static int ma600_change_speed(struct sir
 
 	/* Wait at least 10ms: fake wait_until_sent - 10 bits at 9600 baud*/
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(15));		/* old ma600 uses 15ms */
+	schedule_timeout(MSEC_TO_JIFFIES(15));		/* old ma600 uses 15ms */
 
 #if 1
 	/* read-back of the control byte. ma600 is the first dongle driver
@@ -216,7 +216,7 @@ static int ma600_change_speed(struct sir
 
 	/* Wait at least 10ms */
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(10));
+	schedule_timeout(MSEC_TO_JIFFIES(10));
 
 	/* dongle is now switched to the new speed */
 	dev->speed = speed;
@@ -246,12 +246,12 @@ int ma600_reset(struct sir_dev *dev)
 	/* Reset the dongle : set DTR low for 10 ms */
 	sirdev_set_dtr_rts(dev, FALSE, TRUE);
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(10));
+	schedule_timeout(MSEC_TO_JIFFIES(10));
 
 	/* Go back to normal mode */
 	sirdev_set_dtr_rts(dev, TRUE, TRUE);
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(10));
+	schedule_timeout(MSEC_TO_JIFFIES(10));
 
 	dev->speed = 9600;      /* That's the dongle-default */
 
diff -puN drivers/net/irda/mcp2120.c~jiffies-to-msec-borkage-fix drivers/net/irda/mcp2120.c
--- 25/drivers/net/irda/mcp2120.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.448169320 -0700
+++ 25-akpm/drivers/net/irda/mcp2120.c	2004-05-12 13:46:41.485163696 -0700
@@ -99,7 +99,7 @@ static int mcp2120_change_speed(struct i
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
 
 			/* Give reset 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = MSEC_TO_JIFFIES(1000);
 		}
 		break;
 	case IRDA_TASK_CHILD_WAIT:
@@ -140,7 +140,7 @@ static int mcp2120_change_speed(struct i
                 self->write(self->dev, control, 2);
  
                 irda_task_next_state(task, IRDA_TASK_WAIT);
-		ret = MSECS_TO_JIFFIES(100);
+		ret = MSEC_TO_JIFFIES(100);
                 //printk("mcp2120_change_speed irda_child_done\n");
 		break;
 	case IRDA_TASK_WAIT:
@@ -189,14 +189,14 @@ static int mcp2120_reset(struct irda_tas
 		/* Reset dongle by setting RTS*/
 		self->set_dtr_rts(self->dev, TRUE, TRUE);
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
-		ret = MSECS_TO_JIFFIES(50);
+		ret = MSEC_TO_JIFFIES(50);
 		break;
 	case IRDA_TASK_WAIT1:
                 //printk("mcp2120_reset irda_task_wait1\n");
                 /* clear RTS and wait for at least 30 ms. */
 		self->set_dtr_rts(self->dev, FALSE, FALSE);
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
-		ret = MSECS_TO_JIFFIES(50);
+		ret = MSEC_TO_JIFFIES(50);
 		break;
 	case IRDA_TASK_WAIT2:
                 //printk("mcp2120_reset irda_task_wait2\n");
diff -puN drivers/net/irda/sir_dev.c~jiffies-to-msec-borkage-fix drivers/net/irda/sir_dev.c
--- 25/drivers/net/irda/sir_dev.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.450169016 -0700
+++ 25-akpm/drivers/net/irda/sir_dev.c	2004-05-12 13:46:41.483164000 -0700
@@ -74,7 +74,7 @@ int sirdev_raw_write(struct sir_dev *dev
 	while (dev->tx_buff.len > 0) {			/* wait until tx idle */
 		spin_unlock_irqrestore(&dev->tx_lock, flags);
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(MSECS_TO_JIFFIES(10));
+		schedule_timeout(MSEC_TO_JIFFIES(10));
 		spin_lock_irqsave(&dev->tx_lock, flags);
 	}
 
diff -puN drivers/net/irda/sir_kthread.c~jiffies-to-msec-borkage-fix drivers/net/irda/sir_kthread.c
--- 25/drivers/net/irda/sir_kthread.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.451168864 -0700
+++ 25-akpm/drivers/net/irda/sir_kthread.c	2004-05-12 13:46:41.485163696 -0700
@@ -415,7 +415,7 @@ static void irda_config_fsm(void *data)
 		fsm->state = next_state;
 	} while(!delay);
 
-	irda_queue_delayed_request(&fsm->rq, MSECS_TO_JIFFIES(delay));
+	irda_queue_delayed_request(&fsm->rq, MSEC_TO_JIFFIES(delay));
 }
 
 /* schedule some device configuration task for execution by kIrDAd
diff -puN drivers/net/irda/stir4200.c~jiffies-to-msec-borkage-fix drivers/net/irda/stir4200.c
--- 25/drivers/net/irda/stir4200.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.453168560 -0700
+++ 25-akpm/drivers/net/irda/stir4200.c	2004-05-12 13:46:41.488163240 -0700
@@ -208,7 +208,7 @@ static int write_reg(struct stir_cb *sti
 			       REQ_WRITE_SINGLE,
 			       USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_DEVICE,
 			       value, reg, NULL, 0,
-			       MSECS_TO_JIFFIES(CTRL_TIMEOUT));
+			       MSEC_TO_JIFFIES(CTRL_TIMEOUT));
 }
 
 /* Send control message to read multiple registers */
@@ -221,7 +221,7 @@ static inline int read_reg(struct stir_c
 			       REQ_READ_REG,
 			       USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			       0, reg, data, count,
-			       MSECS_TO_JIFFIES(CTRL_TIMEOUT));
+			       MSEC_TO_JIFFIES(CTRL_TIMEOUT));
 }
 
 static inline int isfir(u32 speed)
@@ -745,7 +745,7 @@ static void stir_send(struct stir_cb *st
 
 	if (usb_bulk_msg(stir->usbdev, usb_sndbulkpipe(stir->usbdev, 1),
 			 stir->io_buf, wraplen,
-			 NULL, MSECS_TO_JIFFIES(TRANSMIT_TIMEOUT))) 
+			 NULL, MSEC_TO_JIFFIES(TRANSMIT_TIMEOUT)))
 		stir->stats.tx_errors++;
 }
 
diff -puN drivers/net/irda/tekram.c~jiffies-to-msec-borkage-fix drivers/net/irda/tekram.c
--- 25/drivers/net/irda/tekram.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.454168408 -0700
+++ 25-akpm/drivers/net/irda/tekram.c	2004-05-12 13:46:41.482164152 -0700
@@ -113,7 +113,7 @@ static int tekram_change_speed(struct ir
 
 	if (self->speed_task && self->speed_task != task) {
 		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__ );
-		return MSECS_TO_JIFFIES(10);
+		return MSEC_TO_JIFFIES(10);
 	} else
 		self->speed_task = task;
 
@@ -150,7 +150,7 @@ static int tekram_change_speed(struct ir
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
 
 			/* Give reset 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = MSEC_TO_JIFFIES(1000);
 		} else
 			irda_task_next_state(task, IRDA_TASK_CHILD_DONE);
 		break;
@@ -171,7 +171,7 @@ static int tekram_change_speed(struct ir
 		irda_task_next_state(task, IRDA_TASK_WAIT);
 
 		/* Wait at least 100 ms */
-		ret = MSECS_TO_JIFFIES(150);
+		ret = MSEC_TO_JIFFIES(150);
 		break;
 	case IRDA_TASK_WAIT:
 		/* Set DTR, Set RTS */
@@ -214,7 +214,7 @@ int tekram_reset(struct irda_task *task)
 
 	if (self->reset_task && self->reset_task != task) {
 		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__ );
-		return MSECS_TO_JIFFIES(10);
+		return MSEC_TO_JIFFIES(10);
 	} else
 		self->reset_task = task;
 	
@@ -227,7 +227,7 @@ int tekram_reset(struct irda_task *task)
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
 
 		/* Sleep 50 ms */
-		ret = MSECS_TO_JIFFIES(50);
+		ret = MSEC_TO_JIFFIES(50);
 		break;
 	case IRDA_TASK_WAIT1:
 		/* Clear DTR, Set RTS */
@@ -236,7 +236,7 @@ int tekram_reset(struct irda_task *task)
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
 		
 		/* Should sleep 1 ms */
-		ret = MSECS_TO_JIFFIES(1);
+		ret = MSEC_TO_JIFFIES(1);
 		break;
 	case IRDA_TASK_WAIT2:
 		/* Set DTR, Set RTS */
diff -puN drivers/net/irda/tekram-sir.c~jiffies-to-msec-borkage-fix drivers/net/irda/tekram-sir.c
--- 25/drivers/net/irda/tekram-sir.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.455168256 -0700
+++ 25-akpm/drivers/net/irda/tekram-sir.c	2004-05-12 13:46:41.479164608 -0700
@@ -211,7 +211,7 @@ static int tekram_reset(struct sir_dev *
 
 	/* Should sleep 1 ms */
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(1));
+	schedule_timeout(MSEC_TO_JIFFIES(1));
 
 	/* Set DTR, Set RTS */
 	sirdev_set_dtr_rts(dev, TRUE, TRUE);
diff -puN include/asm-i386/param.h~jiffies-to-msec-borkage-fix include/asm-i386/param.h
--- 25/include/asm-i386/param.h~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.456168104 -0700
+++ 25-akpm/include/asm-i386/param.h	2004-05-12 13:46:41.497161872 -0700
@@ -5,8 +5,6 @@
 # define HZ		1000		/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC		(USER_HZ)	/* like times() */
-# define JIFFIES_TO_MSEC(x)	(x)
-# define MSEC_TO_JIFFIES(x)	(x)
 #endif
 
 #ifndef HZ
diff -puN include/linux/time.h~jiffies-to-msec-borkage-fix include/linux/time.h
--- 25/include/linux/time.h~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.457167952 -0700
+++ 25-akpm/include/linux/time.h	2004-05-12 13:46:41.496162024 -0700
@@ -383,5 +383,15 @@ struct	itimerval {
 
 #define TIMER_ABSTIME 0x01
 
+#if HZ <= 1000 && !(1000 % HZ)
+#define MSEC_TO_JIFFIES(m)	((1000/HZ)*(m))
+#define JIFFIES_TO_MSEC(j)	((j)/(1000/HZ))
+#elif HZ > 1000 && !(HZ % 1000)
+#define MSEC_TO_JIFFIES(m)	((m)/(HZ/1000))
+#define JIFFIES_TO_MSEC(j)	((HZ/1000)*(j))
+#else
+#define MSEC_TO_JIFFIES(m)	((HZ*(m) + 999)/1000)
+#define JIFFIES_TO_MSEC(j)	((1000*(j) + HZ - 1)/HZ)
+#endif
 
 #endif
diff -puN include/net/irda/irda.h~jiffies-to-msec-borkage-fix include/net/irda/irda.h
--- 25/include/net/irda/irda.h~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.459167648 -0700
+++ 25-akpm/include/net/irda/irda.h	2004-05-12 13:46:41.488163240 -0700
@@ -83,8 +83,6 @@ if(!(expr)) do { \
 #define MESSAGE(args...) printk(KERN_INFO args)
 #define ERROR(args...)   printk(KERN_ERR args)
 
-#define MSECS_TO_JIFFIES(ms) (((ms)*HZ+999)/1000)
-
 /*
  *  Magic numbers used by Linux-IrDA. Random numbers which must be unique to 
  *  give the best protection
diff -puN include/net/sctp/sctp.h~jiffies-to-msec-borkage-fix include/net/sctp/sctp.h
--- 25/include/net/sctp/sctp.h~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.460167496 -0700
+++ 25-akpm/include/net/sctp/sctp.h	2004-05-12 13:46:41.473165520 -0700
@@ -116,11 +116,6 @@
 #define SCTP_STATIC static
 #endif
 
-#define MSECS_TO_JIFFIES(msec) \
-	(((msec / 1000) * HZ) + ((msec % 1000) * HZ) / 1000)
-#define JIFFIES_TO_MSECS(jiff) \
-	(((jiff / HZ) * 1000) + ((jiff % HZ) * 1000) / HZ)
-
 /*
  * Function declarations.
  */
diff -puN kernel/sched.c~jiffies-to-msec-borkage-fix kernel/sched.c
--- 25/kernel/sched.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.461167344 -0700
+++ 25-akpm/kernel/sched.c	2004-05-12 13:46:41.496162024 -0700
@@ -75,13 +75,6 @@
 #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
 #define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
 
-#ifndef JIFFIES_TO_MSEC
-# define JIFFIES_TO_MSEC(x) ((x) * 1000 / HZ)
-#endif
-#ifndef MSEC_TO_JIFFIES
-# define MSEC_TO_JIFFIES(x) ((x) * HZ / 1000)
-#endif
-
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
diff -puN net/irda/ircomm/ircomm_tty.c~jiffies-to-msec-borkage-fix net/irda/ircomm/ircomm_tty.c
--- 25/net/irda/ircomm/ircomm_tty.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.463167040 -0700
+++ 25-akpm/net/irda/ircomm/ircomm_tty.c	2004-05-12 13:46:41.489163088 -0700
@@ -873,7 +873,7 @@ static void ircomm_tty_wait_until_sent(s
 	orig_jiffies = jiffies;
 
 	/* Set poll time to 200 ms */
-	poll_time = IRDA_MIN(timeout, MSECS_TO_JIFFIES(200));
+	poll_time = IRDA_MIN(timeout, MSEC_TO_JIFFIES(200));
 
 	spin_lock_irqsave(&self->spinlock, flags);
 	while (self->tx_skb && self->tx_skb->len) {
diff -puN net/irda/irlap_event.c~jiffies-to-msec-borkage-fix net/irda/irlap_event.c
--- 25/net/irda/irlap_event.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.464166888 -0700
+++ 25-akpm/net/irda/irlap_event.c	2004-05-12 13:46:41.491162784 -0700
@@ -627,7 +627,7 @@ static int irlap_state_query(struct irla
 		if (irda_device_is_receiving(self->netdev) && !self->add_wait) {
 			IRDA_DEBUG(2, "%s(), device is slow to answer, "
 				   "waiting some more!\n", __FUNCTION__);
-			irlap_start_slot_timer(self, MSECS_TO_JIFFIES(10));
+			irlap_start_slot_timer(self, MSEC_TO_JIFFIES(10));
 			self->add_wait = TRUE;
 			return ret;
 		}
@@ -849,7 +849,7 @@ static int irlap_state_setup(struct irla
  *  1.5 times the time taken to transmit a SNRM frame. So this time should
  *  between 15 msecs and 45 msecs.
  */
-			irlap_start_backoff_timer(self, MSECS_TO_JIFFIES(20 +
+			irlap_start_backoff_timer(self, MSEC_TO_JIFFIES(20 +
 						        (jiffies % 30)));
 		} else {
 			/* Always switch state before calling upper layers */
@@ -1506,7 +1506,7 @@ static int irlap_state_nrm_p(struct irla
 		if (irda_device_is_receiving(self->netdev) && !self->add_wait) {
 			IRDA_DEBUG(1, "FINAL_TIMER_EXPIRED when receiving a "
 			      "frame! Waiting a little bit more!\n");
-			irlap_start_final_timer(self, MSECS_TO_JIFFIES(300));
+			irlap_start_final_timer(self, MSEC_TO_JIFFIES(300));
 
 			/*
 			 *  Don't allow this to happen one more time in a row,
diff -puN net/sctp/associola.c~jiffies-to-msec-borkage-fix net/sctp/associola.c
--- 25/net/sctp/associola.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.466166584 -0700
+++ 25-akpm/net/sctp/associola.c	2004-05-12 13:46:41.492162632 -0700
@@ -142,9 +142,9 @@ struct sctp_association *sctp_associatio
 	 * socket values.
 	 */
 	asoc->max_retrans = sp->assocparams.sasoc_asocmaxrxt;
-	asoc->rto_initial = MSECS_TO_JIFFIES(sp->rtoinfo.srto_initial);
-	asoc->rto_max = MSECS_TO_JIFFIES(sp->rtoinfo.srto_max);
-	asoc->rto_min = MSECS_TO_JIFFIES(sp->rtoinfo.srto_min);
+	asoc->rto_initial = MSEC_TO_JIFFIES(sp->rtoinfo.srto_initial);
+	asoc->rto_max = MSEC_TO_JIFFIES(sp->rtoinfo.srto_max);
+	asoc->rto_min = MSEC_TO_JIFFIES(sp->rtoinfo.srto_min);
 
 	asoc->overall_error_count = 0;
 
@@ -170,7 +170,7 @@ struct sctp_association *sctp_associatio
 	asoc->max_init_attempts	= sp->initmsg.sinit_max_attempts;
 
 	asoc->max_init_timeo =
-		 MSECS_TO_JIFFIES(sp->initmsg.sinit_max_init_timeo);
+		 MSEC_TO_JIFFIES(sp->initmsg.sinit_max_init_timeo);
 
 	/* Allocate storage for the ssnmap after the inbound and outbound
 	 * streams have been negotiated during Init.
@@ -507,7 +507,7 @@ struct sctp_transport *sctp_assoc_add_pe
 	/* Initialize the peer's heartbeat interval based on the
 	 * sock configured value.
 	 */
-	peer->hb_interval = MSECS_TO_JIFFIES(sp->paddrparam.spp_hbinterval);
+	peer->hb_interval = MSEC_TO_JIFFIES(sp->paddrparam.spp_hbinterval);
 
 	/* Set the path max_retrans.  */
 	peer->max_retrans = asoc->max_retrans;
diff -puN net/sctp/chunk.c~jiffies-to-msec-borkage-fix net/sctp/chunk.c
--- 25/net/sctp/chunk.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.467166432 -0700
+++ 25-akpm/net/sctp/chunk.c	2004-05-12 13:46:41.493162480 -0700
@@ -186,7 +186,7 @@ struct sctp_datamsg *sctp_datamsg_from_u
 	if (sinfo->sinfo_timetolive) {
 		/* sinfo_timetolive is in milliseconds */
 		msg->expires_at = jiffies +
-				    MSECS_TO_JIFFIES(sinfo->sinfo_timetolive);
+				    MSEC_TO_JIFFIES(sinfo->sinfo_timetolive);
 		msg->can_abandon = 1;
 		SCTP_DEBUG_PRINTK("%s: msg:%p expires_at: %ld jiffies:%ld\n",
 				  __FUNCTION__, msg, msg->expires_at, jiffies);
diff -puN net/sctp/endpointola.c~jiffies-to-msec-borkage-fix net/sctp/endpointola.c
--- 25/net/sctp/endpointola.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.468166280 -0700
+++ 25-akpm/net/sctp/endpointola.c	2004-05-12 13:46:41.493162480 -0700
@@ -129,7 +129,7 @@ struct sctp_endpoint *sctp_endpoint_init
 	ep->timeouts[SCTP_EVENT_TIMEOUT_T1_INIT] =
 		SCTP_DEFAULT_TIMEOUT_T1_INIT;
 	ep->timeouts[SCTP_EVENT_TIMEOUT_T2_SHUTDOWN] =
-		MSECS_TO_JIFFIES(sp->rtoinfo.srto_initial);
+		MSEC_TO_JIFFIES(sp->rtoinfo.srto_initial);
 	ep->timeouts[SCTP_EVENT_TIMEOUT_T3_RTX] = 0;
 	ep->timeouts[SCTP_EVENT_TIMEOUT_T4_RTO] = 0;
 
@@ -138,7 +138,7 @@ struct sctp_endpoint *sctp_endpoint_init
 	 * recommended value of 5 times 'RTO.Max'.
 	 */
         ep->timeouts[SCTP_EVENT_TIMEOUT_T5_SHUTDOWN_GUARD]
-		= 5 * MSECS_TO_JIFFIES(sp->rtoinfo.srto_max);
+		= 5 * MSEC_TO_JIFFIES(sp->rtoinfo.srto_max);
 
 	ep->timeouts[SCTP_EVENT_TIMEOUT_HEARTBEAT] =
 		SCTP_DEFAULT_TIMEOUT_HEARTBEAT;
diff -puN net/sctp/socket.c~jiffies-to-msec-borkage-fix net/sctp/socket.c
--- 25/net/sctp/socket.c~jiffies-to-msec-borkage-fix	2004-05-12 13:46:41.470165976 -0700
+++ 25-akpm/net/sctp/socket.c	2004-05-12 13:46:41.477164912 -0700
@@ -2379,14 +2379,14 @@ SCTP_STATIC int sctp_init_sock(struct so
 	sp->initmsg.sinit_num_ostreams   = sctp_max_outstreams;
 	sp->initmsg.sinit_max_instreams  = sctp_max_instreams;
 	sp->initmsg.sinit_max_attempts   = sctp_max_retrans_init;
-	sp->initmsg.sinit_max_init_timeo = JIFFIES_TO_MSECS(sctp_rto_max);
+	sp->initmsg.sinit_max_init_timeo = JIFFIES_TO_MSEC(sctp_rto_max);
 
 	/* Initialize default RTO related parameters.  These parameters can
 	 * be modified for with the SCTP_RTOINFO socket option.
 	 */
-	sp->rtoinfo.srto_initial = JIFFIES_TO_MSECS(sctp_rto_initial);
-	sp->rtoinfo.srto_max     = JIFFIES_TO_MSECS(sctp_rto_max);
-	sp->rtoinfo.srto_min     = JIFFIES_TO_MSECS(sctp_rto_min);
+	sp->rtoinfo.srto_initial = JIFFIES_TO_MSEC(sctp_rto_initial);
+	sp->rtoinfo.srto_max     = JIFFIES_TO_MSEC(sctp_rto_max);
+	sp->rtoinfo.srto_min     = JIFFIES_TO_MSEC(sctp_rto_min);
 
 	/* Initialize default association related parameters. These parameters
 	 * can be modified with the SCTP_ASSOCINFO socket option.
@@ -2396,7 +2396,7 @@ SCTP_STATIC int sctp_init_sock(struct so
 	sp->assocparams.sasoc_peer_rwnd = 0;
 	sp->assocparams.sasoc_local_rwnd = 0;
 	sp->assocparams.sasoc_cookie_life = 
-		JIFFIES_TO_MSECS(sctp_valid_cookie_life);
+		JIFFIES_TO_MSEC(sctp_valid_cookie_life);
 
 	/* Initialize default event subscriptions. By default, all the
 	 * options are off. 
@@ -2406,7 +2406,7 @@ SCTP_STATIC int sctp_init_sock(struct so
 	/* Default Peer Address Parameters.  These defaults can
 	 * be modified via SCTP_PEER_ADDR_PARAMS
 	 */
-	sp->paddrparam.spp_hbinterval = JIFFIES_TO_MSECS(sctp_hb_interval);
+	sp->paddrparam.spp_hbinterval = JIFFIES_TO_MSEC(sctp_hb_interval);
 	sp->paddrparam.spp_pathmaxrxt = sctp_max_retrans_path;
 
 	/* If enabled no SCTP message fragmentation will be performed.
@@ -2552,7 +2552,7 @@ static int sctp_getsockopt_sctp_status(s
 	status.sstat_primary.spinfo_state = transport->active;
 	status.sstat_primary.spinfo_cwnd = transport->cwnd;
 	status.sstat_primary.spinfo_srtt = transport->srtt;
-	status.sstat_primary.spinfo_rto = JIFFIES_TO_MSECS(transport->rto);
+	status.sstat_primary.spinfo_rto = JIFFIES_TO_MSEC(transport->rto);
 	status.sstat_primary.spinfo_mtu = transport->pmtu;
 
 	if (put_user(len, optlen)) {
@@ -2607,7 +2607,7 @@ static int sctp_getsockopt_peer_addr_inf
 	pinfo.spinfo_state = transport->active;
 	pinfo.spinfo_cwnd = transport->cwnd;
 	pinfo.spinfo_srtt = transport->srtt;
-	pinfo.spinfo_rto = JIFFIES_TO_MSECS(transport->rto);
+	pinfo.spinfo_rto = JIFFIES_TO_MSEC(transport->rto);
 	pinfo.spinfo_mtu = transport->pmtu;
 
 	if (put_user(len, optlen)) {
@@ -2811,7 +2811,7 @@ static int sctp_getsockopt_peer_addr_par
 	if (!trans->hb_allowed)
 		params.spp_hbinterval = 0;
 	else
-		params.spp_hbinterval = JIFFIES_TO_MSECS(trans->hb_interval);
+		params.spp_hbinterval = JIFFIES_TO_MSEC(trans->hb_interval);
 
 	/* spp_pathmaxrxt contains the maximum number of retransmissions
 	 * before this address shall be considered unreachable.
@@ -3168,9 +3168,9 @@ static int sctp_getsockopt_rtoinfo(struc
 
 	/* Values corresponding to the specific association. */
 	if (asoc) {
-		rtoinfo.srto_initial = JIFFIES_TO_MSECS(asoc->rto_initial);
-		rtoinfo.srto_max = JIFFIES_TO_MSECS(asoc->rto_max);
-		rtoinfo.srto_min = JIFFIES_TO_MSECS(asoc->rto_min);
+		rtoinfo.srto_initial = JIFFIES_TO_MSEC(asoc->rto_initial);
+		rtoinfo.srto_max = JIFFIES_TO_MSEC(asoc->rto_max);
+		rtoinfo.srto_min = JIFFIES_TO_MSEC(asoc->rto_min);
 	} else {
 		/* Values corresponding to the endpoint. */
 		struct sctp_opt *sp = sctp_sk(sk);

_

