Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318217AbSHZSv3>; Mon, 26 Aug 2002 14:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSHZSv3>; Mon, 26 Aug 2002 14:51:29 -0400
Received: from pD9E2394F.dip.t-dialin.net ([217.226.57.79]:39346 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318211AbSHZSvD>; Mon, 26 Aug 2002 14:51:03 -0400
From: Lightweight Patch Manager <patch@luckynet.dynu.com>
To: Linus Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] don't let's concatenate with __FUNCTION__
X-Mailer: Lightweight Patch Manager
Message-ID: <20020826185510.C0B551@hawkeye.luckynet.adm>
MIME-Version: 1.0
User-Agent: Lightweight Patch Manager/1.04
Date: Mon, 26 Aug 2002 18:55:10 +0000
X-Priority: I really don't care.
Content-Type: text/plain; charset=US-ASCII
Organization: Lightweight Networking
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This kills strange things like __FUNCTION__ concatenation. Auugh...

diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/arch/cris/drivers/usb-host.c thunder-2.5/arch/cris/drivers/usb-host.c
--- linus-2.5/arch/cris/drivers/usb-host.c	Sat Aug 24 04:50:24 2002
+++ thunder-2.5/arch/cris/drivers/usb-host.c	Mon Aug 26 11:57:28 2002
@@ -78,8 +78,8 @@ static const char *usb_hcd_version = "$R
 #endif
 
 #ifdef USB_DEBUG_TRACE
-#define DBFENTER (printk(KERN_DEBUG __FILE__ ": Entering : " __FUNCTION__ "\n"))
-#define DBFEXIT  (printk(KERN_DEBUG __FILE__ ": Exiting  : " __FUNCTION__ "\n"))
+#define DBFENTER (printk(KERN_DEBUG "%s: Entering : %s\n", __FILE__ , __FUNCTION__ ))
+#define DBFEXIT  (printk(KERN_DEBUG "%s: Exiting  : %s\n", __FILE__ , __FUNCTION__ ))
 #else
 #define DBFENTER (NULL)
 #define DBFEXIT  (NULL)
