Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUFSJHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUFSJHV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 05:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbUFSJHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 05:07:21 -0400
Received: from mail.aknet.ru ([217.67.122.194]:30728 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S265256AbUFSJHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 05:07:06 -0400
Message-ID: <40D4023E.8010500@aknet.ru>
Date: Sat, 19 Jun 2004 13:07:10 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch][rfc] expandable anonymous shared mappings
References: <Pine.LNX.4.44.0406182055380.26845-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0406182055380.26845-100000@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------050006070800070601090702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------050006070800070601090702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

Hugh Dickins wrote:
>> It seems right now there is no way to
>> expand the anonymous shared mappings
>> (or am I missing something?)
> You're right, not missing something.
Good. Thanks for taking a look.

>> This makes this mechanism practically
>> useless for many tasks, it otherwise could
>> suit very well, I beleive.
> You may well be right, though I've no idea of those tasks myself.
I'll try to explain what I wanted to achieve.

> Your test case doesn't fork at all: didn't need to to demonstrate
> the behaviour you object to, but it doesn't give us any hints of
> the use for the change you suggest -
Why I didn't demonstrate its use is because
I actually have an impression the current
behaviour is simply not what someone may
expect after reading "man mmap" and
"man mremap". Nothing in that docs says that
it is not possible to expand that mapping
with mremap(), and I expected it to be expandable
the same way the private anonymous mapping is.
So I just assumed it is a bug, not a design
decision. So I demanstrated not too much, just
whatever I considered a bogus behaveour.

> shared anonymous only becomes
> interesting when you fork.
I disagree with this. The way I am using it,
may look horrible (so that was another reason
I haven't demonstrated it), but yes, I do use
it without the fork().
Here is how am I using it, roughly:
---
pool=mmap(0,pool_size,...,MAP_SHARED|MAP_ANONYMUS,...);
area1=mremap2(pool, 0, area1_size, MREMAP_MAYMOVE|MREMAP_FIXED, area1_addr);
area2=mremap2(pool, 0, area2_size, MREMAP_MAYMOVE|MREMAP_FIXED, area2_addr);
assert(area1==area1_addr && area2==area2_addr);
---
where mremap2() is a function which calls the
mremap syscall directly, to make use of MREMAP_FIXED.
Please don't beat me on that, that's just how
I am (ab)using that stuff :)

> But I do rather like your idea.  At first I was sceptical, thinking
> the same could be achieved in other ways.  But once forked, it's too
> late to extend with further shared anonymous areas, they won't be
> shared with your children by then.  You can use shared maps of actual
> or tmpfs files, or SysV shm, but both are more cumbersome.
Yes, that's the main point. And also I think
this makes the interface more consistent.

> Your point, which I now accept, is that we've got this odd thing of
> shared anonymous mappings, and this odd thing of mremap extending
> maps, can we please put them together in a way that's natural and
> useful, rather than in a way that's useless.
Yes, exactly! This says everything I had to say
in my initial post myself, but haven't done.

> I've appended a slightly different patch below: much like yours,
> but I've a few issues with your shmem_zero_nopage implementation
[...]
> we actually want to avoid vmtruncate's RLIMIT_FSIZE check (it's
Yes, I expected that calling vmtruncate() can be
a bad idea vrt RLIMIT_FSIZE check, esp. when it
sends the SIGXFSZ and then my patch returns
NOPAGE_SIGBUS. Your patch is certainly better.

> Is this patch good for you?
Yes, the patch works. But I still think it can
be cleared up a bit. Esp. I think we can avoid
calling shmem_nopage() twice as we know for sure
(or do we?) that it will fail when i_size<vm_size.
I merged my patch and your patch, I think whatever
I get, is a little cleaner. It is attached.

> One reservation: is there any security aspect to such a change?
> Previously the parent (or ancestor) determined the maximum size
> of the anonymous shared object, now children can extend it (and
> it will all remain allocated until the very last mapping of any
> part of it is unmapped).  I don't see an actual problem with that,
> just see that it leads me into an area where I'm a little uneasy
> (might we need a further MAP_ flag to allow such extension?),
I think (and I may be completely wrong) that we need
the flag to *disallow* such extension. Something like
MAP_DONTEXPAND which will set the VM_DONTEXPAND for vma.
Something more generic, not making the anon shared
mapping a special case.

> Other reservation: it's nicely only a few lines of code, but
> it really is a bit of a hack to be extending the object in the
> nopage, with SIGBUS on failure. 
I agree with that completely. But that seems to
be the design choise to me, so I hadn't any
idea how to get around this, when making the patch
(truncating inside the mremap() itself doesn't
really work with the current design I think).

