Return-Path: <linux-kernel-owner+w=401wt.eu-S932953AbWLSVdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932953AbWLSVdr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932982AbWLSVdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:33:47 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46503 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932957AbWLSVdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:33:46 -0500
Date: Tue, 19 Dec 2006 22:31:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] workqueue: fix drivers/connector/connector.c
Message-ID: <20061219213134.GA16619@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] workqueue: fix drivers/connector/connector.c
From: Ingo Molnar <mingo@elte.hu>

commit c4028958b6ecad064b1a6303a6a5906d4fe48d73 did an incorrect 
conversion of the work-pending check in the connector device (which 
device is enabled in the -rt kernel rpm) - fix this by using 
work_pending().

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/connector/connector.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux/drivers/connector/connector.c
===================================================================
--- linux.orig/drivers/connector/connector.c
+++ linux/drivers/connector/connector.c
@@ -135,8 +135,7 @@ static int cn_call_callback(struct cn_ms
 	spin_lock_bh(&dev->cbdev->queue_lock);
 	list_for_each_entry(__cbq, &dev->cbdev->queue_list, callback_entry) {
 		if (cn_cb_equal(&__cbq->id.id, &msg->id)) {
-			if (likely(!test_bit(WORK_STRUCT_PENDING,
-					     &__cbq->work.work.management) &&
+			if (likely(!work_pending(&__cbq->work.work) &&
 					__cbq->data.ddata == NULL)) {
 				__cbq->data.callback_priv = msg;
 
