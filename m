Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTJMGrr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 02:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbTJMGrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 02:47:47 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:2849 "EHLO
	pasta.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261311AbTJMGrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 02:47:45 -0400
Message-Id: <200310130652.h9D6qiib005952@pasta.boston.redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Dave Kleikamp <shaggy@austin.ibm.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x performance tests Re: [PATCH] BUG() in exec_mmap()
In-Reply-To: Your message of "Thu, 09 Oct 2003 17:25:52 -0300."
Date: Mon, 13 Oct 2003 02:52:44 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 9-Oct-2003 at 17:25 -0300, Marcelo Tosatti wrote:

> BTW, further performance testing of the removal of this optimization is
> VERY welcome.
>
> I've done some tests and no big performance harm has showed up, but thats
> just me.


In a variation of a (loosely) 2.4.21-based kernel, I get a 0% degradation
in the speed of a program exec'ing itself 1,000,000 times with the addition
of the missing locking in exec_mmap():

--- linux-2.4.21/fs/exec.c.orig
+++ linux-2.4.21/fs/exec.c
@@ -452,9 +452,11 @@ static int exec_mmap(void)
 
 	old_mm = current->mm;
 	if (old_mm && atomic_read(&old_mm->mm_users) == 1) {
+		down_write(&old_mm->mmap_sem);
 		mm_release();
 		exit_aio(old_mm);
 		exit_mmap(old_mm);
+		up_write(&old_mm->mmap_sem);
 		return 0;
 	}
 

Applying your change to the same kernel, I get a 2.5% degradation in the
same test case:

--- linux-2.4.21/fs/exec.c.orig
+++ linux-2.4.21/fs/exec.c
@@ -451,12 +451,6 @@ static int exec_mmap(void)
 	struct mm_struct * mm, * old_mm;
 
 	old_mm = current->mm;
-	if (old_mm && atomic_read(&old_mm->mm_users) == 1) {
-		mm_release();
-		exit_aio(old_mm);
-		exit_mmap(old_mm);
-		return 0;
-	}
 
 	mm = mm_alloc();
 	if (mm) {


Average times over 3 runs (of 1,000,000 execs each) were:

	base kernel:	529 elapsed seconds
	w/1st change:	529 elapsed seconds
	w/2nd change:	542 elapsed seconds

I wouldn't bother optimizing for an exec() syscall, but the 1st change
also eliminates the possibility of two ENOMEM error paths in the typical
case of not sharing an mm_struct.


Also, a reproducer that could expose the race condition (in typically 5-20
seconds) on a dual-Xeon Dell box ran for 10's of minutes without problems
with either fix.

Cheers.  -ernie
