Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289902AbSAWQco>; Wed, 23 Jan 2002 11:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289905AbSAWQcZ>; Wed, 23 Jan 2002 11:32:25 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:41476 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S289902AbSAWQcQ>;
	Wed, 23 Jan 2002 11:32:16 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201231631.g0NGVcS426406@saturn.cs.uml.edu>
Subject: Re: Athlon/AGP issue update
To: davem@redhat.com (David S. Miller)
Date: Wed, 23 Jan 2002 11:31:38 -0500 (EST)
Cc: benh@kernel.crashing.org, drobbins@gentoo.org,
        linux-kernel@vger.kernel.org, andrea@suse.de, alan@redhat.com,
        akpm@zip.com.au, vherva@niksula.hut.fi, lwn@lwn.net, paulus@samba.org
In-Reply-To: <20020123.060855.26275529.davem@redhat.com> from "David S. Miller" at Jan 23, 2002 06:08:55 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> From: benh@kernel.crashing.org

>> The workaround here would be for AGP to also _unmap_ the AGP pages from
>> the main kernel mapping, which isn't always possible, for example on PPC
>> we use the BATs to map the kernel lowmem, we can't easily make "holes" in
>> a BAT mapping. That's one reason why I did some experiments to make the
>> PPC kernel able to disable it's BAT mapping.
>
> This would be impossible on sparc64 too, since we implement these
> mappings statically with an add instruction in the TLB handler.
>
> But we also lack AGP on sparc64 so...
>
> I don't think your PPC case needs the kernel mappings messed with.
> I really doubt the PPC will speculatively fetch/store to a TLB
> missing address.... unless you guys have large TLB mappings on
> PPC too?

Yup, we do.

The PPC has a regular TLB for 4 kB pages, typically loaded
by a hardware hash-table lookup. It also has the BAT registers,
which act as a 4-entry software reloaded TLB for large mappings.

Early-stage MMU operations go like this:

1. simultaneous lookup in BAT registers and regular TLB
2. use BAT mapping if found
3. use TLB entry if found
4. proceed to page table lookup

So, if a speculative load/store operation happens in kernel memory,
it will definitely not be impeded by any TLB or page restrictions.
The regular TLB is simply ignored when there is a BAT hit.

That leaves 2 things required for the problem:

speculative stores cause cache loads with the dirty bit?
AGP non-coherent?

In the MPC7400 (first "G4") user's manual, I find no indication
that speculative stores occur at all. Motorola's manuals are
horrible though, so who knows...

AGP might be non-coherent. If so, then the CPU should use a
non-coherent mapping to avoid useless memory bus traffic.
User code has access to some cache control instructions,
so one may mark the memory cacheable for better performance
even when it is non-coherent. ("flush when you're done")

BTW, I'd say the Athlon is pretty broken to set the dirty bit
before a store is certain. The CPU has to be able to set this
bit on a clean cache line anyway, so I don't see how this
brokenness could help performance. Indeed, it hurts performance
by causing erroneous memory bus traffic. (It's a bug.)

