Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbTLGVG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTLGVDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:03:21 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:4705 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264556AbTLGVAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 16:00:30 -0500
Date: Sun, 7 Dec 2003 21:51:22 +0100
Message-Id: <200312072051.hB7KpMgu000717@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 131] Mac SCSI
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac SCSI fixes (from Matthias Urlichs in 2.6.0):
  - Inline functions need to be defined before being used.
  - out_8() takes an address and a value, not the other way round.  

--- linux-2.4.23/drivers/scsi/mac_scsi.c	Thu Sep  4 10:29:22 2003
+++ linux-m68k-2.4.23/drivers/scsi/mac_scsi.c	Mon Oct 13 14:16:09 2003
@@ -74,9 +74,6 @@
 static void mac_scsi_reset_boot(struct Scsi_Host *instance);
 #endif
 
-static __inline__ char macscsi_read(struct Scsi_Host *instance, int reg);
-static __inline__ void macscsi_write(struct Scsi_Host *instance, int reg, int value);
-
 static int setup_called = 0;
 static int setup_can_queue = -1;
 static int setup_cmd_per_lun = -1;
@@ -102,6 +99,52 @@
 static volatile unsigned char *mac_scsi_drq  = NULL;
 static volatile unsigned char *mac_scsi_nodrq = NULL;
 
+
+/*
+ * NCR 5380 register access functions
+ */
+
+#if 0
+/* Debug versions */
+#define CTRL(p,v) (*ctrl = (v))
+
+static char macscsi_read(struct Scsi_Host *instance, int reg)
+{
+  int iobase = instance->io_port;
+  int i;
+  int *ctrl = &((struct NCR5380_hostdata *)instance->hostdata)->ctrl;
+
+  CTRL(iobase, 0);
+  i = in_8(iobase + (reg<<4));
+  CTRL(iobase, 0x40);
+
+  return i;
+}
+
+static void macscsi_write(struct Scsi_Host *instance, int reg, int value)
+{
+  int iobase = instance->io_port;
+  int *ctrl = &((struct NCR5380_hostdata *)instance->hostdata)->ctrl;
+
+  CTRL(iobase, 0);
+  out_8(iobase + (reg<<4), value);
+  CTRL(iobase, 0x40);
+}
+#else
+
+/* Fast versions */
+static __inline__ char macscsi_read(struct Scsi_Host *instance, int reg)
+{
+  return in_8(instance->io_port + (reg<<4));
+}
+
+static __inline__ void macscsi_write(struct Scsi_Host *instance, int reg, int value)
+{
+  out_8(instance->io_port + (reg<<4), value);
+}
+#endif
+
+
 /*
  * Function : mac_scsi_setup(char *str)
  *
@@ -163,18 +206,20 @@
 	    if (ints[5] >= 0)
 		setup_use_pdma = ints[5];
 	}
-#endif
+#endif /* SUPPORT_TAGS */
 	
-#endif
+#endif /* DRIVER_SETUP */
 	return 1;
 }
 
 __setup("mac5380=", mac_scsi_setup);
 
 /*
- * XXX: status debug
+ * If you want to find the instance with (k)gdb ...
  */
+#if NDEBUG
 static struct Scsi_Host *default_instance;
+#endif
 
 /*
  * Function : int macscsi_detect(Scsi_Host_Template * tpnt)
@@ -223,7 +268,9 @@
     /* Once we support multiple 5380s (e.g. DuoDock) we'll do
        something different here */
     instance = scsi_register (tpnt, sizeof(struct NCR5380_hostdata));
+#if NDEBUG
     default_instance = instance;
+#endif
     
     if (macintosh_config->ident == MAC_MODEL_IIFX) {
 	mac_scsi_regp  = via1+0x8000;
@@ -330,49 +377,6 @@
 const char * macscsi_info (struct Scsi_Host *spnt) {
 	return "";
 }
-
-/*
- * NCR 5380 register access functions
- */
-
-/* Debug versions
-#define CTRL(p,v) (*ctrl = (v))
-
-static char macscsi_read(struct Scsi_Host *instance, int reg)
-{
-  int iobase = instance->io_port;
-  int i;
-  int *ctrl = &((struct NCR5380_hostdata *)instance->hostdata)->ctrl;
-
-  CTRL(iobase, 0);
-  i = in_8(iobase + (reg<<4));
-  CTRL(iobase, 0x40);
-
-  return i;
-}
-
-static void macscsi_write(struct Scsi_Host *instance, int reg, int value)
-{
-  int iobase = instance->io_port;
-  int *ctrl = &((struct NCR5380_hostdata *)instance->hostdata)->ctrl;
-
-  CTRL(iobase, 0);
-  out_8(value, iobase + (reg<<4));
-  CTRL(iobase, 0x40);
-}
-*/
-
-/* Fast versions */
-static __inline__ char macscsi_read(struct Scsi_Host *instance, int reg)
-{
-  return in_8(instance->io_port + (reg<<4));
-}
-
-static __inline__ void macscsi_write(struct Scsi_Host *instance, int reg, int value)
-{
-  out_8(value, instance->io_port + (reg<<4));
-}
-
 
 /* 
    Pseudo-DMA: (Ove Edlund)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
