Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWDRWO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWDRWO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWDRWO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:14:26 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12810 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750760AbWDRWOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:14:25 -0400
Date: Wed, 19 Apr 2006 00:14:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
Subject: [-mm patch] drivers/scsi/aic7xxx/: possible cleanups
Message-ID: <20060418221423.GW11582@stusta.de>
References: <20060418031423.3cbef2f7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418031423.3cbef2f7.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 03:14:23AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc1-mm2:
>...
> +aic7xxx-deinline-large-functions-save-80k-of-text.patch
>...
>  Various scsi fixes
>...

This patch contains cleanups including the following:
- make nedlessly global functions static
- #if 0 the following unused global functions:
  - aic7xxx_core.c: ahc_inq()
  - aic7xxx_core.c: ahc_outq()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/aic7xxx/aic79xx.h        |    6 ----
 drivers/scsi/aic7xxx/aic79xx_core.c   |   32 ++++++++++++++++----------
 drivers/scsi/aic7xxx/aic79xx_inline.h |    5 ----
 drivers/scsi/aic7xxx/aic79xx_osm.c    |    6 +++-
 drivers/scsi/aic7xxx/aic79xx_osm.h    |    6 ----
 drivers/scsi/aic7xxx/aic7xxx.h        |    6 ----
 drivers/scsi/aic7xxx/aic7xxx_core.c   |   26 +++++++++++++++------
 drivers/scsi/aic7xxx/aic7xxx_inline.h |    2 -
 drivers/scsi/aic7xxx/aic7xxx_osm.h    |    4 ---
 9 files changed, 43 insertions(+), 50 deletions(-)

--- linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic79xx.h.old	2006-04-18 22:13:02.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic79xx.h	2006-04-18 22:20:39.000000000 +0200
@@ -1336,7 +1336,6 @@
 
 /*************************** Function Declarations ****************************/
 /******************************************************************************/
-void			ahd_reset_cmds_pending(struct ahd_softc *ahd);
 
 /***************************** PCI Front End *********************************/
 struct	ahd_pci_identity *ahd_find_pci_device(ahd_dev_softc_t);
@@ -1373,14 +1372,9 @@
 					   uint8_t *value);
 
 /*************************** Interrupt Services *******************************/
-void			ahd_run_qoutfifo(struct ahd_softc *ahd);
 #ifdef AHD_TARGET_MODE
 void			ahd_run_tqinfifo(struct ahd_softc *ahd, int paused);
 #endif
-void			ahd_handle_hwerrint(struct ahd_softc *ahd);
-void			ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat);
-void			ahd_handle_scsiint(struct ahd_softc *ahd,
-					   u_int intstat);
 
 /***************************** Error Recovery *********************************/
 typedef enum {
--- linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic79xx_inline.h.old	2006-04-18 22:15:53.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic79xx_inline.h	2006-04-18 22:21:10.000000000 +0200
@@ -65,7 +65,6 @@
 					    ahd_mode *src, ahd_mode *dst);
 void ahd_set_modes(struct ahd_softc *ahd, ahd_mode src,
 				   ahd_mode dst);
-void ahd_update_modes(struct ahd_softc *ahd);
 static inline void ahd_assert_modes(struct ahd_softc *ahd, ahd_mode srcmode,
 				      ahd_mode dstmode, const char *file,
 				      int line);
@@ -257,8 +256,6 @@
 void	ahd_outw(struct ahd_softc *ahd, u_int port, u_int value);
 uint32_t ahd_inl(struct ahd_softc *ahd, u_int port);
 void	ahd_outl(struct ahd_softc *ahd, u_int port, uint32_t value);
-uint64_t ahd_inq(struct ahd_softc *ahd, u_int port);
-void	ahd_outq(struct ahd_softc *ahd, u_int port, uint64_t value);
 static inline u_int	ahd_get_scbptr(struct ahd_softc *ahd);
 static inline void	ahd_set_scbptr(struct ahd_softc *ahd, u_int scbptr);
 static inline u_int	ahd_get_hnscb_qoff(struct ahd_softc *ahd);
