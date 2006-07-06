Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWGFW0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWGFW0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWGFW0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:26:44 -0400
Received: from gateway.dreamworks.com ([64.173.252.40]:52627 "EHLO
	gateway.dreamworks.com") by vger.kernel.org with ESMTP
	id S1750926AbWGFW0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:26:43 -0400
Message-ID: <44AD8E1F.2020509@anim.dreamworks.com>
Date: Thu, 06 Jul 2006 15:26:39 -0700
From: Sean Kamath <skamath@anim.dreamworks.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060524)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about Kernel Reporting Sigfaults in <arch>/mm/fault.c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

[All lines are from 2.6.16's latest git repository from kernel.org.]

We recently started noticing error messages showing up in the messages file
every time a user process segfaulted.  Doing some investigation, it turns
out it's only on x86_64 boxen (the other boxes are i386).  We traced this
down to arch/x86_64/mm/fault.c:do_page_fault() (under bad_area_nosemaphore):

478 if (exception_trace && unhandled_signal(tsk, SIGSEGV)) {
479 	printk(
480 	"%s%s[%d]: segfault at %016lx rip %016lx rsp %016lx error %lx\n",
481 		tsk->pid > 1 ? KERN_INFO : KERN_EMERG,
482 		tsk->comm, tsk->pid, address, regs->rip,
483 		regs->rsp, error_code);
484 }

exception_trace is set to 1 (line 296) and not used anywhere else in the file.

arch/i386/mm/fault.c does not have this.
arch/sparc64/mm/fault.c does not have this.

Oddly, sparc/mm/fault.c *does* have (a version of) this, only ifdef'ed out:

319 #if 0
320 	printk("Fault whee %s [%d]: segfaults at %08lx pc=%08lx\n",
321 	tsk->comm, tsk->pid, address, regs->pc);
322 #endif

This leads me to suspect that the segfault reporting in in x86_64 is
vestigial from a time when it was helpful.

The question(s): Is this intentional (to have segfaults reported on x86_64,
and (possibly) nothing else)?  Or was "exception_trace" supposed to be a
flag but never fleshed out?

I admit, it would be nice to be able to toggle on and off segfault
reporting in the kernel (from a system administration point of view, this
is helpful to be able to go back to developers and say 'your program is
crashing a lot' -- something necessary if you are protecting end-users from
a lot of core files . . .) on all platforms.

Sean
