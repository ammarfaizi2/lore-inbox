Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUIVRte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUIVRte (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 13:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUIVRtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 13:49:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3500 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266137AbUIVRta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 13:49:30 -0400
Date: Wed, 22 Sep 2004 18:49:29 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Subject: The new PCI fixup code ate my IDE controller
Message-ID: <20040922174929.GP16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The new DECLARE_PCI_FIXUP_HEADER() now makes the order of fixups depend
on link order.  This is a bad thing because it's now one more thing that
link order is used to determine.  Eventually, we're going to have a knot
where you can't move link order to make everything work.

The specific problem here is that quirk_ide_bases() is called before
superio_fixup_pci().  This is only a problem on PA-RISC.  I can see
a few solutions to this.  First, we can move the whole suckyio driver
to arch/parisc, ensuring it gets linked before drivers/pci.  Second,
just move the DECLARE_PCI_FIXUP_HEADER to arch/parisc.  Third, link
drivers/parisc ahead of drivers/pci (what other fun ordering problems
might we have?)  Fourth, move the IDE quirk from drivers/pci/quirks.c
to drivers/ide somewhere (which is linked after drivers/parisc so would
happen to fix our problem).  Fifth, back out the quirk changes.  Sixth,
change the pci fixup stuff to sort the quirks by vendor ID (PCI_ANY_ID
sorts after any other ID).

Suggestions?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
