Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262783AbVEGIci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbVEGIci (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVEGI1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:27:01 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:45475 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S262783AbVEGIOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:14:21 -0400
Date: Sat, 07 May 2005 17:12:40 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 4/4] nommu - backward compatibility patch for mm/nommu.c
To: Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400GWS1JUNY@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3Iluo0XA8LedTsu+8SHB28Htww==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu patch against 2.6.12-rc3-mm3, for mm/nommu.c : 
- need to fix the vmalloc definition.
- most malloc functions in nommu does not provide the 'len'. should consider
"zero" len value.
 If it does return with error when the 'len' is zero, the whole exist
applications are unable to run, because of the std-c libraries for uClinux.

Signed-off-by : Hyok S. Choi <hyok.choi@samsung.com>

Index: linux-2.6.12-rc3-mm3/mm/nommu.c
================================================================
--- linux-2.6.12-rc3-mm3/mm/nommu.c	2005-05-06 09:58:44.000000000 +0900
+++ linux-2.6.12-rc3-mm3-hsc0/mm/nommu.c	2005-05-06
13:53:54.000000000 +0900
@@ -6,6 +6,7 @@
  *
  *  See Documentation/nommu-mmap.txt
  *
+ *  Copyright (c) 2005      Hyok S. Choi <hyok.choi@samsung.com>
  *  Copyright (c) 2004-2005 David Howells <dhowells@redhat.com>
  *  Copyright (c) 2000-2003 David McCullough <davidm@snapgear.com>
  *  Copyright (c) 2000-2001 D Jeff Dionne <jeff@uClinux.org>
@@ -146,7 +147,7 @@
 	kfree(addr);
 }
 
-void *__vmalloc(unsigned long size, int gfp_mask, pgprot_t prot)
+void *__vmalloc(unsigned long size, unsigned int gfp_mask, pgprot_t prot)
 {
 	/*
 	 * kmalloc doesn't like __GFP_HIGHMEM for some reason
@@ -901,10 +902,12 @@
 #ifdef DEBUG
 	printk("do_munmap:\n");
 #endif
-
+	/* if the len is zero(as some simple-malloc libs does),
+	 * treat it with the start addr only.
+	 */
 	for (parent = &mm->context.vmlist; *parent; parent =
&(*parent)->next)
 		if ((*parent)->vma->vm_start == addr &&
-		    (*parent)->vma->vm_end == end)
+		    (!len || (*parent)->vma->vm_end == end))
 			goto found;
 
 	printk("munmap of non-mmaped memory by process %d (%s): %p\n",
@@ -914,6 +917,9 @@
  found:
 	vml = *parent;
 
+	if(!len)
+		len = vml->vma->vm_end - addr;
+	
 	put_vma(vml->vma);
 
 	*parent = vml->next;

