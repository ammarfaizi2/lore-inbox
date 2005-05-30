Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVE3AcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVE3AcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 20:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVE3AcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 20:32:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16912 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261479AbVE3A2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 20:28:32 -0400
Date: Mon, 30 May 2005 02:28:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/aic7xxx/: possible cleanups
Message-ID: <20050530002830.GK10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global functions:
  - aic79xx_core.c: ahd_print_scb
  - aic79xx_core.c: ahd_suspend
  - aic79xx_core.c: ahd_resume
  - aic79xx_core.c: ahd_dump_all_cards_state
  - aic79xx_core.c: ahd_dump_scbs

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 17 May 2005
- 24 Apr 2005

 drivers/scsi/aic7xxx/aic79xx.h         |   49 ------
 drivers/scsi/aic7xxx/aic79xx_core.c    |  180 +++++++++++++++++--------
 drivers/scsi/aic7xxx/aic79xx_inline.h  |   30 ----
 drivers/scsi/aic7xxx/aic79xx_osm.c     |    2 
 drivers/scsi/aic7xxx/aic79xx_osm.h     |    2 
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c |    2 
 drivers/scsi/aic7xxx/aic79xx_pci.c     |    7 
 drivers/scsi/aic7xxx/aic7xxx.h         |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm.c     |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm.h     |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |    2 
 drivers/scsi/aic7xxx/aic7xxx_pci.c     |    4 
 12 files changed, 136 insertions(+), 148 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx.h.old	2005-04-23 23:10:12.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx.h	2005-04-23 23:59:29.000000000 +0200
@@ -974,8 +974,6 @@
 
 int		ahd_write_seeprom(struct ahd_softc *ahd, uint16_t *buf,
 				  u_int start_addr, u_int count);
-int		ahd_wait_seeprom(struct ahd_softc *ahd);
-int		ahd_verify_vpd_cksum(struct vpd_config *vpd);
 int		ahd_verify_cksum(struct seeprom_config *sc);
 int		ahd_acquire_seeprom(struct ahd_softc *ahd);
 void		ahd_release_seeprom(struct ahd_softc *ahd);
@@ -1311,8 +1309,6 @@
 	char			*name;
 	ahd_device_setup_t	*setup;
 };
-extern struct ahd_pci_identity ahd_pci_ident_table [];
-extern const u_int ahd_num_pci_devs;
 
 /***************************** VL/EISA Declarations ***************************/
 struct aic7770_identity {
@@ -1330,15 +1326,6 @@
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
@@ -1347,12 +1334,8 @@
 int	ahd_pci_test_register_access(struct ahd_softc *);
 
 /************************** SCB and SCB queue management **********************/
-int		ahd_probe_scbs(struct ahd_softc *);
 void		ahd_qinfifo_requeue_tail(struct ahd_softc *ahd,
 					 struct scb *scb);
-int		ahd_match_scb(struct ahd_softc *ahd, struct scb *scb,
-			      int target, char channel, int lun,
-			      u_int tag, role_t role);
 
 /****************************** Initialization ********************************/
 struct ahd_softc	*ahd_alloc(void *platform_arg, char *name);
@@ -1365,35 +1348,22 @@
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
 void			 ahd_softc_insert(struct ahd_softc *);
 struct ahd_softc	*ahd_find_softc(struct ahd_softc *ahd);
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
@@ -1402,7 +1372,6 @@
 void			ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat);
 void			ahd_handle_scsiint(struct ahd_softc *ahd,
 					   u_int intstat);
