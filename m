Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287425AbSCGMVS>; Thu, 7 Mar 2002 07:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310292AbSCGMVH>; Thu, 7 Mar 2002 07:21:07 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:1924 "EHLO ns1.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S287425AbSCGMUv>;
	Thu, 7 Mar 2002 07:20:51 -0500
Date: Thu, 7 Mar 2002 04:20:19 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, lnz@dandelion.com, tech@psidisk.com,
        linux@advansys.com
Subject: Patch?: Untested advansys, pci2220i and BusLogic 2.5.6-pre3 scsi drivers, using my scsi.c changes
Message-ID: <20020307042019.A372@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	If anyone is feeling particularly brave or bored, here are
three untested SCSI drivers for linux-2.5.6-pre3 that I hope fix them
for the new DMA mapping requirements.

	These changes use a little facility that I have added to my scsi.c
that provides two flags, by which a scsi host driver can ask the
central scsi code take care of doing DMA mapping for scatter/gather
lists, DMA mapping of sense_buffer, or both.  I have included these
changes for hosts.h and scsi.[ch] in the patch.  I posted a patch
for this facility yesterday, but I have changed it slightly since
then to provide a mechanism by which scsi drivers see all requests
as gather/scatter list, even ones submitted with scsi_request->use_sg=0,
which should further simplify drivers.  This facility makes it a lot
easier to port to the new linux-2.5 DMA mapping requirements, and
makes the drivers smaller.  With approximately 90 scsi drivers,
I think it will make a big difference.

	Anyhow, I would appreciate it if anyone interested would
take a look at this patch or even try it, to help me spot any mistakes.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi.diff"

--- linux-2.5.6-pre3/drivers/scsi/hosts.h	Tue Feb 19 18:10:59 2002
+++ linux/drivers/scsi/hosts.h	Wed Mar  6 03:30:17 2002
@@ -286,6 +286,11 @@
 
     unsigned highmem_io:1;
 
+    /* Have the high level code automatically handle DMA mapping of
+       Scsi_Request->request_buffer and Scsi_Request->sense_buf. */
+    unsigned dma_map_request:1;
+    unsigned dma_map_sense:1;
+
     /*
      * Name of proc directory
      */
--- linux-2.5.6-pre3/drivers/scsi/scsi.h	Thu Mar  7 03:33:09 2002
+++ linux/drivers/scsi/scsi.h	Wed Mar  6 23:26:31 2002
@@ -449,8 +449,6 @@
  */
 void scsi_resize_dma_pool(void);
 int scsi_init_minimal_dma_pool(void);
-void *scsi_malloc(unsigned int);
-int scsi_free(void *, unsigned int);
 
 /*
  * Prototypes for functions in scsi_merge.c
@@ -734,6 +732,7 @@
 
 	struct timer_list eh_timeout;	/* Used to time out the command. */
 	void *request_buffer;		/* Actual requested buffer */
+	dma_addr_t request_dma_addr;
 
 	/* These elements define the operation we ultimately want to perform */
 	unsigned char data_cmnd[MAX_COMMAND_SIZE];
@@ -746,6 +745,11 @@
 	unsigned bufflen;	/* Size of data buffer */
 	void *buffer;		/* Data buffer */
 
+	struct scatterlist sg_single; /* Convenience value for sg for
+                                         a transfer of a single range. */
+	struct scatterlist *sg;
+	unsigned short sg_cnt;
+
 	unsigned underflow;	/* Return error if less than
 				   this amount is transferred */
 	unsigned old_underflow;	/* save underflow here when reusing the
@@ -768,6 +772,7 @@
 						 * when CHECK CONDITION is
 						 * received on original command 
 						 * (auto-sense) */
+	dma_addr_t sense_dma_addr;
 
 	unsigned flags;
 
@@ -791,11 +796,11 @@
 	Scsi_Pointer SCp;	/* Scratchpad used by some host adapters */
 
 	unsigned char *host_scribble;	/* The host adapter is allowed to
-					   * call scsi_malloc and get some memory
+					   * call kmalloc and get some memory
 					   * and hang it here.     The host adapter
-					   * is also expected to call scsi_free
+					   * is also expected to call kfree
 					   * to release this memory.  (The memory
-					   * obtained by scsi_malloc is guaranteed
+					   * obtained by kmalloc(...,GFP_DMA) is guaranteed
 					   * to be at an address < 16Mb). */
 
 	int result;		/* Status code from lower level driver */
--- linux-2.5.6-pre3/drivers/scsi/scsi.c	Thu Mar  7 03:33:09 2002
+++ linux/drivers/scsi/scsi.c	Wed Mar  6 23:26:40 2002
@@ -314,6 +314,61 @@
 	return SRpnt;
 }
 
+static inline void
+scsi_unmap_dma(Scsi_Cmnd *cmd)
+{
+	const Scsi_Host_Template *template = cmd->host->hostt;
+
+	if (template->dma_map_request) {
+        	int dma_cnt = cmd->use_sg ? cmd->use_sg : 1;
+		int dma_dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+                pci_unmap_sg(cmd->host->pci_dev, cmd->sg, dma_cnt, dma_dir);
+	}
+
+	if (template->dma_map_sense && cmd->sense_dma_addr)
+		pci_unmap_single(cmd->host->pci_dev,
+				 cmd->sense_dma_addr,
+				 sizeof(cmd->sense_buffer),
+				 PCI_DMA_FROMDEVICE);
+}
+
+static inline int
+scsi_map_dma(Scsi_Cmnd *cmd)
+{
+	const Scsi_Host_Template *template = cmd->host->hostt;
+
+        if (cmd->use_sg) {
+        	cmd->sg_cnt = cmd->use_sg;
+                cmd->sg = (struct scatterlist*) cmd->request_buffer;
+        } else {
+        	cmd->sg_cnt = 1;
+                cmd->sg = &cmd->sg_single;
+                cmd->sg_single.page = virt_to_page(cmd->request_buffer);
+                cmd->sg_single.offset =
+                	((unsigned long)cmd->request_buffer) & ~PAGE_MASK;
+                cmd->sg_single.length = cmd->request_bufflen;
+        }
+
+	if (template->dma_map_request) {
+		int dma_dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+                cmd->sg_cnt = pci_map_sg(cmd->host->pci_dev, cmd->sg,
+                                             cmd->sg_cnt, dma_dir);
+                if (cmd->sg_cnt <= 0)
+                	return -EBUSY;
+	}
+	if (template->dma_map_sense) {
+		cmd->sense_dma_addr = pci_map_single(cmd->host->pci_dev,
+						     cmd->sense_buffer,
+						     sizeof(cmd->sense_buffer),
+						     PCI_DMA_FROMDEVICE);
+		if (!cmd->sense_dma_addr) {
+			scsi_unmap_dma(cmd);
+			return -EBUSY;
+		}
+	}
+	return 0;
+}
+
 /*
  * Function:    scsi_release_request
  *
@@ -711,6 +766,7 @@
 		 * length exceeds what the host adapter can handle.
 		 */
 		if (CDB_SIZE(SCpnt) <= SCpnt->host->max_cmd_len) {
+			scsi_map_dma(SCpnt);
 			spin_lock_irqsave(host->host_lock, flags);
 			rtn = host->hostt->queuecommand(SCpnt, scsi_done);
 			spin_unlock_irqrestore(host->host_lock, flags);
@@ -1151,6 +1207,7 @@
 		SCSI_LOG_MLCOMPLETE(1, printk("Ignoring completion of %p due to timeout status", SCpnt));
 		return;
 	}
+	scsi_unmap_dma(SCpnt);
 	spin_lock_irqsave(&scsi_bhqueue_lock, flags);
 
 	SCpnt->serial_number_at_timeout = 0;
--- linux-2.5.6-pre3/drivers/scsi/advansys.h	Tue Feb 19 18:11:02 2002
+++ linux/drivers/scsi/advansys.h	Wed Mar  6 21:15:00 2002
@@ -119,6 +119,8 @@
      * by enabling clustering, I/O throughput increases as well. \
      */ \
     use_clustering:             ENABLE_CLUSTERING, \
+    dma_map_request:		1, \
+    dma_map_sense:		1, \
 }
 #endif
 #endif /* _ADVANSYS_H */
--- linux-2.5.6-pre3/drivers/scsi/advansys.c	Tue Feb 19 18:10:59 2002
+++ linux/drivers/scsi/advansys.c	Wed Mar  6 21:14:59 2002
@@ -752,8 +752,6 @@
 
 */
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 /*
  * --- Linux Version
  */
@@ -861,17 +859,6 @@
 #define ASC_DCNT  __u32         /* Unsigned Data count type. */
 #define ASC_SDCNT __s32         /* Signed Data count type. */
 
-/*
- * These macros are used to convert a virtual address to a
- * 32-bit value. This currently can be used on Linux Alpha
- * which uses 64-bit virtual address but a 32-bit bus address.
- * This is likely to break in the future, but doing this now
- * will give us time to change the HW and FW to handle 64-bit
- * addresses.
- */
-#define ASC_VADDR_TO_U32   virt_to_bus
-#define ASC_U32_TO_VADDR   bus_to_virt
-
 typedef unsigned char uchar;
 
 #ifndef NULL
