Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbVLLP3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVLLP3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 10:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVLLP3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 10:29:49 -0500
Received: from jade.aracnet.com ([216.99.193.136]:39341 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S1750789AbVLLP3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 10:29:48 -0500
Message-ID: <439D9767.2000208@BitWagon.com>
Date: Mon, 12 Dec 2005 07:29:43 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: control placement of vDSO page
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The vDSO page is getting in the way of applications on i686 (i386).
There is a performance problem, a problem with a dangling pointer
in the kernel, and a loss of control in the kernel<->user interface.
A possible solution might be a new system call to move the vDSO page.

Performance: the kernel chooses the vDSO page after mapping the main
program and the PT_INTERP [see fs/binfmt_elf.c].  If pre-linking chose
that same page for some subsequent shared library, then the pre-linking
is discarded, which costs time.  In Fedora Core 4 i686 with random vDSO
placement, the probability is about 7% that a main program with just one
shared library must relocate libc.so.6.  Cascading conflicts and costs
are likely; a program with dozens of shared libs is almost certain
to require expensive runtime relocation processing of shared libraries.

Dangling pointer: setup_frame() in arch/i386/kernel/signal.c uses
        restorer = current->mm->context.vdso + (long)&__kernel_sigreturn;
whenever !(.sa_flags & SA_RESTORER).  Unfortunately, context.vdso is
never changed, so if the user re-maps the vDSO page then the kernel
has a dangling pointer which makes user return from signal unreliable.

Loss of control: in a 32-bit address there are at most one million
4KB pages.  Maintaining contiguous ranges for large arrarys is a problem.
Having no control over placement of the vDSO page makes things worse.
Programs that audit or measure the running of other programs in the
same address space, desire to place the vDSO page after mapping
the programs that are being examined.

Possible solution: a new system call  move_vdso(old_addr, new_addr, flags).
Check that current vDSO was at old_addr, else error.  Change vDSO page
under control of flags like in mmap(): new_addr is hint (place to start
search) or required address if MAP_FIXED.  Return value is new vDSO address.

For some history and examples see
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=162797

Comments?

-- 
John Reiser, jreiser@BitWagon.com
