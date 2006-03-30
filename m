Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWC3ISH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWC3ISH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWC3IRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:17:52 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:46675 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932102AbWC3IRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:17:43 -0500
Message-Id: <20060330081731.173381000@localhost.localdomain>
References: <20060330081605.085383000@localhost.localdomain>
Date: Thu, 30 Mar 2006 16:16:12 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Corey Minyard <minyard@mvista.com>,
       Ben Collins <bcollins@debian.org>, Roland Dreier <rolandd@cisco.com>,
       Alasdair Kergon <dm-devel@redhat.com>, Gerd Knorr <kraxel@bytesex.org>,
       Paul Mackerras <paulus@samba.org>, Frank Pavlic <fpavlic@de.ibm.com>,
       Matthew Wilcox <matthew@wil.cx>,
       Andrew Vasquez <linux-driver@qlogic.com>,
       Mikael Starvik <starvik@axis.com>, Greg Kroah-Hartman <greg@kroah.com>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 7/8] drivers: use list_move()
Content-Disposition: inline; filename=list-move-drivers.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the combination of list_del(A) and list_add(A, B)
to list_move(A, B) under drivers/.

CC: Corey Minyard <minyard@mvista.com>
CC: Ben Collins <bcollins@debian.org>
CC: Roland Dreier <rolandd@cisco.com>
CC: Alasdair Kergon <dm-devel@redhat.com>
CC: Gerd Knorr <kraxel@bytesex.org> 
CC: Paul Mackerras <paulus@samba.org>
CC: Frank Pavlic <fpavlic@de.ibm.com>
CC: Matthew Wilcox <matthew@wil.cx>
CC: Andrew Vasquez <linux-driver@qlogic.com>
CC: Mikael Starvik <starvik@axis.com>
CC: Greg Kroah-Hartman <greg@kroah.com>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 drivers/char/ipmi/ipmi_msghandler.c            |    7 +++----
 drivers/ieee1394/eth1394.c                     |    3 +--
 drivers/ieee1394/raw1394.c                     |    3 +--
 drivers/infiniband/core/mad.c                  |    9 +++------
 drivers/infiniband/core/mad_rmpp.c             |    3 +--
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |    7 +++----
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    6 ++----
 drivers/md/dm-raid1.c                          |    6 ++----
 drivers/media/video/cx88/cx88-video.c          |    6 ++----
 drivers/net/ppp_generic.c                      |    3 +--
 drivers/s390/net/lcs.c                         |    7 +++----
 drivers/scsi/ncr53c8xx.c                       |    3 +--
 drivers/scsi/qla2xxx/qla_init.c                |    3 +--
 drivers/usb/host/hc_crisv10.c                  |    3 +--
 drivers/usb/serial/whiteheat.c                 |   19 +++++++------------
 15 files changed, 32 insertions(+), 56 deletions(-)

Index: 2.6-git/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- 2.6-git.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ 2.6-git/drivers/char/ipmi/ipmi_msghandler.c
@@ -936,10 +936,9 @@ int ipmi_set_gets_events(ipmi_user_t use
 
 	if (val) {
 		/* Deliver any queued events. */
-		list_for_each_entry_safe(msg, msg2, &intf->waiting_events, link) {
-			list_del(&msg->link);
-			list_add_tail(&msg->link, &msgs);
-		}
+		list_for_each_entry_safe(msg, msg2, &intf->waiting_events, link)
+			list_move_tail(&msg->link, &msgs);
+
 	}
 
 	/* Hold the events lock while doing this to preserve order. */
Index: 2.6-git/drivers/ieee1394/eth1394.c
===================================================================
--- 2.6-git.orig/drivers/ieee1394/eth1394.c
+++ 2.6-git/drivers/ieee1394/eth1394.c
@@ -1079,8 +1079,7 @@ static inline int update_partial_datagra
 
 	/* Move list entry to beginnig of list so that oldest partial
 	 * datagrams percolate to the end of the list */
-	list_del(lh);
-	list_add(lh, pdgl);
+	list_move(lh, pdgl);
 
 	return 0;
 }
