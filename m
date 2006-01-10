Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWAJV7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWAJV7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWAJV7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:59:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41226 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932519AbWAJV7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:59:33 -0500
Date: Tue, 10 Jan 2006 22:59:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/aic7xxx/: possible cleanups
Message-ID: <20060110215931.GG3911@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global functions:
  - aic79xx_core.c: ahd_print_scb
  - aic79xx_core.c: ahd_suspend
  - aic79xx_core.c: ahd_resume
  - aic79xx_core.c: ahd_dump_scbs
  - aic79xx_osm.c: ahd_softc_comp

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/aic7xxx/aic79xx.h         |   53 -----
 drivers/scsi/aic7xxx/aic79xx_core.c    |  262 +++++++++++++++----------
 drivers/scsi/aic7xxx/aic79xx_inline.h  |   30 --
 drivers/scsi/aic7xxx/aic79xx_osm.c     |    4 
 drivers/scsi/aic7xxx/aic79xx_osm.h     |    6 
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c |    2 
 drivers/scsi/aic7xxx/aic79xx_pci.c     |    7 
 drivers/scsi/aic7xxx/aic79xx_proc.c    |    2 
 drivers/scsi/aic7xxx/aic7xxx.h         |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm.c     |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm.h     |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |    2 
 drivers/scsi/aic7xxx/aic7xxx_pci.c     |    4 
 13 files changed, 178 insertions(+), 200 deletions(-)

--- devel/drivers/scsi/aic7xxx/aic79xx_inline.h~drivers-scsi-aic7xxx-possible-cleanups	2005-07-12 15:26:40.000000000 -0700
+++ devel-akpm/drivers/scsi/aic7xxx/aic79xx_inline.h	2005-07-12 15:26:40.000000000 -0700
@@ -418,10 +418,6 @@ ahd_targetcmd_offset(struct ahd_softc *a
 }
 
 /*********************** Miscelaneous Support Functions ***********************/
-static __inline void	ahd_complete_scb(struct ahd_softc *ahd,
-					 struct scb *scb);
-static __inline void	ahd_update_residual(struct ahd_softc *ahd,
-					    struct scb *scb);
 static __inline struct ahd_initiator_tinfo *
 			ahd_fetch_transinfo(struct ahd_softc *ahd,
 					    char channel, u_int our_id,
@@ -467,32 +463,6 @@ static __inline uint32_t
 			ahd_get_sense_bufaddr(struct ahd_softc *ahd,
 					      struct scb *scb);
 
-static __inline void
-ahd_complete_scb(struct ahd_softc *ahd, struct scb *scb)
-{
-	uint32_t sgptr;
-
-	sgptr = ahd_le32toh(scb->hscb->sgptr);
-	if ((sgptr & SG_STATUS_VALID) != 0)
-		ahd_handle_scb_status(ahd, scb);
-	else
-		ahd_done(ahd, scb);
-}
-
-/*
- * Determine whether the sequencer reported a residual
- * for this SCB/transaction.
- */
-static __inline void
-ahd_update_residual(struct ahd_softc *ahd, struct scb *scb)
-{
-	uint32_t sgptr;
-
-	sgptr = ahd_le32toh(scb->hscb->sgptr);
-	if ((sgptr & SG_STATUS_VALID) != 0)
-		ahd_calc_residual(ahd, scb);
-}
-
 /*
  * Return pointers to the transfer negotiation information
  * for the specified our_id/remote_id pair.
--- devel/drivers/scsi/aic7xxx/aic79xx_osm_pci.c~drivers-scsi-aic7xxx-possible-cleanups	2005-07-12 15:26:40.000000000 -0700
+++ devel-akpm/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2005-07-12 15:26:40.000000000 -0700
@@ -82,7 +82,7 @@ static struct pci_device_id ahd_linux_pc
 
 MODULE_DEVICE_TABLE(pci, ahd_linux_pci_id_table);
 
-struct pci_driver aic79xx_pci_driver = {
+static struct pci_driver aic79xx_pci_driver = {
 	.name		= "aic79xx",
 	.probe		= ahd_linux_pci_dev_probe,
 	.remove		= ahd_linux_pci_dev_remove,
diff -puN drivers/scsi/aic7xxx/aic79xx_pci.c~drivers-scsi-aic7xxx-possible-cleanups drivers/scsi/aic7xxx/aic79xx_pci.c
--- devel/drivers/scsi/aic7xxx/aic79xx_pci.c~drivers-scsi-aic7xxx-possible-cleanups	2005-07-12 15:26:40.000000000 -0700
+++ devel-akpm/drivers/scsi/aic7xxx/aic79xx_pci.c	2005-07-12 15:26:40.000000000 -0700
@@ -99,7 +99,7 @@ static ahd_device_setup_t ahd_aic7901A_s
 static ahd_device_setup_t ahd_aic7902_setup;
 static ahd_device_setup_t ahd_aic790X_setup;
 
-struct ahd_pci_identity ahd_pci_ident_table [] =
+static struct ahd_pci_identity ahd_pci_ident_table [] =
 {
 	/* aic7901 based controllers */
 	{
@@ -196,7 +196,7 @@ struct ahd_pci_identity ahd_pci_ident_ta
 	}
 };
 
