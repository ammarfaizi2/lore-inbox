Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263866AbSIQHku>; Tue, 17 Sep 2002 03:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263867AbSIQHku>; Tue, 17 Sep 2002 03:40:50 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:17156
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263866AbSIQHks>; Tue, 17 Sep 2002 03:40:48 -0400
Date: Tue, 17 Sep 2002 00:42:56 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Experimental IDE oops dumper v0.1 
In-Reply-To: <20020917020148.3413D2C125@lists.samba.org>
Message-ID: <Pine.LNX.4.10.10209170028370.11597-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rusty,

First of all if you are reading the kernel IDE driver and using it as an
reference you are TOAST!  The kernel assumes nIEN = 0.

Not Interrupt Enable = 0, means device can call the host controller's
mailbox effectively.

Not Interrupt Enable = 1 is what you have to tell all devices attached to
the HBA.

I have avoided writing the polling state diagrams to C.
You beat Alan over the head to suffer as the interperter andre->C and I
get sometime freed I will do them.

On Tue, 17 Sep 2002, Rusty Russell wrote:

> In message <200209161218.g8GCI7301692@devserv.devel.redhat.com> you write:
> > > +	/* Pause (at least 400ns) in case we just issued a command */
> > > +	oopser_usec(1);
> > > +	for (i = 0; i < 1000; i++) {
> > > +		b = inb(HD_STATUS);
> > > +		if (!(b & BUSY_STAT)) {
> > > +			if (b & ERR_STAT) return 0;
> > > +			if (b & flag) return 1;
> > > +		}
> > > +		oopser_usec(1000);
> > 
> > This will stop working on SATA when VDMA goes into newer controllers btw.
> 
> My ignorance of ATA is incredibly deep.  I read an old IDE spec to get
> this to work.  So thanks for checking it.
> 
> There are several ways around this: we can detect in userspace and
> refuse to arm, we can detect in the kernel and refuse to arm, we can
> detect in kernel or userspace and set an "use LBA48" flag.  For
> example, my userspace code currently does:
> 
> 	if (ioctl(devfd, HDIO_GET_IDENTITY, &hdid) < 0) {
> 		perror("Getting identity of drive");
> 		exit(1);
> 	}

Uses and interrupt and nIEN = 0, BUG() for polling

> 	if (!(hdid.capability & (1 << 1))) {
> 		fprintf(stderr, "Drive does not support LBA\n");
> 		exit(1);
> 	}

Wrong answer, you do CHS.

> 
> > > +	/* Bits 24-27, 0x40=LBA, 0x10=slave */
> > > +	if (!wait_before_command()) return -EIO;
> > > +	outb(0x40 | (master ? 0 : 0x10) | ((lba >> 24) & 0x0F), HD_CURRENT);
> > 
> > Doesn't work for LBA48
> > 
> > > +	if (!wait_before_command()) return -EIO;
> > > +	outb(0x40 | (master ? 0 : 0x10) | ((lba >> 24) & 0x0F), HD_CURRENT);
> > 
> > Ditto
> 
> OK, what's the codepath for LBA48 look like?  And how do I detect it?

It is a double pump of the registers.
Soon the used HOB registers shall operate in XOR command integrity.

> > > +/* Called with interrupts off */
> > > +int oopser_read_ide(char dump[512], unsigned int block)
> > > +{
> > > +	/* Wait for non-busy: if not, reset anyway */
> > > +	wait_before_command();
> > > +	/* Soft reset of drive (set nIEN as well) */
> > > +	outb(0x0e, HD_CMD);
> > 
> > Be careful here - one or two drives get nIEN backwards, you might just
> > want to turn off interrupts and be done with it
> 
> Hmm... I have interrupts disabled so I don't really care: should be OK
> I think.  Or were you thinking of something else?

Kernel interrupts are not Device.

> > > +	oopser_usec(1); /* 400ns according to spec */
> > > +	outb(0x0a, HD_CMD);
> > 
> > You really need to reset and reprogram/retune the controller as well.
> 
> OK... How?

Depends of if you want hard or soft reset and if you care about signature
decoding for redetecting presence of attached devices.

> > I like the infrastructure but the IDE dumper code is wishful thinking
> > in one or two spots. You don't know f the controller is in DMA modes,
> > tuned for different things to the drives or legacy free. Im not sure what
> > to do for legacy free cases but the other bits like LBA48 and retuning
> > probably can be handled with some small chipset specific hooks
> 
> The code always does a read sector then a write: if the sector doesn't
> contain the right magic, it stops.  But the more robust the better.

You need a read-modify-write caller.
You need to remember setfeatures need to be hammered on flushcache and
writecache disabled.
You need to be able to walk your buffer and best only if you do single
sector transactions and not multimode.

> Patches appreciated 8)

I'll try, but time is tight for me.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

