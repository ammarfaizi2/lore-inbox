Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271091AbTHGXqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271104AbTHGXqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:46:21 -0400
Received: from dp.samba.org ([66.70.73.150]:30666 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S271091AbTHGXqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:46:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16178.58516.629644.824883@cargo.ozlabs.ibm.com>
Date: Fri, 8 Aug 2003 09:45:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix PPP deflate compression
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two bugs that were stopping PPP compression (and in
particular, Deflate compression) from working.

The first bug was pointed out by Richard Moats.  In the conversion to
use pskb_may_pull, we ended up with a bogus test which basically meant
that the kernel driver never saw the CCP conf-ack packets and thus
never enabled compression.

The second bug crept in with the change of DEFLATE_MIN_SIZE from 8 to
9.  Changing that definition had the unfortunate side-effect of
changing the way that the code interpreted the encoded Deflate
parameter bytes.  This meant that we were using the wrong window size,
twice what we had actually negotiated with the peer.

Please apply.

Paul.

diff -urN linux-2.5/drivers/net/ppp_generic.c pmac-2.5/drivers/net/ppp_generic.c
--- linux-2.5/drivers/net/ppp_generic.c	2003-07-11 10:41:26.000000000 +1000
+++ pmac-2.5/drivers/net/ppp_generic.c	2003-08-07 14:59:13.000000000 +1000
@@ -2073,7 +2073,8 @@
 	case CCP_CONFACK:
 		if ((ppp->flags & (SC_CCP_OPEN | SC_CCP_UP)) != SC_CCP_OPEN)
 			break;
-		if (!pskb_may_pull(skb, len = CCP_LENGTH(dp)) + 2)
+		len = CCP_LENGTH(dp);
+		if (!pskb_may_pull(skb, len + 2))
 			return;		/* too short */
 		dp += CCP_HDRLEN;
 		len -= CCP_HDRLEN;
diff -urN linux-2.5/include/linux/ppp-comp.h pmac-2.5/include/linux/ppp-comp.h
--- linux-2.5/include/linux/ppp-comp.h	2003-06-15 12:12:49.000000000 +1000
+++ pmac-2.5/include/linux/ppp-comp.h	2003-08-07 16:10:06.000000000 +1000
@@ -185,10 +185,9 @@
 #define DEFLATE_MIN_SIZE	9
 #define DEFLATE_MAX_SIZE	15
 #define DEFLATE_METHOD_VAL	8
-#define DEFLATE_SIZE(x)		(((x) >> 4) + DEFLATE_MIN_SIZE)
+#define DEFLATE_SIZE(x)		(((x) >> 4) + 8)
 #define DEFLATE_METHOD(x)	((x) & 0x0F)
-#define DEFLATE_MAKE_OPT(w)	((((w) - DEFLATE_MIN_SIZE) << 4) \
-				 + DEFLATE_METHOD_VAL)
+#define DEFLATE_MAKE_OPT(w)	((((w) - 8) << 4) + DEFLATE_METHOD_VAL)
 #define DEFLATE_CHK_SEQUENCE	0
 
 /*
