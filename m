Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264896AbUFAFzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbUFAFzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 01:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264895AbUFAFzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 01:55:16 -0400
Received: from holomorphy.com ([207.189.100.168]:12430 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264896AbUFAFzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 01:55:01 -0400
Date: Mon, 31 May 2004 22:54:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, suparna@in.ibm.com, linux-aio@kvack.org
Subject: [2/2] correct use_mm()/unuse_mm() to use task_lock() to protect ->mm
Message-ID: <20040601055459.GG2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, suparna@in.ibm.com,
	linux-aio@kvack.org
References: <20040601055118.GF2093@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601055118.GF2093@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Split off from suparna's patches:

Correct use_mm()/unuse_mm() to use task_lock() to protect task->mm.

Index: suparna-2.6.7-rc2/fs/aio.c
===================================================================
--- suparna-2.6.7-rc2.orig/fs/aio.c	2004-05-31 22:06:35.788770000 -0700
+++ suparna-2.6.7-rc2/fs/aio.c	2004-05-31 22:08:41.057727000 -0700
@@ -538,19 +538,25 @@
 
 static void use_mm(struct mm_struct *mm)
 {
-	struct mm_struct *active_mm = current->active_mm;
+	struct mm_struct *active_mm;
+
 	atomic_inc(&mm->mm_count);
+	task_lock(current);
+	active_mm = current->active_mm;
 	current->mm = mm;
 	if (mm != active_mm) {
 		current->active_mm = mm;
 		activate_mm(active_mm, mm);
 	}
+	task_unlock(current);
 	mmdrop(active_mm);
 }
 
 static void unuse_mm(struct mm_struct *mm)
 {
+	task_lock(current);
 	current->mm = NULL;
+	task_unlock(current);
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, current);
 }