-const u_int ahd_num_pci_devs = NUM_ELEMENTS(ahd_pci_ident_table);
+static const u_int ahd_num_pci_devs = NUM_ELEMENTS(ahd_pci_ident_table);
 		
 #define	DEVCONFIG		0x40
 #define		PCIXINITPAT	0x0000E000ul
@@ -240,6 +240,7 @@ static int	ahd_check_extport(struct ahd_
 static void	ahd_configure_termination(struct ahd_softc *ahd,
 					  u_int adapter_control);
 static void	ahd_pci_split_intr(struct ahd_softc *ahd, u_int intstat);
+static void	ahd_pci_intr(struct ahd_softc *ahd);
 
 struct ahd_pci_identity *
 ahd_find_pci_device(ahd_dev_softc_t pci)
@@ -759,7 +760,7 @@ static const char *pci_status_strings[] 
 	"%s: Address or Write Phase Parity Error Detected in %s.\n"
 };
 
-void
+static void
 ahd_pci_intr(struct ahd_softc *ahd)
 {
 	uint8_t		pci_status[8];
diff -puN drivers/scsi/aic7xxx/aic7xxx.h~drivers-scsi-aic7xxx-possible-cleanups drivers/scsi/aic7xxx/aic7xxx.h
--- devel/drivers/scsi/aic7xxx/aic7xxx.h~drivers-scsi-aic7xxx-possible-cleanups	2005-07-12 15:26:40.000000000 -0700
+++ devel-akpm/drivers/scsi/aic7xxx/aic7xxx.h	2005-07-12 15:26:40.000000000 -0700
@@ -1136,8 +1136,6 @@ struct ahc_pci_identity {
 	char			*name;
 	ahc_device_setup_t	*setup;
 };
-extern struct ahc_pci_identity ahc_pci_ident_table[];
-extern const u_int ahc_num_pci_devs;
 
 /***************************** VL/EISA Declarations ***************************/
 struct aic7770_identity {
diff -puN drivers/scsi/aic7xxx/aic7xxx_osm.c~drivers-scsi-aic7xxx-possible-cleanups drivers/scsi/aic7xxx/aic7xxx_osm.c
--- devel/drivers/scsi/aic7xxx/aic7xxx_osm.c~drivers-scsi-aic7xxx-possible-cleanups	2005-07-12 15:26:40.000000000 -0700
+++ devel-akpm/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-07-12 15:26:40.000000000 -0700
@@ -334,7 +334,7 @@ static uint32_t aic7xxx_seltime;
  * force all outstanding transactions to be serviced prior to a new
  * transaction.
  */
-uint32_t aic7xxx_periodic_otag;
+static uint32_t aic7xxx_periodic_otag;
 
 /*
  * Module information and settable options.
diff -puN drivers/scsi/aic7xxx/aic7xxx_osm.h~drivers-scsi-aic7xxx-possible-cleanups drivers/scsi/aic7xxx/aic7xxx_osm.h
--- devel/drivers/scsi/aic7xxx/aic7xxx_osm.h~drivers-scsi-aic7xxx-possible-cleanups	2005-07-12 15:26:40.000000000 -0700
+++ devel-akpm/drivers/scsi/aic7xxx/aic7xxx_osm.h	2005-07-12 15:26:40.000000000 -0700
@@ -565,8 +565,6 @@ ahc_unlock(struct ahc_softc *ahc, unsign
 #define PCIR_SUBVEND_0	0x2c
 #define PCIR_SUBDEV_0	0x2e
 
-extern struct pci_driver aic7xxx_pci_driver;
-
 typedef enum
 {
 	AHC_POWER_STATE_D0,
diff -puN drivers/scsi/aic7xxx/aic7xxx_osm_pci.c~drivers-scsi-aic7xxx-possible-cleanups drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
--- devel/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c~drivers-scsi-aic7xxx-possible-cleanups	2005-07-12 15:26:40.000000000 -0700
+++ devel-akpm/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2005-07-12 15:26:40.000000000 -0700
@@ -130,7 +130,7 @@ static struct pci_device_id ahc_linux_pc
 
 MODULE_DEVICE_TABLE(pci, ahc_linux_pci_id_table);
 
-struct pci_driver aic7xxx_pci_driver = {
+static struct pci_driver aic7xxx_pci_driver = {
 	.name		= "aic7xxx",
 	.probe		= ahc_linux_pci_dev_probe,
 	.remove		= ahc_linux_pci_dev_remove,
diff -puN drivers/scsi/aic7xxx/aic7xxx_pci.c~drivers-scsi-aic7xxx-possible-cleanups drivers/scsi/aic7xxx/aic7xxx_pci.c
--- devel/drivers/scsi/aic7xxx/aic7xxx_pci.c~drivers-scsi-aic7xxx-possible-cleanups	2005-07-12 15:26:40.000000000 -0700
+++ devel-akpm/drivers/scsi/aic7xxx/aic7xxx_pci.c	2005-07-12 15:26:40.000000000 -0700
@@ -164,7 +164,7 @@ static ahc_device_setup_t ahc_aha394XX_s
 static ahc_device_setup_t ahc_aha494XX_setup;
 static ahc_device_setup_t ahc_aha398XX_setup;
 
-struct ahc_pci_identity ahc_pci_ident_table [] =
+static struct ahc_pci_identity ahc_pci_ident_table [] =
 {
 	/* aic7850 based controllers */
 	{
@@ -549,7 +549,7 @@ struct ahc_pci_identity ahc_pci_ident_ta
 	}
 };
 
-const u_int ahc_num_pci_devs = NUM_ELEMENTS(ahc_pci_ident_table);
+static const u_int ahc_num_pci_devs = NUM_ELEMENTS(ahc_pci_ident_table);
 		
 #define AHC_394X_SLOT_CHANNEL_A	4
 #define AHC_394X_SLOT_CHANNEL_B	5
_
--- linux-2.6.15-mm2-full/drivers/scsi/aic7xxx/aic79xx_osm.h.old	2006-01-10 22:15:33.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/scsi/aic7xxx/aic79xx_osm.h	2006-01-10 22:17:42.000000000 +0100
@@ -526,9 +526,6 @@
 	int pos;
 };
 
