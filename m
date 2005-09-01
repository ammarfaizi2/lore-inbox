Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbVIAB3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVIAB3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVIAB3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:29:00 -0400
Received: from ozlabs.org ([203.10.76.45]:62093 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965013AbVIAB27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:28:59 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/18] iseries_veth: Cleanup error and debug messages
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012857.38EFD681EA@ozlabs.org>
Date: Thu,  1 Sep 2005 11:28:57 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the iseries_veth driver prints the file name and line number in its
error messages. This isn't very useful for most users, so just print
"iseries_veth: message" instead.

 - convert uses of veth_printk() to veth_debug()/veth_error()/veth_info()
 - make terminology consistent, ie. always refer to LPAR not lpar
 - be consistent about printing return codes as %d not %x
 - make format strings fit in 80 columns

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |   98 +++++++++++++++++++++++----------------------
 1 files changed, 51 insertions(+), 47 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -79,6 +79,8 @@
 #include <asm/iommu.h>
 #include <asm/vio.h>
 
+#undef DEBUG
+
 #include "iseries_veth.h"
 
 MODULE_AUTHOR("Kyle Lucke <klucke@us.ibm.com>");
@@ -176,11 +178,18 @@ static void veth_timed_ack(unsigned long
  * Utility functions
  */
 
-#define veth_printk(prio, fmt, args...) \
-	printk(prio "%s: " fmt, __FILE__, ## args)
+#define veth_info(fmt, args...) \
+	printk(KERN_INFO "iseries_veth: " fmt, ## args)
 
 #define veth_error(fmt, args...) \
-	printk(KERN_ERR "(%s:%3.3d) ERROR: " fmt, __FILE__, __LINE__ , ## args)
+	printk(KERN_ERR "iseries_veth: Error: " fmt, ## args)
+
+#ifdef DEBUG
+#define veth_debug(fmt, args...) \
+	printk(KERN_DEBUG "iseries_veth: " fmt, ## args)
+#else
+#define veth_debug(fmt, args...) do {} while (0)
+#endif
 
 static inline void veth_stack_push(struct veth_lpar_connection *cnx,
 				   struct veth_msg *msg)
@@ -278,7 +287,7 @@ static void veth_take_cap(struct veth_lp
 						  HvLpEvent_Type_VirtualLan);
 
 	if (cnx->state & VETH_STATE_GOTCAPS) {
-		veth_error("Received a second capabilities from lpar %d\n",
+		veth_error("Received a second capabilities from LPAR %d.\n",
 			   cnx->remote_lp);
 		event->base_event.xRc = HvLpEvent_Rc_BufferNotAvailable;
 		HvCallEvent_ackLpEvent((struct HvLpEvent *) event);
@@ -297,7 +306,7 @@ static void veth_take_cap_ack(struct vet
 
 	spin_lock_irqsave(&cnx->lock, flags);
 	if (cnx->state & VETH_STATE_GOTCAPACK) {
-		veth_error("Received a second capabilities ack from lpar %d\n",
+		veth_error("Received a second capabilities ack from LPAR %d.\n",
 			   cnx->remote_lp);
 	} else {
 		memcpy(&cnx->cap_ack_event, event,
@@ -314,8 +323,7 @@ static void veth_take_monitor_ack(struct
 	unsigned long flags;
 
 	spin_lock_irqsave(&cnx->lock, flags);
-	veth_printk(KERN_DEBUG, "Monitor ack returned for lpar %d\n",
-		    cnx->remote_lp);
+	veth_debug("cnx %d: lost connection.\n", cnx->remote_lp);
 	cnx->state |= VETH_STATE_RESET;
 	veth_kick_statemachine(cnx);
 	spin_unlock_irqrestore(&cnx->lock, flags);
@@ -336,8 +344,8 @@ static void veth_handle_ack(struct VethL
 		veth_take_monitor_ack(cnx, event);
 		break;
 	default:
-		veth_error("Unknown ack type %d from lpar %d\n",
-			   event->base_event.xSubtype, rlp);
+		veth_error("Unknown ack type %d from LPAR %d.\n",
+				event->base_event.xSubtype, rlp);
 	};
 }
 
@@ -373,8 +381,8 @@ static void veth_handle_int(struct VethL
 		veth_receive(cnx, event);
 		break;
 	default:
-		veth_error("Unknown interrupt type %d from lpar %d\n",
-			   event->base_event.xSubtype, rlp);
+		veth_error("Unknown interrupt type %d from LPAR %d.\n",
+				event->base_event.xSubtype, rlp);
 	};
 }
 
@@ -400,8 +408,8 @@ static int veth_process_caps(struct veth
 	     || (remote_caps->ack_threshold > VETH_MAX_ACKS_PER_MSG)
 	     || (remote_caps->ack_threshold == 0)
 	     || (cnx->ack_timeout == 0) ) {
-		veth_error("Received incompatible capabilities from lpar %d\n",
-			   cnx->remote_lp);
+		veth_error("Received incompatible capabilities from LPAR %d.\n",
+				cnx->remote_lp);
 		return HvLpEvent_Rc_InvalidSubtypeData;
 	}
 
@@ -418,8 +426,8 @@ static int veth_process_caps(struct veth
 			cnx->num_ack_events += num;
 
 		if (cnx->num_ack_events < num_acks_needed) {
-			veth_error("Couldn't allocate enough ack events for lpar %d\n",
-				   cnx->remote_lp);
+			veth_error("Couldn't allocate enough ack events "
+					"for LPAR %d.\n", cnx->remote_lp);
 
 			return HvLpEvent_Rc_BufferNotAvailable;
 		}
@@ -498,9 +506,8 @@ static void veth_statemachine(void *p)
 		} else {
 			if ( (rc != HvLpEvent_Rc_PartitionDead)
 			     && (rc != HvLpEvent_Rc_PathClosed) )
-				veth_error("Error sending monitor to "
-					   "lpar %d, rc=%x\n",
-					   rlp, (int) rc);
+				veth_error("Error sending monitor to LPAR %d, "
+						"rc = %d\n", rlp, rc);
 
 			/* Oh well, hope we get a cap from the other
 			 * end and do better when that kicks us */
@@ -523,9 +530,9 @@ static void veth_statemachine(void *p)
 		} else {
 			if ( (rc != HvLpEvent_Rc_PartitionDead)
 			     && (rc != HvLpEvent_Rc_PathClosed) )
-				veth_error("Error sending caps to "
-					   "lpar %d, rc=%x\n",
-					   rlp, (int) rc);
+				veth_error("Error sending caps to LPAR %d, "
+						"rc = %d\n", rlp, rc);
+
 			/* Oh well, hope we get a cap from the other
 			 * end and do better when that kicks us */
 			goto out;
@@ -565,10 +572,8 @@ static void veth_statemachine(void *p)
 			add_timer(&cnx->ack_timer);
 			cnx->state |= VETH_STATE_READY;
 		} else {
-			veth_printk(KERN_ERR, "Caps rejected (rc=%d) by "
-				    "lpar %d\n",
-				    cnx->cap_ack_event.base_event.xRc,
-				    rlp);
+			veth_error("Caps rejected by LPAR %d, rc = %d\n",
+					rlp, cnx->cap_ack_event.base_event.xRc);
 			goto cant_cope;
 		}
 	}
@@ -581,8 +586,8 @@ static void veth_statemachine(void *p)
 	/* FIXME: we get here if something happens we really can't
 	 * cope with.  The link will never work once we get here, and
 	 * all we can do is not lock the rest of the system up */
-	veth_error("Badness on connection to lpar %d (state=%04lx) "
-		   " - shutting down\n", rlp, cnx->state);
+	veth_error("Unrecoverable error on connection to LPAR %d, shutting down"
+			" (state = 0x%04lx)\n", rlp, cnx->state);
 	cnx->state |= VETH_STATE_SHUTDOWN;
 	spin_unlock_irq(&cnx->lock);
 }
@@ -614,7 +619,7 @@ static int veth_init_connection(u8 rlp)
 
 	msgs = kmalloc(VETH_NUMBUFFERS * sizeof(struct veth_msg), GFP_KERNEL);
 	if (! msgs) {
-		veth_error("Can't allocate buffers for lpar %d\n", rlp);
+		veth_error("Can't allocate buffers for LPAR %d.\n", rlp);
 		return -ENOMEM;
 	}
 
@@ -630,8 +635,7 @@ static int veth_init_connection(u8 rlp)
 	cnx->num_events = veth_allocate_events(rlp, 2 + VETH_NUMBUFFERS);
 
 	if (cnx->num_events < (2 + VETH_NUMBUFFERS)) {
-		veth_error("Can't allocate events for lpar %d, only got %d\n",
-			   rlp, cnx->num_events);
+		veth_error("Can't allocate enough events for LPAR %d.\n", rlp);
 		return -ENOMEM;
 	}
 
@@ -889,15 +893,13 @@ static struct net_device * __init veth_p
 
 	rc = register_netdev(dev);
 	if (rc != 0) {
-		veth_printk(KERN_ERR,
-			    "Failed to register ethernet device for vlan %d\n",
-			    vlan);
+		veth_error("Failed registering net device for vlan%d.\n", vlan);
 		free_netdev(dev);
 		return NULL;
 	}
 
-	veth_printk(KERN_DEBUG, "%s attached to iSeries vlan %d (lpar_map=0x%04x)\n",
-		    dev->name, vlan, port->lpar_map);
+	veth_info("%s attached to iSeries vlan %d (LPAR map = 0x%.4X)\n",
+			dev->name, vlan, port->lpar_map);
 
 	return dev;
 }
@@ -1030,7 +1032,7 @@ static int veth_start_xmit(struct sk_buf
 		dev_kfree_skb(skb);
 	} else {
 		if (port->pending_skb) {
-			veth_error("%s: Tx while skb was pending!\n",
+			veth_error("%s: TX while skb was pending!\n",
 				   dev->name);
 			dev_kfree_skb(skb);
 			spin_unlock_irqrestore(&port->pending_gate, flags);
@@ -1066,10 +1068,10 @@ static void veth_recycle_msg(struct veth
 
 		memset(&msg->data, 0, sizeof(msg->data));
 		veth_stack_push(cnx, msg);
-	} else
-		if (cnx->state & VETH_STATE_OPEN)
-			veth_error("Bogus frames ack from lpar %d (#%d)\n",
-				   cnx->remote_lp, msg->token);
+	} else if (cnx->state & VETH_STATE_OPEN) {
+		veth_error("Non-pending frame (# %d) acked by LPAR %d.\n",
+				cnx->remote_lp, msg->token);
+	}
 }
 
 static void veth_flush_pending(struct veth_lpar_connection *cnx)
@@ -1179,8 +1181,8 @@ static void veth_flush_acks(struct veth_
 			     0, &cnx->pending_acks);
 
 	if (rc != HvLpEvent_Rc_Good)
-		veth_error("Error 0x%x acking frames from lpar %d!\n",
-			   (unsigned)rc, cnx->remote_lp);
+		veth_error("Failed acking frames from LPAR %d, rc = %d\n",
+				cnx->remote_lp, (int)rc);
 
 	cnx->num_pending_acks = 0;
 	memset(&cnx->pending_acks, 0xff, sizeof(cnx->pending_acks));
@@ -1216,9 +1218,10 @@ static void veth_receive(struct veth_lpa
 		/* make sure that we have at least 1 EOF entry in the
 		 * remaining entries */
 		if (! (senddata->eofmask >> (startchunk + VETH_EOF_SHIFT))) {
-			veth_error("missing EOF frag in event "
-				   "eofmask=0x%x startchunk=%d\n",
-				   (unsigned) senddata->eofmask, startchunk);
+			veth_error("Missing EOF fragment in event "
+					"eofmask = 0x%x startchunk = %d\n",
+					(unsigned)senddata->eofmask,
+					startchunk);
 			break;
 		}
 
@@ -1237,8 +1240,9 @@ static void veth_receive(struct veth_lpa
 		/* nchunks == # of chunks in this frame */
 
 		if ((length - ETH_HLEN) > VETH_MAX_MTU) {
-			veth_error("Received oversize frame from lpar %d "
-				   "(length=%d)\n", cnx->remote_lp, length);
+			veth_error("Received oversize frame from LPAR %d "
+					"(length = %d)\n",
+					cnx->remote_lp, length);
 			continue;
 		}
 
