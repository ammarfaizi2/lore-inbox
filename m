Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSGQQz6>; Wed, 17 Jul 2002 12:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSGQQz6>; Wed, 17 Jul 2002 12:55:58 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:61584 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315439AbSGQQzv>; Wed, 17 Jul 2002 12:55:51 -0400
Message-ID: <3D35A242.5223261F@nortelnetworks.com>
Date: Wed, 17 Jul 2002 12:58:42 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] suni PHY driver fault handling enhancements
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another ATM patch I'm posting to the list in the hopes that someone picks it up
to pass on to Marcello and Linus since there is no ATM maintainer. It's based
and tested on 2.4.18, but it compiled on 2.5.20 (I haven't tried later ones).

The primary purpose of this patch is to add interrupt-driven detection of many
more SONET fault conditions, as well as a way for userspace to query the current
SONET status.

This patch also removes a broken and unnecessary udelay() in the driver.  The
old udelay() was waiting 1us, while the hardware can take up to 7us before it is
ready to read.  The new method triggers the latch and then reads the data the
next time through the poll routine (a second later).  This means we are a second
out in our counts, but we don't need to busy-wait.

Chris



diff -Nur linux-2.4.18-vanilla/drivers/atm/suni.c
linux-2.4.18/drivers/atm/suni.c
--- linux-2.4.18-vanilla/drivers/atm/suni.c	Tue Nov 13 12:19:41 2001
+++ linux-2.4.18/drivers/atm/suni.c	Wed Jul 17 12:31:59 2002
@@ -35,6 +35,7 @@
 	int loop_mode;			/* loopback mode */
 	struct atm_dev *dev;		/* device back-pointer */
 	struct suni_priv *next;		/* next SUNI */
+	struct sonet_status stat_field;	/* status for userspace */
 };
 
 
@@ -56,6 +57,18 @@
     if (atomic_read(&stats->s) < 0) atomic_set(&stats->s,INT_MAX);
 
 
+static void suni_hz(unsigned long from_timer);
+static int fetch_stats(struct atm_dev *dev,struct sonet_stats *arg,int zero);
+static int change_diag(struct atm_dev *dev,void *arg,int set);
+static int get_diag(struct atm_dev *dev,void *arg);
+static int set_loopback(struct atm_dev *dev,int mode);
+static int suni_ioctl(struct atm_dev *dev,unsigned int cmd,void *arg);
+static void poll_status(struct atm_dev *dev);
+static void suni_int(struct atm_dev *dev);
+		
+		
+		
+		
 static void suni_hz(unsigned long from_timer)
 {
 	struct suni_priv *walk;
@@ -65,8 +78,13 @@
 	for (walk = sunis; walk; walk = walk->next) {
 		dev = walk->dev;
 		stats = &walk->sonet_stats;
-		PUT(0,MRI); /* latch counters */
-		udelay(1);
+		
+		/* There is a "feature" of this chip that is a bit odd,
+		 * in that it continues to increment the line and path
+		 * FEBE counts even when it in in an LOS condition.
+		 * We may eventually want to deal with this.
+		 */
+		
 		ADD_LIMITED(section_bip,(GET(RSOP_SBL) & 0xff) |
 		    ((GET(RSOP_SBM) & 0xff) << 8));
 		ADD_LIMITED(line_bip,(GET(RLOP_LBL) & 0xff) |
@@ -87,6 +105,14 @@
 		ADD_LIMITED(tx_cells,(GET(TACP_TCCL) & 0xff) |
 		    ((GET(TACP_TCC) & 0xff) << 8) |
 		    ((GET(TACP_TCCM) & 7) << 16));
+		
+		/* the chip requires up to 7us to latch some of these counts,
+		 * so we'll trigger it after reading and give the chip a full
+		 * second to latch.  The initial trigger is done in suni_start
+		 * just before setting up suni_hz
+		 */
+		
+		PUT(0,MRI); /* latch counters */
 	}
 	if (from_timer) mod_timer(&poll_timer,jiffies+HZ);
 }
@@ -120,6 +146,7 @@
 	int todo;
 
 	if (get_user(todo,(int *) arg)) return -EFAULT;
+	
 	HANDLE_FLAG(SONET_INS_SBIP,TSOP_DIAG,SUNI_TSOP_DIAG_DBIP8);
 	HANDLE_FLAG(SONET_INS_LBIP,TLOP_DIAG,SUNI_TLOP_DIAG_DBIP);
 	HANDLE_FLAG(SONET_INS_PBIP,TPOP_CD,SUNI_TPOP_DIAG_DB3);
@@ -128,7 +155,10 @@
 	HANDLE_FLAG(SONET_INS_PAIS,TPOP_CD,SUNI_TPOP_DIAG_PAIS);
 	HANDLE_FLAG(SONET_INS_LOS,TSOP_DIAG,SUNI_TSOP_DIAG_DLOS);
 	HANDLE_FLAG(SONET_INS_HCS,TACP_CS,SUNI_TACP_CS_DHCS);
-	return put_user(todo,(int *) arg) ? -EFAULT : 0;
+	HANDLE_FLAG(SONET_INS_LRDI,TLOP_CTRL,SUNI_TLOP_CTRL_RDI);
+	HANDLE_FLAG(SONET_INS_PRDI,TPOP_PS,SUNI_TPOP_PS_PRDI);
+	
+	return put_user(todo,(int *) arg) ? -EFAULT : 0;	
 }
 
 
