Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261187AbSJYCEz>; Thu, 24 Oct 2002 22:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbSJYCEz>; Thu, 24 Oct 2002 22:04:55 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:10887 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261187AbSJYCEa>; Thu, 24 Oct 2002 22:04:30 -0400
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15800.43219.216824.411355@sofia.bsd2.kbnes.nec.co.jp>
Date: Fri, 25 Oct 2002 11:13:39 +0900
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Forward port of aic7xxx driver to 2.5.44 [1/3]
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates the aic7xxx driver to be the same version as in
2.4.20-pre11.  The version currently in 2.5.44 is too old to recognize
my controller.  It compiles cleanly, but I have not yet tried to boot
with it.  Would someone with experienced eyes please look it over to
be sure I didn't do anything stupid?  Thanks.

===== drivers/scsi/aic7xxx/aic7xxx_proc.c 1.4 vs edited =====
--- 1.4/drivers/scsi/aic7xxx/aic7xxx_proc.c	Tue Feb  5 16:53:47 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx_proc.c	Thu Oct 24 13:35:09 2002
@@ -37,10 +37,11 @@
  * String handling code courtesy of Gerard Roudier's <groudier@club-internet.fr>
  * sym driver.
  *
- * $Id: //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_proc.c#13 $
+ * $Id: //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_proc.c#19 $
  */
 #include "aic7xxx_osm.h"
 #include "aic7xxx_inline.h"
+#include "aic7xxx_93cx6.h"
 
 static void	copy_mem_info(struct info_str *info, char *data, int len);
 static int	copy_info(struct info_str *info, char *fmt, ...);
@@ -51,6 +52,46 @@
 				      u_int target_id, u_int target_offset);
 static void	ahc_dump_device_state(struct info_str *info,
 				      struct ahc_linux_device *dev);
+static int	ahc_proc_write_seeprom(struct ahc_softc *ahc,
+				       char *buffer, int length);
+				       
+
+int
+ahc_acquire_seeprom(struct ahc_softc *ahc, struct seeprom_descriptor *sd)
+{
+	int wait;
+
+	if ((ahc->features & AHC_SPIOCAP) != 0
+	 && (ahc_inb(ahc, SPIOCAP) & SEEPROM) == 0)
+		return (0);
+
+	/*
+	 * Request access of the memory port.  When access is
+	 * granted, SEERDY will go high.  We use a 1 second
+	 * timeout which should be near 1 second more than
+	 * is needed.  Reason: after the chip reset, there
+	 * should be no contention.
+	 */
+	SEEPROM_OUTB(sd, sd->sd_MS);
+	wait = 1000;  /* 1 second timeout in msec */
+	while (--wait && ((SEEPROM_STATUS_INB(sd) & sd->sd_RDY) == 0)) {
+		ahc_delay(1000);  /* delay 1 msec */
+	}
+	if ((SEEPROM_STATUS_INB(sd) & sd->sd_RDY) == 0) {
+		SEEPROM_OUTB(sd, 0); 
+		return (0);
+	}
+	return(1);
+}
+
+
+void
+ahc_release_seeprom(struct seeprom_descriptor *sd)
+{
+	/* Release access to the memory port and the serial EEPROM. */
+	SEEPROM_OUTB(sd, 0);
+}
+
 
 static void
 copy_mem_info(struct info_str *info, char *data, int len)
@@ -225,6 +266,96 @@
 	copy_info(info, "\t\tDevice Queue Frozen Count %d\n", dev->qfrozen);
 }
 
+static int
+ahc_proc_write_seeprom(struct ahc_softc *ahc, char *buffer, int length)
+{
+	struct seeprom_descriptor sd;
+	int have_seeprom;
+	u_long s;
+	int paused;
+	int written;
+
+	/* Default to failure. */
+	written = -EINVAL;
+	ahc_lock(ahc, &s);
+	paused = ahc_is_paused(ahc);
+	if (!paused)
+		ahc_pause(ahc);
+
+	if (length != sizeof(struct seeprom_config)) {
+		printf("ahc_proc_write_seeprom: incorrect buffer size\n");
+		goto done;
+	}
+
+	have_seeprom = ahc_verify_cksum((struct seeprom_config*)buffer);
+	if (have_seeprom == 0) {
+		printf("ahc_proc_write_seeprom: cksum verification failed\n");
+		goto done;
+	}
+
+	sd.sd_ahc = ahc;
+	if ((ahc->chip & AHC_VL) != 0) {
+		sd.sd_control_offset = SEECTL_2840;
+		sd.sd_status_offset = STATUS_2840;
+		sd.sd_dataout_offset = STATUS_2840;		
+		sd.sd_chip = C46;
+		sd.sd_MS = 0;
+		sd.sd_RDY = EEPROM_TF;
+		sd.sd_CS = CS_2840;
+		sd.sd_CK = CK_2840;
+		sd.sd_DO = DO_2840;
+		sd.sd_DI = DI_2840;
+		have_seeprom = TRUE;
+	} else {
+		sd.sd_control_offset = SEECTL;
+		sd.sd_status_offset = SEECTL;
+		sd.sd_dataout_offset = SEECTL;
+		if (ahc->flags & AHC_LARGE_SEEPROM)
+			sd.sd_chip = C56_66;
+		else
+			sd.sd_chip = C46;
+		sd.sd_MS = SEEMS;
+		sd.sd_RDY = SEERDY;
+		sd.sd_CS = SEECS;
+		sd.sd_CK = SEECK;
+		sd.sd_DO = SEEDO;
+		sd.sd_DI = SEEDI;
+		have_seeprom = ahc_acquire_seeprom(ahc, &sd);
+	}
+
+	if (!have_seeprom) {
+		printf("ahc_proc_write_seeprom: No Serial EEPROM\n");
+		goto done;
+	} else {
+		u_int start_addr;
+
+		if (ahc->seep_config == NULL) {
+			ahc->seep_config = malloc(sizeof(*ahc->seep_config),
+						  M_DEVBUF, M_NOWAIT);
+			if (ahc->seep_config == NULL) {
+				printf("aic7xxx: Unable to allocate serial "
+				       "eeprom buffer.  Write failing\n");
+				goto done;
+			}
+		}
+		printf("aic7xxx: Writing Serial EEPROM\n");
+		start_addr = 32 * (ahc->channel - 'A');
+		ahc_write_seeprom(&sd, (u_int16_t *)buffer, start_addr,
+				  sizeof(struct seeprom_config)/2);
+		ahc_read_seeprom(&sd, (uint16_t *)ahc->seep_config,
+				 start_addr, sizeof(struct seeprom_config)/2);
+		if ((ahc->chip & AHC_VL) == 0)
+			ahc_release_seeprom(&sd);
+		written = length;
+	}
+
+done:
+	if (!paused)
+		ahc_unpause(ahc);
+	ahc_unlock(ahc, &s);
+	return (written);
+}
+
 /*
  * Return information to handle /proc support for the driver.
  */
