Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVAGSIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVAGSIO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVAGSFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:05:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:6348 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261370AbVAGSEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:04:40 -0500
Date: Fri, 7 Jan 2005 10:04:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Prasanna Meda <pmeda@akamai.com>
Subject: Re: mysterious /proc/<pid>/maps breakage with static binaries in
 2.6.10-mm2
Message-Id: <20050107100422.4dfb8025.akpm@osdl.org>
In-Reply-To: <1105088099.11504.12.camel@localhost>
References: <1105088099.11504.12.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
> In 2.6.10-mm2, if I look at the maps of a process execve'd from a static
>  executable, /proc/<pid>/maps looks wrong.

The first versions of speedup-proc-pid-maps was dodgy.  Does this fix?


--- 25/fs/proc/task_mmu.c~speedup-proc-pid-maps-fix	2005-01-07 10:03:04.313758952 -0800
+++ 25-akpm/fs/proc/task_mmu.c	2005-01-07 10:03:04.317758344 -0800
@@ -133,6 +133,15 @@ static void *m_start(struct seq_file *m,
 	tail_map = get_gate_vma(task);
 	down_read(&mm->mmap_sem);
 
+	/*
+	 * First map is special, since we remember last_addr
+	 * rather than current_addr to hit with mmap_cache most of the time.
+	 */
+	if (!l) {
+		map = mm->mmap;
+		goto out;
+	}
+
 	/* Start with last addr hint */
 	map = find_vma(mm, last_addr);
 	if (map) {
@@ -140,7 +149,7 @@ static void *m_start(struct seq_file *m,
 		goto out;
 	}
 
-	/* Check the map index is within the range */
+	/* Check the map index is within the range, and do linear scan */
 	if ((unsigned long)l < mm->map_count) {
 		map = mm->mmap;
 		while (l-- && map)
@@ -179,16 +188,16 @@ static void *m_next(struct seq_file *m, 
 {
 	struct task_struct *task = m->private;
 	struct vm_area_struct *map = v;
+	struct vm_area_struct *tail_map = get_gate_vma(task);
+
 	(*pos)++;
 	if (map && map->vm_next) {
-		m->version = map->vm_next->vm_start;
+		m->version = (map != tail_map)? map->vm_start: -1UL;
 		return map->vm_next;
 	}
 	m_stop(m, v);
 	m->version = -1UL;
-	if (map != get_gate_vma(task))
-		return get_gate_vma(task);
-	return NULL;
+	return (map != tail_map)? tail_map: NULL;
 }
 
 struct seq_operations proc_pid_maps_op = {
_

