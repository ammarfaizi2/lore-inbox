Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVBQACm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVBQACm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 19:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVBQACR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 19:02:17 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45768 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262138AbVBQABc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 19:01:32 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Linux Kernel list <linux-kernel@vger.kernel.org>, jonsmirl@gmail.com
Subject: pci_map_rom bug?
Date: Wed, 16 Feb 2005 16:00:47 -0800
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502161600.48252.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon, it looks like the loop at the bottom of pci_map_rom is busted?

        do {
                void __iomem *pds;
                /* Standard PCI ROMs start out with these bytes 55 AA */
                if (readb(image) != 0x55)
                        break;
                if (readb(image + 1) != 0xAA)
                        break;
                /* get the PCI data structure and check its signature */
                pds = image + readw(image + 24);
                if (readb(pds) != 'P')
                        break;
                if (readb(pds + 1) != 'C')
                        break;
                if (readb(pds + 2) != 'I')
                        break;
                if (readb(pds + 3) != 'R')
                        break;
                last_image = readb(pds + 21) & 0x80;
                /* this length is reliable */
                image += readw(pds + 16) * 512;
        } while (!last_image);

It looks like it's trying to verify all the ROMs on a given PCI device rather 
than just the one we just ioremap'd above.  Should this check just be inline 
and the loop deleted?  In that case, all of the breaks would turn into return 
NULLs (though the code should probably be refactored to make that a little 
clearer) along with an iounmap?

Thanks,
Jesse
