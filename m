Return-Path: <linux-kernel-owner+w=401wt.eu-S1751556AbXARV3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbXARV3A (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbXARV3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:29:00 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:34747 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbXARV27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:28:59 -0500
Date: Thu, 18 Jan 2007 15:28:58 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] eCryptfs: add flush_dcache_page() calls
Message-ID: <20070118212858.GF3643@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20070118212627.GC3643@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118212627.GC3643@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 02:42:03PM -0800, Andrew Morton wrote:
> On Tue, 9 Jan 2007 16:23:37 -0600
> Michael Halcrow <mhalcrow@us.ibm.com> wrote:
> > +                                   set_header_info(page_virt, crypt_stat);
> > +                           }
>
> The kernel must always run flush_dcache_page() after modifying a pagecache
> page by hand.  Please review all of ecryptfs for this.

Call flush_dcache_page() after modifying a pagecache by hand.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/mmap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

b77b1e2cbda1dfa6cc0925bca790701261771c43
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 2a7ba51..59ec097 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -238,7 +238,9 @@ int ecryptfs_do_readpage(struct file *fi
 	lower_page_data = (char *)kmap_atomic(lower_page, KM_USER1);
 	memcpy(page_data, lower_page_data, PAGE_CACHE_SIZE);
 	kunmap_atomic(lower_page_data, KM_USER1);
+	flush_dcache_page(lower_page);
 	kunmap_atomic(page_data, KM_USER0);
+	flush_dcache_page(page);
 	rc = 0;
 out:
 	if (likely(lower_page))
@@ -322,6 +324,7 @@ static int ecryptfs_readpage(struct file
 					set_header_info(page_virt, crypt_stat);
 				}
 				kunmap_atomic(page_virt, KM_USER0);
+				flush_dcache_page(page);
 				if (rc) {
 					printk(KERN_ERR "Error reading xattr "
 					       "region\n");
@@ -382,6 +385,7 @@ static int fill_zeros_to_end_of_page(str
 	memset((page_virt + end_byte_in_page), 0,
 	       (PAGE_CACHE_SIZE - end_byte_in_page));
 	kunmap_atomic(page_virt, KM_USER0);
+	flush_dcache_page(page);
 out:
 	return 0;
 }
@@ -456,6 +460,7 @@ static int ecryptfs_write_inode_size_to_
 	header_virt = kmap_atomic(header_page, KM_USER0);
 	memcpy(header_virt, &file_size, sizeof(u64));
 	kunmap_atomic(header_virt, KM_USER0);
+	flush_dcache_page(header_page);
 	rc = lower_a_ops->commit_write(lower_file, header_page, 0, 8);
 	if (rc < 0)
 		ecryptfs_printk(KERN_ERR, "Error commiting header page "
@@ -742,6 +747,7 @@ int write_zeros(struct file *file, pgoff
 	tmp_page_virt = kmap_atomic(tmp_page, KM_USER0);
 	memset(((char *)tmp_page_virt + start), 0, num_zeros);
 	kunmap_atomic(tmp_page_virt, KM_USER0);
+	flush_dcache_page(tmp_page);
 	rc = ecryptfs_commit_write(file, tmp_page, start, start + num_zeros);
 	if (rc < 0) {
 		ecryptfs_printk(KERN_ERR, "Error attempting to write zero's "
-- 
1.3.3

