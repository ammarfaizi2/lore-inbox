Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbSLTVTv>; Fri, 20 Dec 2002 16:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265650AbSLTVTv>; Fri, 20 Dec 2002 16:19:51 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:22310 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S265570AbSLTVTt>; Fri, 20 Dec 2002 16:19:49 -0500
Date: Fri, 20 Dec 2002 13:27:49 -0800
Message-Id: <200212202127.gBKLRnB32749@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: PTRACE_GET_THREAD_AREA
In-Reply-To: Daniel Jacobowitz's message of  Friday, 20 December 2002 10:48:29 -0500 <20021220154829.GB17007@nevyn.them.org>
X-Zippy-Says: My life is a patio of fun!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In general, I like this.  However, I have to ask one question: how much
> of the i386-centrism of this patch is actually necessary?  What
> information does GDB _use_ from this, and is there some way we can expose
> it that will be useful in other places?

GDB uses this only at the behest of NPTL's libthread_db, and it only ever
wants the base address of a descriptor presumed to be a flat 4GB data
segment.  So that is just one word per index that you might really be using
in practice.  The reason I made all the information available was the
simple principle that that's what ptrace is for--ideally gdb ought to fetch
the descriptors itself whenever a segment register has a nonstandard value,
and show the user the full details so as not to presume what is going on in
the program.  But I don't have a direct practical need to care about that.

It is also unusual to i386 that there are multiple slots you might want to
ask about, and that the number of potential slots actually available is a
kernel implementation detail rather than an instrinsic architecture limit,
and that the slot indices you know about from register state have a nonzero
origin whose value is also a kernel implementation detail.  Using
PTRACE_PEEKUSR, whether to access just the base-address word or all three
words of each virtual segment descriptor, would encode GDT_ENTRY_TLS_ENTRIES
into the struct user layout and require the user to know GDT_ENTRY_TLS_MIN.

> Eventually most or all targets will have thread-specific data
> implemented; I don't want to have to redo this for each one.

Most architectures use a normal register.  The only other architectures
that do something different AFAIK are x86-64 and Alpha.  I don't know of
anything other than i386 where there is anything other than a plain word
for each slot.  On x86-64 there are exactly two possible slots in the
architecture (fs_base, gs_base); these are already in struct user, so
nothing new is needed.  On Alpha, I suppose anything could be possible
since it's implemented in PAL code, but in reality there is exactly one
slot and if that's not in struct user then it could be.

> Your choice of numbers is fine if this remains i386-centric; if we
> expect there to be a common interface then it should go in
> <linux/ptrace.h> and the 0x4200 range instead.

The interface in my patches is i386-specific.  If we choose a common
interface, it probably won't look like that one or use those names.

A machine-independent interface without the problems cited above would be
something like ptrace(PTRACE_GET_TLS, idx, &word), where IDX is a
machine-dependent selector such as segment register value on i386, 0/1 for
fs/gs on x86-64, and ignored on Alpha.  (For i386, that could also fetch
LDT values I suppose.)