@@ -1314,6 +1301,9 @@
     uchar               extra_bytes;
     uchar               res;
     ASC_DCNT            remain_bytes;
+
+    /* Everything below this line is not used by hardware.  */
+    Scsi_Cmnd		*scp;
 } ASC_QDONE_INFO;
 
 typedef struct asc_sg_list {
@@ -1351,6 +1341,8 @@
     ushort              next_sg_index;
 } ASC_SCSI_Q;
 
+struct adv_req;
+
 typedef struct asc_scsi_req_q {
     ASC_SCSIQ_1         r1;
     ASC_SCSIQ_2         r2;
@@ -1574,6 +1566,7 @@
     ushort              mcode_version;
     uchar               max_tag_qng[ASC_MAX_TID + 1];
     uchar               *overrun_buf;
+    dma_addr_t          overrun_dma;
     uchar               sdtr_period_offset[ASC_MAX_TID + 1];
     ushort              pci_slot_info;
     uchar               adapter_info[6];
@@ -2143,17 +2136,6 @@
 #define ADV_DCNT  __u32         /* Unsigned Data count type. */
 #define ADV_SDCNT __s32         /* Signed Data count type. */
 
-/*
- * These macros are used to convert a virtual address to a
- * 32-bit value. This currently can be used on Linux Alpha
- * which uses 64-bit virtual address but a 32-bit bus address.
- * This is likely to break in the future, but doing this now
- * will give us time to change the HW and FW to handle 64-bit
- * addresses.
- */
-#define ADV_VADDR_TO_U32   virt_to_bus
-#define ADV_U32_TO_VADDR   bus_to_virt
-
 #define AdvPortAddr  ulong              /* Virtual memory address size */
 
 /*
@@ -3196,7 +3178,8 @@
      * End of microcode structure - 60 bytes. The rest of the structure
      * is used by the Adv Library and ignored by the microcode.
      */
-    ADV_VADDR   srb_ptr;
+
+    struct adv_req	*reqp;
     ADV_SG_BLOCK *sg_list_ptr; /* SG list virtual address. */
     char        *vdata_addr;   /* Data buffer virtual address. */
     uchar       a_flag;
@@ -3249,8 +3232,6 @@
 STATIC void  DvcSleepMilliSecond(ADV_DCNT);
 STATIC uchar DvcAdvReadPCIConfigByte(ADV_DVC_VAR *, ushort);
 STATIC void  DvcAdvWritePCIConfigByte(ADV_DVC_VAR *, ushort, uchar);
-STATIC ADV_PADDR DvcGetPhyAddr(ADV_DVC_VAR *, ADV_SCSI_REQ_Q *,
-                uchar *, ASC_SDCNT *, int);
 STATIC void  DvcDelayMicroSecond(ADV_DVC_VAR *, ushort);
 
 /*
@@ -3464,16 +3445,6 @@
 extern ADVEEP_38C0800_CONFIG Default_38C0800_EEPROM_Config;
 extern ADVEEP_38C1600_CONFIG Default_38C1600_EEPROM_Config;
 
-/*
- * DvcGetPhyAddr() flag arguments
- */
-#define ADV_IS_SCSIQ_FLAG       0x01 /* 'addr' is ASC_SCSI_REQ_Q pointer */
-#define ADV_ASCGETSGLIST_VADDR  0x02 /* 'addr' is AscGetSGList() virtual addr */
-#define ADV_IS_SENSE_FLAG       0x04 /* 'addr' is sense virtual pointer */
-#define ADV_IS_DATA_FLAG        0x08 /* 'addr' is data virtual pointer */
-#define ADV_IS_SGLIST_FLAG      0x10 /* 'addr' is sglist virtual pointer */
-#define ADV_IS_CARRIER_FLAG     0x20 /* 'addr' is ADV_CARR_T pointer */
-
 /* Return the address that is aligned at the next doubleword >= to 'addr'. */
 #define ADV_8BALIGN(addr)      (((ulong) (addr) + 0x7) & ~0x7)
 #define ADV_16BALIGN(addr)     (((ulong) (addr) + 0xF) & ~0xF)
@@ -4097,7 +4068,10 @@
     void                 *ioremap_addr;         /* I/O Memory remap address. */
     ushort               ioport;                /* I/O Port address. */
     ADV_CARR_T           *orig_carrp;           /* ADV_CARR_T memory block. */
+    dma_addr_t		 carrp_dma;
     adv_req_t            *orig_reqp;            /* adv_req_t memory block. */
+    dma_addr_t		 reqp_dma;
+    size_t		 reqp_size;
     adv_req_t            *adv_reqp;             /* Request structures. */
     adv_sgblk_t          *adv_sgblkp;           /* Scatter-gather structures. */
     ushort               bios_signature;        /* BIOS Signature. */
@@ -4179,9 +4153,6 @@
 STATIC int asc_board_count = 0;
 STATIC struct Scsi_Host    *asc_host[ASC_NUM_BOARD_SUPPORTED] = { 0 };
 
-/* Overrun buffer used by all narrow boards. */
-STATIC uchar overrun_buf[ASC_OVERRUN_BSIZE] = { 0 };
-
 /*
  * Global structures required to issue a command.
  */
@@ -4196,6 +4167,18 @@
     ASC_IS_PCI,
 };
 
+#if LINUX_VERSION_CODE >= ASC_LINUX_VERSION(2,4,0) && defined(MODULE)
+static struct pci_device_id advansys_pci_tbl[] __initdata = {
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_1100, PCI_ANY_ID, PCI_ANY_ID },
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_1200, PCI_ANY_ID, PCI_ANY_ID },
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_1300, PCI_ANY_ID, PCI_ANY_ID },
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_2300, PCI_ANY_ID, PCI_ANY_ID },
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_2500, PCI_ANY_ID, PCI_ANY_ID },
+    { }				/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, advansys_pci_tbl);
+#endif
+
 /*
  * Used with the LILO 'advansys' option to eliminate or
  * limit I/O port probing at boot time, cf. advansys_setup().
@@ -4281,6 +4264,26 @@
 STATIC void         asc_prt_hex(char *f, uchar *, int);
 #endif /* ADVANSYS_DEBUG */
 
+static inline __u32
+ptr_to_dma32le(dma_addr_t dma_base, void *ptr_base, void *ptr)
+{
+	return cpu_to_le32(dma_base + (ptr - ptr_base));
+}
+
+static inline void *
+dma32le_to_ptr(dma_addr_t dma_base, void *ptr_base, __u32 dma_le32)
+{
+	return ptr_base + (le32_to_cpu(dma_le32) - dma_base);
+}
+
+static inline ADV_CARR_T *
+dma_to_carrp(ADV_DVC_VAR *var, __u32 dma_le32)
+{
+	struct asc_board *boardp = var->drv_ptr;
+	return dma32le_to_ptr(boardp->carrp_dma, boardp->orig_carrp, dma_le32);
+}
+
+
 
 /*
  * --- Linux 'Scsi_Host_Template' and advansys_setup() Functions
@@ -4727,7 +4730,9 @@
                             pci_device_id_cnt++;
                         } else {
 #if ASC_LINUX_KERNEL24
-                            if (pci_enable_device(pci_devp) == 0) {
+                            if (pci_enable_device(pci_devp) == 0 &&
+				/* Board is limited to 32 bit DMA addresses: */
+				pci_set_dma_mask(pci_devp, 0xffffffff) == 0) {
                                 pci_devicep[pci_card_cnt_max++] = pci_devp;
                             }
 #elif ASC_LINUX_KERNEL22
@@ -4847,7 +4852,9 @@
                 asc_dvc_varp->bus_type = asc_bus[bus];
                 asc_dvc_varp->drv_ptr = boardp;
                 asc_dvc_varp->cfg = &boardp->dvc_cfg.asc_dvc_cfg;
