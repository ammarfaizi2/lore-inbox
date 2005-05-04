Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVEDArn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVEDArn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 20:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVEDArn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 20:47:43 -0400
Received: from [203.16.207.254] ([203.16.207.254]:6585 "EHLO
	trantor.sbss.com.au") by vger.kernel.org with ESMTP id S261947AbVEDArl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 20:47:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] 2.6.11 fix PROMISC/bridging in TLAN driver
Date: Wed, 4 May 2005 10:47:41 +1000
Message-ID: <AEC6C66638C05B468B556EA548C1A77D7A092B@trantor.int.sbss.com.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.11 fix PROMISC/bridging in TLAN driver
Thread-Index: AcVQQuBWdhsL5vjnTrCacwP1F9qJyw==
From: "James Harper" <james.harper@bendigoit.com.au>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm re-sending this in the hope that someone will pick it up. I have
made several attempts to contact the maintainer without success,
although none recently.

This has been a problem for me for ages. When using bridging, the driver
is switched into promiscuous mode before the link init is complete. The
init complete routine then resets the promisc bit on the card so the
kernel still thinks the card is in promiscuous mode but the card isn't.
doh.

I think this bug only shows up in bridging when the bridge is started at
boot time (or something else that sets promisc at the same time the card
was started). If promisc is enabled later it works.

Here's a trivial (and hopefully correct) patch that works for me. It
just calls the promisc/multicast setup routine after init.

James


--- linux/drivers/net/tlan.c    2004-07-05 12:10:31.000000000 +1000
+++ linux-2.4.26-xen0/drivers/net/tlan.c        2004-07-05
11:43:48.000000000 +1000
@@ -2378,6 +2378,7 @@
                TLan_SetTimer( dev, (10*HZ), TLAN_TIMER_FINISH_RESET );
                return;
        }
+       TLan_SetMulticastList(dev);

 } /* TLan_FinishReset */

