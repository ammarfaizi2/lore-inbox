Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130745AbQKLPhg>; Sun, 12 Nov 2000 10:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130548AbQKLPh1>; Sun, 12 Nov 2000 10:37:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31600 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130745AbQKLPhM>; Sun, 12 Nov 2000 10:37:12 -0500
Date: Sun, 12 Nov 2000 16:37:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001112163705.A4933@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet> <m1ofzmcne5.fsf@frodo.biederman.org> <20001112122910.A2366@athlon.random> <m1k8a9badf.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k8a9badf.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Nov 12, 2000 at 06:14:36AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 06:14:36AM -0700, Eric W. Biederman wrote:
> x86-64 doesn't load the segment registers at all before use.

Yes, before switching to 64bit long mode we never do any data access. We do a
stack access to clear eflags only while we still run in legacy mode with paging
disabled and so we only rely on ss to be valid when the bootloader jumps at
0x100000 for executing the head.S code (and not anymore on the gdt_48 layout).

> I can tell you don't have real hardware.  The non obviousness

Current code definitely works fine on the simnow simulator so if current code
shouldn't work because it's buggy then at least the simulator is sure buggy as
well (and that isn't going to be the case as its behaviour is in full sync with
the specs as far I can see).

> So while you load the gdt before you set a segment register later,
> which is good the more important part was still missed.

Sorry but I don't see the missing part. Are you sure you're not missing this
part of the x86-64 specs?

	Data and Stack Segments:

	In 64-bit mode, the contents of the ES, DS, and SS segment registers
	are ignored. All fields (base, limit, and attribute) in the
	corresponding segment descriptor registers (hidden part) are also
	ignored.

	Address calculations in 64-bit mode that reference the ES, DS, or SS
	segments, are treated as if the segment base is zero.  Rather than
	perform limit checks, the processor instead checks that all
	virtual-address references are in canonical form.

You'll find the above at the top of page 42 of the specs.

Basically in 64bit long mode only CS matters and basically only to specify
CS.L=1 and CS.D=0.

The only subtle case is during iret where we need a valid data segment for some
subtle reason (but that's unrelated to head.S that instead only needs to
switch to 64bit mode and jump into head64.c where we do the rest of the work
like clearing bss in C). Infact we need only 1 32bit compatibility mode data
segment in the gdt.

> O.k. on monday I'll dig up my patch and that clears this up.

Sure, go ahead if you weren't missing that basic part of the long mode specs.
Thanks.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
