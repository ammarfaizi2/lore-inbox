Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263766AbUFRUwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbUFRUwt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUFRUte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:49:34 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:11789 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262085AbUFRUqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:46:21 -0400
Date: Fri, 18 Jun 2004 21:46:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Stas Sergeev <stsp@aknet.ru>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch][rfc] expandable anonymous shared mappings
In-Reply-To: <40D08D7A.9020909@aknet.ru>
Message-ID: <Pine.LNX.4.44.0406182055380.26845-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004, Stas Sergeev wrote:
> 
> It seems right now there is no way to
> expand the anonymous shared mappings
> (or am I missing something?)

You're right, not missing something.

> This makes this mechanism practically
> useless for many tasks, it otherwise could
> suit very well, I beleive.

You may well be right, though I've no idea of those tasks myself.

Your test case doesn't fork at all: didn't need to to demonstrate
the behaviour you object to, but it doesn't give us any hints of
the use for the change you suggest - shared anonymous only becomes
interesting when you fork.

But I do rather like your idea.  At first I was sceptical, thinking
the same could be achieved in other ways.  But once forked, it's too
late to extend with further shared anonymous areas, they won't be
shared with your children by then.  You can use shared maps of actual
or tmpfs files, or SysV shm, but both are more cumbersome.

Your point, which I now accept, is that we've got this odd thing of
shared anonymous mappings, and this odd thing of mremap extending
maps, can we please put them together in a way that's natural and
useful, rather than in a way that's useless.  (And Linux is free
to specify mremap as it wishes, so long as reasonable compatibility
is retained - and I agree we don't need to reproduce every SIGBUS
of yesteryear.  I would feel uncomfortable about letting mremap
extend SysV shm objects, but that doesn't happen with your patch.)

> The attached patch implements a simple
> nopage vm op for anonymous shared mappings,
> which allows to expand them with mremap().

I've appended a slightly different patch below: much like yours,
but I've a few issues with your shmem_zero_nopage implementation
and so reworked it e.g. it's scary to see an i_sem taken within
mmap_sem (though I don't think there's really any possibility of
deadlock in this case, given the special nature of this object);
we actually want to avoid vmtruncate's RLIMIT_FSIZE check (it's
an implementation detail that we're using something like a file
to back the shared anonymous mapping, the relevant rlimit is
RLIMIT_AS already checked by mremap); must be careful about
two nopages extending at the same time; might as well extend
object to end of vma in one go rather than fault by fault.

Is this patch good for you?

But... I've a couple of reservations, which make me reluctant
to push this patch further without encouragement from others.

One reservation: is there any security aspect to such a change?
Previously the parent (or ancestor) determined the maximum size
of the anonymous shared object, now children can extend it (and
it will all remain allocated until the very last mapping of any
part of it is unmapped).  I don't see an actual problem with that,
just see that it leads me into an area where I'm a little uneasy
(might we need a further MAP_ flag to allow such extension?),
and had better rely on the judgements of others.

Other reservation: it's nicely only a few lines of code, but
it really is a bit of a hack to be extending the object in the
nopage, with SIGBUS on failure.  Isn't the right approach (more
trouble than it's worth?) to extend vm_operations_struct with
an mremap method (perhaps NULL .mremap would be equivalent to
VM_DONTEXPAND, and replace that flag in due course)?  Which in
the shmem_zero case would extend the underlying object (or fail
with a proper mremap failure), and in other cases do nothing but
allow the extension to succeed.  My own inclination is towards
the quick hack in this instance (add the method only when more
uses appear), but again I'd defer to the judgements of others.

Comments?

Hugh

--- 2.6.7/mm/shmem.c	2004-06-16 06:20:39.000000000 +0100
+++ linux/mm/shmem.c	2004-06-17 20:26:26.567507056 +0100
@@ -169,6 +169,7 @@ static struct file_operations shmem_file
 static struct inode_operations shmem_inode_operations;
 static struct inode_operations shmem_dir_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
+static struct vm_operations_struct shmem_zero_vm_ops;
 
 static struct backing_dev_info shmem_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
@@ -1076,7 +1077,8 @@ failed:
 	return error;
 }
 
-struct page *shmem_nopage(struct vm_area_struct *vma, unsigned long address, int *type)
+struct page *shmem_nopage(struct vm_area_struct *vma,
+			  unsigned long address, int *type)
 {
 	struct inode *inode = vma->vm_file->f_dentry->d_inode;
 	struct page *page = NULL;
@@ -1095,6 +1097,36 @@ struct page *shmem_nopage(struct vm_area
 	return page;
 }
 
+struct page *shmem_zero_nopage(struct vm_area_struct *vma,
+				unsigned long address, int *type)
+{
+	struct page *page;
+
+	page = shmem_nopage(vma, address, type);
+	if (unlikely(page == NOPAGE_SIGBUS)) {
+		struct inode *inode = vma->vm_file->f_dentry->d_inode;
+		struct shmem_inode_info *info = SHMEM_I(inode);
+		loff_t vm_size, i_size;
+
+		/*
+		 * If mremap has been used to extend the vma,
+		 * now extend the underlying object to match it.
+		 */
+		vm_size = (vma->vm_end - vma->vm_start) +
+				((loff_t)vma->vm_pgoff << PAGE_SHIFT);
+		spin_lock(&info->lock);
+		i_size = i_size_read(inode);
+		if (i_size < vm_size && vm_size <= SHMEM_MAX_BYTES &&
+		    !shmem_acct_size(info->flags, vm_size - i_size)) {
+			i_size_write(inode, vm_size);
+			inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+		}
+		spin_unlock(&info->lock);
+		page = shmem_nopage(vma, address, type);
+	}
+	return page;
+}
+
 static int shmem_populate(struct vm_area_struct *vma,
 	unsigned long addr, unsigned long len,
 	pgprot_t prot, unsigned long pgoff, int nonblock)
@@ -1976,6 +2008,15 @@ static struct vm_operations_struct shmem
 #endif
 };
 
+static struct vm_operations_struct shmem_zero_vm_ops = {
+	.nopage		= shmem_zero_nopage,
+	.populate	= shmem_populate,
+#ifdef CONFIG_NUMA
+	.set_policy     = shmem_set_policy,
+	.get_policy     = shmem_get_policy,
+#endif
+};
+
 static struct super_block *shmem_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
@@ -2098,7 +2139,8 @@ put_memory:
 int shmem_zero_setup(struct vm_area_struct *vma)
 {
 	struct file *file;
-	loff_t size = vma->vm_end - vma->vm_start;
+	loff_t size = (vma->vm_end - vma->vm_start) +
+			((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 
 	file = shmem_file_setup("dev/zero", size, vma->vm_flags);
 	if (IS_ERR(file))
@@ -2107,7 +2149,7 @@ int shmem_zero_setup(struct vm_area_stru
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	vma->vm_file = file;
-	vma->vm_ops = &shmem_vm_ops;
+	vma->vm_ops = &shmem_zero_vm_ops;
 	return 0;
 }
 

