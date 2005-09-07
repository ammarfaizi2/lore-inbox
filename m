Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVIGSLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVIGSLm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVIGSLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:11:42 -0400
Received: from mail.cs.umn.edu ([128.101.36.202]:42919 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S932091AbVIGSLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:11:41 -0400
Date: Wed, 7 Sep 2005 13:11:33 -0500
From: Dave C Boutcher <sleddog@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [Patch 3/4] [RFC] Resend SCSI target for IBM Power5 LPAR
Message-ID: <20050907181133.GD12904@cs.umn.edu>
Reply-To: boutcher@cs.umn.edu
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20050907180333.GA12904@cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907180333.GA12904@cs.umn.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Config stuff

diff -uNr linux-2.6.13-rc7/drivers/scsi/ibmvscsi/ibmvscsi.h linux-2.6.13-rc7-ibmvscsis/drivers/scsi/ibmvscsi/ibmvscsi.h
--- linux-2.6.13-rc7/drivers/scsi/ibmvscsi/ibmvscsi.h	2005-09-06 15:56:35.231844303 -0500
+++ linux-2.6.13-rc7-ibmvscsis/drivers/scsi/ibmvscsi/ibmvscsi.h	2005-09-06 16:02:41.279485577 -0500
@@ -33,6 +33,7 @@
 #include <linux/list.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
+#include <scsi/scsi_cmnd.h>
 #include "viosrp.h"
 
 struct scsi_cmnd;
diff -uNr linux-2.6.13-rc7/drivers/scsi/ibmvscsi/Makefile linux-2.6.13-rc7-ibmvscsis/drivers/scsi/ibmvscsi/Makefile
--- linux-2.6.13-rc7/drivers/scsi/ibmvscsi/Makefile	2004-10-18 16:54:37.000000000 -0500
+++ linux-2.6.13-rc7-ibmvscsis/drivers/scsi/ibmvscsi/Makefile	2005-09-06 16:02:41.279485577 -0500
@@ -3,3 +3,5 @@
 ibmvscsic-y			+= ibmvscsi.o
 ibmvscsic-$(CONFIG_PPC_ISERIES)	+= iseries_vscsi.o 
 ibmvscsic-$(CONFIG_PPC_PSERIES)	+= rpa_vscsi.o 
+
+obj-$(CONFIG_SCSI_IBMVSCSIS)    += ibmvscsis.o
diff -uNr linux-2.6.13-rc7/drivers/scsi/ibmvscsi/srp.h linux-2.6.13-rc7-ibmvscsis/drivers/scsi/ibmvscsi/srp.h
--- linux-2.6.13-rc7/drivers/scsi/ibmvscsi/srp.h	2005-09-06 15:57:27.855492658 -0500
+++ linux-2.6.13-rc7-ibmvscsis/drivers/scsi/ibmvscsi/srp.h	2005-09-06 16:02:41.297483076 -0500
@@ -53,6 +53,13 @@
 	SRP_INDIRECT_BUFFER = 0x02
 };
 
+enum srp_task_attributes {
+	SRP_SIMPLE_TASK = 0,
+	SRP_HEAD_TASK = 1,
+	SRP_ORDERED_TASK = 2,
+	SRP_ACA_TASK = 4
+};
+
 struct memory_descriptor {
 	u64 virtual_address;
 	u32 memory_handle;
@@ -174,7 +181,7 @@
 	u32 data_out_residual_count;
 	u32 sense_data_list_length;
 	u32 response_data_list_length;
-	u8 sense_and_response_data[18];
+	u8 sense_and_response_data[SCSI_SENSE_BUFFERSIZE];
 };
 
 struct srp_cred_req {
diff -uNr linux-2.6.13-rc7/drivers/scsi/Kconfig linux-2.6.13-rc7-ibmvscsis/drivers/scsi/Kconfig
--- linux-2.6.13-rc7/drivers/scsi/Kconfig	2005-09-06 15:57:27.674385086 -0500
+++ linux-2.6.13-rc7-ibmvscsis/drivers/scsi/Kconfig	2005-09-06 16:02:41.278485716 -0500
@@ -831,6 +831,16 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called ibmvscsic.
 
+config SCSI_IBMVSCSIS
+	tristate "IBM Virtual SCSI Server support"
+	depends on PPC_PSERIES
+	help
+	  This is the IBM Virtual SCSI Server which can be configured using
+	  the ppc64-utils package available at 
+	  http://techsupport.services.ibm.com/server/lopdiags
+	  To compile this driver as a module, choose M here: the
+	  module will be called ibmvscsis.
+
 config SCSI_INITIO
 	tristate "Initio 9100U(W) support"
 	depends on PCI && SCSI
