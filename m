Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136106AbRD0QLP>; Fri, 27 Apr 2001 12:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136107AbRD0QLK>; Fri, 27 Apr 2001 12:11:10 -0400
Received: from mercury.eng.emc.com ([168.159.40.77]:25361 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S136094AbRD0QJY>; Fri, 27 Apr 2001 12:09:24 -0400
Message-ID: <6630C49FB136D511ACEC00B0D049EF8B3EBF9D@SRNAMATH>
From: "peck, william" <peck_william@emc.com>
To: linux-kernel@vger.kernel.org
Subject: Where did this patch come from?
Date: Fri, 27 Apr 2001 12:07:00 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C0CF34.179629E0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C0CF34.179629E0
Content-Type: text/plain;
	charset="iso-8859-1"

I was wondering if anyone could tell me who is responsible for the patch I
have included?  It fixes some issues with scanning the scsi bus,
specifically it reports luns higher than 8.  I am just wondering if whoever
has created this if they have submitted it to be included in the mainstream
2.2.x kernel series.


------_=_NextPart_000_01C0CF34.179629E0
Content-Type: application/octet-stream;
	name="patch-scsi-2.2.16-22.16"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-scsi-2.2.16-22.16"

Index: drivers/scsi/scsi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/em_rh/drivers/scsi/scsi.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 scsi.c
--- drivers/scsi/scsi.c	2001/02/26 01:30:44	1.1.1.1
+++ drivers/scsi/scsi.c	2001/02/28 02:20:52
@@ -186,9 +186,13 @@
 static void resize_dma_pool(void);
 static void print_inquiry(unsigned char *data);
 extern void scsi_times_out (Scsi_Cmnd * SCpnt);
-static int  scan_scsis_single (int channel,int dev,int lun,int * =
max_scsi_dev ,
-                 int * sparse_lun, Scsi_Device ** SDpnt, Scsi_Cmnd * =
SCpnt,
-                 struct Scsi_Host *shpnt, char * scsi_result);
+static int scan_scsis_single(unsigned int channel, unsigned int dev,
+		unsigned int lun, int lun0_scsi_level,=20
+		unsigned int *max_scsi_dev, unsigned int *sparse_lun,=20
+		Scsi_Device ** SDpnt, struct Scsi_Host *shpnt,=20
+		char *scsi_result);
+static int find_lun0_scsi_level(unsigned int channel, unsigned int =
dev,
+				struct Scsi_Host *shpnt);
 void        scsi_build_commandblocks(Scsi_Device * SDpnt);
 static int scsi_unregister_device(struct Scsi_Device_Template * tpnt);
=20
@@ -440,8 +444,10 @@
     }
 }
=20
+#define MAX_SCSI_LUNS 0x7FFFFFFF
+
 #ifdef CONFIG_SCSI_MULTI_LUN
-static int max_scsi_luns =3D 64;
+static int max_scsi_luns =3D MAX_SCSI_LUNS;
 #else
 static int max_scsi_luns =3D 1;
 #endif
@@ -449,7 +455,7 @@
 __initfunc(void scsi_luns_setup(char *str, int *ints))
 {
     if (ints[0] !=3D 1)
-	printk("scsi_luns_setup : usage max_scsi_luns=3Dn (n should be =
between 1 and 8)\n");
+	printk("scsi_luns_setup : usage max_scsi_luns=3Dn (n should be =
between 1 and 2^32-1)\n");
     else
 	max_scsi_luns =3D ints[1];
 }
