Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267723AbTAMTZe>; Mon, 13 Jan 2003 14:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267807AbTAMTZe>; Mon, 13 Jan 2003 14:25:34 -0500
Received: from otter.mbay.net ([206.55.237.2]:58886 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S267723AbTAMTZb> convert rfc822-to-8bit;
	Mon, 13 Jan 2003 14:25:31 -0500
From: John Alvord <jalvo@mbay.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ross Biro <rossb@google.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
Date: Mon, 13 Jan 2003 11:34:02 -0800
Message-ID: <m3562vkrgu0u6qhijvimibkcqjfpujgi59@4ax.com>
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com> <1042399796.525.215.camel@zion.wanadoo.fr> <1042403235.16288.14.camel@irongate.swansea.linux.org.uk> <1042401074.525.219.camel@zion.wanadoo.fr>  <3E230A4D.6020706@google.com> <1042484609.30837.31.camel@zion.wanadoo.fr>
In-Reply-To: <1042484609.30837.31.camel@zion.wanadoo.fr>
X-Mailer: Forte Agent 1.92/32.570
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jan 2003 20:03:29 +0100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

>On Mon, 2003-01-13 at 19:49, Ross Biro wrote:
>
>> The reason we need to enforce the 400nS delay is because of what is 
>> going on on the other processor.  If the other processor is in ide_intr 
>> trying to grab the spinlock and we do not give the drive time to assert 
>> the busy bit and the other processor makes it to the call to 
>> drive_is_ready, then the drive could still return not busy and we could 
>> think the command is done.  This code path is probably less than 50 
>> instructions, so I don't think it's taken anywhere near 400ns for a long 
>> time.
>> 
>> DMA is slightly different.  We don't actually have to delay the 400ns if 
>> we call ide_dma_begin from inside the spinlock.
>
>Exactly. My problem right now is with enforcing that 400ns delay on
>non-DMA path as with PCI write posting on one side, and other fancy bus
>store queues etc... you are really not sure when your outb for the
>command byte will really reach the disk.
>
>So the problem turns down to: is it safe for commands with no data
>transfer and commands with a PIO data transfer to read back from
>some other task file register right after issuing the command byte
>(the select register looks like a good choice, better than status
>for sure) and before doing the delay of 400ns ? On any sane bus
>architecture, that read will make sure the previous write will
>have reached the device or your IO accessors are broken...
>
You could simplify the problem somewhat by forcing all interaction and
interrupt processing to a single CPU.

john
