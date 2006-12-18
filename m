Return-Path: <linux-kernel-owner+w=401wt.eu-S1753799AbWLRK5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbWLRK5N (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbWLRK5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:57:12 -0500
Received: from amsfep16-int.chello.nl ([62.179.120.11]:49065 "EHLO
	amsfep16-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbWLRK5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:57:11 -0500
Subject: Re: 2.6.20-rc1-git4: drivers/connector/connector.c doesn't build
	due to work_struct changes
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0612161448p450a0e16l5ed0f4f87999d0a5@mail.gmail.com>
References: <5a4c581d0612161448p450a0e16l5ed0f4f87999d0a5@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 11:56:26 +0100
Message-Id: <1166439386.10372.61.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-16 at 23:48 +0100, Alessandro Suardi wrote:
>   CC [M]  drivers/char/hangcheck-timer.o
>   CC      drivers/clocksource/acpi_pm.o
>   LD      drivers/clocksource/built-in.o
>   CC [M]  drivers/connector/cn_queue.o
>   CC [M]  drivers/connector/connector.o
> drivers/connector/connector.c: In function 'cn_call_callback':
> drivers/connector/connector.c:138: error: 'struct work_struct' has no
> member named 'management'
> drivers/connector/connector.c:138: error: 'struct work_struct' has no
> member named 'management'
> make[2]: *** [drivers/connector/connector.o] Error 1
> make[1]: *** [drivers/connector] Error 2
> make: *** [drivers] Error 2


Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---

diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index 5e7cd45..2b8893b 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -135,8 +135,7 @@ static int cn_call_callback(struct cn_ms
 	spin_lock_bh(&dev->cbdev->queue_lock);
 	list_for_each_entry(__cbq, &dev->cbdev->queue_list, callback_entry) {
 		if (cn_cb_equal(&__cbq->id.id, &msg->id)) {
-			if (likely(!test_bit(WORK_STRUCT_PENDING,
-					     &__cbq->work.work.management) &&
+			if (likely(!delayed_work_pending(&__cbq->work) &&
 					__cbq->data.ddata == NULL)) {
 				__cbq->data.callback_priv = msg;
 