@@ -468,15 +474,16 @@
                         unchar hlun)
 {
   int             channel;
-  int             dev;
-  int             lun;
-  int             max_dev_lun;
+  unsigned int    dev;
+  unsigned int    lun;
+  unsigned int    max_dev_lun;
   Scsi_Cmnd     * SCpnt;
   unsigned char * scsi_result;
   unsigned char   scsi_result0[256];
   Scsi_Device   * SDpnt;
   Scsi_Device   * SDtail;
-  int             sparse_lun;
+  unsigned int    sparse_lun;
+  int lun0_sl;
=20
   scsi_result =3D NULL;
   SCpnt =3D (Scsi_Cmnd *) scsi_init_malloc (sizeof (Scsi_Cmnd),=20
@@ -539,8 +546,13 @@
     if(dev >=3D shpnt->max_id) goto leave;
     lun =3D hlun;
     if(lun >=3D shpnt->max_lun) goto leave;
-    scan_scsis_single (channel, dev, lun, &max_dev_lun, &sparse_lun,
-		       &SDpnt, SCpnt, shpnt, scsi_result);
+
+    if ((0 =3D=3D lun) || (lun > 7))
+        lun0_sl =3D SCSI_3; /* actually don't care for 0 =3D=3D lun */
+    else
+        lun0_sl =3D find_lun0_scsi_level(channel, dev, shpnt);
+    scan_scsis_single(channel, dev, lun, lun0_sl, &max_dev_lun,=20
+                      &sparse_lun, &SDpnt, shpnt, scsi_result);
=20
     /* See warning by (DB) in scsi_proc_info() towards end of
        'add-single-device' section. (dpg) */
@@ -596,14 +608,33 @@
            */
           max_dev_lun =3D (max_scsi_luns < shpnt->max_lun ?
                          max_scsi_luns : shpnt->max_lun);
-	  sparse_lun =3D 0;
-          for (lun =3D 0; lun < max_dev_lun; ++lun) {
-            if (!scan_scsis_single (channel, order_dev, lun, =
&max_dev_lun,
-				    &sparse_lun, &SDpnt, SCpnt, shpnt,
-				    scsi_result)
-		&& !sparse_lun)
-              break; /* break means don't probe further for luns!=3D0 =
*/
-          }                     /* for lun ends */
+
+#ifdef CONFIG_SCSI_MULTI_LUN
+	  if ((shpnt->max_id > 16) && (shpnt->max_lun > 16)) {
+                /* This is the first step of supporting large numbers
+                 * of luns on a device.  By definition any SCSU host =
capable
+                 * of supporting more than 16 SCSI controlers with =
more than
+		 * 16 luns will probably be a fiber channel or similar device
+		 * and use a sparse lun setup.  If the future this is the
+                 * place to do a report lun call.
+                 */
+                sparse_lun =3D 1;
+          } else {
+                sparse_lun =3D 0;
+          }
+#else
+          sparse_lun =3D 0;
+#endif
+
+          for (lun =3D 0, lun0_sl =3D SCSI_2; lun < max_dev_lun; =
++lun) {
+              if (!scan_scsis_single(channel, order_dev, lun, lun0_sl,
+                                     &max_dev_lun, &sparse_lun, =
&SDpnt, shpnt,
+                                     scsi_result)
+                      && !sparse_lun)
+                  break;	/* break means don't probe further for =
luns!=3D0 */
+              if (SDpnt && (0 =3D=3D lun))
+                lun0_sl =3D SDpnt->scsi_level;
+          }             	/* for lun ends */
         }                       /* if this_id !=3D id ends */
       }                         /* for dev ends */
     }                           /* for channel ends */
@@ -665,18 +696,43 @@
     }
 }
=20
+Scsi_Cmnd *scsi_allocate_request(Scsi_Device * device)
+{
+  Scsi_Cmnd *SCpnt =3D NULL;
+
+  if (!device)
+    panic("No device passed to scsi_allocate_request().\n");
+
+  SCpnt =3D (Scsi_Cmnd *) kmalloc(sizeof(Scsi_Cmnd), GFP_ATOMIC);
+
+  if (SCpnt =3D=3D NULL)
+    return NULL;
+
+  memset(SCpnt, 0, sizeof(Scsi_Cmnd));
+  SCpnt->host =3D device->host;
+  SCpnt->device =3D device;
+  SCpnt->target =3D device->id;
+  SCpnt->lun =3D device->lun;
+  SCpnt->channel =3D device->channel;
+
+  return SCpnt;
+}
+
 /*
  * The worker for scan_scsis.
  * Returning 0 means Please don't ask further for lun!=3D0, 1 means OK =
go on.
  * Global variables used : scsi_devices(linked list)
  */
