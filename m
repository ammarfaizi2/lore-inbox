Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWBTLrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWBTLrl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWBTLrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:47:41 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:29702 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964855AbWBTLrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:47:19 -0500
Date: Mon, 20 Feb 2006 12:43:41 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Greg KH <greg@kroah.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>,
       Brian Hall <brihall@pcisys.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Help: DGE-560T not recognized by Linux
Message-ID: <20060220114341.GA7710@w.ods.org>
References: <20060217222720.a08a2bc1.brihall@pcisys.net> <20060217222428.3cf33f25.akpm@osdl.org> <20060218003622.30a2b501.brihall@pcisys.net> <20060217234841.5f2030ec.akpm@osdl.org> <20060218100126.198d86c3.brihall@pcisys.net> <20060218222946.4da27618.vsu@altlinux.ru> <20060218163555.39fa3b4a@localhost.localdomain> <20060219010441.GA5810@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219010441.GA5810@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sat, Feb 18, 2006 at 05:04:41PM -0800, Greg KH wrote:
> On Sat, Feb 18, 2006 at 04:35:55PM -0800, Stephen Hemminger wrote:
> > On Sat, 18 Feb 2006 22:29:46 +0300
> > Sergey Vlasov <vsu@altlinux.ru> wrote:
> > 
> > > On Sat, 18 Feb 2006 10:01:26 -0700 Brian Hall wrote:
> > > 
> > > > On Fri, 17 Feb 2006 23:48:41 -0800
> > > > Andrew Morton <akpm@osdl.org> wrote:
> > > > > Brian Hall <brihall@pcisys.net> wrote:
> > > > > >  I see that the sky2 driver in 2.6.16rc4 lists my card, but for some
> > > > > >  reason it fails to access the card, maybe because I have an ULi
> > > > > > chipset?
> > > > > > 
> > > > > >  Feb 17 23:18:46 syrinx sky2 0000:02:00.0: can't access PCI config
> > > > > > space
> > > > > 
> > > > > Looks like something died way down in the PCI bus config space
> > > > > read/write operations.  I don't know what would cause that.  You
> > > > > could perhaps play with `pci=conf1', `pci=conf2', etc as per
> > > > > Documentation/kernel-parameters.txt.
> > > > 
> > > > OK, I tried all these pci= options, plus acpi=off, to no effect:
> > > > conf1, conf2, nommconf, biosirq, noacpi, routeirq, nosort, rom,
> > > > lastbus=2, assign-busses, usepirqmask acpi=off
> > > > 
> > > > Also tried adjusting PCIe-related stuff in the BIOS (underclocking PCIe
> > > > from 100 to 70 and adjusting Northbridge options). No change.
> > > 
> > > Most likely it fails here:
> > > 
> > > 		err = pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
> > > 						 0xffffffffUL);
> > > 		if (err)
> > > 			goto pci_err;
> > > 
> > > PEX_UNC_ERR_STAT is 0x104; this register is outside of the standard
> > > 256-byte PCI configuration space, and is reachable only via the MMCONFIG
> > > access mechanism.  Seems that kernel is not using MMCONFIG for some
> > > reason; you mentioned that you have CONFIG_PCI_MMCONFIG=y in kernel
> > > config, so it looks like your BIOS does not provide proper MCFG table.
> > > Full dmesg output might give some clues.
> > 
> > The problem can also be caused by buggy BIOS's that don't report
> > proper values for mmconfig space. There is some code in mmconfig.c that
> > tries to handle that. It might not handle what ever your system is reporting.
> > Andi Kleen seems to be the last person involved and might be able to help.
> > 
> > It would be useful to add some printk's to mmconfig to dump out the table
> > after it discovers the table.
> 
> Andi has a follow-on patch at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-03-pci/pci-give-pci-config-access-initialization-a-defined-ordering.patch
> that should take care of these kinds of mmconfig issues by ordering the
> pci config accessors properly.
> 
> Can you test this patch out to see if it fixes this problem on your
> machine?

Today, I had the *exact* same problem on one server equipped with the same
card. I tried the patch above which did not change anything. However, I
finally fixed it by simply enabling ACPI. Then it always works with and
without the patch above. I could not test marvell's driver because it does
not build on 2.6.16-rc4, but strangely my previous kernel on this machine
was a 2.6.12-rc4-mm2 patched with marvell's driver and with ACPI disabled.

So it seems that marvell's driver on 2.6.12 was able to access config space
even without ACPI while sky2 on 2.6.16-rc4 cannot. I have no idea why,
unfortunately.

Just my 2 cents,
Willy

