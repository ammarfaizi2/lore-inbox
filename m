Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265880AbUFDQSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265880AbUFDQSd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265863AbUFDQQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:16:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:58758 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265848AbUFDQPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:15:50 -0400
Date: Fri, 4 Jun 2004 18:13:04 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: arjanv@redhat.com, luto@myrealbox.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, akpm@osdl.org, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,  
 2.6.7-rc2-bk2
Message-Id: <20040604181304.325000cb.ak@suse.de>
In-Reply-To: <Pine.LNX.4.58.0406040856100.7010@ppc970.osdl.org>
References: <20040602205025.GA21555@elte.hu>
	<20040603230834.GF868@wotan.suse.de>
	<20040604092552.GA11034@elte.hu>
	<200406040826.15427.luto@myrealbox.com>
	<Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org>
	<20040604154142.GF16897@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org>
	<20040604155138.GG16897@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0406040856100.7010@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004 09:02:26 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Fri, 4 Jun 2004, Arjan van de Ven wrote:
> > 
> > I know that in a FC1 full install there are less than 5 binaries that don't
> > run with NX. (one uses nested functions in C and passes function pointers to
> > the inner function around which causes gcc to emit a stack trampoline, and
> > gcc then marks the binary as non-NX, the others have asm in them that we
> > didn't fix in time to be properly marked).
> 
> If things are really that good, why are we even worrying about this?

It's only that good because gcc handles it transparently.

Also more weird exe
 
> So instead of having complex things to try to turn NX on for suid, we 
> should aim to turn ot on as widely as possible, _even_if_ that means that 
> people who upgrade hardware might have to do some trivial MIS stuff.

That is what is currently done on x86-64 in the major distributions
(SUSE,RedHat) at least.

Anything compiled with the new gcc is marked NX on unless
it has a trampoline. Old executables are run with NX off.

I would keep the default for old executables off, because
the applications which need the gcc trampolines are more
widely spread that one first things (e.g. most Ada programs
compiled by GNAT and GNAT itself require this and we 
got a few other reports of third party programs breaking)
But that's handled by the policy of only doing it for programs
compiled by the new gcc.

Of course that is only for the stack. Making the heap non executable
is another can of worms. I don't know if Fedora does that
too, SUSE and mainline x86-64 doesn't.

 
> Make a kernel bootup option to default to legacy mode if somebody
> literally has trouble booting and fixing their thing due to "init" or
> similar being one of the problematic cases. Together with a printk() that 
> says which executable triggered, it should be trivial to clean up a 
> system.

That exists too on x86-64:

/* noexec32=opt{,opt} 

Control the no exec default for 32bit processes. Can be also overwritten
per executable using ELF header flags (e.g. needed for the X server)
Requires noexec=on or noexec=noforce to be effective.

Valid options: 
   all,on    Heap,stack,data is non executable.         
   off       (default) Heap,stack,data is executable
   stack     Stack is non executable, heap/data is.
   force     Don't imply PROT_EXEC for PROT_READ 
   compat    (default) Imply PROT_EXEC for PROT_READ

*/

and the same for 64bit processes:

/* noexec=on|off
Control non executable mappings for 64bit processes.

on      Enable
off     Disable
noforce (default) Don't enable by default for heap/stack/data, 
        but allow PROT_EXEC to be effective

*/ 

BTW 64bit processes mostly have the same problem - there are some
that break since the first x86-64 distributions didn't use NX.

-Andi
