Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133095AbRDVA7J>; Sat, 21 Apr 2001 20:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133103AbRDVA67>; Sat, 21 Apr 2001 20:58:59 -0400
Received: from elmls01.ce.mediaone.net ([24.131.128.25]:6335 "EHLO
	elmls01.ce.mediaone.net") by vger.kernel.org with ESMTP
	id <S133095AbRDVA6n>; Sat, 21 Apr 2001 20:58:43 -0400
Message-ID: <3AE22CEC.8C000984@mediaone.net>
Date: Sat, 21 Apr 2001 19:59:24 -0500
From: Tim Wilson <timwilson@mediaone.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH] ppp_generic, kernel 2.4.3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An astute observer  pointed out that my patch had an extra closing */ in
it. I won't even attempt to explain how that happened, but believe me, I
am suitably mortified.  Can I get a mulligan?

Here is the correct patch, along with the original text.



This patch corrects a bug in CCP establishment which can result in a
major security hole.

The bug can cause PPP to NOT install and use a compressor  module for
sending,  even though the compressor is sucessfully negotiated by CCP.
Since encryption is sometimes implemented as a compressor module (e.g.
MPPE), this bug can cause PPP to send cleartext even though encryption
appears to be sucessfully negotiated.

The bug does not always show up--it depends on the order of CCP messages

exchanged during establishment, and therefore is not deterministic.

The specific problem is handling a sent or received CCP ConfReq. A sent
ConfReq should reset my decompressor; a received ConfReq should reset my

compressor. The original code had this logic exactly reversed.

I am not currently subscribed to the list so please respond directly.




--- drivers/net/ppp_generic.c.orig Sat Apr 21 13:33:00 2001
+++ drivers/net/ppp_generic.c Sat Apr 21 19:41:59 2001
@@ -1967,15 +1967,30 @@

  switch (CCP_CODE(dp)) {
  case CCP_CONFREQ:
+
+  /* A ConfReq starts negotiation of compression
+   * in one direction of transmission,
+   * and hence brings it down...but which way?
+   *
+   * Remember:
+   * A ConfReq indicates what the sender would like to receive
+   */
+  if(inbound)
+   /* He is proposing what I should send */
+   ppp->xstate &= ~SC_COMP_RUN;
+  else
+   /* I am proposing what he should send */
+   ppp->rstate &= ~SC_DECOMP_RUN;
+
+  break;
+
  case CCP_TERMREQ:
  case CCP_TERMACK:
   /*
-   * CCP is going down - disable compression.
+   * CCP is going down, both directions of transmission
    */
-  if (inbound)
-   ppp->rstate &= ~SC_DECOMP_RUN;
-  else
-   ppp->xstate &= ~SC_COMP_RUN;
+  ppp->rstate &= ~SC_DECOMP_RUN;
+  ppp->xstate &= ~SC_COMP_RUN;
   break;

  case CCP_CONFACK:


