Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbUKKQVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUKKQVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbUKKQVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:21:41 -0500
Received: from asplinux.ru ([195.133.213.194]:4106 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S262280AbUKKQUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:20:17 -0500
Message-ID: <419391B8.3060306@sw.ru>
Date: Thu, 11 Nov 2004 19:22:16 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH]: 4/4GB: Ineffiecency in filemap.c
Content-Type: multipart/mixed;
 boundary="------------020700060601000305060600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020700060601000305060600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes ineffiecency in copying user data in some code pieces
when 4GB split is ON:
filemap.c tries to call __copy_XXX_user while in atomic, but 4GB split
code always fails copying when in atomic. So this optimization for
normal kernels doesn't work with 4GB split, moreover, makes lot's of 
unnessaccary locks/checks.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

P.S. These 4GB split patches are against modified 2.6.8.1 kernel, but 
should be appliable to last Fedora kernels

--------------020700060601000305060600
Content-Type: text/plain;
 name="diff-arch-4gb-copyusr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-arch-4gb-copyusr"

--- ./mm/filemap.c.4gbcptusr	2004-11-10 18:38:19.000000000 +0300
+++ ./mm/filemap.c	2004-11-11 16:34:24.669739800 +0300
@@ -814,6 +814,7 @@ int file_read_actor(read_descriptor_t *d
 	if (size > count)
 		size = count;
 
+#ifndef CONFIG_X86_UACCESS_INDIRECT
 	/*
 	 * Faults on the destination of a read are common, so do it before
 	 * taking the kmap.
@@ -822,20 +823,23 @@ int file_read_actor(read_descriptor_t *d
 		kaddr = kmap_atomic(page, KM_USER0);
 		left = __copy_to_user(desc->arg.buf, kaddr + offset, size);
 		kunmap_atomic(kaddr, KM_USER0);
-		if (left == 0)
-			goto success;
 	}
+#else
+	left = size;
+#endif
 
-	/* Do it the slow way */
-	kaddr = kmap(page);
-	left = __copy_to_user(desc->arg.buf, kaddr + offset, size);
-	kunmap(page);
-
-	if (left) {
-		size -= left;
-		desc->error = -EFAULT;
+	if (left != 0) {
+		/* Do it the slow way */
+		kaddr = kmap(page);
+		left = __copy_to_user(desc->arg.buf, kaddr + offset, size);
+		kunmap(page);
+
+		if (left) {
+			size -= left;
+			desc->error = -EFAULT;
+		}
 	}
-success:
+
 	desc->count = count - size;
 	desc->written += size;
 	desc->arg.buf += size;
@@ -1615,9 +1619,13 @@ filemap_copy_from_user(struct page *page
 	char *kaddr;
 	int left;
 
+#ifndef CONFIG_X86_UACCESS_INDIRECT
 	kaddr = kmap_atomic(page, KM_USER0);
 	left = __copy_from_user(kaddr + offset, buf, bytes);
 	kunmap_atomic(kaddr, KM_USER0);
+#else
+	left = bytes;
+#endif
 
 	if (left != 0) {
 		/* Do it the slow way */
@@ -1668,10 +1676,14 @@ filemap_copy_from_user_iovec(struct page
 	char *kaddr;
 	size_t copied;
 
+#ifndef CONFIG_X86_UACCESS_INDIRECT
 	kaddr = kmap_atomic(page, KM_USER0);
 	copied = __filemap_copy_from_user_iovec(kaddr + offset, iov,
 						base, bytes);
 	kunmap_atomic(kaddr, KM_USER0);
+#else
+	copied = 0;
+#endif
 	if (copied != bytes) {
 		kaddr = kmap(page);
 		copied = __filemap_copy_from_user_iovec(kaddr + offset, iov,
--- ./mm/shmem.c.4gbcptusr	2004-11-10 18:38:19.000000000 +0300
+++ ./mm/shmem.c	2004-11-11 14:21:39.919565872 +0300
@@ -1322,6 +1322,7 @@ shmem_file_write(struct file *file, cons
 			break;
 
 		left = bytes;
+#ifndef CONFIG_X86_UACCESS_INDIRECT
 		if (PageHighMem(page)) {
 			volatile unsigned char dummy;
 			__get_user(dummy, buf);
@@ -1331,6 +1332,7 @@ shmem_file_write(struct file *file, cons
 			left = __copy_from_user(kaddr + offset, buf, bytes);
 			kunmap_atomic(kaddr, KM_USER0);
 		}
+#endif
 		if (left) {
 			kaddr = kmap(page);
 			left = __copy_from_user(kaddr + offset, buf, bytes);

--------------020700060601000305060600--

