Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUBEDLi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 22:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUBEDLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 22:11:38 -0500
Received: from ns.suse.de ([195.135.220.2]:51098 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264132AbUBEDLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 22:11:36 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, amitkale@emsyssoft.com,
       "La Monte H.P. Yarroll" <piggy@timesys.com>, trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel>
	<20040204152137.500e8319.akpm@osdl.org.suse.lists.linux.kernel>
	<402182B8.7030900@timesys.com.suse.lists.linux.kernel>
	<20040204155452.49c1eba8.akpm@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Feb 2004 04:11:34 +0100
In-Reply-To: <20040204155452.49c1eba8.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p73n07ykyop.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> need to take a look at such things and really convice ourselves that
> they're worthwhile.  Personally, I'd only be interested in the basic stub.

What I found always extremly ugly in the i386 stub was that it uses
magic globals to talk to the page fault handler. For the x86-64
version I replaced that by just using __get/__put_user in the memory
accesses, which is much cleaner. I would suggest doing that for i386
too.

Also what's also ugly in i386 is that it uses ugly hooks in traps.c/fault.c.
On x86-64 I instead added generic notifiers (see include/asm-x86_64/die.h
and notify_die in arch/x86_64/kernel/traps.c) 
where both kdb and kgdb and possibly dprobes and other debuggers can hook
in without conflicting patches for the same files from everybody.
I would strongly suggest to adopt such a generic framework for i386 too
to clean up the core kernel <-> debugger interaction. As soon as this
frame work is in just dropping the stub is is very clean.

The x86-64 version should be pretty simple to port to i386 if someone
is interested ...

Another issue is that for modern gdb and frame pointer less debugging
with dwarf2 we really need dwarf2 cfi annotation on i386 too. It is
not as ugly as it used to be because newer binutils have much nicer to
use .cfi_* mnemonics to generate the dwarf2 unwind table. x86-64 uses
that now thanks to Jim Houston. It only works with uptodate binutils,
but I guess that's a reasonable requirement. It's a bit intrusive in
entry.S, but not too bad compared to the old way (take a look at
arch/i386/kernel/vsyscall-sysenter.S to see how the old way looks
like) Having the dwarf2 unwind information in the kernel vmlinux is
useful even independent of kgdb for other tools that look at crash
dumps.

-Andi
