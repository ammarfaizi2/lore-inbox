Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbWIFXDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWIFXDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWIFXDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:03:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:32205 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965141AbWIFXDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:03:11 -0400
Date: Wed, 6 Sep 2006 15:57:25 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Robin Holt <holt@sgi.com>,
       Dean Nelson <dcn@sgi.com>, Jack Steiner <steiner@sgi.com>,
       Tony Luck <tony.luck@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 25/37] Silent data corruption caused by XPC
Message-ID: <20060906225725.GZ15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="silent-data-corruption-caused-by-xpc.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Robin Holt <holt@sgi.com>

Jack Steiner identified a problem where XPC can cause a silent
data corruption.  On module load, the placement may cause the
xpc_remote_copy_buffer to span two physical pages.  DMA transfers are
done to the start virtual address translated to physical.

This patch changes the buffer from a statically allocated buffer to a
kmalloc'd buffer.  Dean Nelson reviewed this before posting.  I have
tested it in the configuration that was showing the memory corruption
and verified it works.  I also added a BUG_ON statement to help catch
this if a similar situation is encountered.

Signed-off-by: Robin Holt <holt@sgi.com>
Signed-off-by: Dean Nelson <dcn@sgi.com>
Signed-off-by: Jack Steiner <steiner@sgi.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/ia64/sn/kernel/xpc_channel.c   |    4 ++--
 arch/ia64/sn/kernel/xpc_main.c      |   28 ++++++++++++++++------------
 arch/ia64/sn/kernel/xpc_partition.c |   24 ++++++++----------------
 include/asm-ia64/sn/xp.h            |   22 ++++++++++++++++++----
 include/asm-ia64/sn/xpc.h           |    4 +++-
 5 files changed, 47 insertions(+), 35 deletions(-)

--- linux-2.6.17.11.orig/arch/ia64/sn/kernel/xpc_channel.c
+++ linux-2.6.17.11/arch/ia64/sn/kernel/xpc_channel.c
@@ -279,8 +279,8 @@ xpc_pull_remote_cachelines(struct xpc_pa
 		return part->reason;
 	}
 
-	bte_ret = xp_bte_copy((u64) src, (u64) ia64_tpa((u64) dst),
-				(u64) cnt, (BTE_NORMAL | BTE_WACQUIRE), NULL);
+	bte_ret = xp_bte_copy((u64) src, (u64) dst, (u64) cnt,
+					(BTE_NORMAL | BTE_WACQUIRE), NULL);
 	if (bte_ret == BTE_SUCCESS) {
 		return xpcSuccess;
 	}
--- linux-2.6.17.11.orig/arch/ia64/sn/kernel/xpc_main.c
+++ linux-2.6.17.11/arch/ia64/sn/kernel/xpc_main.c
@@ -1052,6 +1052,8 @@ xpc_do_exit(enum xpc_retval reason)
 	if (xpc_sysctl) {
 		unregister_sysctl_table(xpc_sysctl);
 	}
+
+	kfree(xpc_remote_copy_buffer_base);
 }
 
 
@@ -1212,24 +1214,20 @@ xpc_init(void)
 	partid_t partid;
 	struct xpc_partition *part;
 	pid_t pid;
+	size_t buf_size;
 
 
 	if (!ia64_platform_is("sn2")) {
 		return -ENODEV;
 	}
 
-	/*
-	 * xpc_remote_copy_buffer is used as a temporary buffer for bte_copy'ng
-	 * various portions of a partition's reserved page. Its size is based
-	 * on the size of the reserved page header and part_nasids mask. So we
-	 * need to ensure that the other items will fit as well.
-	 */
-	if (XPC_RP_VARS_SIZE > XPC_RP_HEADER_SIZE + XP_NASID_MASK_BYTES) {
-		dev_err(xpc_part, "xpc_remote_copy_buffer is not big enough\n");
-		return -EPERM;
-	}
-	DBUG_ON((u64) xpc_remote_copy_buffer !=
-				L1_CACHE_ALIGN((u64) xpc_remote_copy_buffer));
+
+	buf_size = max(XPC_RP_VARS_SIZE,
+				XPC_RP_HEADER_SIZE + XP_NASID_MASK_BYTES);
+	xpc_remote_copy_buffer = xpc_kmalloc_cacheline_aligned(buf_size,
+				     GFP_KERNEL, &xpc_remote_copy_buffer_base);
+	if (xpc_remote_copy_buffer == NULL)
+		return -ENOMEM;
 
 	snprintf(xpc_part->bus_id, BUS_ID_SIZE, "part");
 	snprintf(xpc_chan->bus_id, BUS_ID_SIZE, "chan");
