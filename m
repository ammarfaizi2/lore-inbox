Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263028AbTCTWyG>; Thu, 20 Mar 2003 17:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262970AbTCTWxY>; Thu, 20 Mar 2003 17:53:24 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:54532 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263006AbTCTWxC>; Thu, 20 Mar 2003 17:53:02 -0500
Date: Fri, 21 Mar 2003 00:03:57 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org, <akpm@digeo.com>
Subject: Re: [PATCH] alternative dev patch
In-Reply-To: <UTC200303202150.h2KLoEl09978.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0303202314210.5042-100000@serv>
References: <UTC200303202150.h2KLoEl09978.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 20 Mar 2003 Andries.Brouwer@cwi.nl wrote:

> (i)
> There was some unused code, and you decide to start using that
> in order to speed up the open() of a chardev. Is that urgent?
> Is the speed of opening a chardev a bottleneck?

Currently it isn't, but it shouldn't become one?
I'm unsure how your code will scale. It depends on how that code will be 
used. If drivers register a lot of devices, your lookup function has to 
scan a possibly very long list of minor devices and that function is 
difficult to optimize. If drivers want to avoid this they have to 
implement their own lookup function.
One other major reason for the "unused" code is to convert the 16/32/64bit 
dev_t as early as possible to either struct block_device/struct 
char_device, so the kernel mostly doesn't care about the dev_t resolution,
the character device core would match here the behaviour of the block 
device core.

> > Further he introduces a new function register_chrdev_region(),
> > which is only needed by the tty code and rather hides the problem
> > than solves it.
> 
> What does one want? A driver announces the device number regions
> that it wants to cover. Simple and straightforward.
> Hardly a new idea. How is this done for block devices?
> Using blk_register_region(). How is register_chrdev_region()
> hiding problems? It eliminates the tty kludges that you only
> move to a different file.

char devices don't have partitions, so you hardly need regions. The 
problem with the tty layer is that the console and the serial devices 
should have different majors.
Even for block devices blk_register_region() is not the preferred 
interface, you should use alloc_disk/add_disk instead. This will make it 
easier to assign dynamic device numbers later.

> (iii)
> > this patch helps drivers to manage them without huge tables
> > (this latter part is also missing in Andries patch).
> 
> I am not sure I understand. Where are these huge tables?
> And how did you remove them?

See the misc device example. It doesn't have a table, but the list is now 
only needed to generate /proc/misc. As soon as character devices are 
better integrated into the driver model, even this list is not needed 
anymore. This means for simple character devices, we can easily add a 
alloc_chardev/add_chardev interface similiar to block devices.

bye, Roman

