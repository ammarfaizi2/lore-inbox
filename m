Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWDZN6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWDZN6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWDZN6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:58:04 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:54838
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932451AbWDZN6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:58:03 -0400
Message-Id: <444F98B5.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 26 Apr 2006 15:58:45 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <mpt_linux_developer@lsil.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] mpt_interrupt() should return IRQ_NONE when
	appropriate
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The way mpt_interrupt() was coded, it was impossible for the unhandled
interrupt detection logic to ever trigger. All interrupt handlers should
return IRQ_NONE when they have nothing to do.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/drivers/message/fusion/mptbase.c
2.6.17-rc2-mpt_interrupt/drivers/message/fusion/mptbase.c
--- /home/jbeulich/tmp/linux-2.6.17-rc2/drivers/message/fusion/mptbase.c	2006-04-26 11:50:44.000000000 +0200
+++ 2.6.17-rc2-mpt_interrupt/drivers/message/fusion/mptbase.c	2006-04-25 15:04:48.000000000 +0200
@@ -372,20 +372,21 @@ static irqreturn_t
 mpt_interrupt(int irq, void *bus_id, struct pt_regs *r)
 {
 	MPT_ADAPTER *ioc = bus_id;
-	u32 pa;
+	u32 pa = CHIPREG_READ32_dmasync(&ioc->chip->ReplyFifo);
+
+	if (pa == 0xFFFFFFFF)
+		return IRQ_NONE;
 
 	/*
 	 *  Drain the reply FIFO!
 	 */
-	while (1) {
-		pa = CHIPREG_READ32_dmasync(&ioc->chip->ReplyFifo);
-		if (pa == 0xFFFFFFFF)
-			return IRQ_HANDLED;
-		else if (pa & MPI_ADDRESS_REPLY_A_BIT)
+	do {
+		if (pa & MPI_ADDRESS_REPLY_A_BIT)
 			mpt_reply(ioc, pa);
 		else
 			mpt_turbo_reply(ioc, pa);
-	}
+		pa = CHIPREG_READ32_dmasync(&ioc->chip->ReplyFifo);
+	} while (pa != 0xFFFFFFFF);
 
 	return IRQ_HANDLED;
 }