@@ -143,11 +173,17 @@
 	if (GET(TSOP_DIAG) & SUNI_TSOP_DIAG_DBIP8) set |= SONET_INS_SBIP;
 	if (GET(TLOP_DIAG) & SUNI_TLOP_DIAG_DBIP) set |= SONET_INS_LBIP;
 	if (GET(TPOP_CD) & SUNI_TPOP_DIAG_DB3) set |= SONET_INS_PBIP;
-	/* SONET_INS_FRAME is one-shot only */
+	/* SONET_INS_FRAME is one-shot only on actual PMC hardware,
+         * seems to be persistant on idt77155.  Register is write-only
+         * in PMC documentation.
+         */
 	if (GET(TSOP_CTRL) & SUNI_TSOP_CTRL_LAIS) set |= SONET_INS_LAIS;
 	if (GET(TPOP_CD) & SUNI_TPOP_DIAG_PAIS) set |= SONET_INS_PAIS;
 	if (GET(TSOP_DIAG) & SUNI_TSOP_DIAG_DLOS) set |= SONET_INS_LOS;
 	if (GET(TACP_CS) & SUNI_TACP_CS_DHCS) set |= SONET_INS_HCS;
+	if (GET(TLOP_CTRL) & SUNI_TLOP_CTRL_RDI) set |= SONET_INS_LRDI;
+	if (GET(TPOP_PS) & SUNI_TPOP_PS_PRDI) set |= SONET_INS_PRDI;
+        
 	return put_user(set,(int *) arg) ? -EFAULT : 0;
 }
 
@@ -196,6 +232,9 @@
 			    -EFAULT : 0;
 		case SONET_GETFRSENSE:
 			return -EINVAL;
+		case SONET_GETSTATUS:
+			return put_user(PRIV(dev)->stat_field, (struct sonet_status *) arg) ?
+			    -EFAULT : 0;
 		case ATM_SETLOOP:
 			return set_loopback(dev,(int) (long) arg);
 		case ATM_GETLOOP:
@@ -209,19 +248,80 @@
 	}
 }
 
