Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbUCWQQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 11:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUCWQQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 11:16:26 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:9419 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262651AbUCWQPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 11:15:47 -0500
Message-ID: <406062B1.5080802@suse.com>
Date: Tue, 23 Mar 2004 11:15:45 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] dnotify + autofs may create signal/restart syscall loop
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.16.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey all -

I saw a recent bug report that showed when a process set up
a dnotify against the autofs root and then attempted an access(2)
call inside the autofs namespace on a mount that would fail,
it would create a signal/restart loop.

The cause is that the autofs code checks to see if any signals
are pending after it waits on a response from the autofs daemon.
If it finds any, it assumes that autofs_wait was interrupted,
and that it should return -ERESTARTNOINTR. The problem with
this is that a signal_pending(current) check will return true
if *any* signals were received, not just if a signal that
interrupted the wait was received. autofs_wait explicitly
blocks all signals except for SIGKILL, SIGQUIT, and SIGINT
before calling interruptible_sleep_on.

The effect is that if a dnotify is set against the autofs root,
when the autofs daemon creates the directory, a dnotify event
will be sent to the originating process. Since the code in
autofs_root_lookup doesn't check to see what signals are
actually pending, it bails early, telling the caller to try again.
The loop goes on forever until interrupted via one of the actual
interrupting signals.

The following patch makes both autofs_root_lookup and
autofs4_root_lookup verify that one of its defined "shutdown"
signals are pending before bailing out early. Any other signal
should be delivered later, as expected. It doesn't matter if the
signal occured outside of the sleep in autofs_wait. The calling
process will either go away or try again.

-Jeff

diff -ruNp linux-2.6.4/fs/autofs/root.c linux-2.6.4.autofs/fs/autofs/root.c
--- linux-2.6.4/fs/autofs/root.c    2004-03-10 21:55:27.000000000 -0500
+++ linux-2.6.4.autofs/fs/autofs/root.c    2004-03-23 10:38:27.607010457 -0500
@@ -238,9 +238,15 @@ static struct dentry *autofs_root_lookup
      * a signal. If so we can force a restart..
      */
     if (dentry->d_flags & DCACHE_AUTOFS_PENDING) {
+        /* See if we were interrupted */
         if (signal_pending(current)) {
-            unlock_kernel();
-            return ERR_PTR(-ERESTARTNOINTR);
+            sigset_t *sigset = &current->pending.signal;
+            if (sigismember (sigset, SIGKILL) ||
+                sigismember (sigset, SIGQUIT) ||
+                sigismember (sigset, SIGINT)) {
+                unlock_kernel();
+                return ERR_PTR(-ERESTARTNOINTR);
+            }
         }
     }
     unlock_kernel();
diff -ruNp linux-2.6.4/fs/autofs4/root.c linux-2.6.4.autofs/fs/autofs4/root.c
--- linux-2.6.4/fs/autofs4/root.c    2004-03-10 21:55:21.000000000 -0500
+++ linux-2.6.4.autofs/fs/autofs4/root.c    2004-03-23 10:39:02.217761667 -0500
@@ -285,9 +285,15 @@ static struct dentry *autofs4_root_looku
      * a signal. If so we can force a restart..
      */
     if (dentry->d_flags & DCACHE_AUTOFS_PENDING) {
+        /* See if we were interrupted */
         if (signal_pending(current)) {
-            unlock_kernel();
-            return ERR_PTR(-ERESTARTNOINTR);
+            sigset_t *sigset = &current->pending.signal;
+            if (sigismember (sigset, SIGKILL) ||
+                sigismember (sigset, SIGQUIT) ||
+                sigismember (sigset, SIGINT)) {
+                unlock_kernel();
+                return ERR_PTR(-ERESTARTNOINTR);
+            }
         }
     }
     unlock_kernel();

-- 
Jeff Mahoney
SuSE Labs
jeffm@suse.com
