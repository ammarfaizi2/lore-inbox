Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293162AbSB1Pcm>; Thu, 28 Feb 2002 10:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293433AbSB1PaW>; Thu, 28 Feb 2002 10:30:22 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:51428 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S293426AbSB1P2v>; Thu, 28 Feb 2002 10:28:51 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 28 Feb 2002 07:28:47 -0800
Message-Id: <200202281528.HAA06493@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch??: linux-2.5.6-pre1/drivers/scsi/advansys.c DMA-mapping fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The following is my attempt to at porting
linux-2.5.6-pre1/drivers/scsi/advansys.c to the new DMA mapping
scheme described in linux-2.5.6-pre1/Documentation/DMA-mapping.txt.

	Since I do not have an advansys card and I'm a bit green
at doing these conversions, I would appreciate it someone who knows
the advansys driver could take a look at this stuff and either
tell me if I have missed something or take it from here.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


--- linux-2.5.6-pre1/drivers/scsi/advansys.c	Tue Feb 19 18:10:59 2002
+++ linux/drivers/scsi/advansys.c	Thu Feb 28 06:58:13 2002
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
@@ -2152,7 +2144,6 @@
  * addresses.
  */
 #define ADV_VADDR_TO_U32   virt_to_bus
-#define ADV_U32_TO_VADDR   bus_to_virt
 
 #define AdvPortAddr  ulong              /* Virtual memory address size */
 
@@ -3196,7 +3187,8 @@
      * End of microcode structure - 60 bytes. The rest of the structure
      * is used by the Adv Library and ignored by the microcode.
      */
-    ADV_VADDR   srb_ptr;
+
+    struct adv_req	*reqp;
     ADV_SG_BLOCK *sg_list_ptr; /* SG list virtual address. */
     char        *vdata_addr;   /* Data buffer virtual address. */
     uchar       a_flag;
@@ -3249,8 +3241,6 @@
 STATIC void  DvcSleepMilliSecond(ADV_DCNT);
 STATIC uchar DvcAdvReadPCIConfigByte(ADV_DVC_VAR *, ushort);
 STATIC void  DvcAdvWritePCIConfigByte(ADV_DVC_VAR *, ushort, uchar);
-STATIC ADV_PADDR DvcGetPhyAddr(ADV_DVC_VAR *, ADV_SCSI_REQ_Q *,
-                uchar *, ASC_SDCNT *, int);
 STATIC void  DvcDelayMicroSecond(ADV_DVC_VAR *, ushort);
 
 /*
@@ -3464,16 +3454,6 @@
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
@@ -4097,7 +4077,10 @@
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
@@ -4196,6 +4179,18 @@
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
@@ -4281,6 +4276,46 @@
 STATIC void         asc_prt_hex(char *f, uchar *, int);
 #endif /* ADVANSYS_DEBUG */
 
+static void *alloc_consistent(struct pci_dev *pcidev, size_t size,
+			      dma_addr_t *dma_handle)
+{
+	if (pcidev == NULL) {	/* not PCI bus */
+		void *result = kmalloc(size, GFP_ATOMIC);
+		*dma_handle = (dma_addr_t) result;
+		return result;
+	} else
+		return pci_alloc_consistent(pcidev, size, dma_handle);
+}
+
+static void free_consistent(struct pci_dev *pcidev, size_t size,
+			    void *vaddr, dma_addr_t dma_handle)
+{
+	if (pcidev == NULL)
+		kfree(vaddr);	/* not PCI bus */
+	else
+		pci_free_consistent(pcidev, size, vaddr, dma_handle);
+}
+
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
@@ -4727,7 +4762,9 @@
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
@@ -5544,8 +5581,9 @@
                  * Allocate buffer carrier structures. The total size
                  * is about 4 KB, so allocate all at once.
                  */
