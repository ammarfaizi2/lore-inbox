Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287306AbSA2X4Y>; Tue, 29 Jan 2002 18:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287293AbSA2Xzl>; Tue, 29 Jan 2002 18:55:41 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:27064 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S287145AbSA2XxW>; Tue, 29 Jan 2002 18:53:22 -0500
Date: Tue, 29 Jan 2002 15:53:17 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] 2.5.3-pre5 SCSI REPORT LUN scanning
Message-ID: <20020129155317.A812@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all -

Here's a patch for SCSI REPORT LUN scanning.

It's against linux-2.5.3-pre5.

In addition to the SCSI REPORT LUN support, it includes:

A new scan_scsis_target function based on code in scan_scsis, and
parts of scan_scsis_single. Adding this function cleans up the
scanning code, and removes a really ugly for loop. It would be
difficult to cleanly add REPORT LUN scanning without such a function.

Adds missing scsi_release_commandblocks() calls.

Does not set max_dev_lun out of bounds for BLIST_FORCELUN devices.

It also fixes scanning past LUN 7 for SCSI-3 devices (the patch
in 2.4.17 for that fix will not apply correctly against this code).

I tested this code on a x86 system with a fastt 200 (LSI Triton,
IBM 3542); this device is not very interesting, since the firmware
I have on it always gives back LUNs 0 - 31 in the REPORT LUNS
result, even when I don't have LUNs configured there.

I previously tested similar code in a 2.4.x kernel against a Hitachi
DF400, and an EMC Symmetrix box; the code failed when run with an
Emulex adapter and driver.

I have not tested going past LUN 255, or a with the fastt configured
to appear as a sparse LUN configuration. Good test points would be
to go past LUN 255, and then past LUN 2^16 (if any such devices exist,
and any adapter drivers support it), and to test on a big-endian machine
(past LUN 255; current linux lun is in host-order, but the SCSI 8 byte
LUN is comparable to 4 short big-endian integers).

Sequential scanning should be compatible with the current code.

Any suggestions, comments, flames?

Thanks.

-- Patrick Mansfield

diff -urN -X dontdiff linux-2.5.3-pre5/drivers/scsi/Config.help linux-2.5.3-pre5-repluns/drivers/scsi/Config.help
--- linux-2.5.3-pre5/drivers/scsi/Config.help	Fri Jan 25 09:59:00 2002
+++ linux-2.5.3-pre5-repluns/drivers/scsi/Config.help	Mon Jan 28 11:08:28 2002
@@ -145,6 +145,13 @@
   so most people can say N here and should in fact do so, because it
   is safer.
 
+CONFIG_SCSI_REPORT_LUNS
+  If you want to build with SCSI REPORT LUNS support in the kernel, say Y here.
+  The REPORT LUNS command is useful for devices (such as disk arrays) with
+  large numbers of LUNs where the LUN values are not contiguous (sparse LUN).
+  REPORT LUNS scanning is done only for SCSI-3 devices. Most users can safely
+  answer N here.
+
 CONFIG_SCSI_CONSTANTS
   The error messages regarding your SCSI hardware will be easier to
   understand if you say Y here; it will enlarge your kernel by about
diff -urN -X dontdiff linux-2.5.3-pre5/drivers/scsi/Config.in linux-2.5.3-pre5-repluns/drivers/scsi/Config.in
--- linux-2.5.3-pre5/drivers/scsi/Config.in	Tue Nov 27 09:23:27 2001
+++ linux-2.5.3-pre5-repluns/drivers/scsi/Config.in	Mon Jan 28 11:08:53 2002
@@ -21,6 +21,7 @@
 comment 'Some SCSI devices (e.g. CD jukebox) support multiple LUNs'
 
 bool '  Probe all LUNs on each SCSI device' CONFIG_SCSI_MULTI_LUN
+bool '  Build with SCSI REPORT LUNS support' CONFIG_SCSI_REPORT_LUNS
   
 bool '  Verbose SCSI error reporting (kernel size +=12K)' CONFIG_SCSI_CONSTANTS
 bool '  SCSI logging facility' CONFIG_SCSI_LOGGING
diff -urN -X dontdiff linux-2.5.3-pre5/drivers/scsi/scsi_scan.c linux-2.5.3-pre5-repluns/drivers/scsi/scsi_scan.c
--- linux-2.5.3-pre5/drivers/scsi/scsi_scan.c	Thu Jan 10 10:15:38 2002
+++ linux-2.5.3-pre5-repluns/drivers/scsi/scsi_scan.c	Tue Jan 29 14:49:01 2002
@@ -38,11 +38,19 @@
 #define BLIST_ISDISK    	0x100
 #define BLIST_ISROM     	0x200
 