@@ -273,8 +270,6 @@
 static inline void	ahd_set_sdscb_qoff(struct ahd_softc *ahd, u_int value);
 u_int	ahd_inb_scbram(struct ahd_softc *ahd, u_int offset);
 u_int	ahd_inw_scbram(struct ahd_softc *ahd, u_int offset);
-uint32_t ahd_inl_scbram(struct ahd_softc *ahd, u_int offset);
-uint64_t ahd_inq_scbram(struct ahd_softc *ahd, u_int offset);
 struct scb *ahd_lookup_scb(struct ahd_softc *ahd, u_int tag);
 void	ahd_queue_scb(struct ahd_softc *ahd, struct scb *scb);
 static inline uint8_t *
--- linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic79xx_osm.h.old	2006-04-18 22:17:43.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic79xx_osm.h	2006-04-18 22:22:15.000000000 +0200
@@ -387,10 +387,6 @@
 void ahd_outb(struct ahd_softc * ahd, long port, uint8_t val);
 void ahd_outw_atomic(struct ahd_softc * ahd,
 				     long port, uint16_t val);
-void ahd_outsb(struct ahd_softc * ahd, long port,
-			       uint8_t *, int count);
-void ahd_insb(struct ahd_softc * ahd, long port,
-			       uint8_t *, int count);
 
 /**************************** Initialization **********************************/
 int		ahd_linux_register_host(struct ahd_softc *,
@@ -740,8 +736,6 @@
 void	ahd_platform_free(struct ahd_softc *ahd);
 void	ahd_platform_init(struct ahd_softc *ahd);
 void	ahd_platform_freeze_devq(struct ahd_softc *ahd, struct scb *scb);
-void	ahd_freeze_simq(struct ahd_softc *ahd);
-void	ahd_release_simq(struct ahd_softc *ahd);
 
 static inline void
 ahd_freeze_scb(struct scb *scb)
--- linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic79xx_core.c.old	2006-04-18 22:13:28.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic79xx_core.c	2006-04-18 22:36:45.000000000 +0200
@@ -50,6 +50,12 @@
 #include <dev/aic7xxx/aicasm/aicasm_insformat.h>
 #endif
 
+static void ahd_handle_hwerrint(struct ahd_softc *ahd);
+static void ahd_handle_scsiint(struct ahd_softc *ahd, u_int intstat);
+static void ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat);
+static void ahd_reset_cmds_pending(struct ahd_softc *ahd);
+static void ahd_run_qoutfifo(struct ahd_softc *ahd);
+
 /***************************** Timer Facilities *******************************/
 #define ahd_timer_init init_timer
 #define ahd_timer_stop del_timer_sync
@@ -118,7 +124,7 @@
 	mb();
 }
 
-void
+static void
 ahd_outsb(struct ahd_softc * ahd, long port, uint8_t *array, int count)
 {
 	int i;
@@ -132,7 +138,8 @@
 		ahd_outb(ahd, port, *array++);
 }
 
-void
+#ifdef AHD_DUMP_SEQ
+static void
 ahd_insb(struct ahd_softc * ahd, long port, uint8_t *array, int count)
 {
 	int i;
@@ -145,6 +152,7 @@
 	for (i = 0; i < count; i++)
 		*array++ = ahd_inb(ahd, port);
 }
+#endif  /*  AHD_DUMP_SEQ  */
 
 /************************ Sequencer Execution Control *************************/
 void
@@ -165,7 +173,7 @@
 	ahd->dst_mode = dst;
 }
 
-void
+static void
 ahd_update_modes(struct ahd_softc *ahd)
 {
 	ahd_mode_state mode_ptr;
@@ -355,7 +363,7 @@
 	ahd_outb(ahd, port+3, ((value) >> 24) & 0xFF);
 }
 
-uint64_t
+static uint64_t
 ahd_inq(struct ahd_softc *ahd, u_int port)
 {
 	return ((ahd_inb(ahd, port))
@@ -368,7 +376,7 @@
 	      | (((uint64_t)ahd_inb(ahd, port+7)) << 56));
 }
 
-void
+static void
 ahd_outq(struct ahd_softc *ahd, u_int port, uint64_t value)
 {
 	ahd_outb(ahd, port, value & 0xFF);
@@ -413,14 +421,14 @@
 	      | (ahd_inb_scbram(ahd, offset+1) << 8));
 }
 
