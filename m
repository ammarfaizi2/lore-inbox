Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135634AbRDSLzN>; Thu, 19 Apr 2001 07:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135635AbRDSLzD>; Thu, 19 Apr 2001 07:55:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3590 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135634AbRDSLyv>;
	Thu, 19 Apr 2001 07:54:51 -0400
Date: Thu, 19 Apr 2001 13:54:17 +0200
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: block devices don't work without plugging in 2.4.3
Message-ID: <20010419135417.Q16822@suse.de>
In-Reply-To: <20010419125140.M16822@suse.de> <200104191123.f3JBNfM17858@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104191123.f3JBNfM17858@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Thu, Apr 19, 2001 at 01:23:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19 2001, Peter T. Breuer wrote:
> > Besides, the above hunk was removed because it is wrong. For devices
> > using plugging, we would re-call the request_fn while the device was
> > already active and serving requests. Not only is this a performance hit
> 
> Not sure about that ...

It _is_ wrong. The code was correct for devices not using plugging, they
want request_fn to be called on each request add. However, for a
plugging driver in a !q->plugged state it was wrong.

> > we don't need to take, it also gave problems on some drivers.
> 
> Well, I know scsi used to be treating the first element while still on
> the queue, but presumably you are not referring to that.

Not so, IDE does this. And btw, this is still assumed the default
behaviour unless explicitly disabled, for data protection reasons. SCSI
always peals the request off the queue before starting processing.

> So the consensus is that I should enable plugging while the plugging
> function is still here and do nothing when it goes? I must say I don't
> think it should really "go", since that means I have to add a no-op
> macro to replace it, and I don't like #ifdefs. 

The moral would be that you should never do anything. You didn't enable
plugging with blk_queue_pluggable, only disabled it by using a noop
plug.

> BTW, I don't need request merging (and therefore don't need plugging)
> because requests eventually go out over the net. Nevertheless, I have
> always been interested in seeing the difference it could cause. I

Plugging will really not hurt you. If you really don't want plugging and
don't care for merging, then using a request_fn is the wrong approach
anyway. In that case, you simply want to use a make_request_fn style
request handling.

-- 
Jens Axboe

