Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317738AbSFLQ1n>; Wed, 12 Jun 2002 12:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317739AbSFLQ1m>; Wed, 12 Jun 2002 12:27:42 -0400
Received: from mail.lmcg.wisc.edu ([144.92.101.145]:7304 "EHLO
	mail.lmcg.wisc.edu") by vger.kernel.org with ESMTP
	id <S317738AbSFLQ1l>; Wed, 12 Jun 2002 12:27:41 -0400
Date: Wed, 12 Jun 2002 11:27:41 -0500 (CDT)
Message-Id: <200206121627.LAA24760@radium.lmcg.wisc.edu>
From: Daniel Forrest <forrest@lmcg.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] lockd hangs during host lookup garbage collection
Reply-to: Daniel Forrest <forrest@lmcg.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A deadlock occurs under the following sequence:

->nlmsvc_lock				calls down(&file->f_sema)
 ->nlmsvc_create_block
  ->nlmclnt_lookup_host
   ->nlm_lookup_host			may do garbage collection
    ->nlm_gc_hosts
     ->nlmsvc_mark_resources
      ->nlm_traverse_files		action = NLM_ACT_MARK
       ->nlm_inspect_file		loops over all files
        ->nlmsvc_traverse_blocks	calls down(&file->f_sema)

Under heavy load (i.e. >32 client machines locking/unlocking the same
NFS mounted file repeatedly) this happens within seconds.

I discussed this with Trond Myklebust a couple of months ago, but the
question became one of why f_sema was being used at all.  I don't know
the answer to that question.  Until someone else removes f_sema, the
following patch will avoid the problem.

Please apply.

Dan

--- fs/lockd/svclock.c.ORIG     Thu Oct 11 09:52:18 2001
+++ fs/lockd/svclock.c  Tue Jun 11 17:06:01 2002
@@ -176,8 +176,14 @@
        struct nlm_rqst         *call;
 
        /* Create host handle for callback */
+       /* We must up the semaphore in case the host lookup does
+        * garbage collection (which calls nlmsvc_traverse_blocks),
+        * but this shouldn't be a problem because nlmsvc_lock has
+        * to retry the lock after this anyway */
+       up(&file->f_sema);
        host = nlmclnt_lookup_host(&rqstp->rq_addr,
                                rqstp->rq_prot, rqstp->rq_vers);
+       down(&file->f_sema);
        if (host == NULL)
                return NULL;

