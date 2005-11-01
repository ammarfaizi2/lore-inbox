Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbVKAJIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbVKAJIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVKAJIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:08:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58408 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964984AbVKAJIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:08:05 -0500
Date: Tue, 1 Nov 2005 10:08:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: torvalds@osdl.org, acme@mandriva.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk: fix dangling pointer access in __elv_add_request
Message-ID: <20051101090857.GC26049@suse.de>
References: <20051101082349.GA17756@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051101082349.GA17756@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01 2005, Tejun Heo wrote:
> cfq's add_req_fn callback may invoke q->request_fn directly and
> depending on low-level driver used and timing, a queued request may be
> finished & deallocated before add_req_fn callback returns.  So,
> __elv_add_request must not access rq after it's passed to add_req_fn
> callback.

It's a generel problem, you may get the queue run at any time regardless
of what the io scheduler is doing. CFQ does run the queue manully
sometimes, but SCSI may do the very same thing for you as well. Given
that SCSI also shortly reenables interrupts in the ->request_fn()
handling, it's quite possible for the request to be completed.

So, as we don't hold a reference to the request, I'd say your patch
looks correct and should be applied right away.

> Jens, does generalizing queue kicking functions and disallowing
> ioscheds from directly calling q->request_fn sound like a good idea?

Yes certainly.

-- 
Jens Axboe

