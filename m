Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSFUJHY>; Fri, 21 Jun 2002 05:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSFUJHX>; Fri, 21 Jun 2002 05:07:23 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:53041 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316496AbSFUJHS>; Fri, 21 Jun 2002 05:07:18 -0400
Date: Fri, 21 Jun 2002 11:07:18 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
Message-ID: <20020621090718.GB27122@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
References: <20020620112543.GD26376@gum01m.etpnet.phys.tue.nl> <Pine.LNX.4.44.0206200816380.8012-100000@home.transmeta.com> <20020620183209.GF28800@gum01m.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020620183209.GF28800@gum01m.etpnet.phys.tue.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 08:32:09PM +0200, Kurt Garloff wrote:
> Please consider applying the attached patch which adds this line.

Updated patch (with MAJOR -> major correction) against 2.5.24 is here.

diff -uNr linux-2.5.24-dj1/drivers/scsi/hosts.h linux-2.5.24-dj1-scsirephl/drivers/scsi/hosts.h
--- linux-2.5.24-dj1/drivers/scsi/hosts.h	Fri Jun 21 07:51:45 2002
+++ linux-2.5.24-dj1-scsirephl/drivers/scsi/hosts.h	Fri Jun 21 08:22:27 2002
@@ -486,6 +486,7 @@
     void (*detach)(Scsi_Device *);
     int (*init_command)(Scsi_Cmnd *);     /* Used by new queueing code. 
                                            Selects command for blkdevs */
+    int (*find_kdev)(Scsi_Device *, char*, kdev_t*);  /* find back dev. */
 };
 
 void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt);
diff -uNr linux-2.5.24-dj1/drivers/scsi/osst.c linux-2.5.24-dj1-scsirephl/drivers/scsi/osst.c
--- linux-2.5.24-dj1/drivers/scsi/osst.c	Wed Jun 19 04:11:54 2002
+++ linux-2.5.24-dj1-scsirephl/drivers/scsi/osst.c	Fri Jun 21 08:22:27 2002
@@ -155,6 +155,7 @@
 static int osst_attach(Scsi_Device *);
 static int osst_detect(Scsi_Device *);
 static void osst_detach(Scsi_Device *);
+static int osst_find_kdev(Scsi_Device *, char*, kdev_t*);
 
 struct Scsi_Device_Template osst_template =
 {
@@ -166,7 +167,8 @@
        detect:		osst_detect,
        init:		osst_init,
        attach:		osst_attach,
-       detach:		osst_detach
+       detach:		osst_detach,
+       find_kdev:	osst_find_kdev,
 };
 
 static int osst_int_ioctl(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt, unsigned int cmd_in,unsigned long arg);
@@ -5417,6 +5419,24 @@
 	return 0;
 }
 
