Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVJaDw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVJaDw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVJaDw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:52:58 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:20997 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S1751329AbVJaDw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:52:57 -0500
Date: Mon, 31 Oct 2005 01:52:49 -0200
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][noop-iosched] don't reuse a freed request
Message-ID: <20051031035249.GE5632@mandriva.com>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@mandriva.com>,
	Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20051031023024.GC5632@mandriva.com> <20051031025526.GD5632@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031025526.GD5632@mandriva.com>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 31, 2005 at 12:55:26AM -0200, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Oct 31, 2005 at 12:30:24AM -0200, Arnaldo Carvalho de Melo escreveu:
> > Hi,
> > 
> > 	I'm getting the oops below when trying to use qemu with a kernel
> > built with just the noop iosched, I'm never had looked at this code before,
> > so I did a quick hack that seems enough for my case.
> > 
> > 	Ah, this is with a fairly recent git tree (today), haven't checked
> > if it is present in 2.6.14.
> 
> Further info: building with all the io schedulers and using 'elevator=cfq'
> in the kernel cmd line produces another oops, with or without my patch:
> 
> hda:<1>Unable to handle kernel paging request at virtual address c554ef60
> printing eip:
> 01b14f7
> pde = 00015067
> pte = 0554e000
> ops: 0000 [#1]
> EBUG_PAGEALLOC
> odules linked in:
> PU:    0
> IP:    0060:[<c01b14f7>]    Not tainted VLI
> FLAGS: 00000046   (2.6.14acme)
> IP is at __elv_add_request+0xe7/0x13f

Ok, some more info, hope it'll be useful: I narrowed it down to this part
of __elv_add_request:

	case ELEVATOR_INSERT_SORT:
                BUG_ON(!blk_fs_request(rq));
                rq->flags |= REQ_SORTED;
                q->elevator->ops->elevator_add_req_fn(q, rq);
                if (q->last_merge == NULL && rq_mergeable(rq))
                        q->last_merge = rq;
                break;

It seems it is not safe to touch the request (rq) after calling
elevator_add_req_fn, as the panic happens when rq_mergeable tries
to read rq->flags, or cfq_insert_request is doing something bad, well,
enough for my block layer wanderings :-)

Best Regards,

- Arnaldo

P.S. the last patches to touch this code are post 2.6.14
