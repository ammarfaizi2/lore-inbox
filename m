Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbWIEP3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbWIEP3j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWIEP3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:29:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5605 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965139AbWIEP3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:29:36 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060905132530.GD9173@stusta.de> 
References: <20060905132530.GD9173@stusta.de>  <20060901015818.42767813.akpm@osdl.org> 
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: [PATCH] NOMMU: Move the fallback arch_vma_name() to a sensible place
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 05 Sep 2006 16:27:04 +0100
Message-ID: <6024.1157470024@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move the fallback arch_vma_name() to a sensible place (kernel/signal.c).

Currently it's in fs/proc/task_mmu.c, a file that is dependent on both
CONFIG_PROC_FS and CONFIG_MMU being enabled, but it's used from kernel/signal.c
from where it is called unconditionally.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 nommu-arch_vma_name-2618rc5mm1.diff 
 fs/proc/task_mmu.c |    5 -----
 kernel/signal.c    |    5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff -urp ../kernels/linux-2.6.18-rc5-mm1/fs/proc/task_mmu.c linux-2.6.18-rc5-mm1-frv/fs/proc/task_mmu.c
--- ../kernels/linux-2.6.18-rc5-mm1/fs/proc/task_mmu.c	2006-09-04 18:02:43.000000000 +0100
+++ linux-2.6.18-rc5-mm1-frv/fs/proc/task_mmu.c	2006-09-05 15:49:18.000000000 +0100
@@ -122,11 +122,6 @@ struct mem_size_stats
 	unsigned long private_dirty;
 };
 
-__attribute__((weak)) const char *arch_vma_name(struct vm_area_struct *vma)
-{
-	return NULL;
-}
-
 static int show_map_internal(struct seq_file *m, void *v, struct mem_size_stats *mss)
 {
 	struct proc_maps_private *priv = m->private;
diff -urp ../kernels/linux-2.6.18-rc5-mm1/kernel/signal.c linux-2.6.18-rc5-mm1-frv/kernel/signal.c
--- ../kernels/linux-2.6.18-rc5-mm1/kernel/signal.c	2006-09-04 18:03:32.000000000 +0100
+++ linux-2.6.18-rc5-mm1-frv/kernel/signal.c	2006-09-05 15:49:19.000000000 +0100
@@ -773,6 +773,11 @@ static void pad_len_spaces(int len)
 	printk("%*c", len, ' ');
 }
 
+__attribute__((weak)) const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
 static int print_vma(struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = vma->vm_mm;