-void	ahd_format_transinfo(struct info_str *info,
-			     struct ahd_transinfo *tinfo);
-
 /******************************** Locking *************************************/
 static __inline void
 ahd_lockinit(struct ahd_softc *ahd)
@@ -602,8 +599,6 @@
 #define PCIXM_STATUS_MAXCRDS	0x1C00	/* Maximum Cumulative Read Size */
 #define PCIXM_STATUS_RCVDSCEM	0x2000	/* Received a Split Comp w/Error msg */
 
-extern struct pci_driver aic79xx_pci_driver;
-
 typedef enum
 {
 	AHD_POWER_STATE_D0,
@@ -884,7 +879,6 @@
 irqreturn_t
 	ahd_linux_isr(int irq, void *dev_id, struct pt_regs * regs);
 void	ahd_platform_flushwork(struct ahd_softc *ahd);
-int	ahd_softc_comp(struct ahd_softc *, struct ahd_softc *);
 void	ahd_done(struct ahd_softc*, struct scb*);
 void	ahd_send_async(struct ahd_softc *, char channel,
 		       u_int target, u_int lun, ac_code, void *);
--- linux-2.6.15-mm2-full/drivers/scsi/aic7xxx/aic79xx_osm.c.old	2006-01-10 22:15:49.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/scsi/aic7xxx/aic79xx_osm.c	2006-01-10 22:16:59.000000000 +0100
@@ -312,7 +312,7 @@
  * force all outstanding transactions to be serviced prior to a new
  * transaction.
  */
-uint32_t aic79xx_periodic_otag;
+static uint32_t aic79xx_periodic_otag;
 
 /*
  * Module information and settable options.
@@ -794,6 +794,7 @@
 	return (0);
 }
 
+#if 0
 /********************* Platform Dependent Functions ***************************/
 /*
  * Compare "left hand" softc with "right hand" softc, returning:
@@ -847,6 +848,7 @@
 	value = rahd->channel - lahd->channel;
 	return (value);
 }
+#endif  /*  0  */
 
 static void
 ahd_linux_setup_iocell_info(u_long index, int instance, int targ, int32_t value)
--- linux-2.6.15-mm2-full/drivers/scsi/aic7xxx/aic79xx_proc.c.old	2006-01-10 22:17:57.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/scsi/aic7xxx/aic79xx_proc.c	2006-01-10 22:18:05.000000000 +0100
@@ -138,7 +138,7 @@
 	return (len);
 }
 
-void
+static void
 ahd_format_transinfo(struct info_str *info, struct ahd_transinfo *tinfo)
 {
 	u_int speed;
--- linux-2.6.15-mm2-full/drivers/scsi/aic7xxx/aic79xx.h.old	2006-01-10 21:43:06.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/scsi/aic7xxx/aic79xx.h	2006-01-10 22:21:52.000000000 +0100
@@ -974,8 +974,6 @@
 
 int		ahd_write_seeprom(struct ahd_softc *ahd, uint16_t *buf,
 				  u_int start_addr, u_int count);
-int		ahd_wait_seeprom(struct ahd_softc *ahd);
-int		ahd_verify_vpd_cksum(struct vpd_config *vpd);
 int		ahd_verify_cksum(struct seeprom_config *sc);
 int		ahd_acquire_seeprom(struct ahd_softc *ahd);
 void		ahd_release_seeprom(struct ahd_softc *ahd);
@@ -1308,8 +1306,6 @@
 	char			*name;
 	ahd_device_setup_t	*setup;
 };
