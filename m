Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287516AbSA0CXT>; Sat, 26 Jan 2002 21:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287518AbSA0CXG>; Sat, 26 Jan 2002 21:23:06 -0500
Received: from gear.torque.net ([204.138.244.1]:6150 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S287516AbSA0CWu>;
	Sat, 26 Jan 2002 21:22:50 -0500
Message-ID: <3C53643E.47EDB3C2@torque.net>
Date: Sat, 26 Jan 2002 21:21:50 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andi Kleen <ak@suse.de>
Subject: [PATCH] sg in lk 2.5.3-pre5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In pre5 the sg driver tries to set up both address
and page+offset in scatterlist entries. Unfortunately
asm-i386/pci.h's pci_map_sg() contains this check:

                if (sg[i].address && sg[i].page)
                        BUG();

which kills that strategy with the sym53c8xx driver.
The sooner we get rid of address in struct scatterlist
the better ... the address,page+offset duality is a mess. 
Strange that Andi Kleen had problems compiling ide-scsi, 
it compiled and worked on my UP and SMP machines (AMD and
dual Celeron respectively).

Sg patch (which has been already sent to Jens) follows.

Doug Gilbert

--- linux/drivers/scsi/sg.c     Thu Jan 24 18:45:01 2002
+++ linux/drivers/scsi/sg.c3523 Thu Jan 24 20:53:28 2002
@@ -19,7 +19,7 @@
  */
 #include <linux/config.h>
 #ifdef CONFIG_PROC_FS
- static char sg_version_str[] = "Version: 3.5.23 (20020103)";
+ static char sg_version_str[] = "Version: 3.5.23 (20020124)";
 #endif
  static int sg_version_num = 30523; /* 2 digits for each component */
 /*
@@ -76,7 +76,7 @@
 #include <linux/version.h>
 #endif /* LINUX_VERSION_CODE */

-#define SG_STILL_HAVE_ADDRESS_IN_SCATTERLIST
+/* #define SG_STILL_HAVE_ADDRESS_IN_SCATTERLIST */

 #define SG_ALLOW_DIO_DEF 0
 #define SG_ALLOW_DIO_CODE      /* compile out be commenting this define */