-void			ahd_clear_critical_section(struct ahd_softc *ahd);
 
 /***************************** Error Recovery *********************************/
 typedef enum {
@@ -1419,23 +1388,9 @@
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
@@ -1520,11 +1475,8 @@
 #define AHD_SHOW_INT_COALESCING	0x10000
 #define AHD_DEBUG_SEQUENCER	0x20000
 #endif
-void			ahd_print_scb(struct scb *scb);
 void			ahd_print_devinfo(struct ahd_softc *ahd,
 					  struct ahd_devinfo *devinfo);
-void			ahd_dump_sglist(struct scb *scb);
-void			ahd_dump_all_cards_state(void);
 void			ahd_dump_card_state(struct ahd_softc *ahd);
 int			ahd_print_register(ahd_reg_parse_entry_t *table,
 					   u_int num_entries,
@@ -1533,5 +1485,4 @@
 					   u_int value,
 					   u_int *cur_column,
 					   u_int wrap_point);
-void			ahd_dump_scbs(struct ahd_softc *ahd);
 #endif /* _AIC79XX_H_ */
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx_inline.h.old	2005-04-23 23:24:26.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx_inline.h	2005-04-23 23:36:45.000000000 +0200
@@ -418,10 +418,6 @@
 }
 
 /*********************** Miscelaneous Support Functions ***********************/
-static __inline void	ahd_complete_scb(struct ahd_softc *ahd,
-					 struct scb *scb);
-static __inline void	ahd_update_residual(struct ahd_softc *ahd,
-					    struct scb *scb);
 static __inline struct ahd_initiator_tinfo *
 			ahd_fetch_transinfo(struct ahd_softc *ahd,
 					    char channel, u_int our_id,
@@ -467,32 +463,6 @@
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
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx_core.c.old	2005-04-23 23:10:26.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx_core.c	2005-04-23 23:46:10.000000000 +0200
@@ -56,7 +56,7 @@
 struct ahd_softc_tailq ahd_tailq = TAILQ_HEAD_INITIALIZER(ahd_tailq);
 
 /***************************** Lookup Tables **********************************/
-char *ahd_chip_names[] =
+static char *ahd_chip_names[] =
 {
 	"NONE",
 	"aic7901",
@@ -159,7 +159,7 @@
 	AHDMSG_1B,
 	AHDMSG_2B,
 	AHDMSG_EXT
-} ahd_msgtype;
+	} ahd_msgtype;
 static int		ahd_sent_msg(struct ahd_softc *ahd, ahd_msgtype type,
 				     u_int msgval, int full);
 static int		ahd_parse_msg(struct ahd_softc *ahd,
@@ -241,10 +241,37 @@
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
+static void		ahd_dump_sglist(struct scb *scb);
+static void		ahd_enable_coalescing(struct ahd_softc *ahd,
+					      int enable);
+static u_int		ahd_find_busy_tcl(struct ahd_softc *ahd, u_int tcl);
+static void		ahd_freeze_devq(struct ahd_softc *ahd,
+					struct scb *scb);
+static void		ahd_handle_scb_status(struct ahd_softc *ahd,
+					      struct scb *scb);
+static struct ahd_phase_table_entry* ahd_lookup_phase_entry(int phase);
+static int		ahd_match_scb(struct ahd_softc *ahd, struct scb *scb,
+				      int target, char channel, int lun,
+				      u_int tag, role_t role);
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
@@ -298,11 +325,44 @@
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
 
@@ -338,7 +398,7 @@
 	ahd_unpause(ahd);
 }
 
