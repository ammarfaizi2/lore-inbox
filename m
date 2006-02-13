Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWBMXxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWBMXxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWBMXxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:53:44 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:29080 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030310AbWBMXxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:53:43 -0500
Subject: [PATCH] kprobes: Update Documentation/kprobes.txt
From: Jim Keniston <jkenisto@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Ananth N Mavinakayanahalli <mananth@in.ibm.com>,
       Prasanna Panchamukhi <ppancham@in.ibm.com>
Content-Type: multipart/mixed; boundary="=-EedFUYzsggLEYVWEVXlh"
Organization: 
Message-Id: <1139874799.2838.30.camel@dyn9047018079.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 Feb 2006 15:53:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EedFUYzsggLEYVWEVXlh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The enclosed patch against Linux v2.6.16-rc3 updates
Documentation/kprobes.txt to reflect Kprobes enhancements and other
recent developments.  Please apply.

Acked-by: Ananth Mavinakayanahalli <mananth@in.ibm.com>
Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>


--=-EedFUYzsggLEYVWEVXlh
Content-Disposition: attachment; filename=Doc-kprobes.patch
Content-Type: text/plain; name=Doc-kprobes.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


Updates Documentation/kprobes.txt to reflect recent enhancements.

---

 Documentation/kprobes.txt |   75 ++++++++++++++++++++++++----------------------
 1 files changed, 40 insertions(+), 35 deletions(-)

diff -puN Documentation/kprobes.txt~Doc-kprobes Documentation/kprobes.txt
--- linux-2.6.16-rc3/Documentation/kprobes.txt~Doc-kprobes	2006-02-13 15:10:19.000000000 -0800
+++ linux-2.6.16-rc3-jimk/Documentation/kprobes.txt	2006-02-13 15:36:24.000000000 -0800
@@ -136,17 +136,20 @@ Kprobes, jprobes, and return probes are 
 architectures:
 
 - i386
-- x86_64 (AMD-64, E64MT)
+- x86_64 (AMD-64, EM64T)
 - ppc64
-- ia64 (Support for probes on certain instruction types is still in progress.)
+- ia64 (Does not support probes on instruction slot1.)
 - sparc64 (Return probes not yet implemented.)
 
 3. Configuring Kprobes
 
 When configuring the kernel using make menuconfig/xconfig/oldconfig,
-ensure that CONFIG_KPROBES is set to "y".  Under "Kernel hacking",
-look for "Kprobes".  You may have to enable "Kernel debugging"
-(CONFIG_DEBUG_KERNEL) before you can enable Kprobes.
+ensure that CONFIG_KPROBES is set to "y".  Under "Instrumentation
+Support", look for "Kprobes".
+
+So that you can load and unload Kprobes-based instrumentation modules,
+make sure "Loadable module support" (CONFIG_MODULES) and "Module
+unloading" (CONFIG_MODULE_UNLOAD) are set to "y".
 
 You may also want to ensure that CONFIG_KALLSYMS and perhaps even
 CONFIG_KALLSYMS_ALL are set to "y", since kallsyms_lookup_name()
@@ -262,18 +265,18 @@ at any time after the probe has been reg
 
 5. Kprobes Features and Limitations
 
-As of Linux v2.6.12, Kprobes allows multiple probes at the same
-address.  Currently, however, there cannot be multiple jprobes on
-the same function at the same time.
+Kprobes allows multiple probes at the same address.  Currently,
+however, there cannot be multiple jprobes on the same function at
+the same time.
 
 In general, you can install a probe anywhere in the kernel.
 In particular, you can probe interrupt handlers.  Known exceptions
 are discussed in this section.
 
