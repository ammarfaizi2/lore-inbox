Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbWHXPXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWHXPXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWHXPXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:23:34 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:37553 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964997AbWHXPXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:23:32 -0400
Date: Thu, 24 Aug 2006 10:23:22 -0500
From: "Serge E. Hallyn" <sergeh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Serge E Hallyn <sergeh@us.ibm.com>, kjhall@us.ibm.com,
       Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       David Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>
Subject: Re: [PATCH 3/7] SLIM main patch
Message-ID: <20060824152322.GD32764@sergelap.austin.ibm.com>
References: <1156359937.6720.66.camel@localhost.localdomain> <20060823192733.GG28594@kvack.org> <1156365357.6720.87.camel@localhost.localdomain> <1156418815.3007.89.camel@localhost.localdomain> <20060824133248.GC15680@sergelap.austin.ibm.com> <1156428917.3007.150.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156428917.3007.150.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> Ar Iau, 2006-08-24 am 08:32 -0500, ysgrifennodd Serge E. Hallyn:
> > > You also have to deal with existing mmap() mappings and outstanding I/O.
> > 
> > That she does.
> 
> I don't believe so from the patches.
> 
> > > 	SysV shared memory
> > 
> > standard mmap controls should handle this, right?
> 
> No its rather independant of mmap

There are controls on shmat, and shm which has been mmap'ed will be
revoked.

> > > 	mmap
> > 
> > She handles these.
> 
> I must have missed where it handles that.
> 
> > thread #2 is reading data from a pipe which is at a secret level, so how
> > will it exploit that?  It can't write it to a lower integrity file...
> 
> Ok my example isn't quite right - I can create the pipes and do the
> blocking in other patterns to get the result I mean. The problem is that
> I can be blocked in a driver write() method before you raise the
> security level and no change at the VFS level will be early enough to
> stop it.
> 
> Another example would be
> 
> Type ^S > 	thread #1
> 		write(console, padding, internalbuffersize);
> 		write(console, secret_buffer, data) [blocks]
> 
> 	thread #2
> 		sleep to be sure #1 is blocked
> 		open secret file
> 		read(secret, secret_buffer, data);
> 
> Type ^Q
> 
> By the time you raise the security level due to the action of thread #2
> I'm already blocked in tty_do_write() and have passed any vfs checks.

So using the following two patches should solve that problem, by making
sure that the tty pages can't be made writeable again?

Or will the page associated with the tty already have the data, and this
really just needs to be fixed in the tty itself?

-serge

>From 413fe6a2d2563cfd0ab488b89c9a42043d1e698c Mon Sep 17 00:00:00 2001
From: Serge E. Hallyn <serue@us.ibm.com>
Date: Tue, 8 Aug 2006 10:23:19 -0500
Subject: [PATCH 1/3] security: define vm_revoke_write

Define vm_revoke_write() function which may be used to revoke write
permission from a vma_area_struct.  This can be used, for example,
by security modules wishing to revoke write permissions to a process
whose clearance has changed.

The first intended user for this function is the SLIM LSM, which
implements dynamic process integrity labels.  As integrity labels
on a process lower, write permission may need to be revoked to
high integrity files.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 include/linux/mm.h |    2 ++
 mm/mprotect.c      |   18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 990957e..cad1936 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1072,5 +1072,7 @@ #endif
 
 const char *arch_vma_name(struct vm_area_struct *vma);
 
+extern void vm_revoke_write(struct vm_area_struct *vma);
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 638edab..21c322e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -21,6 +21,7 @@ #include <linux/personality.h>
 #include <linux/syscalls.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/module.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
@@ -115,6 +116,23 @@ static void change_protection(struct vm_
 	flush_tlb_range(vma, start, end);
 }
 
+void vm_revoke_write(struct vm_area_struct *vma)
+{
+	pgprot_t newprot;
+
+	down_write(&current->mm->mmap_sem);
+	if (!(vma->vm_flags & VM_SHARED))
+		goto out;
+	if (!(vma->vm_flags & (VM_WRITE|VM_MAYWRITE)))
+		goto out;
+	vma->vm_flags &= ~(VM_MAYWRITE|VM_WRITE);
+	newprot = protection_map[vma->vm_flags];
+	change_protection(vma, vma->vm_start, vma->vm_end, newprot);
+out:
+	up_write(&current->mm->mmap_sem);
+}
+EXPORT_SYMBOL_GPL(vm_revoke_write);
+
 static int
 mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	unsigned long start, unsigned long end, unsigned long newflags)
-- 
1.4.1.1

