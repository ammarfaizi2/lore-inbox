Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265913AbUGECZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbUGECZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 22:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265916AbUGECZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 22:25:28 -0400
Received: from gaia.sbss.com.au ([203.16.207.1]:62000 "EHLO
	trantor.sbss.com.au") by vger.kernel.org with ESMTP id S265913AbUGECZ1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 22:25:27 -0400
Content-class: urn:content-classes:message
Subject: [PATCH] 2.4.26 fix PROMISC/bridging in TLAN driver
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Mon, 5 Jul 2004 12:25:27 +1000
Content-Transfer-Encoding: 8BIT
Message-ID: <AEC6C66638C05B468B556EA548C1A77D2500D2@trantor>
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.4.26 fix PROMISC/bridging in TLAN driver
Thread-Index: AcRiN1E1vJHwXSzMQdSQnI33XWx6vg==
From: "James Harper" <JamesH@bendigoit.com.au>
To: <linux-kernel@vger.kernel.org>
Cc: <chessman@tux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

