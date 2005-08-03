Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVHCV7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVHCV7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 17:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVHCV7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 17:59:49 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:48365 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261574AbVHCV7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 17:59:48 -0400
Date: Wed, 3 Aug 2005 14:59:44 -0700
From: Mike Waychison <mikew@google.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Add generic struct ipc_ids seq_file iteration
Message-ID: <20050803215943.GA3353@google.com>
References: <20050803215559.GA3303@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803215559.GA3303@google.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic method for ipc types to be displayed using seq_file.  This patch
abstracts out seq_file iterating over struct ipc_ids into ipc/util.c

Signed-off-by: Mike Waychison <mikew@google.com>

 util.c |  156 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 util.h |    8 +++
 2 files changed, 164 insertions(+)

Index: linux-2.6.12.3/ipc/util.h
===================================================================
--- linux-2.6.12.3.orig/ipc/util.h	2005-08-03 14:31:28.000000000 -0700
+++ linux-2.6.12.3/ipc/util.h	2005-08-03 14:35:19.000000000 -0700
@@ -30,7 +30,15 @@ struct ipc_ids {
 	struct ipc_id_ary* entries;
 };
 
+struct seq_file;
 void __init ipc_init_ids(struct ipc_ids* ids, int size);
+#ifdef CONFIG_PROC_FS
+void __init ipc_init_proc_interface(const char *path, const char *header,
+				    struct ipc_ids *ids,
+				    int (*show)(struct seq_file *, void *));
+#else
+#define ipc_init_proc_interface(path, header, ids, show) do {} while (0)
+#endif
 
 /* must be called with ids->sem acquired.*/
 int ipc_findkey(struct ipc_ids* ids, key_t key);
Index: linux-2.6.12.3/ipc/util.c
===================================================================
--- linux-2.6.12.3.orig/ipc/util.c	2005-08-03 14:31:28.000000000 -0700
+++ linux-2.6.12.3/ipc/util.c	2005-08-03 14:35:19.000000000 -0700
@@ -24,11 +24,20 @@
 #include <linux/security.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
 
 #include <asm/unistd.h>
 
 #include "util.h"
 
+struct ipc_proc_iface {
+	const char *path;
+	const char *header;
+	struct ipc_ids *ids;
+	int (*show)(struct seq_file *, void *);
+};
+
 /**
  *	ipc_init	-	initialise IPC subsystem
  *
@@ -86,6 +95,43 @@ void __init ipc_init_ids(struct ipc_ids*
 		ids->entries->p[i] = NULL;
 }
 
+#ifdef CONFIG_PROC_FS
+static struct file_operations sysvipc_proc_fops;
+/**
+ *	ipc_init_proc_interface	-  Create a proc interface for sysipc types
+ *				   using a seq_file interface.
+ *	@path: Path in procfs
+ *	@header: Banner to be printed at the beginning of the file.
+ *	@ids: ipc id table to iterate.
+ *	@show: show routine.
+ */
+void __init ipc_init_proc_interface(const char *path, const char *header,
+				    struct ipc_ids *ids,
+				    int (*show)(struct seq_file *, void *))
+{
+	struct proc_dir_entry *pde;
+	struct ipc_proc_iface *iface;
+
+	iface = kmalloc(sizeof(*iface), GFP_KERNEL);
+	if (!iface)
+		return;
+	iface->path	= path;
+	iface->header	= header;
+	iface->ids	= ids;
+	iface->show	= show;
+
+	pde = create_proc_entry(path,
+				S_IRUGO,        /* world readable */
+				NULL            /* parent dir */);
+	if (pde) {
+		pde->data = iface;
+		pde->proc_fops = &sysvipc_proc_fops;
+	} else {
+		kfree(iface);
+	}
+}
+#endif
+
 /**
  *	ipc_findkey	-	find a key in an ipc identifier set	
  *	@ids: Identifier set
@@ -578,3 +624,113 @@ int ipc_parse_version (int *cmd)
 }
 
 #endif /* __ARCH_WANT_IPC_PARSE_VERSION */
+
+#ifdef CONFIG_PROC_FS
+static void *sysvipc_proc_next(struct seq_file *s, void *it, loff_t *pos)
+{
+	struct ipc_proc_iface *iface = s->private;
+	struct kern_ipc_perm *ipc = it;
+	loff_t p;
+
+	/* If we had an ipc id locked before, unlock it */
+	if (ipc && ipc != SEQ_START_TOKEN)
+		ipc_unlock(ipc);
+
+	/*
+	 * p = *pos - 1 (because id 0 starts at position 1)
+	 *          + 1 (because we increment the position by one)
+	 */
+	for (p = *pos; p <= iface->ids->max_id; p++) {
+		if ((ipc = ipc_lock(iface->ids, p)) != NULL) {
+			*pos = p + 1;
+			return ipc;
+		}
+	}
+
+	/* Out of range - return NULL to terminate iteration */
+	return NULL;
+}
+
+/*
+ * File positions: pos 0 -> header, pos n -> ipc id + 1.
+ * SeqFile iterator: iterator value locked shp or SEQ_TOKEN_START.
+ */
+static void *sysvipc_proc_start(struct seq_file *s, loff_t *pos)
+{
+	struct ipc_proc_iface *iface = s->private;
+	struct kern_ipc_perm *ipc;
+	loff_t p;
+
+	/*
+	 * Take the lock - this will be released by the corresponding
+	 * call to stop().
+	 */
+	down(&iface->ids->sem);
+
+	/* pos < 0 is invalid */
+	if (*pos < 0)
+		return NULL;
+
+	/* pos == 0 means header */
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
+
+	/* Find the (pos-1)th ipc */
+	for (p = *pos - 1; p <= iface->ids->max_id; p++) {
+		if ((ipc = ipc_lock(iface->ids, p)) != NULL) {
+			*pos = p + 1;
+			return ipc;
+		}
+	}
+	return NULL;
+}
+
+static void sysvipc_proc_stop(struct seq_file *s, void *it)
+{
+	struct kern_ipc_perm *ipc = it;
+	struct ipc_proc_iface *iface = s->private;
+
+	/* If we had a locked segment, release it */
+	if (ipc && ipc != SEQ_START_TOKEN)
+		ipc_unlock(ipc);
+
+	/* Release the lock we took in start() */
+	up(&iface->ids->sem);
+}
+
+static int sysvipc_proc_show(struct seq_file *s, void *it)
+{
+	struct ipc_proc_iface *iface = s->private;
+
+	if (it == SEQ_START_TOKEN)
+		return seq_puts(s, iface->header);
+
+	return iface->show(s, it);
+}
+
+static struct seq_operations sysvipc_proc_seqops = {
+	.start = sysvipc_proc_start,
+	.stop  = sysvipc_proc_stop,
+	.next  = sysvipc_proc_next,
+	.show  = sysvipc_proc_show,
+};
+
+static int sysvipc_proc_open(struct inode *inode, struct file *file) {
+	int ret;
+	struct seq_file *seq;
+
+	ret = seq_open(file, &sysvipc_proc_seqops);
+	if (!ret) {
+		seq = file->private_data;
+		seq->private = PDE(inode)->data;
+	}
+	return ret;
+}
+
+static struct file_operations sysvipc_proc_fops = {
+	.open    = sysvipc_proc_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+#endif /* CONFIG_PROC_FS */
