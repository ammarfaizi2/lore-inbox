Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423473AbWJZNBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423473AbWJZNBw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423477AbWJZNBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:01:52 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:11489 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423473AbWJZNBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:01:51 -0400
Date: Thu, 26 Oct 2006 15:01:46 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 1/5] binfmt: fix uaccess handling
Message-ID: <20061026130146.GB7127@osiris.boeblingen.de.ibm.com>
References: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 fs/binfmt_elf.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

Index: linux-2.6/fs/binfmt_elf.c
===================================================================
--- linux-2.6.orig/fs/binfmt_elf.c	2006-10-26 14:40:58.000000000 +0200
+++ linux-2.6/fs/binfmt_elf.c	2006-10-26 14:41:59.000000000 +0200
@@ -243,8 +243,9 @@
 	if (interp_aout) {
 		argv = sp + 2;
 		envp = argv + argc + 1;
-		__put_user((elf_addr_t)(unsigned long)argv, sp++);
-		__put_user((elf_addr_t)(unsigned long)envp, sp++);
+		if (__put_user((elf_addr_t)(unsigned long)argv, sp++) ||
+		    __put_user((elf_addr_t)(unsigned long)envp, sp++))
+			return -EFAULT;
 	} else {
 		argv = sp;
 		envp = argv + argc + 1;
@@ -254,7 +255,8 @@
 	p = current->mm->arg_end = current->mm->arg_start;
 	while (argc-- > 0) {
 		size_t len;
-		__put_user((elf_addr_t)p, argv++);
+		if (__put_user((elf_addr_t)p, argv++))
+			return -EFAULT;
 		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
 		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
 			return 0;
@@ -265,7 +267,8 @@
 	current->mm->arg_end = current->mm->env_start = p;
 	while (envc-- > 0) {
 		size_t len;
-		__put_user((elf_addr_t)p, envp++);
+		if (__put_user((elf_addr_t)p, envp++))
+			return -EFAULT;
 		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
 		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
 			return 0;