> Isn't the right approach (more
> trouble than it's worth?) to extend vm_operations_struct with
> an mremap method (perhaps NULL .mremap would be equivalent to
> VM_DONTEXPAND, and replace that flag in due course)?  Which in
That sounds like a very good idea to me. I was
always wondering if it is really the right thing
to not have the .mremap handler at all.
And IIRC right now the missing nopage handler
just causes the zero-page to be mapped in, which
already made me confused a couple of times
(for example I tried to expand the /dev/mem
mapping and was wondering why nothing works).
Instead, making a missing mremap handler to
be equivalent of VM_DONTEXPAND, so that mremap()
to just fail right away, sound very reasonable
to me. But I am not pretending to understand
the linux mm code, so I may be wrong in everything
I am saying here.
As a starting point I am attaching a small
patch for VM_DONTEXPAND. I think it is
implemented wrongly right now. It should
allow the things like
mremap(addr, 0, old_size, MREMAP_MAYMOVE);
but it doesn't. I think it is a bug, and if
we want to have whatever you suggest, we need
this patch. What do you think?

Thanks for your comments again. They were
extremely usefull for me in both educational
and practical purposes.


--------------050006070800070601090702
Content-Type: text/x-patch;
 name="anon_shm1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="anon_shm1.diff"


--- 2.6.7/mm/shmem.c	2004-06-16 06:20:39.000000000 +0100
+++ linux/mm/shmem.c	2004-06-17 20:26:26.567507056 +0100
@@ -169,6 +169,7 @@
 static struct inode_operations shmem_inode_operations;
 static struct inode_operations shmem_dir_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
+static struct vm_operations_struct shmem_zero_vm_ops;
 
 static struct backing_dev_info shmem_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
@@ -1095,6 +1096,33 @@
 	return page;
 }
 
+struct page *shmem_zero_nopage(struct vm_area_struct *vma, unsigned long address, int *type)
+{
+	struct inode *inode = vma->vm_file->f_dentry->d_inode;
+	loff_t vm_size = (vma->vm_end - vma->vm_start) +
+		((loff_t)vma->vm_pgoff << PAGE_SHIFT);
+	loff_t i_size = i_size_read(inode);
+
+	if (unlikely(i_size < vm_size)) {
+		struct shmem_inode_info *info = SHMEM_I(inode);
+		if (shmem_acct_size(info->flags, vm_size - i_size))
+			return NOPAGE_OOM;
+		/*
+		 * If mremap has been used to extend the vma,
+		 * now extend the underlying object to match it.
+		 */
+		if (vm_size <= SHMEM_MAX_BYTES) {
+			spin_lock(&info->lock);
+			i_size_write(inode, vm_size);
+			inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+			spin_unlock(&info->lock);
+		} else
+			return NOPAGE_SIGBUS;
+	}
+
+	return shmem_nopage(vma, address, type);
+}
+
 static int shmem_populate(struct vm_area_struct *vma,
 	unsigned long addr, unsigned long len,
 	pgprot_t prot, unsigned long pgoff, int nonblock)
@@ -1970,6 +1998,15 @@
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
@@ -2092,7 +2129,8 @@
 int shmem_zero_setup(struct vm_area_struct *vma)
 {
 	struct file *file;
-	loff_t size = vma->vm_end - vma->vm_start;
+	loff_t size = (vma->vm_end - vma->vm_start) +
+			((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 
 	file = shmem_file_setup("dev/zero", size, vma->vm_flags);
 	if (IS_ERR(file))
@@ -2101,7 +2139,7 @@
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	vma->vm_file = file;
-	vma->vm_ops = &shmem_vm_ops;
+	vma->vm_ops = &shmem_zero_vm_ops;
 	return 0;
 }
 

--------------050006070800070601090702
Content-Type: text/x-patch;
 name="mremap.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mremap.diff"


--- linux-2.6.6/mm/mremap.c.old	2004-06-14 19:48:36.000000000 +0400
+++ linux-2.6.6/mm/mremap.c	2004-06-19 11:54:28.508681472 +0400
@@ -320,7 +320,7 @@
 	if (old_len > vma->vm_end - addr)
 		goto out;
 	if (vma->vm_flags & VM_DONTEXPAND) {
-		if (new_len > old_len)
+		if (new_len > vma->vm_end - addr)
 			goto out;
 	}
 	if (vma->vm_flags & VM_LOCKED) {

--------------050006070800070601090702
Content-Type: text/plain


Scanned by evaluation version of Dr.Web antivirus Daemon 
http://drweb.ru/unix/


--------------050006070800070601090702--
