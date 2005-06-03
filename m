Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVFCCSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVFCCSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 22:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVFCCSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 22:18:12 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:52695 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261278AbVFCCRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 22:17:53 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Lynch <rusty.lynch@intel.com>
Cc: linux-ia64@vger.kernel.org,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       Hien Nguyen <hien@us.ibm.com>
Subject: Re: [RFC] ia64 function return probes 
In-reply-to: Your message of "Wed, 01 Jun 2005 14:39:22 MST."
             <200506012139.j51LdMhY031546@linux.jf.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Jun 2005 12:17:29 +1000
Message-ID: <7459.1117765049@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005 14:39:22 -0700, 
Rusty Lynch <rusty.lynch@intel.com> wrote:
>The following is an implementation of the ia64 specific parts for implementing
>the function return probes functionality that is a part of kprobes.  There 
>were some assumptions about how the architectures work inside kernel/kprobes.c
>that force me to do some odd things in this implementation.
>[snip]
>Ok, that was the idea.  For ia64 complexities came up with respect to:
>
>* the assumption that kernel/kprobes.c is working with a 
>  stacked based architecture
>
>* the assumption that changing the return address to kretprobe_trampoline()
>  will always result in the first instruction of of kretprobe_trampoline
>  being executed.

Normal br.call/return will always execute the first slot of the return
address.  br.call bn sets bn to IP+16, i.e. the start of the next
bundle, with no slot data.  br.return bn returns to the first slot in
the bundle defined by bn.  Intel IA64 arch vol3, 24531904.pdf page
3:21.

What made you think that you needed to handle return to a non-zero slot
number?  The only instruction that can return to a non-zero slot number
is rfi and, by definition, code that is entered for an interrupt does
not have a return address in any branch register.

>The following patch works around these problems by:
>
>* Providing an empty kretprobe_trampoline(), but we don't really 
>  use it as our trampoline function.  Instead we provide:
>
>	/*
>	 * void ia64_kretprobe_trampoline(void):
>	 *
>	 * When a return probe is set on a given function, it's return
>	 * address (which really just points to the bundle) is set for
>	 * this single bundle function.
>	 *
>	 * We don't know which slot of the bundle will be set, so we set
>	 * a break using a special immediate value to gain control in
>	 * each case so the registered return probe can be called and then
>	 * restore the cr->iip  back to the real address
>	 * (i.e. the original return address)
>	 */
>GLOBAL_ENTRY(ia64_kretprobe_trampoline)
>{ .mii
>	break.m __IA64_BREAK_RPROBE
>	break.i __IA64_BREAK_RPROBE
>	break.i __IA64_BREAK_RPROBE
>}
>END(ia64_kretprobe_trampoline)
>
>  ... and then handle the break interrupts using this new reserved immediate
>  value by just directly calling trampoline_probe_handler().

Implementing a return probe by changing the return address will prevent
us from getting any backtrace past the return probe.  If the function
being probed, or any of its callee functions, gets an error then the
backtrace will terminate at ia64_kretprobe_trampoline, the unwinder may
even loop.  This makes it impossible to find out what called the
function.

One option is to hack return probes into the unwinder as yet another a
special case - not nice.  Another option is this :-

* On entry to the function, arch_prepare_kretprobe() saves the current
  value of b0 in [sp+8] (architecture defined scratch area on stack),
  and saves the current value of ar.pfs in [sp].

* arch_prepare_kretprobe() bumps sp by 16 bytes, to account for the
  saved b0 and ar.pfs.

* arch_prepare_kretprobe() sets b0 to ia64_kretprobe_trampoline.

* arch_prepare_kretprobe() sets the cfm field in ar.pfs to 0.  Of
  course this is the ar.pfs that was saved in pt_regs when the function
  being hooked was entered.

* The function being hooked is entered.  When the function returns, it
  does so to ia64_kretprobe_trampoline with cfm = 0, i.e.
  ia64_kretprobe_trampoline has a zero sized register frame.

* ia64_kretprobe_trampoline looks like this.  Compiled but not tested.

GLOBAL_ENTRY(ia64_kretprobe_trampoline)
	.prologue
	.label_state 1
	.fframe 16
	.savesp b0, 8
	.savesp ar.pfs, 0

	break.m __IA64_BREAK_RPROBE
	ld8 r3=[sp]		// original ar.pfs
	add r2=8, sp		// original b0 was saved in sp+8
	;;
	ld8 r2=[r2]		// original b0

	.body
	mov ar.pfs=r3		// restore original ar.pfs
	;;
	mov b0=r2		// restore original b0
	add sp=-16, sp		// arch_prepare_kretprobe bumped stack by 16 bytes

	.copy_state 1
	br.ret.sptk.many rp
END(ia64_kretprobe_trampoline)

If I got my unwind directives right, that will make the backtrace look
like this

  ...
  hooked function
  ia64_kretprobe_trampoline
  whatever called the hooked function
  ...

It also means that the handler for __IA64_BREAK_RPROBE only has to log
the fact that the function returned then resume at the instruction
after __IA64_BREAK_RPROBE.  ia64_kretprobe_trampoline then returns to
the original caller.

>Index: linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
>===================================================================
>--- linux-2.6.12-rc5.orig/arch/ia64/kernel/kprobes.c
>+++ linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
>@@ -1,4 +1,4 @@
>-/*
>+ /*

Interesting addition of white space there :)

