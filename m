Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVFHWiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVFHWiX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 18:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVFHWiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 18:38:19 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:10639 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262202AbVFHWhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 18:37:10 -0400
Date: Thu, 9 Jun 2005 02:36:39 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050609023639.A7067@jurassic.park.msu.ru>
References: <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org> <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org> <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org> <20050604155742.GA14384@erebor.esa.informatik.tu-darmstadt.de> <20050605204645.A28422@jurassic.park.msu.ru> <20050606002739.GA943@erebor.esa.informatik.tu-darmstadt.de> <20050606184335.A30338@jurassic.park.msu.ru> <20050608173409.GA32004@erebor.esa.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050608173409.GA32004@erebor.esa.informatik.tu-darmstadt.de>; from koch@esa.informatik.tu-darmstadt.de on Wed, Jun 08, 2005 at 07:34:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 07:34:09PM +0200, Andreas Koch wrote:
> However, after pci_assign_unassigned_resources() has been called, the
> MEM and PREFETCH regions of the bridge 0000:00:1e.0 (bridge 1) _remain_
> invalid at 0x00000000.

I believe it was _IO_ and PREFETCH (unused windows of that bridge).
Indeed, IO at 0 is fatal...

Here is additional patch which ensures unused windows of the transparent
bridge are disabled. 

Ivan.

--- linux/drivers/pci/setup-bus.c~	Sun Jun  5 18:37:57 2005
+++ linux/drivers/pci/setup-bus.c	Thu Jun  9 01:28:42 2005
@@ -156,7 +156,7 @@ pci_setup_bridge(struct pci_bus *bus)
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	pcibios_resource_to_bus(bridge, &region, &b_res[0]);
-	if (b_res[0].flags & IORESOURCE_IO) {
+	if ((b_res[0].flags & IORESOURCE_IO) && (region.end > region.start)) {
 		pci_read_config_dword(bridge, PCI_IO_BASE, &l);
 		l &= 0xffff0000;
 		l |= (region.start >> 8) & 0x00f0;
@@ -182,7 +182,7 @@ pci_setup_bridge(struct pci_bus *bus)
 	/* Set up the top and bottom of the PCI Memory segment
 	   for this bus. */
 	pcibios_resource_to_bus(bridge, &region, &b_res[1]);
-	if (b_res[1].flags & IORESOURCE_MEM) {
+	if ((b_res[1].flags & IORESOURCE_MEM) && (region.end > region.start)) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		DBG(KERN_INFO "  MEM window: %08lx-%08lx\n",
@@ -201,7 +201,8 @@ pci_setup_bridge(struct pci_bus *bus)
 
 	/* Set up PREF base/limit. */
 	pcibios_resource_to_bus(bridge, &region, &b_res[2]);
-	if (b_res[2].flags & IORESOURCE_PREFETCH) {
+	if ((b_res[2].flags & IORESOURCE_PREFETCH) &&
+	    (region.end > region.start)) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		DBG(KERN_INFO "  PREFETCH window: %08lx-%08lx\n",
