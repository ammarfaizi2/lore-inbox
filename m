Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKLTFz>; Sun, 12 Nov 2000 14:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbQKLTFq>; Sun, 12 Nov 2000 14:05:46 -0500
Received: from slc539.modem.xmission.com ([166.70.7.31]:3592 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129030AbQKLTFk>; Sun, 12 Nov 2000 14:05:40 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet> <m1ofzmcne5.fsf@frodo.biederman.org> <20001112122910.A2366@athlon.random> <m1k8a9badf.fsf@frodo.biederman.org> <20001112163705.A4933@athlon.random>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Nov 2000 11:57:15 -0700
In-Reply-To: Andrea Arcangeli's message of "Sun, 12 Nov 2000 16:37:05 +0100"
Message-ID: <m1bsvlauic.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Sun, Nov 12, 2000 at 06:14:36AM -0700, Eric W. Biederman wrote:
> > x86-64 doesn't load the segment registers at all before use.
> 
> Yes, before switching to 64bit long mode we never do any data access. We do a
> stack access to clear eflags only while we still run in legacy mode with paging
> disabled and so we only rely on ss to be valid when the bootloader jumps at
> 0x100000 for executing the head.S code (and not anymore on the gdt_48 layout).

Nope you rely on cs & ds as well.  cs is just a duh the codes running
so it must be valid.  But ds is needed for lgdt.

> > I can tell you don't have real hardware.  The non obviousness

I need to retract this a bit.  You are still building a compressed image,
and the code in the boot/compressed/head.S remains unchanged and loads
segment registers, so it works by luck.  If you didn't build a
compressed image you would be in trouble.
 
> Current code definitely works fine on the simnow simulator so if current code
> shouldn't work because it's buggy then at least the simulator is sure buggy as
> well (and that isn't going to be the case as its behaviour is in full sync with
> the specs as far I can see).

Add a target for a noncompressed image and then build.  It should be
interesting to watch.
> 
> > So while you load the gdt before you set a segment register later,
> > which is good the more important part was still missed.
> 
> Sorry but I don't see the missing part. Are you sure you're not missing this
> part of the x86-64 specs?

Nope because what I was complaining about is in 32 bit mode. :)

> 	Data and Stack Segments:
> 
> 	In 64-bit mode, the contents of the ES, DS, and SS segment registers
> 	are ignored. All fields (base, limit, and attribute) in the
> 	corresponding segment descriptor registers (hidden part) are also
> 	ignored.

Hmm.  I'll have to look and see if FS & GS are also ignored.

> 	Address calculations in 64-bit mode that reference the ES, DS, or SS
> 	segments, are treated as if the segment base is zero.  Rather than
> 	perform limit checks, the processor instead checks that all
> 	virtual-address references are in canonical form.

Cool I like this bit.  The segments are finally dead.

> > O.k. on monday I'll dig up my patch and that clears this up.
> 
> Sure, go ahead if you weren't missing that basic part of the long mode specs.
> Thanks.

Nope.  Though I suspect we should do the switch to 64bit mode in
setup.S and not have these issues pollute head.S at all.

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
