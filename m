Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVEGIZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVEGIZd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVEGIZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:25:32 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:60767 "EHLO
	mailout2.samsung.com") by vger.kernel.org with ESMTP
	id S262794AbVEGINw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:13:52 -0400
Date: Sat, 07 May 2005 17:12:11 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 1/4] nommu - do_mmap patch for fs/binfmt_flat.c
To: Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400CQT1J0SY@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3HfRvmUc3lmESxOPJ2cYfMfc/Q==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/binfmt_flat.c do_mmap patch against 2.6.12-rc3-mm3 : do_mmap flag should
not to be 0 for correct operation.
 
Signed-off-by : Hyok S. Choi <hyok.choi@samsung.com>

Index: linux-2.6.12-rc3-mm3/fs/binfmt_flat.c
================================================================
--- linux-2.6.12-rc3-mm3/fs/binfmt_flat.c	2005-05-06
09:53:27.000000000 +0900
+++ linux-2.6.12-rc3-mm3-hsc0/fs/binfmt_flat.c	2005-05-06
12:05:11.000000000 +0900
@@ -292,7 +292,7 @@
 	kfree(buf);
 out_free:
 	kfree(strm.workspace);
-out:
+	
 	return retval;
 }
 
@@ -505,7 +505,7 @@
 	/*
 	 * calculate the extra space we need to map in
 	 */
-	extra = max(bss_len + stack_len, relocs * sizeof(unsigned long));
+	extra = max(bss_len + stack_len, (unsigned long)relocs *
sizeof(unsigned long));
 
 	/*
 	 * there are a couple of cases here,  the separate code/data
@@ -520,7 +520,8 @@
 		DBG_FLT("BINFMT_FLAT: ROM mapping of file (we hope)\n");
 
 		down_write(&current->mm->mmap_sem);
-		textpos = do_mmap(bprm->file, 0, text_len,
PROT_READ|PROT_EXEC, 0, 0);
+		textpos = do_mmap(bprm->file, 0, text_len,
PROT_READ|PROT_EXEC,
+			MAP_SHARED | MAP_DENYWRITE | MAP_EXECUTABLE, 0);
 		up_write(&current->mm->mmap_sem);
 		if (!textpos  || textpos >= (unsigned long) -4096) {
 			if (!textpos)
@@ -532,7 +533,8 @@
 		down_write(&current->mm->mmap_sem);
 		realdatastart = do_mmap(0, 0, data_len + extra +
 				MAX_SHARED_LIBS * sizeof(unsigned long),
-				PROT_READ|PROT_WRITE|PROT_EXEC, 0, 0);
+				PROT_READ|PROT_WRITE|PROT_EXEC,
+				MAP_SHARED, 0);
 		up_write(&current->mm->mmap_sem);
 
 		if (realdatastart == 0 || realdatastart >= (unsigned
long)-4096) {
@@ -574,7 +576,8 @@
 		down_write(&current->mm->mmap_sem);
 		textpos = do_mmap(0, 0, text_len + data_len + extra +
 					MAX_SHARED_LIBS * sizeof(unsigned
long),
-				PROT_READ | PROT_EXEC | PROT_WRITE, 0, 0);
+				PROT_READ | PROT_EXEC | PROT_WRITE,
+				MAP_SHARED, 0);
 		up_write(&current->mm->mmap_sem);
 		if (!textpos  || textpos >= (unsigned long) -4096) {
 			if (!textpos)

