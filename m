Return-Path: <linux-kernel-owner+w=401wt.eu-S965167AbWL2U4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbWL2U4F (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 15:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbWL2U4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 15:56:05 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:42657 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965164AbWL2U4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 15:56:04 -0500
Message-id: <178972895412936593@wsc.cz>
In-reply-to: <26150293961999718626@wsc.cz>
Subject: [PATCH 3/4] Char: mxser_new, less loops in isr
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri, 29 Dec 2006 21:56:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, less loops in isr

Loop only 100^2 times, not 99999^2 times in isr (at most).

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 5065aa25fd624e3477d993baebbf3255a1d492fa
tree a4b05ea113ceea8b8ad1382fa3a5778473597d0f
parent cc46acb974ba967794f7b199fb65ad4abd9531b7
author Jiri Slaby <jirislaby@gmail.com> Fri, 29 Dec 2006 21:07:10 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 29 Dec 2006 21:07:10 +0059

 drivers/char/mxser_new.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 945c7e1..042d138 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -56,7 +56,7 @@
 #define MXSER_BOARDS		4	/* Max. boards */
 #define MXSER_PORTS_PER_BOARD	8	/* Max. ports per board */
 #define MXSER_PORTS		(MXSER_BOARDS * MXSER_PORTS_PER_BOARD)
-#define MXSER_ISR_PASS_LIMIT	99999L
+#define MXSER_ISR_PASS_LIMIT	100
 
 #define	MXSER_ERR_IOADDR	-1
 #define	MXSER_ERR_IRQ		-2
@@ -2222,8 +2222,7 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 	struct mxser_board *brd = NULL;
 	struct mxser_port *port;
 	int max, irqbits, bits, msr;
-	int pass_counter = 0;
-	unsigned int int_cnt;
+	unsigned int int_cnt, pass_counter = 0;
 	int handled = IRQ_NONE;
 
 	for (i = 0; i < MXSER_BOARDS; i++)
@@ -2237,7 +2236,7 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 	if (brd == NULL)
 		goto irq_stop;
 	max = brd->info->nports;
-	while (1) {
+	while (pass_counter++ < MXSER_ISR_PASS_LIMIT) {
 		irqbits = inb(brd->vector) & brd->vector_mask;
 		if (irqbits == brd->vector_mask)
 			break;
@@ -2308,8 +2307,6 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 			} while (int_cnt++ < MXSER_ISR_PASS_LIMIT);
 			spin_unlock(&port->slock);
 		}
-		if (pass_counter++ > MXSER_ISR_PASS_LIMIT)
-			break;	/* Prevent infinite loops */
 	}
 
 irq_stop:
