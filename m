Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUAAUJC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264964AbUAAUHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:07:22 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.14]:43808 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S264870AbUAAUCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:02:01 -0500
Date: Thu, 1 Jan 2004 21:01:59 +0100
Message-Id: <200401012001.i01K1x1m031799@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 360] Mac SCSI
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac SCSI fixes (from Matthias Urlichs):
  - Inline functions need to be defined before being used.
  - out_8() takes an address and a value, not the other way round.

--- linux-2.6.0/drivers/scsi/mac_scsi.c	Tue Jul 29 18:19:10 2003
+++ linux-m68k-2.6.0/drivers/scsi/mac_scsi.c	Mon Oct 13 14:15:39 2003
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