-extern struct ahd_pci_identity ahd_pci_ident_table [];
-extern const u_int ahd_num_pci_devs;
 
 /***************************** VL/EISA Declarations ***************************/
 struct aic7770_identity {
@@ -1327,15 +1323,6 @@
 /*************************** Function Declarations ****************************/
 /******************************************************************************/
 void			ahd_reset_cmds_pending(struct ahd_softc *ahd);
-u_int			ahd_find_busy_tcl(struct ahd_softc *ahd, u_int tcl);
-void			ahd_busy_tcl(struct ahd_softc *ahd,
-				     u_int tcl, u_int busyid);
-static __inline void	ahd_unbusy_tcl(struct ahd_softc *ahd, u_int tcl);
-static __inline void
-ahd_unbusy_tcl(struct ahd_softc *ahd, u_int tcl)
-{
-	ahd_busy_tcl(ahd, tcl, SCB_LIST_NULL);
-}
 
 /***************************** PCI Front End *********************************/
 struct	ahd_pci_identity *ahd_find_pci_device(ahd_dev_softc_t);
@@ -1344,7 +1331,6 @@
 int	ahd_pci_test_register_access(struct ahd_softc *);
 
 /************************** SCB and SCB queue management **********************/
-int		ahd_probe_scbs(struct ahd_softc *);
 void		ahd_qinfifo_requeue_tail(struct ahd_softc *ahd,
 					 struct scb *scb);
 int		ahd_match_scb(struct ahd_softc *ahd, struct scb *scb,
@@ -1362,33 +1348,20 @@
 int			 ahd_parse_cfgdata(struct ahd_softc *ahd,
 					   struct seeprom_config *sc);
 void			 ahd_intr_enable(struct ahd_softc *ahd, int enable);
-void			 ahd_update_coalescing_values(struct ahd_softc *ahd,
-						      u_int timer,
-						      u_int maxcmds,
-						      u_int mincmds);
-void			 ahd_enable_coalescing(struct ahd_softc *ahd,
-					       int enable);
 void			 ahd_pause_and_flushwork(struct ahd_softc *ahd);
 int			 ahd_suspend(struct ahd_softc *ahd); 
-int			 ahd_resume(struct ahd_softc *ahd);
 void			 ahd_set_unit(struct ahd_softc *, int);
 void			 ahd_set_name(struct ahd_softc *, char *);
 struct scb		*ahd_get_scb(struct ahd_softc *ahd, u_int col_idx);
 void			 ahd_free_scb(struct ahd_softc *ahd, struct scb *scb);
-void			 ahd_alloc_scbs(struct ahd_softc *ahd);
 void			 ahd_free(struct ahd_softc *ahd);
 int			 ahd_reset(struct ahd_softc *ahd, int reinit);
-void			 ahd_shutdown(void *arg);
 int			 ahd_write_flexport(struct ahd_softc *ahd,
 					    u_int addr, u_int value);
 int			 ahd_read_flexport(struct ahd_softc *ahd, u_int addr,
 					   uint8_t *value);
-int			 ahd_wait_flexport(struct ahd_softc *ahd);
 
 /*************************** Interrupt Services *******************************/
-void			ahd_pci_intr(struct ahd_softc *ahd);
-void			ahd_clear_intstat(struct ahd_softc *ahd);
-void			ahd_flush_qoutfifo(struct ahd_softc *ahd);
 void			ahd_run_qoutfifo(struct ahd_softc *ahd);
 #ifdef AHD_TARGET_MODE
 void			ahd_run_tqinfifo(struct ahd_softc *ahd, int paused);
@@ -1397,7 +1370,6 @@
 void			ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat);
 void			ahd_handle_scsiint(struct ahd_softc *ahd,
 					   u_int intstat);
-void			ahd_clear_critical_section(struct ahd_softc *ahd);
 
 /***************************** Error Recovery *********************************/
 typedef enum {
@@ -1414,23 +1386,9 @@
 					     char channel, int lun, u_int tag,
 					     int stop_on_first, int remove,
 					     int save_state);
-void			ahd_freeze_devq(struct ahd_softc *ahd, struct scb *scb);
 int			ahd_reset_channel(struct ahd_softc *ahd, char channel,
 					  int initiate_reset);
-int			ahd_abort_scbs(struct ahd_softc *ahd, int target,
-				       char channel, int lun, u_int tag,
-				       role_t role, uint32_t status);
-void			ahd_restart(struct ahd_softc *ahd);
-void			ahd_clear_fifo(struct ahd_softc *ahd, u_int fifo);
-void			ahd_handle_scb_status(struct ahd_softc *ahd,
-					      struct scb *scb);
-void			ahd_handle_scsi_status(struct ahd_softc *ahd,
-					       struct scb *scb);
-void			ahd_calc_residual(struct ahd_softc *ahd,
-					  struct scb *scb);
 /*************************** Utility Functions ********************************/
-struct ahd_phase_table_entry*
-			ahd_lookup_phase_entry(int phase);
 void			ahd_compile_devinfo(struct ahd_devinfo *devinfo,
 					    u_int our_id, u_int target,
 					    u_int lun, char channel,
@@ -1438,14 +1396,6 @@
 /************************** Transfer Negotiation ******************************/
 void			ahd_find_syncrate(struct ahd_softc *ahd, u_int *period,
 					  u_int *ppr_options, u_int maxsync);
-void			ahd_validate_offset(struct ahd_softc *ahd,
-					    struct ahd_initiator_tinfo *tinfo,
-					    u_int period, u_int *offset,
-					    int wide, role_t role);
-void			ahd_validate_width(struct ahd_softc *ahd,
-					   struct ahd_initiator_tinfo *tinfo,
-					   u_int *bus_width,
-					   role_t role);
 /*
  * Negotiation types.  These are used to qualify if we should renegotiate
  * even if our goal and current transport parameters are identical.
@@ -1515,10 +1465,8 @@
 #define AHD_SHOW_INT_COALESCING	0x10000
 #define AHD_DEBUG_SEQUENCER	0x20000
 #endif
-void			ahd_print_scb(struct scb *scb);
 void			ahd_print_devinfo(struct ahd_softc *ahd,
 					  struct ahd_devinfo *devinfo);
-void			ahd_dump_sglist(struct scb *scb);
 void			ahd_dump_card_state(struct ahd_softc *ahd);
 int			ahd_print_register(ahd_reg_parse_entry_t *table,
 					   u_int num_entries,
@@ -1527,5 +1475,4 @@
 					   u_int value,
 					   u_int *cur_column,
 					   u_int wrap_point);
-void			ahd_dump_scbs(struct ahd_softc *ahd);
 #endif /* _AIC79XX_H_ */
--- linux-2.6.15-mm2-full/drivers/scsi/aic7xxx/aic79xx_core.c.old	2006-01-10 22:34:30.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/scsi/aic7xxx/aic79xx_core.c	2006-01-10 22:38:47.000000000 +0100
@@ -54,7 +54,7 @@
 
 
 /***************************** Lookup Tables **********************************/
-char *ahd_chip_names[] =
+static char *ahd_chip_names[] =
 {
 	"NONE",
 	"aic7901",
@@ -157,7 +157,7 @@
 	AHDMSG_1B,
 	AHDMSG_2B,
 	AHDMSG_EXT
-} ahd_msgtype;
+	} ahd_msgtype;
 static int		ahd_sent_msg(struct ahd_softc *ahd, ahd_msgtype type,
 				     u_int msgval, int full);
 static int		ahd_parse_msg(struct ahd_softc *ahd,
@@ -239,10 +239,33 @@
 					      struct target_cmd *cmd);
 #endif
 
+static int		ahd_abort_scbs(struct ahd_softc *ahd, int target,
+				       char channel, int lun, u_int tag,
+				       role_t role, uint32_t status);
+static void		ahd_alloc_scbs(struct ahd_softc *ahd);
+static void		ahd_busy_tcl(struct ahd_softc *ahd, u_int tcl,
+				     u_int scbid);
+static void		ahd_calc_residual(struct ahd_softc *ahd,
+					  struct scb *scb);
+static void		ahd_clear_critical_section(struct ahd_softc *ahd);
+static void		ahd_clear_intstat(struct ahd_softc *ahd);
+static void		ahd_enable_coalescing(struct ahd_softc *ahd,
+					      int enable);
+static u_int		ahd_find_busy_tcl(struct ahd_softc *ahd, u_int tcl);
+static void		ahd_freeze_devq(struct ahd_softc *ahd,
+					struct scb *scb);
+static void		ahd_handle_scb_status(struct ahd_softc *ahd,
+					      struct scb *scb);
+static struct ahd_phase_table_entry* ahd_lookup_phase_entry(int phase);
+static void		ahd_shutdown(void *arg);
+static void		ahd_update_coalescing_values(struct ahd_softc *ahd,
+						     u_int timer,
+						     u_int maxcmds,
+						     u_int mincmds);
+static int		ahd_verify_vpd_cksum(struct vpd_config *vpd);
+static int		ahd_wait_seeprom(struct ahd_softc *ahd);
+
 /******************************** Private Inlines *****************************/
-static __inline void	ahd_assert_atn(struct ahd_softc *ahd);
-static __inline int	ahd_currently_packetized(struct ahd_softc *ahd);
-static __inline int	ahd_set_active_fifo(struct ahd_softc *ahd);
 
 static __inline void
 ahd_assert_atn(struct ahd_softc *ahd)
@@ -296,11 +319,44 @@
 	}
 }
 
