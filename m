Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbUAJD3d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 22:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbUAJD3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 22:29:33 -0500
Received: from waste.org ([209.173.204.2]:43196 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264549AbUAJD3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 22:29:30 -0500
Date: Fri, 9 Jan 2004 21:29:15 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>
Subject: [patch] arch-specific cond_syscall usage issues
Message-ID: <20040110032915.GW18208@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Experimenting with trying to use cond_syscall for a few arch-specific
syscalls, I discovered that it can't actually be used outside the file
in which sys_ni_syscall is declared because the assembler doesn't feel
obliged to output the symbol in that case:

weak.c:

#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
cond_syscall(sys_foo);

$ nm weak.o
         U sys_ni_syscall

One arch (PPC) is apparently trying to use cond_syscall this way
anyway, though it's probably never been actually tested as the above
test was done on a PPC.

After trying a bunch of tricks to get it to work nicely, I decided
there are basically two alternatives: make weak versions of
sys_ni_syscall wherever they're wanted or put the arch-specific
cond_syscalls in kernel/sys.c where sys_ni_syscall is defined.

The former approach is a bit crufty and doesn't actually do the right
thing in practice as you'll get multiple copies of sys_ni_syscall in
your final image.

The latter introduces some slight arch-pollution in sys.c, but as
arch-specific cond_syscalls aren't all that frequent, it should be
pretty minor. So here's a patch to move the current offender to sys.c:

 tiny-mpm/arch/ppc/kernel/syscalls.c |    2 --
 tiny-mpm/kernel/sys.c               |    3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff -puN arch/ppc/kernel/syscalls.c~ppc_cond_syscall arch/ppc/kernel/syscalls.c
--- tiny/arch/ppc/kernel/syscalls.c~ppc_cond_syscall	2004-01-09 21:15:02.000000000 -0600
+++ tiny-mpm/arch/ppc/kernel/syscalls.c	2004-01-09 21:15:08.000000000 -0600
@@ -271,5 +271,3 @@ long ppc_fadvise64_64(int fd, int advice
 {
 	return sys_fadvise64_64(fd, offset, len, advice);
 }
-
-cond_syscall(sys_pciconfig_iobase);
diff -puN kernel/sys.c~ppc_cond_syscall kernel/sys.c
--- tiny/kernel/sys.c~ppc_cond_syscall	2004-01-09 21:15:02.000000000 -0600
+++ tiny-mpm/kernel/sys.c	2004-01-09 21:15:02.000000000 -0600
@@ -252,6 +252,9 @@ cond_syscall(sys_epoll_wait)
 cond_syscall(sys_pciconfig_read)
 cond_syscall(sys_pciconfig_write)
 
+/* arch-specific weak syscall entries */
+cond_syscall(sys_pciconfig_iobase)
+
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
 	int no_nice;

_

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
