Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312219AbSDCRNS>; Wed, 3 Apr 2002 12:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312255AbSDCRNJ>; Wed, 3 Apr 2002 12:13:09 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:62415 "EHLO e1.esmtp.ibm.com")
	by vger.kernel.org with ESMTP id <S312219AbSDCRMu>;
	Wed, 3 Apr 2002 12:12:50 -0500
Message-ID: <3CAB3807.5040508@us.ibm.com>
Date: Wed, 03 Apr 2002 09:12:39 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC][PATCH] BKL reduction in do_exit
Content-Type: multipart/mixed;
 boundary="------------000409080802090008080508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000409080802090008080508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A week ago, I posted this:
http://groups.google.com/groups?selm=linux.kernel.3CA20C9B.20309%40us.ibm.com

Nobody had anything to sayabout it, so here's a patch.  It moves the 
disassociate_ctty(1) up, and releases the BKl after it gets done.  Is 
this a sane thing to do, or do some of those exit_*() functions still 
need the tty?

The patch reduces hold times of the BKL in do_exit() by a factor of 100. 
   They were on the order of 200us, now they're about 1.5us.  However, 
those numbers were on Martin Bligh's NUMA-Q box, so they represent a 
serious worst-case scenario.

The patch is stable, but I don't properly understand the consequences of 
moving the disassociate_ctty(1) up.  I guess we could do this instead:

  	lock_kernel();
  	sem_exit();
	unlock_kernel();
	
  	__exit_files(tsk);
  	__exit_fs(tsk);
  	exit_namespace(tsk);
  	exit_sighand(tsk);
  	exit_thread();
	
	lock_kernel();
	if (current->leader)
		disassociate_ctty(1);
	unlock_kernel();

But, I hesitated to do that because of the lock bouncing consequences on 
the NUMA-Q.

-- 
Dave Hansen
haveblue@us.ibm.com



--------------000409080802090008080508
Content-Type: text/plain;
 name="do_exit-bkl_reduction-2.5.7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="do_exit-bkl_reduction-2.5.7.patch"

--- linux-2.5.7-clean/kernel/exit.c	Tue Apr  2 10:43:28 2002
+++ linux//kernel/exit.c	Wed Apr  3 08:56:00 2002
@@ -500,15 +500,16 @@
 
 	lock_kernel();
 	sem_exit();
+	if (current->leader)
+		disassociate_ctty(1);
+	unlock_kernel();
+	
 	__exit_files(tsk);
 	__exit_fs(tsk);
 	exit_namespace(tsk);
 	exit_sighand(tsk);
 	exit_thread();
 
-	if (current->leader)
-		disassociate_ctty(1);
-
 	put_exec_domain(tsk->thread_info->exec_domain);
 	if (tsk->binfmt && tsk->binfmt->module)
 		__MOD_DEC_USE_COUNT(tsk->binfmt->module);

--------------000409080802090008080508--