+static __inline void
+ahd_unbusy_tcl(struct ahd_softc *ahd, u_int tcl)
+{
+	ahd_busy_tcl(ahd, tcl, SCB_LIST_NULL);
+}
+
+/*
+ * Determine whether the sequencer reported a residual
+ * for this SCB/transaction.
+ */
+static __inline void
+ahd_update_residual(struct ahd_softc *ahd, struct scb *scb)
+{
+	uint32_t sgptr;
+
+	sgptr = ahd_le32toh(scb->hscb->sgptr);
+	if ((sgptr & SG_STATUS_VALID) != 0)
+		ahd_calc_residual(ahd, scb);
+}
+
+static __inline void
+ahd_complete_scb(struct ahd_softc *ahd, struct scb *scb)
+{
+	uint32_t sgptr;
+
+	sgptr = ahd_le32toh(scb->hscb->sgptr);
+	if ((sgptr & SG_STATUS_VALID) != 0)
+		ahd_handle_scb_status(ahd, scb);
+	else
+		ahd_done(ahd, scb);
+}
+
+
 /************************* Sequencer Execution Control ************************/
 /*
  * Restart the sequencer program from address zero
  */
-void
+static void
 ahd_restart(struct ahd_softc *ahd)
 {
 
@@ -336,7 +392,7 @@
 	ahd_unpause(ahd);
 }
 
