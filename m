Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265206AbSJPQrV>; Wed, 16 Oct 2002 12:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265193AbSJPQq0>; Wed, 16 Oct 2002 12:46:26 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:50157 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265202AbSJPQpq> convert rfc822-to-8bit; Wed, 16 Oct 2002 12:45:46 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.43 s390 (6/6): dasd stuff.
Date: Wed, 16 Oct 2002 18:49:04 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210161849.04773.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add module license statements to dasd driver. Add XRC support. Fix possible
endless loop in dasd_term_IO and check range of device numbers.

diff -urN linux-2.5.43/drivers/s390/block/dasd.c linux-2.5.43-s390/drivers/s390/block/dasd.c
--- linux-2.5.43/drivers/s390/block/dasd.c	Wed Oct 16 05:27:57 2002
+++ linux-2.5.43-s390/drivers/s390/block/dasd.c	Wed Oct 16 17:54:15 2002
@@ -80,6 +82,7 @@
 MODULE_SUPPORTED_DEVICE("dasd");
 MODULE_PARM(dasd, "1-" __MODULE_STRING(256) "s");
 MODULE_PARM(dasd_disciplines, "1-" __MODULE_STRING(8) "s");
+MODULE_LICENSE("GPL");
 
 /*
  * SECTION: prototypes for static functions of dasd.c
@@ -1190,6 +1196,7 @@
 			BUG();
 			break;
 		}
+		retries++;
 	}
 	dasd_schedule_bh(device);
 	return rc;
@@ -1554,7 +1567,7 @@
 			goto restart;
 		}
 
-		/* Rechain request on device device request queue */
+		/* Rechain finished requests to final queue */
 		cqr->endclk = get_clock();
 		list_move_tail(&cqr->list, final_queue);
 	}
@@ -1641,7 +1654,7 @@
 
 /*
  * Take a look at the first request on the ccw queue and check
- * if it reached its expire time.
+ * if it reached its expire time. If so, terminate the IO.
  */
 static inline void
 __dasd_check_expire(dasd_device_t * device)
@@ -1766,7 +1779,7 @@
 }
 
 /*
- * Schedules a call to dasd_process_queues over the device tasklet.
+ * Schedules a call to dasd_tasklet over the device tasklet.
  */
 void
 dasd_schedule_bh(dasd_device_t * device)
diff -urN linux-2.5.43/drivers/s390/block/dasd_3990_erp.c linux-2.5.43-s390/drivers/s390/block/dasd_3990_erp.c
--- linux-2.5.43/drivers/s390/block/dasd_3990_erp.c	Wed Oct 16 05:28:34 2002
+++ linux-2.5.43-s390/drivers/s390/block/dasd_3990_erp.c	Wed Oct 16 17:54:15 2002
@@ -1122,6 +1124,9 @@
 		break;
 
 	default:	/* unknown message format - should not happen */
+	        DEV_MESSAGE (KERN_WARNING, device,
+                             "unknown message format %02x",
+                             msg_format);
 		break;
 	}			/* end switch message format */
 
