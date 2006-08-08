Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWHHFsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWHHFsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 01:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWHHFsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 01:48:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4570 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932234AbWHHFsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 01:48:10 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH] x86_64:  Auto size the per cpu area.
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<m1slk89ozd.fsf@ebiederm.dsl.xmission.com>
	<20060807165512.dabefb63.akpm@osdl.org>
	<200608080417.59462.ak@suse.de>
	<20060807194159.f7c741b5.akpm@osdl.org>
	<1155005284.3042.11.camel@laptopd505.fenrus.org>
Date: Mon, 07 Aug 2006 23:47:23 -0600
In-Reply-To: <1155005284.3042.11.camel@laptopd505.fenrus.org> (Arjan van de
	Ven's message of "Tue, 08 Aug 2006 04:47:49 +0200")
Message-ID: <m13bc7aidw.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now for a completely different but trivial approach.
I just boot tested it with 255 CPUS and everything worked.

Currently everything (except module data) we place in
the per cpu area we know about at compile time.  So
instead of allocating a fixed size for the per_cpu area
allocate the number of bytes we need plus a fixed constant
for to be used for modules.

It isn't perfect but it is much less of a pain to
work with than what we are doing now.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/setup64.c |    7 ++-----
 include/asm-x86_64/percpu.h  |   10 ++++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86_64/kernel/setup64.c b/arch/x86_64/kernel/setup64.c
index 0cd3694..94336cf 100644
--- a/arch/x86_64/kernel/setup64.c
+++ b/arch/x86_64/kernel/setup64.c
@@ -95,12 +95,9 @@ #ifdef CONFIG_HOTPLUG_CPU
 #endif
 
 	/* Copy section for each CPU (we discard the original) */
-	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
-#ifdef CONFIG_MODULES
-	if (size < PERCPU_ENOUGH_ROOM)
-		size = PERCPU_ENOUGH_ROOM;
-#endif
+	size = PERCPU_ENOUGH_ROOM;
 
+	printk(KERN_INFO "PERCPU: Allocating %d bytes of per cpu data\n", size);
 	for_each_cpu_mask (i, cpu_possible_map) {
 		char *ptr;
 
diff --git a/include/asm-x86_64/percpu.h b/include/asm-x86_64/percpu.h
index 08dd9f9..39d2bab 100644
--- a/include/asm-x86_64/percpu.h
+++ b/include/asm-x86_64/percpu.h
@@ -11,6 +11,16 @@ #ifdef CONFIG_SMP
 
 #include <asm/pda.h>
 
+#ifdef CONFIG_MODULES
+# define PERCPU_MODULE_RESERVE 8192
+#else
+# define PERCPU_MODULE_RESERVE 0
+#endif
+
+#define PERCPU_ENOUGH_ROOM \
+	(ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES) + \
+	 PERCPU_MODULE_RESERVE)
+
 #define __per_cpu_offset(cpu) (cpu_pda(cpu)->data_offset)
 #define __my_cpu_offset() read_pda(data_offset)
 
-- 
1.4.2.rc3.g7e18e