-int scan_scsis_single (int channel, int dev, int lun, int =
*max_dev_lun,
-    int *sparse_lun, Scsi_Device **SDpnt2, Scsi_Cmnd * SCpnt,
-    struct Scsi_Host * shpnt, char *scsi_result)
+static int scan_scsis_single(unsigned int channel, unsigned int dev,
+                             unsigned int lun, int lun0_scsi_level,
+                             unsigned int *max_dev_lun, unsigned int =
*sparse_lun,=20
+                             Scsi_Device ** SDpnt2, struct Scsi_Host =
*shpnt,=20
+                             char *scsi_result)
 {
   unsigned char scsi_cmd[12];
   struct Scsi_Device_Template *sdtpnt;
   Scsi_Device * SDtail, *SDpnt=3D*SDpnt2;
+  Scsi_Cmnd * SCpnt;
   int bflags, type=3D-1;
=20
   SDpnt->host =3D shpnt;
@@ -695,46 +751,10 @@
   SDpnt->borken =3D 1;
   SDpnt->was_reset =3D 0;
   SDpnt->expecting_cc_ua =3D 0;
-
-  scsi_cmd[0] =3D TEST_UNIT_READY;
-  scsi_cmd[1] =3D lun << 5;
-  scsi_cmd[2] =3D scsi_cmd[3] =3D scsi_cmd[4] =3D scsi_cmd[5] =3D 0;
-
-  SCpnt->host =3D SDpnt->host;
-  SCpnt->device =3D SDpnt;
-  SCpnt->target =3D SDpnt->id;
-  SCpnt->lun =3D SDpnt->lun;
-  SCpnt->channel =3D SDpnt->channel;
-  {
-    struct semaphore sem =3D MUTEX_LOCKED;
-    SCpnt->request.sem =3D &sem;
-    SCpnt->request.rq_status =3D RQ_SCSI_BUSY;
-    spin_lock_irq(&io_request_lock);
-    scsi_do_cmd (SCpnt, (void *) scsi_cmd,
-                 (void *) scsi_result,
-                 256, scan_scsis_done, SCSI_TIMEOUT + 4 * HZ, 5);
-    spin_unlock_irq(&io_request_lock);
-    down (&sem);
-    SCpnt->request.sem =3D NULL;
-  }
=20
-  SCSI_LOG_SCAN_BUS(3,  printk ("scsi: scan_scsis_single id %d lun %d. =
Return code 0x%08x\n",
-          dev, lun, SCpnt->result));
-  SCSI_LOG_SCAN_BUS(3,print_driverbyte(SCpnt->result));
-  SCSI_LOG_SCAN_BUS(3,print_hostbyte(SCpnt->result));
-  SCSI_LOG_SCAN_BUS(3,printk("\n"));
-
-  if (SCpnt->result && status_byte(SCpnt->result) !=3D =
RESERVATION_CONFLICT) {
-    if (((driver_byte (SCpnt->result) & DRIVER_SENSE) ||
-         (status_byte (SCpnt->result) & CHECK_CONDITION)) &&
-        ((SCpnt->sense_buffer[0] & 0x70) >> 4) =3D=3D 7) {
-      if (((SCpnt->sense_buffer[2] & 0xf) !=3D NOT_READY) &&
-          ((SCpnt->sense_buffer[2] & 0xf) !=3D UNIT_ATTENTION) &&
-          ((SCpnt->sense_buffer[2] & 0xf) !=3D ILLEGAL_REQUEST || lun =
> 0))
-        return 1;
-    }
-    else
-      return 0;
+  if (NULL =3D=3D (SCpnt =3D scsi_allocate_request(SDpnt))) {
+    printk("scan_scsis_single: no memory\n");
+    return 0;
   }
=20
   SCSI_LOG_SCAN_BUS(3,printk ("scsi: performing INQUIRY\n"));
@@ -742,7 +762,11 @@
    * Build an INQUIRY command block.
    */
   scsi_cmd[0] =3D INQUIRY;
-  scsi_cmd[1] =3D (lun << 5) & 0xe0;
+  if ((lun > 0) && (lun0_scsi_level <=3D SCSI_2))
+    scsi_cmd[1] =3D (lun << 5) & 0xe0;
+  else=09
+    scsi_cmd[1] =3D 0;	/* SCSI_3 and higher, don't touch */
+
   scsi_cmd[2] =3D 0;
   scsi_cmd[3] =3D 0;
   scsi_cmd[4] =3D 255;
@@ -764,15 +788,17 @@
   SCSI_LOG_SCAN_BUS(3,printk ("scsi: INQUIRY %s with code 0x%x\n",
                               SCpnt->result ? "failed" : "successful", =
SCpnt->result));
=20
-  if (SCpnt->result)
+  if (SCpnt->result) {
+    kfree(SCpnt);
     return 0;     /* assume no peripheral if any sort of error */
-
+  }
   /*
    * Check the peripheral qualifier field - this tells us whether LUNS
    * are supported here or not.
    */
   if( (scsi_result[0] >> 5) =3D=3D 3 )
     {
+      kfree(SCpnt);
       return 0;     /* assume no peripheral if any sort of error */
     }
=20
@@ -896,7 +922,11 @@
     printk ("Unlocked floptical drive.\n");
     SDpnt->lockable =3D 0;
     scsi_cmd[0] =3D MODE_SENSE;
-    scsi_cmd[1] =3D (lun << 5) & 0xe0;
+    if (shpnt->max_lun <=3D 8)
+      scsi_cmd[1] =3D (lun << 5) & 0xe0;
+    else
+      scsi_cmd[1] =3D 0;	/* any other idea? */
+
     scsi_cmd[2] =3D 0x2e;
     scsi_cmd[3] =3D 0;
     scsi_cmd[4] =3D 0x2a;
@@ -932,6 +962,7 @@
   if (!SDpnt)
   {
       printk ("scsi: scan_scsis_single: Cannot malloc\n");
+      kfree(SCpnt);
       return 0;
   }
=20
@@ -963,15 +994,30 @@
   /*
    * Some scsi devices cannot be polled for lun !=3D 0 due to firmware =
bugs
    */
-  if (bflags & BLIST_NOLUN)
+  if (bflags & BLIST_NOLUN) {
+    kfree(SCpnt);
     return 0;                   /* break; */
+  }
=20
   /*
    * If this device is known to support sparse multiple units, =
override the
    * other settings, and scan all of them.
    */
   if (bflags & BLIST_SPARSELUN) {
-    *max_dev_lun =3D 8;
+    /*
+     * Scanning MAX_SCSI_LUNS units would be a bad idea.
+     * Any better idea?
+     * I think we need REPORT LUNS in future to avoid scanning
+     * of unused LUNs. But, that is another item.
+     *
+     * FIXME(eric) - perhaps this should be a kernel configurable?
+     */
+    if (*max_dev_lun < shpnt->max_lun)
+      *max_dev_lun =3D shpnt->max_lun;
+    else if ((max_scsi_luns >> 1) >=3D *max_dev_lun)
+      *max_dev_lun +=3D shpnt->max_lun;
+    else
+      *max_dev_lun =3D max_scsi_luns;
     *sparse_lun =3D 1;
     return 1;
   }
@@ -981,7 +1027,18 @@
    * settings, and scan all of them.
    */
   if (bflags & BLIST_FORCELUN) {
-    *max_dev_lun =3D 8;
+    /*=20
+     * Scanning MAX_SCSI_LUNS units would be a bad idea.
+     * Any better idea?
+     * I think we need REPORT LUNS in future to avoid scanning
+     * of unused LUNs. But, that is another item.
+     */
+    if (*max_dev_lun < shpnt->max_lun)
+      *max_dev_lun =3D shpnt->max_lun;
+    else if ((max_scsi_luns >> 1) >=3D *max_dev_lun)
+      *max_dev_lun +=3D shpnt->max_lun;
+    else
+      *max_dev_lun =3D max_scsi_luns;
     return 1;
   }
=20
@@ -1001,9 +1058,32 @@
   if (((scsi_result[2] & 0x07) =3D=3D 0)
       ||
       ((scsi_result[2] & 0x07) =3D=3D 1 &&
-       (scsi_result[3] & 0x0f) =3D=3D 0))
+       (scsi_result[3] & 0x0f) =3D=3D 0)) {
+    kfree(SCpnt);
     return 0;
+  }
   return 1;