diff -urN linux-2.5.43/drivers/s390/block/dasd_devmap.c linux-2.5.43-s390/drivers/s390/block/dasd_devmap.c
--- linux-2.5.43/drivers/s390/block/dasd_devmap.c	Wed Oct 16 05:28:22 2002
+++ linux-2.5.43-s390/drivers/s390/block/dasd_devmap.c	Wed Oct 16 17:54:15 2002
@@ -87,6 +90,8 @@
 int
 dasd_devno(char *str, char **endp)
 {
+	int val;
+ 
 	/* remove leading '0x' */
 	if (*str == '0') {
 		str++;
@@ -96,7 +101,10 @@
 	/* We require at least one hex digit */
 	if (!isxdigit(*str))
 		return -EINVAL;
-	return simple_strtoul(str, endp, 16);
+	val = simple_strtoul(str, endp, 16);
+	if ((val > 0xFFFF) || (val < 0))
+		return -EINVAL;
+	return val;
 }
 
 /*
diff -urN linux-2.5.43/drivers/s390/block/dasd_diag.c linux-2.5.43-s390/drivers/s390/block/dasd_diag.c
--- linux-2.5.43/drivers/s390/block/dasd_diag.c	Wed Oct 16 05:27:09 2002
+++ linux-2.5.43-s390/drivers/s390/block/dasd_diag.c	Wed Oct 16 17:54:15 2002
@@ -40,6 +42,8 @@
 #endif				/* PRINTK_HEADER */
 #define PRINTK_HEADER "dasd(diag):"
 
+MODULE_LICENSE("GPL");
+
 static dasd_discipline_t dasd_diag_discipline;
 
 typedef struct dasd_diag_private_t {
diff -urN linux-2.5.43/drivers/s390/block/dasd_eckd.c linux-2.5.43-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.5.43/drivers/s390/block/dasd_eckd.c	Wed Oct 16 05:27:07 2002
+++ linux-2.5.43-s390/drivers/s390/block/dasd_eckd.c	Wed Oct 16 17:54:15 2002
@@ -59,6 +61,8 @@
 #define ECKD_F7(i) (i->factor7)
 #define ECKD_F8(i) (i->factor8)
 
+MODULE_LICENSE("GPL");
+
 static dasd_discipline_t dasd_eckd_discipline;
 
 typedef struct dasd_eckd_private_t {
@@ -183,6 +187,31 @@
 }
 
 static inline void
+check_XRC (ccw1_t         *de_ccw,
+           DE_eckd_data_t *data,
+           dasd_device_t  *device)
+{
+        dasd_eckd_private_t *private;
+
+        private = (dasd_eckd_private_t *) device->private;
+
+        /* switch on System Time Stamp - needed for XRC Support */
+        if (private->rdc_data.facilities.XRC_supported) {
+                
+                data->ga_extended |= 0x08;   /* switch on 'Time Stamp Valid'   */
+                data->ga_extended |= 0x02;   /* switch on 'Extended Parameter' */
+                
+                data->ep_sys_time = get_clock ();
+                
+                de_ccw->count = sizeof (DE_eckd_data_t);
+                de_ccw->flags = CCW_FLAG_SLI;  
+        }
+
+        return;
+
+} /* end check_XRC */
+
+static inline void
 define_extent(ccw1_t * ccw, DE_eckd_data_t * data, int trk, int totrk,
 	      int cmd, dasd_device_t * device)
 {
@@ -216,10 +245,12 @@
 	case DASD_ECKD_CCW_WRITE_KD_MT:
 		data->mask.perm = 0x02;
 		data->attributes.operation = private->attrib.operation;
+                check_XRC (ccw, data, device);
 		break;
 	case DASD_ECKD_CCW_WRITE_CKD:
 	case DASD_ECKD_CCW_WRITE_CKD_MT:
 		data->attributes.operation = DASD_BYPASS_CACHE;
+                check_XRC (ccw, data, device);
 		break;
 	case DASD_ECKD_CCW_ERASE:
 	case DASD_ECKD_CCW_WRITE_HOME_ADDRESS:
@@ -227,6 +258,7 @@
 		data->mask.perm = 0x3;
 		data->mask.auth = 0x1;
 		data->attributes.operation = DASD_BYPASS_CACHE;
+                check_XRC (ccw, data, device);
 		break;
 	default:
 		MESSAGE(KERN_ERR, "unknown opcode 0x%x", cmd);
@@ -497,6 +529,11 @@
 		    private->rdc_data.cu_type,
 		    private->rdc_data.cu_model.model);
 	return 0;
+
+        /* get characteristis via diag to determine the kind of minidisk under VM */
+        /* needed beacause XRC is not support by VM (jet)                         */
+        /* Can be removed as soon as VM supports XRC                              */
+	// TBD ??? HUM
 }
 
 static int
@@ -563,6 +600,7 @@
 
 	cqr->device = device;
 	cqr->retries = 0;
+	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
 	return cqr;
 }
@@ -881,6 +919,7 @@
 	}
 	fcp->device = device;
 	fcp->retries = 2;	/* set retry counter to enable ERP */
+	fcp->buildclk = get_clock();
 	fcp->status = DASD_CQR_FILLED;
 	return fcp;
 }
@@ -1119,6 +1158,7 @@
 	cqr->device = device;
 	cqr->retries = 0;
 	cqr->expires = 10 * HZ;
+	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
 
 	rc = dasd_sleep_on_immediatly(cqr);
@@ -1163,6 +1203,7 @@
 	cqr->device = device;
 	cqr->retries = 0;
 	cqr->expires = 10 * HZ;
+	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
 
 	rc = dasd_sleep_on_immediatly(cqr);
@@ -1209,6 +1250,7 @@
 	cqr->device = device;
 	cqr->retries = 0;
 	cqr->expires = 10 * HZ;
+	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
 
 	rc = dasd_sleep_on_immediatly(cqr);
@@ -1277,6 +1319,7 @@
 	ccw->count = sizeof (dasd_rssd_perf_stats_t);
 	ccw->cda = (__u32)(addr_t) stats;
 
