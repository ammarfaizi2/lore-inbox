Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263129AbVHEVYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbVHEVYg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbVHEVYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:24:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263133AbVHEVYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:24:04 -0400
Date: Fri, 5 Aug 2005 14:23:55 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.12.4
Message-ID: <20050805212355.GX7762@shell0.pdx.osdl.net>
References: <20050805212211.GC7991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805212211.GC7991@shell0.pdx.osdl.net>
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
-EXTRAVERSION = .3
+EXTRAVERSION = .4
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
@@ -1149,7 +1149,7 @@ endif # KBUILD_EXTMOD
 #(which is the most common case IMHO) to avoid unneeded clutter in the big tags file.
 #Adding $(srctree) adds about 20M on i386 to the size of the output file!
 
-ifeq ($(KBUILD_OUTPUT),)
+ifeq ($(src),$(obj))
 __srctree =
 else
 __srctree = $(srctree)/
diff --git a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
@@ -44,7 +44,7 @@
 
 #define PFX "powernow-k8: "
 #define BFX PFX "BIOS error: "
-#define VERSION "version 1.40.2"
+#define VERSION "version 1.40.4"
 #include "powernow-k8.h"
 
 /* serialize freq changes  */
@@ -978,7 +978,7 @@ static int __init powernowk8_cpu_init(st
 {
 	struct powernow_k8_data *data;
 	cpumask_t oldmask = CPU_MASK_ALL;
-	int rc;
+	int rc, i;
 
 	if (!check_supported_cpu(pol->cpu))
 		return -ENODEV;
@@ -1064,7 +1064,9 @@ static int __init powernowk8_cpu_init(st
 	printk("cpu_init done, current fid 0x%x, vid 0x%x\n",
 	       data->currfid, data->currvid);
 
-	powernow_data[pol->cpu] = data;
+	for_each_cpu_mask(i, cpu_core_map[pol->cpu]) {
+		powernow_data[i] = data;
+	}
 
 	return 0;
 
diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -827,6 +827,8 @@ asmlinkage int sys_get_thread_area(struc
 	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
 		return -EINVAL;
 
+	memset(&info, 0, sizeof(info));
+
 	desc = current->thread.tls_array + idx - GDT_ENTRY_TLS_MIN;
 
 	info.entry_number = idx;
diff --git a/arch/x86_64/ia32/syscall32.c b/arch/x86_64/ia32/syscall32.c
--- a/arch/x86_64/ia32/syscall32.c
+++ b/arch/x86_64/ia32/syscall32.c
@@ -57,6 +57,7 @@ int syscall32_setup_pages(struct linux_b
 	int npages = (VSYSCALL32_END - VSYSCALL32_BASE) >> PAGE_SHIFT;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
+	int ret;
 
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!vma)
@@ -78,7 +79,11 @@ int syscall32_setup_pages(struct linux_b
 	vma->vm_mm = mm;
 
 	down_write(&mm->mmap_sem);
-	insert_vm_struct(mm, vma);
+	if ((ret = insert_vm_struct(mm, vma))) {
+		up_write(&mm->mmap_sem);
+		kmem_cache_free(vm_area_cachep, vma);
+		return ret;
+	}
 	mm->total_vm += npages;
 	up_write(&mm->mmap_sem);
 	return 0;
diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -277,7 +277,7 @@ static void rp_do_receive(struct r_port 
 		ToRecv = space;
 
 	if (ToRecv <= 0)
-		return;
+		goto done;
 
 	/*
 	 * if status indicates there are errored characters in the
@@ -359,6 +359,7 @@ static void rp_do_receive(struct r_port 
 	}
 	/*  Push the data up to the tty layer */
 	ld->receive_buf(tty, tty->flip.char_buf, tty->flip.flag_buf, count);
+done:
 	tty_ldisc_deref(ld);
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1914,9 +1914,11 @@ qla2x00_reg_remote_port(scsi_qla_host_t 
 		rport_ids.roles |= FC_RPORT_ROLE_FCP_TARGET;
 
 	fcport->rport = rport = fc_remote_port_add(ha->host, 0, &rport_ids);
-	if (!rport)
+	if (!rport) {
 		qla_printk(KERN_WARNING, ha,
 		    "Unable to allocate fc remote port!\n");
+		return;
+	}
 
 	if (rport->scsi_target_id != -1 && rport->scsi_target_id < MAX_TARGETS)
 		fcport->os_target_id = rport->scsi_target_id;
diff --git a/fs/bio.c b/fs/bio.c
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -261,6 +261,7 @@ inline void __bio_clone(struct bio *bio,
 	 */
 	bio->bi_vcnt = bio_src->bi_vcnt;
 	bio->bi_size = bio_src->bi_size;
+	bio->bi_idx = bio_src->bi_idx;
 	bio_phys_segments(q, bio);
 	bio_hw_segments(q, bio);
 }
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1192,7 +1192,7 @@ static inline void *skb_header_pointer(c
 {
 	int hlen = skb_headlen(skb);
 
-	if (offset + len <= hlen)
+	if (hlen - offset >= len)
 		return skb->data + offset;
 
 	if (skb_copy_bits(skb, offset, buffer, len) < 0)
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -578,6 +578,14 @@ static int vlan_device_event(struct noti
 			if (!vlandev)
 				continue;
 
+			if (netif_carrier_ok(dev)) {
+				if (!netif_carrier_ok(vlandev))
+					netif_carrier_on(vlandev);
+			} else {
+				if (netif_carrier_ok(vlandev))
+					netif_carrier_off(vlandev);
+			}
+
 			if ((vlandev->state & VLAN_LINK_STATE_MASK) != flgs) {
 				vlandev->state = (vlandev->state &~ VLAN_LINK_STATE_MASK) 
 					| flgs;
diff --git a/net/ipv4/netfilter/ip_conntrack_core.c b/net/ipv4/netfilter/ip_conntrack_core.c
--- a/net/ipv4/netfilter/ip_conntrack_core.c
+++ b/net/ipv4/netfilter/ip_conntrack_core.c
@@ -1124,6 +1124,9 @@ void ip_conntrack_cleanup(void)
 		schedule();
 		goto i_see_dead_people;
 	}
+	/* wait until all references to ip_conntrack_untracked are dropped */
+	while (atomic_read(&ip_conntrack_untracked.ct_general.use) > 1)
+		schedule();
 
 	kmem_cache_destroy(ip_conntrack_cachep);
 	kmem_cache_destroy(ip_conntrack_expect_cachep);
diff --git a/net/ipv4/netfilter/ip_nat_proto_tcp.c b/net/ipv4/netfilter/ip_nat_proto_tcp.c
--- a/net/ipv4/netfilter/ip_nat_proto_tcp.c
+++ b/net/ipv4/netfilter/ip_nat_proto_tcp.c
@@ -40,7 +40,8 @@ tcp_unique_tuple(struct ip_conntrack_tup
 		 enum ip_nat_manip_type maniptype,
 		 const struct ip_conntrack *conntrack)
 {
-	static u_int16_t port, *portptr;
+	static u_int16_t port;
+	u_int16_t *portptr;
 	unsigned int range_size, min, i;
 
 	if (maniptype == IP_NAT_MANIP_SRC)
diff --git a/net/ipv4/netfilter/ip_nat_proto_udp.c b/net/ipv4/netfilter/ip_nat_proto_udp.c
--- a/net/ipv4/netfilter/ip_nat_proto_udp.c
+++ b/net/ipv4/netfilter/ip_nat_proto_udp.c
@@ -41,7 +41,8 @@ udp_unique_tuple(struct ip_conntrack_tup
 		 enum ip_nat_manip_type maniptype,
 		 const struct ip_conntrack *conntrack)
 {
-	static u_int16_t port, *portptr;
+	static u_int16_t port;
+	u_int16_t *portptr;
 	unsigned int range_size, min, i;
 
 	if (maniptype == IP_NAT_MANIP_SRC)
diff --git a/net/ipv6/netfilter/ip6_queue.c b/net/ipv6/netfilter/ip6_queue.c
--- a/net/ipv6/netfilter/ip6_queue.c
+++ b/net/ipv6/netfilter/ip6_queue.c
@@ -76,7 +76,9 @@ static DECLARE_MUTEX(ipqnl_sem);
 static void
 ipq_issue_verdict(struct ipq_queue_entry *entry, int verdict)
 {
+	local_bh_disable();
 	nf_reinject(entry->skb, entry->info, verdict);
+	local_bh_enable();
 	kfree(entry);
 }
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1180,6 +1180,9 @@ static struct xfrm_policy *xfrm_compile_
 	if (nr > XFRM_MAX_DEPTH)
 		return NULL;
 
+	if (p->dir > XFRM_POLICY_OUT)
+		return NULL;
+
 	xp = xfrm_policy_alloc(GFP_KERNEL);
 	if (xp == NULL) {
 		*dir = -ENOBUFS;
