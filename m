Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUFLNoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUFLNoj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 09:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUFLNoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 09:44:39 -0400
Received: from nmts-mur.murom.net ([213.177.124.6]:44944 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S264777AbUFLNoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 09:44:32 -0400
Date: Sat, 12 Jun 2004 17:44:14 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, stian@nixia.no
Subject: Re: timer + fpu stuff locks my console race
Message-ID: <20040612134413.GA3396@sirius.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0406112308100.13607-100000@chimarrao.boston.redhat.com>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Jun 2004 23:50:25 -0400, Rik van Riel wrote:

> On Fri, 11 Jun 2004, Rik van Riel wrote:
>=20
>> Reproduced here, on my test system running a 2.6 kernel.
>> I did get a kernel backtrace over serial console, though ;)
>=20
> Now I'm not sure if the process is actually stuck in kernel
> space or if it's looping tightly through both kernel and
> user space...

Here is the culprit (include/asm-i386/i387.h):

#define __clear_fpu( tsk )					\
do {								\
	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
		asm volatile("fwait");				\
		(tsk)->thread_info->status &=3D ~TS_USEDFPU;	\
		stts();						\
	}							\
} while (0)

This is called in flush_thread() (which is used in flush_old_exec()
and therefore in sys_execve() path) and in restore_i387_fsave(),
restore_i387_fxsave() (which are reached from sys_sigreturn() and
sys_rt_sigreturn()).

The buggy code in the Stian's program corrupts the FPU state - in
particular, it results in some exception bits being set in the FPU
status word.  In this state the next FP command (except non-waiting
commands, like fnsave and fninit) will raise the FP error exception
(trap 16).  The "fwait" above happens to be that next command.

The FP error handler do_coprocessor_error() calls math_error() for
real work (both in arch/i386/traps.c).  math_error() calls
save_init_fpu(), which saves the FPU state in current->thread.i387 and
sets the TS flag; then math_error() queues a SIGFPE to the task and
returns.  If the fault comes from userspace, this is enough - on the
return path the pending signal will be noticed and delivered.
However, in this case the fault happens in the kernel code, therefore
execution just resumes at the same point - trying to reexecute that
fwait again.

At this time, however, the TS flag is set, so we get another trap -
trap 7, device_not_available.  The trap handler calls
math_state_restore(), which clears the TS flag and reloads the FP
state from current->thread.i387.  Then it returns, and the faulting
instruction is restarted again.  But it gets the same FP error
exception as at the first time...

So the CPU is stuck handling endless faults in kernel mode.

How to fix this?  A quick and dirty fix is to remove the problematic
fwait from __clear_fpu(); 2.2.x kernels did not have it - probably it
was added in some 2.3.x.

--- linux-2.6.6/include/asm-i386/i387.h.fp-lockup	2004-05-10 06:33:06 +0400
+++ linux-2.6.6/include/asm-i386/i387.h	2004-06-12 17:25:56 +0400
@@ -51,7 +51,6 @@
 #define __clear_fpu( tsk )					\
 do {								\
 	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
-		asm volatile("fwait");				\
 		(tsk)->thread_info->status &=3D ~TS_USEDFPU;	\
 		stts();						\
 	}							\

In this case we will ignore a pending FP exception at execve() or
sigreturn() instead of raising SIGFPE (which was probably intended by
whoever put an fwait there).

If we want to be pedantic and care about such pending exceptions, we
should add a check for kernel addresses to do_coprocessor_error() and
add fixup_exception there, like we do for protection faults, so that
the handler will not attempt to restart the failing instruction again.

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAywitW82GfkQfsqIRAsJ5AJ9NqJX4w9xZFq3hOTRz6CvrqRPlxgCeLXjh
a3CvwEek3hgGzqUOozQvoys=
=qXPO
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
