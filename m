Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUCDAue (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUCDAue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:50:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:48038 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261369AbUCDAub convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:50:31 -0500
Date: Wed, 3 Mar 2004 16:52:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm2
Message-Id: <20040303165229.131b7601.akpm@osdl.org>
In-Reply-To: <1078351164.17019.57.camel@telecentrolivre>
References: <20040302201536.52c4e467.akpm@osdl.org>
	<1078351164.17019.57.camel@telecentrolivre>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br> wrote:
>
> Em Qua, 2004-03-03 às 01:15, Andrew Morton escreveu:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/
> 
> I got this:
> 
> Unable to handle kernel paging request at virtual address c1d61f70
> printing eip:
> c0211f8f
> *pde = 00006063
> *pte = 01d61000
> Oops: 0000 [#1]
> DEBUG_PAGEALLOC
> CPU:    0
> EIP:    0060:[__make_request+671/1184]    Not tainted VLI
> EFLAGS: 00010093
> EIP is at __make_request+0x29f/0x4a0

hm, there's a possibility of indirection through an uninitialised variable
there.

--- 25/drivers/block/ll_rw_blk.c~blk-unplug-when-max-request-queued-fix	Wed Mar  3 16:03:01 2004
+++ 25-akpm/drivers/block/ll_rw_blk.c	Wed Mar  3 16:03:32 2004
@@ -2004,7 +2004,8 @@ EXPORT_SYMBOL(__blk_attempt_remerge);
 
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
-	struct request *req, *freereq = NULL;
+	struct request *req = NULL;
+	struct request *freereq = NULL;
 	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, ra;
 	sector_t sector;
 
@@ -2154,7 +2155,7 @@ out:
 		int nr_queued = q->rq.count[READ] + q->rq.count[WRITE];
 
 		if (nr_queued == q->unplug_thresh ||
-				req->nr_sectors == q->max_sectors)
+				(req && req->nr_sectors == q->max_sectors))
 			__generic_unplug_device(q);
 	}
 	spin_unlock_irq(q->queue_lock);

_

