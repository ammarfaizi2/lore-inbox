Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbVJQOiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbVJQOiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 10:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVJQOiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 10:38:17 -0400
Received: from mail.cs.umn.edu ([128.101.36.202]:57786 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S1751385AbVJQOh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 10:37:58 -0400
Date: Mon, 17 Oct 2005 09:37:56 -0500
From: Dave Boutcher <sleddog@us.ibm.com>
To: linux-scsi@vger.kernel.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ibmvscsis scsi target config and include changes
Message-ID: <20051017143756.GD9992@cs.umn.edu>
Mail-Followup-To: linux-scsi@vger.kernel.org,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <20051017020534.GA29968@hound.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017143644.GA9992@cs.umn.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ibmvscsis config file include file changes

Signed-off-by: Dave Boutcher <boutcher@us.ibm.com>
Signed-off-by: Santiago Leon <santil@us.ibm.com>
Signed-off-by: Linda Xie <lxie@us.ibm.com>

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
