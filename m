Return-Path: <linux-kernel-owner+w=401wt.eu-S1753549AbWLRI4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbWLRI4h (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 03:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbWLRI4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 03:56:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38942 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547AbWLRI4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 03:56:36 -0500
Subject: Re: [PATCH 1/2] WorkStruct: Add assign_bits() to give an
	atomic-bitops safe assignment
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, matthew@wil.cx,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612151437130.3849@woody.osdl.org>
References: <20061212201112.29817.22041.stgit@warthog.cambridge.redhat.com>
	 <20061212225443.GA25902@flint.arm.linux.org.uk>
	 <Pine.LNX.4.64.0612121726150.3535@woody.osdl.org>
	 <457F606B.70805@yahoo.com.au>
	 <Pine.LNX.4.64.0612151437130.3849@woody.osdl.org>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 08:56:24 +0000
Message-Id: <1166432184.25827.8.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-15 at 14:45 -0800, Linus Torvalds wrote:
> This uses "atomic_long_t" for the workstruct "data" field, which shares 
> the per-cpu pointer and the workstruct flag bits in one field.

This fixes drivers/connector/connector.c to cope...

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index 5e7cd45..27f377b 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -135,9 +135,8 @@ static int cn_call_callback(struct cn_msg *msg, void (*destruct_data)(void *), v
 	spin_lock_bh(&dev->cbdev->queue_lock);
 	list_for_each_entry(__cbq, &dev->cbdev->queue_list, callback_entry) {
 		if (cn_cb_equal(&__cbq->id.id, &msg->id)) {
-			if (likely(!test_bit(WORK_STRUCT_PENDING,
-					     &__cbq->work.work.management) &&
-					__cbq->data.ddata == NULL)) {
+			if (likely(!work_pending(&__cbq->work.work) &&
+			    __cbq->data.ddata == NULL)) {
 				__cbq->data.callback_priv = msg;
 
 				__cbq->data.ddata = data;

 

-- 
dwmw2

