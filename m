Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279506AbRJXJv6>; Wed, 24 Oct 2001 05:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279504AbRJXJvr>; Wed, 24 Oct 2001 05:51:47 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15365 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279499AbRJXJvf>; Wed, 24 Oct 2001 05:51:35 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 24 Oct 2001 10:57:42 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        mochel@osdl.org (Patrick Mochel),
        jlundell@pobox.com (Jonathan Lundell)
In-Reply-To: <20011024002602.3310@smtp.wanadoo.fr> from "Benjamin Herrenschmidt" at Oct 24, 2001 02:26:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wKn8-00013C-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> upon must be stopped after you. That's the point of having a
> tree here. Patrick and Linus feel the bus tree is enough to handle
> that dependency, which might well be the case for 99% of drivers.

The two trees are certainly closely related - USB devices before USB hub,
USB hub before PCI etc. The scanner example works fine there, providing that
we are careful about memory issues - remember the USB layer allocates memory
to do any transaction, so the scanner has to complete its state save before 
we do any interrupt disabling/memory alloc freezing.

Thats still just ordering and maybe two passes

> the HW or not when getting a new request). In cases where a mid-layer
> enters the scene, like SCSI, that wants to do timeouts, then well...
> we can let it timeout (just stop processing requests), or we can
> have the midlayer go to sleep as well :) That later solution
> may cause some interesting ordering issues however...

For scsi you have to complete the pending commands, you don't know what the
transaction granularity is in some cases and half completing the sequence
won't help you. In addition the upper layers have to queue additional scsi
commands to do stuff like cd drawer locking and to ask the drive firmware
to enter powerdown modes

> For USB, for example, we can consider that when a device driver
> (not a controller driver) suspend has been done, any URB it submits
> can just be dropped (returned immediately with an error). We don't
> need blocking here neither. Of course, that means we have the
> framework to call devices' suspend/resume callbacks when the
> controller is about to go to sleep.

That will scramble large numbers of devices. Randomly erroring pending block
writes is -not- civilised.

Alan
