Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932739AbWJGGAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbWJGGAY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 02:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbWJGGAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 02:00:15 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:11185 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932618AbWJGF42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:56:28 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 13 of 23] Unionfs: Readdir state
Message-Id: <28ddedcd7cbe7b07dc15.1160197652@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
Date: Sat, 07 Oct 2006 01:07:32 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This file contains the routines for maintaining readdir state.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

1 file changed, 295 insertions(+)
fs/unionfs/rdstate.c |  295 ++++++++++++++++++++++++++++++++++++++++++++++++++

diff -r e107be2f4ead -r 28ddedcd7cbe fs/unionfs/rdstate.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/fs/unionfs/rdstate.c	Sat Oct 07 00:46:19 2006 -0400
@@ -0,0 +1,295 @@
+/*
+ * Copyright (c) 2003-2006 Erez Zadok
+ * Copyright (c) 2003-2006 Charles P. Wright
+ * Copyright (c) 2005-2006 Josef 'Jeff' Sipek
+ * Copyright (c) 2005-2006 Junjiro Okajima
+ * Copyright (c) 2005      Arun M. Krishnakumar
+ * Copyright (c) 2004-2006 David P. Quigley
+ * Copyright (c) 2003-2004 Mohammad Nayyer Zubair
+ * Copyright (c) 2003      Puja Gupta
+ * Copyright (c) 2003      Harikesavan Krishnan
+ * Copyright (c) 2003-2006 Stony Brook University
+ * Copyright (c) 2003-2006 The Research Foundation of State University of New York
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "union.h"
+
+/* This file contains the routines for maintaining readdir state. */
+/* There are two structures here, rdstate which is a hash table
+ * of the second structure which is a filldir_node. */
+
+/* This is a kmem_cache_t for filldir nodes, because we allocate a lot of them
+ * and they shouldn't waste memory.  If the node has a small name (as defined
+ * by the dentry structure), then we use an inline name to preserve kmalloc
+ * space. */
+static kmem_cache_t *unionfs_filldir_cachep;
+int init_filldir_cache(void)
+{
+	unionfs_filldir_cachep =
+	    kmem_cache_create("unionfs_filldir", sizeof(struct filldir_node), 0,
+			      SLAB_RECLAIM_ACCOUNT, NULL, NULL);
+
+	if (!unionfs_filldir_cachep)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void destroy_filldir_cache(void)
+{
+	if (unionfs_filldir_cachep)
+		kmem_cache_destroy(unionfs_filldir_cachep);
+}
+
+/* This is a tuning parameter that tells us roughly how big to make the
+ * hash table in directory entries per page.  This isn't perfect, but
+ * at least we get a hash table size that shouldn't be too overloaded.
+ * The following averages are based on my home directory.
+ * 14.44693	Overall
+ * 12.29	Single Page Directories
+ * 117.93	Multi-page directories
+ */
+#define DENTPAGE 4096
+#define DENTPERONEPAGE 12
+#define DENTPERPAGE 118
+#define MINHASHSIZE 1
+static int guesstimate_hash_size(struct inode *inode)
+{
+	struct inode *hidden_inode;
+	int bindex;
+	int hashsize = MINHASHSIZE;
+
+	if (itopd(inode)->uii_hashsize > 0)
+		return itopd(inode)->uii_hashsize;
+
+	for (bindex = ibstart(inode); bindex <= ibend(inode); bindex++) {
+		if (!(hidden_inode = itohi_index(inode, bindex)))
+			continue;
+
+		if (hidden_inode->i_size == DENTPAGE) {
+			hashsize += DENTPERONEPAGE;
+		} else {
+			hashsize +=
+			    (hidden_inode->i_size / DENTPAGE) * DENTPERPAGE;
+		}
+	}
+
+	return hashsize;
+}
+
+int init_rdstate(struct file *file)
+{
+	BUG_ON(sizeof(loff_t) != (sizeof(unsigned int) + sizeof(unsigned int)));
+	BUG_ON(ftopd(file)->rdstate != NULL);
+
+	ftopd(file)->rdstate =
+	    alloc_rdstate(file->f_dentry->d_inode, fbstart(file));
+	if (!ftopd(file)->rdstate)
+		return -ENOMEM;
+	return 0;
+}
+
+struct unionfs_dir_state *find_rdstate(struct inode *inode, loff_t fpos)
+{
+	struct unionfs_dir_state *rdstate = NULL;
+	struct list_head *pos;
+
+	spin_lock(&itopd(inode)->uii_rdlock);
+	list_for_each(pos, &itopd(inode)->uii_readdircache) {
+		struct unionfs_dir_state *r =
+		    list_entry(pos, struct unionfs_dir_state, uds_cache);
+		if (fpos == rdstate2offset(r)) {
+			itopd(inode)->uii_rdcount--;
+			list_del(&r->uds_cache);
+			rdstate = r;
+			break;
+		}
+	}
+	spin_unlock(&itopd(inode)->uii_rdlock);
+	return rdstate;
+}
+
+struct unionfs_dir_state *alloc_rdstate(struct inode *inode, int bindex)
+{
+	int i = 0;
+	int hashsize;
+	int mallocsize = sizeof(struct unionfs_dir_state);
+	struct unionfs_dir_state *rdstate;
+
+	hashsize = guesstimate_hash_size(inode);
+	mallocsize += hashsize * sizeof(struct list_head);
+	/* Round it up to the next highest power of two. */
+	mallocsize--;
+	mallocsize |= mallocsize >> 1;
+	mallocsize |= mallocsize >> 2;
+	mallocsize |= mallocsize >> 4;
+	mallocsize |= mallocsize >> 8;
+	mallocsize |= mallocsize >> 16;
+	mallocsize++;
+
+	/* This should give us about 500 entries anyway. */
+	if (mallocsize > PAGE_SIZE)
+		mallocsize = PAGE_SIZE;
+
+	hashsize =
+	    (mallocsize -
+	     sizeof(struct unionfs_dir_state)) / sizeof(struct list_head);
+
+	rdstate = kmalloc(mallocsize, GFP_KERNEL);
+	if (!rdstate)
+		return NULL;
+
+	spin_lock(&itopd(inode)->uii_rdlock);
+	if (itopd(inode)->uii_cookie >= (MAXRDCOOKIE - 1))
+		itopd(inode)->uii_cookie = 1;
+	else
+		itopd(inode)->uii_cookie++;
+
+	rdstate->uds_cookie = itopd(inode)->uii_cookie;
+	spin_unlock(&itopd(inode)->uii_rdlock);
+	rdstate->uds_offset = 1;
+	rdstate->uds_access = jiffies;
+	rdstate->uds_bindex = bindex;
+	rdstate->uds_dirpos = 0;
+	rdstate->uds_hashentries = 0;
+	rdstate->uds_size = hashsize;
+	for (i = 0; i < rdstate->uds_size; i++)
+		INIT_LIST_HEAD(&rdstate->uds_list[i]);
+
+	return rdstate;
+}
+
+static void free_filldir_node(struct filldir_node *node)
+{
+	if (node->namelen >= DNAME_INLINE_LEN_MIN)
+		kfree(node->name);
+	kmem_cache_free(unionfs_filldir_cachep, node);
+}
+
+void free_rdstate(struct unionfs_dir_state *state)
+{
+	struct filldir_node *tmp;
+	int i;
+
+	for (i = 0; i < state->uds_size; i++) {
+		struct list_head *head = &(state->uds_list[i]);
+		struct list_head *pos, *n;
+
+		/* traverse the list and deallocate space */
+		list_for_each_safe(pos, n, head) {
+			tmp = list_entry(pos, struct filldir_node, file_list);
+			list_del(&tmp->file_list);
+			free_filldir_node(tmp);
+		}
+	}
+
+	kfree(state);
+}
+
+struct filldir_node *find_filldir_node(struct unionfs_dir_state *rdstate,
+				       const char *name, int namelen)
+{
+	int index;
+	unsigned int hash;
+	struct list_head *head;
+	struct list_head *pos;
+	struct filldir_node *cursor = NULL;
+	int found = 0;
+
+	BUG_ON(namelen <= 0);
+
+	hash = full_name_hash(name, namelen);
+	index = hash % rdstate->uds_size;
+
+	head = &(rdstate->uds_list[index]);
+	list_for_each(pos, head) {
+		cursor = list_entry(pos, struct filldir_node, file_list);
+
+		if (cursor->namelen == namelen && cursor->hash == hash
+		    && !strncmp(cursor->name, name, namelen)) {
+			/* a duplicate exists, and hence no need to create entry to the list */
+			found = 1;
+			/* if the duplicate is in this branch, then the file system is corrupted. */
+			if (cursor->bindex == rdstate->uds_bindex) {
+				//buf->error = err = -EIO;
+				printk(KERN_DEBUG
+				       "Possible I/O error unionfs_filldir: a file is duplicated in the same branch %d: %s\n",
+				       rdstate->uds_bindex, cursor->name);
+			}
+			break;
+		}
+	}
+
+	if (!found) {
+		cursor = NULL;
+	}
+	return cursor;
+}
+
+inline struct filldir_node *alloc_filldir_node(const char *name, int namelen,
+					       unsigned int hash, int bindex)
+{
+	struct filldir_node *newnode;
+
+	newnode =
+	    (struct filldir_node *)kmem_cache_alloc(unionfs_filldir_cachep,
+						    SLAB_KERNEL);
+	if (!newnode)
+		goto out;
+
+out:
+	return newnode;
+}
+
+int add_filldir_node(struct unionfs_dir_state *rdstate, const char *name,
+		     int namelen, int bindex, int whiteout)
+{
+	struct filldir_node *new;
+	unsigned int hash;
+	int index;
+	int err = 0;
+	struct list_head *head;
+
+	BUG_ON(namelen <= 0);
+
+	hash = full_name_hash(name, namelen);
+	index = hash % rdstate->uds_size;
+	head = &(rdstate->uds_list[index]);
+
+	new = alloc_filldir_node(name, namelen, hash, bindex);
+	if (!new) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&new->file_list);
+	new->namelen = namelen;
+	new->hash = hash;
+	new->bindex = bindex;
+	new->whiteout = whiteout;
+
+	if (namelen < DNAME_INLINE_LEN_MIN) {
+		new->name = new->iname;
+	} else {
+		new->name = kmalloc(namelen + 1, GFP_KERNEL);
+		if (!new->name) {
+			kmem_cache_free(unionfs_filldir_cachep, new);
+			new = NULL;
+			goto out;
+		}
+	}
+
+	memcpy(new->name, name, namelen);
+	new->name[namelen] = '\0';
+
+	rdstate->uds_hashentries++;
+
+	list_add(&(new->file_list), head);
+out:
+	return err;
+}
+