@@ -1293,6 +1291,8 @@ xpc_init(void)
 		if (xpc_sysctl) {
 			unregister_sysctl_table(xpc_sysctl);
 		}
+
+		kfree(xpc_remote_copy_buffer_base);
 		return -EBUSY;
 	}
 
@@ -1311,6 +1311,8 @@ xpc_init(void)
 		if (xpc_sysctl) {
 			unregister_sysctl_table(xpc_sysctl);
 		}
+
+		kfree(xpc_remote_copy_buffer_base);
 		return -EBUSY;
 	}
 
@@ -1362,6 +1364,8 @@ xpc_init(void)
 		if (xpc_sysctl) {
 			unregister_sysctl_table(xpc_sysctl);
 		}
+
+		kfree(xpc_remote_copy_buffer_base);
 		return -EBUSY;
 	}
 
--- linux-2.6.17.11.orig/arch/ia64/sn/kernel/xpc_partition.c
+++ linux-2.6.17.11/arch/ia64/sn/kernel/xpc_partition.c
@@ -71,19 +71,15 @@ struct xpc_partition xpc_partitions[XP_M
  * Generic buffer used to store a local copy of portions of a remote
  * partition's reserved page (either its header and part_nasids mask,
  * or its vars).
- *
- * xpc_discovery runs only once and is a seperate thread that is
- * very likely going to be processing in parallel with receiving
- * interrupts.
  */
-char ____cacheline_aligned xpc_remote_copy_buffer[XPC_RP_HEADER_SIZE +
-							XP_NASID_MASK_BYTES];
+char *xpc_remote_copy_buffer;
+void *xpc_remote_copy_buffer_base;
 
 
 /*
  * Guarantee that the kmalloc'd memory is cacheline aligned.
  */
-static void *
+void *
 xpc_kmalloc_cacheline_aligned(size_t size, gfp_t flags, void **base)
 {
 	/* see if kmalloc will give us cachline aligned memory by default */
@@ -148,7 +144,7 @@ xpc_get_rsvd_page_pa(int nasid)
 			}
 		}
 
