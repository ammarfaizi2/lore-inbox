Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132843AbRDUTXf>; Sat, 21 Apr 2001 15:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132845AbRDUTXV>; Sat, 21 Apr 2001 15:23:21 -0400
Received: from elmls01.ce.mediaone.net ([24.131.128.25]:12695 "EHLO
	elmls01.ce.mediaone.net") by vger.kernel.org with ESMTP
	id <S132843AbRDUTXG>; Sat, 21 Apr 2001 15:23:06 -0400
Message-ID: <3AE1DE45.7AF13EFC@mediaone.net>
Date: Sat, 21 Apr 2001 14:23:50 -0500
From: Tim Wilson <timwilson@mediaone.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: [PATCH] ppp_generic, kernel 2.4.
Content-Type: multipart/mixed;
 boundary="------------C2F2EA1935059FCED643E3E1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C2F2EA1935059FCED643E3E1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

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

Please forgive if I make a procedural error in submitting this patch;
I'm trying to follow the instructions in the FAQ but this is my first
time. The FAQ said to cc Linus and/or Alan Cox for security issues, so I
am doing that..

I am not currently subscribed to the list so please respond directly.

The patch is attached and also shown below.



--- drivers/net/ppp_generic.c.orig Sat Apr 21 13:33:00 2001
+++ drivers/net/ppp_generic.c Sat Apr 21 13:44:38 2001
@@ -1967,15 +1967,30 @@

  switch (CCP_CODE(dp)) {
  case CCP_CONFREQ:
+
+  /* A ConfReq starts negotiation of compression
+   * in one direction of transmission,
+   * and hence brings it down...but which way?
+   *
+   * Remember:
+   * A ConfReq indicates what the sender would like to receive */
+   */
+  if(inbound)
+   /* He is proposing what I should send */
+   ppp->xstate &= ~SC_COMP_RUN;
+  else
+   /* I am proposing to what he should send */
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




--------------C2F2EA1935059FCED643E3E1
Content-Type: text/plain; charset=us-ascii;
 name="ccp_negotiate_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ccp_negotiate_fix.patch"

--- drivers/net/ppp_generic.c.orig	Sat Apr 21 13:33:00 2001
+++ drivers/net/ppp_generic.c	Sat Apr 21 13:44:38 2001
@@ -1967,15 +1967,30 @@
 
 	switch (CCP_CODE(dp)) {
 	case CCP_CONFREQ:
+
+		/* A ConfReq starts negotiation of compression 
+		 * in one direction of transmission,
+		 * and hence brings it down...but which way?
+		 *
+		 * Remember:
+		 * A ConfReq indicates what the sender would like to receive */
+		 */
+		if(inbound)
+			/* He is proposing what I should send */
+			ppp->xstate &= ~SC_COMP_RUN;
+		else	
+			/* I am proposing to what he should send */
+			ppp->rstate &= ~SC_DECOMP_RUN;
+		
+		break;
+		
 	case CCP_TERMREQ:
 	case CCP_TERMACK:
 		/*
-		 * CCP is going down - disable compression.
+		 * CCP is going down, both directions of transmission 
 		 */
-		if (inbound)
-			ppp->rstate &= ~SC_DECOMP_RUN;
-		else
-			ppp->xstate &= ~SC_COMP_RUN;
+		ppp->rstate &= ~SC_DECOMP_RUN;
+		ppp->xstate &= ~SC_COMP_RUN;
 		break;
 
 	case CCP_CONFACK:

--------------C2F2EA1935059FCED643E3E1--

