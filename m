Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264661AbTE1KqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 06:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbTE1KqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 06:46:12 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:6437 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264661AbTE1KqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 06:46:11 -0400
Date: Wed, 28 May 2003 03:59:39 -0700
From: Andrew Morton <akpm@digeo.com>
To: Jens Axboe <axboe@suse.de>
Cc: kernel@kolivas.org, matthias.mueller@rz.uni-karlsruhe.de,
       m.c.p@wolk-project.de, manish@storadinc.com, andrea@suse.de,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-Id: <20030528035939.72a973b0.akpm@digeo.com>
In-Reply-To: <20030528105029.GS845@suse.de>
References: <3ED2DE86.2070406@storadinc.com>
	<20030528032315.679e77b0.akpm@digeo.com>
	<20030528102529.GQ845@suse.de>
	<200305282048.58032.kernel@kolivas.org>
	<20030528105029.GS845@suse.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 10:59:27.0094 (UTC) FILETIME=[34B7E960:01C32508]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> > THIS IS IT! The last one. No pauses writing a 2Gb file now unless I do a read 
>  > midstream.
> 
>  Cool, especially since we can easily apply this to -rc5 without any
>  worries. Marcelo, if you please...?
> 
>  ===== drivers/block/ll_rw_blk.c 1.44 vs edited =====
>  --- 1.44/drivers/block/ll_rw_blk.c	Mon Apr 14 12:53:03 2003
>  +++ edited/drivers/block/ll_rw_blk.c	Wed May 28 12:49:30 2003
>  @@ -829,8 +829,7 @@
>   	 */
>   	if (q) {
>   		list_add(&req->queue, &q->rq[rw].free);
>  -		if (++q->rq[rw].count >= q->batch_requests &&
>  -				waitqueue_active(&q->wait_for_requests[rw]))
>  +		if (++q->rq[rw].count >= q->batch_requests)
>   			wake_up(&q->wait_for_requests[rw]);
>   	}
>   }

umm, I'd like confirmation of that.

The waitqueue_active() test is wrong because of a missing barrier, but only
on SMP.  And if it does make a mistake it will surely correct itself when the
next request is put back. (That's why I left it there...)

More testing, please.
