Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265142AbTFRKfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 06:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbTFRKfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 06:35:18 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:3975 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S265142AbTFRKfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 06:35:06 -0400
Date: Wed, 18 Jun 2003 12:48:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: trond.myklebust@fys.uio.no,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Fix suspend with NFS mounts active
Message-ID: <20030618104844.GA398@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes suspend with NFS mounts active. Please apply,

								Pavel

--- /usr/src/tmp/linux/fs/lockd/svc.c	2003-02-15 18:51:27.000000000 +0100
+++ /usr/src/linux/fs/lockd/svc.c	2003-06-15 20:17:30.000000000 +0200
@@ -34,6 +34,7 @@
 #include <linux/sunrpc/svcsock.h>
 #include <linux/lockd/lockd.h>
 #include <linux/nfs.h>
+#include <linux/suspend.h>
 
 #define NLMDBG_FACILITY		NLMDBG_SVC
 #define LOCKD_BUFSIZE		(1024 + NLMSVC_XDRSIZE)
@@ -118,9 +119,11 @@
 	 * NFS mount or NFS daemon has gone away, and we've been sent a
 	 * signal, or else another process has taken over our job.
 	 */
-	while ((nlmsvc_users || !signalled()) && nlmsvc_pid == current->pid)
-	{
+	while ((nlmsvc_users || !signalled()) && nlmsvc_pid == current->pid) {
 		long timeout = MAX_SCHEDULE_TIMEOUT;
+
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 		if (signalled()) {
 			flush_signals(current);
 			if (nlmsvc_ops) {
--- /usr/src/tmp/linux/net/sunrpc/sched.c	2003-05-27 13:44:18.000000000 +0200
+++ /usr/src/linux/net/sunrpc/sched.c	2003-06-15 20:16:46.000000000 +0200
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
+#include <linux/suspend.h>
 
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/xprt.h>
@@ -969,6 +970,8 @@
 			flush_signals(current);
 		}
 		__rpc_schedule();
+                if (current->flags & PF_FREEZE)
+                        refrigerator(PF_IOTHREAD);
 
 		if (++rounds >= 64) {	/* safeguard */
 			schedule();

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
