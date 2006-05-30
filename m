Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWE3Tty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWE3Tty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWE3Tty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:49:54 -0400
Received: from mail.parknet.jp ([210.171.160.80]:52486 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932450AbWE3Ttx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:49:53 -0400
X-AuthUser: hirofumi@parknet.jp
To: Jens Axboe <axboe@suse.de>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: .17rc5 cfq slab corruption.
References: <20060527133122.GB3086@redhat.com> <20060530131728.GX4199@suse.de>
	<20060530161232.GA17218@redhat.com> <20060530164917.GB4199@suse.de>
	<20060530165649.GB17218@redhat.com> <20060530170435.GC4199@suse.de>
	<20060530184911.GD4199@suse.de> <20060530185158.GG4199@suse.de>
	<20060530191126.GJ4199@suse.de> <87slmrwbvq.fsf@duaron.myhome.or.jp>
	<20060530194211.GL4199@suse.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 31 May 2006 04:49:30 +0900
In-Reply-To: <20060530194211.GL4199@suse.de> (Jens Axboe's message of "Tue, 30 May 2006 21:42:11 +0200")
Message-ID: <87hd37uwc5.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> Yep, looks like that is missing as well. Care to send a proper patch and
> I'll shove it in, too.

Sorry.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

[PATCH] Fix missing list_del(&__cic->queue_list)

We should kill cic from cfqd->cic_list before freeing it.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 block/cfq-iosched.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN block/cfq-iosched.c~cfq-missing-list_del block/cfq-iosched.c
--- linux-2.6/block/cfq-iosched.c~cfq-missing-list_del	2006-05-31 04:42:36.000000000 +0900
+++ linux-2.6-hirofumi/block/cfq-iosched.c	2006-05-31 04:42:55.000000000 +0900
@@ -1225,6 +1225,7 @@ static void cfq_free_io_context(struct i
 	while ((n = rb_first(&ioc->cic_root)) != NULL) {
 		__cic = rb_entry(n, struct cfq_io_context, rb_node);
 		rb_erase(&__cic->rb_node, &ioc->cic_root);
+		list_del(&__cic->queue_list);
 		kmem_cache_free(cfq_ioc_pool, __cic);
 		freed++;
 	}
_
