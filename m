Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbUKODwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUKODwd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbUKODv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:51:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4114 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261442AbUKOCXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:23:21 -0500
Date: Mon, 15 Nov 2004 03:11:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ipslinux@adaptec.com
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI ips.c: make some code static
Message-ID: <20041115021155.GO2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 drivers/scsi/ips.c |  244 ++++++++++++++++++++++-----------------------
 drivers/scsi/ips.h |   12 --
 2 files changed, 123 insertions(+), 133 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/ips.h.old	2004-11-13 22:29:51.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/ips.h	2004-11-13 22:40:47.000000000 +0100
@@ -53,14 +53,6 @@
    #include <asm/uaccess.h>
    #include <asm/io.h>
 
-   /* Prototypes */
-   extern int ips_detect(Scsi_Host_Template *);
-   extern int ips_release(struct Scsi_Host *);
-   extern int ips_eh_abort(Scsi_Cmnd *);
-   extern int ips_eh_reset(Scsi_Cmnd *);
-   extern int ips_queue(Scsi_Cmnd *, void (*) (Scsi_Cmnd *));
-   extern const char * ips_info(struct Scsi_Host *);
-
    /*
     * Some handy macros
     */
@@ -457,10 +449,10 @@
    static void ips_select_queue_depth(struct Scsi_Host *, Scsi_Device *);
    static int ips_biosparam(Disk *disk, kdev_t dev, int geom[]);
 #else
-   int ips_proc_info(struct Scsi_Host *, char *, char **, off_t, int, int);
+   static int ips_proc_info(struct Scsi_Host *, char *, char **, off_t, int, int);
    static int ips_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 		sector_t capacity, int geom[]);
