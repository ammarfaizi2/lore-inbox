Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268312AbUIPQni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268312AbUIPQni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268229AbUIPQhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:37:35 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:50155 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268463AbUIPQgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:36:37 -0400
To: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com
Cc: jgarzik@pobox.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH][resend] Update e1000 to use module_param()
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Thu, 16 Sep 2004 09:36:35 -0700
Message-ID: <52oek6tbl8.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Sep 2004 16:36:35.0103 (UTC) FILETIME=[5497E2F0:01C49C0B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resending because this seems to have been lost; e1000 still has mixed
MODULE_PARM and module_param use)

The change to e1000_main.c in

    ChangeSet@1.1722.32.6, 2004-05-27 13:44:06-04:00, ganesh.venkatesan@intel.com
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
--- linux-2.6.8.1.orig/drivers/net/e1000/e1000_param.c	2004-08-14 03:55:48.000000000 -0700
+++ linux-2.6.8.1/drivers/net/e1000/e1000_param.c	2004-08-15 08:16:31.109671753 -0700
@@ -55,9 +55,11 @@
  * over and over (plus this helps to avoid typo bugs).
  */
 
+static int param_count;
+
 #define E1000_PARAM(X, S) \
-static const int __devinitdata X[E1000_MAX_NIC + 1] = E1000_PARAM_INIT; \
-MODULE_PARM(X, "1-" __MODULE_STRING(E1000_MAX_NIC) "i"); \
+static int X[E1000_MAX_NIC + 1] = E1000_PARAM_INIT; \
+module_param_array(X, int, param_count, 0); \
 MODULE_PARM_DESC(X, S);
 
 /* Transmit Descriptor Count