+/*
+ * scan_scsis_single() return values.
+ */
+#define SCSI_SCAN_NO_RESPONSE		0
+#define SCSI_SCAN_DEVICE_PRESENT	1
+#define SCSI_SCAN_DEVICE_ADDED		2
+
 static void print_inquiry(unsigned char *data);
 static int scan_scsis_single(unsigned int channel, unsigned int dev,
-		unsigned int lun, int lun0_scsi_level, 
-		unsigned int *max_scsi_dev, unsigned int *sparse_lun, 
-		Scsi_Device ** SDpnt, struct Scsi_Host *shpnt, 
+		unsigned int lun, int scsi_level, Scsi_Device ** SDpnt2,
+		struct Scsi_Host *shpnt, char *scsi_result);
+static void scan_scsis_target(unsigned int channel, unsigned int dev,
+		Scsi_Device ** SDpnt2, struct Scsi_Host *shpnt,
 		char *scsi_result);
 static int find_lun0_scsi_level(unsigned int channel, unsigned int dev,
 				struct Scsi_Host *shpnt);
@@ -177,11 +185,27 @@
 static unsigned int max_scsi_luns = 1;
 #endif
 
+#ifdef CONFIG_SCSI_REPORT_LUNS
+/* 
+ * max_scsi_report_luns: the maximum number of LUNS that will be
+ * returned from the REPORT LUNS command. 8 times this value must
+ * be allocated. In theory this could be up to an 8 byte value, but
+ * in practice, the maximum number of LUNs suppored by any device
+ * is about 16k.
+ */
+static unsigned int max_scsi_report_luns = 128;
+#endif
+
 #ifdef MODULE
 
 MODULE_PARM(max_scsi_luns, "i");
 MODULE_PARM_DESC(max_scsi_luns, "last scsi LUN (should be between 1 and 2^32-1)");
 
+#ifdef CONFIG_SCSI_REPORT_LUNS
+MODULE_PARM(max_scsi_report_luns, "i");
+MODULE_PARM_DESC(max_scsi_report_luns, "REPORT LUNS maximum number of LUNS received (should be between 1 and 16384)");
+#endif
+
 #else
 
 static int __init scsi_luns_setup(char *str)
@@ -200,6 +224,24 @@
 
 __setup("max_scsi_luns=", scsi_luns_setup);
 
+#ifdef CONFIG_SCSI_REPORT_LUNS
+static int __init max_scsi_report_luns_setup(char *str)
+{
+	unsigned int tmp;
+
+	if (get_option(&str, &tmp) == 1) {
+		max_scsi_report_luns = tmp;
+		return 1;
+	} else {
+		printk("scsi_report_luns_setup : usage max_scsi_report_luns=n "
+		       "(n should be between 1 and 16384)\n");
+		return 0;
+	}
+}
+
+__setup("max_scsi_report_luns=", max_scsi_report_luns_setup);
+#endif /* CONFIG_SCSI_REPORT_LUNS */
+
 #endif
 
 static void print_inquiry(unsigned char *data)
@@ -243,20 +285,20 @@
 		printk("\n");
 }
 
