Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbVCQO7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbVCQO7C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 09:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbVCQO7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 09:59:01 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:56022 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S263085AbVCQO4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 09:56:47 -0500
Date: Thu, 17 Mar 2005 15:56:59 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 5/8] s390: s390dbf permissions.
Message-ID: <20050317145659.GE4807@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/8] s390: s390dbf permissions.

From: Michael Holzheu <holzheu@de.ibm.com>

Use more specific permissions for the procfiles if s390dbf. Read only
views should have read permission, write only views should have write
permission.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/debug.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/debug.c linux-2.6-patched/arch/s390/kernel/debug.c
--- linux-2.6/arch/s390/kernel/debug.c	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/debug.c	2005-03-17 15:36:00.000000000 +0100
@@ -931,11 +931,15 @@
 	int rc = 0;
 	int i;
 	unsigned long flags;
-	mode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
+	mode_t mode = S_IFREG;
 	struct proc_dir_entry *pde;
 
 	if (!id)
 		goto out;
+	if (view->prolog_proc || view->format_proc || view->header_proc)
+		mode |= S_IRUSR;
+	if (view->input_proc)
+		mode |= S_IWUSR;
 	pde = create_proc_entry(view->name, mode, id->proc_root_entry);
 	if (!pde){
 		printk(KERN_WARNING "debug: create_proc_entry() failed! Cannot register view %s/%s\n", id->name,view->name);
@@ -958,10 +962,6 @@
 	}
 	else {
 		id->views[i] = view;
-		if (view->prolog_proc || view->format_proc || view->header_proc)
-			mode |= S_IRUSR;
-		if (view->input_proc)
-			mode |= S_IWUSR;
 		pde->proc_fops = &debug_file_ops;
 		id->proc_entries[i] = pde;
 	}
