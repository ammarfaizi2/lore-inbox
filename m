Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKPUB1>; Thu, 16 Nov 2000 15:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131406AbQKPUBR>; Thu, 16 Nov 2000 15:01:17 -0500
Received: from slc725.modem.xmission.com ([166.70.7.217]:22537 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129076AbQKPUBM>; Thu, 16 Nov 2000 15:01:12 -0500
To: Andi Kleen <ak@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet> <m1ofzmcne5.fsf@frodo.biederman.org> <20001112122910.A2366@athlon.random> <m1k8a9badf.fsf@frodo.biederman.org> <20001112163705.A4933@athlon.random> <m1bsvlauic.fsf@frodo.biederman.org> <20001112203353.A13289@gruyere.muc.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Nov 2000 10:43:05 -0700
In-Reply-To: Andi Kleen's message of "Sun, 12 Nov 2000 20:33:53 +0100"
Message-ID: <m1snor7qza.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> [This is quite a bizarre discussion, but I'll answer anyways. I am not exactly
> sure what your point is]

Let me step aside a second and explain where I'm coming from.  As a spin
off of the work of the linuxBIOS project I have implemented a system
call that implements exec functionality at the kernel level.  Essentially
allowing you to warm boot linux from linux.  To get this to work no
bios calls are involved, so I'm not using setup.S.  This also has the 
interesting side effect of allowing a boot loader to be written that
will work on all linux platforms.  (I have currently just begun my
port to alpha).

In the process of the above I have learned quite a bit about how
the current boot loader works.  And want eventually to convert linux
to not need wrapper code to use my bootloader.

Booting vmlinux is fun :)
 
> On Sun, Nov 12, 2000 at 11:57:15AM -0700, Eric W. Biederman wrote:
> > 
> > > > I can tell you don't have real hardware.  The non obviousness
> > 
> > I need to retract this a bit.  You are still building a compressed image,
> > and the code in the boot/compressed/head.S remains unchanged and loads
> > segment registers, so it works by luck.  If you didn't build a
> > compressed image you would be in trouble.
> 
> boot/compressed/head.S does run in 32bit legacy mode, where you of course
> need segment registers. After you got into long mode segments are only
> needed to jump between 32/64bit code segments and and for a the data segment
> of the 32bit emulation (+ the iretd bug currently which I hope will be fixed
> in final hardware) 
> 
> Also note that boot/compressed/* currently does not even link, because the 
> x86-64 toolchain cannot generate relocated 32bit code ATM (the linker chokes
> on the 32bit relocations) The tests we did so far used a precompiled 
> relocated binary compressed/{head,misc}.o from a IA32 build.
...

> > > Sure, go ahead if you weren't missing that basic part of the long mode
> specs.
> 
> > > Thanks.
> > 
> > Nope.  Though I suspect we should do the switch to 64bit mode in
> > setup.S and not have these issues pollute head.S at all.
> 
> I see no advantage in doing it there instead of in head.S

After reading through the long mode specs I now agree.  If you could
be in long mode with the mmu disabled that would be a different story
but you can't and it isn't. 

I was thinking of symmetry with the x86 and how much easier everything
is if you only use one processor mode for the initial boot strap.  No
need for super assemblers etc. Oh well.

On x86 there are some real advantages to moving the segment loads into
setup.S from the various head.S's and they still apply (although to a
lesser extent) to x86-64. This causes less code confusion.

For my kexec stuff I now need to think really hard how I want
to handle x86-64.  What I was thinking would work well in general
is to start the processor it's native/optimal mode with the mmu
disabled.  With x86-64 I can't do this unfortunately :(

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
