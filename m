Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbUCBXgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUCBXgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:36:39 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:50316 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S261726AbUCBXgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:36:37 -0500
Date: Tue, 2 Mar 2004 16:36:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net, amit@av.mvista.com,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [Kgdb-bugreport] [KGDB][RFC] Send a fuller T packet
Message-ID: <20040302233635.GM20227@smtp.west.cox.net>
References: <20040302220233.GG20227@smtp.west.cox.net> <404518AD.40606@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404518AD.40606@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 03:28:45PM -0800, George Anzinger wrote:

> Tom Rini wrote:
> >Hello.  Since a 'T' packet is allowed to send back information on an
> >arbitrary number of registers, and on PPC32 we've always been including
> >information on the stack pointer and program counter, I was wondering
> >what people thought of the following patch:
> >
> >diff -u linux-2.6.3/include/asm-x86_64/kgdb.h 
> >linux-2.6.3/include/asm-x86_64/kgdb.h
> >--- linux-2.6.3/include/asm-x86_64/kgdb.h	2004-02-27 
> >11:30:37.445782703 -0700
> >+++ linux-2.6.3/include/asm-x86_64/kgdb.h	2004-03-02 
> >14:42:47.854532793 -0700
> >@@ -48,6 +48,10 @@
> > /* Number of bytes of registers.  */
> > #define NUMREGBYTES (_LASTREG*8)
> > 
> >+#define PC_REGNUM	_PC	/* Program Counter */
> >+#define SP_REGNUM	_RSP	/* Stack Pointer */
> >+#define PTRACE_PC	rip	/* Program Counter, in ptrace regs. */
> 
> I would really like to keep this stuff out of kgdb.h since it may be 
> included by the user to pick up the BREAKPOINT() (which, by the way we 
> should standardize as I note that here it has () while not on the current 
> x86).

It's BREAKPOINT() everywhere:
$ grep BREAKPOINT include/asm-*/kgdb.h
include/asm-i386/kgdb.h:#define BREAKPOINT() asm("   int $3");
include/asm-ppc/kgdb.h:#define BREAKPOINT()             asm(".long 0x7d821008") /* twge r2, r2 */
include/asm-x86_64/kgdb.h:#define BREAKPOINT() asm("   int $3");

> Isn't there a kgdb_local.h which is used only by kdgd and friends?  We 
> really do want to keep the name space as clean as possible to prevent 
> possible conflicts.

The simple answer is you don't call BREAKPOINT() in your code anywhere.
You call breakpoint() or kgdb_schedule_breakpoint().
The split here is different in that <linux/kgdb.h> should be standalone
(it's not, _yet_).

But this is all an aside to my question. :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