-uint32_t
+static uint32_t
 ahd_inl_scbram(struct ahd_softc *ahd, u_int offset)
 {
 	return (ahd_inw_scbram(ahd, offset)
 	      | (ahd_inw_scbram(ahd, offset+2) << 16));
 }
 
-uint64_t
+static uint64_t
 ahd_inq_scbram(struct ahd_softc *ahd, u_int offset)
 {
 	return (ahd_inl_scbram(ahd, offset)
@@ -1491,7 +1499,7 @@
  * a copy of the first byte (little endian) of the sgptr
  * hscb field.
  */
-void
+static void
 ahd_run_qoutfifo(struct ahd_softc *ahd)
 {
 	struct ahd_completion *completion;
@@ -1530,7 +1538,7 @@
 }
 
 /************************* Interrupt Handling *********************************/
-void
+static void
 ahd_handle_hwerrint(struct ahd_softc *ahd)
 {
 	/*
@@ -1604,7 +1612,7 @@
 }
 #endif  /*  AHD_DEBUG  */
 
-void
+static void
 ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat)
 {
 	u_int seqintcode;
@@ -2193,7 +2201,7 @@
 	ahd_unpause(ahd);
 }
 
-void
+static void
 ahd_handle_scsiint(struct ahd_softc *ahd, u_int intstat)
 {
 	struct scb	*scb;
@@ -7925,7 +7933,7 @@
 		      + NUM_ELEMENTS(ahd->qinfifo) - wrap_qinpos);
 }
 
-void
+static void
 ahd_reset_cmds_pending(struct ahd_softc *ahd)
 {
 	struct		scb *scb;
--- linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic79xx_osm.c.old	2006-04-18 22:21:37.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic79xx_osm.c	2006-04-18 22:22:32.000000000 +0200
@@ -383,6 +383,8 @@
 				 struct scsi_cmnd *);
 static void ahd_linux_setup_tag_info_global(char *p);
 static int  aic79xx_setup(char *c);
+static void ahd_freeze_simq(struct ahd_softc *ahd);
+static void ahd_release_simq(struct ahd_softc *ahd);
 
 static int ahd_linux_unit;
 
@@ -2081,13 +2083,13 @@
 	cmd->scsi_done(cmd);
 }
 
-void
+static void
 ahd_freeze_simq(struct ahd_softc *ahd)
 {
 	scsi_block_requests(ahd->platform_data->host);
 }
 
-void
+static void
 ahd_release_simq(struct ahd_softc *ahd)
 {
 	scsi_unblock_requests(ahd->platform_data->host);
--- linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic7xxx.h.old	2006-04-18 22:23:17.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic7xxx.h	2006-04-18 22:28:44.000000000 +0200
@@ -1192,21 +1192,15 @@
 int			 ahc_resume(struct ahc_softc *ahc);
 void			 ahc_set_unit(struct ahc_softc *, int);
 void			 ahc_set_name(struct ahc_softc *, char *);
-void			 ahc_alloc_scbs(struct ahc_softc *ahc);
 void			 ahc_free(struct ahc_softc *ahc);
 int			 ahc_reset(struct ahc_softc *ahc, int reinit);
 void			 ahc_shutdown(void *arg);
 
 /*************************** Interrupt Services *******************************/
 void			ahc_clear_intstat(struct ahc_softc *ahc);
-void			ahc_run_qoutfifo(struct ahc_softc *ahc);
 #ifdef AHC_TARGET_MODE
 void			ahc_run_tqinfifo(struct ahc_softc *ahc, int paused);
 #endif
-void			ahc_handle_brkadrint(struct ahc_softc *ahc);
-void			ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat);
-void			ahc_handle_scsiint(struct ahc_softc *ahc,
-					   u_int intstat);
 void			ahc_clear_critical_section(struct ahc_softc *ahc);
 
 /***************************** Error Recovery *********************************/
--- linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic7xxx_inline.h.old	2006-04-18 22:26:42.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic7xxx_inline.h	2006-04-18 22:27:53.000000000 +0200
@@ -242,8 +242,6 @@
 void	ahc_outw(struct ahc_softc *ahc, u_int port, u_int value);
 uint32_t ahc_inl(struct ahc_softc *ahc, u_int port);
 void	ahc_outl(struct ahc_softc *ahc, u_int port, uint32_t value);
