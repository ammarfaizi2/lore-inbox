Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbTB0TUU>; Thu, 27 Feb 2003 14:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTB0TUU>; Thu, 27 Feb 2003 14:20:20 -0500
Received: from [200.225.83.11] ([200.225.83.11]:43978 "EHLO
	mandic-05.mandic.com.br") by vger.kernel.org with ESMTP
	id <S266308AbTB0TUP>; Thu, 27 Feb 2003 14:20:15 -0500
Message-ID: <64740.200.136.52.249.1046374223.squirrel@www.mandic.com.br>
Date: Thu, 27 Feb 2003 16:30:23 -0300 (BRT)
Subject: KXL-810 SCSI patch - help
From: "Eckhardt, Rodolpho H. O." <reckhardt@mandic.com.br>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: mandic:mail (version 1.2.7)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20030227163023_57627"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20030227163023_57627
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello,

I have never worked with kernel or modules developing before, but needed a patch for my
pcmcia scsi cd-rom.

I found this patch from a japanese website, and I assume this is for the 2.2 releases. I
cannot make this work with my 2.4.19 (I can't even find the files to patch). I need some
assistance with "translating" this to the 2.4 releases. Can anyone please help me?

It would help a lot to know also what this patch changes in the scsi driver.

Thanks,

Rodolpho Eckhardt
-- 
Rodolpho H. O. Eckhardt
reckhardt@mandic.com.br
Cel: 11 9126-9107


------=_20030227163023_57627
Content-Type: text/plain; name="qlogic_cs.c.diff"
Content-Disposition: attachment; filename="qlogic_cs.c.diff"

--- qlogic_cs.c.org	Tue Oct 26 05:03:18 1999
+++ qlogic_cs.c	Sun Nov 21 15:34:47 1999
@@ -1,3 +1,4 @@
+#undef QLOGIC_LEN32_ID_CHECK
 /*======================================================================
 
     A driver for the Qlogic SCSI card
@@ -239,6 +240,7 @@
 #if (LINUX_VERSION_CODE >= VERSION(2,1,75))
     struct Scsi_Host *host;
 #endif
+    u_short prod_id;
     
     handle = link->handle;
     info = link->priv;
@@ -256,8 +258,10 @@
     
     tuple.DesiredTuple = CISTPL_MANFID;
     if ((CardServices(GetFirstTuple, handle, &tuple) == CS_SUCCESS) &&
-	(CardServices(GetTupleData, handle, &tuple) == CS_SUCCESS))
+	(CardServices(GetTupleData, handle, &tuple) == CS_SUCCESS)){
 	info->manf_id = le16_to_cpu(tuple.TupleData[0]);
+	prod_id = le16_to_cpu(tuple_data[1]);
+    }
 
     /* Configure card */
 #if (LINUX_VERSION_CODE >= VERSION(2,1,23))
@@ -274,6 +278,9 @@
 	CFG_CHECK(ParseTuple, handle, &tuple, &parse);
 	link->conf.ConfigIndex = parse.cftable_entry.index;
 	link->io.BasePort1 = parse.cftable_entry.io.win[0].base;
+#if 1
+	link->io.NumPorts1 = parse.cftable_entry.io.win[0].len;
+#endif
 	if (link->io.BasePort1 != 0) {
 	    i = CardServices(RequestIO, handle, &link->io);
 	    if (i == CS_SUCCESS) break;
@@ -296,6 +303,17 @@
     /* A bad hack... */
     release_region(link->io.BasePort1, link->io.NumPorts1);
     
+#if 1
+    if (link->io.NumPorts1 == 32
+#ifdef QLOGIC_LEN32_ID_CHECK
+	&& ((info->manf_id == 0x0032 && prod_id == 0x0604)/*KXLC004*/ || 
+	    (info->manf_id == 0x0032 && prod_id == 0x0504)/*KXLC003*/
+	    )
+#endif /* QLOGIC_LEN32_ID_CHECK */
+	){
+      qlogic_preset(link->io.BasePort1 + 16, link->irq.AssignedIRQ);
+    } else
+#endif
     qlogic_preset(link->io.BasePort1, link->irq.AssignedIRQ);
     
     scsi_register_module(MODULE_SCSI_HA, &driver_template);
------=_20030227163023_57627
Content-Type: text/plain; name="scsi.diff"
Content-Disposition: attachment; filename="scsi.diff"

diff -uNr scsi.org/sr.c scsi/sr.c
--- scsi.org/sr.c	Sat Jan 16 07:41:04 1999
+++ scsi/sr.c	Mon Nov  1 13:41:15 1999
@@ -1050,6 +1050,7 @@
 {
     int i;
     char name[6];
+    extern int kme_poweron(int);
 
     blk_dev[MAJOR_NR].request_fn = DEVICE_REQUEST;
     blk_size[MAJOR_NR] = sr_sizes;
@@ -1080,6 +1081,11 @@
 	scsi_CDs[i].cdi.dev        = MKDEV(MAJOR_NR,i);
 	scsi_CDs[i].cdi.mask       = 0;
         scsi_CDs[i].cdi.capacity   = 1;
+        if (strncmp(scsi_CDs[i].device->vendor, "MATSHITA", 8) == 0
+           &&  strncmp(scsi_CDs[i].device->model, "KME CD-ROM07", 12) == 0){
+          printk(KERN_INFO "KME CD-ROM07 found.\n");
+          kme_poweron(i);
+        }
 	get_capabilities(i);
 	sr_vendor_init(i);
 
diff -uNr scsi.org/sr_ioctl.c scsi/sr_ioctl.c
--- scsi.org/sr_ioctl.c	Fri Jul  9 12:14:00 1999
+++ scsi/sr_ioctl.c	Mon Nov  1 13:40:33 1999
@@ -14,7 +14,7 @@
 #include <linux/cdrom.h>
 #include "sr.h"
 
-#if 0
+#if 1
 # define DEBUG
 #endif
 
@@ -42,6 +42,60 @@
     if (req->sem != NULL) {
 	up(req->sem);
     }
+}
+
+int kme_poweron(int target)
+{
+    unsigned char cmd[12];
+    Scsi_Cmnd * SCpnt;
+    Scsi_Device * SDev;
+    int result, err = 0;
+    unsigned long flags;
+
+    spin_lock_irqsave(&io_request_lock, flags);
+    SDev  = scsi_CDs[target].device;
+
+    SCpnt = scsi_allocate_device(NULL, scsi_CDs[target].device, 1);
+    SCpnt->cmd_len = 12;
+    cmd[0] = 0xe0;
+    cmd[1] = (scsi_CDs[target].device->lun << 5) & 0xe0;
+    cmd[2] = cmd[3] = cmd[4] = 0x00;
+    memcpy(cmd + 5, "TOMY01H", 7);
+
+    spin_unlock_irqrestore(&io_request_lock, flags);
+
+    if( !scsi_block_when_processing_errors(SDev) )
+        return -ENODEV;
+
+    {
+	struct semaphore sem = MUTEX_LOCKED;
+	SCpnt->request.sem = &sem;
+	spin_lock_irqsave(&io_request_lock, flags);
+	scsi_do_cmd(SCpnt,
+		    (void *) cmd, NULL, 0, sr_ioctl_done, 
+		    IOCTL_TIMEOUT, 0);
+	spin_unlock_irqrestore(&io_request_lock, flags);
+	down(&sem);
+        SCpnt->request.sem = NULL;
+    }
+    
+    result = SCpnt->result;
+    
+    if(driver_byte(result) != 0) {
+      printk(KERN_ERR "sr%d: KME-CDROM power on error, command: ", target);
+      print_command(cmd);
+      print_sense("sr", SCpnt);
+      err = -EIO;
+    }
+   
+    spin_lock_irqsave(&io_request_lock, flags);
+    result = SCpnt->result;
+    /* Wake up a process waiting for device*/
+    wake_up(&SCpnt->device->device_wait);
+    scsi_release_command(SCpnt);
+    SCpnt = NULL;
+    spin_unlock_irqrestore(&io_request_lock, flags);
+    return err;
 }
 
 /* We do our own retries because we want to know what the specific

------=_20030227163023_57627--