-                asc_dvc_varp->cfg->overrun_buf = &overrun_buf[0];
+                asc_dvc_varp->cfg->overrun_buf =
+			pci_alloc_consistent(pci_devp, ASC_OVERRUN_BSIZE,
+					     &asc_dvc_varp->cfg->overrun_dma);
                 asc_dvc_varp->iop_base = iop;
                 asc_dvc_varp->isr_callback = asc_isr_callback;
             } else {
@@ -5489,10 +5496,10 @@
             */
             if (((ret = request_irq(shp->irq, advansys_interrupt,
                             SA_INTERRUPT | (share_irq == TRUE ? SA_SHIRQ : 0),
-                            "advansys", boardp)) != 0) &&
+                            "advansys", shp)) != 0) &&
                 ((ret = request_irq(shp->irq, advansys_interrupt,
                             (share_irq == TRUE ? SA_SHIRQ : 0),
-                            "advansys", boardp)) != 0))
+                            "advansys", shp)) != 0))
             {
                 if (ret == -EBUSY) {
                     ASC_PRINT2(
@@ -5544,8 +5551,9 @@
                  * Allocate buffer carrier structures. The total size
                  * is about 4 KB, so allocate all at once.
                  */
-                carrp =
-                    (ADV_CARR_T *) kmalloc(ADV_CARRIER_BUFSIZE, GFP_ATOMIC);
+		carrp = pci_alloc_consistent(pci_devp, ADV_CARRIER_BUFSIZE,
+					     &boardp->carrp_dma);
+
                 ASC_DBG1(1, "advansys_detect: carrp 0x%lx\n", (ulong) carrp);
 
                 if (carrp == NULL) {
@@ -5561,8 +5569,10 @@
                 for (req_cnt = adv_dvc_varp->max_host_qng;
                     req_cnt > 0; req_cnt--) {
 
-                    reqp = (adv_req_t *)
-                        kmalloc(sizeof(adv_req_t) * req_cnt, GFP_ATOMIC);
+		    boardp->reqp_size = sizeof(adv_req_t) * req_cnt;
+		    reqp = pci_alloc_consistent(pci_devp,
+						boardp->reqp_size,
+						&boardp->reqp_dma);
 
                     ASC_DBG3(1,
                         "advansys_detect: reqp 0x%lx, req_cnt %d, bytes %lu\n",
@@ -5614,14 +5624,23 @@
                         boardp->id);
                     err_code = ADV_ERROR;
                 } else if (reqp == NULL) {
-                    kfree(carrp);
+		    pci_free_consistent(shp->pci_dev,
+				    ADV_CARRIER_BUFSIZE,
+				    carrp,
+				    boardp->carrp_dma);
                     ASC_PRINT1(
 "advansys_detect: board %d error: failed to kmalloc() adv_req_t buffer.\n",
                         boardp->id);
                     err_code = ADV_ERROR;
                 } else if (boardp->adv_sgblkp == NULL) {
-                    kfree(carrp);
-                    kfree(reqp);
+		    pci_free_consistent(shp->pci_dev,
+				    ADV_CARRIER_BUFSIZE,
+				    carrp,
+				    boardp->carrp_dma);
+		    pci_free_consistent(shp->pci_dev,
+				    boardp->reqp_size,
+				    reqp,
+				    boardp->reqp_dma);
                     ASC_PRINT1(
 "advansys_detect: board %d error: failed to kmalloc() adv_sgblk_t buffers.\n",
                         boardp->id);
@@ -5679,11 +5698,17 @@
                 if (ASC_WIDE_BOARD(boardp)) {
                     iounmap(boardp->ioremap_addr);
                     if (boardp->orig_carrp) {
-                        kfree(boardp->orig_carrp);
-                        boardp->orig_carrp = NULL;
+		        pci_free_consistent(shp->pci_dev,
+					ADV_CARRIER_BUFSIZE,
+					boardp->orig_carrp,
+					boardp->carrp_dma);
+		        boardp->orig_carrp = NULL;
                     }
                     if (boardp->orig_reqp) {
-                        kfree(boardp->orig_reqp);
+		        pci_free_consistent(shp->pci_dev,
+					boardp->reqp_size,
+					boardp->orig_reqp,
+					boardp->reqp_dma);
                         boardp->orig_reqp = boardp->adv_reqp = NULL;
                     }
                     while ((sgp = boardp->adv_sgblkp) != NULL)
@@ -5734,11 +5759,15 @@
 
         iounmap(boardp->ioremap_addr);
         if (boardp->orig_carrp) {
-            kfree(boardp->orig_carrp);
+	    pci_free_consistent(shp->pci_dev, ADV_CARRIER_BUFSIZE,
+				boardp->orig_carrp, boardp->carrp_dma);
             boardp->orig_carrp = NULL;
         }
         if (boardp->orig_reqp) {
-            kfree(boardp->orig_reqp);
+	    pci_free_consistent(shp->pci_dev,
+				boardp->reqp_size,
+				boardp->orig_reqp,
+				boardp->reqp_dma);
             boardp->orig_reqp = boardp->adv_reqp = NULL;
         }
         while ((sgp = boardp->adv_sgblkp) != NULL)
@@ -5746,12 +5775,18 @@
             boardp->adv_sgblkp = sgp->next_sgblkp;
             kfree(sgp);
         }
+    } else {
+        ASC_DVC_CFG    *cfg = boardp->dvc_var.asc_dvc_var.cfg;
+	pci_free_consistent(shp->pci_dev, ASC_OVERRUN_BSIZE,
+			    cfg->overrun_buf, cfg->overrun_dma);
     }
+
 #ifdef CONFIG_PROC_FS
     ASC_ASSERT(boardp->prtbuf != NULL);
     kfree(boardp->prtbuf);
 #endif /* CONFIG_PROC_FS */
     scsi_unregister(shp);
+    
     ASC_DBG(1, "advansys_release: end\n");
     return 0;
 }
@@ -5872,7 +5907,7 @@
 
     /* host_lock taken by mid-level prior to call but need to protect */
     /* against own ISR */
-    spin_lock_irqsave(boardp->lock, flags);
+    spin_lock_irqsave(&boardp->lock, flags);
 
     /*
      * Block new commands while handling a reset or abort request.
@@ -6270,26 +6305,16 @@
 STATIC void
 advansys_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-    ulong           flags;
-    int             i;
-    asc_board_t     *boardp;
-    Scsi_Cmnd       *done_scp = NULL, *last_scp = NULL;
-    Scsi_Cmnd       *new_last_scp;
-    struct Scsi_Host *shp;
+	ulong           flags;
+	Scsi_Cmnd       *done_scp = NULL;
+	struct Scsi_Host *shp = dev_id;
+	asc_board_t     *boardp = ASC_BOARDP(shp);
 
-    ASC_DBG(1, "advansys_interrupt: begin\n");
+	ASC_DBG(1, "advansys_interrupt: begin\n");
+	ASC_DBG1(2, "advansys_interrupt: boardp 0x%lx\n", (ulong) boardp);
 
-    /*
-     * Check for interrupts on all boards.
-     * AscISR() will call asc_isr_callback().
-     */
-    for (i = 0; i < asc_board_count; i++) {
-	shp = asc_host[i];
-        boardp = ASC_BOARDP(shp);
-        ASC_DBG2(2, "advansys_interrupt: i %d, boardp 0x%lx\n",
-            i, (ulong) boardp);
-        spin_lock_irqsave(&boardp->lock, flags);
-        if (ASC_NARROW_BOARD(boardp)) {
+	spin_lock_irqsave(&boardp->lock, flags);
+	if (ASC_NARROW_BOARD(boardp)) {
             /*
              * Narrow Board
              */
@@ -6298,7 +6323,7 @@
                 ASC_DBG(1, "advansys_interrupt: before AscISR()\n");
                 AscISR(&boardp->dvc_var.asc_dvc_var);
             }
-        } else {
+	} else {
             /*
              * Wide Board
              */
@@ -6306,7 +6331,7 @@
             if (AdvISR(&boardp->dvc_var.adv_dvc_var)) {
                 ASC_STATS(shp, interrupt);
             }
-        }
+	}
 
         /*
          * Start waiting requests and create a list of completed requests.
@@ -6315,8 +6340,6 @@
          * handler will complete pending requests after it has completed.
          */
         if ((boardp->flags & ASC_HOST_IN_RESET) == 0) {
-            ASC_DBG2(1, "advansys_interrupt: done_scp 0x%lx, last_scp 0x%lx\n",
-                (ulong) done_scp, (ulong) last_scp);
 
             /* Start any waiting commands for the board. */
             if (!ASC_QUEUE_EMPTY(&boardp->waiting)) {
@@ -6326,38 +6349,21 @@
 
              /*
               * Add to the list of requests that must be completed.
-              *
-              * 'done_scp' will always be NULL on the first iteration
-              * of this loop. 'last_scp' is set at the same time as
-              * 'done_scp'.
               */
-            if (done_scp == NULL) {
-                done_scp = asc_dequeue_list(&boardp->done, &last_scp,
-                    ASC_TID_ALL);
-            } else {
-                ASC_ASSERT(last_scp != NULL);
-                REQPNEXT(last_scp) = asc_dequeue_list(&boardp->done,
-                    &new_last_scp, ASC_TID_ALL);
-                if (new_last_scp != NULL) {
-                    ASC_ASSERT(REQPNEXT(last_scp) != NULL);
-                    last_scp = new_last_scp;
-                }
-            }
+	    done_scp = asc_dequeue_list(&boardp->done, NULL, ASC_TID_ALL);
         }
         spin_unlock_irqrestore(&boardp->lock, flags);
-    }
 
-    /*
-     * If interrupts were enabled on entry, then they
-     * are now enabled here.
-     *
-     * Complete all requests on the done list.
-     */
+	/*
+	 * If interrupts were enabled on entry, then they
+	 * are now enabled here.
+	 *
+	 * Complete all requests on the done list.
+	 */
 
-    asc_scsi_done_list(done_scp, 1);
+	asc_scsi_done_list(done_scp, 1);
 
-    ASC_DBG(1, "advansys_interrupt: end\n");
-    return;
+	ASC_DBG(1, "advansys_interrupt: end\n");
 }
 
 /*
@@ -6655,7 +6661,7 @@
     /*
      * Point the ASC_SCSI_Q to the 'Scsi_Cmnd'.
      */
-    asc_scsi_q.q2.srb_ptr = ASC_VADDR_TO_U32(scp);
+    asc_scsi_q.q2.srb_ptr = (u32) scp;
 
     /*
      * Build the ASC_SCSI_Q request.
@@ -6676,7 +6682,7 @@
     asc_scsi_q.q1.target_id = ASC_TID_TO_TARGET_ID(scp->target);
     asc_scsi_q.q1.target_lun = scp->lun;
     asc_scsi_q.q2.target_ix = ASC_TIDLUN_TO_IX(scp->target, scp->lun);
-    asc_scsi_q.q1.sense_addr = cpu_to_le32(virt_to_bus(&scp->sense_buffer[0]));
+    asc_scsi_q.q1.sense_addr = cpu_to_le32(scp->sense_dma_addr);
     asc_scsi_q.q1.sense_len = sizeof(scp->sense_buffer);
 
     /*
@@ -6701,29 +6707,17 @@
      * Build ASC_SCSI_Q for a contiguous buffer or a scatter-gather
      * buffer command.
      */
-    if (scp->use_sg == 0) {
-        /*
-         * CDB request of single contiguous buffer.
-         */
-        ASC_STATS(scp->host, cont_cnt);
-        asc_scsi_q.q1.data_addr =
-            cpu_to_le32(virt_to_bus(scp->request_buffer));
-        asc_scsi_q.q1.data_cnt = cpu_to_le32(scp->request_bufflen);
-        ASC_STATS_ADD(scp->host, cont_xfer,
-                      ASC_CEILING(scp->request_bufflen, 512));
-        asc_scsi_q.q1.sg_queue_cnt = 0;
-        asc_scsi_q.sg_head = NULL;
-    } else {
+    {
         /*
          * CDB scatter-gather request list.
          */
         int                     sgcnt;
         struct scatterlist      *slp;
 
-        if (scp->use_sg > scp->host->sg_tablesize) {
+        if (scp->sg_cnt > scp->host->sg_tablesize) {
             ASC_PRINT3(
-"asc_build_req: board %d: use_sg %d > sg_tablesize %d\n",
-                boardp->id, scp->use_sg, scp->host->sg_tablesize);
+"asc_build_req: board %d: sg_cnt %d > sg_tablesize %d\n",
+                boardp->id, scp->sg_cnt, scp->host->sg_tablesize);
             scp->result = HOST_BYTE(DID_ERROR);
             asc_enqueue(&boardp->done, scp, ASC_BACK);
             return ASC_ERROR;
@@ -6742,20 +6736,18 @@
         asc_scsi_q.q1.data_cnt = 0;
         asc_scsi_q.q1.data_addr = 0;
         /* This is a byte value, otherwise it would need to be swapped. */
-        asc_sg_head.entry_cnt = asc_scsi_q.q1.sg_queue_cnt = scp->use_sg;
+        asc_sg_head.entry_cnt = asc_scsi_q.q1.sg_queue_cnt = scp->sg_cnt;
         ASC_STATS_ADD(scp->host, sg_elem, asc_sg_head.entry_cnt);
 
         /*
          * Convert scatter-gather list into ASC_SG_HEAD list.
          */
-        slp = (struct scatterlist *) scp->request_buffer;
-        for (sgcnt = 0; sgcnt < scp->use_sg; sgcnt++, slp++) {
-            asc_sg_head.sg_list[sgcnt].addr =
-                cpu_to_le32(virt_to_bus(slp->address ? 
-		(unsigned char *)slp->address :
-		(unsigned char *)page_address(slp->page) + slp->offset));
-            asc_sg_head.sg_list[sgcnt].bytes = cpu_to_le32(slp->length);
-            ASC_STATS_ADD(scp->host, sg_xfer, ASC_CEILING(slp->length, 512));
+        slp = scp->sg;
+        for (sgcnt = 0; sgcnt < scp->sg_cnt; sgcnt++, slp++) {
+	    asc_sg_head.sg_list[sgcnt].addr = cpu_to_le32(sg_dma_address(slp));
+            asc_sg_head.sg_list[sgcnt].bytes = cpu_to_le32(sg_dma_len(slp));
+            ASC_STATS_ADD(scp->host, sg_xfer,
+			  ASC_CEILING(asc_sg_head.sg_list[sgcnt].bytes, 512));
         }
     }
 
@@ -6811,7 +6803,7 @@
     /*
      * Set the ADV_SCSI_REQ_Q 'srb_ptr' to point to the adv_req_t structure.
      */
-    scsiqp->srb_ptr = ASC_VADDR_TO_U32(reqp);
+    scsiqp->reqp = reqp;
 
     /*
      * Set the adv_req_t 'cmndp' to point to the Scsi_Cmnd structure.
@@ -6848,35 +6840,27 @@
     scsiqp->target_id = scp->target;
     scsiqp->target_lun = scp->lun;
 
-    scsiqp->sense_addr = cpu_to_le32(virt_to_bus(&scp->sense_buffer[0]));
+    scsiqp->sense_addr = cpu_to_le32(scp->sense_dma_addr);
     scsiqp->sense_len = sizeof(scp->sense_buffer);
 
     /*
      * Build ADV_SCSI_REQ_Q for a contiguous buffer or a scatter-gather
      * buffer command.
      */
-    scsiqp->data_cnt = cpu_to_le32(scp->request_bufflen);
-    scsiqp->vdata_addr = scp->request_buffer;
-    scsiqp->data_addr = cpu_to_le32(virt_to_bus(scp->request_buffer));
+    scsiqp->data_cnt = cpu_to_le32(scp->sg_cnt);
 
-    if (scp->use_sg == 0) {
-        /*
-         * CDB request of single contiguous buffer.
-         */
-        reqp->sgblkp = NULL;
-        scsiqp->sg_list_ptr = NULL;
-        scsiqp->sg_real_addr = 0;
-        ASC_STATS(scp->host, cont_cnt);
-        ASC_STATS_ADD(scp->host, cont_xfer,
-                      ASC_CEILING(scp->request_bufflen, 512));
-    } else {
+    /* FIXME.  Are scsiqp->data_{,v}addr used? */
+    /* scsiqp->vdata_addr = virtual address pointed to by scp->sg[0] */
+    scsiqp->data_addr = cpu_to_le32(sg_dma_address(&scp->sg[0]));
+
+    {
         /*
          * CDB scatter-gather request list.
          */
-        if (scp->use_sg > ADV_MAX_SG_LIST) {
+        if (scp->sg_cnt > ADV_MAX_SG_LIST) {
             ASC_PRINT3(
-"adv_build_req: board %d: use_sg %d > ADV_MAX_SG_LIST %d\n",
-                boardp->id, scp->use_sg, scp->host->sg_tablesize);
+"adv_build_req: board %d: sg_cnt %d > ADV_MAX_SG_LIST %d\n",
+                boardp->id, scp->sg_cnt, scp->host->sg_tablesize);
             scp->result = HOST_BYTE(DID_ERROR);
             asc_enqueue(&boardp->done, scp, ASC_BACK);
 
@@ -6902,7 +6886,7 @@
         }
 
         ASC_STATS(scp->host, sg_cnt);
-        ASC_STATS_ADD(scp->host, sg_elem, scp->use_sg);
+        ASC_STATS_ADD(scp->host, sg_elem, scp->sg_cnt);
     }
 
     ASC_DBG_PRT_ADV_SCSI_REQ_Q(2, scsiqp);
@@ -6933,12 +6917,12 @@
     struct scatterlist  *slp;
     int                 sg_elem_cnt;
     ADV_SG_BLOCK        *sg_block, *prev_sg_block;
-    ADV_PADDR           sg_block_paddr;
+    dma_addr_t          sg_block_paddr;
     int                 i;
 
     scsiqp = (ADV_SCSI_REQ_Q *) ADV_32BALIGN(&reqp->scsi_req_q);
-    slp = (struct scatterlist *) scp->request_buffer;
-    sg_elem_cnt = scp->use_sg;
+    slp = scp->sg;
+    sg_elem_cnt = scp->sg_cnt;
     prev_sg_block = NULL;
     reqp->sgblkp = NULL;
 
@@ -6977,7 +6961,10 @@
              * the allocated ADV_SG_BLOCK structure.
              */
             sg_block = (ADV_SG_BLOCK *) ADV_8BALIGN(&sgblkp->sg_block);
-            sg_block_paddr = virt_to_bus(sg_block);
+	    sg_block_paddr =
+	    	pci_map_single(scp->host->pci_dev, sg_block,
+			       NO_OF_SG_PER_BLOCK * sizeof(ADV_SG_BLOCK), /*?*/
+			       PCI_DMA_BIDIRECTIONAL); /* PCI_DMA_TODEVICE? */
 
             /*
              * Check if this is the first 'adv_sgblk_t' for the request.
@@ -7010,11 +6997,8 @@
 
         for (i = 0; i < NO_OF_SG_PER_BLOCK; i++)
         {
-            sg_block->sg_list[i].sg_addr =
-                cpu_to_le32(virt_to_bus(slp->address ? 
-		(unsigned char *)slp->address :
-                (unsigned char *)page_address(slp->page) + slp->offset));
-            sg_block->sg_list[i].sg_count = cpu_to_le32(slp->length);
+	    sg_block->sg_list[i].sg_addr = cpu_to_le32(sg_dma_address(slp));
+            sg_block->sg_list[i].sg_count = cpu_to_le32(sg_dma_len(slp));
             ASC_STATS_ADD(scp->host, sg_xfer, ASC_CEILING(slp->length, 512));
 
             if (--sg_elem_cnt == 0)
@@ -7053,7 +7037,7 @@
      * Get the Scsi_Cmnd structure and Scsi_Host structure for the
      * command that has been completed.
      */
-    scp = (Scsi_Cmnd *) ASC_U32_TO_VADDR(qdonep->d2.srb_ptr);
+    scp = qdonep->scp;
     ASC_DBG1(1, "asc_isr_callback: scp 0x%lx\n", (ulong) scp);
 
     if (scp == NULL) {
@@ -7228,7 +7212,7 @@
      * completed. The adv_req_t structure actually contains the
      * completed ADV_SCSI_REQ_Q structure.
      */
-    reqp = (adv_req_t *) ADV_U32_TO_VADDR(scsiqp->srb_ptr);
+    reqp = scsiqp->reqp;
     ASC_DBG1(1, "adv_isr_callback: reqp 0x%lx\n", (ulong) reqp);
     if (reqp == NULL) {
         ASC_PRINT("adv_isr_callback: reqp is NULL\n");
@@ -9146,32 +9130,6 @@
  */
 
 /*
- * DvcGetPhyAddr()
- *
- * Return the physical address of 'vaddr' and set '*lenp' to the
- * number of physically contiguous bytes that follow 'vaddr'.
- * 'flag' indicates the type of structure whose physical address
- * is being translated.
- *
- * Note: Because Linux currently doesn't page the kernel and all
- * kernel buffers are physically contiguous, leave '*lenp' unchanged.
- */
-ADV_PADDR
-DvcGetPhyAddr(ADV_DVC_VAR *asc_dvc, ADV_SCSI_REQ_Q *scsiq,
-        uchar *vaddr, ADV_SDCNT *lenp, int flag)
-{
-    ADV_PADDR           paddr;
-
-    paddr = virt_to_bus(vaddr);
-
-    ASC_DBG4(4,
-        "DvcGetPhyAddr: vaddr 0x%lx, lenp 0x%lx *lenp %lu, paddr 0x%lx\n",
-        (ulong) vaddr, (ulong) lenp, (ulong) *((ulong *) lenp), (ulong) paddr);
-
-    return paddr;
-}
-
-/*
  * Read a PCI configuration byte.
  */
 ASC_INITFUNC(
@@ -10500,9 +10458,11 @@
          */
         /* Read request's SRB pointer. */
         scsiq = (ASC_SCSI_Q *)
-           ASC_SRB2SCSIQ(
-               ASC_U32_TO_VADDR(AscReadLramDWord(iop_base,
-               (ushort) (q_addr + ASC_SCSIQ_D_SRBPTR))));
+	    dma32le_to_ptr(asc_dvc->drv_ptr->reqp_dma,
+			   asc_dvc->drv_ptr->orig_reqp,
+			   AscReadLramDWord(iop_base,
+					    (ushort)
+					    (q_addr + ASC_SCSIQ_D_SRBPTR)));
 
         /*
          * Get request's first and working SG queue.
@@ -12764,8 +12724,7 @@
                      ASC_TID_TO_TARGET_ID(asc_dvc->cfg->chip_scsi_id));
 
     /* Align overrun buffer on an 8 byte boundary. */
-    phy_addr = virt_to_bus(asc_dvc->cfg->overrun_buf);
-    phy_addr = cpu_to_le32((phy_addr + 7) & ~0x7);
+    phy_addr = cpu_to_le32((asc_dvc->cfg->overrun_dma + 7) & ~0x7);
     AscMemDWordCopyPtrToLram(iop_base, ASCV_OVERRUN_PADDR_D,
         (uchar *) &phy_addr, 1);
     phy_size = cpu_to_le32(ASC_OVERRUN_BSIZE - 8);
@@ -15465,8 +15424,9 @@
          * Get physical address of the carrier 'carrp'.
          */
         contig_len = sizeof(ADV_CARR_T);
-        carr_paddr = cpu_to_le32(DvcGetPhyAddr(asc_dvc, NULL, (uchar *) carrp,
-            (ADV_SDCNT *) &contig_len, ADV_IS_CARRIER_FLAG));
+        carr_paddr = ptr_to_dma32le(asc_dvc->drv_ptr->carrp_dma,
+				    asc_dvc->drv_ptr->orig_carrp,
+				    carrp);
 
         buf_size -= sizeof(ADV_CARR_T);
 
@@ -15482,12 +15442,14 @@
         }
 
         carrp->carr_pa = carr_paddr;
-        carrp->carr_va = cpu_to_le32(ADV_VADDR_TO_U32(carrp));
+        carrp->carr_va = cpu_to_le32((__u32) carrp);
 
         /*
          * Insert the carrier at the beginning of the freelist.
          */
-        carrp->next_vpa = cpu_to_le32(ADV_VADDR_TO_U32(asc_dvc->carr_freelist));
+        carrp->next_vpa = ptr_to_dma32le(asc_dvc->drv_ptr->carrp_dma,
+					 asc_dvc->drv_ptr->orig_carrp,
+					 asc_dvc->carr_freelist);
         asc_dvc->carr_freelist = carrp;
 
         carrp++;
@@ -15503,8 +15465,7 @@
         asc_dvc->err_code |= ASC_IERR_NO_CARRIER;
         return ADV_ERROR;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-        ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->icq_sp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, asc_dvc->icq_sp->next_vpa);
 
     /*
      * The first command issued will be placed in the stopper carrier.
@@ -15524,8 +15485,7 @@
         asc_dvc->err_code |= ASC_IERR_NO_CARRIER;
         return ADV_ERROR;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-         ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->irq_sp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, asc_dvc->irq_sp->next_vpa);
 
     /*
      * The first command completed by the RISC will be placed in
@@ -16087,8 +16047,9 @@
          * Get physical address for the carrier 'carrp'.
          */
         contig_len = sizeof(ADV_CARR_T);
-        carr_paddr = cpu_to_le32(DvcGetPhyAddr(asc_dvc, NULL, (uchar *) carrp,
-            (ADV_SDCNT *) &contig_len, ADV_IS_CARRIER_FLAG));
+        carr_paddr = ptr_to_dma32le(asc_dvc->drv_ptr->carrp_dma,
+				    asc_dvc->drv_ptr->orig_carrp,
+				    carrp);
 
         buf_size -= sizeof(ADV_CARR_T);
 
@@ -16104,12 +16065,14 @@
         }
 
         carrp->carr_pa = carr_paddr;
-        carrp->carr_va = cpu_to_le32(ADV_VADDR_TO_U32(carrp));
+        carrp->carr_va = cpu_to_le32((__u32) carrp);
 
         /*
          * Insert the carrier at the beginning of the freelist.
          */
-        carrp->next_vpa = cpu_to_le32(ADV_VADDR_TO_U32(asc_dvc->carr_freelist));
+        carrp->next_vpa = ptr_to_dma32le(asc_dvc->drv_ptr->carrp_dma,
+					 asc_dvc->drv_ptr->orig_carrp,
+					 asc_dvc->carr_freelist);
         asc_dvc->carr_freelist = carrp;
 
         carrp++;
@@ -16125,8 +16088,7 @@
         asc_dvc->err_code |= ASC_IERR_NO_CARRIER;
         return ADV_ERROR;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-        ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->icq_sp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, asc_dvc->icq_sp->next_vpa);
 
     /*
      * The first command issued will be placed in the stopper carrier.
@@ -16147,8 +16109,7 @@
         asc_dvc->err_code |= ASC_IERR_NO_CARRIER;
         return ADV_ERROR;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-        ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->irq_sp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, asc_dvc->irq_sp->next_vpa);
 
     /*
      * The first command completed by the RISC will be placed in
@@ -16724,8 +16685,9 @@
          * Get physical address for the carrier 'carrp'.
          */
         contig_len = sizeof(ADV_CARR_T);
-        carr_paddr = cpu_to_le32(DvcGetPhyAddr(asc_dvc, NULL, (uchar *) carrp,
-            (ADV_SDCNT *) &contig_len, ADV_IS_CARRIER_FLAG));
+        carr_paddr = ptr_to_dma32le(asc_dvc->drv_ptr->carrp_dma,
+				    asc_dvc->drv_ptr->orig_carrp,
+				    carrp);
 
         buf_size -= sizeof(ADV_CARR_T);
 
@@ -16741,12 +16703,14 @@
         }
 
         carrp->carr_pa = carr_paddr;
-        carrp->carr_va = cpu_to_le32(ADV_VADDR_TO_U32(carrp));
+        carrp->carr_va = cpu_to_le32((__u32)carrp);
 
         /*
          * Insert the carrier at the beginning of the freelist.
          */
-        carrp->next_vpa = cpu_to_le32(ADV_VADDR_TO_U32(asc_dvc->carr_freelist));
+        carrp->next_vpa = ptr_to_dma32le(asc_dvc->drv_ptr->carrp_dma,
+					 asc_dvc->drv_ptr->orig_carrp,
+					 asc_dvc->carr_freelist);
         asc_dvc->carr_freelist = carrp;
 
         carrp++;
@@ -16761,8 +16725,7 @@
         asc_dvc->err_code |= ASC_IERR_NO_CARRIER;
         return ADV_ERROR;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-        ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->icq_sp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, asc_dvc->icq_sp->next_vpa);
 
     /*
      * The first command issued will be placed in the stopper carrier.
@@ -16786,8 +16749,7 @@
         asc_dvc->err_code |= ASC_IERR_NO_CARRIER;
         return ADV_ERROR;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-        ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->irq_sp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, asc_dvc->irq_sp->next_vpa);
 
     /*
      * The first command completed by the RISC will be placed in
@@ -17978,8 +17940,7 @@
        DvcLeaveCritical(last_int_level);
        return ADV_BUSY;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-        ADV_U32_TO_VADDR(le32_to_cpu(new_carrp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, new_carrp->next_vpa);
     asc_dvc->carr_pending_cnt++;
 
     /*
@@ -17995,8 +17956,9 @@
     scsiq->a_flag &= ~ADV_SCSIQ_DONE;
 
     req_size = sizeof(ADV_SCSI_REQ_Q);
-    req_paddr = DvcGetPhyAddr(asc_dvc, scsiq, (uchar *) scsiq,
-        (ADV_SDCNT *) &req_size, ADV_IS_SCSIQ_FLAG);
+    req_paddr = ptr_to_dma32le(asc_dvc->drv_ptr->reqp_dma,
+			       asc_dvc->drv_ptr->orig_reqp,
+			       scsiq);
 
     ASC_ASSERT(ADV_32BALIGN(req_paddr) == req_paddr);
     ASC_ASSERT(req_size >= sizeof(ADV_SCSI_REQ_Q));
@@ -18005,10 +17967,12 @@
     req_paddr = cpu_to_le32(req_paddr);
 
     /* Save virtual and physical address of ADV_SCSI_REQ_Q and carrier. */
-    scsiq->scsiq_ptr = cpu_to_le32(ADV_VADDR_TO_U32(scsiq));
+    scsiq->scsiq_ptr = ptr_to_dma32le(asc_dvc->drv_ptr->reqp_dma,
+				      asc_dvc->drv_ptr->orig_reqp,
+				      scsiq);
     scsiq->scsiq_rptr = req_paddr;
 
-    scsiq->carr_va = cpu_to_le32(ADV_VADDR_TO_U32(asc_dvc->icq_sp));
+    scsiq->carr_va = cpu_to_le32((__u32) asc_dvc->icq_sp);
     /*
      * Every ADV_CARR_T.carr_pa is byte swapped to little-endian
      * order during initialization.
@@ -18305,7 +18269,9 @@
          * in AdvExeScsiQueue().
          */
         scsiq = (ADV_SCSI_REQ_Q *)
-            ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->irq_sp->areq_vpa));
+	  dma32le_to_ptr(asc_dvc->drv_ptr->reqp_dma,
+			 asc_dvc->drv_ptr->orig_reqp,
+			 asc_dvc->irq_sp->areq_vpa);
 
         /*
          * Request finished with good status and the queue was not
@@ -18325,11 +18291,13 @@
          * stopper carrier.
          */
         free_carrp = asc_dvc->irq_sp;
-        asc_dvc->irq_sp = (ADV_CARR_T *)
-            ADV_U32_TO_VADDR(ASC_GET_CARRP(irq_next_vpa));
+        asc_dvc->irq_sp = dma_to_carrp(asc_dvc, asc_dvc->irq_sp->next_vpa);
 
         free_carrp->next_vpa =
-                cpu_to_le32(ADV_VADDR_TO_U32(asc_dvc->carr_freelist));
+	  ptr_to_dma32le(asc_dvc->drv_ptr->carrp_dma,
+			 asc_dvc->drv_ptr->orig_carrp,
+			 asc_dvc->carr_freelist);
+
         asc_dvc->carr_freelist = free_carrp;
         asc_dvc->carr_pending_cnt--;
 
--- linux-2.5.6-pre3/drivers/scsi/pci2220i.h	Tue Feb 19 18:11:02 2002
+++ linux/drivers/scsi/pci2220i.h	Wed Mar  6 22:41:02 2002
@@ -56,5 +56,7 @@
 	present:		0,			\
 	unchecked_isa_dma:	0,			\
 	use_clustering:		DISABLE_CLUSTERING,	\
+	dma_map_request:	1,			\
+	dma_map_sense:		0,			\
 }
 #endif
