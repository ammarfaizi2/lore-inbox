Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129294AbRBTVoI>; Tue, 20 Feb 2001 16:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129278AbRBTVn7>; Tue, 20 Feb 2001 16:43:59 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:62070
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129144AbRBTVny>; Tue, 20 Feb 2001 16:43:54 -0500
Date: Tue, 20 Feb 2001 22:43:44 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: make drivers/scsi/seagate.c use ioremap instead of isa_{read,write} (242p4)
Message-ID: <20010220224344.D786@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(I have not been able to find a probable current maintainer for
this code.)

The following patch makes drivers/scsi/seagate.c use ioremap
instead of isa_{read, write} (I have not been able to find
a fitting place to put an iounmap since the driver does not
have a release function). The patch also removes some unneces-
sary zero initialization and fixes some resource leaks in
the init/detection process.

It applies against 241ac19 and 242p4.

Comments?.

--- linux-241ac19-clean/drivers/scsi/seagate.c	Sun Nov 12 04:01:11 2000
+++ linux-241ac19/drivers/scsi/seagate.c	Tue Feb 20 22:32:10 2001
@@ -230,7 +230,7 @@
 static int incommand;                   /* set if arbitration has finished
                                            and we are in some command phase. */
 
-static unsigned int base_address = 0;   /* Where the card ROM starts, used to 
+static unsigned int base_address;       /* Where the card ROM starts, used to 
                                            calculate memory mapped register
                                            location.  */
 
@@ -243,23 +243,26 @@
 static unsigned long st0x_dr;           /* data register, read write 256
                                            bytes in length.  */
 
-static volatile int st0x_aborted = 0;   /* set when we are aborted, ie by a
+static volatile int st0x_aborted;       /* set when we are aborted, ie by a
                                            time out, etc.  */
 
-static unsigned char controller_type = 0;       /* set to SEAGATE for ST0x
-                                                   boards or FD for TMC-8xx
-                                                   boards */
+static unsigned char controller_type;   /* set to SEAGATE for ST0x
+                                           boards or FD for TMC-8xx
+                                           boards */
 static int irq = IRQ;
 
+static void *status_remap;
+static void *data_remap;
+
 MODULE_PARM(base_address, "i");
 MODULE_PARM(controller_type, "b");
 MODULE_PARM(irq, "i");
 
 #define retcode(result) (((result) << 16) | (message << 8) | status)
-#define STATUS ((u8) isa_readb(st0x_cr_sr))
-#define DATA ((u8) isa_readb(st0x_dr))
-#define WRITE_CONTROL(d) { isa_writeb((d), st0x_cr_sr); }
-#define WRITE_DATA(d) { isa_writeb((d), st0x_dr); }
+#define STATUS ((u8) readb(status_remap))
+#define DATA ((u8) readb(data_remap))
+#define WRITE_CONTROL(d) { writeb((d), status_remap); }
+#define WRITE_DATA(d) { writeb((d), data_remap); }
 
 void st0x_setup (char *str, int *ints)
 {
@@ -489,13 +492,13 @@
  */
   instance = scsi_register (tpnt, 0);
   if(instance == NULL)
-  	return 0;
+    goto err_scsi_register;
   	
   hostno = instance->host_no;
   if (request_irq (irq, do_seagate_reconnect_intr, SA_INTERRUPT,
 		   (controller_type == SEAGATE) ? "seagate" : "tmc-8xx", NULL)) {
     printk ("scsi%d : unable to allocate IRQ%d\n", hostno, irq);
-    return 0;
+    goto err_request_irq;
   }
   instance->irq = irq;
   instance->io_port = base_address;
@@ -546,7 +549,25 @@
             " SWAPCNTDATA"
 #endif
 	  "\n", tpnt->name);
+
+  status_remap = ioremap(st0x_cr_sr, sizeof(u8));
+  if (!status_remap)
+    goto err_status_remap;
+
+  data_remap = ioremap(st0x_dr, sizeof(u8));
+  if (!data_remap)
+    goto err_data_remap;
+  
   return 1;
+
+ err_data_remap:
+  iounmap(status_remap);
+ err_status_remap:
+  free_irq(irq, do_seagate_reconnect_intr);
+ err_request_irq:
+  scsi_unregister(instance);
+ err_scsi_register:
+  return 0;
 }
 
 const char *seagate_st0x_info (struct Scsi_Host *shpnt)


-- 
        Rasmus(rasmus@jaquet.dk)

It is wonderful to be here in the great state of Chicago.
-Former U.S. Vice-President Dan Quayle
