Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbSJAA3l>; Mon, 30 Sep 2002 20:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSJAA3l>; Mon, 30 Sep 2002 20:29:41 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:1286 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261405AbSJAA3g>;
	Mon, 30 Sep 2002 20:29:36 -0400
Date: Mon, 30 Sep 2002 17:32:40 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.39
Message-ID: <20021001003240.GB3994@kroah.com>
References: <20021001003104.GA3994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001003104.GA3994@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.660   -> 1.660.1.1
#	drivers/usb/serial/keyspan.c	1.32    -> 1.33   
#	drivers/usb/class/bluetty.c	1.28    -> 1.29   
#	drivers/usb/serial/ftdi_sio.c	1.35    -> 1.36   
#	drivers/usb/serial/ipaq.c	1.17    -> 1.18   
#	drivers/usb/serial/visor.c	1.40    -> 1.41   
#	drivers/usb/serial/omninet.c	1.23    -> 1.24   
#	drivers/usb/serial/whiteheat.c	1.24    -> 1.25   
#	drivers/usb/serial/usbserial.c	1.43    -> 1.44   
#	drivers/usb/serial/empeg.c	1.30    -> 1.31   
#	drivers/usb/serial/pl2303.c	1.24    -> 1.25   
#	drivers/usb/serial/ir-usb.c	1.20    -> 1.21   
#	drivers/usb/serial/kl5kusb105.c	1.13    -> 1.14   
#	drivers/usb/class/cdc-acm.c	1.21    -> 1.22   
#	drivers/usb/serial/mct_u232.c	1.28    -> 1.29   
#	drivers/usb/serial/cyberjack.c	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/30	greg@kroah.com	1.660.1.1
# USB: queue_task() fixups
# --------------------------------------------
#
diff -Nru a/drivers/usb/class/bluetty.c b/drivers/usb/class/bluetty.c
--- a/drivers/usb/class/bluetty.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/class/bluetty.c	Mon Sep 30 17:26:30 2002
@@ -1006,9 +1006,7 @@
 	}
 
 	/* wake up our little function to let the tty layer know that something happened */
-	queue_task(&bluetooth->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
-	return;
+	schedule_task(&bluetooth->tqueue);
 }
 
 
diff -Nru a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
--- a/drivers/usb/class/cdc-acm.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/class/cdc-acm.c	Mon Sep 30 17:26:30 2002
@@ -272,8 +272,7 @@
 	if (urb->status)
 		dbg("nonzero write bulk status received: %d", urb->status);
 
-	queue_task(&acm->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&acm->tqueue);
 }
 
 static void acm_softint(void *private)
diff -Nru a/drivers/usb/serial/cyberjack.c b/drivers/usb/serial/cyberjack.c
--- a/drivers/usb/serial/cyberjack.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/serial/cyberjack.c	Mon Sep 30 17:26:30 2002
@@ -437,9 +437,7 @@
 			/* Throw away data. No better idea what to do with it. */
 			priv->wrfilled=0;
 			priv->wrsent=0;
-			queue_task(&port->tqueue, &tq_immediate);
-			mark_bh(IMMEDIATE_BH);
-			return;
+			goto exit;
 		}
 
 		dbg("%s - priv->wrsent=%d", __FUNCTION__,priv->wrsent);
@@ -453,16 +451,10 @@
 			priv->wrfilled=0;
 			priv->wrsent=0;
 		}
-
-		queue_task(&port->tqueue, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
-		return;
 	}
 
-	queue_task(&port->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
-	
-	return;
+exit:
+	schedule_task(&port->tqueue);
 }
 
 static int __init cyberjack_init (void)
diff -Nru a/drivers/usb/serial/empeg.c b/drivers/usb/serial/empeg.c
--- a/drivers/usb/serial/empeg.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/serial/empeg.c	Mon Sep 30 17:26:30 2002
@@ -362,11 +362,7 @@
 		return;
 	}
 
-	queue_task(&port->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
-
-	return;
-
+	schedule_task(&port->tqueue);
 }
 
 
diff -Nru a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
--- a/drivers/usb/serial/ftdi_sio.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/serial/ftdi_sio.c	Mon Sep 30 17:26:30 2002
@@ -484,10 +484,8 @@
 		dbg("nonzero write bulk status received: %d", urb->status);
 		return;
 	}
-	queue_task(&port->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
 
-	return;
+	schedule_task(&port->tqueue);
 } /* ftdi_sio_write_bulk_callback */
 
 
