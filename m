Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbREXPMQ>; Thu, 24 May 2001 11:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262085AbREXPL5>; Thu, 24 May 2001 11:11:57 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:33548 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S262084AbREXPL4>; Thu, 24 May 2001 11:11:56 -0400
From: rjd@xyzzy.clara.co.uk
Message-Id: <200105241511.f4OFBnC27735@xyzzy.clara.co.uk>
Subject: SyncPPP IPCP/LCP loop problem and patch. Take 2
To: paulkf@microgate.com (Paul Fulghum)
Date: Thu, 24 May 2001 16:11:49 +0100 (BST)
Cc: rjd@xyzzy.clara.co.uk, paulus@samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <00bf01c0e2d9$de15b8c0$0c00a8c0@diemos> from "Paul Fulghum" at May 22, 2001 04:27:19 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum wrote:
> > 
> > Thanks but I've already tried that. You get a slightly different pattern
> > to the loop but it still loops.
> 
> What does the loop look like when the cfg-req is sent 1st?

Thanks for making me go back and look at it again guys. The reordering of
REQ and ACK does work to break the loop. Provided you apply the patch to
both ends of the link.

This is a much smaller patch, remains RFC1661 conformant and works against
all the platforms I've been able to test. Against an unpatched Linux it
still loops but no worse than before.


--- syncppp.c-orig	Mon May 21 10:35:59 2001
+++ syncppp.c	Thu May 24 15:55:55 2001
@@ -517,8 +517,10 @@
 		}
 		/* Send Configure-Ack packet. */
 		sp->pp_loopcnt = 0;
-		sppp_cp_send (sp, PPP_LCP, LCP_CONF_ACK,
-				h->ident, len-4, h+1);
+		if (sp->lcp.state != LCP_STATE_OPENED) {
+			sppp_cp_send (sp, PPP_LCP, LCP_CONF_ACK,
+					h->ident, len-4, h+1);
+		}
 		/* Change the state. */
 		switch (sp->lcp.state) {
 		case LCP_STATE_CLOSED:
@@ -534,7 +536,9 @@
 			sp->ipcp.state = IPCP_STATE_CLOSED;
 			/* Initiate renegotiation. */
 			sppp_lcp_open (sp);
-			/* An ACK has already been sent. */
+			/* Send ACK after our REQ in attempt to break loop */
+			sppp_cp_send (sp, PPP_LCP, LCP_CONF_ACK,
+					h->ident, len-4, h+1);
 			sp->lcp.state = LCP_STATE_ACK_SENT;
 			break;
 		}




A colleage has suggested that we should apply the same ordering in the NAK
path and for similar code in the stopped state.  Since I've not seen loops in
these areas I'm loath to make changes without the ability to test.
-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk
