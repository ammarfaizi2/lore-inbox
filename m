Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264194AbTICTYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbTICTXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:23:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:17070 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264195AbTICTWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:22:08 -0400
Date: Wed, 3 Sep 2003 14:21:50 -0500
From: linas@austin.ibm.com
To: linux-kernel@vger.kernel.org, davem@redhat.com, mingo@redhat.com
Cc: antonb@au1.ibm.com, riel@redhat.com, mranweil@us.ibm.com
Subject: PATCH: kernel-2.4 brlock livelock
Message-ID: <20030903142150.A48064@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi,

I'm soliciting for review of a patch to brlock's in kernel 2.4

PROBLEM:
We've got a system here, a very heavily loaded 8-way SMP powerPC64 
system, that seems to be getting stuck in br_write_lock().  It 
appears that its stuck in a 'livelock' situation.

ANALYSIS:
The current 2.4 brlock implementation has a write-lock that spins 
while waiting for the number of readers to drop to zero. 
(This is true for both the 'atomic' and Dave Miller's 'non-atomic'
implementations.)  The problem is that there are so many readers
and so many CPU's, that new readers come in as fast as the old 
readers finish, that the length of the queue never drops to zero,
and thus the write lock is never obtained.  (At leaset that's
what we think is happening, the evidence is indirect.)

After reviewing the brlock code, it appears that neither of the
implementations (atomic/non-atomic) gaurentee 'forward progress'.
The patch below does gaurentee forward progress (at some cost?)
(I can't tell what the cost is).  Note: ppc64 uses the Dave Miller
non-atomic code.

DESCRIPTION OF PATCH:
The patch changes the non-atomic code. It grabs the write lock, and
then spins, waiting for all of the existing readers to finish. 
New readers are held off.  This seems (to me) to be a reasonable 
thing to do, based on the following logic:

The current brlock design, in either the atomic or non-atomic case, 
assumes that sooner or later, the number of readers will drop to
zero.  Since the write locks spin, the current design also seems to 
assume that each individual read lock is not held for very long.
(i.e. it assumes that its OK for the writer to spin until the readers
complete.)  Based on this observation,  I propose a modified write 
lock that does gaurentee forward progress.  

>From what I can tell, it should work just fine; but its minimally
tested.  (I booted it and compiled a kernel.)

There is some performance impact, but I think its less than the
'atomic' code. The atomic code slowly chokes off new readers 
by locking one cpu at a time.  New readers wait and spin: which
is the same as in the patch below, and so this patch doesn't make 
things worse.

--linas

--- brlock.c.orig       2003-09-02 18:18:06.000000000 -0500
+++ brlock.c    2003-09-03 12:05:28.000000000 -0500
@@ -48,14 +48,11 @@ void __br_write_lock (enum brlock_indice
 {
        int i;
  
-again:
        spin_lock(&__br_write_locks[idx].lock);
+wait_for_readers_to_finish:
        for (i = 0; i < smp_num_cpus; i++)
                if (__brlock_array[cpu_logical_map(i)][idx] != 0) {
-                       spin_unlock(&__br_write_locks[idx].lock);
-                       barrier();
-                       cpu_relax();
-                       goto again;
+                       goto wait_for_readers_to_finish;
                }
 }
  




