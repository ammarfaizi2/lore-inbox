Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129696AbRBWVyH>; Fri, 23 Feb 2001 16:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129753AbRBWVx5>; Fri, 23 Feb 2001 16:53:57 -0500
Received: from ns1.qnet.fi ([194.251.131.5]:787 "EHLO qntsrv2.qnet.fi")
	by vger.kernel.org with ESMTP id <S129696AbRBWVxo>;
	Fri, 23 Feb 2001 16:53:44 -0500
Message-ID: <3A96DC2B.1C943AD3@pp.qnet.fi>
Date: Fri, 23 Feb 2001 23:54:51 +0200
From: Martin Storsjö <martin.storsjo@pp.qnet.fi>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/scsi/g_NCR5380.c, kernel 2.4.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I found out that passing boot parameters to the g_NCR5380-driver didn't
work in the 2.4.x-series. It seems like other drivers might be affected,
too. I don't know if this has been discussed before, or if I'm doing
something completely wrong, but at least this patch of mine fixed the
problem. My solution is actually a simple modification of what I found
in aha152x.c. (It also fixes a very minor problem caused by using a
compile-time parameter, which is probably almost never used.)

I'm not subscribed to the list, so I'd be thankful for being personally
contacted with follow-up on this.

// Martin



--- linux/drivers/scsi/g_NCR5380.c.orig Thu Feb 22 19:11:42 2001
+++ linux/drivers/scsi/g_NCR5380.c Fri Feb 23 23:33:38 2001
@@ -139,7 +139,7 @@
     int board; /* Use NCR53c400, Ricoh, etc. extensions ? */
 } overrides
 #ifdef GENERIC_NCR5380_OVERRIDE
-    [] __initdata = GENERIC_NCR5380_OVERRIDE
+    [] __initdata = GENERIC_NCR5380_OVERRIDE;
 #else
     [1] __initdata = {{0,},};
 #endif
@@ -911,6 +911,53 @@
 MODULE_PARM(ncr_53c400, "i");
 MODULE_PARM(ncr_53c400a, "i");
 MODULE_PARM(dtc_3181e, "i");
+
+#else
+
+static int __init do_NCR5380_setup(char *str)
+{
+        int ints[10];
+
+        get_options(str, sizeof(ints)/sizeof(int), ints);
+        generic_NCR5380_setup(str,ints);
+
+        return 1;
+}
+
+static int __init do_NCR53C400_setup(char *str)
+{
+        int ints[10];
+
+        get_options(str, sizeof(ints)/sizeof(int), ints);
+        generic_NCR53C400_setup(str,ints);
+
+        return 1;
+}
+
+static int __init do_NCR53C400A_setup(char *str)
+{
+        int ints[10];
+
+        get_options(str, sizeof(ints)/sizeof(int), ints);
+        generic_NCR53C400A_setup(str,ints);
+
+        return 1;
+}
+
+static int __init do_DTC3181E_setup(char *str)
+{
+        int ints[10];
+
+        get_options(str, sizeof(ints)/sizeof(int), ints);
+        generic_DTC3181E_setup(str,ints);
+
+        return 1;
+}
+
+__setup("ncr5380=", do_NCR5380_setup);
+__setup("ncr53c400=", do_NCR53C400_setup);
+__setup("ncr53c400a=", do_NCR53C400A_setup);
+__setup("dtc3181e=", do_DTC3181E_setup);

 #endif


