Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVBYCPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVBYCPN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 21:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVBYCPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 21:15:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:38097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261800AbVBYCPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 21:15:02 -0500
Date: Thu, 24 Feb 2005 18:14:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: 2.6.11-rc2-mm1 strange messages
Message-Id: <20050224181412.64a1f351.akpm@osdl.org>
In-Reply-To: <20050225012326.GA14302@gamma.logic.tuwien.ac.at>
References: <20050125121704.GA22610@gamma.logic.tuwien.ac.at>
	<20050125102834.7e549322.akpm@osdl.org>
	<20050224141015.GA6756@gamma.logic.tuwien.ac.at>
	<20050224150326.3a82986c.akpm@osdl.org>
	<20050225012326.GA14302@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
> On Don, 24 Feb 2005, Andrew Morton wrote:
> > What does the stack backtrace from iounmap-debugging.patch say?
> 
> iounmap: bad address c00fffd9
>  [<c03f8430>] trap_init+0x30/0x190
>  [<c03f2697>] start_kernel+0x47/0x1c0

ah hah.

trap_init() does:

	void __iomem *p = ioremap(0x0FFFD9, 4);

which returns phys_to_virt(0x0FFFD9) = 0xc00fffd9

then trap_init() does:

	iounmap(p);

and iounmap() does

	if ((void __force *) addr <= high_memory) 
		return; 

which doesn't work, because 0xc00fffd9 is outside 0 ... high_memory.

A quick fix is to delete that iounmap() call from trap_init(), because we
"know" how ioremap() works.  Or, better, simply use phys_to_virt(0x0FFFD9)
in trap_init().

Although a better fix might be to make __iounmap() behave symmetrically:

	if ((long)addr >= phys_to_virt(0xA0000) &&
			(long)addr < phys_to_virt(0x100000))
		return;

but that's not quite right, because we're assuming that the range to be
unmapped is wholly within the PCI/ISA region.  Without a VMA there just
isn't enough info to determine that.

Does anyone have any preferences?
