Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280101AbRKFTC2>; Tue, 6 Nov 2001 14:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280031AbRKFTCZ>; Tue, 6 Nov 2001 14:02:25 -0500
Received: from ns.suse.de ([213.95.15.193]:59661 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280191AbRKFTCP>;
	Tue, 6 Nov 2001 14:02:15 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: current as segment register was Re: Using %cr2 to reference "current"
In-Reply-To: <E161AkQ-0001Fp-00@the-village.bc.nu.suse.lists.linux.kernel> <Pine.LNX.4.33.0111061006150.2222-100000@penguin.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Nov 2001 20:02:09 +0100
In-Reply-To: Linus Torvalds's message of "6 Nov 2001 19:20:45 +0100"
Message-ID: <p73lmhjyb7y.fsf_-_@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:


> There are some people who think that the 5kB stack we have now is too
> small ;(

It was too small on x86-64 ;)

> 
> So it would basically be a small per-CPU/thread area, not just the "struct
> task_struct".

x86-64 has such a per cpu area. It is accessed via gs. It is needed to make
the SYSCALL system entry code work. So far I didn't move
that many fields into it to keep the patches small, but current is just
a field in the PDA (processor data area). The x86-64 has special instructions
to quickly save/restore gs on kernel entry.

One nasty thing is that lea doesn't work on segment registers. It needs
an quite ugly inline assembly mess similar to get/put_user to implement
read/write/add_pda functions for the fundamental types. To implement
that properly without hardcoded offsets it is also needed to have an
offset.c like many other ports that puts structure offsets at compile
time into an include file.

Also all system entry have to enter with interrupts off to avoid races
in switching %gs.

So far I have not moved the task_struct into a slab cache yet, but it is
a trivial step now because all the infrastructure is there.

The code size impact seems to be minimal between current as rsp & mask and 
%gs:current_offset.  smp_processor_id() is much cheaper however. The current
x86 implementation of that was quite bad.

Long term I hope more per CPU data (e.g. in networking, in the scheduler or 
in interrupt handling) should migrate into the per data area.
Accessing the data there is much more efficent than indexing an cache line
padded array, and it saves a lot of cache too because the cache lines can be 
shared.

-Andi

