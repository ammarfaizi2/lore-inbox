Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTFOSRq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTFOSRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:17:46 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:27280 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262497AbTFOSRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:17:44 -0400
Date: Sun, 15 Jun 2003 20:31:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: CaT <cat@zip.com.au>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: [FIX, please test] Re: 2.5.70-bk16 - nfs interferes with s4bios suspend
Message-ID: <20030615183111.GD315@elf.ucw.cz>
References: <20030613033703.GA526@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613033703.GA526@zip.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  stopping tasks failed (2 tasks remaining)
> Suspend failed: Not all processes stopped!
> Restarting tasks...<6> Strange, rpciod not stopped

This should fix it... Someone please test it.
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
@@ -286,7 +287,7 @@
  */
 void rpciod_wake_up(void)
 {
-	if(rpciod_pid==0)
+	if (rpciod_pid==0)
 		printk(KERN_ERR "rpciod: wot no daemon?\n");
 	if (waitqueue_active(&rpciod_idle))
 		wake_up(&rpciod_idle);
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
