Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293644AbSCPIyP>; Sat, 16 Mar 2002 03:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310182AbSCPIyF>; Sat, 16 Mar 2002 03:54:05 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:53667 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S293644AbSCPIxs>;
	Sat, 16 Mar 2002 03:53:48 -0500
Date: Sat, 16 Mar 2002 03:53:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Miles Lane <miles@megapathdsl.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.7-pre2 -- kernel.o(.data+0x300): undefined reference to
 `sys_nfsservctl'
In-Reply-To: <1016265776.6500.348.camel@turbulence.megapathdsl.net>
Message-ID: <Pine.GSO.4.21.0203160317490.4093-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 16 Mar 2002, Miles Lane wrote:

> arch/i386/kernel/kernel.o: In function `sys_call_table':
> arch/i386/kernel/kernel.o(.data+0x300): undefined reference to
> `sys_nfsservctl'

Fix: add a weak alias sys_nfsservctl -> sys_ni_syscall in kernel/sys.c.
While we are at it, the same can be done with sys_quotactl() - I suspect
that fs/noqout.c can be killed.

diff -urN C7-pre2/fs/noquot.c C7-pre2-current/fs/noquot.c
--- C7-pre2/fs/noquot.c	Fri May 12 14:21:20 2000
+++ C7-pre2-current/fs/noquot.c	Sat Mar 16 03:45:27 2002
@@ -2,14 +2,5 @@
  *           compiled into the kernel.
  */
 
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-
 int nr_dquots, nr_free_dquots;
 int max_dquots;
-
-asmlinkage long sys_quotactl(int cmd, const char *special, int id, caddr_t addr)
-{
-	return(-ENOSYS);
-}
diff -urN C7-pre2/kernel/sys.c C7-pre2-current/kernel/sys.c
--- C7-pre2/kernel/sys.c	Fri Mar 15 22:22:40 2002
+++ C7-pre2-current/kernel/sys.c	Sat Mar 16 03:43:14 2002
@@ -173,6 +173,11 @@
 	return -ENOSYS;
 }
 
+/* "Conditional" syscalls */
+
+asmlinkage long sys_nfsservctl(void) __attribute__ ((weak, alias ("sys_ni_syscall")));
+asmlinkage long sys_quotactl(void) __attribute__ ((weak, alias ("sys_ni_syscall")));
+
 static int proc_sel(struct task_struct *p, int which, int who)
 {
 	if(p->pid)

