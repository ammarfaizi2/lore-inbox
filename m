Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUKQX5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUKQX5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbUKQX4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:56:35 -0500
Received: from fmr17.intel.com ([134.134.136.16]:53900 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262554AbUKQXxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:53:35 -0500
Date: Wed, 17 Nov 2004 15:52:38 -0800
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: David Smithson <david@customfilmeffects.com>
cc: Andrew Morton <akpm@osdl.org>,
       "Williams, Mitch A" <mitch.a.williams@intel.com>,
       bonding-devel@lists.sourceforge.net, fubar@us.ibm.com,
       ctindel@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Bonding-devel] Re: [PATCH] Fix for 802.3ad shutdown issue
In-Reply-To: <1100728931.26492.9.camel@localhost>
Message-ID: <Pine.CYG.4.58.0411171550570.3284@mawilli1-desk2.amr.corp.intel.com>
References: <F3EE2A9EB4576F40AFE238EC0AC04BC504191A10@orsmsx402.amr.corp.intel.com>
 <20041102134303.44e715da.akpm@osdl.org> <1100728931.26492.9.camel@localhost>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Nov 2004, David Smithson wrote:

>
> Hi all.  Where could I get my hands on a nicely-formatted version of
> this patch?  I'm looking to patch my FC3 2.6.9 kernel.
>

Sorry for the mangling, David.  Here's the patch, hopefully looking a
little better now that I've figured out how get Pine talking through our
corporate net.
-Mitch Williams


diff -uprN -X dontdiff linux/drivers/net/bonding/bonding.h linux-2.6.9/drivers/net/bonding/bonding.h
--- linux/drivers/net/bonding/bonding.h	2004-10-18 14:53:44.000000000 -0700
+++ linux-2.6.9/drivers/net/bonding/bonding.h	2004-10-29 14:01:14.000000000 -0700
@@ -36,8 +36,8 @@
 #include "bond_3ad.h"
 #include "bond_alb.h"

-#define DRV_VERSION	"2.6.0"
-#define DRV_RELDATE	"January 14, 2004"
+#define DRV_VERSION	"2.6.1"
+#define DRV_RELDATE	"October 29, 2004"
 #define DRV_NAME	"bonding"
 #define DRV_DESCRIPTION	"Ethernet Channel Bonding Driver"

diff -uprN -X dontdiff linux/drivers/net/bonding/bond_main.c linux-2.6.9/drivers/net/bonding/bond_main.c
--- linux/drivers/net/bonding/bond_main.c	2004-10-18 14:55:21.000000000 -0700
+++ linux-2.6.9/drivers/net/bonding/bond_main.c	2004-10-29 14:01:37.000000000 -0700
@@ -469,6 +469,13 @@
  *	  * Add support for VLAN hardware acceleration capable slaves.
  *	  * Add capability to tag self generated packets in ALB/TLB modes.
  *	  Set version to 2.6.0.
+ * 2004/10/29 - Mitch Williams <mitch.a.williams at intel dot com>
+ *      - Fixed bug when unloading module while using 802.3ad.  If
+ *        spinlock debugging is turned on, this causes a stack dump.
+ *        Solution is to move call to dev_remov_pack outside of the
+ *        spinlock.
+ *        Set version to 2.6.1.
+ *
  */

 //#define BONDING_DEBUG 1
@@ -3566,15 +3573,15 @@ static int bond_close(struct net_device
 {
 	struct bonding *bond = bond_dev->priv;

-	write_lock_bh(&bond->lock);
-
-	bond_mc_list_destroy(bond);
-
 	if (bond->params.mode == BOND_MODE_8023AD) {
 		/* Unregister the receive of LACPDUs */
 		bond_unregister_lacpdu(bond);
 	}

+	write_lock_bh(&bond->lock);
+
+	bond_mc_list_destroy(bond);
+
 	/* signal timers not to re-arm */
 	bond->kill_timers = 1;