+#define PRINTSTAT(bit, name) \
+	( printk(KERN_NOTICE "%s(itf %d): %s %s\n",dev->type,dev->number, \
+   #name, stat_field->bit ?  "declared" : "cleared"))
 
-static void poll_los(struct atm_dev *dev)
+static void poll_status(struct atm_dev *dev)
 {
-	dev->signal = GET(RSOP_SIS) & SUNI_RSOP_SIS_LOSV ? ATM_PHY_SIG_LOST :
-	  ATM_PHY_SIG_FOUND;
+	struct  sonet_status *stat_field = &PRIV(dev)->stat_field;
+	
+	/* get master interrupt status to see what caused the interrupt */
+	int mis = GET(MIS);
+
+	if (mis & SUNI_MIS_RSOPI) {
+		int rsop_sis = GET(RSOP_SIS);
+		
+		if (rsop_sis & SUNI_RSOP_SIS_LOSI) {
+			stat_field->los = (rsop_sis & SUNI_RSOP_SIS_LOSV)?1:0;
+			PRINTSTAT(los,LOS);
+			dev->signal = stat_field->los ? ATM_PHY_SIG_LOST : ATM_PHY_SIG_FOUND;
+		}
+		if (rsop_sis & SUNI_RSOP_SIS_LOFI) {
+			stat_field->lof = (rsop_sis & SUNI_RSOP_SIS_LOFV)?1:0;
+			PRINTSTAT(lof,LOF);
+		}
+		if (rsop_sis & SUNI_RSOP_SIS_OOFI) {
+			stat_field->oof = (rsop_sis & SUNI_RSOP_SIS_OOFV)?1:0;
+			PRINTSTAT(oof,OOF);
+		}
+	}
+	
+	if (mis & SUNI_MIS_RLOPI) {
+		int rlop_ies, rlop_cs;
+		rlop_ies = GET(RLOP_IES);
+		rlop_cs = GET(RLOP_CS);
+		
+		if (rlop_ies & SUNI_RLOP_IES_RDII) {
+			stat_field->lrdi = (rlop_cs & SUNI_RLOP_IES_RDIV)?1:0;
+			PRINTSTAT(lrdi,LRDI);
+		}
+		if (rlop_ies & SUNI_RLOP_IES_LAISI) {
+			stat_field->lais = (rlop_cs & SUNI_RLOP_IES_LAISV)?1:0;
+			PRINTSTAT(lais,LAIS);
+		}
+	}
+	
+	if (mis & SUNI_MIS_RPOPI) {
+		int rpop_is, rpop_sc;
+		rpop_is = GET(RPOP_IS);
+		rpop_sc = GET(RPOP_SC);
+		
+		if (rpop_is & SUNI_RPOP_IS_PRDII) {
+			stat_field->prdi = (rpop_sc & SUNI_RPOP_IS_PRDI)?1:0;
+			PRINTSTAT(prdi,PRDI);
+		}
+		if (rpop_is & SUNI_RPOP_IS_PAISI) {
+			stat_field->pais = (rpop_sc & SUNI_RPOP_IS_PAIS)?1:0;
+			PRINTSTAT(pais,PAIS);
+		}
+		if (rpop_is & SUNI_RPOP_IS_LOPI) {
+			stat_field->lop = (rpop_sc & SUNI_RPOP_IS_LOP)?1:0;
+			PRINTSTAT(lop,LOP);
+		}
+	}
+	
+	if (mis & SUNI_MIS_LCDI) {
+		int mct = GET(MCT);
+		stat_field->lcd = (mct & SUNI_MCT_LCDV)?1:0;
+		PRINTSTAT(lcd,LCD);
+	}	
 }
 
 
 static void suni_int(struct atm_dev *dev)
 {
-	poll_los(dev);
-	printk(KERN_NOTICE "%s(itf %d): signal %s\n",dev->type,dev->number,
-	    dev->signal == ATM_PHY_SIG_LOST ?  "lost" : "detected again");
+	poll_status(dev);
 }
 
 
@@ -242,14 +342,30 @@
 	sunis = PRIV(dev);
 	spin_unlock_irqrestore(&sunis_lock,flags);
 	memset(&PRIV(dev)->sonet_stats,0,sizeof(struct k_sonet_stats));
-	PUT(GET(RSOP_CIE) | SUNI_RSOP_CIE_LOSE,RSOP_CIE);
-		/* interrupt on loss of signal */
-	poll_los(dev); /* ... and clear SUNI interrupts */
+	memset(&PRIV(dev)->stat_field,0,sizeof(struct sonet_status));
+	
+	/* interrupt on LOS, OOF, LOF */
+	PUT(GET(RSOP_CIE) | SUNI_RSOP_CIE_LOSE | SUNI_RSOP_CIE_OOFE |
SUNI_RSOP_CIE_LOFE, 
+		RSOP_CIE);
+	
+	/* interrupt on LCD */
+	PUT(GET(MCT) | SUNI_MCT_LCDE, MCT);
+	
+	/* interrupt on LOP, PRDI, PAIS */
+	PUT(GET(RPOP_IE) | SUNI_RPOP_IE_LOPE | SUNI_RPOP_IE_PAISE |
SUNI_RPOP_IE_PRDIE, 
+		RPOP_IE);
+	
+	/* interrupt on LRDI, LAIS */
+	PUT(GET(RLOP_IES) | SUNI_RLOP_IES_LAISE | SUNI_RLOP_IES_RDIE, RLOP_IES);
+	
+	
+	poll_status(dev); /* ... and clear SUNI interrupts */
 	if (dev->signal == ATM_PHY_SIG_LOST)
 		printk(KERN_WARNING "%s(itf %d): no signal\n",dev->type,
 		    dev->number);
 	PRIV(dev)->loop_mode = ATM_LM_NONE;
-	suni_hz(0); /* clear SUNI counters */
+	
+	PUT(0,MRI); /* latch counters -- takes 7us to become readable so don't read
yet */
 	(void) fetch_stats(dev,NULL,1); /* clear kernel counters */
 	if (first) {
 		init_timer(&poll_timer);
diff -Nur linux-2.4.18-vanilla/drivers/atm/suni.h
linux-2.4.18/drivers/atm/suni.h
--- linux-2.4.18-vanilla/drivers/atm/suni.h	Mon Dec 11 16:21:57 2000
+++ linux-2.4.18/drivers/atm/suni.h	Wed Jul 17 12:10:13 2002
@@ -97,6 +97,12 @@
 #define SUNI_MRI_RESET		0x80	/* RW, reset & power down chip
 					   0: normal operation
 					   1: reset & low power */
+/* MIS is reg 2 */
+#define SUNI_MIS_RSOPI		0x01	/* R, interrupt from RSOP block */
+#define SUNI_MIS_RLOPI		0x02	/* R, interrupt from RLOP block */
+#define SUNI_MIS_RPOPI		0x04	/* R, interrupt from RPOP block */
+#define SUNI_MIS_LCDI		0x40	/* R, entered/left LCD */
+
 /* MCT is reg 5 */
 #define SUNI_MCT_LOOPT		0x01	/* RW, timing source, 0: from
 					   TRCLK+/- */
@@ -141,9 +147,40 @@
 #define SUNI_TSOP_DIAG_DBIP8	0x02	/* insert section BIP err (cont) */
 #define SUNI_TSOP_DIAG_DLOS	0x04	/* set line to zero (loss of signal) */
 
+/* RLOP_CS is reg 0x18 */
+#define SUNI_RLOP_IES_RDIV	0x01	/* R, line RDI  */
+#define SUNI_RLOP_IES_LAISV	0x02	/* R, line AIS */
+
+/* RLOP_IES is reg 0x19 */
+#define SUNI_RLOP_IES_RDII	0x01	/* R, line RDI interrupt */
+#define SUNI_RLOP_IES_LAISI	0x02	/* R, LAIS interrupt */
+#define SUNI_RLOP_IES_RDIE	0x10	/* RW, line RDI interrupt enable */
+#define SUNI_RLOP_IES_LAISE	0x20	/* RW, LAIS interrupt enable */
+
+/* TLOP_CTRL is reg 0x20 */
+#define SUNI_TLOP_CTRL_RDI	0x01	/* RW, insert line RDI (cont) */
+
 /* TLOP_DIAG is reg 0x21 */
 #define SUNI_TLOP_DIAG_DBIP	0x01	/* insert line BIP err (continuously) */
 
+/* RPOP_SC is reg 0x30 */
+#define SUNI_RPOP_IS_PRDI	0x04	/* R, RDI */
+#define SUNI_RPOP_IS_PAIS	0x08	/* R, AIS */
+#define SUNI_RPOP_IS_LOP	0x20	/* R, loss of pointer */
+
+/* RPOP_IS is reg 0x31 */
+#define SUNI_RPOP_IS_PRDII	0x04	/* R, RDI interrupt */
+#define SUNI_RPOP_IS_PAISI	0x08	/* R, AIS interrupt */
+#define SUNI_RPOP_IS_LOPI	0x20	/* R, loss of pointer interrupt */
+
+/* RPOP_IE is reg 0x33 */
+#define SUNI_RPOP_IE_PRDIE	0x04	/* RW, enable interrupt on RDI 
+					   state change */
+#define SUNI_RPOP_IE_PAISE	0x08	/* RW, enable interrupt on AIS 
+					   state change */
+#define SUNI_RPOP_IE_LOPE	0x20	/* RW, enable interrupt on loss of
+					   pointer state change */
+
 /* TPOP_DIAG is reg 0x40 */
 #define SUNI_TPOP_DIAG_PAIS	0x01	/* insert STS path alarm ind (cont) */
 #define SUNI_TPOP_DIAG_DB3	0x02	/* insert path BIP err (continuously) */
@@ -160,6 +197,9 @@
 
 #define SUNI_TPOP_S_SONET	0	/* set S bits to 00 */
 #define SUNI_TPOP_S_SDH		2	/* set S bits to 10 */
+
+/* TPOP_PS is reg 0x49 */
+#define SUNI_TPOP_PS_PRDI	0x08	/* RW, insert path remote defect ind (cont) */
 
 /* RACP_IES is reg 0x51 */
 #define SUNI_RACP_IES_FOVRI	0x02	/* R, FIFO overrun */
diff -Nur linux-2.4.18-vanilla/include/linux/sonet.h
linux-2.4.18/include/linux/sonet.h
--- linux-2.4.18-vanilla/include/linux/sonet.h	Mon Dec 11 16:21:56 2000
+++ linux-2.4.18/include/linux/sonet.h	Wed Jul 17 12:09:22 2002
@@ -24,6 +24,19 @@
 } __attribute__ ((packed));
 
 
+struct sonet_status {
+        unsigned int los:1;             /* loss of signal */
+        unsigned int lof:1;             /* loss of frame */
+        unsigned int oof:1;             /* out of frame */
+        unsigned int lop:1;             /* loss of pointer */
+        unsigned int lcd:1;             /* loss of cell delineation */
+        unsigned int lrdi:1;            /* line remote defect indication */
+        unsigned int lais:1;            /* line AIS */
+        unsigned int prdi:1;            /* path remote defect indication */
+        unsigned int pais:1;            /* path AIS */
+};
+
+
 #define SONET_GETSTAT	_IOR('a',ATMIOC_PHYTYP,struct sonet_stats)
 					/* get statistics */
 #define SONET_GETSTATZ	_IOR('a',ATMIOC_PHYTYP+1,struct sonet_stats)
@@ -40,6 +53,9 @@
 					/* get framing mode */
 #define SONET_GETFRSENSE _IOR('a',ATMIOC_PHYTYP+7, \
   unsigned char[SONET_FRSENSE_SIZE])	/* get framing sense information */
+#define SONET_GETSTATUS _IOR('a',ATMIOC_PHYTYP+8,struct sonet_status)
+					/* get status */
+
 
 #define SONET_INS_SBIP	  1		/* section BIP */
 #define SONET_INS_LBIP	  2		/* line BIP */
@@ -49,6 +65,8 @@
 #define SONET_INS_LAIS	 32		/* line alarm indication signal */
 #define SONET_INS_PAIS	 64		/* path alarm indication signal */
 #define SONET_INS_HCS	128		/* insert HCS error */
+#define SONET_INS_LRDI  256		/* line remote defect indication */
+#define SONET_INS_PRDI  512		/* path remote defect indication */
 
 #define SONET_FRAME_SONET 0		/* SONET STS-3 framing */
 #define SONET_FRAME_SDH   1		/* SDH STM-1 framing */




-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
