Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVGZIpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVGZIpC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 04:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVGZIpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 04:45:02 -0400
Received: from fujitsu0.fujitsu.com ([192.240.0.5]:10410 "EHLO
	fujitsu0.fujitsu.com") by vger.kernel.org with ESMTP
	id S261614AbVGZIpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 04:45:00 -0400
Message-ID: <42E5F80B.7060208@us.fujitsu.com>
Date: Tue, 26 Jul 2005 04:44:59 -0400
From: Nobuhiro Tachino <ntachino@us.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] mpol_free_shared_poliy() is not called for non-inline symlink
 under tmpfs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If the inode is non-inline symbolic link under tmpfs,
shmem_destroy_inode() always skips to call mpol_free_shared_policy().
However the policy field of non-inline symbolic link inode is intact and
I think it is better to be freed by mpol_free_shared_policy().
I'm not sure this actually causes any serious problem, but
the following patch fixes it anyway.


diff -Npur linux.org/mm/shmem.c linux/mm/shmem.c
--- linux.org/mm/shmem.c	2005-07-23 04:44:43.000000000 -0400
+++ linux/mm/shmem.c	2005-07-23 04:58:52.000000000 -0400
@@ -2032,8 +2032,8 @@ static struct inode *shmem_alloc_inode(s

  static void shmem_destroy_inode(struct inode *inode)
  {
-	if ((inode->i_mode & S_IFMT) == S_IFREG) {
-		/* only struct inode is valid if it's an inline symlink */
+	if ((inode->i_mode & S_IFMT) == S_IFREG ||
+	    inode->i_op == &shmem_symlink_inode_operations) {
  		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
  	}
  	kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