+	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
 	rc = dasd_sleep_on(cqr);
 	if (rc == 0) {
diff -urN linux-2.5.43/drivers/s390/block/dasd_eckd.h linux-2.5.43-s390/drivers/s390/block/dasd_eckd.h
--- linux-2.5.43/drivers/s390/block/dasd_eckd.h	Wed Oct 16 05:27:54 2002
+++ linux-2.5.43-s390/drivers/s390/block/dasd_eckd.h	Wed Oct 16 17:54:15 2002
@@ -1,3 +1,16 @@
+/* 
+ * File...........: linux/drivers/s390/block/dasd_eckd.h
+ * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
+ *                  Horst Hummel <Horst.Hummel@de.ibm.com> 
+ * Bugreports.to..: <Linux390@de.ibm.com>
+ * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
+ *
+ * $Revision: 1.4 $
+ *
+ * History of changes 
+ * 
+ */
+
 #ifndef DASD_ECKD_H
 #define DASD_ECKD_H
 
@@ -102,6 +115,10 @@
 	__u8 ga_extended;	/* Global Attributes Extended	*/
 	ch_t beg_ext;
 	ch_t end_ext;
+	unsigned long long ep_sys_time; /* Extended Parameter - System Time Stamp */
+	__u8 ep_format;        /* Extended Parameter format byte       */
+	__u8 ep_prio;          /* Extended Parameter priority I/O byte */
+	__u8 ep_reserved[6];   /* Extended Parameter Reserved          */
 } __attribute__ ((packed)) DE_eckd_data_t;
 
 typedef struct LO_eckd_data_t {
@@ -141,7 +158,8 @@
 		unsigned char reserved2:4;
 		unsigned char reserved3:8;
 		unsigned char defect_wr:1;
-		unsigned char reserved4:2;
+		unsigned char XRC_supported:1; 
+		unsigned char reserved4:1;
 		unsigned char striping:1;
 		unsigned char reserved5:4;
 		unsigned char cfw:1;
diff -urN linux-2.5.43/drivers/s390/block/dasd_fba.c linux-2.5.43-s390/drivers/s390/block/dasd_fba.c
--- linux-2.5.43/drivers/s390/block/dasd_fba.c	Wed Oct 16 05:28:28 2002
+++ linux-2.5.43-s390/drivers/s390/block/dasd_fba.c	Wed Oct 16 17:54:15 2002
@@ -38,6 +41,8 @@
 #define DASD_FBA_CCW_LOCATE 0x43
 #define DASD_FBA_CCW_DEFINE_EXTENT 0x63
 
+MODULE_LICENSE("GPL");
+
 static dasd_discipline_t dasd_fba_discipline;
 
 typedef struct dasd_fba_private_t {
diff -urN linux-2.5.43/drivers/s390/block/dasd_proc.c linux-2.5.43-s390/drivers/s390/block/dasd_proc.c
--- linux-2.5.43/drivers/s390/block/dasd_proc.c	Wed Oct 16 05:27:20 2002
+++ linux-2.5.43-s390/drivers/s390/block/dasd_proc.c	Wed Oct 16 17:54:15 2002
@@ -195,10 +198,7 @@
 		break;
 	case DASD_STATE_READY:
 	case DASD_STATE_ONLINE:
-		if (device->state < DASD_STATE_ONLINE)
-			len += sprintf(str + len, "fenced ");
-		else
-			len += sprintf(str + len, "active ");
+		len += sprintf(str + len, "active ");
 		if (dasd_check_blocksize(device->bp_block))
 			len += sprintf(str + len, "n/f	 ");
 		else
diff -urN linux-2.5.43/include/asm-s390/dasd.h linux-2.5.43-s390/include/asm-s390/dasd.h
--- linux-2.5.43/include/asm-s390/dasd.h	Wed Oct 16 05:27:18 2002
+++ linux-2.5.43-s390/include/asm-s390/dasd.h	Wed Oct 16 17:54:15 2002
@@ -8,6 +8,8 @@
  * any future changes wrt the API will result in a change of the APIVERSION reported
  * to userspace by the DASDAPIVER-ioctl
  *
+ * $Revision: 1.3 $
+ *
  * History of changes (starts July 2000)
  * 05/04/01 created by moving the kernel interface to drivers/s390/block/dasd_int.h
  * 12/06/01 DASD_API_VERSION 2 - binary compatible to 0 (new BIODASDINFO2)
@@ -224,8 +226,6 @@
 #define BIODASDSLCK    _IO(DASD_IOCTL_LETTER,4) /* steal lock */
 /* reset profiling information of a device */
 #define BIODASDPRRST   _IO(DASD_IOCTL_LETTER,5)
-/* enable PAV */
-#define BIODASDENAPAV  _IO(DASD_IOCTL_LETTER,6)
 
 
 /* retrieve API version number */
diff -urN linux-2.5.43/include/asm-s390x/dasd.h linux-2.5.43-s390/include/asm-s390x/dasd.h
--- linux-2.5.43/include/asm-s390x/dasd.h	Wed Oct 16 05:27:48 2002
+++ linux-2.5.43-s390/include/asm-s390x/dasd.h	Wed Oct 16 17:54:15 2002
@@ -8,6 +8,8 @@
  * any future changes wrt the API will result in a change of the APIVERSION reported
  * to userspace by the DASDAPIVER-ioctl
  *
+ * $Revision: 1.3 $
+ *
  * History of changes (starts July 2000)
  * 05/04/01 created by moving the kernel interface to drivers/s390/block/dasd_int.h
  * 12/06/01 DASD_API_VERSION 2 - binary compatible to 0 (new BIODASDINFO2)
@@ -224,8 +226,6 @@
 #define BIODASDSLCK    _IO(DASD_IOCTL_LETTER,4) /* steal lock */
 /* reset profiling information of a device */
 #define BIODASDPRRST   _IO(DASD_IOCTL_LETTER,5)
-/* enable PAV */
-#define BIODASDENAPAV  _IO(DASD_IOCTL_LETTER,6)
 
 
 /* retrieve API version number */

