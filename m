Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbTICQdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263947AbTICQdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:33:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30393 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263944AbTICQcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:32:54 -0400
Message-ID: <3F5617A9.4040603@pobox.com>
Date: Wed, 03 Sep 2003 12:32:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: davem@redhat.com
CC: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       benh@kernel.crashing.org
Subject: [PATCH] Re: 2.6.0-test4-mm5
References: <20030902231812.03fae13f.akpm@osdl.org> <20030903161200.GC23729@fs.tum.de>
In-Reply-To: <20030903161200.GC23729@fs.tum.de>
Content-Type: multipart/mixed;
 boundary="------------000005080608020209080704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000005080608020209080704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> It seems gcc is right, there are two .get_link members in this struct:
> 
> 
> <--  snip  -->
> 
> ...
> static struct ethtool_ops gem_ethtool_ops = {


David, would you look over this patch and apply/modify?

I would prefer to use the generic ethtool_op_get_link, because (a) 
sungem is already using netif_carrier_xxx, and (b) if ->get_link ever 
returns an incorrect value, that signals a netif_carrier_xxx bug exists.

As a tangent, gem_pcs_interrupt appears to call netif_carrier_xxx but 
not set gem->lstate.  David/Ben, is that a bug?

Thanks,

	Jeff



--------------000005080608020209080704
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/net/sungem.c 1.44 vs edited =====
--- 1.44/drivers/net/sungem.c	Sun Aug 24 08:58:18 2003
+++ edited/drivers/net/sungem.c	Wed Sep  3 12:28:30 2003
@@ -2416,13 +2416,6 @@
 	return 0;
 }
 
-static u32 gem_get_link(struct net_device *dev)
-{
-	struct gem *gp = dev->priv;
-
-	return (gp->lstate == link_up);
-}
-
 static u32 gem_get_msglevel(struct net_device *dev)
 {
 	struct gem *gp = dev->priv;
@@ -2441,7 +2434,6 @@
 	.get_settings		= gem_get_settings,
 	.set_settings		= gem_set_settings,
 	.nway_reset		= gem_nway_reset,
-	.get_link		= gem_get_link,
 	.get_msglevel		= gem_get_msglevel,
 	.set_msglevel		= gem_set_msglevel,
 };

--------------000005080608020209080704--

