Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277949AbRJWQ3f>; Tue, 23 Oct 2001 12:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277957AbRJWQ32>; Tue, 23 Oct 2001 12:29:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22842 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277949AbRJWQ3W>; Tue, 23 Oct 2001 12:29:22 -0400
Date: Tue, 23 Oct 2001 18:29:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Robert Macaulay <robert_macaulay@dell.com>
Subject: x86 smp_call_function recent breakage
Message-ID: <20011023182954.O26029@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't the right fix:

diff -urN 2.4.12ac5/arch/i386/kernel/smp.c 2.4.12ac6/arch/i386/kernel/smp.c
--- 2.4.12ac5/arch/i386/kernel/smp.c	Mon Oct 22 02:05:38 2001
+++ 2.4.12ac6/arch/i386/kernel/smp.c	Tue Oct 23 18:06:34 2001
@@ -549,6 +549,7 @@
 	 * code desn't get confused if it gets an unexpected repeat
 	 * trigger of an old IPI while we're still setting up the new
 	 * one. */
+	wmb();
 	atomic_set(&data->started, 0);
 
 	local_bh_disable();
@@ -563,22 +564,20 @@
 		cpu_relax();
 	}
 
-	/* It is now safe to reuse the "call_data" global, but we need
-	 * to keep local bottom-halves disabled until after waiters have
-	 * been acknowledged to prevent reuse of the per-cpu call data
-	 * entry. */
+	/* We _must_ wait in all cases here, because we cannot drop the
+	 * call lock (and hence allow the call_data pointer to be
+	 * reused) until all CPUs have read the current value. */
+	while (atomic_read(&data->finished) != cpus)
+		barrier();
+
 	spin_unlock(&call_lock);
 
-	if (wait)
-	{
-		while (atomic_read(&data->finished) != cpus)
-		{
-			barrier();
-			cpu_relax();
-		}
-	}
-	local_bh_enable();
+	/* If any of the smp target functions are sufficiently expensive
+	 * that non-waiting IPI is important, we need to add a third
+	 * level to the handshake here to wait for completion of the
+	 * function. */
 
+	local_bh_enable();
 	return 0;
 }
 
@@ -621,9 +620,9 @@
 
 asmlinkage void smp_call_function_interrupt(void)
 {
-	void (*func) (void *info) = call_data->func;
-	void *info = call_data->info;
-	int wait = call_data->wait;
+	void (*func) (void *info);
+	void *info;
+	int wait;
 
 	ack_APIC_irq();
 	/*
@@ -633,11 +632,15 @@
 	 */
 	if (test_and_set_bit(smp_processor_id(), &call_data->started))
 		return;
-	/*
-	 * At this point the info structure may be out of scope unless wait==1
-	 */
+
+	/* We now know that the call_data is valid: */
+	func = call_data->func;
+	info = call_data->info;
+	wait = call_data->wait;
+
 	(*func)(info);
-	if (wait)
-		set_bit(smp_processor_id(), &call_data->finished);
+	/* Once we set this, all of the call_data information may go out
+	 * of scope. */
+	set_bit(smp_processor_id(), &call_data->finished);
 }
 


Right fix is to backout the broken changes that gone in 2.4.10pre12
because it's totally pointless to have a per-cpu array cacheline
aligned, at least if you don't pass also a paramtere to the IPI routine
so that it knows what entry to peek up so that we can scale the
smp_call_function better and allow other to be execute while we wait for
completion, but there's no parameter so it's just wasted memory and such
a scalability optimization would be a very very minor one since if you
want a chance to scale no IPI should run in first place.

So I'm backing out the below one instead of applying the above one:

diff -urN 2.4.10pre11/arch/i386/kernel/smp.c 2.4.10pre12/arch/i386/kernel/smp.c
--- 2.4.10pre11/arch/i386/kernel/smp.c	Tue Sep 18 02:41:56 2001
+++ 2.4.10pre12/arch/i386/kernel/smp.c	Thu Sep 20 01:43:27 2001
@@ -429,9 +429,10 @@
 	atomic_t started;
 	atomic_t finished;
 	int wait;
-};
+} __attribute__ ((__aligned__(SMP_CACHE_BYTES)));
 
 static struct call_data_struct * call_data;
+static struct call_data_struct call_data_array[NR_CPUS];
 
 /*
  * this function sends a 'generic call function' IPI to all other CPUs
@@ -453,33 +454,45 @@
  * hardware interrupt handler, you may call it from a bottom half handler.
  */
 {
-	struct call_data_struct data;
-	int cpus = smp_num_cpus-1;
+	struct call_data_struct *data;
+	int cpus = (cpu_online_map & ~(1 << smp_processor_id()));
 
 	if (!cpus)
 		return 0;
 
-	data.func = func;
-	data.info = info;
-	atomic_set(&data.started, 0);
-	data.wait = wait;
+	data = &call_data_array[smp_processor_id()];
+	
+	data->func = func;
+	data->info = info;
+	data->wait = wait;
 	if (wait)
-		atomic_set(&data.finished, 0);
-
-	spin_lock_bh(&call_lock);
-	call_data = &data;
-	wmb();
+		atomic_set(&data->finished, 0);
+	/* We have do to this one last to make sure that the IPI service
+	 * code desn't get confused if it gets an unexpected repeat
+	 * trigger of an old IPI while we're still setting up the new
+	 * one. */
+	atomic_set(&data->started, 0);
+
+	local_bh_disable();
+	spin_lock(&call_lock);
+	call_data = data;
 	/* Send a message to all other CPUs and wait for them to respond */
 	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
 
 	/* Wait for response */
-	while (atomic_read(&data.started) != cpus)
+	while (atomic_read(&data->started) != cpus)
 		barrier();
 
+	/* It is now safe to reuse the "call_data" global, but we need
+	 * to keep local bottom-halves disabled until after waiters have
+	 * been acknowledged to prevent reuse of the per-cpu call data
+	 * entry. */
+	spin_unlock(&call_lock);
+
 	if (wait)
-		while (atomic_read(&data.finished) != cpus)
+		while (atomic_read(&data->finished) != cpus)
 			barrier();
-	spin_unlock_bh(&call_lock);
+	local_bh_enable();
 
 	return 0;
 }
@@ -529,18 +542,17 @@
 
 	ack_APIC_irq();
 	/*
-	 * Notify initiating CPU that I've grabbed the data and am
-	 * about to execute the function
+	 * Notify initiating CPU that I've grabbed the data and am about
+	 * to execute the function (and avoid servicing any single IPI
+	 * twice)
 	 */
-	mb();
-	atomic_inc(&call_data->started);
+	if (test_and_set_bit(smp_processor_id(), &call_data->started))
+		return;
 	/*
 	 * At this point the info structure may be out of scope unless wait==1
 	 */
 	(*func)(info);
-	if (wait) {
-		mb();
-		atomic_inc(&call_data->finished);
-	}
+	if (wait)
+		set_bit(smp_processor_id(), &call_data->finished);
 }
 


Robert, this explains the missed IPI during drain_cpu_caches, it isn't
ram fault or IPI missed by the hardware, so I suggest to just backout
the second diff above and try again. Will be fixed also in next -aa of
course.

Andrea
