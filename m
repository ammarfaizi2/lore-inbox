Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314047AbSDSBK1>; Thu, 18 Apr 2002 21:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314045AbSDSBK0>; Thu, 18 Apr 2002 21:10:26 -0400
Received: from pcp607045pcs.galitn01.tn.comcast.net ([68.53.58.57]:39952 "HELO
	gibbs.dhs.org") by vger.kernel.org with SMTP id <S313927AbSDSBKY>;
	Thu, 18 Apr 2002 21:10:24 -0400
Subject: bug in fork failure path?
From: Colin Gibbs <colin@gibbs.dhs.org>
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 18 Apr 2002 20:10:22 -0500
Message-Id: <1019178622.25887.630.camel@monolith>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I came across this bug hacking on sparc32. If fork fails in copy_mm ->
dup_mmap, destroy_context is called on the new mm before
init_new_context. 

fork.c:330 
	retval = -ENOMEM; 
	mm = allocate_mm(); 
	if (!mm) 
		goto fail_nomem; 

	/* Copy the current MM stuff.. */ 
	memcpy(mm, oldmm, sizeof(*mm)); 
	if (!mm_init(mm)) 
		goto fail_nomem; 

Failure is ok here. We don't try to do an mmput, but we have memcpy'd
the mm struct context and all. 

	down_write(&oldmm->mmap_sem); 
	retval = dup_mmap(mm); 
	up_write(&oldmm->mmap_sem); 

	if (retval) 
		goto free_pt; 

If we fail and call mmput, destroy_context gets called before
init_new_context below. This removes the parent process's context since
it was just memcpy'd from the parent's mm struct. 

	/* 
	 * child gets a private LDT (if there was an LDT in the parent) 
	 */ 
	copy_segments(tsk, mm); 

	if (init_new_context(tsk,mm)) 
		goto free_pt; 

Can we move the init_new_context to just after the mm_init call? Works
nicely on sparc. Most archs have a fairly trivial init_new_context
anyway. 

Colin 

--- 2.4.19-pre4/kernel/fork.c	Thu Mar 28 19:49:36 2002
+++ tortoise-19-pre4/kernel/fork.c	Wed Apr 17 23:26:20 2002
@@ -336,6 +336,9 @@
 	if (!mm_init(mm))
 		goto fail_nomem;
 
+	if (init_new_context(tsk,mm))
+		goto free_pt;
+
 	down_write(&oldmm->mmap_sem);
 	retval = dup_mmap(mm);
 	up_write(&oldmm->mmap_sem);
@@ -347,9 +350,6 @@
 	 * child gets a private LDT (if there was an LDT in the parent)
 	 */
 	copy_segments(tsk, mm);
-
-	if (init_new_context(tsk,mm))
-		goto free_pt;
 
 good_mm:
 	tsk->mm = mm;