-static int get_device_flags(unsigned char *response_data)
+static int get_device_flags(Scsi_Device *SDpnt)
 {
 	int i = 0;
 	unsigned char *pnt;
 	for (i = 0; 1; i++) {
 		if (device_list[i].vendor == NULL)
 			return 0;
-		pnt = &response_data[8];
+		pnt = SDpnt->vendor;
 		while (*pnt && *pnt == ' ')
 			pnt++;
 		if (memcmp(device_list[i].vendor, pnt,
 			   strlen(device_list[i].vendor)))
 			continue;
-		pnt = &response_data[16];
+		pnt = SDpnt->model;
 		while (*pnt && *pnt == ' ')
 			pnt++;
 		if (memcmp(device_list[i].model, pnt,
@@ -283,13 +325,10 @@
 	uint channel;
 	unsigned int dev;
 	unsigned int lun;
-	unsigned int max_dev_lun;
 	unsigned char *scsi_result;
 	unsigned char scsi_result0[256];
 	Scsi_Device *SDpnt;
 	Scsi_Device *SDtail;
-	unsigned int sparse_lun;
-	int lun0_sl;
 
 	scsi_result = NULL;
 
@@ -352,6 +391,8 @@
 	if (hardcoded == 1) {
 		Scsi_Device *oldSDpnt = SDpnt;
 		struct Scsi_Device_Template *sdtpnt;
+		unsigned int lun0_sl;
+
 		channel = hchannel;
 		if (channel > shpnt->max_channel)
 			goto leave;
@@ -365,8 +406,8 @@
 			lun0_sl = SCSI_3; /* actually don't care for 0 == lun */
 		else
 			lun0_sl = find_lun0_scsi_level(channel, dev, shpnt);
-		scan_scsis_single(channel, dev, lun, lun0_sl, &max_dev_lun, 
-				  &sparse_lun, &SDpnt, shpnt, scsi_result);
+		scan_scsis_single(channel, dev, lun, lun0_sl, &SDpnt, shpnt,
+			       	  scsi_result);
 		if (SDpnt != oldSDpnt) {
 
 			/* it could happen the blockdevice hasn't yet been inited */
@@ -411,32 +452,13 @@
 					order_dev = dev;
 
 				if (shpnt->this_id != order_dev) {
-
-					/*
-					 * We need the for so our continue, etc. work fine. We put this in
-					 * a variable so that we can override it during the scan if we
-					 * detect a device *KNOWN* to have multiple logical units.
-					 */
-					max_dev_lun = (max_scsi_luns < shpnt->max_lun ?
-					 max_scsi_luns : shpnt->max_lun);
-					sparse_lun = 0;
-					for (lun = 0, lun0_sl = SCSI_2; lun < max_dev_lun; ++lun) {
-						/* don't probe further for luns > 7 for targets <= SCSI_2 */
-						if ((lun0_sl < SCSI_3) && (lun > 7))
-							break;
-
-						if (!scan_scsis_single(channel, order_dev, lun, lun0_sl,
-							 	       &max_dev_lun, &sparse_lun, &SDpnt, shpnt,
-								       scsi_result)
-						    && !sparse_lun)
-							break;	/* break means don't probe further for luns!=0 */
-						if (SDpnt && (0 == lun))
-							lun0_sl = SDpnt->scsi_level;
-					}	/* for lun ends */
-				}	/* if this_id != id ends */
-			}	/* for dev ends */
-		}		/* for channel ends */
-	}			/* if/else hardcoded */
+					scan_scsis_target(channel, order_dev,
+						          &SDpnt, shpnt, 
+							  scsi_result);
+				}
+			}
+		}
+	}	/* if/else hardcoded */
 
       leave:
 
@@ -483,15 +505,38 @@
 }
 
 /*
- * The worker for scan_scsis.
- * Returning 0 means Please don't ask further for lun!=0, 1 means OK go on.
- * Global variables used : scsi_devices(linked list)
+ * Function:    scan_scsis_single
+ *
+ * Purpose:     Determine if a SCSI device (a single LUN) exists, and
+ * 		configure it into the system.
+ *
+ * Arguments:   channel    - the host's channel
+ * 		dev        - target dev (target id)
+ * 		lun        - LUN
+ * 		scsi_level - SCSI 1, 2 or 3
+ * 		SDpnt2     - pointer to pointer of a preallocated Scsi_Device
+ * 		shpnt      - host device to use
+ * 		scsi_result - preallocated buffer for the SCSI command result
+ *
+ * Lock status: None
+ *
+ * Returns:     SCSI_SCAN_NO_RESPONSE - no valid response received from the
+ * 		device, this includes allocation failures preventing IO from
+ * 		being sent, or any general failures.
+ *
+ *		SCSI_SCAN_DEVICE_PRESENT - device responded, SDpnt2 has all
+ *		values needed to send IO set, plus scsi_level is set, but no
+ *		new Scsi_Device was added/allocated.
+ *
+ *   		SCSI_SCAN_DEVICE_ADDED - device responded, and added to list;
+ *   		SDpnt2 filled, and pointed to new allocated Scsi_Device.
+ *
+ * Notes:       This could be cleaned up some by moving SDpnt2 and Scsi_Device
+ * 		allocation into scan_scsis_target.
  */
 static int scan_scsis_single(unsigned int channel, unsigned int dev,
-		unsigned int lun, int lun0_scsi_level,
-		unsigned int *max_dev_lun, unsigned int *sparse_lun, 
-		Scsi_Device ** SDpnt2, struct Scsi_Host *shpnt, 
-		char *scsi_result)
+		unsigned int lun, int scsi_level, Scsi_Device ** SDpnt2,
+		struct Scsi_Host *shpnt, char *scsi_result)
 {
 	char devname[64];
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
@@ -523,7 +568,8 @@
 
 	if (NULL == (SRpnt = scsi_allocate_request(SDpnt))) {
 		printk("scan_scsis_single: no memory\n");
-		return 0;
+		scsi_release_commandblocks(SDpnt);
+		return SCSI_SCAN_NO_RESPONSE;
 	}
 
 	/*
@@ -532,12 +578,16 @@
 	 * devices (and TEST_UNIT_READY to poll for media change). - Paul G.
 	 */
 
-	SCSI_LOG_SCAN_BUS(3, printk("scsi: performing INQUIRY\n"));
+	SCSI_LOG_SCAN_BUS(3,
+		printk("scsi scan: INQUIRY to host %d channel %d "
+		"id %d lun %d\n", shpnt->host_no, channel, dev, lun)
+	);
+
 	/*
 	 * Build an INQUIRY command block.
 	 */
 	scsi_cmd[0] = INQUIRY;
-	if ((lun > 0) && (lun0_scsi_level <= SCSI_2))
+	if ((lun > 0) && (scsi_level <= SCSI_2))
 		scsi_cmd[1] = (lun << 5) & 0xe0;
 	else	
 		scsi_cmd[1] = 0;	/* SCSI_3 and higher, don't touch */
@@ -567,32 +617,38 @@
 			/* not-ready to ready transition - good */
 		} else {
 			/* assume no peripheral if any other sort of error */
+			scsi_release_commandblocks(SDpnt);
 			scsi_release_request(SRpnt);
-			return 0;
+			return SCSI_SCAN_NO_RESPONSE;
 		}
 	}
 
