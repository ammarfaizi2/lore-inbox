Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbULSQed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbULSQed (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 11:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbULSQed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 11:34:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50706 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261307AbULSQe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 11:34:26 -0500
Date: Sun, 19 Dec 2004 17:34:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sf.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Network Development Mailing List <netdev@oss.sgi.com>
Subject: [2.6 patch] bluetooth/cmtp/capi.c: make a function static
Message-ID: <20041219163421.GB21288@stusta.de>
References: <20041214041352.GZ23151@stusta.de> <1103009649.2143.65.camel@pegasus> <20041219160758.GY21288@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041219160758.GY21288@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


diffstat output:
 net/bluetooth/cmtp/capi.c |   28 +++++++++++++---------------
 net/bluetooth/cmtp/cmtp.h |    1 -
 2 files changed, 13 insertions(+), 16 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/net/bluetooth/cmtp/cmtp.h.old	2004-12-18 01:44:36.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/cmtp/cmtp.h	2004-12-18 02:28:40.000000000 +0100
@@ -120,7 +120,6 @@
 void cmtp_detach_device(struct cmtp_session *session);
 
 void cmtp_recv_capimsg(struct cmtp_session *session, struct sk_buff *skb);
-void cmtp_send_capimsg(struct cmtp_session *session, struct sk_buff *skb);
 
 static inline void cmtp_schedule(struct cmtp_session *session)
 {
--- linux-2.6.10-rc3-mm1-full/net/bluetooth/cmtp/capi.c.old	2004-12-18 01:44:43.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/cmtp/capi.c	2004-12-19 17:09:00.000000000 +0100
@@ -139,6 +139,19 @@
 	return session->msgnum;
 }
 
+static void cmtp_send_capimsg(struct cmtp_session *session, struct sk_buff *skb)
+{
+	struct cmtp_scb *scb = (void *) skb->cb;
+
+	BT_DBG("session %p skb %p len %d", session, skb, skb->len);
+
+	scb->id = -1;
+	scb->data = (CAPIMSG_COMMAND(skb->data) == CAPI_DATA_B3);
+
+	skb_queue_tail(&session->transmit, skb);
+
+	cmtp_schedule(session);
+}
 
 static void cmtp_send_interopmsg(struct cmtp_session *session,
 					__u8 subcmd, __u16 appl, __u16 msgnum,
@@ -337,21 +350,6 @@
 	capi_ctr_handle_message(ctrl, appl, skb);
 }
 
-void cmtp_send_capimsg(struct cmtp_session *session, struct sk_buff *skb)
-{
-	struct cmtp_scb *scb = (void *) skb->cb;
-
-	BT_DBG("session %p skb %p len %d", session, skb, skb->len);
-
-	scb->id = -1;
-	scb->data = (CAPIMSG_COMMAND(skb->data) == CAPI_DATA_B3);
-
-	skb_queue_tail(&session->transmit, skb);
-
-	cmtp_schedule(session);
-}
-
-
 static int cmtp_load_firmware(struct capi_ctr *ctrl, capiloaddata *data)
 {
 	BT_DBG("ctrl %p data %p", ctrl, data);