+static int osst_find_kdev(Scsi_Device *sdp, char* nm, kdev_t *dev)
+{
+	int i;
+	OS_Scsi_Tape *ostp;
+	
+	if (sdp && sdp->type == TYPE_TAPE && osst_supports(sdp)) {
+		for (ostp = os_scsi_tapes[i = 0]; i < osst_template.dev_max;
+		     ostp = os_scsi_tapes[++i]) {
+			if (ostp && ostp->device == sdp) {
+				sprintf (nm, "osst%i", i);
+				*dev = mk_kdev(OSST_MAJOR, i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 static int osst_attach(Scsi_Device * SDp)
 {
 	OS_Scsi_Tape * tpnt;
diff -uNr linux-2.5.24-dj1/drivers/scsi/scsi_proc.c linux-2.5.24-dj1-scsirephl/drivers/scsi/scsi_proc.c
--- linux-2.5.24-dj1/drivers/scsi/scsi_proc.c	Wed Jun 19 04:11:47 2002
+++ linux-2.5.24-dj1-scsirephl/drivers/scsi/scsi_proc.c	Fri Jun 21 08:21:44 2002
@@ -260,6 +260,10 @@
 
 	int x, y = *size;
 	extern const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE];
+	char nm[16];
+	kdev_t kdev;
+	int att = scd->attached;
+	struct Scsi_Device_Template *sd_t = scsi_devicelist;
 
 	y = sprintf(buffer + len,
 	     "Host: scsi%d Channel: %02d Id: %02d Lun: %02d\n  Vendor: ",
@@ -295,7 +299,24 @@
 		y += sprintf(buffer + len + y, " CCS\n");
 	else
 		y += sprintf(buffer + len + y, "\n");
+	
+	/* Report high level devices attached */
+	y += sprintf (buffer + len + y, "  Attached drivers:");
 
+	while (att && sd_t) {
+		if (sd_t->find_kdev) {
+			if (!(sd_t->find_kdev(scd, nm, &kdev))) {
+				y += sprintf(buffer + len + y,
+					     " %s(%c:%02x:%02x)",
+					     nm, (sd_t->blk? 'b': 'c'),
+					     major(kdev), minor(kdev));
+				--att;
+			}
+		}
+		sd_t = sd_t->next;
+	}
+
+	y += sprintf(buffer + len + y, "\n");
 	*size = y;
 	return;
 }
diff -uNr linux-2.5.24-dj1/drivers/scsi/sd.c linux-2.5.24-dj1-scsirephl/drivers/scsi/sd.c
--- linux-2.5.24-dj1/drivers/scsi/sd.c	Fri Jun 21 07:51:45 2002
+++ linux-2.5.24-dj1-scsirephl/drivers/scsi/sd.c	Fri Jun 21 08:22:27 2002
@@ -103,6 +103,7 @@
 static int sd_detect(Scsi_Device *);
 static void sd_detach(Scsi_Device *);
 static int sd_init_command(Scsi_Cmnd *);
+static int sd_find_kdev(Scsi_Device*, char*, kdev_t*);
 
 static struct Scsi_Device_Template sd_template = {
 	module:THIS_MODULE,
@@ -122,6 +123,7 @@
 	attach:sd_attach,
 	detach:sd_detach,
 	init_command:sd_init_command,
+	find_kdev:sd_find_kdev,
 };
 
 static void sd_rw_intr(Scsi_Cmnd * SCpnt);
@@ -285,6 +287,24 @@
 	}
 }
 
+static int sd_find_kdev(Scsi_Device *sdp, char* nm, kdev_t *dev)
+{
+	Scsi_Disk *sdkp;
+	int dsk_nr;
+
+	if (sdp && (sdp->type == TYPE_DISK || sdp->type == TYPE_MOD)) {
+		for (dsk_nr = 0; dsk_nr < sd_template.dev_max; ++dsk_nr) {
+			sdkp = sd_dsk_arr[dsk_nr];
+			if (sdkp->device == sdp) {
+				sd_dskname(dsk_nr, nm);
+				*dev = MKDEV_SD(dsk_nr);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 /**
  *	sd_find_queue - yields queue associated with device
  *	@dev: kernel device descriptor (kdev_t)
diff -uNr linux-2.5.24-dj1/drivers/scsi/sg.c linux-2.5.24-dj1-scsirephl/drivers/scsi/sg.c
--- linux-2.5.24-dj1/drivers/scsi/sg.c	Fri Jun 21 07:51:45 2002
+++ linux-2.5.24-dj1-scsirephl/drivers/scsi/sg.c	Fri Jun 21 08:22:27 2002
@@ -111,6 +111,7 @@
 static void sg_finish(void);
 static int sg_detect(Scsi_Device *);
 static void sg_detach(Scsi_Device *);
+static int sg_find_kdev(Scsi_Device *, char*, kdev_t*);
 
 static Scsi_Request * dummy_cmdp;	/* only used for sizeof */
 
@@ -120,6 +121,7 @@
 static struct Scsi_Device_Template sg_template =
 {
       module:THIS_MODULE,
+      name:"generic",
       tag:"sg",
       scsi_type:0xff,
       major:SCSI_GENERIC_MAJOR,
@@ -127,7 +129,8 @@
       init:sg_init,
       finish:sg_finish,
       attach:sg_attach,
-      detach:sg_detach
+      detach:sg_detach,
+      find_kdev:sg_find_kdev
 };
 
 
@@ -2674,6 +2677,37 @@
 }
 
 #ifdef CONFIG_PROC_FS
+static int sg_find_kdev(Scsi_Device* sdp, char *nm, kdev_t *dev)
+{
+    unsigned long iflags;
+    int err = 1; 
+
+    if (sdp && sg_dev_arr) {
+	int k;
+	read_lock_irqsave(&sg_dev_arr_lock, iflags);
+	for (k = 0; k < sg_template.dev_max; ++k) {
+	    if (sg_dev_arr[k] && sg_dev_arr[k]->device == sdp) {
+		sprintf (nm, "sg%i", k);
+	        *dev = sg_dev_arr[k]->i_rdev;
+		err = 0;
+		break;
+	    }
+	}
+	read_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+    }
+    return err;
+}
+#else
+/* Not needed without procfs support */
+static int sg_find_kdev(Scsi_Device* sdp, char *nm, kdev_t *dev)
+{
+    *nm = 0;
+    *kdev = NODEV;
+    return 1;
+}
+#endif
+
+#ifdef CONFIG_PROC_FS
 
 static struct proc_dir_entry * sg_proc_sgp = NULL;
 
diff -uNr linux-2.5.24-dj1/drivers/scsi/sr.c linux-2.5.24-dj1-scsirephl/drivers/scsi/sr.c
--- linux-2.5.24-dj1/drivers/scsi/sr.c	Wed Jun 19 04:11:50 2002
+++ linux-2.5.24-dj1-scsirephl/drivers/scsi/sr.c	Fri Jun 21 08:22:27 2002
@@ -71,6 +71,8 @@
 
 static int sr_init_command(Scsi_Cmnd *);
 
+static int sr_find_kdev(Scsi_Device*, char*, kdev_t*);
+
 static struct Scsi_Device_Template sr_template =
 {
 	module:THIS_MODULE,
@@ -84,7 +86,8 @@
 	finish:sr_finish,
 	attach:sr_attach,
 	detach:sr_detach,
-	init_command:sr_init_command
+	init_command:sr_init_command,
+	find_kdev:sr_find_kdev,
 };
 
 Scsi_CD *scsi_CDs;
@@ -471,6 +474,23 @@
 	return 0;
 }
 
+static int sr_find_kdev(Scsi_Device *sdp, char* nm, kdev_t *dev)
+{
+	Scsi_CD *srp;
+	int i;
+	
+	if (sdp && (sdp->type == TYPE_ROM || sdp->type == TYPE_WORM)) {
+		for (srp = scsi_CDs, i = 0; i < sr_template.dev_max;
+		     ++i, ++srp) {
+			if (srp->device == sdp) {
+				sprintf(nm, "sr%i", i);
+				*dev = mk_kdev(SCSI_CDROM_MAJOR,i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
 
 void get_sectorsize(int i)
 {
diff -uNr linux-2.5.24-dj1/drivers/scsi/st.c linux-2.5.24-dj1-scsirephl/drivers/scsi/st.c
--- linux-2.5.24-dj1/drivers/scsi/st.c	Wed Jun 19 04:11:56 2002
+++ linux-2.5.24-dj1-scsirephl/drivers/scsi/st.c	Fri Jun 21 08:22:27 2002
@@ -148,6 +148,7 @@
 static int st_attach(Scsi_Device *);
 static int st_detect(Scsi_Device *);
 static void st_detach(Scsi_Device *);
+static int st_find_kdev(Scsi_Device*, char*, kdev_t*);
 
 static struct Scsi_Device_Template st_template = {
 	module:		THIS_MODULE,
@@ -157,7 +158,8 @@
 	major:		SCSI_TAPE_MAJOR, 
 	detect:		st_detect, 
 	attach:		st_attach, 
-	detach:		st_detach
+	detach:		st_detach,
+	find_kdev:	st_find_kdev
 };
 
 static int st_compression(Scsi_Tape *, int);
@@ -3760,6 +3762,24 @@
 	return;
 }
 
+static int st_find_kdev(Scsi_Device * sdp, char* nm, kdev_t *dev)
+{
+	int i;
+	Scsi_Tape *stp;
+
+	if (sdp && sdp->type == TYPE_TAPE && !st_incompatible(sdp)) {
+		for (stp = scsi_tapes[0], i = 0; i < st_template.dev_max;
+		     stp = scsi_tapes[++i]) {
+			if (stp && stp->device == sdp) {
+				sprintf(nm, "st%i", i);
+				*dev = mk_kdev(SCSI_TAPE_MAJOR, i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 static int __init init_st(void)
 {
 	validate_options();



Regards,
-- 
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security
