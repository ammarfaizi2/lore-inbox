Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWBSAc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWBSAc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 19:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWBSAc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 19:32:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932370AbWBSAc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 19:32:28 -0500
Date: Sat, 18 Feb 2006 16:35:55 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Brian Hall <brihall@pcisys.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Help: DGE-560T not recognized by Linux
Message-ID: <20060218163555.39fa3b4a@localhost.localdomain>
In-Reply-To: <20060218222946.4da27618.vsu@altlinux.ru>
References: <20060217222720.a08a2bc1.brihall@pcisys.net>
	<20060217222428.3cf33f25.akpm@osdl.org>
	<20060218003622.30a2b501.brihall@pcisys.net>
	<20060217234841.5f2030ec.akpm@osdl.org>
	<20060218100126.198d86c3.brihall@pcisys.net>
	<20060218222946.4da27618.vsu@altlinux.ru>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Feb 2006 22:29:46 +0300
Sergey Vlasov <vsu@altlinux.ru> wrote:

> On Sat, 18 Feb 2006 10:01:26 -0700 Brian Hall wrote:
> 
> > On Fri, 17 Feb 2006 23:48:41 -0800
> > Andrew Morton <akpm@osdl.org> wrote:
> > > Brian Hall <brihall@pcisys.net> wrote:
> > > >  I see that the sky2 driver in 2.6.16rc4 lists my card, but for some
> > > >  reason it fails to access the card, maybe because I have an ULi
> > > > chipset?
> > > > 
> > > >  Feb 17 23:18:46 syrinx sky2 0000:02:00.0: can't access PCI config
> > > > space
> > > 
> > > Looks like something died way down in the PCI bus config space
> > > read/write operations.  I don't know what would cause that.  You
> > > could perhaps play with `pci=conf1', `pci=conf2', etc as per
> > > Documentation/kernel-parameters.txt.
> > 
> > OK, I tried all these pci= options, plus acpi=off, to no effect:
> > conf1, conf2, nommconf, biosirq, noacpi, routeirq, nosort, rom,
> > lastbus=2, assign-busses, usepirqmask acpi=off
> > 
> > Also tried adjusting PCIe-related stuff in the BIOS (underclocking PCIe
> > from 100 to 70 and adjusting Northbridge options). No change.
> 
> Most likely it fails here:
> 
> 		err = pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
> 						 0xffffffffUL);
> 		if (err)
> 			goto pci_err;
> 
> PEX_UNC_ERR_STAT is 0x104; this register is outside of the standard
> 256-byte PCI configuration space, and is reachable only via the MMCONFIG
> access mechanism.  Seems that kernel is not using MMCONFIG for some
> reason; you mentioned that you have CONFIG_PCI_MMCONFIG=y in kernel
> config, so it looks like your BIOS does not provide proper MCFG table.
> Full dmesg output might give some clues.

The problem can also be caused by buggy BIOS's that don't report
proper values for mmconfig space. There is some code in mmconfig.c that
tries to handle that. It might not handle what ever your system is reporting.
Andi Kleen seems to be the last person involved and might be able to help.

It would be useful to add some printk's to mmconfig to dump out the table
after it discovers the table.
