Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266626AbSKZUAN>; Tue, 26 Nov 2002 15:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266637AbSKZUAN>; Tue, 26 Nov 2002 15:00:13 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:9088 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S266626AbSKZUAM>; Tue, 26 Nov 2002 15:00:12 -0500
Date: Tue, 26 Nov 2002 15:07:28 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] prevent "oops" in RPC debugging code
Message-ID: <Pine.LNX.4.44.0211261503270.9482-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
  rpc_show_tasks is invoked when changing the RPC client debug mode.
  recent changes have allowed tk_msg.rpc_proc to be NULL, which caused
  rpc_show_tasks to "oops."  the following change fixes that, and
  provides a little extra clean up as well.

Apply Against:
  2.5.49

Test status:
  Compiles, links, boots.  Oops does not recur.


diff -Naur 07-counters/net/sunrpc/sched.c 08-debug-oops/net/sunrpc/sched.c
--- 07-counters/net/sunrpc/sched.c	Fri Nov 22 16:40:44 2002
+++ 08-debug-oops/net/sunrpc/sched.c	Mon Nov 25 13:33:24 2002
@@ -1123,11 +1123,12 @@
 		"-rpcwait -action- --exit--\n");
 	alltask_for_each(t, le, &all_tasks)
 		printk("%05d %04d %04x %06d %8p %6d %8p %08ld %8s %8p %8p\n",
-			t->tk_pid, t->tk_msg.rpc_proc->p_proc,
+			t->tk_pid,
+			(t->tk_msg.rpc_proc ? t->tk_msg.rpc_proc->p_proc : -1),
 			t->tk_flags, t->tk_status,
 			t->tk_client, t->tk_client->cl_prog,
 			t->tk_rqstp, t->tk_timeout,
-			t->tk_rpcwait ? rpc_qname(t->tk_rpcwait) : " <NULL> ",
+			rpc_qname(t->tk_rpcwait),
 			t->tk_action, t->tk_exit);
 	spin_unlock(&rpc_sched_lock);
 }

