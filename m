Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUGIRSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUGIRSc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 13:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUGIRSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 13:18:32 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:18135 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S265108AbUGIRRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 13:17:47 -0400
Date: Fri, 9 Jul 2004 19:17:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: cpu hotplug bugs.
Message-ID: <20040709171739.GB3546@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: cpu hotplug bugs.

From: Ursula Braun-Krahl <braunu@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

iucv driver changes:
 - Fix iucv declare/retrieve buffer which the cpu hotplug patch has broken.
 - Make smp_call_function_on call func(info) in non-smp kernels.
 - Use a spinlock to get smp_get_cpu/smp_put_cpu race free.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/smp.c  |   38 ++++++++++++++-----------
 drivers/s390/net/iucv.c |   71 +++++++++++++++++++++++-------------------------
 include/asm-s390/smp.h  |    8 ++++-
 3 files changed, 64 insertions(+), 53 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/smp.c linux-2.6-s390/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	Fri Jul  9 18:58:41 2004
+++ linux-2.6-s390/arch/s390/kernel/smp.c	Fri Jul  9 18:58:54 2004
@@ -582,38 +582,45 @@
 
 /* Reserving and releasing of CPUs */
 
-static atomic_t smp_cpu_reserved[NR_CPUS];
+static spinlock_t smp_reserve_lock = SPIN_LOCK_UNLOCKED;
+static int smp_cpu_reserved[NR_CPUS];
 
 int
 smp_get_cpu(cpumask_t cpu_mask)
 {
-	int val, cpu;
+	unsigned long flags;
+	int cpu;
 
+	spin_lock_irqsave(&smp_reserve_lock, flags);
 	/* Try to find an already reserved cpu. */
 	for_each_cpu_mask(cpu, cpu_mask) {
-		while ((val = atomic_read(&smp_cpu_reserved[cpu])) != 0) {
-			if (!atomic_compare_and_swap(val, val + 1,
-						     &smp_cpu_reserved[cpu]))
-				/* Found one. */
-				goto out;
+		if (smp_cpu_reserved[cpu] != 0) {
+			smp_cpu_reserved[cpu]++;
+			/* Found one. */
+			goto out;
 		}
 	}
 	/* Reserve a new cpu from cpu_mask. */
 	for_each_cpu_mask(cpu, cpu_mask) {
-		atomic_inc(&smp_cpu_reserved[cpu]);
-		if (cpu_online(cpu))
+		if (cpu_online(cpu)) {
+			smp_cpu_reserved[cpu]++;
 			goto out;
-		atomic_dec(&smp_cpu_reserved[cpu]);
+		}
 	}
 	cpu = -ENODEV;
 out:
+	spin_unlock_irqrestore(&smp_reserve_lock, flags);
 	return cpu;
 }
 
 void
 smp_put_cpu(int cpu)
 {
-	atomic_dec(&smp_cpu_reserved[cpu]);
+	unsigned long flags;
+
+	spin_lock_irqsave(&smp_reserve_lock, flags);
+	smp_cpu_reserved[cpu]--;
+	spin_unlock_irqrestore(&smp_reserve_lock, flags);
 }
 
 static inline int
@@ -682,10 +689,9 @@
 	unsigned long flags;
 	ec_creg_mask_parms cr_parms;
 
-	local_irq_save(flags);
-
-	if (atomic_read(&smp_cpu_reserved[smp_processor_id()])) {
-		local_irq_restore(flags);
+	spin_lock_irqsave(&smp_reserve_lock, flags);
+	if (smp_cpu_reserved[smp_processor_id()] != 0) {
+		spin_unlock_irqrestore(&smp_reserve_lock, flags);
 		return -EBUSY;
 	}
 
@@ -715,7 +721,7 @@
 	cr_parms.andvals[14] = ~(1<<28 | 1<<27 | 1<<26 | 1<<25 | 1<<24);
 	smp_ctl_bit_callback(&cr_parms);
 
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&smp_reserve_lock, flags);
 	return 0;
 }
 
diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-s390/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	Fri Jul  9 18:58:43 2004
+++ linux-2.6-s390/drivers/s390/net/iucv.c	Fri Jul  9 18:58:54 2004
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.34 2004/06/24 10:53:48 braunu Exp $
+ * $Id: iucv.c,v 1.38 2004/07/09 15:59:53 mschwide Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.34 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.38 $
  *
  */
 
@@ -354,7 +354,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.34 $";
+	char vbuf[] = "$Revision: 1.38 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -386,7 +386,7 @@
 	}
 
 	ret = bus_register(&iucv_bus);
-	if (ret != 0) {
+	if (ret) {
 		printk(KERN_ERR "IUCV: failed to register bus.\n");
 		return ret;
 	}
@@ -527,7 +527,7 @@
 		 */
 		list_for_each(lh, &iucv_handler_table) {
 			handler *h = list_entry(lh, handler, list);
-			if (memcmp(&new->id, &h->id, sizeof(h->id)) == 0) {
+			if (!memcmp(&new->id, &h->id, sizeof(h->id))) {
 				iucv_debug(1, "ret 1");
 				spin_unlock_irqrestore (&iucv_lock, flags);
 				return 1;
@@ -642,8 +642,6 @@
 {
 	iparml_db *parm;
 
-	if (smp_processor_id() != iucv_cpuid)
-		return;
 	parm = (iparml_db *)grab_param();
 	parm->ipbfadr1 = virt_to_phys(iucv_external_int_buffer);
 	if ((*((ulong *)result) = b2f0(DECLARE_BUFFER, parm)) == 1)
@@ -662,8 +660,6 @@
 {
 	iparml_control *parm;
 
-	if (smp_processor_id() != iucv_cpuid)
-		return;
 	parm = (iparml_control *)grab_param();
 	b2f0(RETRIEVE_BUFFER, parm);
 	release_param(parm);
@@ -683,13 +679,18 @@
 	ulong b2f0_result;
 
 	iucv_debug(1, "entering");
+	b2f0_result = -ENODEV;
 	spin_lock_irqsave (&iucv_lock, flags);
 	if (iucv_cpuid == -1) {
 		/* Reserve any cpu for use by iucv. */
 		iucv_cpuid = smp_get_cpu(CPU_MASK_ALL);
 		spin_unlock_irqrestore (&iucv_lock, flags);
-		smp_call_function(iucv_declare_buffer_cpuid,
-				  &b2f0_result, 0, 1);
+		smp_call_function_on(iucv_declare_buffer_cpuid,
+			&b2f0_result, 0, 1, iucv_cpuid);
+		if (b2f0_result) {
+			smp_put_cpu(iucv_cpuid);
+			iucv_cpuid = -1;
+		}
 		iucv_debug(1, "Address of EIB = %p", iucv_external_int_buffer);
 	} else {
 		spin_unlock_irqrestore (&iucv_lock, flags);
@@ -710,7 +711,8 @@
 {
 	iucv_debug(1, "entering");
 	if (iucv_cpuid != -1) {
-		smp_call_function(iucv_retrieve_buffer_cpuid, 0, 0, 1);
+		smp_call_function_on(iucv_retrieve_buffer_cpuid,
+				     0, 0, 1, iucv_cpuid);
 		/* Release the cpu reserved by iucv_declare_buffer. */
 		smp_put_cpu(iucv_cpuid);
 		iucv_cpuid = -1;
@@ -872,6 +874,9 @@
 		iucv_remove_handler(new_handler);
 		kfree(new_handler);
 		switch(rc) {
+		case -ENODEV:
+			err = "No CPU can be reserved";
+			break;
 		case 0x03:
 			err = "Directory error";
 			break;
@@ -892,7 +897,7 @@
 		       "returned error 0x%02lx (%s)\n", __FUNCTION__, rc, err);
 		return NULL;
 	}
-	if (register_flag == 0) {
+	if (!register_flag) {
 		/* request the 0x4000 external interrupt */
 		rc = register_external_interrupt (0x4000, iucv_irq_handler);
 		if (rc) {
@@ -1042,7 +1047,7 @@
 	parm->ipflags1 = (__u8)flags1;
 	b2f0_result = b2f0(ACCEPT, parm);
 
-	if (b2f0_result == 0) {
+	if (!b2f0_result) {
 		if (msglim)
 			*msglim = parm->ipmsglim;
 		if (pgm_data)
@@ -1182,7 +1187,7 @@
 	memcpy(&local_parm, parm, sizeof(local_parm));
 	release_param(parm);
 	parm = &local_parm;
-	if (b2f0_result == 0)
+	if (!b2f0_result)
 		add_pathid_result = __iucv_add_pathid(parm->ippathid, h);
 	spin_unlock_irqrestore (&iucv_lock, flags);
 
@@ -1242,7 +1247,7 @@
 	parm->ipflags1 |= (IPSRCCLS | IPFGMID | IPFGPID);
 	b2f0_result = b2f0(PURGE, parm);
 
-	if ((b2f0_result == 0) && audit) {
+	if (!b2f0_result && audit) {
 		memcpy(audit, parm->ipaudit, sizeof(parm->ipaudit));
 		/* parm->ipaudit has only 3 bytes */
 		*audit >>= 8;
@@ -1406,7 +1411,7 @@
 
 	b2f0_result = b2f0(RECEIVE, parm);
 
-	if (b2f0_result == 0 || b2f0_result == 5) {
+	if (!b2f0_result || b2f0_result == 5) {
 		if (flags1_out) {
 			iucv_debug(2, "*flags1_out = %d", *flags1_out);
 			*flags1_out = (parm->ipflags1 & (~0x07));
@@ -1496,7 +1501,7 @@
 
 	b2f0_result = b2f0(RECEIVE, parm);
 
-	if (b2f0_result == 0 || b2f0_result == 5) {
+	if (!b2f0_result || b2f0_result == 5) {
 
 		if (flags1_out) {
 			iucv_debug(2, "*flags1_out = %d", *flags1_out);
@@ -1543,7 +1548,7 @@
 				*residual_length = abs (buflen - 8);
 
 			if (residual_buffer) {
-				if (moved == 0)
+				if (!moved)
 					*residual_buffer = (ulong) buffer;
 				else
 					*residual_buffer =
@@ -1645,7 +1650,7 @@
 
 	b2f0_result = b2f0(REPLY, parm);
 
-	if ((b2f0_result == 0) || (b2f0_result == 5)) {
+	if ((!b2f0_result) || (b2f0_result == 5)) {
 		if (ipbfadr2)
 			*ipbfadr2 = parm->ipbfadr2;
 		if (ipbfln2f)
@@ -1711,7 +1716,7 @@
 
 	b2f0_result = b2f0(REPLY, parm);
 
-	if ((b2f0_result == 0) || (b2f0_result == 5)) {
+	if ((!b2f0_result) || (b2f0_result == 5)) {
 
 		if (ipbfadr2)
 			*ipbfadr2 = parm->ipbfadr2;
@@ -1837,7 +1842,7 @@
 
 	b2f0_result = b2f0(SEND, parm);
 
-	if ((b2f0_result == 0) && (msgid))
+	if ((!b2f0_result) && (msgid))
 		*msgid = parm->ipmsgid;
 	release_param(parm);
 
@@ -1891,7 +1896,7 @@
 	parm->ipflags1 = (IPNORPY | IPBUFLST | flags1);
 	b2f0_result = b2f0(SEND, parm);
 
-	if ((b2f0_result == 0) && (msgid))
+	if ((!b2f0_result) && (msgid))
 		*msgid = parm->ipmsgid;
 	release_param(parm);
 
@@ -1937,7 +1942,7 @@
 
 	b2f0_result = b2f0(SEND, parm);
 
-	if ((b2f0_result == 0) && (msgid))
+	if ((!b2f0_result) && (msgid))
 		*msgid = parm->ipmsgid;
 	release_param(parm);
 
@@ -1998,7 +2003,7 @@
 
 	b2f0_result = b2f0(SEND, parm);
 
-	if ((b2f0_result == 0) && (msgid))
+	if ((!b2f0_result) && (msgid))
 		*msgid = parm->ipmsgid;
 	release_param(parm);
 
@@ -2059,7 +2064,7 @@
 	parm->ipmsgtag = msgtag;
 	parm->ipflags1 = (IPBUFLST | IPANSLST | flags1);
 	b2f0_result = b2f0(SEND, parm);
-	if ((b2f0_result == 0) && (msgid))
+	if ((!b2f0_result) && (msgid))
 		*msgid = parm->ipmsgid;
 	release_param(parm);
 
@@ -2117,7 +2122,7 @@
 
 	b2f0_result = b2f0(SEND, parm);
 
-	if ((b2f0_result == 0) && (msgid))
+	if ((!b2f0_result) && (msgid))
 		*msgid = parm->ipmsgid;
 	release_param(parm);
 
@@ -2178,7 +2183,7 @@
 	parm->ipflags1 = (IPRMDATA | IPANSLST | flags1);
 	memcpy(parm->iprmmsg, prmmsg, sizeof(parm->iprmmsg));
 	b2f0_result = b2f0(SEND, parm);
-	if ((b2f0_result == 0) && (msgid))
+	if ((!b2f0_result) && (msgid))
 		*msgid = parm->ipmsgid;
 	release_param(parm);
 
@@ -2191,9 +2196,6 @@
 {
         iparml_set_mask *parm;
 
-        if (smp_processor_id() != iucv_cpuid)
-                return;
-
         iucv_debug(1, "entering");
         parm = (iparml_set_mask *)grab_param();
         parm->ipmask = *((__u8*)result);
@@ -2229,10 +2231,7 @@
 
 	u.param = SetMaskFlag;
 	cpu = get_cpu();
-	if (cpu == iucv_cpuid)
-		iucv_setmask_cpuid(&u);
-	else
-		smp_call_function(iucv_setmask_cpuid, &u, 0, 1);
+	smp_call_function_on(iucv_setmask_cpuid, &u, 0, 1, iucv_cpuid);
 	put_cpu();
 
 	return u.result;
@@ -2361,7 +2360,7 @@
 				iucv_dumpit("temp_buff2",
 					    temp_buff2, sizeof(temp_buff2));
 				
-				if (memcmp (temp_buff1, temp_buff2, 24) == 0) {
+				if (!memcmp (temp_buff1, temp_buff2, 24)) {
 					
 					iucv_debug(2,
 						   "found a matching handler");
diff -urN linux-2.6/include/asm-s390/smp.h linux-2.6-s390/include/asm-s390/smp.h
--- linux-2.6/include/asm-s390/smp.h	Fri Jul  9 18:58:46 2004
+++ linux-2.6-s390/include/asm-s390/smp.h	Fri Jul  9 18:58:54 2004
@@ -69,7 +69,13 @@
 #endif
 
 #ifndef CONFIG_SMP
-#define smp_call_function_on(func,info,nonatomic,wait,cpu)      ({ 0; })
+static inline int
+smp_call_function_on(void (*func) (void *info), void *info,
+		     int nonatomic, int wait, int cpu)
+{
+	func(info);
+	return 0;
+}
 #define smp_get_cpu(cpu) ({ 0; })
 #define smp_put_cpu(cpu) ({ 0; })
 #endif
