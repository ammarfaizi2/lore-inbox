Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWJWEeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWJWEeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 00:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWJWEeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 00:34:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25550 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751470AbWJWEeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 00:34:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Yinghai Lu <yinghai.lu@amd.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] x86_64 irq: Simplify the vector allocator.
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
	<20061022035109.GM5211@rhun.haifa.ibm.com>
	<m1psck21fc.fsf@ebiederm.dsl.xmission.com>
	<20061022085216.GQ5211@rhun.haifa.ibm.com>
Date: Sun, 22 Oct 2006 22:32:07 -0600
In-Reply-To: <20061022085216.GQ5211@rhun.haifa.ibm.com> (Muli Ben-Yehuda's
	message of "Sun, 22 Oct 2006 10:52:16 +0200")
Message-ID: <m1ods3y7nc.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is no reason to remember a per cpu position of which vector
to try.  Keeping a global position is simpler and more likely to
result in a global vector allocation even if I don't need or require
it.  For level triggered interrupts this means we are less likely to
acknowledge another cpus irq, and cause the level triggered irq to
harmlessly refire.

This simplification makes it easier to only access data structures
of  online cpus, by having fewer special cases to deal with.


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/io_apic.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index b000017..0e89ae7 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -612,10 +612,7 @@ static int __assign_irq_vector(int irq, 
 	 * Also, we've got to be careful not to trash gate
 	 * 0x80, because int 0x80 is hm, kind of importantish. ;)
 	 */
-	static struct {
-		int vector;
-		int offset;
-	} pos[NR_CPUS] = { [ 0 ... NR_CPUS - 1] = {FIRST_DEVICE_VECTOR, 0} };
+	static int current_vector = FIRST_DEVICE_VECTOR, current_offset = 0;
 	int old_vector = -1;
 	int cpu;
 
@@ -631,14 +628,13 @@ static int __assign_irq_vector(int irq, 
 
 	for_each_cpu_mask(cpu, mask) {
 		cpumask_t domain;
-		int first, new_cpu;
+		int new_cpu;
 		int vector, offset;
 
 		domain = vector_allocation_domain(cpu);
-		first = first_cpu(domain);
 
-		vector = pos[first].vector;
-		offset = pos[first].offset;
+		vector = current_vector;
+		offset = current_offset;
 next:
 		vector += 8;
 		if (vector >= FIRST_SYSTEM_VECTOR) {
@@ -646,7 +642,7 @@ next:
 			offset = (offset + 1) % 8;
 			vector = FIRST_DEVICE_VECTOR + offset;
 		}
-		if (unlikely(pos[first].vector == vector))
+		if (unlikely(current_vector == vector))
 			continue;
 		if (vector == IA32_SYSCALL_VECTOR)
 			goto next;
@@ -654,10 +650,8 @@ next:
 			if (per_cpu(vector_irq, new_cpu)[vector] != -1)
 				goto next;
 		/* Found one! */
-		for_each_cpu_mask(new_cpu, domain) {
-			pos[new_cpu].vector = vector;
-			pos[new_cpu].offset = offset;
-		}
+		current_vector = vector;
+		current_offset = offset;
 		if (old_vector >= 0) {
 			int old_cpu;
 			for_each_cpu_mask(old_cpu, irq_domain[irq])
-- 
1.4.2.rc3.g7e18e-dirty

