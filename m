Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314049AbSDVDcS>; Sun, 21 Apr 2002 23:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314051AbSDVDcR>; Sun, 21 Apr 2002 23:32:17 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:34827 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314049AbSDVDcP>; Sun, 21 Apr 2002 23:32:15 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: marcelo@conectiva.br
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] TRIVIAL 2.4.19-pre7: smp_call_function not allowed from bh
Date: Mon, 22 Apr 2002 13:35:34 +1000
Message-Id: <E16zUc3-0000Rk-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dipankar@in.ibm.com: Fw: [PATCH 2.5.7] smp_call_function trivial change:
  Hi Rusty,
  
  I discussed this with Andrea long ago, but never got around
  to send the patch. Better late than never.
  
  Going by the documentation and use of _bh version of spin_lock(),
  smp_call_function() is allowed to be called from BH context,
  We can run into a deadlock with some locks if we do so. 
  This because reader-writer locks can sometimes be used optimally
  by not disabling irqs while taking the reader side if only the 
  reader side of the lock is taken from irq context.
  
      CPU #0                                CPU #1

      read_lock(&tasklist_lock)
                                       write_lock_irq(&tasklist_lock)
                                       [spins with interrupt disabled]
      [Interrupted by BH]
      smp_call_function() for BH
           handler
                                       [ doesn't take the IPI]
    
  So, cpu #1 doesn't take the IPI and cpu #0 spinwaits
  for the IPI handler to start, resulting in a deadlock.
  
  The last time I looked, I couldn't see smp_call_function() being
  called from BH context anywhere. So, there is no immediate problem.
  However it seems right to correct the documentation and also not 
  disable BH while taking the call lock since it isn't necessary.
  
  Patch for 2.5.7 included.

--- trivial-2.4.19-pre7/arch/i386/kernel/smp.c.orig	Mon Apr 22 13:21:41 2002
+++ trivial-2.4.19-pre7/arch/i386/kernel/smp.c	Mon Apr 22 13:21:41 2002
@@ -528,7 +528,7 @@
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
  *
  * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler, you may call it from a bottom half handler.
+ * hardware interrupt handler or from a bottom half handler.
  */
 {
 	struct call_data_struct data;
@@ -544,7 +544,7 @@
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock_bh(&call_lock);
+	spin_lock(&call_lock);
 	call_data = &data;
 	wmb();
 	/* Send a message to all other CPUs and wait for them to respond */
@@ -557,7 +557,7 @@
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
 			barrier();
-	spin_unlock_bh(&call_lock);
+	spin_unlock(&call_lock);
 
 	return 0;
 }

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