-void
+static void
 ahd_clear_fifo(struct ahd_softc *ahd, u_int fifo)
 {
 	ahd_mode_state	 saved_modes;
@@ -360,7 +416,7 @@
  * Flush and completed commands that are sitting in the command
  * complete queues down on the chip but have yet to be dma'ed back up.
  */
-void
+static void
 ahd_flush_qoutfifo(struct ahd_softc *ahd)
 {
 	struct		scb *scb;
@@ -845,6 +901,51 @@
 	ahd_free(ahd);
 }
 
+#ifdef AHD_DEBUG
+static void
+ahd_dump_sglist(struct scb *scb)
+{
+	int i;
+
+	if (scb->sg_count > 0) {
+		if ((scb->ahd_softc->flags & AHD_64BIT_ADDRESSING) != 0) {
+			struct ahd_dma64_seg *sg_list;
+
+			sg_list = (struct ahd_dma64_seg*)scb->sg_list;
+			for (i = 0; i < scb->sg_count; i++) {
+				uint64_t addr;
+				uint32_t len;
+
+				addr = ahd_le64toh(sg_list[i].addr);
+				len = ahd_le32toh(sg_list[i].len);
+				printf("sg[%d] - Addr 0x%x%x : Length %d%s\n",
+				       i,
+				       (uint32_t)((addr >> 32) & 0xFFFFFFFF),
+				       (uint32_t)(addr & 0xFFFFFFFF),
+				       sg_list[i].len & AHD_SG_LEN_MASK,
+				       (sg_list[i].len & AHD_DMA_LAST_SEG)
+				     ? " Last" : "");
+			}
+		} else {
+			struct ahd_dma_seg *sg_list;
+
+			sg_list = (struct ahd_dma_seg*)scb->sg_list;
+			for (i = 0; i < scb->sg_count; i++) {
+				uint32_t len;
+
+				len = ahd_le32toh(sg_list[i].len);
+				printf("sg[%d] - Addr 0x%x%x : Length %d%s\n",
+				       i,
+				       (len & AHD_SG_HIGH_ADDR_MASK) >> 24,
+				       ahd_le32toh(sg_list[i].addr),
+				       len & AHD_SG_LEN_MASK,
+				       len & AHD_DMA_LAST_SEG ? " Last" : "");
+			}
+		}
+	}
+}
+#endif  /*  AHD_DEBUG  */
+
 void
 ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat)
 {
@@ -2439,7 +2540,7 @@
 }
 
 #define AHD_MAX_STEPS 2000