@@ -235,20 +366,26 @@
 	struct	ahc_softc *ahc;
 	struct	info_str info;
 	char	ahc_info[256];
+	u_long	s;
 	u_int	max_targ;
 	u_int	i;
+	int	retval;
 
+	retval = -EINVAL;
+	ahc_list_lock(&s);
 	TAILQ_FOREACH(ahc, &ahc_tailq, links) {
 		if (ahc->platform_data->host->host_no == hostno)
 			break;
 	}
 
 	if (ahc == NULL)
-		return (-EINVAL);
+		goto done;
 
 	 /* Has data been written to the file? */ 
-	if (inout == TRUE)
-		return (-ENOSYS);
+	if (inout == TRUE) {
+		retval = ahc_proc_write_seeprom(ahc, buffer, length);
+		goto done;
+	}
 
 	if (start)
 		*start = buffer;
@@ -261,7 +398,22 @@
 	copy_info(&info, "Adaptec AIC7xxx driver version: %s\n",
 		  AIC7XXX_DRIVER_VERSION);
 	ahc_controller_info(ahc, ahc_info);
-	copy_info(&info, "%s\n", ahc_info);
+	copy_info(&info, "%s\n\n", ahc_info);
+
+	if (ahc->seep_config == NULL)
+		copy_info(&info, "No Serial EEPROM\n");
+	else {
+		copy_info(&info, "Serial EEPROM:\n");
+		for (i = 0; i < sizeof(*ahc->seep_config)/2; i++) {
+			if (((i % 8) == 0) && (i != 0)) {
+				copy_info(&info, "\n");
+			}
+			copy_info(&info, "0x%.4x ",
+				  ((uint16_t*)ahc->seep_config)[i]);
+		}
+		copy_info(&info, "\n");
+	}
+	copy_info(&info, "\n");
 
 	max_targ = 15;
 	if ((ahc->features & (AHC_WIDE|AHC_TWIN)) == 0)
@@ -284,5 +436,8 @@
 		ahc_dump_target_state(ahc, &info, our_id,
 				      channel, target_id, i);
 	}
-	return (info.pos > info.offset ? info.pos - info.offset : 0);
+	retval = info.pos > info.offset ? info.pos - info.offset : 0;
+done:
+	ahc_list_unlock(&s);
+	return (retval);
 }
===== drivers/scsi/aic7xxx/aic7xxx_pci.c 1.5 vs edited =====
--- 1.5/drivers/scsi/aic7xxx/aic7xxx_pci.c	Tue Feb  5 16:53:47 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx_pci.c	Thu Oct 24 13:28:07 2002
@@ -39,9 +39,9 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  *
- * $Id: //depot/aic7xxx/aic7xxx/aic7xxx_pci.c#32 $
+ * $Id: //depot/aic7xxx/aic7xxx/aic7xxx_pci.c#46 $
  *
- * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx_pci.c,v 1.6 2000/11/10 20:13:41 gibbs Exp $
+ * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx_pci.c,v 1.2.2.14 2002/04/29 19:36:31 gibbs Exp $
  */
 
 #include "aic7xxx_osm.h"
@@ -207,7 +207,7 @@
 	 : ((id) & 0x1000) >> 12)
 /*
  * Informational only. Should use chip register to be
- * ceratian, but may be use in identification strings.
+ * certain, but may be use in identification strings.
  */
 #define SUBID_9005_CARD_SCSIWIDTH_MASK	0x2000
 #define SUBID_9005_CARD_PCIWIDTH_MASK	0x4000
@@ -661,6 +661,8 @@
 				  int pcheck, int fast, int large);
 static void ahc_probe_ext_scbram(struct ahc_softc *ahc);
 static void check_extport(struct ahc_softc *ahc, u_int *sxfrctl1);
