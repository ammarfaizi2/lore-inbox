Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313660AbSEIP1c>; Thu, 9 May 2002 11:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313661AbSEIP1b>; Thu, 9 May 2002 11:27:31 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30836 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313660AbSEIP1b>; Thu, 9 May 2002 11:27:31 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
In-Reply-To: <Pine.LNX.4.44.0205081200340.5406-100000@home.transmeta.com>
	<20020508191054.6282@smtp.wanadoo.fr>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 May 2002 09:19:12 -0600
Message-ID: <m1znz9z6vj.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> >And done properly with per-controller (or drive - you may want to
> >virtualize at the drive level just because you could separate out
> >different kinds of drive accesses that way too) function pointers you can
> >then _mix_ access methods, without getting completely idiotic run-time
> >checks inside "ide_out()".
> 
> Which ends up basically into having function pointers in the
> ata_channel (or ata_drive, but I doubt that would be really
> necessary) a set of 4 access functions: taskfile_in/out for
> access to taskfile registers (8 bits), and data_in/out for
> steaming datas in/out of the data reg (16 bits).
> 
> That would cleanly solve my problem of mixing MMIO and PIO
> controllers in the same machine, that would solve the crazy
> byteswapping needed by some controllers for PIO at least,
> etc...
> 
> I would even suggest not caring about the taskfile register
> address at all (that is kill the array of port addresses) but
> just pass the taskfile_in/out functions the register number
> (cyl_hi, cyl_lo, select, ....) as a nice symbolic constant,
> and let the channel specific implementation figure it out.
> I haven't checked if you already killed all of the request/release
> region crap done by the common ide code, that is matter is completely
> internal to the host controller driver, etc...
> 
> Now, andre may tell us we need one more set for "slow IO"
> versions for some HW, I don't know the details for these so
> I'll let the old man speak up here.


I'd suggest pointers in the ata_channel that abstract out the
functions of the host controllers.  For most controllers we
can have a common PCI IDE library that implements them, and provides
a reference implementation for the weird cases.  

>From the ata-6 draft there are the following protocols, that should
be implementable on an IDE host controller.

- Software reset protocol
- Non-data command protocol
- PIO data-in command protocol
- PIO data-out command protocol
- DMA command protocol
- PACKET command protocol
- READ/WRITE DMA QUEUED command protocol
- EXECUTE DEVICE DIAGNOSTIC command protocol
- DEVICE RESET command protocol
- Ultra DMA data-in commands
- Ultra DMA data-out commands

Given the high level of the protocol abstraction we aren't
likely to beat ourselves to death with extra cpu or io overhead.
Nor is this an insane number of things to implement.

Perhaps more can be factored out (controllers being so similiar) but
that is the abstraction we need for the layer sending commands to ATA
devices.  This allows the higher layers to focus on sending commands
to ATA devices.

Eric
