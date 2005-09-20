Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbVITM7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVITM7Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbVITM7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:59:25 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:3211 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S965005AbVITM7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:59:25 -0400
Date: Tue, 20 Sep 2005 16:59:02 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Continuing PCI and Yenta troubles in 2.6.13.1 and 2.6.14-rc1
Message-ID: <20050920165902.A27065@jurassic.park.msu.ru>
References: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de> <20050913063053.GA24158@suse.de> <20050913154529.C15709@jurassic.park.msu.ru> <200509201202.24318.koch@esa.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200509201202.24318.koch@esa.informatik.tu-darmstadt.de>; from koch@esa.informatik.tu-darmstadt.de on Tue, Sep 20, 2005 at 12:02:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 12:02:23PM +0200, Andreas Koch wrote:
> Thus, I believe there is still something rotten in the PCI code since the 
> 2.6.12-rc6 days.

Thanks a lot for the report.

You are right, and I believe the change that broke things is
introduction of pci_fixup_parent_subordinate_busnr()...

The patch here does two things:
- hunk #1 should fix the problems you've seen when you boot without
  additional "pci" kernel options;
- hunk #2 supposedly fixes boot with "pci=assign-busses" option which
  otherwise hangs Acer TM81xx machines as reported.

Please try this with and without "pci=assign-busses". If it boots,
I'd like to see 'lspci -vvx' for both cases.

Ivan.

--- 2.6.13.2/drivers/pci/probe.c	Mon Aug  8 12:20:28 2005
+++ linux/drivers/pci/probe.c	Tue Sep 20 16:17:23 2005
@@ -400,6 +400,12 @@ static void pci_enable_crs(struct pci_de
 static void __devinit pci_fixup_parent_subordinate_busnr(struct pci_bus *child, int max)
 {
 	struct pci_bus *parent = child->parent;
+
+	/* Attempts to fix that up are really dangerous unless
+	   we're going to re-assign all bus numbers. */
+	if (!pcibios_assign_all_busses())
+		return;
+
 	while (parent->parent && parent->subordinate < max) {
 		parent->subordinate = max;
 		pci_write_config_byte(parent->self, PCI_SUBORDINATE_BUS, max);
@@ -476,8 +482,18 @@ int __devinit pci_scan_bridge(struct pci
 		 * We need to assign a number to this bus which we always
 		 * do in the second pass.
 		 */
-		if (!pass)
+		if (!pass) {
+			if (pcibios_assign_all_busses())
+				/* Temporarily disable forwarding of the
+				   configuration cycles on all bridges in
+				   this bus segment to avoid possible
+				   conflicts in the second pass between two
+				   bridges programmed with overlapping
+				   bus ranges. */
+				pci_write_config_dword(dev, PCI_PRIMARY_BUS,
+						       buses & ~0xffffff);
 			return max;
+		}
 
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
