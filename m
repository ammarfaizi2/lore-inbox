Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267395AbTA3GvI>; Thu, 30 Jan 2003 01:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTA3GvI>; Thu, 30 Jan 2003 01:51:08 -0500
Received: from mail.lmcg.wisc.edu ([144.92.101.145]:41639 "EHLO
	mail.lmcg.wisc.edu") by vger.kernel.org with ESMTP
	id <S267395AbTA3GvH>; Thu, 30 Jan 2003 01:51:07 -0500
Date: Thu, 30 Jan 2003 01:00:27 -0600
From: Daniel Forrest <forrest@lmcg.wisc.edu>
Message-Id: <200301300700.h0U70RM05470@leinie.lmcg.wisc.edu>
To: Jan Kasprzak <kas@informatics.muni.cz>
CC: linux-kernel@vger.kernel.org
In-reply-to: <20030129133434.A1584@fi.muni.cz> (message from Jan Kasprzak on
	Wed, 29 Jan 2003 13:34:34 +0100)
Subject: Re: 2.4.20 NFS server lock-up (SMP)
Reply-to: Daniel Forrest <forrest@lmcg.wisc.edu>
References: <20030129133434.A1584@fi.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yenya,

>> I have a problem on Linux 2.4.20 with NFS server - my NFS server
>> from time to time (currently about once a day) stops responding to
>> NFS requests.  Apart from that the system is OK, I can log in via
>> SSH, and I can run "/sbin/reboot -n -f" to reboot it.  Also
>> filesystem operations seem to be OK, even Samba server is
>> responding.  When this happens, I see all nfsd processes and lockd
>> process to be stuck in the "D" state.

My guess is that this is related to a bug in garbage collection in
lockd.  The breakpoint is when you pass 32 unique clients.  If you are
able to recompile the kernel, try this patch:

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

This is a patch against 2.5.53, but it should also apply to any 2.4 or
2.5 tree since the code is virtually identical.

--- fs/lockd/svclock.c.ORIG	Mon Dec 23 23:19:52 2002
+++ fs/lockd/svclock.c	Mon Dec 30 13:42:10 2002
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
 
I have tried repeatedly to get this patch into the kernel, but it
hasn't made it yet.  If this does solve your problem, let me know and
I will try one more time to get it accepted.

-- 
Dan
