Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbUCSQUY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 11:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUCSQUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 11:20:24 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:6822 "EHLO fed1mtao08.cox.net")
	by vger.kernel.org with ESMTP id S263080AbUCSQUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 11:20:10 -0500
Date: Fri, 19 Mar 2004 09:20:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Document hooks in kgdb
Message-ID: <20040319162009.GE4569@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  The following is my first attempt at documenting the hooks found in
the KGDB found on kgdb.sf.net.  I'm not quite sure about the description
of some of the optional hooks (used under hw breakpoints) so corrections
/ suggestions welcome.  After I got done with it, it hit me that maybe I
should have done this in the code, and in DocBook format, so I'll go and
do that next...

<-- snip -->
This is an attempt to document the various architecture specific functions
that are part of KGDB.  There are a number of optional functions, depending
on hardware setps, for which empty defaults are provided.  There are also
functions which must be implemented and for which no default is provided.

The required functions are:
int kgdb_arch_handle_exception(int vector, int signo, int err_code,
		char *InBuffer, char *outBuffer, struct pt_regs *regs)
	This function MUST handle the 'c' and 's' command packets,
	as well packets to set / remove a hardware breakpoint, if used.

void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
	Convert the ptrace regs in regs into what GDB expects to
	see for registers, in gdb_regs.

void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
	Like regs_to_gdb_regs, except that the process in p is sleeping,
	so we cannot get as much information.

void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
	Convert the GDB regs in gdb_regs into the ptrace regs pointed
	to in regs.

The optional functions are:
int kgdb_arch_init(void) :
	This function will handle the initalization of any architecture
	specific hooks.  If there is a suitable early output driver,
	kgdb_serial can be pointed at it now.

void kgdb_printexceptioninfo(int exceptionNo, int errorcode, char *buffer)
	Write into buffer and information about the exception that has
	occured that can be gleaned from exceptionNo and errorcode.

void kgdb_disable_hw_debug(struct pt_regs *regs)
	Disable hardware debugging while we are in kgdb.

void kgdb_correct_hw_break(void)
	A hook to allow for changes to the hardware breakpoint, called
	after a single step (s) or continue (c) packet, and once we're about
	to let the kernel continue running.

void kgdb_post_master_code(struct pt_regs *regs, int eVector, int err_code)
	Store the raw vector and error, for later retreival.

void kgdb_shadowinfo(struct pt_regs *regs, char *buffer, unsigned threadid)
struct task_struct *kgdb_get_shadow_thread(struct pt_regs *regs, int threadid)
struct pt_regs *kgdb_shadow_regs(struct pt_regs *regs, int threadid)
	If we have a shadow thread (determined by setting
	kgdb_ops->shadowth = 1), these functions are required to return
	information about this thread.

-- 
Tom Rini
http://gate.crashing.org/~trini/
