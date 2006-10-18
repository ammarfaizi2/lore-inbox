Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbWJRQd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWJRQd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422665AbWJRQd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:33:57 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:33933 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422663AbWJRQdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:33:55 -0400
Date: Wed, 18 Oct 2006 18:34:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20061018163401.GB15229@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 Documentation/s390/CommonIO         |    2 +
 Documentation/s390/cds.txt          |   52 ++++++++++++++++-------------------
 Documentation/s390/driver-model.txt |    3 ++
 arch/s390/defconfig                 |   12 +++-----
 arch/s390/kernel/compat_linux.c     |    2 +
 arch/s390/kernel/syscalls.S         |    1 +
 drivers/s390/block/dasd.c           |    1 +
 drivers/s390/char/monwriter.c       |   14 +++++++--
 drivers/s390/cio/device_fsm.c       |    4 +++
 drivers/s390/cio/qdio.c             |    2 +
 include/asm-s390/pgtable.h          |   50 +++++++++++++++++++++++++++-------
 include/asm-s390/unistd.h           |    3 +-
 12 files changed, 94 insertions(+), 52 deletions(-)

Cedric Le Goater:
      [S390] fix vmlinux link when CONFIG_SYSIPC=n

Cornelia Huck:
      [S390] cio: sch_no -> schid.sch_no conversion.
      [S390] cio: update documentation.

Heiko Carstens:
      [S390] Wire up epoll_pwait syscall.

Martin Schwidefsky:
      [S390] Fix pte type checking.
      [S390] update default configuration

Melissa Howland:
      [S390] monwriter find header logic.

Peter Oberparleiter:
      [S390] cio: invalid device operational notification

Stefan Weinhuber:
      [S390] dasd: clean up timer.

diff --git a/Documentation/s390/CommonIO b/Documentation/s390/CommonIO
index 59d1166..d684a6a 100644
--- a/Documentation/s390/CommonIO
+++ b/Documentation/s390/CommonIO
@@ -66,7 +66,7 @@ Command line parameters
 
   When a device is un-ignored, device recognition and sensing is performed and 
   the device driver will be notified if possible, so the device will become
-  available to the system.
+  available to the system. Note that un-ignoring is performed asynchronously.
 
   You can also add ranges of devices to be ignored by piping to 
   /proc/cio_ignore; "add <device range>, <device range>, ..." will ignore the
diff --git a/Documentation/s390/cds.txt b/Documentation/s390/cds.txt
index d80e573..32a96cc 100644
--- a/Documentation/s390/cds.txt
+++ b/Documentation/s390/cds.txt
@@ -174,14 +174,10 @@ read_dev_chars() - Read Device Character
 
 This routine returns the characteristics for the device specified.
 
-The function is meant to be called with an irq handler in place; that is,
+The function is meant to be called with the device already enabled; that is,
 at earliest during set_online() processing.
 
-While the request is processed synchronously, the device interrupt
-handler is called for final ending status. In case of error situations the
-interrupt handler may recover appropriately. The device irq handler can
-recognize the corresponding interrupts by the interruption parameter be
-0x00524443. The ccw_device must not be locked prior to calling read_dev_chars().
+The ccw_device must not be locked prior to calling read_dev_chars().
 
 The function may be called enabled or disabled.
 
@@ -410,26 +406,7 @@ individual flag meanings.
 
 Usage Notes :
 
-Prior to call ccw_device_start() the device driver must assure disabled state,
-i.e. the I/O mask value in the PSW must be disabled. This can be accomplished
-by calling local_save_flags( flags). The current PSW flags are preserved and
-can be restored by local_irq_restore( flags) at a later time.
-
-If the device driver violates this rule while running in a uni-processor
-environment an interrupt might be presented prior to the ccw_device_start()
-routine returning to the device driver main path. In this case we will end in a
-deadlock situation as the interrupt handler will try to obtain the irq
-lock the device driver still owns (see below) !
-
-The driver must assure to hold the device specific lock. This can be
-accomplished by
-
-(i)  spin_lock(get_ccwdev_lock(cdev)), or
-(ii) spin_lock_irqsave(get_ccwdev_lock(cdev), flags)
-
-Option (i) should be used if the calling routine is running disabled for
-I/O interrupts (see above) already. Option (ii) obtains the device gate und
-puts the CPU into I/O disabled state by preserving the current PSW flags.
+ccw_device_start() must be called disabled and with the ccw device lock held.
 
 The device driver is allowed to issue the next ccw_device_start() call from
 within its interrupt handler already. It is not required to schedule a
