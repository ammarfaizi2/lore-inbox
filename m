Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267757AbUBRTCJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267542AbUBRTCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:02:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22665 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267757AbUBRTCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:02:03 -0500
Date: Wed, 18 Feb 2004 19:01:56 +0000
From: Matthew Wilcox <willy@debian.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: Testing for extended PCI config space
Message-ID: <20040218190156.GN11824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's kind of tricky to figure out whether we can access the extended
config space or not.  Given that nobody checks the return value from
pci_read_config_*(), I don't know whether we'll be able to persuade them
to check pdev->cfg_size or not, but we can at least try to get it right.

/**
 * pci_cfg_space_size - get the configuration space size of the PCI device.
 *
 * Regular PCI devices have 256 bytes, but PCI-X 2 and PCI Express devices
 * have 4096 bytes.  Even if the device is capable, that doesn't mean we can
 * access it.  Maybe we don't have a way to generate extended config space
 * accesses, or the device is behind a reverse Express bridge.  So we try
 * reading the dword at 0x100 which must either be 0 or a valid extended
 * capability header.
 */
static int pci_cfg_space_size(struct pci_dev *dev)
{
        int pos;
        u32 status;

        pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
        if (!pos) {
                pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
                if (!pos)
                        goto fail;

                pci_read_config_dword(dev, pos + PCI_X_STATUS, &status);
                if (!(status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ)))
                        goto fail;
        }

        if (pci_read_config_dword(dev, 256, &status) != PCIBIOS_SUCCESSFUL)
                goto fail;
        if (status == 0xffffffff)
                goto fail;

        return PCI_CFG_SPACE_EXP_SIZE;

 fail:
        return PCI_CFG_SPACE_SIZE;
}


-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
