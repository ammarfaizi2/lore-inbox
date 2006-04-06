Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWDFVEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWDFVEB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 17:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWDFVEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 17:04:01 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10918
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751321AbWDFVEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 17:04:01 -0400
Date: Thu, 06 Apr 2006 14:03:57 -0700 (PDT)
Message-Id: <20060406.140357.14088592.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Subject: fs/binfmt_elf.c:maydump()
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I sort of understand the idea behind this check in maydump():

	/* If it hasn't been written to, don't write it out */
	if (!vma->anon_vma)
		return 0;

but it causes real problems for debugging.  In fact a GDB testcase
breaks because of this check.

In the GDB testcase, the application mmap()'s a file with some
text in it.  It then calls abort() to dump core.  Then GDB loads
up the application again using that core file, and it tries to
look at the mmap()'d file, and that doesn't work.  We don't dump
the file contents because of the above check so GDB has no idea
how to reproduce the application state at the time of the core
dump.

Furthermore, it is vitally important to dump such areas to handle the
case where the file contents change after the core dump occurs.
So even if we had some way to tell GDB the full pathname of the
file which was mapped at that location, we should still dump the
contents and not try to elide them via this check in maydump().

Yes, this means we might hit the core dump limits quicker but we
shouldn't be doing anything which makes less debugging information
than necessary available.  Software development is hard enough as
it is right? :)

I also have a strange feeling that the VM_SHARED/i_nlink==0 check
might cause similar problems, but I won't touch that for now.

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 537893a..7fea878 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1167,10 +1167,6 @@ static int maydump(struct vm_area_struct
 	if (vma->vm_flags & VM_SHARED)
 		return vma->vm_file->f_dentry->d_inode->i_nlink == 0;
 
-	/* If it hasn't been written to, don't write it out */
-	if (!vma->anon_vma)
-		return 0;
-
 	return 1;
 }
 

