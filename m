Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWCIOBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWCIOBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 09:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWCIOBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 09:01:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2966 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751491AbWCIOBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 09:01:35 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <21627.1141846631@warthog.cambridge.redhat.com> 
References: <21627.1141846631@warthog.cambridge.redhat.com>  <29826.1141828678@warthog.cambridge.redhat.com> <31492.1141753245@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, alan@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #3] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 09 Mar 2006 14:01:16 +0000
Message-ID: <27749.1141912876@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm thinking of adding the attached to the document. Any comments or
objections?

David

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 6eeb7e4..f9a9192 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -4,6 +4,8 @@
 
 Contents:
 
+ (*) What do we consider memory?
+
  (*) What are memory barriers?
 
  (*) Where are memory barriers needed?
@@ -32,6 +34,82 @@ Contents:
  (*) References.
 
 
+===========================
+WHAT DO WE CONSIDER MEMORY?
+===========================
+
+For the purpose of this specification, "memory", at least as far as cached CPU
+vs CPU interactions go, has to include the CPU caches in the system.  Although
+any particular read or write may not actually appear outside of the CPU that
+issued it because the CPU was able to satisfy it from its own cache, it's still
+as if the memory access had taken place as far as the other CPUs are concerned
+since the cache coherency and ejection mechanisms will propegate the effects
+upon conflict.
+
+Consider the system logically as:
+
+	    <--- CPU --->         :       <----------- Memory ----------->
+	                          :
+	+--------+    +--------+  :   +--------+    +-----------+
+	|        |    |        |  :   |        |    |           |    +---------+
+	|  CPU   |    | Memory |  :   | CPU    |    |           |    |	       |
+	|  Core  |--->| Access |----->| Cache  |<-->|           |    |	       |
+	|        |    | Queue  |  :   |        |    |           |--->| Memory  |
+	|        |    |        |  :   |        |    |           |    |	       |
+	+--------+    +--------+  :   +--------+    |           |    | 	       |
+	                          :                 | Cache     |    +---------+
+	                          :                 | Coherency |
+	                          :                 | Mechanism |    +---------+
+	+--------+    +--------+  :   +--------+    |           |    |	       |
+	|        |    |        |  :   |        |    |           |    |         |
+	|  CPU   |    | Memory |  :   | CPU    |    |           |--->| Device  |
+	|  Core  |--->| Access |----->| Cache  |<-->|           |    | 	       |
+	|        |    | Queue  |  :   |        |    |           |    | 	       |
+	|        |    |        |  :   |        |    |           |    +---------+
+	+--------+    +--------+  :   +--------+    +-----------+
+	                          :
+	                          :
+
+The CPU core may execute instructions in any order it deems fit, provided the
+expected program causality appears to be maintained.  Some of the instructions
+generate load and store operations which then go into the memory access queue
+to be performed.  The core may place these in the queue in any order it wishes,
+and continue execution until it is forced to wait for an instruction to
+complete.
+
+What memory barriers are concerned with is controlling the order in which
+accesses cross from the CPU side of things to the memory side of things, and
+the order in which the effects are perceived to happen by the other observers
+in the system.
+
+
+Note that the above model does not show uncached memory or I/O accesses.  These
+procede directly from the queue to the memory or the devices, bypassing any
+cache coherency:
+
+	    <--- CPU --->         :
+       	                          :		+-----+
+	+--------+    +--------+  :             |     |
+	|        |    |        |  :             |     |              +---------+
+	|  CPU   |    | Memory |  :             |     |              |	       |
+	|  Core  |--->| Access |--------------->|     |              |	       |
+	|        |    | Queue  |  :             |     |------------->| Memory  |
+	|        |    |        |  :             |     |              |	       |
+	+--------+    +--------+  :             |     |              | 	       |
+	                          :             |     |              +---------+
+	                          :             | Bus |
+	                          :             |     |              +---------+
+	+--------+    +--------+  :             |     |              |	       |
+	|        |    |        |  :             |     |              |         |
+	|  CPU   |    | Memory |  :             |     |<------------>| Device  |
+	|  Core  |--->| Access |--------------->|     |              | 	       |
+	|        |    | Queue  |  :             |     |              | 	       |
+	|        |    |        |  :             |     |              +---------+
+	+--------+    +--------+  :             |     |
+	                          :		+-----+
+	                          :
+
+
 =========================
 WHAT ARE MEMORY BARRIERS?
 =========================
@@ -448,8 +526,8 @@ In all cases there are variants on a LOC
 
      The LOCK accesses will be completed before the UNLOCK accesses.
 
-And therefore an UNLOCK followed by a LOCK is equivalent to a full barrier, but
-a LOCK followed by an UNLOCK isn't.
+     Therefore an UNLOCK followed by a LOCK is equivalent to a full barrier,
+     but a LOCK followed by an UNLOCK is not.
 
 Locks and semaphores may not provide any guarantee of ordering on UP compiled
 systems, and so can't be counted on in such a situation to actually do anything