-void
+static void
 ahd_clear_fifo(struct ahd_softc *ahd, u_int fifo)
 {
 	ahd_mode_state	 saved_modes;
@@ -362,7 +422,7 @@
  * Flush and completed commands that are sitting in the command
  * complete queues down on the chip but have yet to be dma'ed back up.
  */
-void
+static void
 ahd_flush_qoutfifo(struct ahd_softc *ahd)
 {
 	struct		scb *scb;
@@ -2441,7 +2501,7 @@
 }
 
 #define AHD_MAX_STEPS 2000
-void
+static void
 ahd_clear_critical_section(struct ahd_softc *ahd)
 {
 	ahd_mode_state	saved_modes;
@@ -2565,7 +2625,7 @@
 /*
  * Clear any pending interrupt status.
  */
-void
+static void
 ahd_clear_intstat(struct ahd_softc *ahd)
 {
 	AHD_ASSERT_MODES(ahd, ~(AHD_MODE_UNKNOWN_MSK|AHD_MODE_CFG_MSK),
@@ -2596,6 +2656,8 @@
 #ifdef AHD_DEBUG
 uint32_t ahd_debug = AHD_DEBUG_OPTS;
 #endif
+
+#if 0	
 void
 ahd_print_scb(struct scb *scb)
 {
@@ -2620,8 +2682,9 @@
 	       SCB_GET_TAG(scb));
 	ahd_dump_sglist(scb);
 }
+#endif  /*  0  */
 
-void
+static void
 ahd_dump_sglist(struct scb *scb)
 {
 	int i;
@@ -3365,7 +3428,7 @@
 	       devinfo->target, devinfo->lun);
 }
 
-struct ahd_phase_table_entry*
+static struct ahd_phase_table_entry*
 ahd_lookup_phase_entry(int phase)
 {
 	struct ahd_phase_table_entry *entry;
@@ -5336,7 +5399,7 @@
 	return;
 }
 
-void
+static void
 ahd_shutdown(void *arg)
 {
 	struct	ahd_softc *ahd;
@@ -5465,7 +5528,7 @@
 /*
  * Determine the number of SCBs available on the controller
  */
-int
+static int
 ahd_probe_scbs(struct ahd_softc *ahd) {
 	int i;
 
@@ -5914,7 +5977,7 @@
 	ahd_platform_scb_free(ahd, scb);
 }
 
-void
+static void
 ahd_alloc_scbs(struct ahd_softc *ahd)
 {
 	struct scb_data *scb_data;
@@ -6954,7 +7017,7 @@
 	ahd_outb(ahd, HCNTRL, hcntrl);
 }
 
-void
+static void
 ahd_update_coalescing_values(struct ahd_softc *ahd, u_int timer, u_int maxcmds,
 			     u_int mincmds)
 {
@@ -6972,7 +7035,7 @@
 	ahd_outb(ahd, INT_COALESCING_MINCMDS, -mincmds);
 }
 
-void
+static void
 ahd_enable_coalescing(struct ahd_softc *ahd, int enable)
 {
 
@@ -7061,6 +7124,7 @@
 	ahd->flags &= ~AHD_ALL_INTERRUPTS;
 }
 
+#if 0
 int
 ahd_suspend(struct ahd_softc *ahd)
 {
@@ -7074,7 +7138,9 @@
 	ahd_shutdown(ahd);
 	return (0);
 }
+#endif  /*  0  */
 
+#if 0
 int
 ahd_resume(struct ahd_softc *ahd)
 {
@@ -7084,6 +7150,7 @@
 	ahd_restart(ahd);
 	return (0);
 }
+#endif  /*  0  */
 
 /************************** Busy Target Table *********************************/
 /*
@@ -7116,7 +7183,7 @@
 /*
  * Return the untagged transaction id for a given target/channel lun.
  */
-u_int
+static u_int
 ahd_find_busy_tcl(struct ahd_softc *ahd, u_int tcl)
 {
 	u_int scbid;
@@ -7129,7 +7196,7 @@
 	return (scbid);
 }
 
-void
+static void
 ahd_busy_tcl(struct ahd_softc *ahd, u_int tcl, u_int scbid)
 {
 	u_int scb_offset;
@@ -7141,7 +7208,7 @@
 }
 
 /************************** SCB and SCB queue management **********************/
-int
+static int
 ahd_match_scb(struct ahd_softc *ahd, struct scb *scb, int target,
 	      char channel, int lun, u_int tag, role_t role)
 {
@@ -7177,7 +7244,7 @@
 	return match;
 }
 
-void
+static void
 ahd_freeze_devq(struct ahd_softc *ahd, struct scb *scb)
 {
 	int	target;
@@ -7618,7 +7685,7 @@
  * been modified from CAM_REQ_INPROG.  This routine assumes that the sequencer
  * is paused before it is called.
  */
-int
+static int
 ahd_abort_scbs(struct ahd_softc *ahd, int target, char channel,
 	       int lun, u_int tag, role_t role, uint32_t status)
 {
@@ -7985,18 +8052,8 @@
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
@@ -8204,10 +8261,21 @@
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
@@ -8745,6 +8813,7 @@
 	return (last_probe);
 }
 
+#if 0
 void
 ahd_dump_all_cards_state(void)
 {
@@ -8754,6 +8823,7 @@
 		ahd_dump_card_state(list_ahd);
 	}
 }
+#endif  /*  0  */
 
 int
 ahd_print_register(ahd_reg_parse_entry_t *table, u_int num_entries,
@@ -9045,6 +9115,7 @@
 		ahd_unpause(ahd);
 }
 
+#if 0
 void
 ahd_dump_scbs(struct ahd_softc *ahd)
 {
@@ -9070,6 +9141,7 @@
 	ahd_set_scbptr(ahd, saved_scb_index);
 	ahd_restore_modes(ahd, saved_modes);
 }
+#endif  /*  0  */
 
 /**************************** Flexport Logic **********************************/
 /*
@@ -9172,7 +9244,7 @@
 /*
  * Wait ~100us for the serial eeprom to satisfy our request.
  */
-int
+static int
 ahd_wait_seeprom(struct ahd_softc *ahd)
 {
 	int cnt;
@@ -9190,7 +9262,7 @@
  * Validate the two checksums in the per_channel
  * vital product data struct.
  */
-int
+static int
 ahd_verify_vpd_cksum(struct vpd_config *vpd)
 {
 	int i;
@@ -9269,6 +9341,24 @@
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
@@ -9310,24 +9400,6 @@
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
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx_osm.h.old	2005-04-23 23:49:47.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx_osm.h	2005-04-23 23:49:53.000000000 +0200
@@ -837,8 +837,6 @@
 #define PCIXM_STATUS_MAXCRDS	0x1C00	/* Maximum Cumulative Read Size */
 #define PCIXM_STATUS_RCVDSCEM	0x2000	/* Received a Split Comp w/Error msg */
 
-extern struct pci_driver aic79xx_pci_driver;
-
 typedef enum
 {
 	AHD_POWER_STATE_D0,
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx_osm_pci.c.old	2005-04-23 23:50:00.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2005-04-23 23:50:07.000000000 +0200
@@ -82,7 +82,7 @@
 
 MODULE_DEVICE_TABLE(pci, ahd_linux_pci_id_table);
 
-struct pci_driver aic79xx_pci_driver = {
+static struct pci_driver aic79xx_pci_driver = {
 	.name		= "aic79xx",
 	.probe		= ahd_linux_pci_dev_probe,
 	.remove		= ahd_linux_pci_dev_remove,
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx_pci.c.old	2005-04-23 23:50:48.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx_pci.c	2005-04-23 23:51:52.000000000 +0200
@@ -99,7 +99,7 @@
 static ahd_device_setup_t ahd_aic7902_setup;
 static ahd_device_setup_t ahd_aic790X_setup;
 
-struct ahd_pci_identity ahd_pci_ident_table [] =
+static struct ahd_pci_identity ahd_pci_ident_table [] =
 {
 	/* aic7901 based controllers */
 	{
@@ -196,7 +196,7 @@
 	}
 };
 
-const u_int ahd_num_pci_devs = NUM_ELEMENTS(ahd_pci_ident_table);
+static const u_int ahd_num_pci_devs = NUM_ELEMENTS(ahd_pci_ident_table);
 		
 #define	DEVCONFIG		0x40
 #define		PCIXINITPAT	0x0000E000ul
@@ -240,6 +240,7 @@
 static void	ahd_configure_termination(struct ahd_softc *ahd,
 					  u_int adapter_control);
 static void	ahd_pci_split_intr(struct ahd_softc *ahd, u_int intstat);
+static void	ahd_pci_intr(struct ahd_softc *ahd);
 
 struct ahd_pci_identity *
 ahd_find_pci_device(ahd_dev_softc_t pci)
@@ -759,7 +760,7 @@
 	"%s: Address or Write Phase Parity Error Detected in %s.\n"
 };
 
-void
+static void
 ahd_pci_intr(struct ahd_softc *ahd)
 {
 	uint8_t		pci_status[8];
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx_osm.c.old	2005-04-24 00:04:27.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-04-24 00:04:34.000000000 +0200
@@ -401,7 +401,7 @@
  * force all outstanding transactions to be serviced prior to a new
  * transaction.
  */
-uint32_t aic79xx_periodic_otag;
+static uint32_t aic79xx_periodic_otag;
 
 /*
  * Module information and settable options.
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic7xxx_osm.c.old	2005-04-23 23:54:42.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-04-23 23:54:52.000000000 +0200
@@ -421,7 +421,7 @@
  * force all outstanding transactions to be serviced prior to a new
  * transaction.
  */
-uint32_t aic7xxx_periodic_otag;
+static uint32_t aic7xxx_periodic_otag;
 
 /*
  * Module information and settable options.
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic7xxx_osm.h.old	2005-04-23 23:55:09.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic7xxx_osm.h	2005-04-23 23:55:14.000000000 +0200
@@ -797,8 +797,6 @@
 #define PCIR_SUBVEND_0	0x2c
 #define PCIR_SUBDEV_0	0x2e
 
-extern struct pci_driver aic7xxx_pci_driver;
-
 typedef enum
 {
 	AHC_POWER_STATE_D0,
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c.old	2005-04-23 23:55:21.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2005-04-23 23:55:27.000000000 +0200
@@ -130,7 +130,7 @@
 
 MODULE_DEVICE_TABLE(pci, ahc_linux_pci_id_table);
 
-struct pci_driver aic7xxx_pci_driver = {
+static struct pci_driver aic7xxx_pci_driver = {
 	.name		= "aic7xxx",
 	.probe		= ahc_linux_pci_dev_probe,
 	.remove		= ahc_linux_pci_dev_remove,
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic7xxx.h.old	2005-04-23 23:55:43.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic7xxx.h	2005-04-23 23:56:30.000000000 +0200
@@ -1143,8 +1143,6 @@
 	char			*name;
 	ahc_device_setup_t	*setup;
 };
-extern struct ahc_pci_identity ahc_pci_ident_table[];
-extern const u_int ahc_num_pci_devs;
 
 /***************************** VL/EISA Declarations ***************************/
 struct aic7770_identity {
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic7xxx_pci.c.old	2005-04-23 23:56:00.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/aic7xxx/aic7xxx_pci.c	2005-04-23 23:56:35.000000000 +0200
@@ -164,7 +164,7 @@
 static ahc_device_setup_t ahc_aha494XX_setup;
 static ahc_device_setup_t ahc_aha398XX_setup;
 
-struct ahc_pci_identity ahc_pci_ident_table [] =
+static struct ahc_pci_identity ahc_pci_ident_table [] =
 {
 	/* aic7850 based controllers */
 	{
@@ -549,7 +549,7 @@
 	}
 };
 
-const u_int ahc_num_pci_devs = NUM_ELEMENTS(ahc_pci_ident_table);
+static const u_int ahc_num_pci_devs = NUM_ELEMENTS(ahc_pci_ident_table);
 		
 #define AHC_394X_SLOT_CHANNEL_A	4
 #define AHC_394X_SLOT_CHANNEL_B	5

