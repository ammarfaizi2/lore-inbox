Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312752AbSCVQeC>; Fri, 22 Mar 2002 11:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312753AbSCVQdp>; Fri, 22 Mar 2002 11:33:45 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:7651 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S312752AbSCVQd0>; Fri, 22 Mar 2002 11:33:26 -0500
Date: Fri, 22 Mar 2002 22:06:34 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.7] smp_call_function trivial change
Message-ID: <20020322220634.A26077@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

diff -uN arch/i386/kernel/smp.c /tmp/smp.c
--- arch/i386/kernel/smp.c	Tue Mar 19 02:07:05 2002
+++ /tmp/smp.c	Fri Mar 22 21:48:02 2002
@@ -539,7 +539,7 @@
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
  *
  * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler, you may call it from a bottom half handler.
+ * hardware interrupt handler or from a bottom half handler.
  */
 {
 	struct call_data_struct data;
@@ -555,7 +555,7 @@
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock_bh(&call_lock);
+	spin_lock(&call_lock);
 	call_data = &data;
 	wmb();
 	/* Send a message to all other CPUs and wait for them to respond */
@@ -568,7 +568,7 @@
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
 			barrier();
-	spin_unlock_bh(&call_lock);
+	spin_unlock(&call_lock);
 
 	return 0;
 }

