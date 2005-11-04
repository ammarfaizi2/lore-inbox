Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVKDRo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVKDRo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVKDRoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:44:25 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1214
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750758AbVKDRoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:44:24 -0500
Date: Fri, 04 Nov 2005 09:40:53 -0800 (PST)
Message-Id: <20051104.094053.118921373.davem@davemloft.net>
To: macro@linux-mips.org
Cc: gregkh@suse.de, stern@rowland.harvard.edu, linux-kernel@vger.kernel.org
Subject: Re: post-2.6.14 USB change breaks sparc64 boot
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.55.0511031738390.24109@blysk.ds.pg.gda.pl>
References: <20051103.093328.74747521.davem@davemloft.net>
	<Pine.LNX.4.55.0511031738390.24109@blysk.ds.pg.gda.pl>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Thu, 3 Nov 2005 17:46:20 +0000 (GMT)

> On Thu, 3 Nov 2005, David S. Miller wrote:
> 
> > Perhaps pci_fixup_final would be a more appropriate time to run this
> > USB host controller fixup?  One downside to this is that such calls
> > would not be invoked for hot-plugged USB host controller devices.
> 
>  This might actually want to be split to disable legacy stuff as soon as
> possible to prevent a flood of interrupts, sending SMIs and what not else.  
> That just requires poking at the PCI config space.  Whatever's the rest
> could be done later.  I guess hot-plugged USB host controllers are not
> configured for legacy support, so the early bits should not matter for
> them.

Would anyone mind if I pushed to Linus the following fix, at
least for now?  Thanks.

diff-tree 834843a8562e6614768d8c8b8a23d94d98af7360 (from 06024f217d607369f0ee0071034ebb03071d5fb2)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Fri Nov 4 09:38:18 2005 -0800

    [USB]: Make early handoff a final fixup instead of a header one.
    
    At header fixup time, it is not yet legal to ioremap() PCI
    device registers, yet that is what this quirk code needs to
    do.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index b1aa350..e46528c 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -316,4 +316,4 @@ static void __devinit quirk_usb_early_ha
 	else if (pdev->class == PCI_CLASS_SERIAL_USB_EHCI)
 		quirk_usb_disable_ehci(pdev);
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_early_handoff);
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_early_handoff);
