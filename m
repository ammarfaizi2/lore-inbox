Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269119AbUHZQBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269119AbUHZQBu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269081AbUHZP7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:59:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6337 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269165AbUHZP6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:58:12 -0400
Date: Thu, 26 Aug 2004 16:58:03 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Matthew Wilcox <willy@debian.org>, Greg KH <greg@kroah.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040826155803.GN16196@parcelfarce.linux.theplanet.co.uk>
References: <20040826131346.GK16196@parcelfarce.linux.theplanet.co.uk> <20040826154049.69769.qmail@web14923.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826154049.69769.qmail@web14923.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 08:40:49AM -0700, Jon Smirl wrote:
> I was computing the length because of the need to copy for the
> partially decoded case. I have one card that maps a 40KB ROM with a
> 512KB window. In that case it makes a 450KB different in the copy size.

Youch.  That card's actually breaking the PCI spec, but never mind, it exists.

> The copy case is adding a lot of complexity to the code. We could just
> give it the boot and require that partially decoded drivers just turn
> the ROM attribute off.
> 
> If not, how do I get the size from your algorithm?

In words, what the algorithm is doing is:

	for_each_rom_image
		get_the_pci_data_structure
		get_the_rom_length_from_pds

At the end of the algorithm, 'image' should be pointing to the end of the
ROM data.

I'm just tracking down another bug with the current code -- it maps the
ROMs into the wrong address range on my ia64 zx1 box.  I'll send more
mail once I've fixed that.

> --- Matthew Wilcox <willy@debian.org> wrote:
> 
> > On Wed, Aug 25, 2004 at 01:06:38PM -0700, Jon Smirl wrote:
> > > New version attached fixes this and the function documentation.
> > 
> > Sorry, I found two more bugs ;-(
> > 
> > > +unsigned char *
> > > +pci_map_rom(struct pci_dev *pdev, size_t *size)
> > > +{
> > [...]
> > > +	/* Standard PCI ROMs start out with these three bytes 55 AA
> > size/512 */
> > > +	if ((*rom == 0x55) && (*(rom + 1) == 0xAA))
> > > +		*size = *(rom + 2) * 512;	/* return true ROM size, not PCI
> > window size */
> > 
> > First, you're dereferencing an ioremapped pointer directly instead of
> > using readb() et al.  This is a portability no-no but happens to work
> > on x86.
> > 
> > Second, only images of code type 0 (Intel x86, PC-AT compatible) are
> > specified to have length as the third byte.  OpenFirmware, PA-RISC
> > and
> > EFI may or may not have size as the third byte.  It's also possible
> > that there are multiple images in the ROM.  So what you have to do to
> > be correct is something like ...
> > 
> > 	int last_image;
> > 	char *image = rom;
> > 	do {
> > 		char *pds;
> > 		if (readb(image) != 0x55)
> > 			break;
> > 		if (readb(image + 1) != 0xAA)
> > 			break;
> > 		pds = image + readw(image + 16);
> > 		if (readb(pds) != 'P')
> > 			break;
> > 		if (readb(pds + 1) != 'C')
> > 			break;
> > 		if (readb(pds + 2) != 'I')
> > 			break;
> > 		if (readb(pds + 3) != 'R')
> > 			break;
> > 		last_image = readb(pds + 21) & 0x80;
> > 		image += readw(pds + 16) * 512;
> > 	} while (!last_image);
> > 
> > But I'm not sure it's worth it.  I'm inclined to just map the whole
> > thing.
> > 
> > -- 
> > "Next the statesmen will invent cheap lies, putting the blame upon 
> > the nation that is attacked, and every man will be glad of those
> > conscience-soothing falsities, and will diligently study them, and
> > refuse
> > to examine any refutations of them; and thus he will by and by
> > convince 
> > himself that the war is just, and will thank God for the better sleep
> > 
> > he enjoys after this process of grotesque self-deception." -- Mark
> > Twain
> > 
> 
> =====
> Jon Smirl
> jonsmirl@yahoo.com
> 
> 
> 		
> __________________________________
> Do you Yahoo!?
> Yahoo! Mail is new and improved - Check it out!
> http://promotions.yahoo.com/new_mail
> 

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
