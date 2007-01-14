Return-Path: <linux-kernel-owner+w=401wt.eu-S1751119AbXANFdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbXANFdz (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 00:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbXANFdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 00:33:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58572 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbXANFdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 00:33:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
In-Reply-To: Roland McGrath's message of  Saturday, 13 January 2007 21:31:39 -0800 <20070114053140.351701800E5@magilla.sf.frob.com>
Subject: [PATCH 3/11] Add VM_ALWAYSDUMP
Emacs: (setq software-quality (/ 1 number-of-authors))
Message-Id: <20070114053350.5AA811800E5@magilla.sf.frob.com>
Date: Sat, 13 Jan 2007 21:33:50 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the VM_ALWAYSDUMP flag for vm_flags in vm_area_struct.
This provides a clean explicit way to have a vma always included in core
dumps, as is needed for vDSO's.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 fs/binfmt_elf.c    |    4 ++++
 include/linux/mm.h |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 7cb2872..6fec8bf 100644  
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1178,6 +1178,10 @@ static int dump_seek(struct file *file, 
  */
 static int maydump(struct vm_area_struct *vma)
 {
+	/* The vma can be set up to tell us the answer directly.  */
+	if (vma->vm_flags & VM_ALWAYSDUMP)
+		return 1;
+
 	/* Do not dump I/O mapped devices or special mappings */
 	if (vma->vm_flags & (VM_IO | VM_RESERVED))
 		return 0;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7691223..2d2c08d 100644  
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -168,6 +168,7 @@ extern unsigned int kobjsize(const void 
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
 #define VM_INSERTPAGE	0x02000000	/* The vma has had "vm_insert_page()" done on it */
+#define VM_ALWAYSDUMP	0x04000000	/* Always include in core dumps */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
