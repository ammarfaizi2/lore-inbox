Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWGQQnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWGQQnv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWGQQcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:26811 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750968AbWGQQcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:45 -0400
Date: Mon, 17 Jul 2006 09:26:40 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, romieu@fr.zoreil.com,
       Roy Marples <uberlord@gentoo.org>, Chris Wright <chrisw@sous-sol.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 11/45] via-velocity: the link is not correctly detected when the device starts
Message-ID: <20060717162640.GL4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="via-velocity-the-link-is-not-correctly-detected-when-the-device-starts.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Francois Romieu <romieu@fr.zoreil.com>

via-velocity: the link is not correctly detected when the device starts

The patch fixes http://bugzilla.kernel.org/show_bug.cgi?id=6711

Signed-off-by: Roy Marples <uberlord@gentoo.org>
Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/via-velocity.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.17.3.orig/drivers/net/via-velocity.c
+++ linux-2.6.17.3/drivers/net/via-velocity.c
@@ -248,6 +248,7 @@ static void velocity_free_rd_ring(struct
 static void velocity_free_tx_buf(struct velocity_info *vptr, struct velocity_td_info *);
 static int velocity_soft_reset(struct velocity_info *vptr);
 static void mii_init(struct velocity_info *vptr, u32 mii_status);
+static u32 velocity_get_link(struct net_device *dev);
 static u32 velocity_get_opt_media_mode(struct velocity_info *vptr);
 static void velocity_print_link_status(struct velocity_info *vptr);
 static void safe_disable_mii_autopoll(struct mac_regs __iomem * regs);
@@ -798,6 +799,9 @@ static int __devinit velocity_found1(str
 	if (ret < 0)
 		goto err_iounmap;
 
+	if (velocity_get_link(dev))
+		netif_carrier_off(dev);
+
 	velocity_print_info(vptr);
 	pci_set_drvdata(pdev, dev);
 	
@@ -1653,8 +1657,10 @@ static void velocity_error(struct veloci
 
 		if (linked) {
 			vptr->mii_status &= ~VELOCITY_LINK_FAIL;
+			netif_carrier_on(vptr->dev);
 		} else {
 			vptr->mii_status |= VELOCITY_LINK_FAIL;
+			netif_carrier_off(vptr->dev);
 		}
 
 		velocity_print_link_status(vptr);

--