+static void ahc_parse_pci_eeprom(struct ahc_softc *ahc,
+				 struct seeprom_config *sc);
 static void configure_termination(struct ahc_softc *ahc,
 				  struct seeprom_descriptor *sd,
 				  u_int adapter_control,
@@ -679,9 +681,6 @@
 static void aic785X_cable_detect(struct ahc_softc *ahc, int *internal50_present,
 				 int *externalcable_present,
 				 int *eeprom_present);
-static int acquire_seeprom(struct ahc_softc *ahc,
-			   struct seeprom_descriptor *sd);
-static void release_seeprom(struct seeprom_descriptor *sd);
 static void write_brdctl(struct ahc_softc *ahc, uint8_t value);
 static uint8_t read_brdctl(struct ahc_softc *ahc);
 
@@ -767,6 +766,8 @@
 ahc_pci_config(struct ahc_softc *ahc, struct ahc_pci_identity *entry)
 {
 	struct scb_data *shared_scb_data;
+	u_long		 l;
+	u_long		 s;
 	u_int		 command;
 	u_int		 our_id = 0;
 	u_int		 sxfrctl1;
@@ -782,11 +783,19 @@
 	ahc->chip |= AHC_PCI;
 	ahc->description = entry->name;
 
+	ahc_power_state_change(ahc, AHC_POWER_STATE_D0);
+
 	error = ahc_pci_map_registers(ahc);
 	if (error != 0)
 		return (error);
 
-	ahc_power_state_change(ahc, AHC_POWER_STATE_D0);
+	/*
+	 * Before we continue probing the card, ensure that
+	 * its interrupts are *disabled*.  We don't want
+	 * a misstep to hang the machine in an interrupt
+	 * storm.
+	 */
+	ahc_intr_enable(ahc, FALSE);
 
 	/*
 	 * If we need to support high memory, enable dual
@@ -964,19 +973,23 @@
 		return (error);
 
 	/*
-	 * Link this softc in with all other ahc instances.
-	 */
-	ahc_softc_insert(ahc);
-
-	/*
 	 * Allow interrupts now that we are completely setup.
 	 */
 	error = ahc_pci_map_int(ahc);
 	if (error != 0)
 		return (error);
 
+	ahc_list_lock(&l);
+	/*
+	 * Link this softc in with all other ahc instances.
+	 */
+	ahc_softc_insert(ahc);
+
+	ahc_lock(ahc, &s);
 	ahc_intr_enable(ahc, TRUE);
+	ahc_unlock(ahc, &s);
 
+	ahc_list_unlock(&l);
 	return (0);
 }
 
@@ -999,6 +1012,14 @@
 
 	if ((ahc->features & AHC_ULTRA2) != 0)
 		ramps = (ahc_inb(ahc, DSCOMMAND0) & RAMPS) != 0;
+	else if (chip == AHC_AIC7895 || chip == AHC_AIC7895C)
+		/*
+		 * External SCBRAM arbitration is flakey
+		 * on these chips.  Unfortunately this means
+		 * we don't use the extra SCB ram space on the
+		 * 3940AUW.
+		 */
+		ramps = 0;
 	else if (chip >= AHC_AIC7870)
 		ramps = (devconfig & RAMPSM) != 0;
 	else
@@ -1026,6 +1047,9 @@
 		ahc_outb(ahc, SCBBADDR, ahc_get_pci_function(ahc->dev_softc));
 	}
 
