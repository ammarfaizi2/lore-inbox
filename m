Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbTGHTUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTGHTUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:20:08 -0400
Received: from ns.suse.de ([213.95.15.193]:46602 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267580AbTGHTTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:19:53 -0400
Date: Tue, 8 Jul 2003 21:34:27 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, grundler@parisc-linux.org,
       James.Bottomley@SteelEye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-Id: <20030708213427.39de0195.ak@suse.de>
In-Reply-To: <20030707.191438.71104854.davem@redhat.com>
References: <20030702235619.GA21567@wotan.suse.de>
	<1057263988.21508.18.camel@dhcp22.swansea.linux.org.uk>
	<20030703212415.GA30277@wotan.suse.de>
	<20030707.191438.71104854.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jul 2003 19:14:38 -0700 (PDT)
"David S. Miller" <davem@redhat.com> wrote:

>    From: Andi Kleen <ak@suse.de>
>    Date: Thu, 3 Jul 2003 23:24:15 +0200
> 
>    But of course it doesn't help much in practice because all the interesting
>    block devices support DAC anyways and the IOMMU is disabled for that.
>    
> Platform dependant.  SAC DMA transfers are faster on sparc64 so
> we only allow the device to specify a 32-bit DMA mask successfully.
> 
> And actually, I would recommend other platforms that have a IOMMU do
> this too (unless there is some other reason not to) since virtual
> merging causes less scatter-gather entries to be used in the device
> and thus you can stuff more requests into it.

Do you know a common PCI block device that would benefit from this (performs significantly
better with short sg lists)? It would be interesting to test.

I don't want to use the IOMMU for production for SAC on AMD64 because
on some of the boxes the available IOMMU area is quite small. e.g. the single
processor boxes typically only have a 128MB aperture set up, which means
the IOMMU hole is only 64MB (other 64MB for AGP).And some of them do not even have a 
BIOS option to enlarge it (I can allocate a bigger one myself, but it costs
memory). The boxes that have more than 4GB memory at least typically 
support enlarging it. 

Overflow is typically deadly because the API does not allow proper
error handling and most drivers don't check for it. That's especially
risky for block devices: while pci_map_sg can at least return an error
not everybody checks for it and when you get an overflow the next
super block write with such an unchecked error will destroy the file 
system.

Also networking tests have shown that it costs around 10% performance.
These are old numbers and some optimizations have been done since then
so it may be better now.
 
-Andi
