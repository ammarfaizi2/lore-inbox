Return-Path: <linux-kernel-owner+w=401wt.eu-S1752835AbWLOQXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbWLOQXM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbWLOQWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:22:51 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:3550 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbWLOQWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:22:40 -0500
Date: Fri, 15 Dec 2006 17:22:32 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: [S390] Fix reboot hang
Message-ID: <20061215162232.GG4920@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

[S390] Fix reboot hang

We use printks after shutting down all other cpus. This is not allowed
and can lead to deadlocks. Therefore the printks have to be removed.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ipl.c |   45 +--------------------------------------------
 1 files changed, 1 insertion(+), 44 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/ipl.c linux-2.6-patched/arch/s390/kernel/ipl.c
--- linux-2.6/arch/s390/kernel/ipl.c	2006-12-15 16:55:11.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/ipl.c	2006-12-15 16:55:12.000000000 +0100
@@ -609,42 +609,12 @@ static ssize_t on_panic_store(struct sub
 static struct subsys_attribute on_panic_attr =
 		__ATTR(on_panic, 0644, on_panic_show, on_panic_store);
 
-static void print_fcp_block(struct ipl_parameter_block *fcp_block)
-{
-	printk(KERN_EMERG "wwpn:      %016llx\n",
-		(unsigned long long)fcp_block->ipl_info.fcp.wwpn);
-	printk(KERN_EMERG "lun:       %016llx\n",
-		(unsigned long long)fcp_block->ipl_info.fcp.lun);
-	printk(KERN_EMERG "bootprog:  %lld\n",
-		(unsigned long long)fcp_block->ipl_info.fcp.bootprog);
-	printk(KERN_EMERG "br_lba:    %lld\n",
-		(unsigned long long)fcp_block->ipl_info.fcp.br_lba);
-	printk(KERN_EMERG "device:    %llx\n",
-		(unsigned long long)fcp_block->ipl_info.fcp.devno);
-	printk(KERN_EMERG "opt:       %x\n", fcp_block->ipl_info.fcp.opt);
-}
-
 void do_reipl(void)
 {
 	struct ccw_dev_id devid;
 	static char buf[100];
 	char loadparm[LOADPARM_LEN + 1];
 
-	switch (reipl_type) {
-	case IPL_TYPE_CCW:
-		reipl_get_ascii_loadparm(loadparm);
-		printk(KERN_EMERG "reboot on ccw device: 0.0.%04x\n",
-			reipl_block_ccw->ipl_info.ccw.devno);
-		printk(KERN_EMERG "loadparm = '%s'\n", loadparm);
-		break;
-	case IPL_TYPE_FCP:
-		printk(KERN_EMERG "reboot on fcp device:\n");
-		print_fcp_block(reipl_block_fcp);
-		break;
-	default:
-		break;
-	}
-
 	switch (reipl_method) {
 	case IPL_METHOD_CCW_CIO:
 		devid.devno = reipl_block_ccw->ipl_info.ccw.devno;
@@ -654,6 +624,7 @@ void do_reipl(void)
 		reipl_ccw_dev(&devid);
 		break;
 	case IPL_METHOD_CCW_VM:
+		reipl_get_ascii_loadparm(loadparm);
 		if (strlen(loadparm) == 0)
 			sprintf(buf, "IPL %X",
 				reipl_block_ccw->ipl_info.ccw.devno);
@@ -683,7 +654,6 @@ void do_reipl(void)
 		diag308(DIAG308_IPL, NULL);
 		break;
 	}
-	printk(KERN_EMERG "reboot failed!\n");
 	signal_processor(smp_processor_id(), sigp_stop_and_store_status);
 }
 
@@ -692,19 +662,6 @@ static void do_dump(void)
 	struct ccw_dev_id devid;
 	static char buf[100];
 
-	switch (dump_type) {
-	case IPL_TYPE_CCW:
-		printk(KERN_EMERG "Automatic dump on ccw device: 0.0.%04x\n",
-		       dump_block_ccw->ipl_info.ccw.devno);
-		break;
-	case IPL_TYPE_FCP:
-		printk(KERN_EMERG "Automatic dump on fcp device:\n");
-		print_fcp_block(dump_block_fcp);
-		break;
-	default:
-		return;
-	}
-
 	switch (dump_method) {
 	case IPL_METHOD_CCW_CIO:
 		smp_send_stop();
