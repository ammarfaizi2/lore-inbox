Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264447AbRGISZN>; Mon, 9 Jul 2001 14:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264463AbRGISZD>; Mon, 9 Jul 2001 14:25:03 -0400
Received: from hypnos.cps.intel.com ([192.198.165.17]:3011 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S264447AbRGISYz>; Mon, 9 Jul 2001 14:24:55 -0400
Message-ID: <9678C2B4D848D41187450090276D1FAE0635F133@FMSMSX32>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH-2.4.3] scsi logging
Date: Mon, 9 Jul 2001 11:24:35 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd like to propose the following patch to 3 SCSI mid-layer files from
kernel 2.4.3.  I have tested this with 2.4.3, but it should be relevant to
other 2.4.x
kernels also.

It has the following changes/enhancements:
1) Log the disk serial number during scsi_scan() - scsi_scan.c.
   Why: This is a requirement in some environments to ensure unambiguous 
   identification of a particular problem disk.
2) Interpret additional values in print_sense_internal() - constants.c.
   Why: The detail wrt Illegal Requests is very useful, since it can
indicate
   either an application bug or an incompatible feature of the device.
3) Don't skip logging sense errors for sg functions - sg.c.
   Why: All sense errors should be logged so that a potential scsi device 
   hardware problem doesn't go unrecognized.

Andy Cress

--- linux-243.org/drivers/scsi/scsi_scan.c	Sun Feb  4 13:05:30 2001
+++ linux-243/drivers/scsi/scsi_scan.c	Tue Jun 19 15:33:38 2001
@@ -212,6 +212,16 @@
 			printk(" ");
 	}
 
+        if ((data[0] & 0x1f) == 0) {  /* if type == disk */
+           printk("  Ser#: ");
+           for (i = 36; i < 44; i++) {
+                if (data[i] >= 0x20 && i < data[4] + 5)
+                        printk("%c", data[i]);
+                else
+                        printk(" ");
+           }
+         }  /*endif*/             
+
 	printk("\n");
 
 	i = data[0] & 0x1f;
--- linux-243.org/drivers/scsi/constants.c	Mon Jan 15 16:08:15 2001
+++ linux-243/drivers/scsi/constants.c	Wed Jun 27 16:35:49 2001
@@ -690,17 +690,27 @@
 {
     int i, s;
     int sense_class, valid, code;
+    int key;
     const char * error = NULL;
     
     sense_class = (sense_buffer[0] >> 4) & 0x07;
     code = sense_buffer[0] & 0xf;
     valid = sense_buffer[0] & 0x80;
+    key = sense_buffer[2] & 0x0f;
     
     if (sense_class == 7) {	/* extended sense data */
 	s = sense_buffer[7] + 8;
 	if(s > SCSI_SENSE_BUFFERSIZE)
 	   s = SCSI_SENSE_BUFFERSIZE;
 	
+#if (CONSTANTS & CONST_SENSE)
+	printk( "%s%s: sense key %s\n", devclass,
+	       kdevname(dev), snstext[key]);
+#else
+	printk("%s%s: sns = %2x %2x\n", devclass,
+	       kdevname(dev), sense_buffer[0], sense_buffer[2]);
+#endif
+
 	if (!valid)
 	    printk("[valid=0] ");
 	printk("Info fld=0x%x, ", (int)((sense_buffer[3] << 24) |
@@ -728,14 +738,6 @@
 	
 	printk("%s ", error);
 	
-#if (CONSTANTS & CONST_SENSE)
-	printk( "%s%s: sense key %s\n", devclass,
-	       kdevname(dev), snstext[sense_buffer[2] & 0x0f]);
-#else
-	printk("%s%s: sns = %2x %2x\n", devclass,
-	       kdevname(dev), sense_buffer[0], sense_buffer[2]);
-#endif
-	
 	/* Check to see if additional sense information is available */
 	if(sense_buffer[7] + 7 < 13 ||
 	   (sense_buffer[12] == 0  && sense_buffer[13] ==  0)) goto done;
@@ -754,6 +756,28 @@
 		printk(additional2[i].text, sense_buffer[13]);
 		printk("\n");
 	    };
+
+	/* Illegal Request & SKSV is set (Sense-Key Specific Field Valid
bit)*/
+        if (key == 0x05 && (sense_buffer[15] & 0x80) == 0x80) {
+	     int bytenum;
+          /* Now find the invalid byte in parameter list or CDB */
+          (sense_buffer[15] & 0x40) == 0x40 ? printk("Error in CDB: ")
+                       : printk("Error in Parameter List: ");
+          bytenum = sense_buffer[16] * 0x100 + sense_buffer[17];
+	     printk("Byte #%d", bytenum);
+	     if ((sense_buffer[15] & 0x08) == 0x08) /*BPV(Bit Pointer
Valid)?*/
+	        printk(", Bit #%d is in error.\n", sense_buffer[15] & 0x07);
+	     else printk(" is in error.\n");
+          } 
+
+        /* If media error (bad spot), indicate where (LBA) */
+        if (key == MEDIUM_ERROR    || key == RECOVERED_ERROR || 
+            key == HARDWARE_ERROR  || key == VOLUME_OVERFLOW || 
+            key == MISCOMPARE ) {
+             printk("LBA=%02x%02x%02x%02x \n",
+                    sense_buffer[3], sense_buffer[4],
+                    sense_buffer[5], sense_buffer[6]);
+	   }
 #else
 	printk("ASC=%2x ASCQ=%2x\n", sense_buffer[12], sense_buffer[13]);
 #endif
--- linux-243.org/drivers/scsi/sg.c	Mon Jan 15 16:08:15 2001
+++ linux-243/drivers/scsi/sg.c	Wed Jun 27 16:27:56 2001
@@ -1049,9 +1049,9 @@
 	srp->header.msg_status  = msg_byte(SRpnt->sr_result);
 	srp->header.host_status = host_byte(SRpnt->sr_result);
 	srp->header.driver_status = driver_byte(SRpnt->sr_result);
-	if ((sdp->sgdebug > 0) &&
-	    ((CHECK_CONDITION == srp->header.masked_status) ||
-	     (COMMAND_TERMINATED == srp->header.masked_status)))
+	if ((CHECK_CONDITION == srp->header.masked_status) ||
+	    (COMMAND_TERMINATED == srp->header.masked_status) ||
+	    (DRIVER_SENSE & srp->header.driver_status))
 	    print_req_sense("sg_cmd_done_bh", SRpnt);
 
 	/* Following if statement is a patch supplied by Eric Youngdale */


