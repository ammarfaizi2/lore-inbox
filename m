Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262206AbRETT66>; Sun, 20 May 2001 15:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262198AbRETT6t>; Sun, 20 May 2001 15:58:49 -0400
Received: from t2.redhat.com ([199.183.24.243]:41716 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262204AbRETT6g>; Sun, 20 May 2001 15:58:36 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21.0105201150110.7553-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.21.0105201150110.7553-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 May 2001 20:57:51 +0100
Message-ID: <21747.990388671@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
> Now, a good way to force the issue may be to just remove the "ioctl"
> function pointer from the file operations structure altogether. We
> don't have to force peopel to use "read/write" - we can just make it
> clear that ioctl's _have_ to be wrapped, and that the only ioctl's
> that are acceptable are the ones that are well-designed enough to be
> wrappable. So we'd have a "linux/fs/ioctl.c" that would do all the
> wrapping,

I have so far resisted adding an 'ioctl' method to the MTD structure. Yet
because userspace needs to be able to request an erase, request information
about the erasesize of the device, etc., I've got an ioctl wrapper much as
you describe in drivers/mtd/mtdchar.c. It calls _real_ functions like 
->erase() in the underlying MTD device, which can't easily be exposed to
userspace (unless we do something silly like using CORBA :)

I can see the advantage of doing what you suggest - add methods to the
struct block_device for the sensible things like HDIO_GETGEO, BLKGETSIZE,
etc. (and anyone suggesting that it's sensible to have the physical block
device driver at all involved in BLKRRPART shall be summarily shot).

But please don't _actually_ put all the ioctl wrappers in fs/ioctl.c. It'd 
be a nightmare for the maintainers of the various sections of it. 

Besides, what on earth does it have to do with file systems?

Maybe abi/ioctl/{blkdev,mtd,usb,scsi,...}.c ?

Having it outside the directories which are traditionally owned by the 
respective subsystem maintainers means that it's far easier to be fascist 
about what's added, too.

On a related note - I was actually beginning to consider a dev-private ioctl
for MTD devices, actually for reasons of taste - some stuff like turning 
on/off the automatic hardware ECC on the DiskOnChip devices I consider ugly
enough that I didn't want to deal with it in generic code. At least a
dev-private ioctl seemed like it would banish the ugliness into the
offending driver, and be vaguely reusable if any other device turned out to
require such ugliness.

--
dwmw2