+	ahc->flags &= ~AHC_LSCBS_ENABLED;
+	if (large)
+		ahc->flags |= AHC_LSCBS_ENABLED;
 	devconfig = ahc_pci_read_config(ahc->dev_softc, DEVCONFIG, /*bytes*/4);
 	if ((ahc->features & AHC_ULTRA2) != 0) {
 		u_int dscommand0;
@@ -1172,9 +1196,7 @@
 check_extport(struct ahc_softc *ahc, u_int *sxfrctl1)
 {
 	struct	seeprom_descriptor sd;
-	struct	seeprom_config sc;
-	u_int	scsi_conf;
-	u_int	adapter_control;
+	struct	seeprom_config *sc;
 	int	have_seeprom;
 	int	have_autoterm;
 
@@ -1182,6 +1204,7 @@
 	sd.sd_control_offset = SEECTL;		
 	sd.sd_status_offset = SEECTL;		
 	sd.sd_dataout_offset = SEECTL;		
+	sc = ahc->seep_config;
 
 	/*
 	 * For some multi-channel devices, the c46 is simply too
@@ -1201,7 +1224,7 @@
 	sd.sd_DO = SEEDO;
 	sd.sd_DI = SEEDI;
 
-	have_seeprom = acquire_seeprom(ahc, &sd);
+	have_seeprom = ahc_acquire_seeprom(ahc, &sd);
 	if (have_seeprom) {
 
 		if (bootverbose) 
@@ -1212,11 +1235,12 @@
 
 			start_addr = 32 * (ahc->channel - 'A');
 
-			have_seeprom = read_seeprom(&sd, (uint16_t *)&sc,
-						    start_addr, sizeof(sc)/2);
+			have_seeprom = ahc_read_seeprom(&sd, (uint16_t *)sc,
+							start_addr,
+							sizeof(*sc)/2);
 
 			if (have_seeprom)
-				have_seeprom = verify_cksum(&sc);
+				have_seeprom = ahc_verify_cksum(sc);
 
 			if (have_seeprom != 0 || sd.sd_chip == C56_66) {
 				if (bootverbose) {
@@ -1229,7 +1253,7 @@
 			}
 			sd.sd_chip = C56_66;
 		}
-		release_seeprom(&sd);
+		ahc_release_seeprom(&sd);
 	}
 
 	if (!have_seeprom) {
@@ -1248,7 +1272,7 @@
 			uint16_t *sc_data;
 			int	  i;
 
-			sc_data = (uint16_t *)&sc;
+			sc_data = (uint16_t *)sc;
 			for (i = 0; i < 32; i++) {
 				uint16_t val;
 				int	 j;
@@ -1257,129 +1281,27 @@
 				val = ahc_inb(ahc, SRAM_BASE + j)
 				    | ahc_inb(ahc, SRAM_BASE + j + 1) << 8;
 			}
-			have_seeprom = verify_cksum(&sc);
+			have_seeprom = ahc_verify_cksum(sc);
+			if (have_seeprom)
+				ahc->flags |= AHC_SCB_CONFIG_USED;
 		}
+		/*
+		 * Clear any SCB parity errors in case this data and
+		 * its associated parity was not initialized by the BIOS
+		 */
+		ahc_outb(ahc, CLRINT, CLRPARERR);
+		ahc_outb(ahc, CLRINT, CLRBRKADRINT);
 	}
 
 	if (!have_seeprom) {
 		if (bootverbose)
 			printf("%s: No SEEPROM available.\n", ahc_name(ahc));
 		ahc->flags |= AHC_USEDEFAULTS;
+		free(ahc->seep_config, M_DEVBUF);
+		ahc->seep_config = NULL;
+		sc = NULL;
 	} else {
-		/*
-		 * Put the data we've collected down into SRAM
-		 * where ahc_init will find it.
-		 */
-		int i;
-		int max_targ = sc.max_targets & CFMAXTARG;
-		uint16_t discenable;
-		uint16_t ultraenb;
-
-		discenable = 0;
-		ultraenb = 0;
-		if ((sc.adapter_control & CFULTRAEN) != 0) {
-			/*
-			 * Determine if this adapter has a "newstyle"
-			 * SEEPROM format.
-			 */
-			for (i = 0; i < max_targ; i++) {
-				if ((sc.device_flags[i] & CFSYNCHISULTRA) != 0){
-					ahc->flags |= AHC_NEWEEPROM_FMT;
-					break;
-				}
-			}
-		}
-
-		for (i = 0; i < max_targ; i++) {
-			u_int     scsirate;
-			uint16_t target_mask;
-
-			target_mask = 0x01 << i;
-			if (sc.device_flags[i] & CFDISC)
-				discenable |= target_mask;
-			if ((ahc->flags & AHC_NEWEEPROM_FMT) != 0) {
-				if ((sc.device_flags[i] & CFSYNCHISULTRA) != 0)
-					ultraenb |= target_mask;
-			} else if ((sc.adapter_control & CFULTRAEN) != 0) {
-				ultraenb |= target_mask;
-			}
-			if ((sc.device_flags[i] & CFXFER) == 0x04
-			 && (ultraenb & target_mask) != 0) {
-				/* Treat 10MHz as a non-ultra speed */
-				sc.device_flags[i] &= ~CFXFER;
-			 	ultraenb &= ~target_mask;
-			}
-			if ((ahc->features & AHC_ULTRA2) != 0) {
-				u_int offset;
-
-				if (sc.device_flags[i] & CFSYNCH)
-					offset = MAX_OFFSET_ULTRA2;
-				else 
-					offset = 0;
-				ahc_outb(ahc, TARG_OFFSET + i, offset);
-
-				/*
-				 * The ultra enable bits contain the
-				 * high bit of the ultra2 sync rate
-				 * field.
-				 */
-				scsirate = (sc.device_flags[i] & CFXFER)
-					 | ((ultraenb & target_mask)
-					    ? 0x8 : 0x0);
-				if (sc.device_flags[i] & CFWIDEB)
-					scsirate |= WIDEXFER;
-			} else {
-				scsirate = (sc.device_flags[i] & CFXFER) << 4;
-				if (sc.device_flags[i] & CFSYNCH)
-					scsirate |= SOFS;
-				if (sc.device_flags[i] & CFWIDEB)
-					scsirate |= WIDEXFER;
-			}
-			ahc_outb(ahc, TARG_SCSIRATE + i, scsirate);
-		}
-		ahc->our_id = sc.brtime_id & CFSCSIID;
-
-		scsi_conf = (ahc->our_id & 0x7);
-		if (sc.adapter_control & CFSPARITY)
-			scsi_conf |= ENSPCHK;
-		if (sc.adapter_control & CFRESETB)
-			scsi_conf |= RESET_SCSI;
-
-		ahc->flags |=
-		    (sc.adapter_control & CFBOOTCHAN) >> CFBOOTCHANSHIFT;
-
-		if (sc.bios_control & CFEXTEND)
-			ahc->flags |= AHC_EXTENDED_TRANS_A;
-
-		if (sc.bios_control & CFBIOSEN)
-			ahc->flags |= AHC_BIOS_ENABLED;
-		if (ahc->features & AHC_ULTRA
-		 && (ahc->flags & AHC_NEWEEPROM_FMT) == 0) {
-			/* Should we enable Ultra mode? */
-			if (!(sc.adapter_control & CFULTRAEN))
-				/* Treat us as a non-ultra card */
-				ultraenb = 0;
-		}
-
-		if (sc.signature == CFSIGNATURE
-		 || sc.signature == CFSIGNATURE2) {
-			uint32_t devconfig;
-
-			/* Honor the STPWLEVEL settings */
-			devconfig = ahc_pci_read_config(ahc->dev_softc,
-							DEVCONFIG, /*bytes*/4);
-			devconfig &= ~STPWLEVEL;
-			if ((sc.bios_control & CFSTPWLEVEL) != 0)
-				devconfig |= STPWLEVEL;
-			ahc_pci_write_config(ahc->dev_softc, DEVCONFIG,
-					     devconfig, /*bytes*/4);
-		}
-		/* Set SCSICONF info */
-		ahc_outb(ahc, SCSICONF, scsi_conf);
-		ahc_outb(ahc, DISC_DSB, ~(discenable & 0xff));
-		ahc_outb(ahc, DISC_DSB + 1, ~((discenable >> 8) & 0xff));
-		ahc_outb(ahc, ULTRA_ENB, ultraenb & 0xff);
-		ahc_outb(ahc, ULTRA_ENB + 1, (ultraenb >> 8) & 0xff);
+		ahc_parse_pci_eeprom(ahc, sc);
 	}
 
 	/*
@@ -1389,10 +1311,6 @@
 	 * hasn't failed yet...
 	 */
 	have_autoterm = have_seeprom;
-	if (have_seeprom)
-		adapter_control = sc.adapter_control;
-	else
-		adapter_control = CFAUTOTERM;
 
 	/*
 	 * Some low-cost chips have SEEPROM and auto-term control built
@@ -1400,17 +1318,141 @@
 	 * if the termination logic is enabled.
 	 */
 	if ((ahc->features & AHC_SPIOCAP) != 0) {
-		if ((ahc_inb(ahc, SPIOCAP) & SSPIOCPS) != 0)
-			have_autoterm = TRUE;
-		else
+		if ((ahc_inb(ahc, SPIOCAP) & SSPIOCPS) == 0)
 			have_autoterm = FALSE;
 	}
 
 	if (have_autoterm) {
-		acquire_seeprom(ahc, &sd);
-		configure_termination(ahc, &sd, adapter_control, sxfrctl1);
-		release_seeprom(&sd);
+		ahc_acquire_seeprom(ahc, &sd);
+		configure_termination(ahc, &sd, sc->adapter_control, sxfrctl1);
+		ahc_release_seeprom(&sd);
+	} else if (have_seeprom) {
+		*sxfrctl1 &= ~STPWEN;
+		if ((sc->adapter_control & CFSTERM) != 0)
+			*sxfrctl1 |= STPWEN;
+		if (bootverbose)
+			printf("%s: Low byte termination %sabled\n",
+			       ahc_name(ahc),
+			       (*sxfrctl1 & STPWEN) ? "en" : "dis");
+	}
+}
+
+static void
+ahc_parse_pci_eeprom(struct ahc_softc *ahc, struct seeprom_config *sc)
+{
+	/*
+	 * Put the data we've collected down into SRAM
+	 * where ahc_init will find it.
+	 */
+	int	 i;
+	int	 max_targ = sc->max_targets & CFMAXTARG;
+	u_int	 scsi_conf;
+	uint16_t discenable;
+	uint16_t ultraenb;
+
+	discenable = 0;
+	ultraenb = 0;
+	if ((sc->adapter_control & CFULTRAEN) != 0) {
+		/*
+		 * Determine if this adapter has a "newstyle"
+		 * SEEPROM format.
+		 */
+		for (i = 0; i < max_targ; i++) {
+			if ((sc->device_flags[i] & CFSYNCHISULTRA) != 0) {
+				ahc->flags |= AHC_NEWEEPROM_FMT;
+				break;
+			}
+		}
+	}
+
+	for (i = 0; i < max_targ; i++) {
+		u_int     scsirate;
+		uint16_t target_mask;
+
+		target_mask = 0x01 << i;
+		if (sc->device_flags[i] & CFDISC)
+			discenable |= target_mask;
+		if ((ahc->flags & AHC_NEWEEPROM_FMT) != 0) {
+			if ((sc->device_flags[i] & CFSYNCHISULTRA) != 0)
+				ultraenb |= target_mask;
+		} else if ((sc->adapter_control & CFULTRAEN) != 0) {
+			ultraenb |= target_mask;
+		}
+		if ((sc->device_flags[i] & CFXFER) == 0x04
+		 && (ultraenb & target_mask) != 0) {
+			/* Treat 10MHz as a non-ultra speed */
+			sc->device_flags[i] &= ~CFXFER;
+		 	ultraenb &= ~target_mask;
+		}
+		if ((ahc->features & AHC_ULTRA2) != 0) {
+			u_int offset;
+
+			if (sc->device_flags[i] & CFSYNCH)
+				offset = MAX_OFFSET_ULTRA2;
+			else 
+				offset = 0;
+			ahc_outb(ahc, TARG_OFFSET + i, offset);
+
+			/*
+			 * The ultra enable bits contain the
+			 * high bit of the ultra2 sync rate
+			 * field.
+			 */
+			scsirate = (sc->device_flags[i] & CFXFER)
+				 | ((ultraenb & target_mask) ? 0x8 : 0x0);
+			if (sc->device_flags[i] & CFWIDEB)
+				scsirate |= WIDEXFER;
+		} else {
+			scsirate = (sc->device_flags[i] & CFXFER) << 4;
+			if (sc->device_flags[i] & CFSYNCH)
+				scsirate |= SOFS;
+			if (sc->device_flags[i] & CFWIDEB)
+				scsirate |= WIDEXFER;
+		}
+		ahc_outb(ahc, TARG_SCSIRATE + i, scsirate);
+	}
+	ahc->our_id = sc->brtime_id & CFSCSIID;
+
+	scsi_conf = (ahc->our_id & 0x7);
+	if (sc->adapter_control & CFSPARITY)
+		scsi_conf |= ENSPCHK;
+	if (sc->adapter_control & CFRESETB)
+		scsi_conf |= RESET_SCSI;
+
+	ahc->flags |= (sc->adapter_control & CFBOOTCHAN) >> CFBOOTCHANSHIFT;
+
+	if (sc->bios_control & CFEXTEND)
+		ahc->flags |= AHC_EXTENDED_TRANS_A;
+
+	if (sc->bios_control & CFBIOSEN)
+		ahc->flags |= AHC_BIOS_ENABLED;
+	if (ahc->features & AHC_ULTRA
+	 && (ahc->flags & AHC_NEWEEPROM_FMT) == 0) {
+		/* Should we enable Ultra mode? */
+		if (!(sc->adapter_control & CFULTRAEN))
+			/* Treat us as a non-ultra card */
+			ultraenb = 0;
+	}
+
+	if (sc->signature == CFSIGNATURE
+	 || sc->signature == CFSIGNATURE2) {
+		uint32_t devconfig;
+
+		/* Honor the STPWLEVEL settings */
+		devconfig = ahc_pci_read_config(ahc->dev_softc,
+						DEVCONFIG, /*bytes*/4);
+		devconfig &= ~STPWLEVEL;
+		if ((sc->bios_control & CFSTPWLEVEL) != 0)
+			devconfig |= STPWLEVEL;
+		ahc_pci_write_config(ahc->dev_softc, DEVCONFIG,
+				     devconfig, /*bytes*/4);
 	}
+	/* Set SCSICONF info */
+	ahc_outb(ahc, SCSICONF, scsi_conf);
+	ahc_outb(ahc, DISC_DSB, ~(discenable & 0xff));
+	ahc_outb(ahc, DISC_DSB + 1, ~((discenable >> 8) & 0xff));
+	ahc_outb(ahc, ULTRA_ENB, ultraenb & 0xff);
+	ahc_outb(ahc, ULTRA_ENB + 1, (ultraenb >> 8) & 0xff);
 }
 
 static void
