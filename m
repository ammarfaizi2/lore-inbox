Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267687AbSLTC2z>; Thu, 19 Dec 2002 21:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267691AbSLTC2z>; Thu, 19 Dec 2002 21:28:55 -0500
Received: from crack.them.org ([65.125.64.184]:53220 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267687AbSLTC2x>;
	Thu, 19 Dec 2002 21:28:53 -0500
Date: Thu, 19 Dec 2002 21:37:36 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       "H. Peter Anvin" <hpa@transmeta.com>,
       Terje Eggestad <terje.eggestad@scali.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021220023735.GA25030@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	"H. Peter Anvin" <hpa@transmeta.com>,
	Terje Eggestad <terje.eggestad@scali.com>,
	Ulrich Drepper <drepper@redhat.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	Hugh Dickins <hugh@veritas.com>,
	Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20021220005333.GA20227@nevyn.them.org> <Pine.LNX.4.44.0212191746200.4545-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212191746200.4545-100000@home.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 05:47:55PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 19 Dec 2002, Daniel Jacobowitz wrote:
> > >
> > >    (ptrace also doesn't actually allow you to look at the instruction
> > >    contents in high memory, so gdb won't see the instructions in the
> > >    user-mode fast system call trampoline even when it can single-step
> > >    them, and I don't think I'll bother to fix it up).
> >
> > This worries me.  I'm no x86 guru, but I assume the trampoline's setting of
> > the TF bit will kick in right around the following 'ret'.  So the
> > application will stop and GDB won't be able to read the instruction at
> > PC.  I bet that makes it unhappy.
> 
> It doesn't make gdb all that unhappy, everything seems to work fine
> despite the fact that gdb decides it just can't display the instructions.

Yeah; sometimes it will generate that error in the middle of
single-stepping over something larger, though, and it breaks you out of
whatever you were doing.

> > Shouldn't be that hard to fix this up in ptrace, though.
> 
> Or even in user space, since the high pages are all the same in all
> processes (so gdb doesn't even strictly need ptrace, it can just read it's
> _own_ codespace there). But yeah, we could make ptrace aware of the magic
> pages.

I need to get back to my scheduled ptrace cleanups.  Meanwhile, here's
a patch to do this.  Completely untested, like all good patches; but
it's pretty simple.

===== arch/i386/kernel/ptrace.c 1.17 vs edited =====
--- 1.17/arch/i386/kernel/ptrace.c	Wed Nov 27 18:14:11 2002
+++ edited/arch/i386/kernel/ptrace.c	Thu Dec 19 21:33:37 2002
@@ -21,6 +21,7 @@
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/debugreg.h>
+#include <asm/fixmap.h>
 
 /*
  * does not yet catch signals sent when the child dies.
@@ -196,6 +197,18 @@
 	case PTRACE_PEEKDATA: {
 		unsigned long tmp;
 		int copied;
+
+		/* Allow ptrace to read from the vsyscall page.  */
+		if (addr >= FIXADDR_START && addr < FIXADDR_TOP &&
+		    (addr & 3) == 0) {
+			int idx = virt_to_fix (addr);
+			if (idx == FIX_VSYSCALL) {
+				tmp = * (unsigned long *) addr;
+				ret = put_user (tmp, (unsigned long *) data);
+				break;
+			}
+		}
+			
 
 		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
 		ret = -EIO;


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