-	/*
-	 * Check for SPARSELUN before checking the peripheral qualifier,
-	 * so sparse lun devices are completely scanned.
-	 */
+	SDpnt->scsi_level = scsi_result[2] & 0x07;
+	if (SDpnt->scsi_level >= 2 ||
+	    (SDpnt->scsi_level == 1 &&
+	     (scsi_result[3] & 0x0f) == 1))
+		SDpnt->scsi_level++;
+
+	memcpy(SDpnt->vendor, scsi_result + 8, 8);
+	memcpy(SDpnt->model, scsi_result + 16, 16);
+	memcpy(SDpnt->rev, scsi_result + 32, 4);
 
 	/*
 	 * Get any flags for this device.  
 	 */
-	bflags = get_device_flags (scsi_result);
+	bflags = get_device_flags (SDpnt);
 
-	if (bflags & BLIST_SPARSELUN) {
-	  *sparse_lun = 1;
-	}
-	/*
-	 * Check the peripheral qualifier field - this tells us whether LUNS
-	 * are supported here or not.
-	 */
 	if ((scsi_result[0] >> 5) == 3) {
-		scsi_release_request(SRpnt);
-		return 0;	/* assume no peripheral if any sort of error */
+		/*
+		 * Peripheral qualifier 011b: The device server is not
+		 * capable of supporting a physical device on this logical
+		 * unit.
+		 */
+		scsi_release_commandblocks(SDpnt);
+  		scsi_release_request(SRpnt);
+		return SCSI_SCAN_DEVICE_PRESENT;
 	}
+
 	 /*   The Toshiba ROM was "gender-changed" here as an inline hack.
 	      This is now much more generic.
 	      This is a mess: What we really want is to leave the scsi_result
@@ -609,10 +665,6 @@
 		scsi_result[1] |= 0x80;     /* removable */
 	}
     
-	memcpy(SDpnt->vendor, scsi_result + 8, 8);
-	memcpy(SDpnt->model, scsi_result + 16, 16);
-	memcpy(SDpnt->rev, scsi_result + 32, 4);
-
 	SDpnt->removable = (0x80 & scsi_result[1]) >> 7;
 	/* Use the peripheral qualifier field to determine online/offline */
 	if (((scsi_result[0] >> 5) & 7) == 1) 	SDpnt->online = FALSE;
@@ -667,12 +719,6 @@
 			SDpnt->attached +=
 			    (*sdtpnt->detect) (SDpnt);
 
-	SDpnt->scsi_level = scsi_result[2] & 0x07;
-	if (SDpnt->scsi_level >= 2 ||
-	    (SDpnt->scsi_level == 1 &&
-	     (scsi_result[3] & 0x0f) == 1))
-		SDpnt->scsi_level++;
-
 	/*
 	 * Accommodate drivers that want to sleep when they should be in a polling
 	 * loop.
@@ -726,6 +772,9 @@
 		scsi_wait_req (SRpnt, (void *) scsi_cmd,
 	        	(void *) scsi_result, 0x2a,
 	        	SCSI_TIMEOUT, 3);
+		/*
+		 * scsi_result no longer holds inquiry data.
+		 */
 	}
 
 	scsi_release_request(SRpnt);
@@ -741,7 +790,7 @@
 	SDpnt = (Scsi_Device *) kmalloc(sizeof(Scsi_Device), GFP_ATOMIC);
 	if (!SDpnt) {
 		printk("scsi: scan_scsis_single: Cannot malloc\n");
-		return 0;
+		return SCSI_SCAN_NO_RESPONSE;
 	}
         memset(SDpnt, 0, sizeof(Scsi_Device));
 
@@ -788,62 +837,408 @@
 	SDpnt->prev = SDtail;
 	SDpnt->next = NULL;
 