@@ -1453,10 +1495,10 @@
 		enablePRI_high = 0;
 		if ((ahc->features & AHC_NEW_TERMCTL) != 0) {
 			ahc_new_term_detect(ahc, &enableSEC_low,
-					       &enableSEC_high,
-					       &enablePRI_low,
-					       &enablePRI_high,
-					       &eeprom_present);
+					    &enableSEC_high,
+					    &enablePRI_low,
+					    &enablePRI_high,
+					    &eeprom_present);
 			if ((adapter_control & CFSEAUTOTERM) == 0) {
 				if (bootverbose)
 					printf("%s: Manual SE Termination\n",
@@ -1534,6 +1576,15 @@
 			       "Only two connectors on the "
 			       "adapter may be used at a "
 			       "time!\n", ahc_name(ahc));
+
+			/*
+			 * Pretend there are no cables in the hope
+			 * that having all of the termination on
+			 * gives us a more stable bus.
+			 */
+		 	internal50_present = 0;
+			internal68_present = 0;
+			externalcable_present = 0;
 		}
 
 		if ((ahc->features & AHC_WIDE) != 0
@@ -1696,7 +1747,12 @@
 		     int *externalcable_present, int *eeprom_present)
 {
 	uint8_t brdctl;
+	uint8_t spiocap;
 
+	spiocap = ahc_inb(ahc, SPIOCAP);
+	spiocap &= ~SOFTCMDEN;
+	spiocap |= EXT_BRDCTL;
+	ahc_outb(ahc, SPIOCAP, spiocap);
 	ahc_outb(ahc, BRDCTL, BRDRW|BRDCS);
 	ahc_outb(ahc, BRDCTL, 0);
 	brdctl = ahc_inb(ahc, BRDCTL);
@@ -1706,41 +1762,6 @@
 	*eeprom_present = (ahc_inb(ahc, SPIOCAP) & EEPROM) ? 1 : 0;
 }
 	
