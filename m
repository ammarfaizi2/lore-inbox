Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTEFStu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264038AbTEFStu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:49:50 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:41715 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264027AbTEFStt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:49:49 -0400
Subject: [RFC][Patch] fix for irq_affinity_write_proc v2.5
From: Keith Mannthey <kmannth@us.ibm.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 May 2003 12:03:08 -0700
Message-Id: <1052247789.16886.261.camel@dyn9-47-17-180.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  irq_affinity_write_proc currently directly calls set_ioapic_affinity
which writes to the ioapic.  This undermines the work done by kirqd by
writing a cpu mask directly to the ioapic. I propose the following patch
to tie the /proc affinity writes into the same code path as kirqd. 
Kirqd will enforce the affinity requested by the user.   

Keith Mannthey


diff -urN linux-2.5.68/arch/i386/kernel/irq.c linux-2.5.68-procfix/arch/i386/kernel/irq.c
--- linux-2.5.68/arch/i386/kernel/irq.c	Sat Apr 19 19:48:50 2003
+++ linux-2.5.68-procfix/arch/i386/kernel/irq.c	Thu May  8 13:47:38 2003
@@ -871,8 +871,11 @@
 		return -EINVAL;
 
 	irq_affinity[irq] = new_value;
-	irq_desc[irq].handler->set_affinity(irq, new_value);
-
+	if (irqbalance_disabled)
+		irq_desc[irq].handler->set_affinity(irq, new_value);
+	else
+		do_irq_balance();
+	
 	return full_count;
 }


