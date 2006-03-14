Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbWCNV1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWCNV1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWCNV1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:27:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19337 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751791AbWCNV1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:27:08 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <m1veujy47r.fsf@ebiederm.dsl.xmission.com> 
References: <m1veujy47r.fsf@ebiederm.dsl.xmission.com>  <16835.1141936162@warthog.cambridge.redhat.com> 
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, alan@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 14 Mar 2006 21:26:52 +0000
Message-ID: <32068.1142371612@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> A small nit.  You are not documenting the most subtle memory barrier:
> smp_read_barrier_depends();  Which is a deep requirement of the RCU
> code.

How about this the attached adjustment?

David

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 3ec9ff4..0c38bea 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -457,13 +457,14 @@ except in small and specific cases.  In 
 EXPLICIT KERNEL MEMORY BARRIERS
 ===============================
 
-The Linux kernel has six basic CPU memory barriers:
+The Linux kernel has eight basic CPU memory barriers:
 
-		MANDATORY	SMP CONDITIONAL
-		===============	===============
-	GENERAL	mb()		smp_mb()
-	READ	rmb()		smp_rmb()
-	WRITE	wmb()		smp_wmb()
+	TYPE		MANDATORY		SMP CONDITIONAL
+	===============	=======================	===========================
+	GENERAL		mb()			smp_mb()
+	WRITE		wmb()			smp_wmb()
+	READ		rmb()			smp_rmb()
+	DATA DEPENDENCY	read_barrier_depends()	smp_read_barrier_depends()
 
 General memory barriers give a guarantee that all memory accesses specified
 before the barrier will appear to happen before all memory accesses specified
@@ -472,6 +473,36 @@ after the barrier with respect to the ot
 Read and write memory barriers give similar guarantees, but only for memory
 reads versus memory reads and memory writes versus memory writes respectively.
 
+Data dependency memory barriers ensure that if two reads are issued that
+depend on each other, that the first read is completed _before_ the dependency
+comes into effect.  For instance, consider a case where the address used in
+the second read is calculated from the result of the first read:
+
+	CPU 1		CPU 2		COMMENT
+	===============	===============	=======================================
+					a == 0, b == 1 and p == &a, q == &a
+	b = 2;
+	smp_wmb();			Make sure b is changed before p
+	p = &b;		q = p;
+			d = *q;
+
+then old data values may be used in the address calculation for the second
+value, potentially resulting in q == &b and d == 0 being seen, which is never
+correct.  What is required is a data dependency memory barrier:
+
+	CPU 1		CPU 2		COMMENT
+	===============	===============	=======================================
+					a == 0, b == 1 and p == &a, q == &a
+	b = 2;
+	smp_wmb();			Make sure b is changed before p
+	p = &b;		q = p;
+			smp_read_barrier_depends();
+					Make sure q is changed before d is read
+			d = *q;
+
+This forces the result to be either q == &a and d == 0 or q == &b and d == 2.
+The result of q == &b and d == 0 will never be seen.
+
 All memory barriers imply compiler barriers.
 
 SMP memory barriers are only compiler barriers on uniprocessor compiled systems
