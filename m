Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbWJ3HSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbWJ3HSs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 02:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbWJ3HSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 02:18:48 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:4763 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1030496AbWJ3HSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 02:18:47 -0500
Date: Mon, 30 Oct 2006 18:17:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, ak@suse.de,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>, pj@sgi.com
Subject: [PATCH 1/2] Create compat_sys_migrate_pages.
Message-Id: <20061030181701.23ea7cba.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 2.3.0beta3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed on bigendian 64bit architectures.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/compat.h |    4 ++++
 kernel/compat.c        |   33 +++++++++++++++++++++++++++++++++
 kernel/sys_ni.c        |    1 +
 3 files changed, 38 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/linux/compat.h b/include/linux/compat.h
index f155319..80b17f4 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -230,5 +230,9 @@ asmlinkage long compat_sys_adjtimex(stru
 extern int compat_printk(const char *fmt, ...);
 extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
 
+asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
+		compat_ulong_t maxnode, const compat_ulong_t __user *old_nodes,
+		const compat_ulong_t __user *new_nodes);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff --git a/kernel/compat.c b/kernel/compat.c
index d4898aa..6952dd0 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -982,4 +982,37 @@ asmlinkage long compat_sys_move_pages(pi
 	}
 	return sys_move_pages(pid, nr_pages, pages, nodes, status, flags);
 }
+
+asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
+			compat_ulong_t maxnode,
+			const compat_ulong_t __user *old_nodes,
+			const compat_ulong_t __user *new_nodes)
+{
+	unsigned long __user *old = NULL;
+	unsigned long __user *new = NULL;
+	nodemask_t tmp_mask;
+	unsigned long nr_bits;
+	unsigned long size;
+
+	nr_bits = min_t(unsigned long, maxnode - 1, MAX_NUMNODES);
+	size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
+	if (old_nodes) {
+		if (compat_get_bitmap(nodes_addr(tmp_mask), old_nodes, nr_bits))
+			return -EFAULT;
+		old = compat_alloc_user_space(new_nodes ? size * 2 : size);
+		if (new_nodes)
+			new = old + size / sizeof(unsigned long);
+		if (copy_to_user(old, nodes_addr(tmp_mask), size))
+			return -EFAULT;
+	}
+	if (new_nodes) {
+		if (compat_get_bitmap(nodes_addr(tmp_mask), new_nodes, nr_bits))
+			return -EFAULT;
+		if (new == NULL)
+			new = compat_alloc_user_space(size);
+		if (copy_to_user(new, nodes_addr(tmp_mask), size))
+			return -EFAULT;
+	}
+	return sys_migrate_pages(pid, nr_bits + 1, old, new);
+}
 #endif
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 0e53314..d7306d0 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -135,6 +135,7 @@ cond_syscall(sys_madvise);
 cond_syscall(sys_mremap);
 cond_syscall(sys_remap_file_pages);
 cond_syscall(compat_sys_move_pages);
+cond_syscall(compat_sys_migrate_pages);
 
 /* block-layer dependent */
 cond_syscall(sys_bdflush);
-- 
1.4.3.2