--- linux-2.5.6-pre3/drivers/scsi/pci2220i.c	Tue Feb 19 18:10:54 2002
+++ linux/drivers/scsi/pci2220i.c	Wed Mar  6 22:41:02 2002
@@ -34,8 +34,6 @@
  *
  ****************************************************************************/
 
-#error Convert me to understand page+offset based scatterlists
-
 //#define DEBUG 1
 
 #include <linux/module.h>
@@ -53,6 +51,7 @@
 #include <linux/blk.h>
 #include <linux/timer.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 #include <asm/dma.h>
 #include <asm/system.h>
 #include <asm/io.h>
@@ -77,6 +76,24 @@
 
 #define MAXADAPTER 4					// Increase this and the sizes of the arrays below, if you need more.
 
+#ifdef MODULE
+static struct pci_device_id pci2220i_pci_tbl[] __initdata = {
+	{
+	  vendor: VENDOR_PSI,
+	  device: DEVICE_DALE_1,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: VENDOR_PSI,
+	  device: DEVICE_BIGD_1,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, pci2220i_pci_tbl);
+#endif
 
 typedef struct
 	{
@@ -140,6 +157,7 @@
 	ULONG		 startSector;
 	USHORT		 sectorCount;
 	ULONG		 readCount;
+	void		*currentSgPage;
 	UCHAR		*currentSgBuffer;
 	ULONG		 currentSgCount;
 	USHORT		 nextSg;
@@ -463,10 +481,20 @@
 		padapter->currentSgCount -= count;
 		if ( !padapter->currentSgCount )
 			{
-			if ( padapter->nextSg < padapter->SCpnt->use_sg )
+			if ( padapter->nextSg < padapter->SCpnt->sg_cnt )
 				{
-				padapter->currentSgBuffer = ((struct scatterlist *)padapter->SCpnt->request_buffer)[padapter->nextSg].address;
-				padapter->currentSgCount = ((struct scatterlist *)padapter->SCpnt->request_buffer)[padapter->nextSg].length;
+				struct scatterlist *sg =
+				    &padapter->SCpnt->sg[padapter->nextSg];
+				kunmap(padapter->currentSgPage);
+				padapter->currentSgPage = kmap(sg->page);
+				if (padapter->currentSgPage == NULL) {
+					printk (KERN_ERR
+						"pci2220i: kmap failed\n");
+					return;
+				}
+				padapter->currentSgBuffer =
+					padapter->currentSgPage + sg->offset;
+				padapter->currentSgCount = sg->length;
 				padapter->nextSg++;
 				}
 			}
@@ -755,6 +783,8 @@
 			add_timer (&padapter->reconTimer);
 			}
 		}