+}
+
+/*
+ * The worker for scan_scsis.
+ * Returns the scsi_level of lun0 on this host, channel and dev (if =
already
+ * known), otherwise returns SCSI_2.
+ */
+static int find_lun0_scsi_level(unsigned int channel, unsigned int =
dev,
+				struct Scsi_Host *shpnt)
+{
+  int res =3D SCSI_2;
+  Scsi_Device *SDpnt;
+
+  for (SDpnt =3D shpnt->host_queue; SDpnt; SDpnt =3D SDpnt->next)
+    {
+      if ((0 =3D=3D SDpnt->lun) && (dev =3D=3D SDpnt->id) &&
+          (channel =3D=3D SDpnt->channel))
+        return (int)SDpnt->scsi_level;
+    }
+  /* haven't found lun0, should send INQUIRY but take easy route */
+  return res;
 }
=20
 /*
Index: drivers/scsi/scsi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/em_rh/drivers/scsi/scsi.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 scsi.h
--- drivers/scsi/scsi.h	2001/02/26 01:30:44	1.1.1.1
+++ drivers/scsi/scsi.h	2001/02/28 01:54:05
@@ -431,7 +431,8 @@
     Scsi_Cmnd          * device_queue;    /* queue of SCSI Command =
structures */
=20
 /* public: */
-    unsigned char id, lun, channel;
+    unsigned int lun;
+    unsigned char id, channel;
=20
     unsigned int manufacturer;      /* Manufacturer of device, for =
using=20
 				     * vendor-specific cmd's */
@@ -541,8 +542,8 @@
    =20
 /* public: */
=20
+    unsigned int       lun;
     unsigned char      target;
-    unsigned char      lun;
     unsigned char      channel;
     unsigned char      cmd_len;
     unsigned char      old_cmd_len;

------_=_NextPart_000_01C0CF34.179629E0--