diff -Nru a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
--- a/drivers/usb/serial/ipaq.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/serial/ipaq.c	Mon Sep 30 17:26:30 2002
@@ -465,10 +465,8 @@
 		priv->active = 0;
 		spin_unlock_irqrestore(&write_list_lock, flags);
 	}
-	queue_task(&port->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
-	
-	return;
+
+	schedule_task(&port->tqueue);
 }
 
 static int ipaq_write_room(struct usb_serial_port *port)
diff -Nru a/drivers/usb/serial/ir-usb.c b/drivers/usb/serial/ir-usb.c
--- a/drivers/usb/serial/ir-usb.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/serial/ir-usb.c	Mon Sep 30 17:26:30 2002
@@ -426,10 +426,7 @@
 		urb->actual_length,
 		urb->transfer_buffer);
 
-	queue_task(&port->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
-	
-	return;
+	schedule_task(&port->tqueue);
 }
 
 static void ir_read_bulk_callback (struct urb *urb)
diff -Nru a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
--- a/drivers/usb/serial/keyspan.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/serial/keyspan.c	Mon Sep 30 17:26:30 2002
@@ -447,10 +447,8 @@
 	p_priv = (struct keyspan_port_private *)(port->private);
 	dbg ("%s - urb %d", __FUNCTION__, urb == p_priv->out_urbs[1]); 
 
-	if (port->open_count) {
-		queue_task(&port->tqueue, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
-	}
+	if (port->open_count)
+		schedule_task(&port->tqueue);
 }
 
 static void	usa26_inack_callback(struct urb *urb)
diff -Nru a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
--- a/drivers/usb/serial/kl5kusb105.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/serial/kl5kusb105.c	Mon Sep 30 17:26:30 2002
@@ -577,10 +577,7 @@
 	}
 
 	/* from generic_write_bulk_callback */
-	queue_task(&port->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
-
-	return;
+	schedule_task(&port->tqueue);
 } /* klsi_105_write_bulk_completion_callback */
 
 
diff -Nru a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
--- a/drivers/usb/serial/mct_u232.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/serial/mct_u232.c	Mon Sep 30 17:26:30 2002
@@ -507,8 +507,7 @@
 		
 	} else {
 		/* from generic_write_bulk_callback */
-		queue_task(&port->tqueue, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		schedule_task(&port->tqueue);
 	}
 
 	return;
diff -Nru a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
--- a/drivers/usb/serial/omninet.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/serial/omninet.c	Mon Sep 30 17:26:30 2002
@@ -359,12 +359,9 @@
 		return;
 	}
 
-	queue_task(&port->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&port->tqueue);
 
 //	dbg("omninet_write_bulk_callback, tty %0x\n", tty);
-
-	return;
 }
 
 
diff -Nru a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/serial/pl2303.c	Mon Sep 30 17:26:30 2002
@@ -705,10 +705,7 @@
 		return;
 	}
 
-	queue_task(&port->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
-
-	return;
+	schedule_task(&port->tqueue);
 }
 
 
diff -Nru a/drivers/usb/serial/usbserial.c b/drivers/usb/serial/usbserial.c
--- a/drivers/usb/serial/usbserial.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/serial/usbserial.c	Mon Sep 30 17:26:30 2002
@@ -1092,10 +1092,7 @@
 
 	usb_serial_port_softint((void *)port);
 
-	queue_task(&port->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
-
-	return;
+	schedule_tasks(&port->tqueue);
 }
 
 static void generic_shutdown (struct usb_serial *serial)
diff -Nru a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
--- a/drivers/usb/serial/visor.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/serial/visor.c	Mon Sep 30 17:26:30 2002
@@ -458,10 +458,7 @@
 	/* free up the transfer buffer, as usb_free_urb() does not do this */
 	kfree (urb->transfer_buffer);
 
-	queue_task(&port->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
-
-	return;
+	schedule_task(&port->tqueue);
 }
 
 
diff -Nru a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
--- a/drivers/usb/serial/whiteheat.c	Mon Sep 30 17:26:30 2002
+++ b/drivers/usb/serial/whiteheat.c	Mon Sep 30 17:26:30 2002
@@ -918,10 +918,7 @@
 
 	usb_serial_port_softint((void *)port);
 
-	queue_task(&port->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
-
-	return;
+	schedule_task(&port->tqueue);
 }
 
 