@@ -488,7 +465,7 @@ int ccw_device_resume(struct ccw_device 
 
 cdev - ccw_device the resume operation is requested for
 
-The resume_IO() function returns:
+The ccw_device_resume() function returns:
 
         0  - suspended channel program is resumed
 -EBUSY     - status pending
@@ -507,6 +484,8 @@ a long-running channel program or the de
 a halt subchannel (HSCH) I/O command. For those purposes the ccw_device_halt()
 command is provided.
 
+ccw_device_halt() must be called disabled and with the ccw device lock held.
+
 int ccw_device_halt(struct ccw_device *cdev,
                     unsigned long intparm);
 
@@ -517,7 +496,7 @@ intparm : interruption parameter; value 
 
 The ccw_device_halt() function returns :
 
-      0 - successful completion or request successfully initiated
+      0 - request successfully initiated
 -EBUSY  - the device is currently busy, or status pending.
 -ENODEV - cdev invalid.
 -EINVAL - The device is not operational or the ccw device is not online.
@@ -533,6 +512,23 @@ can then perform an appropriate action. 
 read to a network device (with or without PCI flag) a ccw_device_halt()
 is required to end the pending operation.
 
+ccw_device_clear() - Terminage I/O Request Processing
+
+In order to terminate all I/O processing at the subchannel, the clear subchannel
+(CSCH) command is used. It can be issued via ccw_device_clear().
+
+ccw_device_clear() must be called disabled and with the ccw device lock held.
+
+int ccw_device_clear(struct ccw_device *cdev, unsigned long intparm);
+
+cdev:	 ccw_device the clear operation is requested for
+intparm: interruption parameter (see ccw_device_halt())
+
+The ccw_device_clear() function returns:
+
+      0 - request successfully initiated
+-ENODEV - cdev invalid
+-EINVAL - The device is not operational or the ccw device is not online.
 
 Miscellaneous Support Routines
 
diff --git a/Documentation/s390/driver-model.txt b/Documentation/s390/driver-model.txt
index 62c0823..77bf450 100644
--- a/Documentation/s390/driver-model.txt
+++ b/Documentation/s390/driver-model.txt
@@ -239,6 +239,9 @@ status - Can be 'online' or 'offline'.
 
 type - The physical type of the channel path.
 
+shared - Whether the channel path is shared.
+
+cmg - The channel measurement group.
 
 3. System devices
 -----------------
diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index a325739..c313e9a 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18
-# Wed Oct  4 19:45:46 2006
+# Linux kernel version: 2.6.19-rc2
+# Wed Oct 18 17:11:10 2006
 #
 CONFIG_MMU=y
 CONFIG_LOCKDEP_SUPPORT=y
@@ -211,6 +211,7 @@ CONFIG_INET6_XFRM_MODE_TRANSPORT=y
 CONFIG_INET6_XFRM_MODE_TUNNEL=y
 CONFIG_INET6_XFRM_MODE_BEET=y
 # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
+CONFIG_IPV6_SIT=y
 # CONFIG_IPV6_TUNNEL is not set
 # CONFIG_IPV6_SUBTREES is not set
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
@@ -528,6 +529,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -646,10 +648,6 @@ #
 # CONFIG_NLS is not set
 
 #
-# Distributed Lock Manager
-#
-
-#
 # Instrumentation Support
 #
 
@@ -669,7 +667,6 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=17
-# CONFIG_DETECT_SOFTLOCKUP is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_DEBUG_PREEMPT=y
@@ -690,6 +687,7 @@ # CONFIG_DEBUG_LIST is not set
 # CONFIG_FRAME_POINTER is not set
 # CONFIG_UNWIND_INFO is not set
 CONFIG_FORCED_INLINING=y
+CONFIG_HEADERS_CHECK=y
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_LKDTM is not set
 
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index e15e148..2001767 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -295,6 +295,7 @@ static inline long put_tv32(struct compa
  *
  * This is really horribly ugly.
  */
+#ifdef CONFIG_SYSVIPC
 asmlinkage long sys32_ipc(u32 call, int first, int second, int third, u32 ptr)
 {
 	if (call >> 16)		/* hack for backward compatibility */
@@ -338,6 +339,7 @@ asmlinkage long sys32_ipc(u32 call, int 
 
 	return -ENOSYS;
 }
+#endif
 
 asmlinkage long sys32_truncate64(const char __user * path, unsigned long high, unsigned long low)
 {
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index e59baec..a4ceae3 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -320,3 +320,4 @@ SYSCALL(sys_tee,sys_tee,sys_tee_wrapper)
 SYSCALL(sys_vmsplice,sys_vmsplice,compat_sys_vmsplice_wrapper)
 NI_SYSCALL							/* 310 sys_move_pages */
 SYSCALL(sys_getcpu,sys_getcpu,sys_getcpu_wrapper)
+SYSCALL(sys_epoll_pwait,sys_epoll_pwait,sys_ni_syscall)
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index d0647d1..79ffef6 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -203,6 +203,7 @@ dasd_state_basic_to_known(struct dasd_de
 	rc = dasd_flush_ccw_queue(device, 1);
 	if (rc)
 		return rc;
+	dasd_clear_timer(device);
 
 	DBF_DEV_EVENT(DBF_EMERG, device, "%p debug area deleted", device);
 	if (device->debug_area != NULL) {
diff --git a/drivers/s390/char/monwriter.c b/drivers/s390/char/monwriter.c
index abd02ed..b9b0fc3 100644
--- a/drivers/s390/char/monwriter.c
+++ b/drivers/s390/char/monwriter.c
@@ -73,12 +73,15 @@ static inline struct mon_buf *monwrite_f
 	struct mon_buf *entry, *next;
 
 	list_for_each_entry_safe(entry, next, &monpriv->list, list)
-		if (entry->hdr.applid == monhdr->applid &&
+		if ((entry->hdr.mon_function == monhdr->mon_function ||
+		     monhdr->mon_function == MONWRITE_STOP_INTERVAL) &&
+		    entry->hdr.applid == monhdr->applid &&
 		    entry->hdr.record_num == monhdr->record_num &&
 		    entry->hdr.version == monhdr->version &&
 		    entry->hdr.release == monhdr->release &&
 		    entry->hdr.mod_level == monhdr->mod_level)
 			return entry;
+
 	return NULL;
 }
 
@@ -92,7 +95,9 @@ static int monwrite_new_hdr(struct mon_p
 	    monhdr->mon_function > MONWRITE_START_CONFIG ||
 	    monhdr->hdrlen != sizeof(struct monwrite_hdr))
 		return -EINVAL;
-	monbuf = monwrite_find_hdr(monpriv, monhdr);
+	monbuf = NULL;
+	if (monhdr->mon_function != MONWRITE_GEN_EVENT)
+		monbuf = monwrite_find_hdr(monpriv, monhdr);
 	if (monbuf) {
 		if (monhdr->mon_function == MONWRITE_STOP_INTERVAL) {
 			monhdr->datalen = monbuf->hdr.datalen;
@@ -104,7 +109,7 @@ static int monwrite_new_hdr(struct mon_p
 			kfree(monbuf);
 			monbuf = NULL;
 		}
-	} else {
+	} else if (monhdr->mon_function != MONWRITE_STOP_INTERVAL) {
 		if (mon_buf_count >= mon_max_bufs)
 			return -ENOSPC;
 		monbuf = kzalloc(sizeof(struct mon_buf), GFP_KERNEL);
@@ -118,7 +123,8 @@ static int monwrite_new_hdr(struct mon_p
 		}
 		monbuf->hdr = *monhdr;
 		list_add_tail(&monbuf->list, &monpriv->list);
-		mon_buf_count++;
+		if (monhdr->mon_function != MONWRITE_GEN_EVENT)
+			mon_buf_count++;
 	}
 	monpriv->current_buf = monbuf;
 	return 0;
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index fcaf28d..de3d085 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -578,9 +578,13 @@ ccw_device_verify_done(struct ccw_device
 		}
 		break;
 	case -ETIME:
+		/* Reset oper notify indication after verify error. */
+		cdev->private->flags.donotify = 0;
 		ccw_device_done(cdev, DEV_STATE_BOXED);
 		break;
 	default:
+		/* Reset oper notify indication after verify error. */
+		cdev->private->flags.donotify = 0;
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_nopath_notify, cdev);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
diff --git a/drivers/s390/cio/qdio.c b/drivers/s390/cio/qdio.c
index 0648ce5..476aa1d 100644
--- a/drivers/s390/cio/qdio.c
+++ b/drivers/s390/cio/qdio.c
@@ -3529,7 +3529,7 @@ do_QDIO(struct ccw_device *cdev,unsigned
 #ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[20];
 
-	sprintf(dbf_text,"doQD%04x",cdev->private->sch_no);
+	sprintf(dbf_text,"doQD%04x",cdev->private->schid.sch_no);
  	QDIO_DBF_TEXT3(0,trace,dbf_text);
 #endif /* CONFIG_QDIO_DEBUG */
 
diff --git a/include/asm-s390/pgtable.h b/include/asm-s390/pgtable.h
index 519f0a5..36bb6da 100644
--- a/include/asm-s390/pgtable.h
+++ b/include/asm-s390/pgtable.h
@@ -200,18 +200,45 @@ #endif /* __s390x__ */
  */
 
 /* Hardware bits in the page table entry */
-#define _PAGE_RO        0x200          /* HW read-only                     */
-#define _PAGE_INVALID   0x400          /* HW invalid                       */
+#define _PAGE_RO	0x200		/* HW read-only bit  */
+#define _PAGE_INVALID	0x400		/* HW invalid bit    */
+#define _PAGE_SWT	0x001		/* SW pte type bit t */
+#define _PAGE_SWX	0x002		/* SW pte type bit x */
 
-/* Mask and six different types of pages. */
-#define _PAGE_TYPE_MASK		0x601
+/* Six different types of pages. */
 #define _PAGE_TYPE_EMPTY	0x400
 #define _PAGE_TYPE_NONE		0x401
-#define _PAGE_TYPE_SWAP		0x600
-#define _PAGE_TYPE_FILE		0x601
+#define _PAGE_TYPE_SWAP		0x403
+#define _PAGE_TYPE_FILE		0x601	/* bit 0x002 is used for offset !! */
 #define _PAGE_TYPE_RO		0x200
 #define _PAGE_TYPE_RW		0x000
 
+/*
+ * PTE type bits are rather complicated. handle_pte_fault uses pte_present,
+ * pte_none and pte_file to find out the pte type WITHOUT holding the page
+ * table lock. ptep_clear_flush on the other hand uses ptep_clear_flush to
+ * invalidate a given pte. ipte sets the hw invalid bit and clears all tlbs
+ * for the page. The page table entry is set to _PAGE_TYPE_EMPTY afterwards.
+ * This change is done while holding the lock, but the intermediate step
+ * of a previously valid pte with the hw invalid bit set can be observed by
+ * handle_pte_fault. That makes it necessary that all valid pte types with
+ * the hw invalid bit set must be distinguishable from the four pte types
+ * empty, none, swap and file.
+ *
+ *			irxt  ipte  irxt
+ * _PAGE_TYPE_EMPTY	1000   ->   1000
+ * _PAGE_TYPE_NONE	1001   ->   1001
+ * _PAGE_TYPE_SWAP	1011   ->   1011
+ * _PAGE_TYPE_FILE	11?1   ->   11?1
+ * _PAGE_TYPE_RO	0100   ->   1100
+ * _PAGE_TYPE_RW	0000   ->   1000
+ *
+ * pte_none is true for bits combinations 1000, 1100
+ * pte_present is true for bits combinations 0000, 0010, 0100, 0110, 1001
+ * pte_file is true for bits combinations 1101, 1111
+ * swap pte is 1011 and 0001, 0011, 0101, 0111, 1010 and 1110 are invalid.
+ */
+
 #ifndef __s390x__
 
 /* Bits in the segment table entry */
@@ -365,18 +392,21 @@ #endif /* __s390x__ */
 
 static inline int pte_none(pte_t pte)
 {
-	return (pte_val(pte) & _PAGE_TYPE_MASK) == _PAGE_TYPE_EMPTY;
+	return (pte_val(pte) & _PAGE_INVALID) && !(pte_val(pte) & _PAGE_SWT);
 }
 
 static inline int pte_present(pte_t pte)
 {
-	return !(pte_val(pte) & _PAGE_INVALID) ||
-		(pte_val(pte) & _PAGE_TYPE_MASK) == _PAGE_TYPE_NONE;
+	unsigned long mask = _PAGE_RO | _PAGE_INVALID | _PAGE_SWT | _PAGE_SWX;
+	return (pte_val(pte) & mask) == _PAGE_TYPE_NONE ||
+		(!(pte_val(pte) & _PAGE_INVALID) &&
+		 !(pte_val(pte) & _PAGE_SWT));
 }
 
 static inline int pte_file(pte_t pte)
 {
-	return (pte_val(pte) & _PAGE_TYPE_MASK) == _PAGE_TYPE_FILE;
+	unsigned long mask = _PAGE_RO | _PAGE_INVALID | _PAGE_SWT;
+	return (pte_val(pte) & mask) == _PAGE_TYPE_FILE;
 }
 
 #define pte_same(a,b)	(pte_val(a) == pte_val(b))
diff --git a/include/asm-s390/unistd.h b/include/asm-s390/unistd.h
index a19238c..71d3c21 100644
--- a/include/asm-s390/unistd.h
+++ b/include/asm-s390/unistd.h
@@ -249,8 +249,9 @@ #define __NR_tee		308
 #define __NR_vmsplice		309
 /* Number 310 is reserved for new sys_move_pages */
 #define __NR_getcpu		311
+#define __NR_epoll_pwait	312
 
-#define NR_syscalls 312
+#define NR_syscalls 313
 
 /* 
  * There are some system calls that are not present on 64 bit, some