-void
+static void
 ahd_clear_critical_section(struct ahd_softc *ahd)
 {
 	ahd_mode_state	saved_modes;
@@ -2563,7 +2664,7 @@
 /*
  * Clear any pending interrupt status.
  */
-void
+static void
 ahd_clear_intstat(struct ahd_softc *ahd)
 {
 	AHD_ASSERT_MODES(ahd, ~(AHD_MODE_UNKNOWN_MSK|AHD_MODE_CFG_MSK),
@@ -2594,6 +2695,8 @@
 #ifdef AHD_DEBUG
 uint32_t ahd_debug = AHD_DEBUG_OPTS;
 #endif
+
+#if 0
 void
 ahd_print_scb(struct scb *scb)
 {
@@ -2618,49 +2721,7 @@
 	       SCB_GET_TAG(scb));
 	ahd_dump_sglist(scb);
 }
-
-void
-ahd_dump_sglist(struct scb *scb)
-{
-	int i;
-
-	if (scb->sg_count > 0) {
-		if ((scb->ahd_softc->flags & AHD_64BIT_ADDRESSING) != 0) {
-			struct ahd_dma64_seg *sg_list;
-
-			sg_list = (struct ahd_dma64_seg*)scb->sg_list;
-			for (i = 0; i < scb->sg_count; i++) {
-				uint64_t addr;
-				uint32_t len;
-
-				addr = ahd_le64toh(sg_list[i].addr);
-				len = ahd_le32toh(sg_list[i].len);
-				printf("sg[%d] - Addr 0x%x%x : Length %d%s\n",
-				       i,
-				       (uint32_t)((addr >> 32) & 0xFFFFFFFF),
-				       (uint32_t)(addr & 0xFFFFFFFF),
-				       sg_list[i].len & AHD_SG_LEN_MASK,
-				       (sg_list[i].len & AHD_DMA_LAST_SEG)
-				     ? " Last" : "");
-			}
-		} else {
-			struct ahd_dma_seg *sg_list;
-
-			sg_list = (struct ahd_dma_seg*)scb->sg_list;
-			for (i = 0; i < scb->sg_count; i++) {
-				uint32_t len;
-
-				len = ahd_le32toh(sg_list[i].len);
-				printf("sg[%d] - Addr 0x%x%x : Length %d%s\n",
-				       i,
-				       (len & AHD_SG_HIGH_ADDR_MASK) >> 24,
-				       ahd_le32toh(sg_list[i].addr),
-				       len & AHD_SG_LEN_MASK,
-				       len & AHD_DMA_LAST_SEG ? " Last" : "");
-			}
-		}
-	}
-}
+#endif  /*  0  */
 
 /************************* Transfer Negotiation *******************************/
 /*
@@ -2823,7 +2884,7 @@
  * Truncate the given synchronous offset to a value the
  * current adapter type and syncrate are capable of.
  */
-void
+static void
 ahd_validate_offset(struct ahd_softc *ahd,
 		    struct ahd_initiator_tinfo *tinfo,
 		    u_int period, u_int *offset, int wide,
@@ -2854,7 +2915,7 @@
  * Truncate the given transfer width parameter to a value the
  * current adapter type is capable of.
  */
-void
+static void
 ahd_validate_width(struct ahd_softc *ahd, struct ahd_initiator_tinfo *tinfo,
 		   u_int *bus_width, role_t role)
 {
@@ -3363,7 +3424,7 @@
 	       devinfo->target, devinfo->lun);
 }
 
-struct ahd_phase_table_entry*
+static struct ahd_phase_table_entry*
 ahd_lookup_phase_entry(int phase)
 {
 	struct ahd_phase_table_entry *entry;
@@ -5266,7 +5327,7 @@
 	return;
 }
 
-void
+static void
 ahd_shutdown(void *arg)
 {
 	struct	ahd_softc *ahd;
@@ -5395,7 +5456,7 @@
 /*
  * Determine the number of SCBs available on the controller
  */
-int
+static int
 ahd_probe_scbs(struct ahd_softc *ahd) {
 	int i;
 
@@ -5844,7 +5905,7 @@
 	ahd_platform_scb_free(ahd, scb);
 }
 
-void
+static void
 ahd_alloc_scbs(struct ahd_softc *ahd)
 {
 	struct scb_data *scb_data;
@@ -6884,7 +6945,7 @@
 	ahd_outb(ahd, HCNTRL, hcntrl);
 }
 
-void
+static void
 ahd_update_coalescing_values(struct ahd_softc *ahd, u_int timer, u_int maxcmds,
 			     u_int mincmds)
 {
@@ -6902,7 +6963,7 @@
 	ahd_outb(ahd, INT_COALESCING_MINCMDS, -mincmds);
 }
 
-void
+static void
 ahd_enable_coalescing(struct ahd_softc *ahd, int enable)
 {
 
@@ -6991,6 +7052,7 @@
 	ahd->flags &= ~AHD_ALL_INTERRUPTS;
 }
 
+#if 0
 int
 ahd_suspend(struct ahd_softc *ahd)
 {
@@ -7004,7 +7066,9 @@
 	ahd_shutdown(ahd);
 	return (0);
 }
+#endif  /*  0  */
 
+#if 0
 int
 ahd_resume(struct ahd_softc *ahd)
 {
@@ -7014,6 +7078,7 @@
 	ahd_restart(ahd);
 	return (0);
 }
+#endif  /*  0  */
 
 /************************** Busy Target Table *********************************/
 /*
@@ -7046,7 +7111,7 @@
 /*
  * Return the untagged transaction id for a given target/channel lun.
  */
-u_int
+static u_int
 ahd_find_busy_tcl(struct ahd_softc *ahd, u_int tcl)
 {
 	u_int scbid;
@@ -7059,7 +7124,7 @@
 	return (scbid);
 }
 
-void
+static void
 ahd_busy_tcl(struct ahd_softc *ahd, u_int tcl, u_int scbid)
 {
 	u_int scb_offset;
@@ -7107,7 +7172,7 @@
 	return match;
 }
 
-void
+static void
 ahd_freeze_devq(struct ahd_softc *ahd, struct scb *scb)
 {
 	int	target;
@@ -7548,7 +7613,7 @@
  * been modified from CAM_REQ_INPROG.  This routine assumes that the sequencer
  * is paused before it is called.
  */
-int
+static int
 ahd_abort_scbs(struct ahd_softc *ahd, int target, char channel,
 	       int lun, u_int tag, role_t role, uint32_t status)
 {
@@ -7896,18 +7961,8 @@
 }
 
 /****************************** Status Processing *****************************/
-void
-ahd_handle_scb_status(struct ahd_softc *ahd, struct scb *scb)
-{
-	if (scb->hscb->shared_data.istatus.scsi_status != 0) {
-		ahd_handle_scsi_status(ahd, scb);
-	} else {
-		ahd_calc_residual(ahd, scb);
-		ahd_done(ahd, scb);
-	}
-}
 
-void
+static void
 ahd_handle_scsi_status(struct ahd_softc *ahd, struct scb *scb)
 {
 	struct hardware_scb *hscb;
@@ -8115,10 +8170,21 @@
 	}
 }
 
+static void
+ahd_handle_scb_status(struct ahd_softc *ahd, struct scb *scb)
+{
+	if (scb->hscb->shared_data.istatus.scsi_status != 0) {
+		ahd_handle_scsi_status(ahd, scb);
+	} else {
+		ahd_calc_residual(ahd, scb);
+		ahd_done(ahd, scb);
+	}
+}
+
 /*
  * Calculate the residual for a just completed SCB.
  */
-void
+static void
 ahd_calc_residual(struct ahd_softc *ahd, struct scb *scb)
 {
 	struct hardware_scb *hscb;
@@ -8945,6 +9011,7 @@
 		ahd_unpause(ahd);
 }
 
+#if 0
 void
 ahd_dump_scbs(struct ahd_softc *ahd)
 {
@@ -8970,6 +9037,7 @@
 	ahd_set_scbptr(ahd, saved_scb_index);
 	ahd_restore_modes(ahd, saved_modes);
 }
+#endif  /*  0  */
 
 /**************************** Flexport Logic **********************************/
 /*
@@ -9072,7 +9140,7 @@
 /*
  * Wait ~100us for the serial eeprom to satisfy our request.
  */
-int
+static int
 ahd_wait_seeprom(struct ahd_softc *ahd)
 {
 	int cnt;
@@ -9090,7 +9158,7 @@
  * Validate the two checksums in the per_channel
  * vital product data struct.
  */
-int
+static int
 ahd_verify_vpd_cksum(struct vpd_config *vpd)
 {
 	int i;
@@ -9169,6 +9237,24 @@
 	/* Currently a no-op */
 }
 
+/*
+ * Wait at most 2 seconds for flexport arbitration to succeed.
+ */
+static int
+ahd_wait_flexport(struct ahd_softc *ahd)
+{
+	int cnt;
+
+	AHD_ASSERT_MODES(ahd, AHD_MODE_SCSI_MSK, AHD_MODE_SCSI_MSK);
+	cnt = 1000000 * 2 / 5;
+	while ((ahd_inb(ahd, BRDCTL) & FLXARBACK) == 0 && --cnt)
+		ahd_delay(5);
+
+	if (cnt == 0)
+		return (ETIMEDOUT);
+	return (0);
+}
+
 int
 ahd_write_flexport(struct ahd_softc *ahd, u_int addr, u_int value)
 {
@@ -9210,24 +9296,6 @@
 	return (0);
 }
 
-/*
- * Wait at most 2 seconds for flexport arbitration to succeed.
- */
-int
-ahd_wait_flexport(struct ahd_softc *ahd)
-{
-	int cnt;
-
-	AHD_ASSERT_MODES(ahd, AHD_MODE_SCSI_MSK, AHD_MODE_SCSI_MSK);
-	cnt = 1000000 * 2 / 5;
-	while ((ahd_inb(ahd, BRDCTL) & FLXARBACK) == 0 && --cnt)
-		ahd_delay(5);
-
-	if (cnt == 0)
-		return (ETIMEDOUT);
-	return (0);
-}
-
 /************************* Target Mode ****************************************/
 #ifdef AHD_TARGET_MODE
 cam_status