+	if (padapter->currentSgPage != NULL)
+		kunmap(padapter->currentSgPage);
 	}
 /****************************************************************
  *	Name:	InlineIdentify	:LOCAL
@@ -2044,21 +2074,20 @@
 	UCHAR			rc;											// command return code
 	int				z; 
 	PDEVICE_RAID1	pdr;
+	struct scatterlist	*sg0;
 
 	SCpnt->scsi_done = done;
 	padapter->SCpnt = SCpnt;  									// Save this command data
 	padapter->readCount = 0;
 
-	if ( SCpnt->use_sg )
-		{
-		padapter->currentSgBuffer = ((struct scatterlist *)SCpnt->request_buffer)[0].address;
-		padapter->currentSgCount = ((struct scatterlist *)SCpnt->request_buffer)[0].length;
-		}
-	else
-		{
-		padapter->currentSgBuffer = SCpnt->request_buffer;
-		padapter->currentSgCount = SCpnt->request_bufflen;
-		}
+	sg0 = &SCpnt->sg[0];
+	padapter->currentSgPage = kmap(sg0->page);
+	if (padapter->currentSgPage == NULL) {
+		printk ("pci2220i_queuecommand: kmap failed.\n");
+		return 0;
+	}
+	padapter->currentSgBuffer = padapter->currentSgPage + sg0->offset;
+	padapter->currentSgCount = sg0->length;
 	padapter->nextSg = 1;
 
 	if ( !done )
--- linux-2.5.6-pre3/drivers/scsi/BusLogic.h	Tue Feb 19 18:11:02 2002
+++ linux/drivers/scsi/BusLogic.h	Thu Mar  7 04:00:47 2002
@@ -79,7 +79,10 @@
     bios_param:     BusLogic_BIOSDiskParameters,  /* BIOS Disk Parameters   */ \
     unchecked_isa_dma: 1,			  /* Default Initial Value  */ \
     max_sectors:    128,			  /* I/O queue len limit    */ \
