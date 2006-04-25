Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWDYLcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWDYLcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 07:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWDYLcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 07:32:13 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:44706 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751556AbWDYLcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 07:32:12 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH 1/2] aic7xxx: deinline large functions, save 80k of text
Date: Tue, 25 Apr 2006 14:31:26 +0300
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org, hare@suse.de,
       gibbs@scsiguy.com, eike-kernel@sf-tec.de, stefanr@s5r6.in-berlin.de
References: <200604120945.34419.vda@ilport.com.ua> <1144940556.3474.10.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1144940556.3474.10.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OigTECrMADqlkrs"
Message-Id: <200604251431.26622.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_OigTECrMADqlkrs
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 13 April 2006 18:02, James Bottomley wrote:
> On Wed, 2006-04-12 at 09:45 +0300, Denis Vlasenko wrote:
> > This patch
> > 
> > moves big inlines into aic79xx_core.c and aic7xxx_core.c
> > makes ahd_delay just a wrapper around udelay
> > marks a few functions static
> > fixes spelling fix in error message
> 
> There are two things that really spring to mind here
> 
> 1. This alters the Adaptec HIM layer (the machine independent bit).  I
> think no one cares about this anymore, so that's fine.  However, if
> you're going to do this, do it properly, so get rid of the superfluous
> HIM layer abstractions like this:
> 
> #define ahd_timer_init init_timer
> #define ahd_timer_stop del_timer_sync
> typedef void ahd_linux_callback_t (u_long);  
> 
> Just make it use the linux types natively.

This is easy. See attached patch. It also incorporates changes made by
Adrian Bunk.

> 2. There's no actual code content to this, which always makes me
> reluctant to accept changes.  However, I notice this alters the inb/outb
> abstractions, so what you could do, if you were feeling brave is
> eliminate the Adaptec implementation of ioread8/iowrite8 and replace it
> with the linux one (i.e. use ioport_map if the card really wants port
> I/O).  This has been on my Todo list for a long time; even if you
> haven't got the hardware, Hannes and I can test it for you.

I looked into it, and tried to do the conversion, but stumbled upon this:

uint8_t
ahd_inb(struct ahd_softc * ahd, long port)
{
        uint8_t x;

        if (ahd->tags[0] == BUS_SPACE_MEMIO) {
                x = readb(ahd->bshs[0].maddr + port);
        } else {
                x = inb(ahd->bshs[(port) >> 8].ioport + ((port) & 0xFF));
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        }
        mb();
        return (x);
}

After some surgery on ahd_linux_pci_reserve_io/mem_regions() I can coerce
it into using iomem* pointers instead of bus_space_handle_t union,
but I still cannot use ioread8() instead of ahd_inb()
because of the ^^^ code above.

I don't think it makes sense to try to convert it to ioread8() and friends.
It will just add (not replace) yet another indirection...

> Note that you can't use ioread16 or any of the longer reads or writes.
> The adaptec cards have terrible problems with write combining, so
> everything needs to still be done in terms of ioread8/iowrite8

I looked at the code. This hardware must be, um, "interesting".
--
vda

--Boundary-00=_OigTECrMADqlkrs
Content-Type: text/x-diff;
  charset="koi8-r";
  name="2.6.17-rc1-mm2-aic4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.17-rc1-mm2-aic4.patch"

diff -urpN linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic79xx.h linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic79xx.h
--- linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic79xx.h	Wed Apr 12 09:31:57 2006
+++ linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic79xx.h	Tue Apr 25 12:04:37 2006
@@ -1336,7 +1336,6 @@ extern const int ahd_num_aic7770_devs;
 
 /*************************** Function Declarations ****************************/
 /******************************************************************************/
-void			ahd_reset_cmds_pending(struct ahd_softc *ahd);
 
 /***************************** PCI Front End *********************************/
 struct	ahd_pci_identity *ahd_find_pci_device(ahd_dev_softc_t);
