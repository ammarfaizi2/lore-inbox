Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267509AbTACMgb>; Fri, 3 Jan 2003 07:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267510AbTACMgb>; Fri, 3 Jan 2003 07:36:31 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:6919 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267509AbTACMg1>; Fri, 3 Jan 2003 07:36:27 -0500
Date: Fri, 3 Jan 2003 12:44:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Cc: SZALAY Attila <sasa@pheniscidae.tvnetwork.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.54
Message-ID: <20030103124450.A28863@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
	SZALAY Attila <sasa@pheniscidae.tvnetwork.hu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030102103422.GB24116@sasa.home> <Pine.LNX.4.33L2.0301020745260.22868-100000@dragon.pdx.osdl.net> <20030103093250.GC7661@sasa.home> <20030103110418.GD7661@sasa.home> <1041596348.27024.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1041596348.27024.16.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 03, 2003 at 12:19:08PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 12:19:08PM +0000, Alan Cox wrote:
> The pcmcia scsi makefiles are broken. Its been reported repeatedly to
> the folks who broke the makefiles but nobody has fixed it. I have a hack
> for this but its versus 2.5.49/2.5.50

How about merging a proper fix instead of whining? :)


--- 1.6/drivers/scsi/pcmcia/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/drivers/scsi/pcmcia/Makefile	Fri Jan  3 13:37:48 2003
@@ -1,17 +1,5 @@
-#
-# Makefile for the Linux PCMCIA SCSI drivers.
-#
 
-obj-y		:=
-obj-m		:=
-obj-n		:=
-obj-		:=
-
-vpath %c ..
-
-CFLAGS_aha152x.o = -DPCMCIA -D__NO_VERSION__ -DAHA152X_STAT
-CFLAGS_fdomain.o = -DPCMCIA -D__NO_VERSION__
-CFLAGS_qlogicfas.o = -DPCMCIA -D__NO_VERSION__
+EXTRA_CFLAGS		+= -Idrivers/scsi
 
 # 16-bit client drivers
 obj-$(CONFIG_PCMCIA_QLOGIC)	+= qlogic_cs.o
@@ -19,6 +7,6 @@
 obj-$(CONFIG_PCMCIA_AHA152X)	+= aha152x_cs.o
 obj-$(CONFIG_PCMCIA_NINJA_SCSI)	+= nsp_cs.o
 
-aha152x_cs-objs	:= aha152x_stub.o aha152x.o
-fdomain_cs-objs	:= fdomain_stub.o fdomain.o
-qlogic_cs-objs	:= qlogic_stub.o qlogicfas.o
+aha152x_cs-objs	:= aha152x_stub.o aha152x_core.o
+fdomain_cs-objs	:= fdomain_stub.o fdomain_core.o
+qlogic_cs-objs	:= qlogic_stub.o qlogic_core.o
--- 1.7/drivers/scsi/pcmcia/aha152x_stub.c	Fri Nov 22 18:59:03 2002
+++ edited/drivers/scsi/pcmcia/aha152x_stub.c	Fri Jan  3 13:17:04 2003
@@ -45,11 +45,10 @@
 #include <scsi/scsi.h>
 #include <linux/major.h>
 #include <linux/blk.h>
-
-#include <../drivers/scsi/scsi.h>
-#include <../drivers/scsi/hosts.h>
 #include <scsi/scsi_ioctl.h>
-#include <../drivers/scsi/aha152x.h>
+
+#include "scsi.h"
+#include "hosts.h"
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
@@ -112,7 +111,8 @@
 static dev_link_t *aha152x_attach(void);
 static void aha152x_detach(dev_link_t *);
 
-static Scsi_Host_Template driver_template = AHA152X;
+#define driver_template aha152x_driver_template
+extern Scsi_Host_Template aha152x_driver_template;
 
 static dev_link_t *dev_list = NULL;
 
--- 1.7/drivers/scsi/pcmcia/fdomain_stub.c	Sun Dec  1 22:18:28 2002
+++ edited/drivers/scsi/pcmcia/fdomain_stub.c	Fri Jan  3 13:17:04 2003
@@ -42,11 +42,10 @@
 #include <scsi/scsi.h>
 #include <linux/major.h>
 #include <linux/blk.h>
-
-#include <../drivers/scsi/scsi.h>
-#include <../drivers/scsi/hosts.h>
 #include <scsi/scsi_ioctl.h>
-#include <../drivers/scsi/fdomain.h>
+
+#include "scsi.h"
+#include "hosts.h"
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
--- 1.14/drivers/scsi/pcmcia/nsp_cs.c	Fri Nov 22 18:59:03 2002
+++ edited/drivers/scsi/pcmcia/nsp_cs.c	Fri Jan  3 13:17:04 2003
@@ -50,8 +50,8 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include <../drivers/scsi/scsi.h>
-#include <../drivers/scsi/hosts.h>
+#include "scsi.h"
+#include "hosts.h"
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_ioctl.h>
--- 1.6/drivers/scsi/pcmcia/nsp_cs.h	Tue Nov  5 18:12:44 2002
+++ edited/drivers/scsi/pcmcia/nsp_cs.h	Fri Jan  3 13:17:04 2003
@@ -15,6 +15,8 @@
 #ifndef  __nsp_cs__
 #define  __nsp_cs__
 
+#include <linux/version.h>
+
 /* for debugging */
 //#define PCMCIA_DEBUG 9
 
--- 1.7/drivers/scsi/pcmcia/qlogic_stub.c	Sun Dec  1 22:45:56 2002
+++ edited/drivers/scsi/pcmcia/qlogic_stub.c	Fri Jan  3 13:17:04 2003
@@ -43,12 +43,10 @@
 #include <scsi/scsi.h>
 #include <linux/major.h>
 #include <linux/blk.h>
-
-#include <../drivers/scsi/scsi.h>
-#include <../drivers/scsi/hosts.h>
 #include <scsi/scsi_ioctl.h>
 
-#include <../drivers/scsi/qlogicfas.h>
+#include "scsi.h"
+#include "hosts.h"
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
--- /dev/null	Sat Mar 23 20:46:34 2002
+++ b/drivers/scsi/pcmcia/aha152x_core.c	Fri Jan  3 13:36:43 2003
@@ -0,0 +1,3 @@
+#define PCMCIA	1
+#define AHA152X_STAT 1
+#include "aha152x.c"
--- /dev/null	Sat Mar 23 20:46:34 2002
+++ b/drivers/scsi/pcmcia/fdomain_core.c	Fri Jan  3 13:35:40 2003
@@ -0,0 +1,2 @@
+#define PCMCIA 1
+#include "fdomain.c"
--- /dev/null	Sat Mar 23 20:46:34 2002
+++ b/drivers/scsi/pcmcia/qlogic_core.c	Fri Jan  3 13:38:21 2003
@@ -0,0 +1,2 @@
+#define PCMCIA 1
+#include "qlogicfas.c"
