Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135616AbRDSKxO>; Thu, 19 Apr 2001 06:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135615AbRDSKxE>; Thu, 19 Apr 2001 06:53:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30981 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135616AbRDSKwr>;
	Thu, 19 Apr 2001 06:52:47 -0400
Date: Thu, 19 Apr 2001 12:51:40 +0200
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: block devices don't work without plugging in 2.4.3
Message-ID: <20010419125140.M16822@suse.de>
In-Reply-To: <200104191039.f3JAdvq15198@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104191039.f3JAdvq15198@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Thu, Apr 19, 2001 at 12:39:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19 2001, Peter T. Breuer wrote:
> Sorry to repeat .. I didn't see this go out on the list and I haven't
> had any reply. So let's ask again. Is this a new coding error in ll_rw_blk?
> 
>  -----------------
> 
> The following has been lost from __make_request() in ll_rw_blk.c since
> 2.4.2 (incl):
> 
>  out:
> -       if (!q->plugged)
> -               (q->request_fn)(q);
>         if (freereq)
> 
> The result is that a block device that doesn't do plugging doesn't
> work.
> 
> If it has called blk_queue_pluggable() to register a no-op plug_fn,
> then q->plugged will never be set (it's the duty of the plug_fn), and
> the devices registered request function will never be called.
> 
> This behaviour is distinct from 2.4.0, where registering a no-op
> plug_fn made things work fine.
> 
> Is this a coding oversight?

Check the archives, I replied to this days ago. But since I'm taking the
subject up anyway, let me expand on it a bit further.

Not using plugging is gone, blk_queue_pluggable has been removed from
the current 2.4.4-pre series if you check that. The main reason for
doing this, is that there are generally no reasons for _not_ using
plugging in the 2.4 series kernels. In 2.2 and previous, not using the
builtin plugging was generally done to disable request merging. In 2.4,
the queues have good control over what happens there with the
back/front/request merging functions -- so drivers can just use that.

Besides, the above hunk was removed because it is wrong. For devices
using plugging, we would re-call the request_fn while the device was
already active and serving requests. Not only is this a performance hit
we don't need to take, it also gave problems on some drivers.

-- 
Jens Axboe

