Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbVALFgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbVALFgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVALFeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:34:31 -0500
Received: from ozlabs.org ([203.10.76.45]:2449 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263102AbVALF3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:29:47 -0500
Date: Wed, 12 Jan 2005 16:27:41 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, orinoco-devel@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [5/8] orinoco: Cleanup low-level hermes code
Message-ID: <20050112052741.GF30426@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	orinoco-devel@lists.sourceforge.net, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20050112052352.GA30426@localhost.localdomain> <20050112052434.GB30426@localhost.localdomain> <20050112052543.GC30426@localhost.localdomain> <20050112052630.GD30426@localhost.localdomain> <20050112052711.GE30426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112052711.GE30426@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apply some cleanups to the low-level orinoco handling code in
hermes.[ch].  This cleans up some error handling code, corrects an
error code to something more accurate, and also increases a timeout
value.  This last can (when the hardware plays up) cause long delays
with spinlocks held, which is bad, but is rather less prone to
prematurely giving up, which has the unfortunate habit of fatally
confusing the hardware in other ways :-/.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/hermes.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/hermes.c	2005-01-12 15:22:34.263633584 +1100
+++ working-2.6/drivers/net/wireless/hermes.c	2004-11-05 13:59:07.000000000 +1100
@@ -383,12 +383,17 @@
 		reg = hermes_read_reg(hw, oreg);
 	}
 
-	if (reg & HERMES_OFFSET_BUSY) {
-		return -ETIMEDOUT;
-	}
+	if (reg != offset) {
+		printk(KERN_ERR "hermes @ %p: BAP%d offset %s: "
+		       "reg=0x%x id=0x%x offset=0x%x\n", hw->iobase, bap,
+		       (reg & HERMES_OFFSET_BUSY) ? "timeout" : "error",
+		       reg, id, offset);
+
+		if (reg & HERMES_OFFSET_BUSY) {
+			return -ETIMEDOUT;
+		}
 
-	if (reg & HERMES_OFFSET_ERR) {
-		return -EIO;
+		return -EIO;		/* error or wrong offset */
 	}
 
 	return 0;
@@ -476,7 +481,7 @@
 	rlength = hermes_read_reg(hw, dreg);
 
 	if (! rlength)
-		return -ENOENT;
+		return -ENODATA;
 
 	rtype = hermes_read_reg(hw, dreg);
 
Index: working-2.6/drivers/net/wireless/hermes.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/hermes.h	2005-01-12 11:13:41.000000000 +1100
+++ working-2.6/drivers/net/wireless/hermes.h	2004-11-05 13:53:55.000000000 +1100
@@ -340,7 +340,7 @@
 #ifdef __KERNEL__
 
 /* Timeouts */
-#define HERMES_BAP_BUSY_TIMEOUT (500) /* In iterations of ~1us */
+#define HERMES_BAP_BUSY_TIMEOUT (10000) /* In iterations of ~1us */
 
 /* Basic control structure */
 typedef struct hermes {


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
