Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269246AbUIHXrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269246AbUIHXrc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUIHXrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:47:31 -0400
Received: from the-village.bc.nu ([81.2.110.252]:16553 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269246AbUIHXnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:43:37 -0400
Subject: Re: multi-domain PCI and sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Jon Smirl <jonsmirl@gmail.com>, jbarnes@engr.sgi.com, willy@debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040908112143.330a9301.davem@davemloft.net>
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409072115.09856.jbarnes@engr.sgi.com>
	 <20040907211637.20de06f4.davem@davemloft.net>
	 <200409072125.41153.jbarnes@engr.sgi.com>
	 <9e47339104090723554eb021e4@mail.gmail.com>
	 <20040908112143.330a9301.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094683264.12335.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 23:41:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-08 at 19:21, David S. Miller wrote:
> On ppc, sparc, and other non-x86 platforms, when you perform load/store
> instructions within the port I/O space window, the PCI controller emits
> the IN/OUT transactions exactly as if an x86 processor had executed
> an in{bwl}/out{bwl} instruction.

Some of them are not quite that pretty. In certain cases outb gets 
translated into code that does horrors vaguely of the form

	spin_lock_irqsave
	lane = (addr & 3) << 3;
	writel(1<<(addr&3), somecontroller->lanes);
	writel(addr, somecontroller->offset);
	writel(val << lane, somecontroller->somewhere);
	spin_unlock_irqrestore

Other code has extra magic reads in to work around fpga pci bridges that
forgot out is synchronous and writel is posted.

A better summary from the higher levels of the kernel would be "don't
look behind the sofa, there might be a monster lurking".

The only way I can see VGA routing working is to have some kind of arch
code that can tell you which devices are on the same VGA legacy tree.
That then allows a vga layer to walk VGA devices and ask arch code the
typically simple question

		pci_vga_shared_router(pdev1, pdev2)

Alan

