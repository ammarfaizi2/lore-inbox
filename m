Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262406AbREXWOX>; Thu, 24 May 2001 18:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262402AbREXWOO>; Thu, 24 May 2001 18:14:14 -0400
Received: from pobox.sibyte.com ([208.12.96.20]:36614 "HELO pobox.sibyte.com")
	by vger.kernel.org with SMTP id <S262398AbREXWOG>;
	Thu, 24 May 2001 18:14:06 -0400
From: Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [CHECKER] free bugs in 2.4.4 and 2.4.4-ac8
Date: Thu, 24 May 2001 15:01:27 -0700
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: mc@cs.Stanford.EDU
In-Reply-To: <200105242104.OAA29654@csl.Stanford.EDU>
In-Reply-To: <200105242104.OAA29654@csl.Stanford.EDU>
MIME-Version: 1.0
Message-Id: <0105241513340I.01510@plugh.sibyte.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001, Dawson Engler wrote:
> Hi All,
> 
> Enclosed are 24 bugs where code uses memory that has been freed.  The
> good thing about these bugs is that they are easy to fix.  (Note: About
> 5 of these have had patches submitted, so this list is a bit out of
> date.)

Enclosed is a patch for these.  It's untested, as I don't have any of this
hardware, but all the fixes I made seemed relatively obvious.  Of course, by
saying this, I've doomed myself to at least 1 stupid mistake.

There are 3 spots I didn't fix, just because I'm not sure what the appropriate
fix is.  On in the ipv6 udp code, I'm unsure as to what the intent is.  The 2
rio code spots require some more serious restructuring to fix the debug message.

Patch is against 2.4.4-ac16

-Justin

--- linux-2.4.4-ac16/drivers/atm/iphase.c	Thu May 24 14:24:46 2001
+++ linux/drivers/atm/iphase.c	Thu May 24 14:43:25 2001
@@ -1318,12 +1318,12 @@
           if (ia_vcc == NULL)
           {
              atomic_inc(&vcc->stats->rx_err);
-             dev_kfree_skb_any(skb);
 #if LINUX_VERSION_CODE >= 0x20312
              atm_return(vcc, atm_guess_pdu2truesize(skb->len));
 #else
              atm_return(vcc, atm_pdu2truesize(skb->len));
 #endif
+             dev_kfree_skb_any(skb);
              goto INCR_DLE;
            }
           // get real pkt length  pwang_test
@@ -1334,7 +1334,6 @@
                               (skb->len - sizeof(struct cpcs_trailer))))
           {
              atomic_inc(&vcc->stats->rx_err);
-             dev_kfree_skb_any(skb);
              IF_ERR(printk("rx_dle_intr: Bad  AAL5 trailer %d (skb len %d)", 
                                                             length, skb->len);)
 #if LINUX_VERSION_CODE >= 0x20312
@@ -1342,6 +1341,7 @@
 #else
              atm_return(vcc, atm_pdu2truesize(skb->len));
 #endif 
+             dev_kfree_skb_any(skb);
              goto INCR_DLE;
           }
           skb_trim(skb, length);
diff -ru linux-2.4.4-ac16/drivers/block/cciss.c linux/drivers/block/cciss.c
--- linux-2.4.4-ac16/drivers/block/cciss.c	Thu May 24 14:24:47 2001
+++ linux/drivers/block/cciss.c	Thu May 24 14:28:26 2001
@@ -680,6 +680,7 @@
 			{
                         	kfree(buff);
 				cmd_free(h, c, 0);
+				return ( -EFAULT);
 			}
                 }
                 kfree(buff);
diff -ru linux-2.4.4-ac16/drivers/char/drm/gamma_dma.c linux/drivers/char/drm/gamma_dma.c
--- linux-2.4.4-ac16/drivers/char/drm/gamma_dma.c	Mon Dec 11 12:39:44 2000
+++ linux/drivers/char/drm/gamma_dma.c	Thu May 24 14:55:44 2001
@@ -555,12 +555,6 @@
 		current->state = TASK_RUNNING;
 		DRM_DEBUG("%d running\n", current->pid);
 		remove_wait_queue(&last_buf->dma_wait, &entry);
-		if (!retcode
-		    || (last_buf->list==DRM_LIST_PEND && !last_buf->pending)) {
-			if (!waitqueue_active(&last_buf->dma_wait)) {
-				drm_free_buffer(dev, last_buf);
-			}
-		}
 		if (retcode) {
 			DRM_ERROR("ctx%d w%d p%d c%d i%d l%d %d/%d\n",
 				  d->context,
@@ -571,6 +565,12 @@
 				  last_buf->list,
 				  last_buf->pid,
 				  current->pid);
+		}
+		if (!retcode
+		    || (last_buf->list==DRM_LIST_PEND && !last_buf->pending)) {
+			if (!waitqueue_active(&last_buf->dma_wait)) {
+				drm_free_buffer(dev, last_buf);
+			}
 		}
 	}
 	return retcode;
diff -ru linux-2.4.4-ac16/drivers/message/i2o/i2o_pci.c linux/drivers/message/i2o/i2o_pci.c
--- linux-2.4.4-ac16/drivers/message/i2o/i2o_pci.c	Thu May 24 14:24:52 2001
+++ linux/drivers/message/i2o/i2o_pci.c	Thu May 24 14:40:17 2001
@@ -254,7 +254,6 @@
 #else
 			i2o_delete_controller(c);
 #endif /* MODULE */	
