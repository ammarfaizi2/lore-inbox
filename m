Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136525AbREDVtx>; Fri, 4 May 2001 17:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136526AbREDVto>; Fri, 4 May 2001 17:49:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64527 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136525AbREDVtc>; Fri, 4 May 2001 17:49:32 -0400
Subject: Re: [linux-usb-devel] pegasus + MediaGX: Oops in khubd, the continuing story?
To: linux-usb-devel@lists.sourceforge.net
Date: Fri, 4 May 2001 22:53:04 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010504221648.L7822@unternet.org> from "Frank de Lange" at May 04, 2001 10:16:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vnVb-00085n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Oops'es are mostly in the khubd process, but they sometimes appear in other
> programs (insmod, ifconfig). They always lead to an immedate panic, and nothing

I suspect the ohci driver currently. I've been reviewing it a little and it
is full of code written by someone who does not know about pci write posting.

Specifically

	writel(value, pciaddr)

is a queued operation. So 

	writel(value, foo)
	delay
	real(foo)

might not do the writel into the delay is over or during it. PCI makes 
guarantees that

-	writes will go out in order and will be merged only if prefetchable set
-	multiple writes to the same addr will remain multiple writes
-	reads will not complete until the writes do

This applies in both directions - bus mastering nasties abound notably


	writel(STOP, reg->dmactrl)
	kfree(buffer)

is dangerous 

	You have to do

	writel(STOP, reg->dmactrl);
			[posted]
	readl(reg->dmactrl)
			[read forces write, read reply will follow any DMA
			 pending the other way]

I've not attempted to fix it yet