-    use_clustering: ENABLE_CLUSTERING }		  /* Enable Clustering	    */
+    use_clustering: ENABLE_CLUSTERING,		  /* Enable Clustering	    */ \
+    dma_map_request : 1,			  /* Map gather/scatter */     \
+    dma_map_sense : 1 }
+
 
 
 /*
@@ -106,7 +109,6 @@
   BusLogic_InitializeProbeInfoList
 #endif
 
-
 /*
   Define the maximum number of BusLogic Host Adapters supported by this driver.
 */
@@ -162,7 +164,10 @@
 */
 
 #define BusLogic_MaxMailboxes			211
-
+#define BusLogic_MailboxSpace				\
+	(BusLogic_MaxMailboxes *			\
+	 (sizeof(BusLogic_OutgoingMailbox_T)		\
+	  + sizeof(BusLogic_IncomingMailbox_T)))
 
 /*
   Define the number of CCBs that should be allocated as a group to optimize
@@ -1192,7 +1197,7 @@
   /*
     BusLogic Linux Driver Defined Portion.
   */
-  boolean AllocationGroupHead;
+  struct BusLogic_CCB_Group *Group;
   BusLogic_CCB_Status_T Status;
   unsigned long SerialNumber;
   SCSI_Command_T *Command;
@@ -1204,6 +1209,30 @@
 }
 BusLogic_CCB_T;
 
