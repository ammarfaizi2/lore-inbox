Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVDUNH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVDUNH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 09:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVDUNH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 09:07:56 -0400
Received: from mail.suse.de ([195.135.220.2]:24248 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261355AbVDUNHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 09:07:36 -0400
Date: Thu, 21 Apr 2005 15:07:35 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linus@osdl.org
Subject: fix for ISDN ippp filtering
Message-ID: <20050421130735.GA23653@pingi3.kke.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@osdl.org,
	linus@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We do not longer use DLT_LINUX_SLL for activ/pass filters but DLT_PPP_WITHDIRECTION
witch need 1 as outbound flag.
Please apply.

Signed-off-by: Karsten Keil <kkeil@suse.de>

diff -urN linux-2.6.12-rc2.org/drivers/isdn/i4l/isdn_ppp.c linux-2.6.12-rc2/drivers/isdn/i4l/isdn_ppp.c
--- linux-2.6.12-rc2.org/drivers/isdn/i4l/isdn_ppp.c	2005-04-20 16:01:07.070809128 +0200
+++ linux-2.6.12-rc2/drivers/isdn/i4l/isdn_ppp.c	2005-04-20 18:31:28.533367073 +0200
@@ -1151,7 +1151,7 @@
 	{
 		u_int16_t *p = (u_int16_t *) skb->data;
 
-		*p = 0;	/* indicate inbound in DLT_LINUX_SLL */
+		*p = 0;	/* indicate inbound */
 	}
 
 	if (is->pass_filter
@@ -1293,12 +1293,12 @@
 	/* check if we should pass this packet
 	 * the filter instructions are constructed assuming
 	 * a four-byte PPP header on each packet */
-	skb_push(skb, 4);
+	*skb_push(skb, 4) = 1; /* indicate outbound */
 
 	{
 		u_int16_t *p = (u_int16_t *) skb->data;
 
-		*p++ = htons(4); /* indicate outbound in DLT_LINUX_SLL */
+		p++;
 		*p   = htons(proto);
 	}
 
@@ -1491,12 +1491,12 @@
 	 * temporarily remove part of the fake header stuck on
 	 * earlier.
 	 */
-	skb_pull(skb, IPPP_MAX_HEADER - 4);
+	*skb_pull(skb, IPPP_MAX_HEADER - 4) = 1; /* indicate outbound */
 
 	{
 		u_int16_t *p = (u_int16_t *) skb->data;
 
-		*p++ = htons(4);	/* indicate outbound in DLT_LINUX_SLL */
+		p++;
 		*p   = htons(proto);
 	}
 	

-- 
Karsten Keil
SuSE Labs
ISDN development