+	return SCSI_SCAN_DEVICE_ADDED;
+}
+
+/*
+ * Function:    scsi_report_lun_scan
+ *
+ * Purpose:     Use a SCSI REPORT LUN to determine what LUNs to scan.
+ *
+ * Arguments:   SDlun0_pnt - pointer to a Scsi_Device for LUN 0
+ * 		channel    - the host's channel
+ * 		dev        - target dev (target id)
+ * 		SDpnt2     - pointer to pointer of a preallocated Scsi_Device
+ * 		shpnt      - host device to use
+ * 		scsi_result - preallocated buffer for the SCSI command result
+ *
+ * Lock status: None
+ *
+ * Returns:     If the LUNs for device at shpnt/channel/dev are scanned,
+ * 		return 0, else return 1.
+ *
+ * Notes:       
+ */
+static inline int scsi_report_lun_scan(Scsi_Device *SDlun0_pnt, unsigned
+		int channel, unsigned int dev, Scsi_Device **SDpnt2,
+		struct Scsi_Host *shpnt, char *scsi_result)
+{
+
+#ifdef CONFIG_SCSI_REPORT_LUNS
+
+	char devname[64];
+	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
+	unsigned int length;
+	unsigned int lun;
+	unsigned int num_luns;
+	unsigned int retries;
+	ScsiLun *fcp_cur_lun_pnt, *lun_data_pnt;
+	Scsi_Request *SRpnt;
+	int scsi_level, i;
+	char *byte_pnt;
+	int got_command_blocks = 0;
+
+	/*
+	 * Only support SCSI-3 and up devices.
+	 */
+	if (SDlun0_pnt->scsi_level < SCSI_3) {
+		return 1;
+	}
+
+	/*
+	 * Note SDlun0_pnt might be invalid after scan_scsis_single is called.
+	 */
+
+	/*
+	 * Command blocks might be built depending on whether LUN 0 was
+	 * configured or not. Checking has_cmdblocks here is ugly.
+	 */
+	if (SDlun0_pnt->has_cmdblocks == 0) {
+		got_command_blocks = 1;
+		scsi_build_commandblocks(SDlun0_pnt);
+	}
+	SRpnt = scsi_allocate_request(SDlun0_pnt);
+
+	sprintf (devname, "host %d channel %d id %d",
+		 SDlun0_pnt->host->host_no, SDlun0_pnt->channel,
+		 SDlun0_pnt->id);
+	/*
+	 * Allocate enough to hold the header (the same size as one ScsiLun)
+	 * plus the max number of luns we are requesting.
+	 *
+	 * XXX: Maybe allocate this once, like scsi_result, and pass it down.
+	 * scsi_result can't be used, as it is needed for the scan INQUIRY
+	 * data. In addition, reallocating and trying again (with the exact
+	 * amount we need) would be nice, but then we need to somehow limit the
+	 * size allocated base on the available memory (and limits of kmalloc).
+	 */
+	length = (max_scsi_report_luns + 1) * sizeof(ScsiLun);
+	lun_data_pnt = (ScsiLun *) kmalloc(length,
+			(shpnt->unchecked_isa_dma ?  GFP_DMA : GFP_ATOMIC));
+	if (lun_data_pnt == NULL) {
+		printk("scsi: scsi_report_lun_scan: Cannot malloc\n");
+		if (got_command_blocks) {
+			scsi_release_commandblocks(SDlun0_pnt);
+		}
+		return 1;
+	}
+
+	/*
+	 * We can get a UNIT ATTENTION, for example a power on/reset, so retry
+	 * a few times (like sd.c does for TEST UNIT READY). Experience shows
+	 * some combinations of adapter/devices get at least two power
+	 * on/resets.
+	 *
+	 * Illegal requests (for devices that do not support REPORT LUNS)
+	 * should come through as a check condition, and will not generate a
+	 * retry.
+	 */
+	retries = 0;
+	while (retries++ < 3) {
+		scsi_cmd[0] = REPORT_LUNS;
+		scsi_cmd[1] = 0; /* reserved */
+		scsi_cmd[2] = 0; /* reserved */
+		scsi_cmd[3] = 0; /* reserved */
+		scsi_cmd[4] = 0; /* reserved */
+		scsi_cmd[5] = 0; /* reserved */
+		/*
+		 * bytes 6 - 9: length of the command.
+		 */
+		scsi_cmd[6] = (unsigned char) (length >> 24) & 0xff;
+		scsi_cmd[7] = (unsigned char) (length >> 16) & 0xff;
+		scsi_cmd[8] = (unsigned char) (length >> 8) & 0xff;
+		scsi_cmd[9] = (unsigned char) length & 0xff;
+
+		scsi_cmd[10] = 0; /* reserved */
+		scsi_cmd[11] = 0; /* control */
+
+		SRpnt->sr_cmd_len = 0;
+		SRpnt->sr_data_direction = SCSI_DATA_READ;
+
+		SCSI_LOG_SCAN_BUS(3,
+			printk("scsi: Sending REPORT LUNS to %s (try %d)\n",
+				devname, retries));
+
+		scsi_wait_req (SRpnt, (void *) scsi_cmd,
+			  (void *) lun_data_pnt,
+			  length, SCSI_TIMEOUT+4*HZ, 3);
+
+		SCSI_LOG_SCAN_BUS(3,
+			printk("scsi: REPORT LUNS %s (try %d) result 0x%x\n",
+			SRpnt->sr_result ? "failed" : "successful", retries,
+			SRpnt->sr_result));
+
+		if (SRpnt->sr_result == 0
+		    || SRpnt->sr_sense_buffer[2] != UNIT_ATTENTION) {
+			break;
+		}
+	}
+
+	scsi_release_request(SRpnt);
+	if (got_command_blocks) {
+		scsi_release_commandblocks(SDlun0_pnt);
+	}
+
+	if (SRpnt->sr_result) {
+		kfree((char *) lun_data_pnt);
+		return 1;
+	}
+
+	/*
+	 * Get the length from the first four bytes of lun_data_pnt.
+	 */
+	byte_pnt = (char*) lun_data_pnt->scsi_lun;
+	length = ((byte_pnt[0] << 24) | (byte_pnt[1] << 16) |
+			 (byte_pnt[2] << 8) | (byte_pnt[3] << 0));
+	if ((length / sizeof(ScsiLun)) > max_scsi_report_luns) {
+		printk("scsi: On %s only %d (max_scsi_report_luns) of %d luns"
+			" reported, try increasing max_scsi_report_luns.\n",
+			devname, max_scsi_report_luns,
+			length / sizeof(ScsiLun));
+		num_luns = max_scsi_report_luns;
+	} else {
+		num_luns = (length / sizeof(ScsiLun));
+	}
+
+	scsi_level = SDlun0_pnt->scsi_level;
+
+	/*
+	 * Scan the luns in lun_data_pnt. The entry at offset 0 is really
+	 * the header, so start at 1 and go up to and including num_luns.
+	 */
+	for (fcp_cur_lun_pnt = &lun_data_pnt[1];
+	     fcp_cur_lun_pnt <= &lun_data_pnt[num_luns];
+	     fcp_cur_lun_pnt++) {
+		/*
+		 * Store into the lun in CPU byte order in order to be
+		 * compatible with the current lun byte order.
+		 *
+		 * Put 8 bytes of the LUN into N bytes, in chunks of 2 bytes
+		 * (one LUN level uses 2 bytes). Each LUN level is effectively
+		 * in SCSI host order (big endian).
+		 *
+		 * Given LUN (in hex, byte ordered): 0a 04 0b 03 0c 02 0d 01
+		 * Convert to the integer (not byte ordered):
+		 * 0x0d010c020b030a04
+		 *
+		 * Or, for LUN 1: 00 01 00 00 00 00 00 00 Convert to the four
+		 * byte int (not byte ordered): 0x00000001
+		 */
+		lun = 0;
+		for (i = 0; i < sizeof(lun)/sizeof(u16); i++) {
+			lun = lun | (be16_to_cpu(fcp_cur_lun_pnt->scsi_lun[i])
+				<< (i * 16));
+		}
+		/*
+		 * Check if the uncopied data is non-zero, and if so does
+		 * not fit in lun.
+		 */
+		for (; i < sizeof(ScsiLun)/sizeof(u16); i++) {
+			if (fcp_cur_lun_pnt->scsi_lun[i] != 0) {
+				break;
+			}
+		}
+		if (i != sizeof(ScsiLun)/sizeof(u16)) {
+			/*
+			 * Output an error displaying the LUN in byte order,
+			 * this differs from what linux would print for the
+			 * integer LUN value.
+			 */
+			printk("scsi: %s lun 0x", devname);
+			byte_pnt = (char*) fcp_cur_lun_pnt->scsi_lun;
+			for (i = 0; i < 8; i++) {
+				printk("%02x", byte_pnt[i]);
+			}
+			printk("has a LUN larger than that supported by"
+				" the kernel\n");
+		} else if (lun == 0) {
+			/*
+			 * LUN 0 has already been scanned.
+			 */
+		} else if (lun > shpnt->max_lun) {
+			printk("scsi: %s lun %d has a LUN larger than allowed"
+				" by the host adapter\n", devname, lun);
+		} else {
+			/*
+			 * Don't use SDlun0_pnt after this call - it can be
+			 * overwritten via SDpnt2 if there was no real device
+			 * at LUN 0.
+			 */
+			if (scan_scsis_single(channel, dev, lun,
+			    scsi_level, SDpnt2, shpnt, scsi_result)
+				== SCSI_SCAN_NO_RESPONSE) {
+				/*
+				 * Got some results, but now none, abort.
+				 */
+				printk("scsi: no response from %s lun %d while"
+				       " scanning, scan aborted\n", devname, 
+				       lun);
+				break;
+			}
+		}
+	}
+
+	kfree((char *) lun_data_pnt);
+	return 0;
+
+#else
+	return 1;
+#endif	/* CONFIG_SCSI_REPORT_LUNS */
+
+}
+
+/*
+ * Function:    scan_scsis_target
+ *
+ * Purpose:     Scan the given scsi target dev, and as needed all LUNs
+ * 		on the target dev.
+ *
+ * Arguments:   channel    - the host's channel
+ * 		dev        - target dev (target id)
+ * 		SDpnt2     - pointer to pointer of a preallocated Scsi_Device
+ * 		shpnt      - host device to use
+ * 		scsi_result - preallocated buffer for the SCSI command result
+ *
+ * Lock status: None
+ *
+ * Returns:     void
+ *
+ * Notes:       This tries to be compatible with linux 2.4.x. This function
+ * 		relies on scan_scsis_single to setup SDlun0_pnt. 
+ *
+ * 		It would be better if the Scsi_Device allocation and freeing
+ * 		was done here, rather than oddly embedded in scan_scsis_single
+ * 		and scan_scsis.
+ */
+static void scan_scsis_target(unsigned int channel, unsigned int dev,
+		Scsi_Device **SDpnt2, struct Scsi_Host *shpnt,
+		char *scsi_result)
+{
+	int bflags, scsi_level;
+	Scsi_Device *SDlun0_pnt;
+	unsigned int sparse_lun = 0;
+	unsigned int max_dev_lun, lun;
+	unsigned int sdlun0_res;
+
+	/*
+	 * Scan lun 0, use the results to determine whether to scan further.
+	 * Ideally, we would not configure LUN 0 until we scan.
+	 */
+	SDlun0_pnt = *SDpnt2;
+	sdlun0_res = scan_scsis_single(channel, dev, 0 /* LUN 0 */, SCSI_2,
+		SDpnt2, shpnt, scsi_result);
+	if (sdlun0_res == SCSI_SCAN_NO_RESPONSE) {
+		return;
+	}
+
+	/*
+	 * If no new SDpnt was allocated (SCSI_SCAN_DEVICE_PRESENT), SDlun0_pnt
+	 * can later be modified. It is unlikely the lun level would change,
+	 * but save it just in case.
+	 */
+	scsi_level = SDlun0_pnt->scsi_level;
+
+	/*
+	 * We could probably use and save the bflags from lun 0 for all luns
+	 * on a target, but be safe and match current behaviour. (LUN 0
+	 * bflags controls the settings checked in this function.)
+	 */
+	bflags = get_device_flags (SDlun0_pnt);
+
 	/*
 	 * Some scsi devices cannot be polled for lun != 0 due to firmware bugs
 	 */
 	if (bflags & BLIST_NOLUN)
-		return 0;	/* break; */
+		return;
 
 	/*
-	 * If this device is known to support sparse multiple units, override the
-	 * other settings, and scan all of them.
+	 * Ending the scan here if max_scsi_luns == 1 breaks scanning of
+	 * SPARSE, FORCE, MAX5 LUN devices, and the report lun scans.
+	 */
+
+	if (scsi_report_lun_scan(SDlun0_pnt, channel, dev, SDpnt2, shpnt,
+	    scsi_result) == 0) {
+		return;
+	}
+
+	SCSI_LOG_SCAN_BUS(3,
+		printk("scsi: Sequential scan of host %d channel %d id %d\n",
+		 SDlun0_pnt->host->host_no, SDlun0_pnt->channel,
+		 SDlun0_pnt->id));
+
+	max_dev_lun = (max_scsi_luns < shpnt->max_lun ?
+			max_scsi_luns : shpnt->max_lun);
+	/*
+	 * If this device is known to support sparse multiple units,
+	 * override the other settings, and scan all of them.
 	 */
 	if (bflags & BLIST_SPARSELUN) {
-		*max_dev_lun = shpnt->max_lun;
-		*sparse_lun = 1;
-		return 1;
+		max_dev_lun = shpnt->max_lun;
+		sparse_lun = 1;
+	} else if (sdlun0_res == SCSI_SCAN_DEVICE_PRESENT) {
+		/*
+		 * LUN 0 responded, but no LUN 0 was added, don't scan any
+		 * further. This matches linux 2.4.x behaviour.
+		 */
+		return;
+	}
+	if ((scsi_level < SCSI_1_CCS) && ((bflags &
+	     (BLIST_FORCELUN | BLIST_SPARSELUN | BLIST_MAX5LUN)) == 0)) {
+		/*
+		 * If less than SCSI_1_CSS, and not a forced lun scan, stop
+		 * scanning, this matches 2.4 behaviour, but it could be a bug
+		 * to scan SCSI_1_CSS devices past LUN 0.
+		 */
+		return;
 	}
 	/*
-	 * If this device is known to support multiple units, override the other
-	 * settings, and scan all of them.
+	 * If this device is known to support multiple units, override
+	 * the other settings, and scan all of them.
 	 */
 	if (bflags & BLIST_FORCELUN) {
-		/* 
-		 * Scanning MAX_SCSI_LUNS units would be a bad idea.
-		 * Any better idea?
-		 * I think we need REPORT LUNS in future to avoid scanning
-		 * of unused LUNs. But, that is another item.
-		 */
-		if (*max_dev_lun < shpnt->max_lun)
-			*max_dev_lun = shpnt->max_lun;
-		else 	if ((max_scsi_luns >> 1) >= *max_dev_lun)
-				*max_dev_lun += shpnt->max_lun;
-			else	*max_dev_lun = max_scsi_luns;
-		return 1;
+		max_dev_lun = shpnt->max_lun;
 	}
 	/*
 	 * REGAL CDC-4X: avoid hang after LUN 4
 	 */
 	if (bflags & BLIST_MAX5LUN) {
-		*max_dev_lun = 5;
-		return 1;
+		max_dev_lun = min(5U, max_dev_lun);
+	}
+	if (scsi_level < SCSI_3) {
+		/*
+		 * Do not scan past LUN 7.
+		 */
+		max_dev_lun = min(8U, max_dev_lun);
 	}
 
 	/*
-	 * We assume the device can't handle lun!=0 if: - it reports scsi-0
-	 * (ANSI SCSI Revision 0) (old drives like MAXTOR XT-3280) or - it
-	 * reports scsi-1 (ANSI SCSI Revision 1) and Response Data Format 0
-	 */
-	if (((scsi_result[2] & 0x07) == 0)
-	    ||
-	    ((scsi_result[2] & 0x07) == 1 &&
-	     (scsi_result[3] & 0x0f) == 0))
-		return 0;
-	return 1;
+	 * We have already scanned lun 0.
+	 */
+	for (lun = 1; lun < max_dev_lun; ++lun) {
+		int res;
+		/*
+		 * Scan until scan_scsis_single says stop,
+		 * unless sparse_lun is set.
+		 */
+		res = scan_scsis_single(channel, dev, lun,
+		     scsi_level, SDpnt2, shpnt, scsi_result);
+		if (res == SCSI_SCAN_NO_RESPONSE) {
+			/*
+			 * Got a response on LUN 0, but now no response.
+			 */
+			printk("scsi: no response from device"
+				" host%d/bus%d/target%d/lun%d"
+				" while scanning, scan aborted\n",
+				shpnt->host_no, channel, dev, lun);
+			return;
+		} else if ((res == SCSI_SCAN_DEVICE_PRESENT)
+			    && !sparse_lun) {
+			return;
+		}
+	}
 }
 
 /*
- * The worker for scan_scsis.
  * Returns the scsi_level of lun0 on this host, channel and dev (if already
  * known), otherwise returns SCSI_2.
  */