-		bte_res = xp_bte_copy(rp_pa, ia64_tpa(buf), buf_len,
+		bte_res = xp_bte_copy(rp_pa, buf, buf_len,
 					(BTE_NOTIFY | BTE_WACQUIRE), NULL);
 		if (bte_res != BTE_SUCCESS) {
 			dev_dbg(xpc_part, "xp_bte_copy failed %i\n", bte_res);
@@ -447,7 +443,7 @@ xpc_check_remote_hb(void)
 
 		/* pull the remote_hb cache line */
 		bres = xp_bte_copy(part->remote_vars_pa,
-					ia64_tpa((u64) remote_vars),
+					(u64) remote_vars,
 					XPC_RP_VARS_SIZE,
 					(BTE_NOTIFY | BTE_WACQUIRE), NULL);
 		if (bres != BTE_SUCCESS) {
@@ -498,8 +494,7 @@ xpc_get_remote_rp(int nasid, u64 *discov
 
 
 	/* pull over the reserved page header and part_nasids mask */
-
-	bres = xp_bte_copy(*remote_rp_pa, ia64_tpa((u64) remote_rp),
+	bres = xp_bte_copy(*remote_rp_pa, (u64) remote_rp,
 				XPC_RP_HEADER_SIZE + xp_nasid_mask_bytes,
 				(BTE_NOTIFY | BTE_WACQUIRE), NULL);
 	if (bres != BTE_SUCCESS) {
@@ -554,11 +549,8 @@ xpc_get_remote_vars(u64 remote_vars_pa, 
 		return xpcVarsNotSet;
 	}
 
-
 	/* pull over the cross partition variables */
-
-	bres = xp_bte_copy(remote_vars_pa, ia64_tpa((u64) remote_vars),
-				XPC_RP_VARS_SIZE,
+	bres = xp_bte_copy(remote_vars_pa, (u64) remote_vars, XPC_RP_VARS_SIZE,
 				(BTE_NOTIFY | BTE_WACQUIRE), NULL);
 	if (bres != BTE_SUCCESS) {
 		return xpc_map_bte_errors(bres);
@@ -1239,7 +1231,7 @@ xpc_initiate_partid_to_nasids(partid_t p
 
 	part_nasid_pa = (u64) XPC_RP_PART_NASIDS(part->remote_rp_pa);
 
-	bte_res = xp_bte_copy(part_nasid_pa, ia64_tpa((u64) nasid_mask),
+	bte_res = xp_bte_copy(part_nasid_pa, (u64) nasid_mask,
 			xp_nasid_mask_bytes, (BTE_NOTIFY | BTE_WACQUIRE), NULL);
 
 	return xpc_map_bte_errors(bte_res);
--- linux-2.6.17.11.orig/include/asm-ia64/sn/xp.h
+++ linux-2.6.17.11/include/asm-ia64/sn/xp.h
@@ -60,23 +60,37 @@
  * the bte_copy() once in the hope that the failure was due to a temporary
  * aberration (i.e., the link going down temporarily).
  *
- * See bte_copy for definition of the input parameters.
+ * 	src - physical address of the source of the transfer.
+ *	vdst - virtual address of the destination of the transfer.
+ *	len - number of bytes to transfer from source to destination.
+ *	mode - see bte_copy() for definition.
+ *	notification - see bte_copy() for definition.
  *
  * Note: xp_bte_copy() should never be called while holding a spinlock.
  */
 static inline bte_result_t
-xp_bte_copy(u64 src, u64 dest, u64 len, u64 mode, void *notification)
+xp_bte_copy(u64 src, u64 vdst, u64 len, u64 mode, void *notification)
 {
 	bte_result_t ret;
+	u64 pdst = ia64_tpa(vdst);
 
 
-	ret = bte_copy(src, dest, len, mode, notification);
+	/*
+	 * Ensure that the physically mapped memory is contiguous.
+	 *
+	 * We do this by ensuring that the memory is from region 7 only.
+	 * If the need should arise to use memory from one of the other
+	 * regions, then modify the BUG_ON() statement to ensure that the
+	 * memory from that region is always physically contiguous.
+	 */
+	BUG_ON(REGION_NUMBER(vdst) != RGN_KERNEL);
 
+	ret = bte_copy(src, pdst, len, mode, notification);
 	if (ret != BTE_SUCCESS) {
 		if (!in_interrupt()) {
 			cond_resched();
 		}
-		ret = bte_copy(src, dest, len, mode, notification);
+		ret = bte_copy(src, pdst, len, mode, notification);
 	}
 
 	return ret;
--- linux-2.6.17.11.orig/include/asm-ia64/sn/xpc.h
+++ linux-2.6.17.11/include/asm-ia64/sn/xpc.h
@@ -684,7 +684,9 @@ extern struct xpc_vars *xpc_vars;
 extern struct xpc_rsvd_page *xpc_rsvd_page;
 extern struct xpc_vars_part *xpc_vars_part;
 extern struct xpc_partition xpc_partitions[XP_MAX_PARTITIONS + 1];
-extern char xpc_remote_copy_buffer[];
+extern char *xpc_remote_copy_buffer;
+extern void *xpc_remote_copy_buffer_base;
+extern void *xpc_kmalloc_cacheline_aligned(size_t, gfp_t, void **);
 extern struct xpc_rsvd_page *xpc_rsvd_page_init(void);
 extern void xpc_allow_IPI_ops(void);
 extern void xpc_restrict_IPI_ops(void);

--
