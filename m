Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVEaRDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVEaRDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVEaQ7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:59:33 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:11204 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261986AbVEaQ51
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:57:27 -0400
In-Reply-To: <428DB76B.5060009@fujitsu-siemens.com>
Subject: Re: Again: UML on s390 (31Bit)
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org, Ulrich Weigand <uweigand@de.ibm.com>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OFB257B050.D41F8BE1-ON41257012.005BE91F-41257012.005D25B2@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 31 May 2005 17:57:24 +0100
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 31/05/2005 18:57:25
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've prepared and attached a small program that easily can reproduce
> > the problem. I hope this will help to find a viable solution.
>
> Here is a slightly modified version of my testtool. The new version
> covers the fact, that in certain situations UML must avoid syscall
> restarting, even if PSWADDR is not modified.

Ok, Uli convinced me that the original patch to clear regs->traps if
the system call has been canceled on the first call to syscall_trace
is the correct thing to do. If the tracer chooses to invalidate the
system call of the traced process then the complete handling of the
function executed for the system call is done in the tracer. That
includes system call restarting in the case that another system call
is involved to implement the function. The point is that the traced
process did not execute a system call, ergo no system call restarting
may take place.
So after a long discussion I'll just use a slightly modified version
of the original patch:

Index: ptrace.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/s390/kernel/ptrace.c,v
retrieving revision 1.35
diff -u -r1.35 ptrace.c
--- ptrace.c      6 May 2005 18:59:13 -0000     1.35
+++ ptrace.c      31 May 2005 16:50:50 -0000
@@ -39,6 +39,7 @@
 #include <asm/pgalloc.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/unistd.h>

 #ifdef CONFIG_S390_SUPPORT
 #include "compat_ptrace.h"
@@ -762,6 +763,13 @@
            return;
      ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
                         ? 0x80 : 0));
+
+     /*
+      * If the debuffer has set an invalid system call number,
+      * we prepare to skip the system call restart handling.
+      */
+     if (!entryexit && regs->gprs[2] >= NR_syscalls)
+           regs->trap = -1;

      /*
       * this isn't the same as continuing with a signal, but it will do

===================================================================

regs->trap should be reset for any invalid system call, not just for
negative system call numbers.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


