Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312255AbSDXVOA>; Wed, 24 Apr 2002 17:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312261AbSDXVN7>; Wed, 24 Apr 2002 17:13:59 -0400
Received: from mail.lmcg.wisc.edu ([144.92.101.145]:42406 "EHLO
	mail.lmcg.wisc.edu") by vger.kernel.org with ESMTP
	id <S312255AbSDXVN5>; Wed, 24 Apr 2002 17:13:57 -0400
Date: Wed, 24 Apr 2002 16:13:54 -0500 (CDT)
Message-Id: <200204242113.QAA29375@radium.lmcg.wisc.edu>
From: Daniel Forrest <forrest@lmcg.wisc.edu>
To: linux-kernel@vger.kernel.org
CC: Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <shsk7rd8k9r.fsf@charged.uio.no> (message from Trond Myklebust on
	12 Apr 2002 09:10:24 +0200)
Subject: Re: lockd hanging
Reply-to: Daniel Forrest <forrest@lmcg.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

>> There is no single maintainer of the lockd code. Neil Brown and I tend
>> to share responsibility for pushing these patches to Linus & Marcelo.
>> 
>> FYI: You will find a number of people who would be interested in
>> discussing this on the NFS mail list NFS@lists.sourceforge.net
>> (although a lot of us are subscribed to linux kernel too). Please just
>> trot out your patches on either of these lists, and show us what
>> you've found 8-)

The bug I have found is in fs/lockd/svclock.c and is caused by downing
an already downed semaphore:

->nlmsvc_lock				calls down(&file->f_sema)
 ->nlmsvc_create_block
  ->nlmclnt_lookup_host
   ->nlm_lookup_host			may do garbage collection
    ->nlm_gc_hosts
     ->nlmsvc_mark_resources
      ->nlm_traverse_files		action = NLM_ACT_MARK
       ->nlm_inspect_file		loops over all files
        ->nlmsvc_traverse_blocks	calls down(&file->f_sema)

The solution I have used is to up the file semaphore before calling
nlmclnt_lookup_host.  This seems an okay thing to do because the
caller (nlmsvc_lock) is going to retry everything they have done
since downing the file semaphore in the first place.

Going over each chunk of the following patch:

1.) Is this exact change around the call to nlmclnt_lookup_host.

2.) In the case that nlmsvc_create_block failed, the file semaphore
    wasn't being up'ed.  I have never seen nlmsvc_create_block fail,
    but all of the other return paths do up the file semaphore before
    returning.

3-6.) It seems that nlmsvc_delete_block should only be called with
      the file semaphore down'ed.  nlmsvc_retry_blocked calls both
      nlmsvc_grant_blocked and nlmsvc_delete_block, but doesn't down
      the file semaphore.  So move the file semaphore stuff from
      nlmsvc_grant_blocked to nlmsvc_retry_blocked where it applies
      to both calls.

7.) Call nlm_release_host because the other return path does.
    Again, this is another routine (nlmsvc_find_block) that I have
    never seen fail, but it seems the right thing to do.

8.) I think the file semaphore should not be up'ed until after
    nlmsvc_delete_block is called.  This simplifies the code a good
    deal.  It is a moot point, however, because nlmsvc_grant_reply
    is never called from anywhere.  I can see how it would fit into
    svcproc.c, but none of the NLM_*_RES procedures are implemented.

9.) This is the move of the file semaphore stuff from (3-6) above.

Without these changes, I can freeze lockd within a minute of heavy
(~40 machines locking/unlocking the same file continuously) activity.
With these changes I can still on very rare[*] occasions freeze up the
entire system, but as far as I can tell it has nothing to do with the
lockd code.

[*] By rare, I mean that if nothing else is actively using the network
for data transfer and I have all 40 machines locking/unlocking the
same file for a couple hundred iterations, I can sometimes get the
machine to freeze.  More details if anyone is interested.

So here is the patch, generated against 2.4.18, but it will apply
against 2.5.10 since the code is identical.

--- fs/lockd/svclock.c.ORIG	Thu Oct 11 09:52:18 2001
+++ fs/lockd/svclock.c	Wed Apr 24 13:11:47 2002
@@ -176,8 +176,14 @@
 	struct nlm_rqst		*call;
 
 	/* Create host handle for callback */