-uint64_t ahc_inq(struct ahc_softc *ahc, u_int port);
-void	ahc_outq(struct ahc_softc *ahc, u_int port, uint64_t value);
 struct scb*
 	ahc_get_scb(struct ahc_softc *ahc);
 void	ahc_free_scb(struct ahc_softc *ahc, struct scb *scb);
--- linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic7xxx_osm.h.old	2006-04-18 22:27:25.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic7xxx_osm.h	2006-04-18 22:28:23.000000000 +0200
@@ -392,10 +392,6 @@
 /***************************** Low Level I/O **********************************/
 uint8_t ahc_inb(struct ahc_softc * ahc, long port);
 void ahc_outb(struct ahc_softc * ahc, long port, uint8_t val);
-void ahc_outsb(struct ahc_softc * ahc, long port,
-	       uint8_t *, int count);
-void ahc_insb(struct ahc_softc * ahc, long port,
-	       uint8_t *, int count);
 
 /**************************** Initialization **********************************/
 int		ahc_linux_register_host(struct ahc_softc *,
--- linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic7xxx_core.c.old	2006-04-18 22:23:32.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/scsi/aic7xxx/aic7xxx_core.c	2006-04-18 22:37:13.000000000 +0200
@@ -50,6 +50,12 @@
 #include <dev/aic7xxx/aicasm/aicasm_insformat.h>
 #endif
 
+static void ahc_alloc_scbs(struct ahc_softc *ahc);
+static void ahc_handle_brkadrint(struct ahc_softc *ahc);
+static void ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat);
+static void ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat);
+static void ahc_run_qoutfifo(struct ahc_softc *ahc);
+
 /***************************** Low Level I/O **********************************/
 uint8_t
 ahc_inb(struct ahc_softc * ahc, long port)
@@ -76,7 +82,7 @@
 	mb();
 }
 
-void
+static void
 ahc_outsb(struct ahc_softc * ahc, long port, uint8_t *array, int count)
 {
 	int i;
@@ -90,7 +96,8 @@
 		ahc_outb(ahc, port, *array++);
 }
 
-void
+#ifdef AHC_DUMP_SEQ
+static void
 ahc_insb(struct ahc_softc * ahc, long port, uint8_t *array, int count)
 {
 	int i;
@@ -103,6 +110,7 @@
 	for (i = 0; i < count; i++)
 		*array++ = ahc_inb(ahc, port);
 }
+#endif  /*  AHC_DUMP_SEQ  */
 
 /*********************** Miscelaneous Support Functions ***********************/
 uint16_t
@@ -136,6 +144,8 @@
 	ahc_outb(ahc, port+3, ((value) >> 24) & 0xFF);
 }
 
+#if 0
+
 uint64_t
 ahc_inq(struct ahc_softc *ahc, u_int port)
 {
@@ -162,6 +172,8 @@
 	ahc_outb(ahc, port+7, (value >> 56) & 0xFF);
 }
 
+#endif  /*  0  */
+
 /*
  * Get a free scb. If there are none, see if we can allocate a new SCB.
  */
@@ -661,7 +673,7 @@
 }
 
 /************************* Input/Output Queues ********************************/
-void
+static void
 ahc_run_qoutfifo(struct ahc_softc *ahc)
 {
 	struct scb *scb;
@@ -733,7 +745,7 @@
 }
 
 /************************* Interrupt Handling *********************************/
-void
+static void
 ahc_handle_brkadrint(struct ahc_softc *ahc)
 {
 	/*
@@ -762,7 +774,7 @@
 	ahc_shutdown(ahc);
 }
 
-void
+static void
 ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 {
 	struct scb *scb;
@@ -1312,7 +1324,7 @@
 	ahc_unpause(ahc);
 }
 
-void
+static void
 ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 {
 	u_int	scb_index;
@@ -4724,7 +4736,7 @@
 		free(scb_data->scbarray, M_DEVBUF);
 }
 
-void
+static void
 ahc_alloc_scbs(struct ahc_softc *ahc)
 {
 	struct scb_data *scb_data;

