Return-Path: <linux-kernel-owner+w=401wt.eu-S964898AbXALSXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbXALSXJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 13:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbXALSXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 13:23:09 -0500
Received: from tomts43.bellnexxia.net ([209.226.175.110]:46624 "EHLO
	tomts43-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964898AbXALSXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 13:23:07 -0500
Date: Fri, 12 Jan 2007 13:23:01 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 05/05] update - Linux Kernel Markers, non optimised architectures
Message-ID: <20070112182301.GA11102@Krystal>
References: <11685601382063-git-send-email-mathieu.desnoyers@polymtl.ca> <11685601404005-git-send-email-mathieu.desnoyers@polymtl.ca> <45A710F8.7000405@yahoo.com.au> <20070112050032.GA14100@Krystal> <45A71827.6020300@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45A71827.6020300@yahoo.com.au>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:19:07 up 142 days, 15:26,  3 users,  load average: 1.25, 0.69, 0.52
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Piggin (nickpiggin@yahoo.com.au) wrote:
> OK, well one problem is that it can cause a resched event to be lost, so
> you might say it has more side-effects without checking resched.
> 

Here is the patch that implements this. I also did a cosmetic change to
linux/marker.h. Preliminary tests of running the markers with preempt_enable()
with LTTng 0.6.56 instrumentation shows no problem.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-generic/marker.h
+++ b/include/asm-generic/marker.h
@@ -39,7 +39,7 @@ struct __mark_marker {
 		if (unlikely(__marker_enable_##name)) { \
 			preempt_disable(); \
 			(*__mark_call_##name)(format, ## args); \
-			preempt_enable_no_resched(); \
+			preempt_enable(); \
 		} \
 	} while (0)
 
--- a/include/asm-i386/marker.h
+++ b/include/asm-i386/marker.h
@@ -42,7 +42,7 @@ struct __mark_marker {
 		if (unlikely(condition)) { \
 			preempt_disable(); \
 			(*__mark_call_##name)(format, ## args); \
-			preempt_enable_no_resched(); \
+			preempt_enable(); \
 		} \
 	} while (0)
 
--- a/include/asm-powerpc/marker.h
+++ b/include/asm-powerpc/marker.h
@@ -45,7 +45,7 @@ struct __mark_marker {
 		if (unlikely(condition)) { \
 			preempt_disable(); \
 			(*__mark_call_##name)(format, ## args); \
-			preempt_enable_no_resched(); \
+			preempt_enable(); \
 		} \
 	} while (0)
 
--- a/include/linux/marker.h
+++ b/include/linux/marker.h
@@ -8,12 +8,12 @@
  *
  * Example :
  *
- * MARK(subsystem_event, "%d %s %p[struct task_struct *]",
+ * MARK(subsystem_event, "%d %s %p[struct task_struct]",
  *   someint, somestring, current);
  * Where :
  * - Subsystem is the name of your subsystem.
  * - event is the name of the event to mark.
- * - "%d %s %p[struct task_struct *]" is the formatted string for printk.
+ * - "%d %s %p[struct task_struct]" is the formatted string for printk.
  * - someint is an integer.
  * - somestring is a char pointer.
  * - current is a pointer to a struct task_struct.
@@ -27,6 +27,9 @@
  * Markers can be put in inline functions, inlined static functions and
  * unrolled loops.
  *
+ * Note : It is safe to put markers within preempt-safe code : preempt_enable()
+ * will not call the scheduler due to the tests in preempt_schedule().
+ *
  * (C) Copyright 2006 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
  *
  * This file is released under the GPLv2.
-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
