Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264368AbUFPSN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbUFPSN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUFPSN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:13:59 -0400
Received: from mail.aknet.ru ([217.67.122.194]:16398 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S264368AbUFPSMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:12:08 -0400
Message-ID: <40D08D7A.9020909@aknet.ru>
Date: Wed, 16 Jun 2004 22:12:10 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch][rfc] expandable anonymous shared mappings
Content-Type: multipart/mixed;
 boundary="------------030307010400080007040904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------030307010400080007040904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hello.

It seems right now there is no way to
expand the anonymous shared mappings
(or am I missing something?)
This makes this mechanism practically
useless for many tasks, it otherwise could
suit very well, I beleive.
The attached patch implements a simple
nopage vm op for anonymous shared mappings,
which allows to expand them with mremap().
Attached is also a test-case which crashes
with bus error without the patch and works
properly with the patch (it tries to expand
the mapping, but without the patch it is
not possible).
The patch is against 2.6.7-rc3-mm2, but
should work with any 2.6.6 I beleive.

I would be glad to hear any comments on that.
I really would like to use the anonymous shared
mappings rather than those heavy-weight
alternatives like shm_open() and such, when
appropriate, but without the mremap() support,
this looks quite impossible to me.


--------------030307010400080007040904
Content-Type: text/x-patch;
 name="anon_nopg.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="anon_nopg.diff"


--- linux/mm/shmem.c	2004-06-15 09:51:54.000000000 +0400
+++ linux/mm/shmem.c	2004-06-15 17:03:04.000000000 +0400
@@ -169,6 +169,7 @@
 static struct inode_operations shmem_inode_operations;
 static struct inode_operations shmem_dir_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
+static struct vm_operations_struct shmem_zero_vm_ops;
 
 static struct backing_dev_info shmem_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
@@ -1095,6 +1096,27 @@
 	return page;
 }
 
+struct page *shmem_zero_nopage(struct vm_area_struct *vma, unsigned long address, int *type)
+{
+	struct inode *inode = vma->vm_file->f_dentry->d_inode;
+	loff_t vm_size = address + PAGE_SIZE - vma->vm_start;
+	loff_t i_size = i_size_read(inode);
+
+	if (i_size < vm_size) {
+		int error;
+		error = shmem_acct_size(SHMEM_I(inode)->flags, vm_size - i_size);
+		if (error)
+			return NOPAGE_SIGBUS;
+		down(&inode->i_sem);
+		error = vmtruncate(inode, vm_size);
+		up(&inode->i_sem);
+		if (error)
+			return NOPAGE_SIGBUS;
+	}
+
+	return shmem_nopage(vma, address, type);
+}
+
 static int shmem_populate(struct vm_area_struct *vma,
 	unsigned long addr, unsigned long len,
 	pgprot_t prot, unsigned long pgoff, int nonblock)
@@ -1970,6 +1992,15 @@
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
@@ -2101,7 +2132,7 @@
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	vma->vm_file = file;
-	vma->vm_ops = &shmem_vm_ops;
+	vma->vm_ops = &shmem_zero_vm_ops;
 	return 0;
 }
 

--------------030307010400080007040904
Content-Type: text/x-csrc;
 name="shar_grow.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="shar_grow.c"


#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

#define NPAG 200

int main(int argc, char *argv[])
{
  char *src, *dst, *ptr, buf[255];

  if ((src = mmap(0, getpagesize(), PROT_READ | PROT_WRITE,
      MAP_SHARED | MAP_ANONYMOUS, -1, 0)) == MAP_FAILED) {
    perror("mmap()");
    return 1;
  }

  printf("mapped to %p\n", src);
  if ((dst = mremap(src, getpagesize(), NPAG * getpagesize(),
      MREMAP_MAYMOVE)) == MAP_FAILED) {
    perror("mremap()");
    return 1;
  }

  sprintf(buf, "cat /proc/%i/maps", getpid());
  system(buf);
  fflush(stdout);

  ptr = dst + (NPAG - 5) * getpagesize();
  printf("trying %p (%p)...\n", ptr, ptr-dst);
  *ptr = 20;
  printf("%#x, works!\n", *ptr);
  ptr = dst + (NPAG - 3) * getpagesize();
  printf("trying %p (%p)...\n", ptr, ptr-dst);
  *ptr = 20;
  printf("%#x, works!\n", *ptr);
  return 0;
}

--------------030307010400080007040904
Content-Type: text/plain


Scanned by evaluation version of Dr.Web antivirus Daemon 
http://drweb.ru/unix/


--------------030307010400080007040904--