-For obvious reasons, it's a bad idea to install a probe in
-the code that implements Kprobes (mostly kernel/kprobes.c and
-arch/*/kernel/kprobes.c).  A patch in the v2.6.13 timeframe instructs
-Kprobes to reject such requests.
+The register_*probe functions will return -EINVAL if you attempt
+to install a probe in the code that implements Kprobes (mostly
+kernel/kprobes.c and arch/*/kernel/kprobes.c, but also functions such
+as do_page_fault and notifier_call_chain).
 
 If you install a probe in an inline-able function, Kprobes makes
 no attempt to chase down all inline instances of the function and
@@ -290,18 +293,14 @@ from the accidental ones.  Don't drink a
 
 Kprobes makes no attempt to prevent probe handlers from stepping on
 each other -- e.g., probing printk() and then calling printk() from a
-probe handler.  As of Linux v2.6.12, if a probe handler hits a probe,
-that second probe's handlers won't be run in that instance.
+probe handler.  If a probe handler hits a probe, that second probe's
+handlers won't be run in that instance, and the kprobe.nmissed member
+of the second probe will be incremented.
 
-In Linux v2.6.12 and previous versions, Kprobes' data structures are
-protected by a single lock that is held during probe registration and
-unregistration and while handlers are run.  Thus, no two handlers
-can run simultaneously.  To improve scalability on SMP systems,
-this restriction will probably be removed soon, in which case
-multiple handlers (or multiple instances of the same handler) may
-run concurrently on different CPUs.  Code your handlers accordingly.
+As of Linux v2.6.15-rc1, multiple handlers (or multiple instances of
+the same handler) may run concurrently on different CPUs.
 
-Kprobes does not use semaphores or allocate memory except during
+Kprobes does not use mutexes or allocate memory except during
 registration and unregistration.
 
 Probe handlers are run with preemption disabled.  Depending on the
@@ -316,11 +315,18 @@ address instead of the real return addre
 (As far as we can tell, __builtin_return_address() is used only
 for instrumentation and error reporting.)
 
-If the number of times a function is called does not match the
-number of times it returns, registering a return probe on that
-function may produce undesirable results.  We have the do_exit()
-and do_execve() cases covered.  do_fork() is not an issue.  We're
-unaware of other specific cases where this could be a problem.
+If the number of times a function is called does not match the number
+of times it returns, registering a return probe on that function may
+produce undesirable results.  We have the do_exit() case covered.
+do_execve() and do_fork() are not an issue.  We're unaware of other
+specific cases where this could be a problem.
+
+If, upon entry to or exit from a function, the CPU is running on
+a stack other than that of the current task, registering a return
+probe on that function may produce undesirable results.  For this
+reason, Kprobes doesn't support return probes (or kprobes or jprobes)
+on the x86_64 version of __switch_to(); the registration functions
+return -EINVAL.
 
 6. Probe Overhead
 
@@ -347,14 +353,12 @@ k = 0.77 usec; j = 1.31; r = 1.26; kr = 
 
 7. TODO
 
-a. SystemTap (http://sourceware.org/systemtap): Work in progress
-to provide a simplified programming interface for probe-based
-instrumentation.
-b. Improved SMP scalability: Currently, work is in progress to handle
-multiple kprobes in parallel.
-c. Kernel return probes for sparc64.
-d. Support for other architectures.
-e. User-space probes.
+a. SystemTap (http://sourceware.org/systemtap): Provides a simplified
+programming interface for probe-based instrumentation.  Try it out.
+b. Kernel return probes for sparc64.
+c. Support for other architectures.
+d. User-space probes.
+e. Watchpoint probes (which fire on data references).
 
 8. Kprobes Example
 
@@ -411,8 +415,7 @@ int init_module(void)
 		printk("Couldn't find %s to plant kprobe\n", "do_fork");
 		return -1;
 	}
-	ret = register_kprobe(&kp);
-	if (ret < 0) {
+	if ((ret = register_kprobe(&kp) < 0)) {
 		printk("register_kprobe failed, returned %d\n", ret);
 		return -1;
 	}
_

--=-EedFUYzsggLEYVWEVXlh--