+/* Command Control Blocks are allocated in contiguous groups.  This data
+   structure sits at the front of each group.  It is needed so that we
+   can quickly covert a CCB "bus" address back to a CCB virtual addresss.
+   It also accelerates freeing of CCB's. */
+
+typedef struct BusLogic_CCB_Group {
+	dma_addr_t DMA_Address;
+	int Size;
+	struct BusLogic_CCB_Group *Next;
+} BusLogic_CCB_Group_T;
+
+/* For future use, to eliminate  */
+#define for_each_ccb(padapter, ccb, code)				\
+{									\
+	BusLogic_CCB_Head_T *__grp;					\
+	for (__grp = padapter->CCB_Groups; __grp; __grp = __grp->Next){ \
+		BusLogic_CCB_T *__start = (BusLogic_CCB_T*) &__grp[1];	\
+		BusLogic_CCB_T *__end = __start + __grp->Count;		\
+		for ((ccb) = __start; (ccb) != __end; (ccb)++) {	\
+			code;						\
+		}							\
+	}								\
+}
+
 
 /*
   Define the 32 Bit Mode Outgoing Mailbox structure.
@@ -1421,6 +1450,7 @@
   FlashPoint_Info_T FlashPointInfo;
   FlashPoint_CardHandle_T CardHandle;
   struct BusLogic_HostAdapter *Next;
+  BusLogic_CCB_Group_T *CCB_Groups;
   BusLogic_CCB_T *All_CCBs;
   BusLogic_CCB_T *Free_CCBs;
   BusLogic_CCB_T *FirstCompletedCCB;
@@ -1444,9 +1474,7 @@
   BusLogic_IncomingMailbox_T *LastIncomingMailbox;
   BusLogic_IncomingMailbox_T *NextIncomingMailbox;
   BusLogic_TargetStatistics_T TargetStatistics[BusLogic_MaxTargetDevices];
-  unsigned char MailboxSpace[BusLogic_MaxMailboxes
-			     * (sizeof(BusLogic_OutgoingMailbox_T)
-				+ sizeof(BusLogic_IncomingMailbox_T))];
+  dma_addr_t MailboxDMA_Address;
   char MessageBuffer[BusLogic_MessageBufferSize];
 }
 BusLogic_HostAdapter_T;
@@ -1655,22 +1683,6 @@
   sti();
   while (--Milliseconds >= 0) udelay(1000);
   restore_flags(ProcessorFlags);
-}
-
-
-/*
-  Virtual_to_Bus and Bus_to_Virtual map between Kernel Virtual Addresses
-  and PCI/VLB/EISA/ISA Bus Addresses.
-*/
-
-static inline BusLogic_BusAddress_T Virtual_to_Bus(void *VirtualAddress)
-{
-  return (BusLogic_BusAddress_T) virt_to_bus(VirtualAddress);
-}
-
-static inline void *Bus_to_Virtual(BusLogic_BusAddress_T BusAddress)
-{
-  return (void *) bus_to_virt(BusAddress);
 }
 
 
--- linux-2.5.6-pre3/drivers/scsi/BusLogic.c	Tue Feb 19 18:11:05 2002
+++ linux/drivers/scsi/BusLogic.c	Thu Mar  7 04:00:46 2002
@@ -29,8 +29,6 @@
 #define BusLogic_DriverVersion		"2.1.15"
 #define BusLogic_DriverDate		"17 August 1998"
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/config.h>
@@ -50,10 +48,35 @@
 #include <asm/system.h>
 #include "scsi.h"
 #include "hosts.h"
+#include <scsi/scsicam.h>
 #include "sd.h"
 #include "BusLogic.h"
 #include "FlashPoint.c"
 
