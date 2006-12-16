Return-Path: <linux-kernel-owner+w=401wt.eu-S1030535AbWLPBd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030535AbWLPBd1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 20:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030538AbWLPBc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 20:32:56 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:38869 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030535AbWLPBcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 20:32:54 -0500
Message-id: <2880031291415520798@wsc.cz>
Subject: [PATCH 1/5] Char: isicom, fix locking in isr
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat, 16 Dec 2006 02:09:44 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, fix locking in isr

2 spin_unlocks are omitted in the interrupt handler. Put them there to fix
up deadlocking on UP.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit f2d37e8d3de070f8cda48a454f7b991d29b310be
tree 23027dcdc3215fbb488577edb9610322956edb0b
parent 5df5a993999b94d728cedfa669eba2b0b58e16d7
author Jiri Slaby <jirislaby@gmail.com> Wed, 13 Dec 2006 23:10:48 +0100
committer Jiri Slaby <jirislaby@gmail.com> Fri, 15 Dec 2006 20:29:34 +0059

 drivers/char/isicom.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 0362740..836e967 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -563,6 +563,7 @@ static irqreturn_t isicom_interrupt(int irq, void *dev_id)
 	port = card->ports + channel;
 	if (!(port->flags & ASYNC_INITIALIZED)) {
 		outw(0x0000, base+0x04); /* enable interrupts */
+		spin_unlock(&card->card_lock);
 		return IRQ_HANDLED;
 	}
 
@@ -677,6 +678,7 @@ static irqreturn_t isicom_interrupt(int irq, void *dev_id)
 		tty_flip_buffer_push(tty);
 	}
 	outw(0x0000, base+0x04); /* enable interrupts */
+	spin_unlock(&card->card_lock);
 
 	return IRQ_HANDLED;
 }
