Return-Path: <linux-kernel-owner+w=401wt.eu-S932679AbWLSIow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbWLSIow (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWLSIow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:44:52 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:13968 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682AbWLSIov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:44:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=stJAWhuYFO9xbGmpAtYDBsVMhjIhgKcAjeBQkhcYcViembvHz2sAlKUhtUqfmHkvZ8CvlsnRhfe5TOaAi+MYuqmrE3IuQDwEhO3UkJgZQepf7A8qLPUrfywWhAZKN4bROr9AeGJxORnGIlSKL0br2m8EWhyOHKvDBH3cHyUB9o8=
Date: Tue, 19 Dec 2006 17:43:57 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
       Christoph Raisch <raisch@de.ibm.com>
Subject: [PATCH] ehca: fix do_mmap() error check
Message-ID: <20061219084357.GG4049@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of do_mmap() should be checked by IS_ERR().

Cc: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Cc: Christoph Raisch <raisch@de.ibm.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/infiniband/hw/ehca/ehca_uverbs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: 2.6-mm/drivers/infiniband/hw/ehca/ehca_uverbs.c
===================================================================
--- 2.6-mm.orig/drivers/infiniband/hw/ehca/ehca_uverbs.c
+++ 2.6-mm/drivers/infiniband/hw/ehca/ehca_uverbs.c
@@ -321,14 +321,14 @@ int ehca_mmap_nopage(u64 foffset, u64 le
 		     struct vm_area_struct **vma)
 {
 	down_write(&current->mm->mmap_sem);
-	*mapped = (void*)do_mmap(NULL,0, length, PROT_WRITE,
+	*mapped = (void*)do_mmap(NULL, 0, length, PROT_WRITE,
 				 MAP_SHARED | MAP_ANONYMOUS,
 				 foffset);
 	up_write(&current->mm->mmap_sem);
-	if (!(*mapped)) {
+	if (IS_ERR(*mapped)) {
 		ehca_gen_err("couldn't mmap foffset=%lx length=%lx",
 			     foffset, length);
-		return -EINVAL;
+		return PTR_ERR(*mmaped);
 	}
 
 	*vma = find_vma(current->mm, (u64)*mapped);
