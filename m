Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265613AbUBJBLE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 20:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265622AbUBJBLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 20:11:03 -0500
Received: from palrel12.hp.com ([156.153.255.237]:13238 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265613AbUBJBKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 20:10:16 -0500
Date: Mon, 9 Feb 2004 17:10:15 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] IrLAP disconnection pending race
Message-ID: <20040210011015.GC673@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir260_irlap_discon_pend_race.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Don't drop IrLAP connection is we *just* received an
		incomming IrLMP connection request.


diff -u -p linux/include/net/irda/irlap.d4.h linux/include/net/irda/irlap.h
--- linux/include/net/irda/irlap.d4.h	Wed Jan  7 16:27:07 2004
+++ linux/include/net/irda/irlap.h	Wed Jan  7 16:29:31 2004
@@ -283,4 +283,10 @@ static inline int irlap_is_primary(struc
 	return(ret);
 }
 
+/* Clear a pending IrLAP disconnect. - Jean II */
+static inline void irlap_clear_disconnect(struct irlap_cb *self)
+{
+	self->disconnect_pending = FALSE;
+}
+
 #endif
diff -u -p linux/net/irda/irlmp_event.d4.c linux/net/irda/irlmp_event.c
--- linux/net/irda/irlmp_event.d4.c	Wed Jan  7 16:25:13 2004
+++ linux/net/irda/irlmp_event.c	Wed Jan  7 16:32:08 2004
@@ -391,6 +391,14 @@ static void irlmp_state_active(struct la
 		IRDA_DEBUG(4, "%s(), LS_CONNECT_REQUEST\n", __FUNCTION__);
 
 		/*
+		 * IrLAP may have a pending disconnect. We tried to close
+		 * IrLAP, but it was postponed because the link was
+		 * busy or we were still sending packets. As we now
+		 * need it, make sure it stays on. Jean II
+		 */
+		irlap_clear_disconnect(self->irlap);
+
+		/*
 		 *  LAP connection already active, just bounce back! Since we
 		 *  don't know which LSAP that tried to do this, we have to
 		 *  notify all LSAPs using this LAP, but that should be safe to
