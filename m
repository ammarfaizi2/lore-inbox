Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTJSVUl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 17:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTJSVUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 17:20:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:42968 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262251AbTJSVUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 17:20:39 -0400
Date: Sun, 19 Oct 2003 14:20:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: axboe@suse.de, piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8, DEBUG_SLAB, oops in as_latter_request()
Message-Id: <20031019142042.2f41eb68.akpm@osdl.org>
In-Reply-To: <m2ismlovep.fsf@p4.localdomain>
References: <m2ismlovep.fsf@p4.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> I was running 2.6.0-test8 compiled with CONFIG_DEBUG_SLAB=y. When
>  testing the CDRW packet writing driver, I got an oops in
>  as_latter_request. (Full oops at the end of this message.) It is
>  repeatable and happens because arq->rb_node.rb_right is uninitialized.

deadline seems to have the same problem.

We may as well squish this with the big hammer?

 drivers/block/as-iosched.c       |    1 +
 drivers/block/deadline-iosched.c |    1 +
 2 files changed, 2 insertions(+)

diff -puN drivers/block/as-iosched.c~iosched-oops-fixes drivers/block/as-iosched.c
--- 25/drivers/block/as-iosched.c~iosched-oops-fixes	2003-10-19 14:17:39.000000000 -0700
+++ 25-akpm/drivers/block/as-iosched.c	2003-10-19 14:18:09.000000000 -0700
@@ -1718,6 +1718,7 @@ static int as_set_request(request_queue_
 	struct as_rq *arq = mempool_alloc(ad->arq_pool, gfp_mask);
 
 	if (arq) {
+		memset(arq, 0, sizeof(*arq));
 		RB_CLEAR(&arq->rb_node);
 		arq->request = rq;
 		arq->state = AS_RQ_NEW;
diff -puN drivers/block/deadline-iosched.c~iosched-oops-fixes drivers/block/deadline-iosched.c
--- 25/drivers/block/deadline-iosched.c~iosched-oops-fixes	2003-10-19 14:17:39.000000000 -0700
+++ 25-akpm/drivers/block/deadline-iosched.c	2003-10-19 14:17:39.000000000 -0700
@@ -775,6 +775,7 @@ deadline_set_request(request_queue_t *q,
 
 	drq = mempool_alloc(dd->drq_pool, gfp_mask);
 	if (drq) {
+		memset(drq, 0, sizeof(*drq));
 		RB_CLEAR(&drq->rb_node);
 		drq->request = rq;
 

_

