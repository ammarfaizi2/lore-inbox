Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136418AbRD3AOk>; Sun, 29 Apr 2001 20:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136417AbRD3AOe>; Sun, 29 Apr 2001 20:14:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30039 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136409AbRD3AOX>; Sun, 29 Apr 2001 20:14:23 -0400
Date: Mon, 30 Apr 2001 02:13:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010430021345.E923@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca> <9cg7t7$gbt$1@cesium.transmeta.com> <3AEBF782.1911EDD2@mandrakesoft.com> <15083.64180.314190.500961@pizda.ninka.net> <20010429153229.L679@nightmaster.csn.tu-chemnitz.de> <200104291848.f3TIm6821037@vindaloo.ras.ucalgary.ca> <20010429221159.U706@nightmaster.csn.tu-chemnitz.de> <20010429161827.B17539@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010429161827.B17539@xi.linuxpower.cx>; from greg@linuxpower.cx on Sun, Apr 29, 2001 at 04:18:27PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 04:18:27PM -0400, Gregory Maxwell wrote:
> having both the code and a comprehensive jump-table might become tough in a

In the x86-64 implementation there's no jump table. The original design
had a jump table but Peter raised the issue that indirect jumps are very
costly and he suggested to jump to a fixed virtual address instead, I
agreed with his suggestion. So this is what I implemented for x86-64
with regard to the userspace vsyscall API (which will be used by glibc):

	enum vsyscall_num {
		__NR_vgettimeofday,
		__NR_vtime,
	};
	
	#define VSYSCALL_ADDR(vsyscall_nr) (VSYSCALL_START+VSYSCALL_SIZE*(vsyscall_nr))

the linker can prelink the vsyscall virtual address into the binary as a
weak symbol and the dynamic linker will need to patch it only if
somebody is overriding the weak symbol with a LD_PRELOAD.

Virtual address space is relatively cheap. Currently the 64bit
vgettimeofday bytecode + data is nearly 200 bytes, and the first two
slots are large 512bytes each. So with 1024 bytes we do the whole thing,
and we still have space for further 6 vsyscalls without paying any
additional tlb entry.

(the implementation of the above #define will change shortly but the
VSYSCALL_ADDR() API for glibc will remain the same)

Andrea
