Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268783AbUHZNRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268783AbUHZNRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268959AbUHZNRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:17:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3730 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268783AbUHZNNx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:13:53 -0400
Date: Thu, 26 Aug 2004 14:13:46 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040826131346.GK16196@parcelfarce.linux.theplanet.co.uk>
References: <20040825185519.GG30125@kroah.com> <20040825200638.1165.qmail@web14927.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825200638.1165.qmail@web14927.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 01:06:38PM -0700, Jon Smirl wrote:
> New version attached fixes this and the function documentation.

Sorry, I found two more bugs ;-(

> +unsigned char *
> +pci_map_rom(struct pci_dev *pdev, size_t *size)
> +{
[...]
> +	/* Standard PCI ROMs start out with these three bytes 55 AA size/512 */
> +	if ((*rom == 0x55) && (*(rom + 1) == 0xAA))
> +		*size = *(rom + 2) * 512;	/* return true ROM size, not PCI window size */

First, you're dereferencing an ioremapped pointer directly instead of
using readb() et al.  This is a portability no-no but happens to work
on x86.

Second, only images of code type 0 (Intel x86, PC-AT compatible) are
specified to have length as the third byte.  OpenFirmware, PA-RISC and
EFI may or may not have size as the third byte.  It's also possible
that there are multiple images in the ROM.  So what you have to do to
be correct is something like ...

	int last_image;
	char *image = rom;
	do {
		char *pds;
		if (readb(image) != 0x55)
			break;
		if (readb(image + 1) != 0xAA)
			break;
		pds = image + readw(image + 16);
		if (readb(pds) != 'P')
			break;
		if (readb(pds + 1) != 'C')
			break;
		if (readb(pds + 2) != 'I')
			break;
		if (readb(pds + 3) != 'R')
			break;
		last_image = readb(pds + 21) & 0x80;
		image += readw(pds + 16) * 512;
	} while (!last_image);

But I'm not sure it's worth it.  I'm inclined to just map the whole thing.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