-                carrp =
-                    (ADV_CARR_T *) kmalloc(ADV_CARRIER_BUFSIZE, GFP_ATOMIC);
+		carrp = alloc_consistent(pci_devp, ADV_CARRIER_BUFSIZE,
+					 &boardp->carrp_dma);
+
                 ASC_DBG1(1, "advansys_detect: carrp 0x%lx\n", (ulong) carrp);
 
                 if (carrp == NULL) {
@@ -5561,8 +5599,10 @@
                 for (req_cnt = adv_dvc_varp->max_host_qng;
                     req_cnt > 0; req_cnt--) {
 
-                    reqp = (adv_req_t *)
-                        kmalloc(sizeof(adv_req_t) * req_cnt, GFP_ATOMIC);
+		    boardp->reqp_size = sizeof(adv_req_t) * req_cnt;
+		    reqp = alloc_consistent(pci_devp,
+					    boardp->reqp_size,
+					    &boardp->reqp_dma);
 
                     ASC_DBG3(1,
                         "advansys_detect: reqp 0x%lx, req_cnt %d, bytes %lu\n",
@@ -5614,14 +5654,23 @@
                         boardp->id);
                     err_code = ADV_ERROR;
                 } else if (reqp == NULL) {
-                    kfree(carrp);
+		    free_consistent(shp->pci_dev,
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
+		    free_consistent(shp->pci_dev,
+				    ADV_CARRIER_BUFSIZE,
+				    carrp,
+				    boardp->carrp_dma);
+		    free_consistent(shp->pci_dev,
+				    boardp->reqp_size,
+				    reqp,
+				    boardp->reqp_dma);
                     ASC_PRINT1(
 "advansys_detect: board %d error: failed to kmalloc() adv_sgblk_t buffers.\n",
                         boardp->id);
@@ -5679,11 +5728,17 @@
                 if (ASC_WIDE_BOARD(boardp)) {
                     iounmap(boardp->ioremap_addr);
                     if (boardp->orig_carrp) {
-                        kfree(boardp->orig_carrp);
-                        boardp->orig_carrp = NULL;
+		        free_consistent(shp->pci_dev,
+					ADV_CARRIER_BUFSIZE,
+					boardp->orig_carrp,
+					boardp->carrp_dma);
+		        boardp->orig_carrp = NULL;
                     }
                     if (boardp->orig_reqp) {
-                        kfree(boardp->orig_reqp);
+		        free_consistent(shp->pci_dev,
+					boardp->reqp_size,
+					boardp->orig_reqp,
+					boardp->reqp_dma);
                         boardp->orig_reqp = boardp->adv_reqp = NULL;
                     }
                     while ((sgp = boardp->adv_sgblkp) != NULL)
@@ -5734,11 +5789,15 @@
 
         iounmap(boardp->ioremap_addr);
         if (boardp->orig_carrp) {
-            kfree(boardp->orig_carrp);
+	    free_consistent(shp->pci_dev, ADV_CARRIER_BUFSIZE,
+			    boardp->orig_carrp, boardp->carrp_dma);
             boardp->orig_carrp = NULL;
         }
         if (boardp->orig_reqp) {
-            kfree(boardp->orig_reqp);
+	    free_consistent(shp->pci_dev,
+			    boardp->reqp_size,
+			    boardp->orig_reqp,
+			    boardp->reqp_dma);
             boardp->orig_reqp = boardp->adv_reqp = NULL;
         }
         while ((sgp = boardp->adv_sgblkp) != NULL)
@@ -5872,7 +5931,7 @@
 
     /* host_lock taken by mid-level prior to call but need to protect */
     /* against own ISR */
-    spin_lock_irqsave(boardp->lock, flags);
+    spin_lock_irqsave(&boardp->lock, flags);
 
     /*
      * Block new commands while handling a reset or abort request.
@@ -6655,7 +6714,7 @@
     /*
      * Point the ASC_SCSI_Q to the 'Scsi_Cmnd'.
      */
-    asc_scsi_q.q2.srb_ptr = ASC_VADDR_TO_U32(scp);
+    asc_scsi_q.q2.srb_ptr = (u32) scp;
 
     /*
      * Build the ASC_SCSI_Q request.
@@ -6750,10 +6809,7 @@
          */
         slp = (struct scatterlist *) scp->request_buffer;
         for (sgcnt = 0; sgcnt < scp->use_sg; sgcnt++, slp++) {
-            asc_sg_head.sg_list[sgcnt].addr =
-                cpu_to_le32(virt_to_bus(slp->address ? 
-		(unsigned char *)slp->address :
-		(unsigned char *)page_address(slp->page) + slp->offset));
+	    asc_sg_head.sg_list[sgcnt].addr = sg_dma_address(slp);
             asc_sg_head.sg_list[sgcnt].bytes = cpu_to_le32(slp->length);
             ASC_STATS_ADD(scp->host, sg_xfer, ASC_CEILING(slp->length, 512));
         }
@@ -6811,7 +6867,7 @@
     /*
      * Set the ADV_SCSI_REQ_Q 'srb_ptr' to point to the adv_req_t structure.
      */
-    scsiqp->srb_ptr = ASC_VADDR_TO_U32(reqp);
+    scsiqp->reqp = reqp;
 
     /*
      * Set the adv_req_t 'cmndp' to point to the Scsi_Cmnd structure.
@@ -7010,10 +7066,7 @@
 
         for (i = 0; i < NO_OF_SG_PER_BLOCK; i++)
         {
-            sg_block->sg_list[i].sg_addr =
-                cpu_to_le32(virt_to_bus(slp->address ? 
-		(unsigned char *)slp->address :
-                (unsigned char *)page_address(slp->page) + slp->offset));
+	    sg_block->sg_list[i].sg_addr = sg_dma_address(slp);
             sg_block->sg_list[i].sg_count = cpu_to_le32(slp->length);
             ASC_STATS_ADD(scp->host, sg_xfer, ASC_CEILING(slp->length, 512));
 
@@ -7053,7 +7106,7 @@
      * Get the Scsi_Cmnd structure and Scsi_Host structure for the
      * command that has been completed.
      */
-    scp = (Scsi_Cmnd *) ASC_U32_TO_VADDR(qdonep->d2.srb_ptr);
+    scp = qdonep->scp;
     ASC_DBG1(1, "asc_isr_callback: scp 0x%lx\n", (ulong) scp);
 
     if (scp == NULL) {
@@ -7228,7 +7281,7 @@
      * completed. The adv_req_t structure actually contains the
      * completed ADV_SCSI_REQ_Q structure.
      */
-    reqp = (adv_req_t *) ADV_U32_TO_VADDR(scsiqp->srb_ptr);
+    reqp = scsiqp->reqp;
     ASC_DBG1(1, "adv_isr_callback: reqp 0x%lx\n", (ulong) reqp);
     if (reqp == NULL) {
         ASC_PRINT("adv_isr_callback: reqp is NULL\n");
@@ -9146,32 +9199,6 @@
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
@@ -10500,9 +10527,11 @@
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
@@ -15465,8 +15494,9 @@
          * Get physical address of the carrier 'carrp'.
          */
         contig_len = sizeof(ADV_CARR_T);
-        carr_paddr = cpu_to_le32(DvcGetPhyAddr(asc_dvc, NULL, (uchar *) carrp,
-            (ADV_SDCNT *) &contig_len, ADV_IS_CARRIER_FLAG));
+        carr_paddr = ptr_to_dma32le(asc_dvc->drv_ptr->carrp_dma,
+				    asc_dvc->drv_ptr->orig_carrp,
+				    carrp);
 
         buf_size -= sizeof(ADV_CARR_T);
 
@@ -15482,12 +15512,14 @@
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
@@ -15503,8 +15535,7 @@
         asc_dvc->err_code |= ASC_IERR_NO_CARRIER;
         return ADV_ERROR;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-        ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->icq_sp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, asc_dvc->icq_sp->next_vpa);
 
     /*
      * The first command issued will be placed in the stopper carrier.
@@ -15524,8 +15555,7 @@
         asc_dvc->err_code |= ASC_IERR_NO_CARRIER;
         return ADV_ERROR;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-         ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->irq_sp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, asc_dvc->irq_sp->next_vpa);
 
     /*
      * The first command completed by the RISC will be placed in
@@ -16087,8 +16117,9 @@
          * Get physical address for the carrier 'carrp'.
          */
         contig_len = sizeof(ADV_CARR_T);
-        carr_paddr = cpu_to_le32(DvcGetPhyAddr(asc_dvc, NULL, (uchar *) carrp,
-            (ADV_SDCNT *) &contig_len, ADV_IS_CARRIER_FLAG));
+        carr_paddr = ptr_to_dma32le(asc_dvc->drv_ptr->carrp_dma,
+				    asc_dvc->drv_ptr->orig_carrp,
+				    carrp);
 
         buf_size -= sizeof(ADV_CARR_T);
 
@@ -16104,12 +16135,14 @@
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
@@ -16125,8 +16158,7 @@
         asc_dvc->err_code |= ASC_IERR_NO_CARRIER;
         return ADV_ERROR;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-        ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->icq_sp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, asc_dvc->icq_sp->next_vpa);
 
     /*
      * The first command issued will be placed in the stopper carrier.
@@ -16147,8 +16179,7 @@
         asc_dvc->err_code |= ASC_IERR_NO_CARRIER;
         return ADV_ERROR;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-        ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->irq_sp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, asc_dvc->irq_sp->next_vpa);
 
     /*
      * The first command completed by the RISC will be placed in
@@ -16724,8 +16755,9 @@
          * Get physical address for the carrier 'carrp'.
          */
         contig_len = sizeof(ADV_CARR_T);
-        carr_paddr = cpu_to_le32(DvcGetPhyAddr(asc_dvc, NULL, (uchar *) carrp,
-            (ADV_SDCNT *) &contig_len, ADV_IS_CARRIER_FLAG));
+        carr_paddr = ptr_to_dma32le(asc_dvc->drv_ptr->carrp_dma,
+				    asc_dvc->drv_ptr->orig_carrp,
+				    carrp);
 
         buf_size -= sizeof(ADV_CARR_T);
 
@@ -16741,12 +16773,14 @@
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
@@ -16761,8 +16795,7 @@
         asc_dvc->err_code |= ASC_IERR_NO_CARRIER;
         return ADV_ERROR;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-        ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->icq_sp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, asc_dvc->icq_sp->next_vpa);
 
     /*
      * The first command issued will be placed in the stopper carrier.
@@ -16786,8 +16819,7 @@
         asc_dvc->err_code |= ASC_IERR_NO_CARRIER;
         return ADV_ERROR;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-        ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->irq_sp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, asc_dvc->irq_sp->next_vpa);
 
     /*
      * The first command completed by the RISC will be placed in
@@ -17978,8 +18010,7 @@
        DvcLeaveCritical(last_int_level);
        return ADV_BUSY;
     }
-    asc_dvc->carr_freelist = (ADV_CARR_T *)
-        ADV_U32_TO_VADDR(le32_to_cpu(new_carrp->next_vpa));
+    asc_dvc->carr_freelist = dma_to_carrp(asc_dvc, new_carrp->next_vpa);
     asc_dvc->carr_pending_cnt++;
 
     /*
@@ -17995,8 +18026,9 @@
     scsiq->a_flag &= ~ADV_SCSIQ_DONE;
 
     req_size = sizeof(ADV_SCSI_REQ_Q);
-    req_paddr = DvcGetPhyAddr(asc_dvc, scsiq, (uchar *) scsiq,
-        (ADV_SDCNT *) &req_size, ADV_IS_SCSIQ_FLAG);
+    req_paddr = ptr_to_dma32le(asc_dvc->drv_ptr->reqp_dma,
+			       asc_dvc->drv_ptr->orig_reqp,
+			       scsiq);
 
     ASC_ASSERT(ADV_32BALIGN(req_paddr) == req_paddr);
     ASC_ASSERT(req_size >= sizeof(ADV_SCSI_REQ_Q));
@@ -18005,10 +18037,12 @@
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
@@ -18305,7 +18339,9 @@
          * in AdvExeScsiQueue().
          */
         scsiq = (ADV_SCSI_REQ_Q *)
-            ADV_U32_TO_VADDR(le32_to_cpu(asc_dvc->irq_sp->areq_vpa));
+	  dma32le_to_ptr(asc_dvc->drv_ptr->reqp_dma,
+			 asc_dvc->drv_ptr->orig_reqp,
+			 asc_dvc->irq_sp->areq_vpa);
 
         /*
          * Request finished with good status and the queue was not
@@ -18325,11 +18361,13 @@
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
 

