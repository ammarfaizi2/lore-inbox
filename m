Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbUBERum (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUBERum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:50:42 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:29319 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S266520AbUBERuk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:50:40 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: kgdb support in vanilla 2.6.2
Date: Thu, 5 Feb 2004 23:20:04 +0530
User-Agent: KMail/1.5
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org,
       "La Monte H.P. Yarroll" <piggy@timesys.com>, trini@kernel.crashing.org,
       George Anzinger <george@mvista.com>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <20040204155452.49c1eba8.akpm@osdl.org.suse.lists.linux.kernel> <p73n07ykyop.fsf@verdi.suse.de>
In-Reply-To: <p73n07ykyop.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402052320.04393.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 Feb 2004 8:41 am, Andi Kleen wrote:
> Andrew Morton <akpm@osdl.org> writes:
> > need to take a look at such things and really convice ourselves that
> > they're worthwhile.  Personally, I'd only be interested in the basic
> > stub.
>
> What I found always extremly ugly in the i386 stub was that it uses
> magic globals to talk to the page fault handler. For the x86-64
> version I replaced that by just using __get/__put_user in the memory
> accesses, which is much cleaner. I would suggest doing that for i386
> too.

May be I am missing something obvious. When debugging a page fault handler if 
kgdb accesses an swapped-out user page doesn't it deadlock when trying to 
hold mm semaphore?

I use the global to let page fault handler that this access is from kgdb so 
don't try to load any pages, report an error instead.

>
> Also what's also ugly in i386 is that it uses ugly hooks in
> traps.c/fault.c. On x86-64 I instead added generic notifiers (see
> include/asm-x86_64/die.h and notify_die in arch/x86_64/kernel/traps.c)
> where both kdb and kgdb and possibly dprobes and other debuggers can hook
> in without conflicting patches for the same files from everybody.
> I would strongly suggest to adopt such a generic framework for i386 too
> to clean up the core kernel <-> debugger interaction. As soon as this
> frame work is in just dropping the stub is is very clean.

I liked these.  Never got time to integrate them.

>
> The x86-64 version should be pretty simple to port to i386 if someone
> is interested ...
>
> Another issue is that for modern gdb and frame pointer less debugging
> with dwarf2 we really need dwarf2 cfi annotation on i386 too. It is
> not as ugly as it used to be because newer binutils have much nicer to
> use .cfi_* mnemonics to generate the dwarf2 unwind table. x86-64 uses
> that now thanks to Jim Houston. It only works with uptodate binutils,
> but I guess that's a reasonable requirement. It's a bit intrusive in
> entry.S, but not too bad compared to the old way (take a look at
> arch/i386/kernel/vsyscall-sysenter.S to see how the old way looks
> like) Having the dwarf2 unwind information in the kernel vmlinux is
> useful even independent of kgdb for other tools that look at crash
> dumps.

George has coded cfi directives i386 too. He can use them to backtrace past 
irqs stack.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

