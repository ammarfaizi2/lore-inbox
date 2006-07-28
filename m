Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161270AbWG1UJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161270AbWG1UJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161264AbWG1UIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:08:49 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:43787 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1161270AbWG1UIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:08:19 -0400
Date: Fri, 28 Jul 2006 16:08:05 -0400
From: nhorman@tuxdriver.com
Message-Id: <200607282008.k6SK85lh009691@ra.tuxdriver.com>
To: fpavlic@de.ibm.com, kernel-janitors@osdl.org, linux-kernel@vger.kernel.org,
       nhorman@tuxdriver.com
Subject: [KJ] audit return code handling for kernel_thread [9/11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Audit/Cleanup of kernel_thread calls, specifically checking of return codes.
    Problems seemed to fall into 3 main categories:
    
    1) callers of kernel_thread were inconsistent about meaning of a zero return
    code.  Some callers considered a zero return code to mean success, others took
    it to mean failure.  a zero return code, while not actually possible in the
    current implementation, should be considered a success (pid 0 is/should be
    valid). fixed all callers to treat zero return as success
    
    2) caller of kernel_thread saved return code of kernel_thread for later use
    without ever checking its value.  Callers who did this tended to assume a
    non-zero return was success, and would often wait for a completion queue to be
    woken up, implying that an error (negative return code) from kernel_thread could
    lead to deadlock.  Repaired by checking return code at call time, and setting
    saved return code to zero in the event of an error.
    
    3) callers of kernel_thread never bothered to check the return code at all.
    This can lead to seemingly unrelated errors later in execution.  Fixed by
    checking return code at call time and printing a warning message on failure.

Regards
Neil
    
Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 drivers/s390/net/qeth_main.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -1048,11 +1048,14 @@ qeth_start_kernel_thread(struct qeth_car
 		return;
 
 	if (qeth_do_start_thread(card, QETH_SET_IP_THREAD))
-		kernel_thread(qeth_register_ip_addresses, (void *)card,SIGCHLD);
+		if (kernel_thread(qeth_register_ip_addresses, (void *)card,SIGCHLD) < 0)
+			printk(KERN_WARNING "Could not start qeth register thread\n");
 	if (qeth_do_start_thread(card, QETH_SET_PROMISC_MODE_THREAD))
-		kernel_thread(qeth_set_promisc_mode, (void *)card, SIGCHLD);
+		if (kernel_thread(qeth_set_promisc_mode, (void *)card, SIGCHLD) < 0)
+			printk(KERN_WARNING "Could not start qeth prmisc thread\n");
 	if (qeth_do_start_thread(card, QETH_RECOVER_THREAD))
-		kernel_thread(qeth_recover, (void *) card, SIGCHLD);
+		if (kernel_thread(qeth_recover, (void *) card, SIGCHLD) < 0)
+			printk(KERN_WARNING "Could not start qeth recovery thread\n");
 }
 
 