+	/* We must up the semaphore in case the host lookup does
+	 * garbage collection (which calls nlmsvc_traverse_blocks),
+	 * but this shouldn't be a problem because nlmsvc_lock has
+	 * to retry the lock after this anyway */
+	up(&file->f_sema);
 	host = nlmclnt_lookup_host(&rqstp->rq_addr,
 				rqstp->rq_prot, rqstp->rq_vers);
+	down(&file->f_sema);
 	if (host == NULL)
 		return NULL;
 
@@ -357,8 +363,10 @@
 	 * retry because we may have slept in kmalloc. */
 	if (block == NULL) {
 		dprintk("lockd: blocking on this lock (allocating).\n");
-		if (!(block = nlmsvc_create_block(rqstp, file, lock, cookie)))
+		if (!(block = nlmsvc_create_block(rqstp, file, lock, cookie))) {
+			up(&file->f_sema);
 			return nlm_lck_denied_nolocks;
+		}
 		goto again;
 	}
 
@@ -505,9 +513,6 @@
 
 	dprintk("lockd: grant blocked lock %p\n", block);
 
-	/* First thing is lock the file */
-	down(&file->f_sema);
-
 	/* Unlink block request from list */
 	nlmsvc_remove_block(block);
 
@@ -525,7 +530,6 @@
 		dprintk("lockd: lock still blocked\n");
 		nlmsvc_insert_block(block, NLM_NEVER);
 		posix_block_lock(conflock, &lock->fl);
-		up(&file->f_sema);
 		return;
 	}
 
@@ -537,7 +541,6 @@
 		printk(KERN_WARNING "lockd: unexpected error %d in %s!\n",
 				-error, __FUNCTION__);
 		nlmsvc_insert_block(block, 10 * HZ);
-		up(&file->f_sema);
 		return;
 	}
 
@@ -555,7 +558,6 @@
 	if (nlmsvc_async_call(&block->b_call, NLMPROC_GRANTED_MSG,
 						nlmsvc_grant_callback) < 0)
 		nlm_release_host(block->b_call.a_host);
-	up(&file->f_sema);
 }
 
 /*
@@ -578,6 +580,7 @@
 		*(unsigned int *)(call->a_args.cookie.data));
 	if (!(block = nlmsvc_find_block(&call->a_args.cookie))) {
 		dprintk("lockd: no block for cookie %x\n", *(u32 *)(call->a_args.cookie.data));
+		nlm_release_host(call->a_host);
 		return;
 	}
 
@@ -621,20 +624,17 @@
 		if (status == NLM_LCK_DENIED_GRACE_PERIOD) {
 			/* Try again in a couple of seconds */
 			nlmsvc_insert_block(block, 10 * HZ);
-			block = NULL;
 		} else {
 			/* Lock is now held by client, or has been rejected.
 			 * In both cases, the block should be removed. */
 			file->f_count++;
-			up(&file->f_sema);
 			if (status == NLM_LCK_GRANTED)
 				nlmsvc_delete_block(block, 0);
 			else
 				nlmsvc_delete_block(block, 1);
 		}
 	}
-	if (!block)
-		up(&file->f_sema);
+	up(&file->f_sema);
 	nlm_release_file(file);
 }
 
@@ -652,16 +652,22 @@
 			nlm_blocked,
 			nlm_blocked? nlm_blocked->b_when : 0);
 	while ((block = nlm_blocked)) {
+		struct nlm_file		*file = block->b_file;
+
 		if (block->b_when == NLM_NEVER)
 			break;
 	        if (time_after(block->b_when,jiffies))
 			break;
 		dprintk("nlmsvc_retry_blocked(%p, when=%ld, done=%d)\n",
 			block, block->b_when, block->b_done);
+
+		/* First thing is lock the file */
+		down(&file->f_sema);
 		if (block->b_done)
 			nlmsvc_delete_block(block, 0);
 		else
 			nlmsvc_grant_blocked(block);
+		up(&file->f_sema);
 	}
 
 	if ((block = nlm_blocked) && block->b_when != NLM_NEVER)

-- 
+----------------------------------+----------------------------------+
| Daniel K. Forrest                | Laboratory for Molecular and     |
| forrest@lmcg.wisc.edu            | Computational Genomics           |
| (608)262-9479                    | University of Wisconsin, Madison |
+----------------------------------+----------------------------------+