@@ -1373,14 +1372,9 @@ int			 ahd_read_flexport(struct ahd_soft
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
diff -urpN linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic79xx_core.c linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic79xx_core.c
--- linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic79xx_core.c	Wed Apr 12 09:32:39 2006
+++ linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic79xx_core.c	Tue Apr 25 12:04:37 2006
@@ -50,10 +50,15 @@
 #include <dev/aic7xxx/aicasm/aicasm_insformat.h>
 #endif
 
+static void ahd_handle_hwerrint(struct ahd_softc *ahd);
+static void ahd_handle_scsiint(struct ahd_softc *ahd, u_int intstat);
+static void ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat);
+static void ahd_reset_cmds_pending(struct ahd_softc *ahd);
+static void ahd_run_qoutfifo(struct ahd_softc *ahd);
+
 /***************************** Timer Facilities *******************************/
-#define ahd_timer_init init_timer
-#define ahd_timer_stop del_timer_sync
 typedef void ahd_linux_callback_t (u_long);  
+
 static void
 ahd_timer_reset(ahd_timer_t *timer, int usec, ahd_callback_t *func, void *arg)
 {
@@ -118,7 +123,7 @@ ahd_outw_atomic(struct ahd_softc * ahd, 
 	mb();
 }
 
-void
+static void
 ahd_outsb(struct ahd_softc * ahd, long port, uint8_t *array, int count)
 {
 	int i;
@@ -132,7 +137,8 @@ ahd_outsb(struct ahd_softc * ahd, long p
 		ahd_outb(ahd, port, *array++);
 }
 
-void
+#ifdef AHD_DUMP_SEQ
+static void
 ahd_insb(struct ahd_softc * ahd, long port, uint8_t *array, int count)
 {
 	int i;
@@ -145,6 +151,7 @@ ahd_insb(struct ahd_softc * ahd, long po
 	for (i = 0; i < count; i++)
 		*array++ = ahd_inb(ahd, port);
 }
+#endif  /*  AHD_DUMP_SEQ  */
 
 /************************ Sequencer Execution Control *************************/
 void
@@ -165,7 +172,7 @@ ahd_set_modes(struct ahd_softc *ahd, ahd
 	ahd->dst_mode = dst;
 }
 
-void
+static void
 ahd_update_modes(struct ahd_softc *ahd)
 {
 	ahd_mode_state mode_ptr;
@@ -355,7 +362,7 @@ ahd_outl(struct ahd_softc *ahd, u_int po
 	ahd_outb(ahd, port+3, ((value) >> 24) & 0xFF);
 }
 
-uint64_t
+static uint64_t
 ahd_inq(struct ahd_softc *ahd, u_int port)
 {
 	return ((ahd_inb(ahd, port))
@@ -368,7 +375,7 @@ ahd_inq(struct ahd_softc *ahd, u_int por
 	      | (((uint64_t)ahd_inb(ahd, port+7)) << 56));
 }
 
-void
+static void
 ahd_outq(struct ahd_softc *ahd, u_int port, uint64_t value)
 {
 	ahd_outb(ahd, port, value & 0xFF);
@@ -413,14 +420,14 @@ ahd_inw_scbram(struct ahd_softc *ahd, u_
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
@@ -1492,7 +1499,7 @@ clrchn:
  * a copy of the first byte (little endian) of the sgptr
  * hscb field.
  */
-void
+static void
 ahd_run_qoutfifo(struct ahd_softc *ahd)
 {
 	struct ahd_completion *completion;
@@ -1531,7 +1538,7 @@ ahd_run_qoutfifo(struct ahd_softc *ahd)
 }
 
 /************************* Interrupt Handling *********************************/
-void
+static void
 ahd_handle_hwerrint(struct ahd_softc *ahd)
 {
 	/*
@@ -1605,7 +1612,7 @@ ahd_dump_sglist(struct scb *scb)
 }
 #endif  /*  AHD_DEBUG  */
 
-void
+static void
 ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat)
 {
 	u_int seqintcode;
@@ -2212,7 +2219,7 @@ ahd_handle_seqint(struct ahd_softc *ahd,
 	ahd_unpause(ahd);
 }
 
-void
+static void
 ahd_handle_scsiint(struct ahd_softc *ahd, u_int intstat)
 {
 	struct scb	*scb;
@@ -5910,8 +5917,8 @@ ahd_alloc(void *platform_arg, char *name
 	ahd->bugs = AHD_BUGNONE;
 	ahd->flags = AHD_SPCHK_ENB_A|AHD_RESET_BUS_A|AHD_TERM_ENB_A
 		   | AHD_EXTENDED_TRANS_A|AHD_STPWLEVEL_A;
-	ahd_timer_init(&ahd->reset_timer);
-	ahd_timer_init(&ahd->stat_timer);
+	init_timer(&ahd->reset_timer);
+	init_timer(&ahd->stat_timer);
 	ahd->int_coalescing_timer = AHD_INT_COALESCING_TIMER_DEFAULT;
 	ahd->int_coalescing_maxcmds = AHD_INT_COALESCING_MAXCMDS_DEFAULT;
 	ahd->int_coalescing_mincmds = AHD_INT_COALESCING_MINCMDS_DEFAULT;
@@ -6041,8 +6048,8 @@ ahd_shutdown(void *arg)
 	/*
 	 * Stop periodic timer callbacks.
 	 */
-	ahd_timer_stop(&ahd->reset_timer);
-	ahd_timer_stop(&ahd->stat_timer);
+	del_timer_sync(&ahd->reset_timer);
+	del_timer_sync(&ahd->stat_timer);
 
 	/* This will reset most registers to 0, but not all */
 	ahd_reset(ahd, /*reinit*/FALSE);
@@ -7948,7 +7955,7 @@ ahd_qinfifo_count(struct ahd_softc *ahd)
 		      + NUM_ELEMENTS(ahd->qinfifo) - wrap_qinpos);
 }
 
-void
+static void
 ahd_reset_cmds_pending(struct ahd_softc *ahd)
 {
 	struct		scb *scb;
diff -urpN linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic79xx_inline.h linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic79xx_inline.h
--- linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic79xx_inline.h	Wed Apr 12 09:32:27 2006
+++ linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic79xx_inline.h	Tue Apr 25 12:04:37 2006
@@ -65,7 +65,6 @@ static inline void ahd_extract_mode_stat
 					    ahd_mode *src, ahd_mode *dst);
 void ahd_set_modes(struct ahd_softc *ahd, ahd_mode src,
 				   ahd_mode dst);
-void ahd_update_modes(struct ahd_softc *ahd);
 static inline void ahd_assert_modes(struct ahd_softc *ahd, ahd_mode srcmode,
 				      ahd_mode dstmode, const char *file,
 				      int line);
@@ -257,8 +256,6 @@ uint16_t ahd_inw(struct ahd_softc *ahd, 
 void	ahd_outw(struct ahd_softc *ahd, u_int port, u_int value);
 uint32_t ahd_inl(struct ahd_softc *ahd, u_int port);
 void	ahd_outl(struct ahd_softc *ahd, u_int port, uint32_t value);
-uint64_t ahd_inq(struct ahd_softc *ahd, u_int port);
-void	ahd_outq(struct ahd_softc *ahd, u_int port, uint64_t value);
 static inline u_int	ahd_get_scbptr(struct ahd_softc *ahd);
 static inline void	ahd_set_scbptr(struct ahd_softc *ahd, u_int scbptr);
 static inline u_int	ahd_get_hnscb_qoff(struct ahd_softc *ahd);
@@ -273,8 +270,6 @@ static inline u_int	ahd_get_sdscb_qoff(s
 static inline void	ahd_set_sdscb_qoff(struct ahd_softc *ahd, u_int value);
 u_int	ahd_inb_scbram(struct ahd_softc *ahd, u_int offset);
 u_int	ahd_inw_scbram(struct ahd_softc *ahd, u_int offset);
-uint32_t ahd_inl_scbram(struct ahd_softc *ahd, u_int offset);
-uint64_t ahd_inq_scbram(struct ahd_softc *ahd, u_int offset);
 struct scb *ahd_lookup_scb(struct ahd_softc *ahd, u_int tag);
 void	ahd_queue_scb(struct ahd_softc *ahd, struct scb *scb);
 static inline uint8_t *
diff -urpN linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic79xx_osm.c linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic79xx_osm.c	Wed Apr 12 09:31:57 2006
+++ linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic79xx_osm.c	Tue Apr 25 12:04:37 2006
@@ -383,6 +383,8 @@ static int ahd_linux_run_command(struct 
 				 struct scsi_cmnd *);
 static void ahd_linux_setup_tag_info_global(char *p);
 static int  aic79xx_setup(char *c);
+static void ahd_freeze_simq(struct ahd_softc *ahd);
+static void ahd_release_simq(struct ahd_softc *ahd);
 
 static int ahd_linux_unit;
 
@@ -2077,13 +2079,13 @@ ahd_linux_queue_cmd_complete(struct ahd_
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
diff -urpN linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic79xx_osm.h linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic79xx_osm.h
--- linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic79xx_osm.h	Wed Apr 12 09:31:57 2006
+++ linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic79xx_osm.h	Tue Apr 25 12:04:37 2006
@@ -387,10 +387,6 @@ uint16_t ahd_inw_atomic(struct ahd_softc
 void ahd_outb(struct ahd_softc * ahd, long port, uint8_t val);
 void ahd_outw_atomic(struct ahd_softc * ahd,
 				     long port, uint16_t val);
-void ahd_outsb(struct ahd_softc * ahd, long port,
-			       uint8_t *, int count);
-void ahd_insb(struct ahd_softc * ahd, long port,
-			       uint8_t *, int count);
 
 /**************************** Initialization **********************************/
 int		ahd_linux_register_host(struct ahd_softc *,
@@ -740,8 +736,6 @@ int	ahd_platform_alloc(struct ahd_softc 
 void	ahd_platform_free(struct ahd_softc *ahd);
 void	ahd_platform_init(struct ahd_softc *ahd);
 void	ahd_platform_freeze_devq(struct ahd_softc *ahd, struct scb *scb);
-void	ahd_freeze_simq(struct ahd_softc *ahd);
-void	ahd_release_simq(struct ahd_softc *ahd);
 
 static inline void
 ahd_freeze_scb(struct scb *scb)
diff -urpN linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic7xxx.h linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic7xxx.h
--- linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic7xxx.h	Wed Apr 12 09:25:49 2006
+++ linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic7xxx.h	Tue Apr 25 12:04:37 2006
@@ -1192,21 +1192,15 @@ int			 ahc_suspend(struct ahc_softc *ahc
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
diff -urpN linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic7xxx_core.c linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic7xxx_core.c
--- linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic7xxx_core.c	Wed Apr 12 09:28:17 2006
+++ linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic7xxx_core.c	Tue Apr 25 12:04:37 2006
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
@@ -76,7 +82,7 @@ ahc_outb(struct ahc_softc * ahc, long po
 	mb();
 }
 
-void
+static void
 ahc_outsb(struct ahc_softc * ahc, long port, uint8_t *array, int count)
 {
 	int i;
@@ -90,7 +96,8 @@ ahc_outsb(struct ahc_softc * ahc, long p
 		ahc_outb(ahc, port, *array++);
 }
 
-void
+#ifdef AHC_DUMP_SEQ
+static void
 ahc_insb(struct ahc_softc * ahc, long port, uint8_t *array, int count)
 {
 	int i;
@@ -103,6 +110,7 @@ ahc_insb(struct ahc_softc * ahc, long po
 	for (i = 0; i < count; i++)
 		*array++ = ahc_inb(ahc, port);
 }
+#endif  /*  AHC_DUMP_SEQ  */
 
 /*********************** Miscelaneous Support Functions ***********************/
 uint16_t
@@ -136,6 +144,8 @@ ahc_outl(struct ahc_softc *ahc, u_int po
 	ahc_outb(ahc, port+3, ((value) >> 24) & 0xFF);
 }
 
+#if 0
+
 uint64_t
 ahc_inq(struct ahc_softc *ahc, u_int port)
 {
@@ -162,6 +172,8 @@ ahc_outq(struct ahc_softc *ahc, u_int po
 	ahc_outb(ahc, port+7, (value >> 56) & 0xFF);
 }
 
+#endif  /*  0  */
+
 /*
  * Get a free scb. If there are none, see if we can allocate a new SCB.
  */
@@ -661,7 +673,7 @@ ahc_restart(struct ahc_softc *ahc)
 }
 
 /************************* Input/Output Queues ********************************/
-void
+static void
 ahc_run_qoutfifo(struct ahc_softc *ahc)
 {
 	struct scb *scb;
@@ -733,7 +745,7 @@ ahc_run_untagged_queue(struct ahc_softc 
 }
 
 /************************* Interrupt Handling *********************************/
-void
+static void
 ahc_handle_brkadrint(struct ahc_softc *ahc)
 {
 	/*
@@ -762,7 +774,7 @@ ahc_handle_brkadrint(struct ahc_softc *a
 	ahc_shutdown(ahc);
 }
 
-void
+static void
 ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 {
 	struct scb *scb;
@@ -1312,7 +1324,7 @@ unpause:
 	ahc_unpause(ahc);
 }
 
-void
+static void
 ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 {
 	u_int	scb_index;
@@ -4724,7 +4736,7 @@ ahc_fini_scbdata(struct ahc_softc *ahc)
 		free(scb_data->scbarray, M_DEVBUF);
 }
 
-void
+static void
 ahc_alloc_scbs(struct ahc_softc *ahc)
 {
 	struct scb_data *scb_data;
diff -urpN linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic7xxx_inline.h linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic7xxx_inline.h
--- linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic7xxx_inline.h	Wed Apr 12 09:31:57 2006
+++ linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic7xxx_inline.h	Tue Apr 25 12:04:37 2006
@@ -242,8 +242,6 @@ uint16_t ahc_inw(struct ahc_softc *ahc, 
 void	ahc_outw(struct ahc_softc *ahc, u_int port, u_int value);
 uint32_t ahc_inl(struct ahc_softc *ahc, u_int port);
 void	ahc_outl(struct ahc_softc *ahc, u_int port, uint32_t value);
-uint64_t ahc_inq(struct ahc_softc *ahc, u_int port);
-void	ahc_outq(struct ahc_softc *ahc, u_int port, uint64_t value);
 struct scb*
 	ahc_get_scb(struct ahc_softc *ahc);
 void	ahc_free_scb(struct ahc_softc *ahc, struct scb *scb);
diff -urpN linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic7xxx_osm.h linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic7xxx_osm.h
--- linux-2.6.17-rc1-mm2-aic2/drivers/scsi/aic7xxx/aic7xxx_osm.h	Wed Apr 12 09:31:57 2006
+++ linux-2.6.17-rc1-mm2-aic4/drivers/scsi/aic7xxx/aic7xxx_osm.h	Tue Apr 25 12:04:37 2006
@@ -392,10 +392,6 @@ static inline void ahc_delay(int usec)
 /***************************** Low Level I/O **********************************/
 uint8_t ahc_inb(struct ahc_softc * ahc, long port);
 void ahc_outb(struct ahc_softc * ahc, long port, uint8_t val);
-void ahc_outsb(struct ahc_softc * ahc, long port,
-	       uint8_t *, int count);
-void ahc_insb(struct ahc_softc * ahc, long port,
-	       uint8_t *, int count);
 
 /**************************** Initialization **********************************/
 int		ahc_linux_register_host(struct ahc_softc *,

--Boundary-00=_OigTECrMADqlkrs--