>From 195e53662e09bba81c59681eece3beedff2b7d1e Mon Sep 17 00:00:00 2001
From: Serge E. Hallyn <serue@us.ibm.com>
Date: Tue, 8 Aug 2006 10:25:23 -0500
Subject: [PATCH 2/3] security: define security_page_mkwrite

Define a security_page_mkwrite() hook which is called before making
a page writable.  This can be used by security modules after revoking
write access to a vma, in order to avoid reacquiring write access,
without having to manually change the file->f_mode.

The intended user of this hook is the SLIM security module, which
needs the ability to revoke write access to an open file when a
process' integrity level is lowered.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 include/linux/security.h |   21 +++++++++++++++++++++
 mm/memory.c              |   11 +++++++++++
 security/dummy.c         |    7 +++++++
 3 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index f753038..5515188 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -410,6 +410,14 @@ #ifdef CONFIG_SECURITY
  *	the size of the buffer required.
  *	Returns number of bytes used/required on success.
  *
+ * Security hooks for page operations
+ *
+ * @page_mkwrite:
+ *	Check for permission to make a page table entry writable.
+ *	@vma is the vma to which the page belongs
+ *	@p is the struct page wanting to be made writable
+ *	Return 0 if permission is granted.
+ *
  * Security hooks for file operations
  *
  * @file_permission:
@@ -1198,6 +1206,7 @@ struct security_operations {
   	int (*inode_setsecurity)(struct inode *inode, const char *name, const void *value, size_t size, int flags);
   	int (*inode_listsecurity)(struct inode *inode, char *buffer, size_t buffer_size);
 
+	int (*page_mkwrite) (struct vm_area_struct *vma, struct page *p);
 	int (*file_permission) (struct file * file, int mask);
 	int (*file_alloc_security) (struct file * file);
 	void (*file_free_security) (struct file * file);
@@ -1738,6 +1747,12 @@ static inline int security_inode_listsec
 	return security_ops->inode_listsecurity(inode, buffer, buffer_size);
 }
 
+static inline int security_page_mkwrite(struct vm_area_struct *vma,
+			struct page *p)
+{
+	return security_ops->page_mkwrite(vma, p);
+}
+
 static inline int security_file_permission (struct file *file, int mask)
 {
 	return security_ops->file_permission (file, mask);
@@ -2405,6 +2420,12 @@ static inline int security_inode_listsec
 	return 0;
 }
 
+static inline int security_page_mkwrite(struct vm_area_struct *vma,
+			struct page *p)
+{
+	return 0;
+}
+
 static inline int security_file_permission (struct file *file, int mask)
 {
 	return 0;
diff --git a/mm/memory.c b/mm/memory.c
index 109e986..c4ed919 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -49,6 +49,7 @@ #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/delayacct.h>
 #include <linux/init.h>
+#include <linux/security.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -1466,6 +1467,12 @@ static int do_wp_page(struct mm_struct *
 
 	if (unlikely((vma->vm_flags & (VM_SHARED|VM_WRITE)) ==
 				(VM_SHARED|VM_WRITE))) {
+		ret = security_page_mkwrite(vma, old_page);
+		if (ret) {
+			page_cache_release(old_page);
+			return VM_FAULT_SIGBUS;
+		}
+
 		if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
 			/*
 			 * Notify the address space that the page is about to
@@ -2144,6 +2151,10 @@ retry:
 			/* if the page will be shareable, see if the backing
 			 * address space wants to know that the page is about
 			 * to become writable */
+			if (security_page_mkwrite(vma, new_page)) {
+				page_cache_release(new_page);
+				return VM_FAULT_SIGBUS;
+			}
 			if (vma->vm_ops->page_mkwrite &&
 			    vma->vm_ops->page_mkwrite(vma, new_page) < 0
 			    ) {
diff --git a/security/dummy.c b/security/dummy.c
index bbbfda7..20e838e 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -397,6 +397,12 @@ static const char *dummy_inode_xattr_get
 	return NULL;
 }
 
+static inline int dummy_page_mkwrite(struct vm_area_struct *vma,
+			struct page *p)
+{
+	return 0;
+}
+
 static int dummy_file_permission (struct file *file, int mask)
 {
 	return 0;
@@ -968,6 +974,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, inode_getsecurity);
 	set_to_dummy_if_null(ops, inode_setsecurity);
 	set_to_dummy_if_null(ops, inode_listsecurity);
+	set_to_dummy_if_null(ops, page_mkwrite);
 	set_to_dummy_if_null(ops, file_permission);
 	set_to_dummy_if_null(ops, file_alloc_security);
 	set_to_dummy_if_null(ops, file_free_security);
-- 
1.4.1.1

