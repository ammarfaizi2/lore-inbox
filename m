Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbVD2UPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbVD2UPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbVD2UO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:14:56 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:39066 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262941AbVD2UMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:12:39 -0400
Message-ID: <42729533.3080502@acm.org>
Date: Fri, 29 Apr 2005 15:12:35 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix a deadlock in the IPMI driver
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090002030802090800020104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090002030802090800020104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------090002030802090800020104
Content-Type: text/x-patch;
 name="ipmi-deadlock-fix-0426.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-deadlock-fix-0426.diff"

This patch corrects an issue with the IPMI message layer taking a lock and
calling  lower layer driver.  If an error occrues at the lower layer the lock
can be taken again causing a deadlock.	The lock is released before calling the
lower layer.

Signed-off-by: David Griego <dgriego@mvista.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.12-rc2/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.12-rc2.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.12-rc2/drivers/char/ipmi/ipmi_msghandler.c
@@ -2647,28 +2647,20 @@
 	deliver_response(msg);
 }
 
-static void
-send_from_recv_msg(ipmi_smi_t intf, struct ipmi_recv_msg *recv_msg,
-		   struct ipmi_smi_msg *smi_msg,
-		   unsigned char seq, long seqid)
+static struct ipmi_smi_msg *
+smi_from_recv_msg(ipmi_smi_t intf, struct ipmi_recv_msg *recv_msg,
+		  unsigned char seq, long seqid)
 {
-	if (!smi_msg)
-		smi_msg = ipmi_alloc_smi_msg();
+	struct ipmi_smi_msg *smi_msg = ipmi_alloc_smi_msg();
 	if (!smi_msg)
 		/* If we can't allocate the message, then just return, we
 		   get 4 retries, so this should be ok. */
-		return;
+		return NULL;
 
 	memcpy(smi_msg->data, recv_msg->msg.data, recv_msg->msg.data_len);
 	smi_msg->data_size = recv_msg->msg.data_len;
 	smi_msg->msgid = STORE_SEQ_IN_MSGID(seq, seqid);
 		
-	/* Send the new message.  We send with a zero priority.  It
-	   timed out, I doubt time is that critical now, and high
-	   priority messages are really only for messages to the local
-	   MC, which don't get resent. */
-	intf->handlers->sender(intf->send_info, smi_msg, 0);
-
 #ifdef DEBUG_MSGING
 	{
 		int m;
@@ -2678,6 +2670,7 @@
 		printk("\n");
 	}
 #endif
+	return smi_msg;
 }
 
 static void
@@ -2742,14 +2735,13 @@
 					intf->timed_out_ipmb_commands++;
 				spin_unlock(&intf->counter_lock);
 			} else {
+				struct ipmi_smi_msg *smi_msg;
 				/* More retries, send again. */
 
 				/* Start with the max timer, set to normal
 				   timer after the message is sent. */
 				ent->timeout = MAX_MSG_TIMEOUT;
 				ent->retries_left--;
-				send_from_recv_msg(intf, ent->recv_msg, NULL,
-						   j, ent->seqid);
 				spin_lock(&intf->counter_lock);
 				if (ent->recv_msg->addr.addr_type
 				    == IPMI_LAN_ADDR_TYPE)
@@ -2757,6 +2749,20 @@
 				else
 					intf->retransmitted_ipmb_commands++;
 				spin_unlock(&intf->counter_lock);
+				smi_msg = smi_from_recv_msg(intf, 
+						ent->recv_msg, j, ent->seqid);
+				if(!smi_msg)
+					continue;
+
+				spin_unlock_irqrestore(&(intf->seq_lock),flags);
+				/* Send the new message.  We send with a zero 
+				 * priority.  It timed out, I doubt time is 
+				 * that critical now, and high priority 
+				 * messages are really only for messages to the
+				 * local MC, which don't get resent. */
+				intf->handlers->sender(intf->send_info, 
+							smi_msg, 0);
+				spin_lock_irqsave(&(intf->seq_lock), flags);
 			}
 		}
 		spin_unlock_irqrestore(&(intf->seq_lock), flags);

--------------090002030802090800020104--
