Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUDNWQv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUDNWQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:16:50 -0400
Received: from palrel11.hp.com ([156.153.255.246]:27825 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261857AbUDNWQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:16:46 -0400
Date: Wed, 14 Apr 2004 15:16:45 -0700
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Fix handling of RD:RSP
Message-ID: <20040414221645.GC5434@bougret.hpl.hp.com>
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

ir265_rd_rsp_retry.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
	o [CORRECT] Fix handling of RD:RSP to be spec compliant


diff -u -p linux/net/irda/irlap_event.d0.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d0.c	Wed Apr  7 18:54:24 2004
+++ linux/net/irda/irlap_event.c	Wed Apr  7 18:54:33 2004
@@ -2236,6 +2236,14 @@ static int irlap_state_sclose(struct irl
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
 		break;
 	case RECV_DM_RSP:
+		/* IrLAP-1.1 p.82: in SCLOSE, S and I type RSP frames
+		 * shall take us down into default NDM state, like DM_RSP
+		 */
+	case RECV_RR_RSP:
+	case RECV_RNR_RSP:
+	case RECV_REJ_RSP:
+	case RECV_SREJ_RSP:
+	case RECV_I_RSP:
 		/* Always switch state before calling upper layers */
 		irlap_next_state(self, LAP_NDM);
 
@@ -2253,6 +2261,17 @@ static int irlap_state_sclose(struct irl
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
 		break;
 	default:
+		/* IrLAP-1.1 p.82: in SCLOSE, basically any received frame
+		 * with pf=1 shall restart the wd-timer and resend the rd:rsp
+		 */
+		if (info != NULL  &&  info->pf) {
+			del_timer(&self->wd_timer);
+			irlap_wait_min_turn_around(self, &self->qos_tx);
+			irlap_send_rd_frame(self);
+			irlap_start_wd_timer(self, self->wd_timeout);
+			break;		/* stay in SCLOSE */
+		}
+
 		IRDA_DEBUG(1, "%s(), Unknown event %d, (%s)\n", __FUNCTION__,
 			   event, irlap_event[event]);
 