@@ -983,7 +983,7 @@ static int etrax_usb_do_bulk_hw_add(stru
 		dbg_bulk("actual_length == %d", urb->actual_length);
 	
 		if (urb->transfer_buffer_length > 0xffff) {
-			panic(__FILE__ __FUNCTION__ ":urb->transfer_buffer_length > 0xffff\n");
+			panic("%s:%s:urb->transfer_buffer_length > 0xffff\n", __FILE__ , __FUNCTION__ );
 		}
 
 		sb_desc_1->sw_len = urb->transfer_buffer_length;  /* was actual_length */
@@ -1041,7 +1041,7 @@ static int etrax_usb_do_bulk_hw_add(stru
 
 	*R_USB_EPT_INDEX = IO_FIELD(R_USB_EPT_INDEX, value, epid); nop();
 	if (*R_USB_EPT_DATA & IO_MASK(R_USB_EPT_DATA, hold)) {
-		panic("Hold was set in %s\n", __FUNCTION__);
+		panic("Hold was set in %s\n", __FUNCTION__ );
 	}
 
 	*R_USB_EPT_DATA &=
@@ -1329,7 +1329,7 @@ static int etrax_usb_do_ctrl_hw_add(stru
 
 	*R_USB_EPT_INDEX = IO_FIELD(R_USB_EPT_INDEX, value, epid); nop();
 	if (*R_USB_EPT_DATA & IO_MASK(R_USB_EPT_DATA, hold)) {
-		panic("Hold was set in %s\n", __FUNCTION__);
+		panic("Hold was set in %s\n", __FUNCTION__ );
 	}
 	
 
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/arch/parisc/kernel/ccio-dma.c thunder-2.5/arch/parisc/kernel/ccio-dma.c
--- linus-2.5/arch/parisc/kernel/ccio-dma.c	Sat Aug 24 04:50:55 2002
+++ thunder-2.5/arch/parisc/kernel/ccio-dma.c	Mon Aug 26 12:06:21 2002
@@ -304,8 +304,8 @@ ccio_alloc_range(struct ccio_device *ioa
 	mask = (unsigned long) -1L;
  	mask >>= BITS_PER_LONG - pages_needed;
 
-	DBG_RES(__FUNCTION__ " size: %d pages_needed %d pages_mask 0x%08lx\n", 
-		size, pages_needed, mask);
+	DBG_RES("%s size: %d pages_needed %d pages_mask 0x%08lx\n", 
+		__FUNCTION__ , size, pages_needed, mask);
 
 	spin_lock_irqsave(&ioa->ccio_lock, flags);
 
@@ -325,18 +325,18 @@ ccio_alloc_range(struct ccio_device *ioa
 		CCIO_FIND_FREE_MAPPING(ioa, res_idx, mask, 64)
 #endif
 	} else {
-		panic(__FILE__ ":" __FUNCTION__ "() Too many pages to map.\n");
+		panic("%s:%s() Too many pages to map.\n", __FILE__ , __FUNCTION__ );
 	}
 
 #ifdef DUMP_RESMAP
 	dump_resmap();
 #endif
-	panic(__FILE__ ":" __FUNCTION__ "() I/O MMU is out of mapping resources\n");
+	panic("%s:%s() I/O MMU is out of mapping resources\n", __FILE__ , __FUNCTION__ );
 	
 resource_found:
 	
-	DBG_RES(__FUNCTION__ " res_idx %d mask 0x%08lx res_hint: %d\n",
-		res_idx, mask, ioa->res_hint);
+	DBG_RES("%s res_idx %d mask 0x%08lx res_hint: %d\n",
+		__FUNCTION__ , res_idx, mask, ioa->res_hint);
 
 	ccio_used_pages += pages_needed;
 	ccio_used_bytes += ((pages_needed >> 3) ? (pages_needed >> 3) : 1);
@@ -377,8 +377,8 @@ ccio_free_range(struct ccio_device *ioa,
 	mask = (unsigned long) -1L;
  	mask >>= BITS_PER_LONG - pages_mapped;
 
-	DBG_RES(__FUNCTION__ " res_idx: %d size: %d pages_mapped %d mask 0x%08lx\n", 
-		res_idx, size, pages_mapped, mask);
+	DBG_RES("%s res_idx: %d size: %d pages_mapped %d mask 0x%08lx\n", 
+		__FUNCTION__ , res_idx, size, pages_mapped, mask);
 
 	spin_lock_irqsave(&ioa->ccio_lock, flags);
 
@@ -393,7 +393,7 @@ ccio_free_range(struct ccio_device *ioa,
 		CCIO_FREE_MAPPINGS(ioa, res_idx, mask, 64);
 #endif
 	} else {
-		panic(__FILE__ ":" __FUNCTION__ "() Too many pages to unmap.\n");
+		panic("%s:%s() Too many pages to unmap.\n", __FILE__ , __FUNCTION__ );
 	}
 	
 	ccio_used_pages -= (pages_mapped ? pages_mapped : 1);
@@ -695,7 +695,7 @@ static dma_addr_t ccio_map_single(struct
 	idx = ccio_alloc_range(ioa, size);
 	iovp = (dma_addr_t) MKIOVP(idx);
 
-	DBG_RUN(__FUNCTION__ " 0x%p -> 0x%lx", addr, (long) iovp | offset);
+	DBG_RUN("%s 0x%p -> 0x%lx", __FUNCTION__ , addr, (long) iovp | offset);
 
 	pdir_start = &(ioa->pdir_base[idx]);
 
@@ -747,7 +747,7 @@ static void ccio_unmap_single(struct pci
 	/* Mask off offset */
 	iova &= IOVP_MASK;
 
-	DBG_RUN(__FUNCTION__ " iovp 0x%lx\n", (long) iova);
+	DBG_RUN("%s iovp 0x%lx\n", __FUNCTION__ , (long) iova);
 
 #ifdef DELAYED_RESOURCE_CNT
 	if (ioa->saved_cnt < DELAYED_RESOURCE_CNT) {
@@ -776,7 +776,7 @@ static void * ccio_alloc_consistent (str
 	unsigned long flags;
 	struct ccio_device *ioa = ccio_list;
 
-	DBG_RUN(__FUNCTION__ " size 0x%x\n",  size);
+	DBG_RUN("%s size 0x%x\n", __FUNCTION__ , size);
 
 #if 0
 /* GRANT Need to establish hierarchy for non-PCI devs as well
@@ -798,7 +798,7 @@ static void * ccio_alloc_consistent (str
 		memset(ret, 0, size);
 		*dma_handle = ccio_map_single(hwdev, ret, size, PCI_DMA_BIDIRECTIONAL);
 	}
-	DBG_RUN(__FUNCTION__ " ret %p\n",  ret);
+	DBG_RUN("%s ret %p\n", __FUNCTION__ , ret);
 
 	return ret;
 }
@@ -822,7 +822,7 @@ static int ccio_map_sg(struct pci_dev *d
 {
 	int tmp = nents;
 
-	DBG_RUN(KERN_WARNING __FUNCTION__ " START\n");
+	DBG_RUN(KERN_WARNING "%s START\n", __FUNCTION__ );
 
         /* KISS: map each buffer seperately. */
 	while (nents) {
@@ -832,14 +832,14 @@ static int ccio_map_sg(struct pci_dev *d
 		sglist++;
 	}
 
-	DBG_RUN(KERN_WARNING __FUNCTION__ " DONE\n");
+	DBG_RUN(KERN_WARNING "%s DONE\n", __FUNCTION__ );
 	return tmp;
 }
 
 
 static void ccio_unmap_sg(struct pci_dev *dev, struct scatterlist *sglist, int nents, int direction)
 {
-	DBG_RUN(KERN_WARNING __FUNCTION__ " : unmapping %d entries\n", nents);
+	DBG_RUN(KERN_WARNING "%s : unmapping %d entries\n", __FUNCTION__ , nents);
 	while (nents) {
 		ccio_unmap_single(dev, sg_dma_address(sglist), sg_dma_len(sglist), direction);
 		nents--;
@@ -878,7 +878,7 @@ static int
 ccio_get_iotlb_size(struct hp_device *d)
 {
 	if(d->spa_shift == 0) {
-		panic(__FUNCTION__ ": Can't determine I/O TLB size.\n");
+		panic("%s: Can't determine I/O TLB size.\n", __FUNCTION__ );
 	}
 	return(1 << d->spa_shift);
 }
@@ -951,15 +951,15 @@ ccio_alloc_pdir(struct ccio_device *ioa)
 	/* Verify it's a power of two */
 	ASSERT((1 << get_order(pdir_size)) == (pdir_size >> PAGE_SHIFT));
 
-	DBG_INIT(__FUNCTION__ " hpa 0x%p mem %dMB IOV %dMB (%d bits)\n    PDIR size 0x%0x",
-		ioa->ccio_hpa, (int) (mem_max>>20), iova_space_size>>20,
-		iov_order + PAGE_SHIFT, pdir_size);
+	DBG_INIT("%s hpa 0x%p mem %dMB IOV %dMB (%d bits)\n    PDIR size 0x%0x",
+		 __FUNCTION__ , ioa->ccio_hpa, (int) (mem_max>>20),
+		 iova_space_size>>20, iov_order + PAGE_SHIFT, pdir_size);
 
 	ioa->pdir_base =
 	pdir_base = (void *) __get_free_pages(GFP_KERNEL, get_order(pdir_size));
 	if (NULL == pdir_base)
 	{
-		panic(__FILE__ ":" __FUNCTION__ "() could not allocate I/O Page Table\n");
+		panic("%s:%s() could not allocate I/O Page Table\n", __FILE__ , __FUNCTION__ );
 	}
 	memset(pdir_base, 0, pdir_size);
 
@@ -1023,13 +1023,13 @@ ccio_resmap_init(struct ccio_device *ioa
 	/* resource map size dictated by pdir_size */
 	res_size = ioa->pdir_size/sizeof(u64); /* entries */
 	res_size >>= 3;	/* convert bit count to byte count */
-	DBG_INIT(__FUNCTION__ "() res_size 0x%x\n", res_size);
+	DBG_INIT("%s() res_size 0x%x\n", __FUNCTION__ , res_size);
 
 	ioa->res_size = res_size;
 	ioa->res_map = (char *) __get_free_pages(GFP_KERNEL, get_order(res_size));
 	if (NULL == ioa->res_map)
 	{
-		panic(__FILE__ ":" __FUNCTION__ "() could not allocate resource map\n");
+		panic("%s:%s() could not allocate resource map\n", __FILE__ , __FUNCTION__ );
 	}
 	memset(ioa->res_map, 0, res_size);
 }
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/drivers/atm/firestream.c thunder-2.5/drivers/atm/firestream.c
--- linus-2.5/drivers/atm/firestream.c	Sat Aug 24 04:51:37 2002
+++ thunder-2.5/drivers/atm/firestream.c	Mon Aug 26 12:08:05 2002
@@ -330,8 +330,8 @@ MODULE_PARM(fs_keystream, "i");
 #define FS_DEBUG_QSIZE   0x00001000
 
 
-#define func_enter() fs_dprintk (FS_DEBUG_FLOW, "fs: enter " __FUNCTION__ "\n")
-#define func_exit()  fs_dprintk (FS_DEBUG_FLOW, "fs: exit  " __FUNCTION__ "\n")
+#define func_enter() fs_dprintk (FS_DEBUG_FLOW, "fs: enter %s\n", __FUNCTION__ )
+#define func_exit()  fs_dprintk (FS_DEBUG_FLOW, "fs: exit  %s\n", __FUNCTION__ )
 
 
 struct fs_dev *fs_boards = NULL;
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/drivers/char/generic_serial.c thunder-2.5/drivers/char/generic_serial.c
--- linus-2.5/drivers/char/generic_serial.c	Sat Aug 24 04:51:47 2002
+++ thunder-2.5/drivers/char/generic_serial.c	Mon Aug 26 12:36:08 2002
@@ -41,8 +41,8 @@ static int gs_debug;
 #define gs_dprintk(f, str...) /* nothing */
 #endif
 
-#define func_enter() gs_dprintk (GS_DEBUG_FLOW, "gs: enter " __FUNCTION__ "\n")
-#define func_exit()  gs_dprintk (GS_DEBUG_FLOW, "gs: exit  " __FUNCTION__ "\n")
+#define func_enter() gs_dprintk (GS_DEBUG_FLOW, "gs: enter %s\n", __FUNCTION__ )
+#define func_exit()  gs_dprintk (GS_DEBUG_FLOW, "gs: exit  %s\n", __FUNCTION__ )
 
 #if NEW_WRITE_LOCKING
 #define DECL      /* Nothing */
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/drivers/char/machzwd.c thunder-2.5/drivers/char/machzwd.c
--- linus-2.5/drivers/char/machzwd.c	Sat Aug 24 04:51:48 2002
+++ thunder-2.5/drivers/char/machzwd.c	Mon Aug 26 12:38:08 2002
@@ -153,7 +153,7 @@ static unsigned long next_heartbeat = 0;
 #ifndef ZF_DEBUG
 #	define dprintk(format, args...)
 #else
-#	define dprintk(format, args...) printk(KERN_DEBUG PFX; ":" __FUNCTION__ ":%d: " format, __LINE__ , ## args)
+#	define dprintk(format, args...) printk(KERN_DEBUG PFX; ":%s:%d: " format, __FUNCTION__ , __LINE__ , ## args)
 #endif
 
 
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/drivers/char/sx.c thunder-2.5/drivers/char/sx.c
--- linus-2.5/drivers/char/sx.c	Sat Aug 24 04:51:50 2002
+++ thunder-2.5/drivers/char/sx.c	Mon Aug 26 12:36:30 2002
@@ -405,11 +405,10 @@ static struct real_driver sx_real_driver
 
 
 
-#define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter " __FUNCTION__ "\n")
-#define func_exit()  sx_dprintk (SX_DEBUG_FLOW, "sx: exit  " __FUNCTION__ "\n")
+#define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s\n", __FUNCTION__ )
+#define func_exit()  sx_dprintk (SX_DEBUG_FLOW, "sx: exit  %s\n", __FUNCTION__ )
 
-#define func_enter2() sx_dprintk (SX_DEBUG_FLOW, "sx: enter " __FUNCTION__ \
-                                  "(port %d)\n", port->line)
+#define func_enter2() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s (port %d)\n", __FUNCTION__ , port->line)
 
 
 
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/drivers/net/wan/cycx_drv.c thunder-2.5/drivers/net/wan/cycx_drv.c
--- linus-2.5/drivers/net/wan/cycx_drv.c	Sat Aug 24 04:52:47 2002
+++ thunder-2.5/drivers/net/wan/cycx_drv.c	Mon Aug 26 12:10:25 2002
@@ -423,8 +423,8 @@ static int load_cyc2x(cycxhw_t *hw, cfm_
 
 	/* Verify firmware module format version */
 	if (cfm->version != CFM_VERSION) {
-		printk(KERN_ERR "%s:" __FUNCTION__ ": firmware format %u rejected! "
-				"Expecting %u.\n",
+		printk(KERN_ERR "%s:%s: firmware format %u rejected! "
+				"Expecting %u.\n", __FUNCTION__ ,
 				modname, cfm->version, CFM_VERSION);
 		return -EINVAL;
 	}
@@ -437,8 +437,8 @@ static int load_cyc2x(cycxhw_t *hw, cfm_
 	if (((len - sizeof(cfm_t) - 1) != cfm->info.codesize) ||
 */
 	if (cksum != cfm->checksum) {
-		printk(KERN_ERR "%s:" __FUNCTION__ ": firmware corrupted!\n",
-				modname);
+		printk(KERN_ERR "%s:%s: firmware corrupted!\n",
+				modname, __FUNCTION__ );
 		printk(KERN_ERR " cdsize = 0x%x (expected 0x%lx)\n",
 				len - sizeof(cfm_t) - 1, cfm->info.codesize);
                 printk(KERN_ERR " chksum = 0x%x (expected 0x%x)\n",
@@ -450,7 +450,7 @@ static int load_cyc2x(cycxhw_t *hw, cfm_
 
 	img_hdr = (cycx_header_t*)(((u8*)cfm) + sizeof(cfm_t) - 1);
 #ifdef FIRMWARE_DEBUG
-	printk(KERN_INFO "%s:" __FUNCTION__ ": image sizes\n", modname);
+	printk(KERN_INFO "%s:%s: image sizes\n", modname, __FUNCTION__ );
 	printk(KERN_INFO " reset=%lu\n", img_hdr->reset_size);
 	printk(KERN_INFO "  data=%lu\n", img_hdr->data_size);
 	printk(KERN_INFO "  code=%lu\n", img_hdr->code_size);
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/drivers/scsi/pcmcia/nsp_cs.c thunder-2.5/drivers/scsi/pcmcia/nsp_cs.c
--- linus-2.5/drivers/scsi/pcmcia/nsp_cs.c	Sat Aug 24 04:53:20 2002
+++ thunder-2.5/drivers/scsi/pcmcia/nsp_cs.c	Mon Aug 26 12:49:27 2002
@@ -168,12 +168,12 @@ static int nsp_queuecommand(Scsi_Cmnd *S
 #endif
 	nsp_hw_data *data = &nsp_data;
 
-	DEBUG(0, __FUNCTION__ "() SCpnt=0x%p target=%d lun=%d buff=0x%p bufflen=%d use_sg=%d\n",
+	DEBUG(0, "%s() SCpnt=0x%p target=%d lun=%d buff=0x%p bufflen=%d use_sg=%d\n", __FUNCTION__ ,
 	      SCpnt, target, SCpnt->lun, SCpnt->request_buffer, SCpnt->request_bufflen, SCpnt->use_sg);
 	//DEBUG(0, " before CurrentSC=0x%p\n", data->CurrentSC);
 
 	if(data->CurrentSC != NULL) {
-		printk(KERN_DEBUG " " __FUNCTION__ "() CurrentSC!=NULL this can't be happen\n");
+		printk(KERN_DEBUG "%s() CurrentSC!=NULL this can't be happen\n", __FUNCTION__ );
 		data->CurrentSC = NULL;
 		SCpnt->result   = DID_BAD_TARGET << 16;
 		done(SCpnt);
@@ -219,7 +219,7 @@ static int nsp_queuecommand(Scsi_Cmnd *S
 	}
 
 
-	//DEBUG(0, __FUNCTION__ "() out\n");
+	//DEBUG(0, "%s() out\n", __FUNCTION__ );
 	return 0;
 }
 
@@ -231,7 +231,7 @@ static void nsp_setup_fifo(nsp_hw_data *
 	unsigned int  base = data->BaseAddress;
 	unsigned char transfer_mode_reg;
 
-	//DEBUG(0, __FUNCTION__ "() enabled=%d\n", enabled);
+	//DEBUG(0, "%s() enabled=%d\n", __FUNCTION__ , enabled);
 
 	if (enabled != FALSE) {
 		transfer_mode_reg = TRANSFER_GO | BRAIND;
@@ -256,7 +256,7 @@ static int nsphw_init(nsp_hw_data *data)
 				  SyncOffset:	   0
 	};
 
-	DEBUG(0, __FUNCTION__ "() in base=0x%x\n", base);
+	DEBUG(0, "%s() in base=0x%x\n", __FUNCTION__ , base);
 
 	data->ScsiClockDiv = CLOCK_40M;
 	data->CurrentSC    = NULL;
@@ -324,7 +324,7 @@ static unsigned int nsphw_start_selectio
 	int	      wait_count;
 	unsigned char phase, arbit;
 
-	//DEBUG(0, __FUNCTION__ "()in\n");
+	//DEBUG(0, "%s()in\n", __FUNCTION__ );
 
 	phase = nsp_index_read(base, SCSIBUSMON);
 	if(phase != BUSMON_BUS_FREE) {
@@ -406,7 +406,7 @@ static int nsp_msg(Scsi_Cmnd *SCpnt, nsp
 	int		       i;
 
 
-	DEBUG(0, __FUNCTION__ "()\n");
+	DEBUG(0, "%s()\n", __FUNCTION__ );
 
 /**!**/
 
@@ -461,7 +461,7 @@ static void nsp_start_timer(Scsi_Cmnd *S
 {
 	unsigned int base = SCpnt->host->io_port;
 
-	//DEBUG(0, __FUNCTION__ "() in SCpnt=0x%p, time=%d\n", SCpnt, time);
+	//DEBUG(0, "%s() in SCpnt=0x%p, time=%d\n", __FUNCTION__ , SCpnt, time);
 	data->TimerCount = time;
 	nsp_index_write(base, TIMERCOUNT, time);
 }
@@ -475,7 +475,7 @@ static int nsp_negate_signal(Scsi_Cmnd *
 	unsigned char reg;
 	int	      count, i = TRUE;
 
-	//DEBUG(0, __FUNCTION__ "()\n");
+	//DEBUG(0, "%s()\n", __FUNCTION__ );
 
 	count = jiffies + HZ;
 
@@ -487,7 +487,7 @@ static int nsp_negate_signal(Scsi_Cmnd *
 	} while ((i = time_before(jiffies, count)) && (reg & mask) != 0);
 
 	if (!i) {
-		printk(KERN_DEBUG __FUNCTION__ " %s signal off timeut\n", str);
+		printk(KERN_DEBUG "%s: %s signal off timeut\n", __FUNCTION__ , str);
 	}
 
 	return 0;
@@ -504,7 +504,7 @@ static int nsp_expect_signal(Scsi_Cmnd	 
 	int	      wait_count;
 	unsigned char phase, i_src;
 
-	//DEBUG(0, __FUNCTION__ "() current_phase=0x%x, mask=0x%x\n", current_phase, mask);
+	//DEBUG(0, "%s() current_phase=0x%x, mask=0x%x\n", __FUNCTION__ , current_phase, mask);
 
 	wait_count = jiffies + HZ;
 	do {
@@ -524,7 +524,7 @@ static int nsp_expect_signal(Scsi_Cmnd	 
 		}
 	} while(time_before(jiffies, wait_count));
 
-	//DEBUG(0, __FUNCTION__ " : " __FUNCTION__ " timeout\n");
+	//DEBUG(0, "%s : %s timeout\n", __FUNCTION__ , __FUNCTION__ );
 	return -1;
 }
 
@@ -539,7 +539,7 @@ static int nsp_xfer(Scsi_Cmnd *SCpnt, ns
 	int	      ptr;
 	int	      ret;
 
-	//DEBUG(0, __FUNCTION__ "()\n");
+	//DEBUG(0, "%s()\n", __FUNCTION__ );
 	for (ptr = 0; len > 0; len --, ptr ++) {
 
 		ret = nsp_expect_signal(SCpnt, phase, BUSMON_REQ);
@@ -574,7 +574,7 @@ static int nsp_dataphase_bypass(Scsi_Cmn
 {
 	unsigned int count;
 
-	//DEBUG(0, __FUNCTION__ "()\n");
+	//DEBUG(0, "%s()\n", __FUNCTION__ );
 
 	if (SCpnt->SCp.have_data_in != IO_IN) {
 		return 0;
@@ -606,7 +606,7 @@ static int nsp_reselected(Scsi_Cmnd *SCp
 	unsigned int  base = SCpnt->host->io_port;
 	unsigned char reg;
 
-	//DEBUG(0, __FUNCTION__ "()\n");
+	//DEBUG(0, "%s()\n", __FUNCTION__ );
 
 	nsp_negate_signal(SCpnt, BUSMON_SEL, "reselect<SEL>");
 
@@ -635,7 +635,7 @@ static int nsp_fifo_count(Scsi_Cmnd *SCp
 
 	count = (h << 16) | (m << 8) | (l << 0);
 
-	//DEBUG(0, __FUNCTION__ "() =0x%x\n", count);
+	//DEBUG(0, "%s() =0x%x\n", __FUNCTION__ , count);
 
 	return count;
 }
@@ -656,7 +656,10 @@ static void nsp_pio_read(Scsi_Cmnd *SCpn
 
 	ocount = data->FifoCount;
 
-	DEBUG(0, __FUNCTION__ "() in SCpnt=0x%p resid=%d ocount=%d ptr=0x%p this_residual=%d buffers=0x%p nbuf=%d\n", SCpnt, RESID, ocount, SCpnt->SCp.ptr, SCpnt->SCp.this_residual, SCpnt->SCp.buffer, SCpnt->SCp.buffers_residual);
+	DEBUG(0, "%s() in SCpnt=0x%p resid=%d ocount=%d ptr=0x%p this_residual=%d buffers=0x%p nbuf=%d\n",
+	      __FUNCTION__ , SCpnt, RESID, ocount, SCpnt->SCp.ptr,
+	      SCpnt->SCp.this_residual, SCpnt->SCp.buffer,
+	      SCpnt->SCp.buffers_residual);
 
 	time_out = jiffies + 10 * HZ;
 
@@ -722,7 +725,8 @@ static void nsp_pio_read(Scsi_Cmnd *SCpn
 	data->FifoCount = ocount;
 
 	if (!i) {
-		printk(KERN_DEBUG __FUNCTION__ "() pio read timeout resid=%d this_residual=%d buffers_residual=%d\n", RESID, SCpnt->SCp.this_residual, SCpnt->SCp.buffers_residual);
+		printk(KERN_DEBUG "%s() pio read timeout resid=%d this_residual=%d buffers_residual=%d\n",
+		       __FUNCTION__ ,RESID, SCpnt->SCp.this_residual, SCpnt->SCp.buffers_residual);
 	}
 	DEBUG(0, " read ocount=0x%x\n", ocount);
 }
@@ -739,7 +743,9 @@ static void nsp_pio_write(Scsi_Cmnd *SCp
 
 	ocount	 = data->FifoCount;
 
-	DEBUG(0, __FUNCTION__ "() in fifocount=%d ptr=0x%p this_residual=%d buffers=0x%p nbuf=%d resid=0x%x\n", data->FifoCount, SCpnt->SCp.ptr, SCpnt->SCp.this_residual, SCpnt->SCp.buffer, SCpnt->SCp.buffers_residual, RESID);
+	DEBUG(0, "%s() in fifocount=%d ptr=0x%p this_residual=%d buffers=0x%p nbuf=%d resid=0x%x\n",
+	      __FUNCTION__ , data->FifoCount, SCpnt->SCp.ptr, SCpnt->SCp.this_residual,
+	      SCpnt->SCp.buffer, SCpnt->SCp.buffers_residual, RESID);
 
 	time_out = jiffies + 10 * HZ;
 
@@ -795,7 +801,7 @@ static void nsp_pio_write(Scsi_Cmnd *SCp
 	data->FifoCount = ocount;
 
 	if (!i) {
-		printk(KERN_DEBUG __FUNCTION__ "() pio write timeout resid=%d\n", RESID);
+		printk(KERN_DEBUG "%s() pio write timeout resid=%d\n", __FUNCTION__ , RESID);
 	}
 	//DEBUG(0, " write ocount=%d\n", ocount);
 }
@@ -813,7 +819,7 @@ static int nsp_nexus(Scsi_Cmnd *SCpnt, n
 	unsigned char  lun    = SCpnt->lun;
 	sync_data     *sync   = &(data->Sync[target][lun]);
 
-	//DEBUG(0, __FUNCTION__ "() in SCpnt=0x%p\n", SCpnt);
+	//DEBUG(0, "%s() in SCpnt=0x%p\n", __FUNCTION__ , SCpnt);
 
 	/* setup synch transfer registers */
 	nsp_index_write(base, SYNCREG,	sync->SyncRegister);
@@ -916,7 +922,8 @@ static void nspintr(int irq, void *dev_i
 	nsp_write(base, IRQCONTROL, IRQCONTROL_TIMER_CLEAR | IRQCONTROL_FIFO_CLEAR);
 
 	if (data->CurrentSC == NULL) {
-		printk(KERN_DEBUG __FUNCTION__ " CurrentSC==NULL irq_status=0x%x phase=0x%x irq_phase=0x%x this can't be happen\n", i_src, phase, irq_phase);
+		printk(KERN_DEBUG "%s: CurrentSC==NULL irq_status=0x%x phase=0x%x irq_phase=0x%x; this can't be happen\n",
+		       __FUNCTION__ , i_src, phase, irq_phase);
 		return;
 	} else {
 		tmpSC    = data->CurrentSC;
@@ -930,7 +937,7 @@ static void nspintr(int irq, void *dev_i
 	 */
 	if ((i_src & IRQSTATUS_SCSI) != 0) {
 		if ((irq_phase & SCSI_RESET_IRQ) != 0) {
-			printk(KERN_DEBUG " " __FUNCTION__ "() bus reset (power off?)\n");
+			printk(KERN_DEBUG "%s() bus reset (power off?)\n", __FUNCTION__ );
 			*sync_neg          = SYNC_NOT_YET;
 			data->CurrentSC    = NULL;
 			tmpSC->result	   = DID_RESET << 16;
@@ -1028,7 +1035,8 @@ static void nspintr(int irq, void *dev_i
 
 	/* check unexpected bus free state */
 	if (phase == 0) {
-		printk(KERN_DEBUG " " __FUNCTION__ " unexpected bus free. i_src=0x%x, phase=0x%x, irq_phase=0x%x\n", i_src, phase, irq_phase);
+		printk(KERN_DEBUG "%s unexpected bus free. i_src=0x%x, phase=0x%x, irq_phase=0x%x\n",
+		       __FUNCTION__ , i_src, phase, irq_phase);
 
 		*sync_neg       = SYNC_NOT_YET;
 		data->CurrentSC = NULL;
@@ -1163,7 +1171,7 @@ static void nspintr(int irq, void *dev_i
 		break;
 	}
 
-	//DEBUG(0, __FUNCTION__ "() out\n");
+	//DEBUG(0, "%s() out\n", __FUNCTION__ );
 	return;	
 
 timer_out:
@@ -1183,7 +1191,7 @@ static int nsp_detect(Scsi_Host_Template
 	struct Scsi_Host *host;	/* registered host structure */
 	nsp_hw_data *data = &nsp_data;
 
-	DEBUG(0, __FUNCTION__ " this_id=%d\n", sht->this_id);
+	DEBUG(0, "%s: this_id=%d\n", __FUNCTION__ , sht->this_id);
 
 	request_region(data->BaseAddress, data->NumAddress, "nsp_cs");
 	host		  = scsi_register(sht, 0);
@@ -1202,7 +1210,7 @@ static int nsp_detect(Scsi_Host_Template
 		host->irq);
 	sht->name	  = nspinfo;
 
-	DEBUG(0, __FUNCTION__ " end\n");
+	DEBUG(0, "%s end\n", __FUNCTION__ );
 
 	return 1; /* detect done. */
 }
@@ -1234,7 +1242,7 @@ static const char *nsp_info(struct Scsi_
 /*---------------------------------------------------------------*/
 static int nsp_reset(Scsi_Cmnd *SCpnt, unsigned int why)
 {
-	DEBUG(0, __FUNCTION__ " SCpnt=0x%p why=%d\n", SCpnt, why);
+	DEBUG(0, "%s SCpnt=0x%p why=%d\n", __FUNCTION__ , SCpnt, why);
 
 	nsp_eh_bus_reset(SCpnt);
 
@@ -1243,7 +1251,7 @@ static int nsp_reset(Scsi_Cmnd *SCpnt, u
 
 static int nsp_abort(Scsi_Cmnd *SCpnt)
 {
-	DEBUG(0, __FUNCTION__ " SCpnt=0x%p\n", SCpnt);
+	DEBUG(0, "%s SCpnt=0x%p\n", __FUNCTION__ , SCpnt);
 
 	nsp_eh_bus_reset(SCpnt);
 
@@ -1257,7 +1265,7 @@ static int nsp_abort(Scsi_Cmnd *SCpnt)
 
 static int nsp_eh_abort(Scsi_Cmnd *SCpnt)
 {
-	DEBUG(0, __FUNCTION__ " SCpnt=0x%p\n", SCpnt);
+	DEBUG(0, "%s SCpnt=0x%p\n", __FUNCTION__ , SCpnt);
 
 	nsp_eh_bus_reset(SCpnt);
 
@@ -1266,7 +1274,7 @@ static int nsp_eh_abort(Scsi_Cmnd *SCpnt
 
 static int nsp_eh_device_reset(Scsi_Cmnd *SCpnt)
 {
-	DEBUG(0, __FUNCTION__ " SCpnt=0x%p\n", SCpnt);
+	DEBUG(0, "%s SCpnt=0x%p\n", __FUNCTION__ , SCpnt);
 
 	return FAILED;
 }
@@ -1276,7 +1284,7 @@ static int nsp_eh_bus_reset(Scsi_Cmnd *S
 	unsigned int base = SCpnt->host->io_port;
 	int	     i;
 
-	DEBUG(0, __FUNCTION__ "() SCpnt=0x%p base=0x%x\n", SCpnt, base);
+	DEBUG(0, "%s() SCpnt=0x%p base=0x%x\n", __FUNCTION__ , SCpnt, base);
 
 	nsp_write(base, IRQCONTROL, IRQCONTROL_ALLMASK);
 
@@ -1296,7 +1304,7 @@ static int nsp_eh_host_reset(Scsi_Cmnd *
 {
 	nsp_hw_data *data = &nsp_data;
 
-	DEBUG(0, __FUNCTION__ "\n");
+	DEBUG(0, "%s\n", __FUNCTION__ );
 
 	nsphw_init(data);
 
@@ -1331,7 +1339,7 @@ static dev_link_t *nsp_cs_attach(void)
 	dev_link_t   *link;
 	int	      ret, i;
 
-	DEBUG(0, __FUNCTION__ "()\n");
+	DEBUG(0, "%s()\n", __FUNCTION__ );
 
 	/* Create new SCSI device */
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
@@ -1402,7 +1410,7 @@ static void nsp_cs_detach(dev_link_t *li
 {
 	dev_link_t **linkp;
 
-	DEBUG(0, __FUNCTION__ "(0x%p)\n", link);
+	DEBUG(0, "%s(0x%p)\n", __FUNCTION__ , link);
     
 	/* Locate device structure */
 	for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next) {
@@ -1460,7 +1468,7 @@ static void nsp_cs_config(dev_link_t *li
 	struct Scsi_Host *host;
 	nsp_hw_data      *data = &nsp_data;
 
-	DEBUG(0, __FUNCTION__ "() in\n");
+	DEBUG(0, "%s() in\n", __FUNCTION__ );
 
 	tuple.DesiredTuple    = CISTPL_CONFIG;
 	tuple.Attributes      = 0;
@@ -1493,7 +1501,7 @@ static void nsp_cs_config(dev_link_t *li
 			break;
 		}
 	next_entry:
-		DEBUG(0, __FUNCTION__ " next\n");
+		DEBUG(0, "%s next\n", __FUNCTION__ );
 		CS_CHECK(GetNextTuple, handle, &tuple);
 	}
 
@@ -1508,7 +1516,7 @@ static void nsp_cs_config(dev_link_t *li
 	data->NumAddress  = link->io.NumPorts1;
 	data->IrqNumber   = link->irq.AssignedIRQ;
 
-	DEBUG(0, __FUNCTION__ " I/O[0x%x+0x%x] IRQ %d\n",
+	DEBUG(0, "%s I/O[0x%x+0x%x] IRQ %d\n", __FUNCTION__ ,
 	      data->BaseAddress, data->NumAddress, data->IrqNumber);
 
 	if(nsphw_init(data) == FALSE) {
@@ -1597,7 +1605,7 @@ static void nsp_cs_release(u_long arg)
 {
 	dev_link_t *link = (dev_link_t *)arg;
 
-	DEBUG(0, __FUNCTION__ "(0x%p)\n", link);
+	DEBUG(0, "%s(0x%p)\n", __FUNCTION__ , link);
 
 	/*
 	 * If the device is currently in use, we won't release until it
@@ -1651,7 +1659,7 @@ static int nsp_cs_event(event_t		    eve
 	dev_link_t  *link = args->client_data;
 	scsi_info_t *info = link->priv;
 
-	DEBUG(1, __FUNCTION__ "(0x%06x)\n", event);
+	DEBUG(1, "%s(0x%06x)\n", __FUNCTION__ , event);
 
 	switch (event) {
 	case CS_EVENT_CARD_REMOVAL:
@@ -1700,7 +1708,7 @@ static int nsp_cs_event(event_t		    eve
 		DEBUG(0, " event: unknown\n");
 		break;
 	}
-	DEBUG(0, __FUNCTION__ " end\n");
+	DEBUG(0, "%s end\n", __FUNCTION__ );
 	return 0;
 } /* nsp_cs_event */
 
@@ -1711,7 +1719,7 @@ static int __init nsp_cs_init(void)
 {
 	servinfo_t serv;
 
-	DEBUG(0, __FUNCTION__ "() in\n");
+	DEBUG(0, "%s() in\n", __FUNCTION__ );
 	DEBUG(0, "%s\n", version);
 	CardServices(GetCardServicesInfo, &serv);
 	if (serv.Revision != CS_RELEASE_CODE) {
@@ -1721,14 +1729,14 @@ static int __init nsp_cs_init(void)
 	}
 	register_pcmcia_driver(&dev_info, &nsp_cs_attach, &nsp_cs_detach);
 
-	DEBUG(0, __FUNCTION__ "() out\n");
+	DEBUG(0, "%s() out\n", __FUNCTION__ );
 	return 0;
 }
 
 
 static void __exit nsp_cs_cleanup(void)
 {
-	DEBUG(0, __FUNCTION__ "() unloading\n");
+	DEBUG(0, "%s() unloading\n", __FUNCTION__ );
 	unregister_pcmcia_driver(&dev_info);
 	while (dev_list != NULL) {
 		if (dev_list->state & DEV_CONFIG) {
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/drivers/scsi/pcmcia/nsp_message.c thunder-2.5/drivers/scsi/pcmcia/nsp_message.c
--- linus-2.5/drivers/scsi/pcmcia/nsp_message.c	Sat Aug 24 04:53:20 2002
+++ thunder-2.5/drivers/scsi/pcmcia/nsp_message.c	Mon Aug 26 12:39:28 2002
@@ -64,7 +64,7 @@ static void nsp_message_out(Scsi_Cmnd *S
 	DEBUG(0, " msgout loop\n");
 	do {
 		if (nsp_xfer(SCpnt, data, BUSPHASE_MESSAGE_OUT)) {
-			printk(KERN_DEBUG " " __FUNCTION__ " msgout: xfer short\n");
+			printk(KERN_DEBUG "%s msgout: xfer short\n", __FUNCTION__ );
 		}
 
 		/* catch a next signal */
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/drivers/usb/class/bluetty.c thunder-2.5/drivers/usb/class/bluetty.c
--- linus-2.5/drivers/usb/class/bluetty.c	Sat Aug 24 04:53:23 2002
+++ thunder-2.5/drivers/usb/class/bluetty.c	Mon Aug 26 12:28:18 2002
@@ -300,7 +300,7 @@ static int bluetooth_ctrl_msg (struct us
 		}
 	}
 	if (urb == NULL) {
-		dbg (__FUNCTION__ " - no free urbs");
+		dbg ("%s - no free urbs", __FUNCTION__ );
 		return -ENOMEM;
 	}
 
@@ -308,7 +308,7 @@ static int bluetooth_ctrl_msg (struct us
 	if (urb->transfer_buffer == NULL) {
 		urb->transfer_buffer = kmalloc (len, GFP_KERNEL);
 		if (urb->transfer_buffer == NULL) {
-			err (__FUNCTION__" - out of memory");
+			err ("%s - out of memory", __FUNCTION__ );
 			return -ENOMEM;
 		}
 	}
@@ -316,7 +316,7 @@ static int bluetooth_ctrl_msg (struct us
 		kfree (urb->transfer_buffer);
 		urb->transfer_buffer = kmalloc (len, GFP_KERNEL);
 		if (urb->transfer_buffer == NULL) {
-			err (__FUNCTION__" - out of memory");
+			err ("%s - out of memory", __FUNCTION__ );
 			return -ENOMEM;
 		}
 	}
@@ -334,7 +334,7 @@ static int bluetooth_ctrl_msg (struct us
 	/* send it down the pipe */
 	status = usb_submit_urb(urb, GFP_KERNEL);
 	if (status)
-		dbg(__FUNCTION__ " - usb_submit_urb(control) failed with status = %d", status);
+		dbg("%s - usb_submit_urb(control) failed with status = %d", __FUNCTION__ , status);
 	
 	return status;
 }
@@ -389,7 +389,7 @@ static int bluetooth_open (struct tty_st
 			       bluetooth_read_bulk_callback, bluetooth);
 		result = usb_submit_urb(bluetooth->read_urb, GFP_KERNEL);
 		if (result)
-			dbg(__FUNCTION__ " - usb_submit_urb(read bulk) failed with status %d", result);
+			dbg("%s - usb_submit_urb(read bulk) failed with status %d", __FUNCTION__ , result);
 #endif
 		FILL_INT_URB (bluetooth->interrupt_in_urb, bluetooth->dev,
 			      usb_rcvintpipe(bluetooth->dev, bluetooth->interrupt_in_endpointAddress),
@@ -399,7 +399,7 @@ static int bluetooth_open (struct tty_st
 			      bluetooth->interrupt_in_interval);
 		result = usb_submit_urb(bluetooth->interrupt_in_urb, GFP_KERNEL);
 		if (result)
-			dbg(__FUNCTION__ " - usb_submit_urb(interrupt in) failed with status %d", result);
+			dbg("%s - usb_submit_urb(interrupt in) failed with status %d", __FUNCTION__ , result);
 	}
 	
 	up(&bluetooth->lock);
@@ -420,7 +420,7 @@ static void bluetooth_close (struct tty_
 	dbg(__FUNCTION__);
 
 	if (!bluetooth->open_count) {
-		dbg (__FUNCTION__ " - device not opened");
+		dbg ("%s - device not opened", __FUNCTION__ );
 		return;
 	}
 
@@ -456,24 +456,24 @@ static int bluetooth_write (struct tty_s
 		return -ENODEV;
 	}
 
-	dbg(__FUNCTION__ " - %d byte(s)", count);
+	dbg("%s - %d byte(s)", __FUNCTION__ , count);
 
 	if (!bluetooth->open_count) {
-		dbg (__FUNCTION__ " - device not opened");
+		dbg ("%s - device not opened", __FUNCTION__ );
 		return -EINVAL;
 	}
 
 	if (count == 0) {
-		dbg(__FUNCTION__ " - write request of 0 bytes");
+		dbg("%s - write request of 0 bytes", __FUNCTION__ );
 		return 0;
 	}
 	if (count == 1) {
-		dbg(__FUNCTION__ " - write request only included type %d", buf[0]);
+		dbg("%s - write request only included type %d", __FUNCTION__ , buf[0]);
 		return 1;
 	}
 
 #ifdef DEBUG
-	printk (KERN_DEBUG __FILE__ ": " __FUNCTION__ " - length = %d, data = ", count);
+	printk (KERN_DEBUG "%s: %s - length = %d, data = ", __FILE__ , __FUNCTION__ , count);
 	for (i = 0; i < count; ++i) {
 		printk ("%.2x ", buf[i]);
 	}
@@ -483,7 +483,7 @@ static int bluetooth_write (struct tty_s
 	if (from_user) {
 		temp_buffer = kmalloc (count, GFP_KERNEL);
 		if (temp_buffer == NULL) {
-			err (__FUNCTION__ "- out of memory.");
+			err ("%s - out of memory.", __FUNCTION__ );
 			retval = -ENOMEM;
 			goto exit;
 		}
@@ -499,7 +499,7 @@ static int bluetooth_write (struct tty_s
 	switch (*current_buffer) {
 		/* First byte indicates the type of packet */
 		case CMD_PKT:
-			/* dbg(__FUNCTION__ "- Send cmd_pkt len:%d", count);*/
+			/* dbg("%s - Send cmd_pkt len:%d", __FUNCTION__ , count);*/
 
 			retval = bluetooth_ctrl_msg (bluetooth, 0x00, 0x00, &current_buffer[1], count-1);
 			if (retval) {
@@ -525,7 +525,7 @@ static int bluetooth_write (struct tty_s
 					}
 				}
 				if (urb == NULL) {
-					dbg (__FUNCTION__ " - no free urbs");
+					dbg ("%s - no free urbs", __FUNCTION__ );
 					retval = bytes_sent;
 					goto exit;
 				}
@@ -541,7 +541,7 @@ static int bluetooth_write (struct tty_s
 				/* send it down the pipe */
 				retval = usb_submit_urb(urb, GFP_KERNEL);
 				if (retval) {
-					dbg(__FUNCTION__ " - usb_submit_urb(write bulk) failed with error = %d", retval);
+					dbg("%s - usb_submit_urb(write bulk) failed with error = %d", __FUNCTION__ , retval);
 					goto exit;
 				}
 #ifdef BTBUGGYHARDWARE
@@ -560,7 +560,7 @@ static int bluetooth_write (struct tty_s
 			break;
 		
 		default :
-			dbg(__FUNCTION__" - unsupported (at this time) write type");
+			dbg("%s - unsupported (at this time) write type", __FUNCTION__ );
 			retval = -EINVAL;
 			break;
 	}
@@ -586,7 +586,7 @@ static int bluetooth_write_room (struct 
 	dbg(__FUNCTION__);
 
 	if (!bluetooth->open_count) {
-		dbg (__FUNCTION__ " - device not open");
+		dbg ("%s - device not open", __FUNCTION__ );
 		return -EINVAL;
 	}
 
@@ -596,7 +596,7 @@ static int bluetooth_write_room (struct 
 		}
 	}
 
-	dbg(__FUNCTION__ " - returns %d", room);
+	dbg("%s - returns %d", __FUNCTION__ , room);
 	return room;
 }
 
@@ -612,7 +612,7 @@ static int bluetooth_chars_in_buffer (st
 	}
 
 	if (!bluetooth->open_count) {
-		dbg (__FUNCTION__ " - device not open");
+		dbg ("%s - device not open", __FUNCTION__ );
 		return -EINVAL;
 	}
 
@@ -622,13 +622,14 @@ static int bluetooth_chars_in_buffer (st
 		}
 	}
 
-	dbg (__FUNCTION__ " - returns %d", chars);
+	dbg ("%s - returns %d", __FUNCTION__ , chars);
 	return chars;
 }
 
 
 static void bluetooth_throttle (struct tty_struct * tty)
 {
+	/* FIXME: Activate this function! --ct */
 	struct usb_bluetooth *bluetooth = get_usb_bluetooth ((struct usb_bluetooth *)tty->driver_data, __FUNCTION__);
 
 	if (!bluetooth) {
@@ -638,11 +639,11 @@ static void bluetooth_throttle (struct t
 	dbg(__FUNCTION__);
 
 	if (!bluetooth->open_count) {
-		dbg (__FUNCTION__ " - device not open");
+		dbg ("%s - device not open", __FUNCTION__ );
 		return;
 	}
 	
-	dbg(__FUNCTION__ " unsupported (at this time)");
+	dbg("%s unsupported (at this time)", __FUNCTION__ );
 
 	return;
 }
@@ -650,6 +651,7 @@ static void bluetooth_throttle (struct t
 
 static void bluetooth_unthrottle (struct tty_struct * tty)
 {
+	/* FIXME: Activate this function! --ct */
 	struct usb_bluetooth *bluetooth = get_usb_bluetooth ((struct usb_bluetooth *)tty->driver_data, __FUNCTION__);
 
 	if (!bluetooth) {
@@ -659,11 +661,11 @@ static void bluetooth_unthrottle (struct
 	dbg(__FUNCTION__);
 
 	if (!bluetooth->open_count) {
-		dbg (__FUNCTION__ " - device not open");
+		dbg ("%s - device not open", __FUNCTION__ );
 		return;
 	}
 
-	dbg(__FUNCTION__ " unsupported (at this time)");
+	dbg("%s unsupported (at this time)", __FUNCTION__ );
 }
 
 
@@ -675,10 +677,10 @@ static int bluetooth_ioctl (struct tty_s
 		return -ENODEV;
 	}
 
-	dbg(__FUNCTION__ " - cmd 0x%.4x", cmd);
+	dbg("%s - cmd 0x%.4x", __FUNCTION__ , cmd);
 
 	if (!bluetooth->open_count) {
-		dbg (__FUNCTION__ " - device not open");
+		dbg ("%s - device not open", __FUNCTION__ );
 		return -ENODEV;
 	}
 
@@ -698,7 +700,7 @@ static void bluetooth_set_termios (struc
 	dbg(__FUNCTION__);
 
 	if (!bluetooth->open_count) {
-		dbg (__FUNCTION__ " - device not open");
+		dbg ("%s - device not open", __FUNCTION__ );
 		return;
 	}
 
@@ -720,7 +722,7 @@ void btusb_enable_bulk_read(struct tty_s
 	dbg(__FUNCTION__);
 
 	if (!bluetooth->open_count) {
-		dbg (__FUNCTION__ " - device not open");
+		dbg ("%s - device not open", __FUNCTION__ );
 		return;
 	}
 
@@ -731,7 +733,7 @@ void btusb_enable_bulk_read(struct tty_s
 			      bluetooth_read_bulk_callback, bluetooth);
 		result = usb_submit_urb(bluetooth->read_urb, GFP_KERNEL);
 		if (result)
-			err (__FUNCTION__ " - failed submitting read urb, error %d", result);
+			err ("%s - failed submitting read urb, error %d", __FUNCTION__ , result);
 	}
 }
 
@@ -745,7 +747,7 @@ void btusb_disable_bulk_read(struct tty_
 	dbg(__FUNCTION__);
 
 	if (!bluetooth->open_count) {
-		dbg (__FUNCTION__ " - device not open");
+		dbg ("%s - device not open", __FUNCTION__ );
 		return;
 	}
 
@@ -771,24 +773,24 @@ static void bluetooth_int_callback (stru
 	dbg(__FUNCTION__);
 
 	if (!bluetooth) {
-		dbg(__FUNCTION__ " - bad bluetooth pointer, exiting");
+		dbg("%s - bad bluetooth pointer, exiting", __FUNCTION__ );
 		return;
 	}
 
 	if (urb->status) {
-		dbg(__FUNCTION__ " - nonzero int status received: %d", urb->status);
+		dbg("%s - nonzero int status received: %d", __FUNCTION__ , urb->status);
 		return;
 	}
 
 	if (!count) {
-		dbg(__FUNCTION__ " - zero length int");
+		dbg("%s - zero length int", __FUNCTION__ );
 		return;
 	}
 
 
 #ifdef DEBUG
 	if (count) {
-		printk (KERN_DEBUG __FILE__ ": " __FUNCTION__ "- length = %d, data = ", count);
+		printk (KERN_DEBUG "%s: %s- length = %d, data = ", __FILE__ , __FUNCTION__ , count);
 		for (i = 0; i < count; ++i) {
 			printk ("%.2x ", data[i]);
 		}
@@ -818,7 +820,7 @@ static void bluetooth_int_callback (stru
 	}
 	
 	if (bluetooth->int_packet_pos + count > EVENT_BUFFER_SIZE) {
-		err(__FUNCTION__ " - exceeded EVENT_BUFFER_SIZE");
+		err("%s - exceeded EVENT_BUFFER_SIZE", __FUNCTION__ );
 		bluetooth->int_packet_pos = 0;
 		return;
 	}
@@ -834,7 +836,7 @@ static void bluetooth_int_callback (stru
 		return;
 
 	if (packet_size + EVENT_HDR_SIZE < bluetooth->int_packet_pos) {
-		err(__FUNCTION__ " - packet was too long");
+		err("%s - packet was too long", __FUNCTION__ );
 		bluetooth->int_packet_pos = 0;
 		return;
 	}
@@ -861,12 +863,12 @@ static void bluetooth_ctrl_callback (str
 	dbg(__FUNCTION__);
 
 	if (!bluetooth) {
-		dbg(__FUNCTION__ " - bad bluetooth pointer, exiting");
+		dbg("%s - bad bluetooth pointer, exiting", __FUNCTION__ );
 		return;
 	}
 
 	if (urb->status) {
-		dbg(__FUNCTION__ " - nonzero read bulk status received: %d", urb->status);
+		dbg("%s - nonzero read bulk status received: %d", __FUNCTION__ , urb->status);
 		return;
 	}
 }
@@ -885,27 +887,27 @@ static void bluetooth_read_bulk_callback
 	dbg(__FUNCTION__);
 
 	if (!bluetooth) {
-		dbg(__FUNCTION__ " - bad bluetooth pointer, exiting");
+		dbg("%s - bad bluetooth pointer, exiting", __FUNCTION__ );
 		return;
 	}
 
 	if (urb->status) {
-		dbg(__FUNCTION__ " - nonzero read bulk status received: %d", urb->status);
+		dbg("%s - nonzero read bulk status received: %d", __FUNCTION__ , urb->status);
 		if (urb->status == -ENOENT) {                   
-			dbg(__FUNCTION__ " - URB canceled, won't reschedule");
+			dbg(__FUNCTION__ "%s - URB canceled, won't reschedule", __FUNCTION__ );
 			return;
 		}
 		goto exit;
 	}
 
 	if (!count) {
-		dbg(__FUNCTION__ " - zero length read bulk");
+		dbg("%s - zero length read bulk", __FUNCTION__ );
 		goto exit;
 	}
 
 #ifdef DEBUG
 	if (count) {
-		printk (KERN_DEBUG __FILE__ ": " __FUNCTION__ "- length = %d, data = ", count);
+		printk (KERN_DEBUG "%s: %s - length = %d, data = ", __FILE__ , __FUNCTION__ , count);
 		for (i = 0; i < count; ++i) {
 			printk ("%.2x ", data[i]);
 		}
@@ -922,7 +924,7 @@ static void bluetooth_read_bulk_callback
 			      bluetooth_read_bulk_callback, bluetooth);
 		result = usb_submit_urb(bluetooth->read_urb, GFP_KERNEL);
 		if (result)
-			err (__FUNCTION__ " - failed resubmitting read urb, error %d", result);
+			err ("%s - failed resubmitting read urb, error %d", __FUNCTION__ , result);
 
 		return;
 	}
@@ -939,7 +941,7 @@ static void bluetooth_read_bulk_callback
 	}
 
 	if (bluetooth->bulk_packet_pos + count > ACL_BUFFER_SIZE) {
-		err(__FUNCTION__ " - exceeded ACL_BUFFER_SIZE");
+		err("%s - exceeded ACL_BUFFER_SIZE", __FUNCTION__ );
 		bluetooth->bulk_packet_pos = 0;
 		goto exit;
 	}
@@ -956,7 +958,7 @@ static void bluetooth_read_bulk_callback
 	}
 
 	if (packet_size + ACL_HDR_SIZE < bluetooth->bulk_packet_pos) {
-		err(__FUNCTION__ " - packet was too long");
+		err("%s - packet was too long", __FUNCTION__ );
 		bluetooth->bulk_packet_pos = 0;
 		goto exit;
 	}
@@ -983,7 +985,7 @@ exit:
 		      bluetooth_read_bulk_callback, bluetooth);
 	result = usb_submit_urb(bluetooth->read_urb, GFP_KERNEL);
 	if (result)
-		err (__FUNCTION__ " - failed resubmitting read urb, error %d", result);
+		err ("%s - failed resubmitting read urb, error %d", __FUNCTION__ , result);
 
 	return;
 }
@@ -996,12 +998,12 @@ static void bluetooth_write_bulk_callbac
 	dbg(__FUNCTION__);
 
 	if (!bluetooth) {
-		dbg(__FUNCTION__ " - bad bluetooth pointer, exiting");
+		dbg("%s - bad bluetooth pointer, exiting", __FUNCTION__ );
 		return;
 	}
 
 	if (urb->status) {
-		dbg(__FUNCTION__ " - nonzero write bulk status received: %d", urb->status);
+		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__ , urb->status);
 		return;
 	}
 
@@ -1025,7 +1027,7 @@ static void bluetooth_softint(void *priv
 
 	tty = bluetooth->tty;
 	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc.write_wakeup) {
-		dbg(__FUNCTION__ " - write wakeup call.");
+		dbg("%s - write wakeup call.", __FUNCTION__ );
 		(tty->ldisc.write_wakeup)(tty);
 	}
 
@@ -1087,7 +1089,7 @@ static void * usb_bluetooth_probe(struct
 	if ((num_bulk_in != 1) ||
 	    (num_bulk_out != 1) ||
 	    (num_interrupt_in != 1)) {
-		dbg (__FUNCTION__ " - improper number of endpoints. Bluetooth driver not bound.");
+		dbg ("%s - improper number of endpoints. Bluetooth driver not bound.", __FUNCTION__ );
 		return NULL;
 	}
 
@@ -1327,7 +1329,7 @@ int usb_bluetooth_init(void)
 	bluetooth_tty_driver.init_termios          = tty_std_termios;
 	bluetooth_tty_driver.init_termios.c_cflag  = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	if (tty_register_driver (&bluetooth_tty_driver)) {
-		err(__FUNCTION__ " - failed to register tty driver");
+		err("%s - failed to register tty driver", __FUNCTION__ );
 		return -1;
 	}
 
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/drivers/usb/misc/brlvger.c thunder-2.5/drivers/usb/misc/brlvger.c
--- linus-2.5/drivers/usb/misc/brlvger.c	Sat Aug 24 04:53:28 2002
+++ thunder-2.5/drivers/usb/misc/brlvger.c	Mon Aug 26 12:11:59 2002
@@ -208,9 +208,8 @@ static DECLARE_WAIT_QUEUE_HEAD(open_wait
 #define err(args...) \
     ({ printk(KERN_ERR "Voyager: " args); \
        printk("\n"); })
-#define dbgprint(args...) \
-    ({ printk(KERN_DEBUG "Voyager: " __FUNCTION__ ": " args); \
-       printk("\n"); })
+#define dbgprint(fmt,args...) \
+    printk(KERN_DEBUG "Voyager: %s: " fmt, __FUNCTION__ , ## args)
 #define dbg(args...) \
     ({ if(debug >= 1) dbgprint(args); })
 #define dbg2(args...) \
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/fs/jbd/revoke.c thunder-2.5/fs/jbd/revoke.c
--- linus-2.5/fs/jbd/revoke.c	Sat Aug 24 04:53:50 2002
+++ thunder-2.5/fs/jbd/revoke.c	Mon Aug 26 11:52:30 2002
@@ -135,7 +135,7 @@ repeat:
 oom:
 	if (!journal_oom_retry)
 		return -ENOMEM;
-	jbd_debug(1, "ENOMEM in " __FUNCTION__ ", retrying.\n");
+	jbd_debug(1, "ENOMEM in %s, retrying.\n", __FUNCTION__ );
 	yield();
 	goto repeat;
 }
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/net/ipv4/netfilter/ipt_ULOG.c thunder-2.5/net/ipv4/netfilter/ipt_ULOG.c
--- linus-2.5/net/ipv4/netfilter/ipt_ULOG.c	Sat Aug 24 04:55:36 2002
+++ thunder-2.5/net/ipv4/netfilter/ipt_ULOG.c	Mon Aug 26 11:54:35 2002
@@ -55,8 +55,7 @@ MODULE_LICENSE("GPL");
 #define ULOG_MAXNLGROUPS	32		/* numer of nlgroups */
 
 #if 0
-#define DEBUGP(format, args...)	printk(__FILE__ ":" __FUNCTION__ ":" \
-				       format, ## args)
+#define DEBUGP(format, args...)	printk("%s:%s:" format, __FILE__ , __FUNCTION__ , ## args)
 #else
 #define DEBUGP(format, args...)
 #endif
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/security/security.c thunder-2.5/security/security.c
--- linus-2.5/security/security.c	Sat Aug 24 04:55:45 2002
+++ thunder-2.5/security/security.c	Mon Aug 26 12:51:09 2002
@@ -52,7 +52,7 @@ static int inline verify (struct securit
 	/* verify the security_operations structure exists */
 	if (!ops) {
 		printk (KERN_INFO "Passed a NULL security_operations "
-			"pointer, " __FUNCTION__ " failed.\n");
+			"pointer, %s failed.\n", __FUNCTION__ );
 		return -EINVAL;
 	}
 
@@ -69,8 +69,8 @@ static int inline verify (struct securit
 
 	if (err) {
 		printk (KERN_INFO "Not enough functions specified in the "
-			"security_operation structure, " __FUNCTION__
-			" failed.\n");
+			"security_operation structure, %s failed.\n",
+			__FUNCTION__ );
 		return -EINVAL;
 	}
 	return 0;
@@ -108,13 +108,15 @@ int register_security (struct security_o
 {
 
 	if (verify (ops)) {
-		printk (KERN_INFO __FUNCTION__ " could not verify "
-			"security_operations structure.\n");
+		printk (KERN_INFO "%s could not verify "
+			"security_operations structure.\n",
+			__FUNCTION__ );
 		return -EINVAL;
 	}
 	if (security_ops != &dummy_security_ops) {
 		printk (KERN_INFO "There is already a security "
-			"framework initialized, " __FUNCTION__ " failed.\n");
+			"framework initialized, %s failed.\n",
+			__FUNCTION__ );
 		return -EINVAL;
 	}
 
@@ -137,9 +139,9 @@ int register_security (struct security_o
 int unregister_security (struct security_operations *ops)
 {
 	if (ops != security_ops) {
-		printk (KERN_INFO __FUNCTION__ ": trying to unregister "
+		printk (KERN_INFO "%s: trying to unregister "
 			"a security_opts structure that is not "
-			"registered, failing.\n");
+			"registered, failing.\n", __FUNCTION__ );
 		return -EINVAL;
 	}
 
@@ -163,14 +165,14 @@ int unregister_security (struct security
 int mod_reg_security (const char *name, struct security_operations *ops)
 {
 	if (verify (ops)) {
-		printk (KERN_INFO __FUNCTION__ " could not verify "
-			"security operations.\n");
+		printk (KERN_INFO "%s could not verify "
+			"security operations.\n", __FUNCTION__ );
 		return -EINVAL;
 	}
 
 	if (ops == security_ops) {
-		printk (KERN_INFO __FUNCTION__ " security operations "
-			"already registered.\n");
+		printk (KERN_INFO "%s security operations "
+			"already registered.\n", __FUNCTION__ );
 		return -EINVAL;
 	}
 
@@ -193,8 +195,8 @@ int mod_reg_security (const char *name, 
 int mod_unreg_security (const char *name, struct security_operations *ops)
 {
 	if (ops == security_ops) {
-		printk (KERN_INFO __FUNCTION__ " invalid attempt to unregister "
-			" primary security ops.\n");
+		printk (KERN_INFO "%s invalid attempt to unregister "
+			" primary security ops.\n", __FUNCTION__ );
 		return -EINVAL;
 	}
 

-- 
Lightweight Patch Manager, without pine.
If you have any objections (apart from who I am), tell me

