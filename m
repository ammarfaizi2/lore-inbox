Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279629AbRJXWfY>; Wed, 24 Oct 2001 18:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279627AbRJXWfO>; Wed, 24 Oct 2001 18:35:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52234 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279622AbRJXWfG>; Wed, 24 Oct 2001 18:35:06 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 24 Oct 2001 23:41:24 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        mochel@osdl.org (Patrick Mochel),
        jlundell@pobox.com (Jonathan Lundell)
In-Reply-To: <20011024173349.20613@smtp.adsl.oleane.com> from "Benjamin Herrenschmidt" at Oct 24, 2001 07:33:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wWiC-0002uM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >The device tree is for _device_ suspend, not for "subsystem suspend". The
> >SCSI subsystem is a piece of cr*p, but even if it was perfect it should
> >never get involved with the act of suspension.
> 
> I agree I'd like subsystems to avoid polluting the PM tree (or device tree).
> If there are a few cases where a subsystem needs to know a driver it's using
> is asleep, it's probably up to the interface of this susbystem to provide
> a function to be called by the driver when it's going to suspend mode.

I don't think it is a big problem. We can add virtual nodes. They way I
see it we either
	a) put in grungy subsystem hacks
	b) register virtual device nodes for subsystems when needed

b feels cleaner

> I really don't think it's _that_ difficult to properly do this blocking.
> For things like sound drivers, a simple semaphore is plenty enough. For

Sound is more easily handled by not blocking user space but waiting until
the final IRQ off moment and grabbing the registers. That avoids a lot
of ugly locking gunge. It literally comes down to

	case suspending
		kmalloc buffer
		done
	case final suspend point
		turn off DMA
		readl
		readl
		readl
		readl
		...
		done