-static int
-acquire_seeprom(struct ahc_softc *ahc, struct seeprom_descriptor *sd)
-{
-	int wait;
-
-	if ((ahc->features & AHC_SPIOCAP) != 0
-	 && (ahc_inb(ahc, SPIOCAP) & SEEPROM) == 0)
-		return (0);
-
-	/*
-	 * Request access of the memory port.  When access is
-	 * granted, SEERDY will go high.  We use a 1 second
-	 * timeout which should be near 1 second more than
-	 * is needed.  Reason: after the chip reset, there
-	 * should be no contention.
-	 */
-	SEEPROM_OUTB(sd, sd->sd_MS);
-	wait = 1000;  /* 1 second timeout in msec */
-	while (--wait && ((SEEPROM_STATUS_INB(sd) & sd->sd_RDY) == 0)) {
-		ahc_delay(1000);  /* delay 1 msec */
-	}
-	if ((SEEPROM_STATUS_INB(sd) & sd->sd_RDY) == 0) {
-		SEEPROM_OUTB(sd, 0); 
-		return (0);
-	}
-	return(1);
-}
-
-static void
-release_seeprom(struct seeprom_descriptor *sd)
-{
-	/* Release access to the memory port and the serial EEPROM. */
-	SEEPROM_OUTB(sd, 0);
-}
-
 static void
 write_brdctl(struct ahc_softc *ahc, uint8_t value)
 {
===== drivers/scsi/aic7xxx/scsi_message.h 1.2 vs edited =====
--- 1.2/drivers/scsi/aic7xxx/scsi_message.h	Tue Feb  5 16:38:15 2002
+++ edited/drivers/scsi/aic7xxx/scsi_message.h	Thu Oct 24 14:18:15 2002
@@ -46,7 +46,7 @@
 #define MSG_IDENTIFY_DISCFLAG	0x40 
 #define MSG_IDENTIFY(lun, disc)	(((disc) ? 0xc0 : MSG_IDENTIFYFLAG) | (lun))
 #define MSG_ISIDENTIFY(m)	((m) & MSG_IDENTIFYFLAG)
-#define MSG_IDENTIFY_LUNMASK	0x03F 
+#define MSG_IDENTIFY_LUNMASK	0x3F 
 
 /* Extended messages (opcode and length) */
 #define MSG_EXT_SDTR		0x01
@@ -60,6 +60,11 @@
 
 #define MSG_EXT_PPR		0x04 /* SPI3 */
 #define MSG_EXT_PPR_LEN		0x06
-#define MSG_EXT_PPR_QAS_REQ	0x04
-#define MSG_EXT_PPR_DT_REQ	0x02
+#define	MSG_EXT_PPR_PCOMP_EN	0x80
+#define	MSG_EXT_PPR_RTI		0x40
+#define	MSG_EXT_PPR_RD_STRM	0x20
+#define	MSG_EXT_PPR_WR_FLOW	0x10
+#define	MSG_EXT_PPR_HOLD_MCS	0x08
+#define	MSG_EXT_PPR_QAS_REQ	0x04
+#define	MSG_EXT_PPR_DT_REQ	0x02
 #define MSG_EXT_PPR_IU_REQ	0x01
===== drivers/scsi/aic7xxx/aic7xxx_93cx6.h 1.2 vs edited =====
--- 1.2/drivers/scsi/aic7xxx/aic7xxx_93cx6.h	Tue Feb  5 16:53:47 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx_93cx6.h	Wed Oct 23 16:13:40 2002
@@ -38,9 +38,9 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  *
- * $Id: //depot/aic7xxx/aic7xxx/aic7xxx_93cx6.h#7 $
+ * $Id: //depot/aic7xxx/aic7xxx/aic7xxx_93cx6.h#10 $
  *
- * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx_93cx6.h,v 1.8 2000/11/10 20:13:41 gibbs Exp $
+ * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx_93cx6.h,v 1.7.2.3 2002/04/29 19:36:31 gibbs Exp $
  */
 #ifndef _AIC7XXX_93CX6_H_
 #define _AIC7XXX_93CX6_H_
@@ -93,8 +93,10 @@
 #define	SEEPROM_DATA_INB(sd) \
 	ahc_inb(sd->sd_ahc, sd->sd_dataout_offset)
 
-int read_seeprom(struct seeprom_descriptor *sd, uint16_t *buf,
-		 u_int start_addr, u_int count);
-int verify_cksum(struct seeprom_config *sc);
+int ahc_read_seeprom(struct seeprom_descriptor *sd, uint16_t *buf,
+		     u_int start_addr, u_int count);
+int ahc_write_seeprom(struct seeprom_descriptor *sd, uint16_t *buf,
+		      u_int start_addr, u_int count);
+int ahc_verify_cksum(struct seeprom_config *sc);
 
 #endif /* _AIC7XXX_93CX6_H_ */
===== drivers/scsi/aic7xxx/aic7xxx_93cx6.c 1.4 vs edited =====
--- 1.4/drivers/scsi/aic7xxx/aic7xxx_93cx6.c	Tue Feb  5 16:53:47 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx_93cx6.c	Wed Oct 23 16:12:20 2002
@@ -28,9 +28,9 @@
  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
  * SUCH DAMAGE.
  *
- * $Id: //depot/aic7xxx/aic7xxx/aic7xxx_93cx6.c#10 $
+ * $Id: //depot/aic7xxx/aic7xxx/aic7xxx_93cx6.c#15 $
  *
- * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx_93cx6.c,v 1.9 2000/11/10 20:13:41 gibbs Exp $
+ * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx_93cx6.c,v 1.8.2.5 2002/04/29 19:36:31 gibbs Exp $
  */
 
 /*
@@ -77,9 +77,13 @@
  */
 static struct seeprom_cmd {
   	uint8_t len;
- 	uint8_t bits[3];
+ 	uint8_t bits[9];
 } seeprom_read = {3, {1, 1, 0}};
 
+static struct seeprom_cmd seeprom_ewen = {9, {1, 0, 0, 1, 1, 0, 0, 0, 0}};
+static struct seeprom_cmd seeprom_ewds = {9, {1, 0, 0, 0, 0, 0, 0, 0, 0}};
+static struct seeprom_cmd seeprom_write = {3, {1, 0, 1}};
+
 /*
  * Wait for the SEERDY to go high; about 800 ns.
  */
@@ -90,15 +94,55 @@
 	(void)SEEPROM_INB(sd);	/* Clear clock */
 
 /*
+ * Send a START condition and the given command
+ */
+static void
+send_seeprom_cmd(struct seeprom_descriptor *sd, struct seeprom_cmd *cmd)
+{
+	uint8_t temp;
+	int i = 0;
+
+	/* Send chip select for one clock cycle. */
+	temp = sd->sd_MS ^ sd->sd_CS;
+	SEEPROM_OUTB(sd, temp ^ sd->sd_CK);
+	CLOCK_PULSE(sd, sd->sd_RDY);
+
+	for (i = 0; i < cmd->len; i++) {
+		if (cmd->bits[i] != 0)
+			temp ^= sd->sd_DO;
+		SEEPROM_OUTB(sd, temp);
+		CLOCK_PULSE(sd, sd->sd_RDY);
+		SEEPROM_OUTB(sd, temp ^ sd->sd_CK);
+		CLOCK_PULSE(sd, sd->sd_RDY);
+		if (cmd->bits[i] != 0)
+			temp ^= sd->sd_DO;
+	}
+}
+
+/*
+ * Clear CS put the chip in the reset state, where it can wait for new commands.
+ */
+static void
+reset_seeprom(struct seeprom_descriptor *sd)
+{
+	uint8_t temp;
+
+	temp = sd->sd_MS;
+	SEEPROM_OUTB(sd, temp);
+	CLOCK_PULSE(sd, sd->sd_RDY);
+	SEEPROM_OUTB(sd, temp ^ sd->sd_CK);
+	CLOCK_PULSE(sd, sd->sd_RDY);
+	SEEPROM_OUTB(sd, temp);
+	CLOCK_PULSE(sd, sd->sd_RDY);
+}
+
+/*
  * Read the serial EEPROM and returns 1 if successful and 0 if
  * not successful.
  */
 int
-read_seeprom(sd, buf, start_addr, count)
-	struct seeprom_descriptor *sd;
-	uint16_t *buf;
-	u_int start_addr;
-	u_int count;
+ahc_read_seeprom(struct seeprom_descriptor *sd, uint16_t *buf,
+		 u_int start_addr, u_int count)
 {
 	int i = 0;
 	u_int k = 0;
@@ -110,26 +154,14 @@
 	 * will range from 0 to count-1.
 	 */
 	for (k = start_addr; k < count + start_addr; k++) {
-		/* Send chip select for one clock cycle. */
-		temp = sd->sd_MS ^ sd->sd_CS;
-		SEEPROM_OUTB(sd, temp ^ sd->sd_CK);
-		CLOCK_PULSE(sd, sd->sd_RDY);
-
 		/*
 		 * Now we're ready to send the read command followed by the
 		 * address of the 16-bit register we want to read.
 		 */
-		for (i = 0; i < seeprom_read.len; i++) {
-			if (seeprom_read.bits[i] != 0)
-				temp ^= sd->sd_DO;
-			SEEPROM_OUTB(sd, temp);
-			CLOCK_PULSE(sd, sd->sd_RDY);
-			SEEPROM_OUTB(sd, temp ^ sd->sd_CK);
-			CLOCK_PULSE(sd, sd->sd_RDY);
-			if (seeprom_read.bits[i] != 0)
-				temp ^= sd->sd_DO;
-		}
+		send_seeprom_cmd(sd, &seeprom_read);
+
 		/* Send the 6 or 8 bit address (MSB first, LSB last). */
+		temp = sd->sd_MS ^ sd->sd_CS;
 		for (i = (sd->sd_chip - 1); i >= 0; i--) {
 			if ((k & (1 << i)) != 0)
 				temp ^= sd->sd_DO;
@@ -161,13 +193,7 @@
 		buf[k - start_addr] = v;
 
 		/* Reset the chip select for the next command cycle. */
-		temp = sd->sd_MS;
-		SEEPROM_OUTB(sd, temp);
-		CLOCK_PULSE(sd, sd->sd_RDY);
-		SEEPROM_OUTB(sd, temp ^ sd->sd_CK);
-		CLOCK_PULSE(sd, sd->sd_RDY);
-		SEEPROM_OUTB(sd, temp);
-		CLOCK_PULSE(sd, sd->sd_RDY);
+		reset_seeprom(sd);
 	}
 #ifdef AHC_DUMP_EEPROM
 	printf("\nSerial EEPROM:\n\t");
@@ -182,8 +208,77 @@
 	return (1);
 }
 
+/*
+ * Write the serial EEPROM and return 1 if successful and 0 if
+ * not successful.
+ */
+int
+ahc_write_seeprom(struct seeprom_descriptor *sd, uint16_t *buf,
+		  u_int start_addr, u_int count)
+{
+	uint16_t v;
+	uint8_t temp;
+	int i, k;
+
+	/* Place the chip into write-enable mode */
+	send_seeprom_cmd(sd, &seeprom_ewen);
+	reset_seeprom(sd);
+
+	/* Write all requested data out to the seeprom. */
+	temp = sd->sd_MS ^ sd->sd_CS;
+	for (k = start_addr; k < count + start_addr; k++) {
+		/* Send the write command */
+		send_seeprom_cmd(sd, &seeprom_write);
+
+		/* Send the 6 or 8 bit address (MSB first). */
+		for (i = (sd->sd_chip - 1); i >= 0; i--) {
+			if ((k & (1 << i)) != 0)
+				temp ^= sd->sd_DO;
+			SEEPROM_OUTB(sd, temp);
+			CLOCK_PULSE(sd, sd->sd_RDY);
+			SEEPROM_OUTB(sd, temp ^ sd->sd_CK);
+			CLOCK_PULSE(sd, sd->sd_RDY);
+			if ((k & (1 << i)) != 0)
+				temp ^= sd->sd_DO;
+		}
+
+		/* Write the 16 bit value, MSB first */
+		v = buf[k - start_addr];
+		for (i = 15; i >= 0; i--) {
+			if ((v & (1 << i)) != 0)
+				temp ^= sd->sd_DO;
+			SEEPROM_OUTB(sd, temp);
+			CLOCK_PULSE(sd, sd->sd_RDY);
+			SEEPROM_OUTB(sd, temp ^ sd->sd_CK);
+			CLOCK_PULSE(sd, sd->sd_RDY);
+			if ((v & (1 << i)) != 0)
+				temp ^= sd->sd_DO;
+		}
+
+		/* Wait for the chip to complete the write */
+		temp = sd->sd_MS;
+		SEEPROM_OUTB(sd, temp);
+		CLOCK_PULSE(sd, sd->sd_RDY);
+		temp = sd->sd_MS ^ sd->sd_CS;
+		do {
+			SEEPROM_OUTB(sd, temp);
+			CLOCK_PULSE(sd, sd->sd_RDY);
+			SEEPROM_OUTB(sd, temp ^ sd->sd_CK);
+			CLOCK_PULSE(sd, sd->sd_RDY);
+		} while ((SEEPROM_DATA_INB(sd) & sd->sd_DI) == 0);
+
+		reset_seeprom(sd);
+	}
+
+	/* Put the chip back into write-protect mode */
+	send_seeprom_cmd(sd, &seeprom_ewds);
+	reset_seeprom(sd);
+
+	return (1);
+}
+
 int
-verify_cksum(struct seeprom_config *sc)
+ahc_verify_cksum(struct seeprom_config *sc)
 {
 	int i;
 	int maxaddr;

