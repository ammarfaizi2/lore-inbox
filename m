Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270745AbTGNT4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270755AbTGNT4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:56:07 -0400
Received: from 69-55-72-150.ppp.netsville.net ([69.55.72.150]:20434 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S270745AbTGNTzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:55:48 -0400
Subject: Re: RFC on io-stalls patch
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
In-Reply-To: <20030714195138.GX833@suse.de>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva>
	 <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com>
	 <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com>
	 <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random>
	 <20030714054918.GD843@suse.de>
	 <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva>
	 <20030714131206.GJ833@suse.de>  <20030714195138.GX833@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1058213348.13313.274.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 14 Jul 2003 16:09:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-14 at 15:51, Jens Axboe wrote:

> Some initial results with the attached patch, I'll try and do some more
> fine grained tomorrow. Base kernel was 2.4.22-pre5 (obviously), drive
> tested is a SCSI drive (on aic7xxx, tcq fixed at 4), fs is ext3. I would
> have done ide testing actually, but the drive in that machine appears to
> have gone dead. I'll pop in a new one tomorrow and test on that too.
> 

Thanks Jens, the results so far are very interesting (although I'm
curious to hear how 2.4.21 did).

> --- 1.47/drivers/block/ll_rw_blk.c	Fri Jul 11 10:30:54 2003
> +++ edited/drivers/block/ll_rw_blk.c	Mon Jul 14 20:42:36 2003
> @@ -549,10 +549,12 @@
>  static struct request *get_request(request_queue_t *q, int rw)
>  {
>  	struct request *rq = NULL;
> -	struct request_list *rl;
> +	struct request_list *rl = &q->rq;
>  
> -	rl = &q->rq;
> -	if (!list_empty(&rl->free) && !blk_oversized_queue(q)) {
> +	if ((rw == WRITE) && (blk_oversized_queue(q) || (rl->count < 4)))
> +		return NULL;
> +
> +	if (!list_empty(&rl->free)) {
>  		rq = blkdev_free_rq(&rl->free);
>  		list_del(&rq->queue);
>  		rl->count--;
> @@ -947,7 +949,7 @@

Could I talk you into trying a form of this patch that honors
blk_oversized_queue for everything except the BH_sync requests?

-chris


