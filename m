Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUCVGlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 01:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUCVGlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 01:41:51 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:57286 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261790AbUCVGls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 01:41:48 -0500
Date: Mon, 22 Mar 2004 01:41:53 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, olh@suse.de
Subject: [PATCH][2.6-mm] defer free_initmem() if we have no /init
Message-ID: <Pine.LNX.4.58.0403220132060.28727@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the absence of /init and other nice boot goodies, we fall through to
prepare_namespace() so we shall require initmem to complete boot.

Freeing 1nunedlketo lamdlo y:r3elkpfgeeg
equest at virtual address c06c22a0
 printing eip:
c06c22a0
*pde = 00757027
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
CPU:    1
EIP:    0060:[<c06c22a0>]    Not tainted VLI
EFLAGS: 00010213   (2.6.5-rc2-mm1)
EIP is at prepare_namespace+0x0/0xd0
eax: 00000002   ebx: 00000000   ecx: c060b2c0   edx: c060b300
esi: 00000001   edi: 00000000   ebp: dff8ffec   esp: dff8ffd4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=dff8f000 task=dff1fa50)
Stack: c0103235 00000000 00000000 0000007b c0103170 00000000 00000000 c01051f5
       00000000 00000000 00000000
Call Trace:
 [<c0103235>] init+0xc5/0x190
 [<c0103170>] init+0x0/0x190
 [<c01051f5>] kernel_thread_helper+0x5/0x10

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init!

Index: linux-2.6.5-rc2-mm1/init/main.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.5-rc2-mm1/init/main.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 main.c
--- linux-2.6.5-rc2-mm1/init/main.c	21 Mar 2004 17:02:18 -0000	1.1.1.1
+++ linux-2.6.5-rc2-mm1/init/main.c	21 Mar 2004 20:54:19 -0000
@@ -586,8 +586,8 @@ static int free_initmem_on_exec_helper(v
 	char c;

 	sys_close(fd[1]);
-	sys_read(fd[0], &c, 1);
-	free_initmem();
+	if (sys_read(fd[0], &c, 1) > 0)
+		free_initmem();
 	return 0;
 }

@@ -596,7 +596,7 @@ static void free_initmem_on_exec(void)
 	int fd[2];

 	do_pipe(fd);
-       kernel_thread(free_initmem_on_exec_helper, &fd, SIGCHLD);
+	kernel_thread(free_initmem_on_exec_helper, &fd, SIGCHLD);

 	sys_dup2(fd[1], 255);   /* to get it out of the way */
 	sys_close(fd[0]);
@@ -643,6 +643,7 @@ static int init(void * unused)
 	run_init_process("/init");

 	prepare_namespace();
+	free_initmem();

 	if (sys_open("/dev/console", O_RDWR, 0) < 0)
 		printk("Warning: unable to open an initial console.\n");
