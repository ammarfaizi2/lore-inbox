Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285666AbSALKtP>; Sat, 12 Jan 2002 05:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285703AbSALKtE>; Sat, 12 Jan 2002 05:49:04 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:15065 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S285666AbSALKsy>; Sat, 12 Jan 2002 05:48:54 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 12 Jan 2002 02:48:53 -0800
Message-Id: <200201121048.CAA11276@adam.yggdrasil.com>
To: hpa@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
Cc: ak@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote, in response to Andi Kleen:
>You don't need CMPXCHG8B to do efficient inline mutexes.  In fact, the
>pthreads code for i386 uses the same mutexes the kernel does (LOCK INC
>based, I believe), complete with section hacking to make them
>efficiently inlinable -- and then they're put inside a function call.
[...]

	Your comment prompted me to look at
linux-2.5.2-pre11/include/asm-i386/spinlock.h, and I now believe that
the "lock; decb" that it uses for grabbing spinlocks will return an
incorrect success if 255 or more processors are waiting on the same
spinlock.  I don't know if anybody has ever built a shared memory x86
multiprocessor with 257 (not a typo) or more CPU's, but it's possible
to imagine.  It's also possible to imagine this scenario happening
with even just one processor and a preemtable kernel.  I believe that
the current preemtable kernel patch limits the number of preempted
processes to something like four or six, but that's just a temporary
limitation of the current version.

	If we get the point where this scenario really could happen,
then maybe the spin lock counter type should be expanded from one byte
to four.  I think we already assume four byte alignment in
asm-i386/semaphore.h, which uses a four byte count (I think "lock" is
not guaranteed to work across page boundaries).

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