-   int ips_slave_configure(Scsi_Device *SDptr);
+   static int ips_slave_configure(Scsi_Device *SDptr);
 #endif
 
 /*
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/ips.c.old	2004-11-13 22:28:43.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/ips.c	2004-11-13 22:38:30.000000000 +0100
@@ -246,6 +246,117 @@
 #endif
 
 /*
+ * Function prototypes
+ */
+static int ips_detect(Scsi_Host_Template *);
+static int ips_release(struct Scsi_Host *);
+static int ips_eh_abort(Scsi_Cmnd *);
+static int ips_eh_reset(Scsi_Cmnd *);
+static int ips_queue(Scsi_Cmnd *, void (*)(Scsi_Cmnd *));
+static const char *ips_info(struct Scsi_Host *);
+static irqreturn_t do_ipsintr(int, void *, struct pt_regs *);
+static int ips_hainit(ips_ha_t *);
+static int ips_map_status(ips_ha_t *, ips_scb_t *, ips_stat_t *);
+static int ips_send_wait(ips_ha_t *, ips_scb_t *, int, int);
+static int ips_send_cmd(ips_ha_t *, ips_scb_t *);
+static int ips_online(ips_ha_t *, ips_scb_t *);
+static int ips_inquiry(ips_ha_t *, ips_scb_t *);
+static int ips_rdcap(ips_ha_t *, ips_scb_t *);
+static int ips_msense(ips_ha_t *, ips_scb_t *);
+static int ips_reqsen(ips_ha_t *, ips_scb_t *);
+static int ips_deallocatescbs(ips_ha_t *, int);
+static int ips_allocatescbs(ips_ha_t *);
+static int ips_reset_copperhead(ips_ha_t *);
+static int ips_reset_copperhead_memio(ips_ha_t *);
+static int ips_reset_morpheus(ips_ha_t *);
+static int ips_issue_copperhead(ips_ha_t *, ips_scb_t *);
+static int ips_issue_copperhead_memio(ips_ha_t *, ips_scb_t *);
+static int ips_issue_i2o(ips_ha_t *, ips_scb_t *);
+static int ips_issue_i2o_memio(ips_ha_t *, ips_scb_t *);
+static int ips_isintr_copperhead(ips_ha_t *);
+static int ips_isintr_copperhead_memio(ips_ha_t *);
+static int ips_isintr_morpheus(ips_ha_t *);
+static int ips_wait(ips_ha_t *, int, int);
+static int ips_write_driver_status(ips_ha_t *, int);
+static int ips_read_adapter_status(ips_ha_t *, int);
+static int ips_read_subsystem_parameters(ips_ha_t *, int);
+static int ips_read_config(ips_ha_t *, int);
+static int ips_clear_adapter(ips_ha_t *, int);
+static int ips_readwrite_page5(ips_ha_t *, int, int);
+static int ips_init_copperhead(ips_ha_t *);
+static int ips_init_copperhead_memio(ips_ha_t *);
+static int ips_init_morpheus(ips_ha_t *);
+static int ips_isinit_copperhead(ips_ha_t *);
+static int ips_isinit_copperhead_memio(ips_ha_t *);
+static int ips_isinit_morpheus(ips_ha_t *);
+static int ips_erase_bios(ips_ha_t *);
+static int ips_program_bios(ips_ha_t *, char *, uint32_t, uint32_t);
+static int ips_verify_bios(ips_ha_t *, char *, uint32_t, uint32_t);
+static int ips_erase_bios_memio(ips_ha_t *);
+static int ips_program_bios_memio(ips_ha_t *, char *, uint32_t, uint32_t);
+static int ips_verify_bios_memio(ips_ha_t *, char *, uint32_t, uint32_t);
+static int ips_flash_copperhead(ips_ha_t *, ips_passthru_t *, ips_scb_t *);
+static int ips_flash_bios(ips_ha_t *, ips_passthru_t *, ips_scb_t *);
+static int ips_flash_firmware(ips_ha_t *, ips_passthru_t *, ips_scb_t *);
+static void ips_free_flash_copperhead(ips_ha_t * ha);
+static void ips_get_bios_version(ips_ha_t *, int);
+static void ips_identify_controller(ips_ha_t *);
+static void ips_chkstatus(ips_ha_t *, IPS_STATUS *);
+static void ips_enable_int_copperhead(ips_ha_t *);
+static void ips_enable_int_copperhead_memio(ips_ha_t *);
+static void ips_enable_int_morpheus(ips_ha_t *);
+static int ips_intr_copperhead(ips_ha_t *);
+static int ips_intr_morpheus(ips_ha_t *);
+static void ips_next(ips_ha_t *, int);
+static void ipsintr_blocking(ips_ha_t *, struct ips_scb *);
+static void ipsintr_done(ips_ha_t *, struct ips_scb *);
+static void ips_done(ips_ha_t *, ips_scb_t *);
+static void ips_free(ips_ha_t *);
+static void ips_init_scb(ips_ha_t *, ips_scb_t *);
+static void ips_freescb(ips_ha_t *, ips_scb_t *);
+static void ips_setup_funclist(ips_ha_t *);
+static void ips_statinit(ips_ha_t *);
+static void ips_statinit_memio(ips_ha_t *);
+static void ips_fix_ffdc_time(ips_ha_t *, ips_scb_t *, time_t);
+static void ips_ffdc_reset(ips_ha_t *, int);
+static void ips_ffdc_time(ips_ha_t *);
+static uint32_t ips_statupd_copperhead(ips_ha_t *);
+static uint32_t ips_statupd_copperhead_memio(ips_ha_t *);
+static uint32_t ips_statupd_morpheus(ips_ha_t *);
+static ips_scb_t *ips_getscb(ips_ha_t *);
+static void ips_putq_scb_head(ips_scb_queue_t *, ips_scb_t *);
+static void ips_putq_wait_tail(ips_wait_queue_t *, Scsi_Cmnd *);
+static void ips_putq_copp_tail(ips_copp_queue_t *,
+				      ips_copp_wait_item_t *);
+static ips_scb_t *ips_removeq_scb_head(ips_scb_queue_t *);
+static ips_scb_t *ips_removeq_scb(ips_scb_queue_t *, ips_scb_t *);
+static Scsi_Cmnd *ips_removeq_wait_head(ips_wait_queue_t *);
+static Scsi_Cmnd *ips_removeq_wait(ips_wait_queue_t *, Scsi_Cmnd *);
+static ips_copp_wait_item_t *ips_removeq_copp(ips_copp_queue_t *,
+						     ips_copp_wait_item_t *);
+static ips_copp_wait_item_t *ips_removeq_copp_head(ips_copp_queue_t *);
+
+static int ips_is_passthru(Scsi_Cmnd *);
+static int ips_make_passthru(ips_ha_t *, Scsi_Cmnd *, ips_scb_t *, int);
+static int ips_usrcmd(ips_ha_t *, ips_passthru_t *, ips_scb_t *);
+static void ips_cleanup_passthru(ips_ha_t *, ips_scb_t *);
+static void ips_scmd_buf_write(Scsi_Cmnd * scmd, void *data,
+			       unsigned int count);
+static void ips_scmd_buf_read(Scsi_Cmnd * scmd, void *data, unsigned int count);
+
+static int ips_proc_info(struct Scsi_Host *, char *, char **, off_t, int, int);
+static int ips_host_info(ips_ha_t *, char *, off_t, int);
+static void copy_mem_info(IPS_INFOSTR *, char *, int);
+static int copy_info(IPS_INFOSTR *, char *, ...);
+static int ips_get_version_info(ips_ha_t * ha, dma_addr_t, int intr);
+static void ips_version_check(ips_ha_t * ha, int intr);
+static int ips_abort_init(ips_ha_t * ha, int index);
+static int ips_init_phase2(int index);
+
+static int ips_init_phase1(struct pci_dev *pci_dev, int *indexPtr);
+static int ips_register_scsi(int index);
+
+/*
  * global variables
  */
 static const char ips_name[] = "ips";
