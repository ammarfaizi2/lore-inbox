Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVHOFnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVHOFnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 01:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVHOFnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 01:43:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8654 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751079AbVHOFnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 01:43:09 -0400
Date: Sun, 14 Aug 2005 22:43:00 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.12.5
Message-ID: <20050815054300.GL7762@shell0.pdx.osdl.net>
References: <20050815054022.GK7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815054022.GK7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 12
-EXTRAVERSION = .4
+EXTRAVERSION = .5
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff --git a/arch/ppc64/boot/zlib.c b/arch/ppc64/boot/zlib.c
--- a/arch/ppc64/boot/zlib.c
+++ b/arch/ppc64/boot/zlib.c
@@ -1307,7 +1307,7 @@ local int huft_build(
   {
     *t = (inflate_huft *)Z_NULL;
     *m = 0;
-    return Z_OK;
+    return Z_DATA_ERROR;
   }
 
 
@@ -1351,6 +1351,7 @@ local int huft_build(
     if ((j = *p++) != 0)
       v[x[j]++] = i;
   } while (++i < n);
+  n = x[g];			/* set n to length of v */
 
 
   /* Generate the Huffman codes and for each, make the table entries */
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -729,8 +729,6 @@ static void __init amd_detect_cmp(struct
 	int cpu = smp_processor_id();
 	int node = 0;
 	unsigned bits;
-	if (c->x86_num_cores == 1)
-		return;
 
 	bits = 0;
 	while ((1 << bits) < c->x86_num_cores)
diff --git a/arch/x86_64/kernel/smp.c b/arch/x86_64/kernel/smp.c
--- a/arch/x86_64/kernel/smp.c
+++ b/arch/x86_64/kernel/smp.c
@@ -284,6 +284,71 @@ struct call_data_struct {
 static struct call_data_struct * call_data;
 
 /*
+ * this function sends a 'generic call function' IPI to one other CPU
+ * in the system.
+ */
+static void __smp_call_function_single (int cpu, void (*func) (void *info), void *info,
+				int nonatomic, int wait)
+{
+	struct call_data_struct data;
+	int cpus = 1;
+
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	call_data = &data;
+	wmb();
+	/* Send a message to all other CPUs and wait for them to respond */
+	send_IPI_mask(cpumask_of_cpu(cpu), CALL_FUNCTION_VECTOR);
+
+	/* Wait for response */
+	while (atomic_read(&data.started) != cpus)
+		cpu_relax();
+
+	if (!wait)
+		return;
+
+	while (atomic_read(&data.finished) != cpus)
+		cpu_relax();
+}
+
+/*
+ * Run a function on another CPU
+ *  <func>	The function to run. This must be fast and non-blocking.
+ *  <info>	An arbitrary pointer to pass to the function.
+ *  <nonatomic>	Currently unused.
+ *  <wait>	If true, wait until function has completed on other CPUs.
+ *  [RETURNS]   0 on success, else a negative status code.
+ *
+ * Does not return until the remote CPU is nearly ready to execute <func>
+ * or is or has executed.
+ */
+
+int smp_call_function_single (int cpu, void (*func) (void *info), void *info, 
+	int nonatomic, int wait)
+{
+	
+	int me = get_cpu(); /* prevent preemption and reschedule on another processor */
+
+	if (cpu == me) {
+		printk("%s: trying to call self\n", __func__);
+		put_cpu();
+		return -EBUSY;
+	}
+	spin_lock_bh(&call_lock);
+
+	__smp_call_function_single(cpu, func,info,nonatomic,wait);	
+
+	spin_unlock_bh(&call_lock);
+	put_cpu();
+	return 0;
+}
+
+/*
  * this function sends a 'generic call function' IPI to all other CPUs
  * in the system.
  */
diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -202,9 +202,6 @@ static __cpuinit void sync_master(void *
 {
 	unsigned long flags, i;
 
-	if (smp_processor_id() != boot_cpu_id)
-		return;
-
 	go[MASTER] = 0;
 
 	local_irq_save(flags);
@@ -253,7 +250,7 @@ get_delta(long *rt, long *master)
 	return tcenter - best_tm;
 }
 
-static __cpuinit void sync_tsc(void)
+static __cpuinit void sync_tsc(unsigned int master)
 {
 	int i, done = 0;
 	long delta, adj, adjust_latency = 0;
@@ -267,9 +264,17 @@ static __cpuinit void sync_tsc(void)
 	} t[NUM_ROUNDS] __cpuinitdata;
 #endif
 
+	printk(KERN_INFO "CPU %d: Syncing TSC to CPU %u.\n",
+		smp_processor_id(), master);
+
 	go[MASTER] = 1;
 
-	smp_call_function(sync_master, NULL, 1, 0);
+	/* It is dangerous to broadcast IPI as cpus are coming up,
+	 * as they may not be ready to accept them.  So since
+	 * we only need to send the ipi to the boot cpu direct
+	 * the message, and avoid the race.
+	 */
+	smp_call_function_single(master, sync_master, NULL, 1, 0);
 
 	while (go[MASTER])	/* wait for master to be ready */
 		no_cpu_relax();
@@ -313,16 +318,14 @@ static __cpuinit void sync_tsc(void)
 	printk(KERN_INFO
 	       "CPU %d: synchronized TSC with CPU %u (last diff %ld cycles, "
 	       "maxerr %lu cycles)\n",
-	       smp_processor_id(), boot_cpu_id, delta, rt);
+	       smp_processor_id(), master, delta, rt);
 }
 
 static void __cpuinit tsc_sync_wait(void)
 {
 	if (notscsync || !cpu_has_tsc)
 		return;
-	printk(KERN_INFO "CPU %d: Syncing TSC to CPU %u.\n", smp_processor_id(),
-			boot_cpu_id);
-	sync_tsc();
+	sync_tsc(0);
 }
 
 static __init int notscsync_setup(char *s)
diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -129,8 +129,14 @@ static int zisofs_readpage(struct file *
 	cend = le32_to_cpu(*(__le32 *)(bh->b_data + (blockendptr & bufmask)));
 	brelse(bh);
 
+	if (cstart > cend)
+		goto eio;
+		
 	csize = cend-cstart;
 
+	if (csize > deflateBound(1UL << zisofs_block_shift))
+		goto eio;
+
 	/* Now page[] contains an array of pages, any of which can be NULL,
 	   and the locks on which we hold.  We should now read the data and
 	   release the pages.  If the pages are NULL the decompressed data
diff --git a/include/asm-x86_64/smp.h b/include/asm-x86_64/smp.h
--- a/include/asm-x86_64/smp.h
+++ b/include/asm-x86_64/smp.h
@@ -46,6 +46,8 @@ extern int pic_mode;
 extern int smp_num_siblings;
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
+extern int smp_call_function_single (int cpuid, void (*func) (void *info), void *info,
+				     int retry, int wait);
 extern void smp_send_reschedule(int cpu);
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
 extern void zap_low_mappings(void);
diff --git a/include/linux/zlib.h b/include/linux/zlib.h
--- a/include/linux/zlib.h
+++ b/include/linux/zlib.h
@@ -506,6 +506,11 @@ extern int zlib_deflateReset (z_streamp 
    stream state was inconsistent (such as zalloc or state being NULL).
 */
 
+static inline unsigned long deflateBound(unsigned long s)
+{
+	return s + ((s + 7) >> 3) + ((s + 63) >> 6) + 11;
+}
+
 extern int zlib_deflateParams (z_streamp strm, int level, int strategy);
 /*
      Dynamically update the compression level and compression strategy.  The
diff --git a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -249,13 +249,18 @@ static inline unsigned int block_size(in
 /* Created by linker magic */
 extern char __per_cpu_start[], __per_cpu_end[];
 
-static void *percpu_modalloc(unsigned long size, unsigned long align)
+static void *percpu_modalloc(unsigned long size, unsigned long align,
+			     const char *name)
 {
 	unsigned long extra;
 	unsigned int i;
 	void *ptr;
 
-	BUG_ON(align > SMP_CACHE_BYTES);
+	if (align > SMP_CACHE_BYTES) {
+		printk(KERN_WARNING "%s: per-cpu alignment %li > %i\n",
+		       name, align, SMP_CACHE_BYTES);
+		align = SMP_CACHE_BYTES;
+	}
 
 	ptr = __per_cpu_start;
 	for (i = 0; i < pcpu_num_used; ptr += block_size(pcpu_size[i]), i++) {
@@ -347,7 +352,8 @@ static int percpu_modinit(void)
 }	
 __initcall(percpu_modinit);
 #else /* ... !CONFIG_SMP */
-static inline void *percpu_modalloc(unsigned long size, unsigned long align)
+static inline void *percpu_modalloc(unsigned long size, unsigned long align,
+				    const char *name)
 {
 	return NULL;
 }
@@ -1554,7 +1560,8 @@ static struct module *load_module(void _
 	if (pcpuindex) {
 		/* We have a special allocation for this section. */
 		percpu = percpu_modalloc(sechdrs[pcpuindex].sh_size,
-					 sechdrs[pcpuindex].sh_addralign);
+					 sechdrs[pcpuindex].sh_addralign,
+					 mod->name);
 		if (!percpu) {
 			err = -ENOMEM;
 			goto free_mod;
diff --git a/lib/inflate.c b/lib/inflate.c
--- a/lib/inflate.c
+++ b/lib/inflate.c
@@ -326,7 +326,7 @@ DEBG("huft1 ");
   {
     *t = (struct huft *)NULL;
     *m = 0;
-    return 0;
+    return 2;
   }
 
 DEBG("huft2 ");
@@ -374,6 +374,7 @@ DEBG("huft5 ");
     if ((j = *p++) != 0)
       v[x[j]++] = i;
   } while (++i < n);
+  n = x[g];                   /* set n to length of v */
 
 DEBG("h6 ");
 
@@ -410,12 +411,13 @@ DEBG1("1 ");
 DEBG1("2 ");
           f -= a + 1;           /* deduct codes from patterns left */
           xp = c + k;
-          while (++j < z)       /* try smaller tables up to z bits */
-          {
-            if ((f <<= 1) <= *++xp)
-              break;            /* enough codes to use up j bits */
-            f -= *xp;           /* else deduct codes from patterns */
-          }
+          if (j < z)
+            while (++j < z)       /* try smaller tables up to z bits */
+            {
+              if ((f <<= 1) <= *++xp)
+                break;            /* enough codes to use up j bits */
+              f -= *xp;           /* else deduct codes from patterns */
+            }
         }
 DEBG1("3 ");
         z = 1 << j;             /* table entries for j-bit table */
diff --git a/lib/zlib_inflate/inftrees.c b/lib/zlib_inflate/inftrees.c
--- a/lib/zlib_inflate/inftrees.c
+++ b/lib/zlib_inflate/inftrees.c
@@ -141,7 +141,7 @@ static int huft_build(
   {
     *t = NULL;
     *m = 0;
-    return Z_OK;
+    return Z_DATA_ERROR;
   }
 
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -409,7 +409,7 @@ asmlinkage long sys_set_mempolicy(int mo
 	struct mempolicy *new;
 	DECLARE_BITMAP(nodes, MAX_NUMNODES);
 
-	if (mode > MPOL_MAX)
+	if (mode < 0 || mode > MPOL_MAX)
 		return -EINVAL;
 	err = get_nodes(nodes, nmask, maxnode, mode);
 	if (err)
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -188,7 +188,11 @@ static void keyring_destroy(struct key *
 
 	if (keyring->description) {
 		write_lock(&keyring_name_lock);
-		list_del(&keyring->type_data.link);
+
+		if (keyring->type_data.link.next != NULL &&
+		    !list_empty(&keyring->type_data.link))
+			list_del(&keyring->type_data.link);
+
 		write_unlock(&keyring_name_lock);
 	}
 
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -641,7 +641,7 @@ long join_session_keyring(const char *na
 		keyring = keyring_alloc(name, tsk->uid, tsk->gid, 0, NULL);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
-			goto error;
+			goto error2;
 		}
 	}
 	else if (IS_ERR(keyring)) {