Index: 2.6-git/drivers/ieee1394/raw1394.c
===================================================================
--- 2.6-git.orig/drivers/ieee1394/raw1394.c
+++ 2.6-git/drivers/ieee1394/raw1394.c
@@ -132,8 +132,7 @@ static void free_pending_request(struct 
 static void __queue_complete_req(struct pending_request *req)
 {
 	struct file_info *fi = req->file_info;
-	list_del(&req->list);
-	list_add_tail(&req->list, &fi->req_complete);
+	list_move_tail(&req->list, &fi->req_complete);
 
 	up(&fi->complete_sem);
 	wake_up_interruptible(&fi->poll_wait_complete);
Index: 2.6-git/drivers/infiniband/core/mad.c
===================================================================
--- 2.6-git.orig/drivers/infiniband/core/mad.c
+++ 2.6-git/drivers/infiniband/core/mad.c
@@ -1648,11 +1648,9 @@ ib_find_send_mad(struct ib_mad_agent_pri
 void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr)
 {
 	mad_send_wr->timeout = 0;
-	if (mad_send_wr->refcount == 1) {
-		list_del(&mad_send_wr->agent_list);
-		list_add_tail(&mad_send_wr->agent_list,
+	if (mad_send_wr->refcount == 1)
+		list_move_tail(&mad_send_wr->agent_list,
 			      &mad_send_wr->mad_agent_priv->done_list);
-	}
 }
 
 static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
@@ -1977,8 +1975,7 @@ retry:
 		queued_send_wr = container_of(mad_list,
 					struct ib_mad_send_wr_private,
 					mad_list);
-		list_del(&mad_list->list);
-		list_add_tail(&mad_list->list, &send_queue->list);
+		list_move_tail(&mad_list->list, &send_queue->list);
 	}
 	spin_unlock_irqrestore(&send_queue->lock, flags);
 
Index: 2.6-git/drivers/infiniband/core/mad_rmpp.c
===================================================================
--- 2.6-git.orig/drivers/infiniband/core/mad_rmpp.c
+++ 2.6-git/drivers/infiniband/core/mad_rmpp.c
@@ -679,8 +679,7 @@ static void process_rmpp_ack(struct ib_m
 			goto out;
 
 		mad_send_wr->refcount++;
-		list_del(&mad_send_wr->agent_list);
-		list_add_tail(&mad_send_wr->agent_list,
+		list_move_tail(&mad_send_wr->agent_list,
 			      &mad_send_wr->mad_agent_priv->send_list);
 	}
 out:
Index: 2.6-git/drivers/infiniband/ulp/ipoib/ipoib_ib.c
===================================================================
--- 2.6-git.orig/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ 2.6-git/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -378,10 +378,9 @@ static void __ipoib_reap_ah(struct net_d
 
 	spin_lock_irq(&priv->lock);
 	list_for_each_entry_safe(ah, tah, &priv->dead_ahs, list)
-		if ((int) priv->tx_tail - (int) ah->last_send >= 0) {
-			list_del(&ah->list);
-			list_add_tail(&ah->list, &remove_list);
-		}
+		if ((int) priv->tx_tail - (int) ah->last_send >= 0)
+			list_move_tail(&ah->list, &remove_list);
+
 	spin_unlock_irq(&priv->lock);
 
 	list_for_each_entry_safe(ah, tah, &remove_list, list) {
Index: 2.6-git/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
===================================================================
--- 2.6-git.orig/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ 2.6-git/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -877,8 +877,7 @@ void ipoib_mcast_restart_task(void *dev_
 
 			if (mcast) {
 				/* Destroy the send only entry */
-				list_del(&mcast->list);
-				list_add_tail(&mcast->list, &remove_list);
+				list_move_tail(&mcast->list, &remove_list);
 
 				rb_replace_node(&mcast->rb_node,
 						&nmcast->rb_node,
@@ -903,8 +902,7 @@ void ipoib_mcast_restart_task(void *dev_
 			rb_erase(&mcast->rb_node, &priv->multicast_tree);
 
 			/* Move to the remove list */
-			list_del(&mcast->list);
-			list_add_tail(&mcast->list, &remove_list);
+			list_move_tail(&mcast->list, &remove_list);
 		}
 	}
 
Index: 2.6-git/drivers/md/dm-raid1.c
===================================================================
--- 2.6-git.orig/drivers/md/dm-raid1.c
+++ 2.6-git/drivers/md/dm-raid1.c
@@ -458,11 +458,9 @@ static int __rh_recovery_prepare(struct 
 	/* Already quiesced ? */
 	if (atomic_read(&reg->pending))
 		list_del_init(&reg->list);
+	else
+		list_move(&reg->list, &rh->quiesced_regions);
 
-	else {
-		list_del_init(&reg->list);
-		list_add(&reg->list, &rh->quiesced_regions);
-	}
 	spin_unlock_irq(&rh->region_lock);
 
 	return 1;
Index: 2.6-git/drivers/media/video/cx88/cx88-video.c
===================================================================
--- 2.6-git.orig/drivers/media/video/cx88/cx88-video.c
+++ 2.6-git/drivers/media/video/cx88/cx88-video.c
@@ -492,8 +492,7 @@ static int restart_video_queue(struct cx
 			return 0;
 		buf = list_entry(q->queued.next, struct cx88_buffer, vb.queue);
 		if (NULL == prev) {
-			list_del(&buf->vb.queue);
-			list_add_tail(&buf->vb.queue,&q->active);
+			list_move_tail(&buf->vb.queue, &q->active);
 			start_video_dma(dev, q, buf);
 			buf->vb.state = STATE_ACTIVE;
 			buf->count    = q->count++;
@@ -504,8 +503,7 @@ static int restart_video_queue(struct cx
 		} else if (prev->vb.width  == buf->vb.width  &&
 			   prev->vb.height == buf->vb.height &&
 			   prev->fmt       == buf->fmt) {
-			list_del(&buf->vb.queue);
-			list_add_tail(&buf->vb.queue,&q->active);
+			list_move_tail(&buf->vb.queue, &q->active);
 			buf->vb.state = STATE_ACTIVE;
 			buf->count    = q->count++;
 			prev->risc.jmp[1] = cpu_to_le32(buf->risc.dma);
Index: 2.6-git/drivers/net/ppp_generic.c
===================================================================
--- 2.6-git.orig/drivers/net/ppp_generic.c
+++ 2.6-git/drivers/net/ppp_generic.c
@@ -2580,8 +2580,7 @@ ppp_find_channel(int unit)
 
 	list_for_each_entry(pch, &new_channels, list) {
 		if (pch->file.index == unit) {
-			list_del(&pch->list);
-			list_add(&pch->list, &all_channels);
+			list_move(&pch->list, &all_channels);
 			return pch;
 		}
 	}
Index: 2.6-git/drivers/s390/net/lcs.c
===================================================================
--- 2.6-git.orig/drivers/s390/net/lcs.c
+++ 2.6-git/drivers/s390/net/lcs.c
@@ -1145,10 +1145,9 @@ list_modified:
 		}
 	}
 	/* re-insert all entries from the failed_list into ipm_list */
-	list_for_each_entry_safe(ipm, tmp, &failed_list, list) {
-		list_del_init(&ipm->list);
-		list_add_tail(&ipm->list, &card->ipm_list);
-	}
+	list_for_each_entry_safe(ipm, tmp, &failed_list, list)
+		list_move_tail(&ipm->list, &card->ipm_list);
+
 	spin_unlock_irqrestore(&card->ipm_lock, flags);
 	if (card->state == DEV_STATE_UP)
 		netif_wake_queue(card->dev);
Index: 2.6-git/drivers/scsi/ncr53c8xx.c
===================================================================
--- 2.6-git.orig/drivers/scsi/ncr53c8xx.c
+++ 2.6-git/drivers/scsi/ncr53c8xx.c
@@ -5118,8 +5118,7 @@ static void ncr_ccb_skipped(struct ncb *
 		cp->host_status &= ~HS_SKIPMASK;
 		cp->start.schedule.l_paddr = 
 			cpu_to_scr(NCB_SCRIPT_PHYS (np, select));
-		list_del(&cp->link_ccbq);
-		list_add_tail(&cp->link_ccbq, &lp->skip_ccbq);
+		list_move_tail(&cp->link_ccbq, &lp->skip_ccbq);
 		if (cp->queued) {
 			--lp->queuedccbs;
 		}
Index: 2.6-git/drivers/scsi/qla2xxx/qla_init.c
===================================================================
--- 2.6-git.orig/drivers/scsi/qla2xxx/qla_init.c
+++ 2.6-git/drivers/scsi/qla2xxx/qla_init.c
@@ -2273,8 +2273,7 @@ qla2x00_configure_fabric(scsi_qla_host_t
 			}
 
 			/* Remove device from the new list and add it to DB */
-			list_del(&fcport->list);
-			list_add_tail(&fcport->list, &ha->fcports);
+			list_move_tail(&fcport->list, &ha->fcports);
 
 			/* Login and update database */
 			qla2x00_fabric_dev_login(ha, fcport, &next_loopid);
Index: 2.6-git/drivers/usb/host/hc_crisv10.c
===================================================================
--- 2.6-git.orig/drivers/usb/host/hc_crisv10.c
+++ 2.6-git/drivers/usb/host/hc_crisv10.c
@@ -411,8 +411,7 @@ static inline void urb_list_move_last(st
 	urb_entry_t *urb_entry = __urb_list_entry(urb, epid);
 	assert(urb_entry);
 
-	list_del(&urb_entry->list);
-	list_add_tail(&urb_entry->list, &urb_list[epid]);
+	list_move_tail(&urb_entry->list, &urb_list[epid]);
 }
 
 /* Get the next urb in the list. */
Index: 2.6-git/drivers/usb/serial/whiteheat.c
===================================================================
--- 2.6-git.orig/drivers/usb/serial/whiteheat.c
+++ 2.6-git/drivers/usb/serial/whiteheat.c
@@ -685,19 +685,16 @@ static void whiteheat_close(struct usb_s
 		wrap = list_entry(tmp, struct whiteheat_urb_wrap, list);
 		urb = wrap->urb;
 		usb_kill_urb(urb);
-		list_del(tmp);
-		list_add(tmp, &info->rx_urbs_free);
-	}
-	list_for_each_safe(tmp, tmp2, &info->rx_urb_q) {
-		list_del(tmp);
-		list_add(tmp, &info->rx_urbs_free);
+		list_move(tmp, &info->rx_urbs_free);
 	}
+	list_for_each_safe(tmp, tmp2, &info->rx_urb_q)
+		list_move(tmp, &info->rx_urbs_free);
+
 	list_for_each_safe(tmp, tmp2, &info->tx_urbs_submitted) {
 		wrap = list_entry(tmp, struct whiteheat_urb_wrap, list);
 		urb = wrap->urb;
 		usb_kill_urb(urb);
-		list_del(tmp);
-		list_add(tmp, &info->tx_urbs_free);
+		list_move(tmp, &info->tx_urbs_free);
 	}
 	spin_unlock_irqrestore(&info->lock, flags);
 
@@ -1079,8 +1076,7 @@ static void whiteheat_write_callback(str
 		err("%s - Not my urb!", __FUNCTION__);
 		return;
 	}
-	list_del(&wrap->list);
-	list_add(&wrap->list, &info->tx_urbs_free);
+	list_move(&wrap->list, &info->tx_urbs_free);
 	spin_unlock(&info->lock);
 
 	if (urb->status) {
@@ -1372,8 +1368,7 @@ static int start_port_read(struct usb_se
 				wrap = list_entry(tmp, struct whiteheat_urb_wrap, list);
 				urb = wrap->urb;
 				usb_kill_urb(urb);
-				list_del(tmp);
-				list_add(tmp, &info->rx_urbs_free);
+				list_move(tmp, &info->rx_urbs_free);
 			}
 			break;
 		}

--
