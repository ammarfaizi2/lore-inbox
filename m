Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWEIHKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWEIHKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 03:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWEIHKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 03:10:52 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:15318 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751437AbWEIHKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 03:10:51 -0400
Date: Tue, 9 May 2006 12:39:11 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: [RFC] [PATCH 4/6] Kprobes: Insert probes on non-memory resident pages
Message-ID: <20060509070911.GD22493@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060509065455.GA11630@in.ibm.com> <20060509065917.GA22493@in.ibm.com> <20060509070106.GB22493@in.ibm.com> <20060509070508.GC22493@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509070508.GC22493@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

User-space probes also supports the registering of the probe points
before the probed code is loaded. This clearly has advantages for
catching initialization problems. This involves modifying the probed
applications address_space readpage() and readpages(). Overhead of
changing the address_space readpage/s() is limited to only the probed
application until all probes are removed from that application.

This patch provides the feature of inserting probes on pages that are
not present in the memory during registration.

To add readpage and readpages() hooks, two new elements are added to
the uprobe_module object:
	struct address_space_operations *ori_a_ops;
	struct address_space_operations user_a_ops;

When the pages are read into memory through the readpage and
readpages address space operations, any associated probes are
automatically inserted into those pages. These user-space probes
readpage and readpages routines internally call the original
readpage() and readpages() routines, and then check whether probes are
to be added to these pages, inserting probes as necessary.

During unregistration, care should be taken to replace the readpage
and readpages hooks with the original routines if no probes remain on
that application.

Signed-of-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


 kernel/uprobes.c |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 121 insertions(+)

diff -puN kernel/uprobes.c~kprobes_userspace_probes-hook-readpage kernel/uprobes.c
--- linux-2.6.17-rc3-mm1/kernel/uprobes.c~kprobes_userspace_probes-hook-readpage	2006-05-09 10:08:49.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/kernel/uprobes.c	2006-05-09 10:08:49.000000000 +0530
@@ -300,15 +300,134 @@ struct uprobe_module __kprobes *get_modu
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
+/*
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
+/*
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
 /*
  * Add uprobe and uprobe_module to the appropriate hash list.
+ * Also switches i_op to hooks into readpage and readpages().
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
@@ -437,6 +556,8 @@ void __kprobes unregister_uprobe(struct 
 	hlist_del(&uprobe->ulist);
 	if (hlist_empty(&umodule->ulist_head)) {
 		list_del(&umodule->mlist);
+		umodule->nd.dentry->d_inode->i_mapping->a_ops =
+							umodule->ori_a_ops;
 		write_access_to_inode(uprobe->inode);
 		path_release(&umodule->nd);
 		kfree(umodule);

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