+#ifdef MODULE
+static struct pci_device_id buslogic_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_BUSLOGIC,
+	  device: PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_BUSLOGIC,
+	  device: PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER_NC,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_BUSLOGIC,
+	  device: PCI_DEVICE_ID_BUSLOGIC_FLASHPOINT,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, buslogic_pci_tbl);
+#endif
 
 /*
   BusLogic_DriverOptionsCount is a count of the number of BusLogic Driver
@@ -225,11 +248,21 @@
 */
 
 static void BusLogic_InitializeCCBs(BusLogic_HostAdapter_T *HostAdapter,
-				    void *BlockPointer, int BlockSize)
+				    void *BlockPointer,
+				    dma_addr_t DMA_Address,
+				    int BlockSize)
 {
-  BusLogic_CCB_T *CCB = (BusLogic_CCB_T *) BlockPointer;
+  BusLogic_CCB_Group_T *Group = (BusLogic_CCB_Group_T*) BlockPointer;
+  BusLogic_CCB_T *CCB = (BusLogic_CCB_T *) &Group[1];
   memset(BlockPointer, 0, BlockSize);
-  CCB->AllocationGroupHead = true;
+
+  Group->DMA_Address = DMA_Address + sizeof(*Group);
+  Group->Size = BlockSize;
+  Group->Next = HostAdapter->CCB_Groups;
+  HostAdapter->CCB_Groups = Group;
+
+  BlockSize -= sizeof (*Group);
+  
   while ((BlockSize -= sizeof(BusLogic_CCB_T)) >= 0)
     {
       CCB->Status = BusLogic_CCB_Free;
@@ -255,20 +288,22 @@
 
 static boolean BusLogic_CreateInitialCCBs(BusLogic_HostAdapter_T *HostAdapter)
 {
-  int BlockSize = BusLogic_CCB_AllocationGroupSize * sizeof(BusLogic_CCB_T);
+  int BlockSize = BusLogic_CCB_AllocationGroupSize * sizeof(BusLogic_CCB_T) +
+	sizeof(BusLogic_CCB_Group_T);
   while (HostAdapter->AllocatedCCBs < HostAdapter->InitialCCBs)
     {
-      void *BlockPointer = kmalloc(BlockSize,
-				   (HostAdapter->BounceBuffersRequired
-				    ? GFP_ATOMIC | GFP_DMA
-				    : GFP_ATOMIC));
+      dma_addr_t DMA_Address;
+      void *BlockPointer =pci_alloc_consistent(HostAdapter->SCSI_Host->pci_dev,
+					       BlockSize,
+					       &DMA_Address);
       if (BlockPointer == NULL)
 	{
 	  BusLogic_Error("UNABLE TO ALLOCATE CCB GROUP - DETACHING\n",
 			 HostAdapter);
 	  return false;
 	}
-      BusLogic_InitializeCCBs(HostAdapter, BlockPointer, BlockSize);
+      BusLogic_InitializeCCBs(HostAdapter, BlockPointer, DMA_Address,
+			      BlockSize);
     }
   return true;
 }
@@ -280,14 +315,14 @@
 
 static void BusLogic_DestroyCCBs(BusLogic_HostAdapter_T *HostAdapter)
 {
-  BusLogic_CCB_T *NextCCB = HostAdapter->All_CCBs, *CCB;
+  BusLogic_CCB_Group_T *Group, *Next = HostAdapter->CCB_Groups;
   HostAdapter->All_CCBs = NULL;
   HostAdapter->Free_CCBs = NULL;
-  while ((CCB = NextCCB) != NULL)
+  while ((Group = Next) != NULL)
     {
-      NextCCB = CCB->NextAll;
-      if (CCB->AllocationGroupHead)
-	kfree(CCB);
+      Next = Group->Next;
+      pci_free_consistent(HostAdapter->SCSI_Host->pci_dev,
+			  Group->Size, Group, Group->DMA_Address);
     }
 }
 
@@ -303,17 +338,19 @@
 					  int AdditionalCCBs,
 					  boolean SuccessMessageP)
 {
-  int BlockSize = BusLogic_CCB_AllocationGroupSize * sizeof(BusLogic_CCB_T);
+  int BlockSize = BusLogic_CCB_AllocationGroupSize * sizeof(BusLogic_CCB_T) +
+	sizeof(BusLogic_CCB_Group_T);
   int PreviouslyAllocated = HostAdapter->AllocatedCCBs;
   if (AdditionalCCBs <= 0) return;
   while (HostAdapter->AllocatedCCBs - PreviouslyAllocated < AdditionalCCBs)
     {
-      void *BlockPointer = kmalloc(BlockSize,
-				   (HostAdapter->BounceBuffersRequired
-				    ? GFP_ATOMIC | GFP_DMA
-				    : GFP_ATOMIC));
+      dma_addr_t DMA_Address;
+      void *BlockPointer =pci_alloc_consistent(HostAdapter->SCSI_Host->pci_dev,
+					       BlockSize,
+					       &DMA_Address);
       if (BlockPointer == NULL) break;
-      BusLogic_InitializeCCBs(HostAdapter, BlockPointer, BlockSize);
+      BusLogic_InitializeCCBs(HostAdapter, BlockPointer, DMA_Address,
+			      BlockSize);
     }
   if (HostAdapter->AllocatedCCBs > PreviouslyAllocated)
     {
@@ -2299,6 +2336,11 @@
   */
   if (HostAdapter->DMA_ChannelAcquired)
     free_dma(HostAdapter->DMA_Channel);
+  if (HostAdapter->FirstOutgoingMailbox != NULL)
+	pci_free_consistent(HostAdapter->SCSI_Host->pci_dev,
+			    BusLogic_MailboxSpace,
+			    HostAdapter->FirstOutgoingMailbox,
+			    HostAdapter->MailboxDMA_Address);
 }
 
 
@@ -2342,7 +2384,12 @@
     Initialize the Outgoing and Incoming Mailbox pointers.
   */
   HostAdapter->FirstOutgoingMailbox =
-    (BusLogic_OutgoingMailbox_T *) HostAdapter->MailboxSpace;
+    pci_alloc_consistent(HostAdapter->SCSI_Host->pci_dev,
+			 BusLogic_MailboxSpace,
+			 &HostAdapter->MailboxDMA_Address);
+  if (HostAdapter->FirstOutgoingMailbox == NULL)
+    return BusLogic_Failure(HostAdapter, "MAILBOX MEMORY ALLOCATION");
+
   HostAdapter->LastOutgoingMailbox =
     HostAdapter->FirstOutgoingMailbox + HostAdapter->MailboxCount - 1;
   HostAdapter->NextOutgoingMailbox = HostAdapter->FirstOutgoingMailbox;
@@ -2362,8 +2409,7 @@
     Initialize the Host Adapter's Pointer to the Outgoing/Incoming Mailboxes.
   */
   ExtendedMailboxRequest.MailboxCount = HostAdapter->MailboxCount;
-  ExtendedMailboxRequest.BaseMailboxAddress =
-    Virtual_to_Bus(HostAdapter->FirstOutgoingMailbox);
+  ExtendedMailboxRequest.BaseMailboxAddress = HostAdapter->MailboxDMA_Address;
   if (BusLogic_Command(HostAdapter, BusLogic_InitializeExtendedMailbox,
 		       &ExtendedMailboxRequest,
 		       sizeof(ExtendedMailboxRequest), NULL, 0) < 0)
@@ -2978,6 +3024,29 @@
   return (HostStatus << 16) | TargetDeviceStatus;
 }
 
+static BusLogic_CCB_T *
+Bus_to_CCB(BusLogic_HostAdapter_T *HostAdapter,
+	   BusLogic_BusAddress_T BusAddress)
+{
+	BusLogic_CCB_Group_T *Group;
+	for (Group = HostAdapter->CCB_Groups; Group; Group = Group->Next) {
+		int Offset = BusAddress - Group->DMA_Address;
+		if (Offset > 0 && Offset < Group->Size)
+			return (BusLogic_CCB_T*) (((void*)Group) + Offset);
+	}
+	printk ("BusLogic.c: Bus_to_CCB: Invalid CCB bus address 0x%x.\n", BusAddress);
+	BUG();
+	return NULL;
+}
+
+dma_addr_t
+CCB_Virtual_to_Bus(BusLogic_CCB_T *CCB, void *ptr)
+{
+	BusLogic_CCB_Group_T *Group = CCB->Group;
+	return Group->DMA_Address + (ptr - (void*) Group);
+}
+
+
 
 /*
   BusLogic_ScanIncomingMailboxes scans the Incoming Mailboxes saving any
@@ -3004,8 +3073,7 @@
   while ((CompletionCode = NextIncomingMailbox->CompletionCode) !=
 	 BusLogic_IncomingMailboxFree)
     {
-      BusLogic_CCB_T *CCB = (BusLogic_CCB_T *)
-	Bus_to_Virtual(NextIncomingMailbox->CCB);
+      BusLogic_CCB_T *CCB = Bus_to_CCB(HostAdapter, NextIncomingMailbox->CCB);
       if (CompletionCode != BusLogic_AbortedCommandNotFound)
 	{
 	  if (CCB->Status == BusLogic_CCB_Active ||
@@ -3306,7 +3374,7 @@
 	the Host Adapter is operating asynchronously and the locking code
 	does not protect against simultaneous access by the Host Adapter.
       */
-      NextOutgoingMailbox->CCB = Virtual_to_Bus(CCB);
+      NextOutgoingMailbox->CCB = CCB_Virtual_to_Bus(CCB, CCB);
       NextOutgoingMailbox->ActionCode = ActionCode;
       BusLogic_StartMailboxCommand(HostAdapter);
       if (++NextOutgoingMailbox > HostAdapter->LastOutgoingMailbox)
@@ -3347,6 +3415,8 @@
   int SegmentCount = Command->use_sg;
   ProcessorFlags_T ProcessorFlags;
   BusLogic_CCB_T *CCB;
+  SCSI_ScatterList_T *ScatterList;
+  int Segment;
   /*
     SCSI REQUEST_SENSE commands will be executed automatically by the Host
     Adapter for any errors, so they should not be executed explicitly unless
@@ -3383,29 +3453,21 @@
   /*
     Initialize the fields in the BusLogic Command Control Block (CCB).
   */
-  if (SegmentCount == 0)
-    {
-      CCB->Opcode = BusLogic_InitiatorCCB;
-      CCB->DataLength = BufferLength;
-      CCB->DataPointer = Virtual_to_Bus(BufferPointer);
-    }
+  ScatterList = (SCSI_ScatterList_T *) BufferPointer;
+  CCB->Opcode = BusLogic_InitiatorCCB_ScatterGather;
+  CCB->DataLength = SegmentCount * sizeof(BusLogic_ScatterGatherSegment_T);
+  if (BusLogic_MultiMasterHostAdapterP(HostAdapter))
+	CCB->DataPointer = CCB_Virtual_to_Bus(CCB, CCB->ScatterGatherList);
   else
-    {
-      SCSI_ScatterList_T *ScatterList = (SCSI_ScatterList_T *) BufferPointer;
-      int Segment;
-      CCB->Opcode = BusLogic_InitiatorCCB_ScatterGather;
-      CCB->DataLength = SegmentCount * sizeof(BusLogic_ScatterGatherSegment_T);
-      if (BusLogic_MultiMasterHostAdapterP(HostAdapter))
-	CCB->DataPointer = Virtual_to_Bus(CCB->ScatterGatherList);
-      else CCB->DataPointer = Virtual_to_32Bit_Virtual(CCB->ScatterGatherList);
-      for (Segment = 0; Segment < SegmentCount; Segment++)
+	CCB->DataPointer = Virtual_to_32Bit_Virtual(CCB->ScatterGatherList);/* WTF? FIXME. */
+  for (Segment = 0; Segment < SegmentCount; Segment++)
 	{
 	  CCB->ScatterGatherList[Segment].SegmentByteCount =
-	    ScatterList[Segment].length;
+	    sg_dma_len(&ScatterList[Segment]);
 	  CCB->ScatterGatherList[Segment].SegmentDataPointer =
-	    Virtual_to_Bus(ScatterList[Segment].address);
+	    sg_dma_address(&ScatterList[Segment]);
 	}
-    }
+
   switch (CDB[0])
     {
     case READ_6:
@@ -3498,7 +3560,7 @@
 	}
     }
   memcpy(CCB->CDB, CDB, CDB_Length);
-  CCB->SenseDataPointer = Virtual_to_Bus(&Command->sense_buffer);
+  CCB->SenseDataPointer = Command->sense_dma_addr;
   CCB->Command = Command;
   Command->scsi_done = CompletionRoutine;
   if (BusLogic_MultiMasterHostAdapterP(HostAdapter))

--IS0zKkzwUGydFO0o--
