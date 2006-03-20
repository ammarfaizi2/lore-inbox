Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbWCTGJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWCTGJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWCTGJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:09:53 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:23521 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751640AbWCTGJw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:09:52 -0500
Date: Mon, 20 Mar 2006 11:40:14 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Message-ID: <20060320061014.GE31091@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060320060745.GC31091@in.ibm.com> <20060320060931.GD31091@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320060931.GD31091@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the feature of inserting probes on pages that are
not present in the memory during registration.

To add readpage and readpages() hooks, two new elements are added to
the uprobe_module object:
	struct address_space_operations *ori_a_ops;
	struct address_space_operations user_a_ops;

User-space probes allows probes to be inserted even in pages that are
not present in the memory at the time of registration. This is done
by adding hooks to the readpage and readpages routines. During
registration, the address space operation object is modified by
substituting user-space probes's specific readpage and readpages
routines. When the pages are read into memory through the readpage and
readpages address space operations, any associated probes are
automatically inserted into those pages. These user-space probes
readpage and readpages routines internally call the original
readpage() and readpages() routines, and then check whether probes are
to be added to these pages, inserting probes as necessary. The
overhead of adding these hooks is limited to the application on which
the probes are inserted.

During unregistration, care should be taken to replace the readpage and
readpages hooks with the original routines if no probes remain on that
application.

Signed-of-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>



 kernel/uprobes.c |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 121 insertions(+)

diff -puN kernel/uprobes.c~kprobes_userspace_probes-hook-readpage kernel/uprobes.c
--- linux-2.6.16-rc6-mm2/kernel/uprobes.c~kprobes_userspace_probes-hook-readpage	2006-03-20 10:49:14.000000000 +0530
+++ linux-2.6.16-rc6-mm2-prasanna/kernel/uprobes.c	2006-03-20 10:49:14.000000000 +0530
@@ -302,6 +302,115 @@ static struct uprobe_module __kprobes *g
 	return NULL;
 }
 
+static inline void insert_readpage_uprobe(struct page *page,
+	struct address_space *mapping, struct uprobe *uprobe)
+{
+	unsigned long page_start = page->index << PAGE_CACHE_SHIFT;
+	unsigned long page_end = page_start + PAGE_SIZE;
+
+	if ((uprobe->offset >= page_start) && (uprobe->offset < page_end)) {
+		map_uprobe_page(page, uprobe, insert_kprobe_user);
+		flush_vma(mapping, page, uprobe);
+	}
+}
+
+/**
+ *  This function hooks the readpages() of all modules that have active
+ *  probes on them. The original readpages() is called for the given
+ *  inode/address_space to actually read the pages into the memory.
+ *  Then all probes that are specified on these pages are inserted.
+ */
+static int __kprobes uprobe_readpages(struct file *file,
+				struct address_space *mapping,
+				struct list_head *pages, unsigned nr_pages)
+{
+	int retval = 0;
+	struct page *page;
+	struct uprobe_module *umodule;
+	struct uprobe *uprobe = NULL;
+	struct hlist_node *node;
+
+	mutex_lock(&uprobe_mutex);
+
+	umodule = get_module_by_inode(file->f_dentry->d_inode);
+	if (!umodule) {
+		/*
+		 * No module associated with this file, call the
+		 * original readpages().
+		 */
+		retval = mapping->a_ops->readpages(file, mapping,
+							pages, nr_pages);
+		goto out;
+	}
+
+	/* call original readpages() */
+	retval = umodule->ori_a_ops->readpages(file, mapping, pages, nr_pages);
+	if (retval < 0)
+		goto out;
+
+	/*
+	 * TODO: Walk through readpages page list and get
+	 * pages with probes instead of find_get_page().
+	 */
+	hlist_for_each_entry(uprobe, node, &umodule->ulist_head, ulist) {
+		page = find_get_page(mapping,
+				uprobe->offset >> PAGE_CACHE_SHIFT);
+		if (!page)
+			continue;
+
+		if (!uprobe->kp.opcode)
+			insert_readpage_uprobe(page, mapping, uprobe);
+		page_cache_release(page);
+	}
+
+out:
+	mutex_unlock(&uprobe_mutex);
+
+	return retval;
+}
+
+/**
+ *  This function hooks the readpage() of all modules that have active
+ *  probes on them. The original readpage() is called for the given
+ *  inode/address_space to actually read the pages into the memory.
+ *  Then all probes that are specified on this page are inserted.
+ */
+int __kprobes uprobe_readpage(struct file *file, struct page *page)
+{
+	int retval = 0;
+	struct uprobe_module *umodule;
+	struct uprobe *uprobe = NULL;
+	struct hlist_node *node;
+	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+
+	mutex_lock(&uprobe_mutex);
+
+	umodule = get_module_by_inode(file->f_dentry->d_inode);
+	if (!umodule) {
+		/*
+		 * No module associated with this file, call the
+		 * original readpage().
+		 */
+		retval = mapping->a_ops->readpage(file, page);
+		goto out;
+	}
+
+	/* call original readpage() */
+	retval = umodule->ori_a_ops->readpage(file, page);
+	if (retval < 0)
+		goto out;
+
+	hlist_for_each_entry(uprobe, node, &umodule->ulist_head, ulist) {
+		if (!uprobe->kp.opcode)
+			insert_readpage_uprobe(page, mapping, uprobe);
+	}
+
+out:
+	mutex_unlock(&uprobe_mutex);
+
+	return retval;
+}
+
 /**
  * Gets exclusive write access to the given inode to ensure that the file
  * on which probes are currently applied does not change. Use the function,
@@ -324,13 +433,23 @@ static inline int ex_write_unlock(struct
 
 /**
  * Add uprobe and uprobe_module to the appropriate hash list.
+ * Also swithces i_op to hooks into readpage and readpages().
  */
 static void __kprobes get_inode_ops(struct uprobe *uprobe,
 				   struct uprobe_module *umodule)
 {
+	struct address_space *as;
+
 	INIT_HLIST_HEAD(&umodule->ulist_head);
 	hlist_add_head(&uprobe->ulist, &umodule->ulist_head);
 	list_add(&umodule->mlist, &uprobe_module_list);
+	as = umodule->nd.dentry->d_inode->i_mapping;
+	umodule->ori_a_ops = as->a_ops;
+	umodule->user_a_ops = *as->a_ops;
+	umodule->user_a_ops.readpage = uprobe_readpage;
+	umodule->user_a_ops.readpages = uprobe_readpages;
+	as->a_ops = &umodule->user_a_ops;
+
 }
 
 /*
@@ -459,6 +578,8 @@ void __kprobes unregister_uprobe(struct 
 	hlist_del(&uprobe->ulist);
 	if (hlist_empty(&umodule->ulist_head)) {
 		list_del(&umodule->mlist);
+		umodule->nd.dentry->d_inode->i_mapping->a_ops =
+							umodule->ori_a_ops;
 		ex_write_unlock(uprobe->inode);
 		path_release(&umodule->nd);
 		kfree(umodule);

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