diff -urN -X dontdiff linux-2.5.3-pre5/include/scsi/scsi.h linux-2.5.3-pre5-repluns/include/scsi/scsi.h
--- linux-2.5.3-pre5/include/scsi/scsi.h	Fri Apr 27 13:59:19 2001
+++ linux-2.5.3-pre5-repluns/include/scsi/scsi.h	Fri Jan 25 10:46:17 2002
@@ -78,6 +78,7 @@
 #define MODE_SENSE_10         0x5a
 #define PERSISTENT_RESERVE_IN 0x5e
 #define PERSISTENT_RESERVE_OUT 0x5f
+#define REPORT_LUNS           0xa0
 #define MOVE_MEDIUM           0xa5
 #define READ_12               0xa8
 #define WRITE_12              0xaa
@@ -162,6 +163,16 @@
     u_char  block_length_med;
     u_char  block_length_lo;
 };
+
+/*
+ * ScsiLun: 8 byte lun. This is represented as four shorts, in order
+ * to make the conversion to an integer (4 or 8 byte) simpler. Per
+ * the SCSI spec, it is really 4 LUN levels, and each level is 2
+ * bytes long.
+ */
+typedef struct scsi_lun {
+	u16 scsi_lun[4];
+} ScsiLun;
 
 /*
  *  MESSAGE CODES