@@ -293,7 +404,7 @@
 #endif
 };
 
-IPS_DEFINE_COMPAT_TABLE( Compatable );	/* Version Compatability Table      */
+static IPS_DEFINE_COMPAT_TABLE( Compatable );	/* Version Compatability Table      */
 
 
 /* This table describes all ServeRAID Adapters */
@@ -311,7 +422,7 @@
 static int __devinit  ips_insert_device(struct pci_dev *pci_dev, const struct pci_device_id *ent);
 static void __devexit ips_remove_device(struct pci_dev *pci_dev);
    
-struct pci_driver ips_pci_driver = {
+static struct pci_driver ips_pci_driver = {
 	.name		= ips_hot_plug_name,
 	.id_table	= ips_pci_table,
 	.probe		= ips_insert_device,
@@ -408,119 +519,6 @@
 	IPS_DATA_UNK, IPS_DATA_UNK, IPS_DATA_UNK, IPS_DATA_UNK, IPS_DATA_UNK
 };
 
-/*
- * Function prototypes
- */
-int ips_detect(Scsi_Host_Template *);
-int ips_release(struct Scsi_Host *);
-int ips_eh_abort(Scsi_Cmnd *);
-int ips_eh_reset(Scsi_Cmnd *);
-int ips_queue(Scsi_Cmnd *, void (*)(Scsi_Cmnd *));
-const char *ips_info(struct Scsi_Host *);
-irqreturn_t do_ipsintr(int, void *, struct pt_regs *);
-static int ips_hainit(ips_ha_t *);
-static int ips_map_status(ips_ha_t *, ips_scb_t *, ips_stat_t *);
-static int ips_send_wait(ips_ha_t *, ips_scb_t *, int, int);
-static int ips_send_cmd(ips_ha_t *, ips_scb_t *);
-static int ips_online(ips_ha_t *, ips_scb_t *);
-static int ips_inquiry(ips_ha_t *, ips_scb_t *);
-static int ips_rdcap(ips_ha_t *, ips_scb_t *);
-static int ips_msense(ips_ha_t *, ips_scb_t *);
-static int ips_reqsen(ips_ha_t *, ips_scb_t *);
-static int ips_deallocatescbs(ips_ha_t *, int);
-static int ips_allocatescbs(ips_ha_t *);
-static int ips_reset_copperhead(ips_ha_t *);
-static int ips_reset_copperhead_memio(ips_ha_t *);
-static int ips_reset_morpheus(ips_ha_t *);
-static int ips_issue_copperhead(ips_ha_t *, ips_scb_t *);
-static int ips_issue_copperhead_memio(ips_ha_t *, ips_scb_t *);
-static int ips_issue_i2o(ips_ha_t *, ips_scb_t *);
-static int ips_issue_i2o_memio(ips_ha_t *, ips_scb_t *);
-static int ips_isintr_copperhead(ips_ha_t *);
-static int ips_isintr_copperhead_memio(ips_ha_t *);
-static int ips_isintr_morpheus(ips_ha_t *);
-static int ips_wait(ips_ha_t *, int, int);
-static int ips_write_driver_status(ips_ha_t *, int);
-static int ips_read_adapter_status(ips_ha_t *, int);
-static int ips_read_subsystem_parameters(ips_ha_t *, int);
-static int ips_read_config(ips_ha_t *, int);
-static int ips_clear_adapter(ips_ha_t *, int);
-static int ips_readwrite_page5(ips_ha_t *, int, int);
-static int ips_init_copperhead(ips_ha_t *);
-static int ips_init_copperhead_memio(ips_ha_t *);
-static int ips_init_morpheus(ips_ha_t *);
-static int ips_isinit_copperhead(ips_ha_t *);
-static int ips_isinit_copperhead_memio(ips_ha_t *);
-static int ips_isinit_morpheus(ips_ha_t *);
-static int ips_erase_bios(ips_ha_t *);
-static int ips_program_bios(ips_ha_t *, char *, uint32_t, uint32_t);
-static int ips_verify_bios(ips_ha_t *, char *, uint32_t, uint32_t);
-static int ips_erase_bios_memio(ips_ha_t *);
-static int ips_program_bios_memio(ips_ha_t *, char *, uint32_t, uint32_t);
-static int ips_verify_bios_memio(ips_ha_t *, char *, uint32_t, uint32_t);
-static int ips_flash_copperhead(ips_ha_t *, ips_passthru_t *, ips_scb_t *);
-static int ips_flash_bios(ips_ha_t *, ips_passthru_t *, ips_scb_t *);
-static int ips_flash_firmware(ips_ha_t *, ips_passthru_t *, ips_scb_t *);
-static void ips_free_flash_copperhead(ips_ha_t * ha);
-static void ips_get_bios_version(ips_ha_t *, int);
-static void ips_identify_controller(ips_ha_t *);
-static void ips_chkstatus(ips_ha_t *, IPS_STATUS *);
-static void ips_enable_int_copperhead(ips_ha_t *);
-static void ips_enable_int_copperhead_memio(ips_ha_t *);
-static void ips_enable_int_morpheus(ips_ha_t *);
-static int ips_intr_copperhead(ips_ha_t *);
-static int ips_intr_morpheus(ips_ha_t *);
-static void ips_next(ips_ha_t *, int);
-static void ipsintr_blocking(ips_ha_t *, struct ips_scb *);
-static void ipsintr_done(ips_ha_t *, struct ips_scb *);
-static void ips_done(ips_ha_t *, ips_scb_t *);
-static void ips_free(ips_ha_t *);
-static void ips_init_scb(ips_ha_t *, ips_scb_t *);
-static void ips_freescb(ips_ha_t *, ips_scb_t *);
-static void ips_setup_funclist(ips_ha_t *);
-static void ips_statinit(ips_ha_t *);
-static void ips_statinit_memio(ips_ha_t *);
-static void ips_fix_ffdc_time(ips_ha_t *, ips_scb_t *, time_t);
-static void ips_ffdc_reset(ips_ha_t *, int);
-static void ips_ffdc_time(ips_ha_t *);
-static uint32_t ips_statupd_copperhead(ips_ha_t *);
-static uint32_t ips_statupd_copperhead_memio(ips_ha_t *);
-static uint32_t ips_statupd_morpheus(ips_ha_t *);
-static ips_scb_t *ips_getscb(ips_ha_t *);
-static void ips_putq_scb_head(ips_scb_queue_t *, ips_scb_t *);
-static void ips_putq_wait_tail(ips_wait_queue_t *, Scsi_Cmnd *);
-static void ips_putq_copp_tail(ips_copp_queue_t *,
-				      ips_copp_wait_item_t *);
-static ips_scb_t *ips_removeq_scb_head(ips_scb_queue_t *);
-static ips_scb_t *ips_removeq_scb(ips_scb_queue_t *, ips_scb_t *);
-static Scsi_Cmnd *ips_removeq_wait_head(ips_wait_queue_t *);
-static Scsi_Cmnd *ips_removeq_wait(ips_wait_queue_t *, Scsi_Cmnd *);
-static ips_copp_wait_item_t *ips_removeq_copp(ips_copp_queue_t *,
-						     ips_copp_wait_item_t *);
-static ips_copp_wait_item_t *ips_removeq_copp_head(ips_copp_queue_t *);
-
-static int ips_is_passthru(Scsi_Cmnd *);
-static int ips_make_passthru(ips_ha_t *, Scsi_Cmnd *, ips_scb_t *, int);
-static int ips_usrcmd(ips_ha_t *, ips_passthru_t *, ips_scb_t *);
-static void ips_cleanup_passthru(ips_ha_t *, ips_scb_t *);
-static void ips_scmd_buf_write(Scsi_Cmnd * scmd, void *data,
-			       unsigned int count);
-static void ips_scmd_buf_read(Scsi_Cmnd * scmd, void *data, unsigned int count);
-
-int ips_proc_info(struct Scsi_Host *, char *, char **, off_t, int, int);
-static int ips_host_info(ips_ha_t *, char *, off_t, int);
-static void copy_mem_info(IPS_INFOSTR *, char *, int);
-static int copy_info(IPS_INFOSTR *, char *, ...);
-static int ips_get_version_info(ips_ha_t * ha, dma_addr_t, int intr);
-static void ips_version_check(ips_ha_t * ha, int intr);
-static int ips_abort_init(ips_ha_t * ha, int index);
-static int ips_init_phase2(int index);
-
-static int ips_init_phase1(struct pci_dev *pci_dev, int *indexPtr);
-static int ips_register_scsi(int index);
-/*--------------------------------------------------------------------------*/
-/* Exported Functions                                                       */
-/*--------------------------------------------------------------------------*/
 
 /****************************************************************************/
 /*                                                                          */
@@ -589,7 +587,7 @@
 /* NOTE: this routine is called under the io_request_lock spinlock          */
 /*                                                                          */
 /****************************************************************************/
-int
+static int
 ips_detect(Scsi_Host_Template * SHT)
 {
 	int i;
@@ -678,7 +676,7 @@
 /*   Remove a driver                                                        */
 /*                                                                          */
 /****************************************************************************/
-int
+static int
 ips_release(struct Scsi_Host *sh)
 {
 	ips_scb_t *scb;
@@ -874,7 +872,7 @@
 /* NOTE: this routine is called under the io_request_lock spinlock          */
 /*                                                                          */
 /****************************************************************************/
-int
+static int
 ips_eh_reset(Scsi_Cmnd * SC)
 {
 	int ret;
@@ -1074,7 +1072,7 @@
 /*    Linux obtains io_request_lock before calling this function            */
 /*                                                                          */
 /****************************************************************************/
-int
+static int
 ips_queue(Scsi_Cmnd * SC, void (*done) (Scsi_Cmnd *))
 {
 	ips_ha_t *ha;
@@ -1297,7 +1295,7 @@
 /*   Set queue depths on devices once scan is complete                      */
 /*                                                                          */
 /****************************************************************************/
-int
+static int
 ips_slave_configure(Scsi_Device * SDptr)
 {
 	ips_ha_t *ha;
@@ -1323,7 +1321,7 @@
 /*   Wrapper for the interrupt handler                                      */
 /*                                                                          */
 /****************************************************************************/
-irqreturn_t
+static irqreturn_t
 do_ipsintr(int irq, void *dev_id, struct pt_regs * regs)
 {
 	ips_ha_t *ha;
@@ -1502,7 +1500,7 @@
 /*   Return info about the driver                                           */
 /*                                                                          */
 /****************************************************************************/
-const char *
+static const char *
 ips_info(struct Scsi_Host *SH)
 {
 	static char buffer[256];
@@ -1540,7 +1538,7 @@
 /*   The passthru interface for the driver                                  */
 /*                                                                          */
 /****************************************************************************/
-int
+static int
 ips_proc_info(struct Scsi_Host *host, char *buffer, char **start, off_t offset,
 	      int length, int func)
 {

