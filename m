Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268655AbUIQKFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268655AbUIQKFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268658AbUIQKFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:05:31 -0400
Received: from fmr05.intel.com ([134.134.136.6]:64650 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S268655AbUIQKFP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:05:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH][resend] Update e1000 to use module_param()
Date: Fri, 17 Sep 2004 03:05:00 -0700
Message-ID: <468F3FDA28AA87429AD807992E22D07E028C8E99@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][resend] Update e1000 to use module_param()
Thread-Index: AcScC39eyxL29yW1TRmvRlbR0r4eEQAkghKQ
From: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
To: "Roland Dreier" <roland@topspin.com>, "cramerj" <cramerj@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>
Cc: <jgarzik@pobox.com>, <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Sep 2004 10:05:02.0202 (UTC) FILETIME=[CC256DA0:01C49C9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland:

Thanks for the patch. Based on some feedback from the community we had
developed a patch several weeks ago. We just submitted the patch. Please
let me know if you see any issues with it.

Thanks,
Ganesh.

-----Original Message-----
From: Roland Dreier [mailto:roland@topspin.com] 
Sent: Thursday, September 16, 2004 9:37 AM
To: cramerj; Ronciak, John; Venkatesan, Ganesh
Cc: jgarzik@pobox.com; netdev@oss.sgi.com; linux-kernel@vger.kernel.org
Subject: [PATCH][resend] Update e1000 to use module_param()

(resending because this seems to have been lost; e1000 still has mixed
MODULE_PARM and module_param use)

The change to e1000_main.c in

    ChangeSet@1.1722.32.6, 2004-05-27 13:44:06-04:00,
ganesh.venkatesan@intel.com
      [PATCH] e1000 7/7: Support for ethtool msglevel based error

added module_param(debug, ...) to e1000_main.c.  Since e1000_param.c
still uses MODULE_PARM(), this means that one gets

    e1000: Ignoring new-style parameters in presence of obsolete ones

when e1000 is loaded, so the debug parameter cannot even be set.

The patch below fixes this by updating e1000_param.c to use
module_param() as well.  Since module_param might make the parameters
visible in sysfs, I removed the __devinitdata notation from the
parameter arrays as well, just to be safe.

Thanks,
  Roland

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-2.6.8.1/drivers/net/e1000/e1000_param.c
===================================================================
--- linux-2.6.8.1.orig/drivers/net/e1000/e1000_param.c	2004-08-14
03:55:48.000000000 -0700
+++ linux-2.6.8.1/drivers/net/e1000/e1000_param.c	2004-08-15
08:16:31.109671753 -0700
@@ -55,9 +55,11 @@
  * over and over (plus this helps to avoid typo bugs).
  */
 
+static int param_count;
+
 #define E1000_PARAM(X, S) \
-static const int __devinitdata X[E1000_MAX_NIC + 1] = E1000_PARAM_INIT;
\
-MODULE_PARM(X, "1-" __MODULE_STRING(E1000_MAX_NIC) "i"); \
+static int X[E1000_MAX_NIC + 1] = E1000_PARAM_INIT; \
+module_param_array(X, int, param_count, 0); \
 MODULE_PARM_DESC(X, S);
 
 /* Transmit Descriptor Count
