Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbVKCRff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbVKCRff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbVKCRff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:35:35 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:42380
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030389AbVKCRfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:35:34 -0500
Date: Thu, 03 Nov 2005 09:33:28 -0800 (PST)
Message-Id: <20051103.093328.74747521.davem@davemloft.net>
To: gregkh@suse.de
CC: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org
Subject: post-2.6.14 USB change breaks sparc64 boot
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This change:

diff-tree 478a3bab8c87a9ba4a4ba338314e32bb0c378e62 (from 46f116eab81b21c6ae8c4f169498c632b1f94bf1)
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Wed Oct 19 12:52:02 2005 -0400

    [PATCH] USB: Always do usb-handoff
    
    This revised patch (as586b) makes usb-handoff permanently true and no
    longer a kernel boot parameter.  It also removes the piix3_usb quirk code;
    that was nothing more than an early version of the USB handoff code
    (written at a time when Intel's PIIX3 was about the only motherboard with
    USB support).  And it adds identifiers for the three PCI USB controller
    classes to pci_ids.h.
    
    Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

breaks sparc64 bootup badly on machines with USB host controllers.

The reason is that this fixup is run as a PCI header fixup, but at
that time it is not yet legal to do ioremap() on the PCI device's
resources.  This USB fixup does ioremap() calls so that it can program
a few of the host controller registers during bootup.  It fails
spectacularly since the PCI device resource values haven't been been
adjusted by the sparc64 PCI layer yet.

The platform layer first needs a chance to fixup the pdev->resource[]
values to the format the ioremap() expects, and this is done after the
PCI header fixups are executed.  On platforms where this matters, such
adjustments are made immediately after the pci_scan_bus() invocation.

So ioremap() calls during pci_scan_bus() are pretty much not allowed.

Perhaps pci_fixup_final would be a more appropriate time to run this
USB host controller fixup?  One downside to this is that such calls
would not be invoked for hot-plugged USB host controller devices.
