Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265461AbTIEVqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbTIEVoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:44:00 -0400
Received: from palrel13.hp.com ([156.153.255.238]:26538 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264313AbTIEVn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:43:28 -0400
Date: Fri, 5 Sep 2003 14:43:20 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] LAP close race
Message-ID: <20030905214320.GE14233@bougret.hpl.hp.com>
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

ir2604_lap_close_race-5.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CRITICA] Fix a race condition when closing the LAP
		prevent the stack to open new LSAPs while we are killing them.


diff -u -p linux/net/irda/irlap.d2.c linux/net/irda/irlap.c
--- linux/net/irda/irlap.d2.c	Thu Sep  4 18:30:08 2003
+++ linux/net/irda/irlap.c	Thu Sep  4 18:30:37 2003
@@ -221,8 +221,11 @@ void irlap_close(struct irlap_cb *self)
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
-	irlap_disconnect_indication(self, LAP_DISC_INDICATION);
+	/* We used to send a LAP_DISC_INDICATION here, but this was
+	 * racy. This has been move within irlmp_unregister_link()
+	 * itself. Jean II */
 
+	/* Kill the LAP and all LSAPs on top of it */
 	irlmp_unregister_link(self->saddr);
 	self->notify.instance = NULL;
 
diff -u -p linux/net/irda/irlmp.d2.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d2.c	Thu Sep  4 18:30:15 2003
+++ linux/net/irda/irlmp.c	Thu Sep  4 18:30:37 2003
@@ -321,15 +321,23 @@ void irlmp_unregister_link(__u32 saddr)
 
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
+	/* We must remove ourselves from the hashbin *first*. This ensure
+	 * that no more LSAPs will be open on this link and no discovery
+	 * will be triggered anymore. Jean II */
 	link = hashbin_remove(irlmp->links, saddr, NULL);
 	if (link) {
 		ASSERT(link->magic == LMP_LAP_MAGIC, return;);
 
+		/* Kill all the LSAPs on this link. Jean II */
+		link->reason = LAP_DISC_INDICATION;
+		link->daddr = DEV_ADDR_ANY;
+		irlmp_do_lap_event(link, LM_LAP_DISCONNECT_INDICATION, NULL);
+
 		/* Remove all discoveries discovered at this link */
 		irlmp_expire_discoveries(irlmp->cachelog, link->saddr, TRUE);
 
+		/* Final cleanup */
 		del_timer(&link->idle_timer);
-
 		link->magic = 0;
 		kfree(link);
 	}