-			kfree(c);
 			iounmap(mem);
 			return -EBUSY;
 		}
diff -ru linux-2.4.4-ac16/drivers/net/hamradio/bpqether.c linux/drivers/net/hamradio/bpqether.c
--- linux-2.4.4-ac16/drivers/net/hamradio/bpqether.c	Wed Apr 18 14:40:06 2001
+++ linux/drivers/net/hamradio/bpqether.c	Thu May 24 14:48:02 2001
@@ -191,9 +191,9 @@
 
 			unregister_netdevice(&bpq->axdev);
 			kfree(bpq);
+		} else {
+			bpq_prev = bpq;
 		}
-
-		bpq_prev = bpq;
 	}
 
 	restore_flags(flags);
diff -ru linux-2.4.4-ac16/drivers/net/wan/lapbether.c linux/drivers/net/wan/lapbether.c
--- linux-2.4.4-ac16/drivers/net/wan/lapbether.c	Wed Apr 18 14:40:07 2001
+++ linux/drivers/net/wan/lapbether.c	Thu May 24 14:47:10 2001
@@ -111,9 +111,9 @@
 			unregister_netdev(&lapbeth->axdev);
 			dev_put(lapbeth->ethdev);
 			kfree(lapbeth);
+		} else {
+			lapbeth_prev = lapbeth;
 		}
-
-		lapbeth_prev = lapbeth;
 	}
 
 	restore_flags(flags);
diff -ru linux-2.4.4-ac16/drivers/sound/cs4281/cs4281m.c linux/drivers/sound/cs4281/cs4281m.c
--- linux-2.4.4-ac16/drivers/sound/cs4281/cs4281m.c	Thu May 24 14:24:59 2001
+++ linux/drivers/sound/cs4281/cs4281m.c	Thu May 24 14:44:03 2001
@@ -4463,9 +4463,9 @@
 	unregister_sound_midi(s->dev_midi);
 	iounmap(s->pBA1);
 	iounmap(s->pBA0);
-	kfree(s);
 	pci_set_drvdata(pci_dev,NULL);
 	list_del(&s->list);
+	kfree(s);
 	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2, printk(KERN_INFO
 		 "cs4281: cs4281_remove()-: remove successful\n"));
 }
diff -ru linux-2.4.4-ac16/drivers/usb/serial/io_edgeport.c linux/drivers/usb/serial/io_edgeport.c
--- linux-2.4.4-ac16/drivers/usb/serial/io_edgeport.c	Thu May 24 14:25:01 2001
+++ linux/drivers/usb/serial/io_edgeport.c	Thu May 24 14:52:51 2001
@@ -944,7 +944,7 @@
 	}
 
 	if (status) {
-		dbg(__FUNCTION__" - nonzero write bulk status received: %d", urb->status);
+		dbg(__FUNCTION__" - nonzero write bulk status received: %d", status);
 		return;
 	}
 
diff -ru linux-2.4.4-ac16/net/ax25/ax25_ip.c linux/net/ax25/ax25_ip.c
--- linux-2.4.4-ac16/net/ax25/ax25_ip.c	Fri Dec 29 14:35:47 2000
+++ linux/net/ax25/ax25_ip.c	Thu May 24 14:51:43 2001
@@ -154,7 +154,6 @@
 			if (skb->sk != NULL)
 				skb_set_owner_w(ourskb, skb->sk);
 
-			kfree_skb(skb);
 
 			src_c = *src;
 			dst_c = *dst;
@@ -162,8 +161,10 @@
 			skb_pull(ourskb, AX25_HEADER_LEN - 1);	/* Keep PID */
 			skb->nh.raw = skb->data;
 
+			kfree_skb(skb);
+
 			ax25_send_frame(ourskb, ax25_dev->values[AX25_VALUES_PACLEN], &src_c, 
-&dst_c, route->digipeat, dev);
+					&dst_c, route->digipeat, dev);
 
 			return 1;
 		}
diff -ru linux-2.4.4-ac16/net/netrom/nr_dev.c linux/net/netrom/nr_dev.c
--- linux-2.4.4-ac16/net/netrom/nr_dev.c	Wed Apr 18 14:40:07 2001
+++ linux/net/netrom/nr_dev.c	Thu May 24 14:50:52 2001
@@ -116,10 +116,10 @@
 	if (!nr_route_frame(skbn, NULL)) {
 		kfree_skb(skbn);
 		stats->tx_errors++;
+	} else {
+		stats->tx_bytes += skbn->len;
 	}
-
 	stats->tx_packets++;
-	stats->tx_bytes += skbn->len;
 
 	return 1;
 }
diff -ru linux-2.4.4-ac16/net/wanrouter/wanmain.c linux/net/wanrouter/wanmain.c
--- linux-2.4.4-ac16/net/wanrouter/wanmain.c	Thu Apr 12 12:11:39 2001
+++ linux/net/wanrouter/wanmain.c	Thu May 24 14:48:49 2001
@@ -611,10 +611,10 @@
 
 	if (conf->data_size && conf->data){
 		if(conf->data_size > 128000 || conf->data_size < 0) {
-			kfree(conf);
 			printk(KERN_INFO 
 			    "%s: ERROR, Invalid firmware data size %i !\n",
 					wandev->name, conf->data_size);
+			kfree(conf);
 		        return -EINVAL;;
 		}
 
