Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267981AbTAMSvl>; Mon, 13 Jan 2003 13:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268155AbTAMSvl>; Mon, 13 Jan 2003 13:51:41 -0500
Received: from [217.167.51.129] ([217.167.51.129]:48064 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S267981AbTAMSvh>;
	Mon, 13 Jan 2003 13:51:37 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ross Biro <rossb@google.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E230A4D.6020706@google.com>
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
	 <1042399796.525.215.camel@zion.wanadoo.fr>
	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>
	 <1042401074.525.219.camel@zion.wanadoo.fr>  <3E230A4D.6020706@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042484609.30837.31.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 13 Jan 2003 20:03:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 19:49, Ross Biro wrote:

> The reason we need to enforce the 400nS delay is because of what is 
> going on on the other processor.  If the other processor is in ide_intr 
> trying to grab the spinlock and we do not give the drive time to assert 
> the busy bit and the other processor makes it to the call to 
> drive_is_ready, then the drive could still return not busy and we could 
> think the command is done.  This code path is probably less than 50 
> instructions, so I don't think it's taken anywhere near 400ns for a long 
> time.
> 
> DMA is slightly different.  We don't actually have to delay the 400ns if 
> we call ide_dma_begin from inside the spinlock.

Exactly. My problem right now is with enforcing that 400ns delay on
non-DMA path as with PCI write posting on one side, and other fancy bus
store queues etc... you are really not sure when your outb for the
command byte will really reach the disk.

So the problem turns down to: is it safe for commands with no data
transfer and commands with a PIO data transfer to read back from
some other task file register right after issuing the command byte
(the select register looks like a good choice, better than status
for sure) and before doing the delay of 400ns ? On any sane bus
architecture, that read will make sure the previous write will
have reached the device or your IO accessors are broken...

Ben.





