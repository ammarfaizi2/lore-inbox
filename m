Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293596AbSDQQb4>; Wed, 17 Apr 2002 12:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293603AbSDQQbz>; Wed, 17 Apr 2002 12:31:55 -0400
Received: from 16-159.104.popsite.net ([66.19.52.159]:41220 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S293596AbSDQQbz>; Wed, 17 Apr 2002 12:31:55 -0400
Message-Id: <200204171631.g3HGViA02265@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: ebiederm@xmission.com (Eric W. Biederman)
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 arch subdivision into machine types for 2.5.8 
In-Reply-To: Message from ebiederm@xmission.com (Eric W. Biederman) 
   of "17 Apr 2002 01:00:10 MDT." <m1it6qizd1.fsf@frodo.biederman.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Apr 2002 11:31:44 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The 8 byte GDT alignment requirement in boot/setup.S was the biggest problem 
> (until I found it empirically), if that's not done, they crash when jumping to 
> protected mode.

ebiederm@xmission.com said:
> It sounds like we may have been getting lucky on that one.  I guess an
> explicit align directive fixes that. 

No, most CPUs don't require this alignment.  It was only a requirement of the 
voyager quad processor cards.  I can boot the system on 6 cpus (3 dyads) 
perfectly happily with the gdt anywhere.  I suspect it's because the Quad 
cards use a clever memory cache line invalidation scheme to exchange 
interprocessor interrupts, but I've never investigated.

> Interesting, so reading this and skimming your patch the voyager BIOS
> is a descendant of the XT & AT BIOS.  But it is a very weird one.

Yes, it tries to use the basic AT BIOS sequence.  It's wierd because the 
initial BIOS (actually called SUS) setup is done by a small i386 that's part 
of the baseboard (voyagers can actually boot up and tell you they don't have 
any CPUs).  This CPU does all the peripheral configuration too, so the BIOS 
that the real CPUs see is very hacked down.

The only reason they have that much BIOS functionality is because the OS they 
boot for reference disc configuration is an ancient version of DOS.

> What was the gate a20 issue, you fixed in setup.S?

Well, the a20 stuff worked pretty much OK until someone re-did the way we 
started setting and checking it.  All the #defines really do is ignore all the 
fancy a20 gate setting stuff and just use the standard one (after all, if I'm 
never going to use the code, there's not much point having it in the boot 
sequence).


> BIOS-provided physical RAM map:
>  Voyager-SUS: 0000000000000000 - 0000000000093000 (usable)
>                                             ^^^^^ usually around 9fffff
>  Voyager-SUS: 0000000000100000 - 000000003ffff000 (usable) 

ebiederm@xmission.com said:
> Certainly a different one.  I find it interesting how none of these
> maps reserve the bios interrupt table, or the BIOS data area.
> Basically the first 1280 bytes of memory...  And they just assume
> everyone will know better and not touch them :) 

Well, technically the BIOS interrupt table isn't "reserved" memory because you 
can and do relocate it and reuse the memory.  There's no e820 classification 
for "don't mess with this if you want BIOS to work but otherwise you're free 
to trash it".  "reserved" at least as far as voyager is concerned means "never 
ever treat this as ordinary memory".

The missing 0xfff at the top is the memory used to send IPIs (it actually 
overlays real memory and you can read and write it as normal memory, it will 
just cause havoc with SMP).

James


