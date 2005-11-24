Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbVKXMVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbVKXMVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 07:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbVKXMVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 07:21:36 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:21649 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030383AbVKXMVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 07:21:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZKDR5QFJEVI5Rhtnoogp6a/f8L150Ka+iSoNx+mn8YiZ1jFck8sBafFxjuLVmgHDeZCnHEyCcBFFaSPQjI7F2u9MmKRHnf5jl+N67wh878mQXTqtBCMIaqCWbqp5stAvpes/XeLodwmMzrY3RiV9jreTARELwOjxkIzHK/wtm94=
Message-ID: <4385B047.8020707@gmail.com>
Date: Thu, 24 Nov 2005 21:21:27 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 09/10] blk: add FUA support
 to IDE
References: <20051117153509.B89B4777@htj.dyndns.org>	 <20051117153509.5A77ED53@htj.dyndns.org>	 <58cb370e0511171239i16e0aaffr237ef7af68ece946@mail.gmail.com>	 <437DF271.6050702@gmail.com> <58cb370e0511180817p48602e3ap6d3ef49b842e8a00@mail.gmail.com> <4385AAFB.5070605@gmail.com>
In-Reply-To: <4385AAFB.5070605@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops, I was delusional again.

Tejun Heo wrote:
> 
> Well, this one is quite a pain in the ass.
> 
> I'm not very fond of ->rq_select_barrier() approach for the following 
> reasons.
> 
> * That removes possibility of correct synchronization.  With 
> blk_queue_ordered() approach, we can later add 
> blk_queue_[un]lock_ordered() to achieve correct synchronization if that 
> becomes necessary, but with ->rq_select_barrier() approach, the 
> low-level driver ends up having less control over what's gonna happen when.

Of course, we can do the same lock/unlock dance with 
->rq_select_barrier() approach.  I wasn't thinking straight.  Forget 
this rationale.

> 
> * Changing ordered mode is not supposed to be a frequent operation and 
> the blk_queue_ordered() interface makes that explicit.
> 
> So, I added ide_driver_t->protocol_changed() callback which gets called 
> whenever dma/multimode changes occur.  Unfortunately, dma/multmode 
> changes can be committed with or without context, and with or without 
> queue lock.  As blk_queue_ordered uses the queue lock for 
> synchronization, this becomes issue.
> 
> I tried to distinguish places where the changes occur while queue lock 
> is held from the other.  Not only was it highly error-prone, it couldn't 
> be done without modifying/auditing all low-level drivers as some drivers 
> (cs5520) use the same function which touches dma setting 
> (cs5520_tune_chipset) from both ->speedproc (called with queuelock) and 
> ->ide_dma_check (called without queuelock).
> 
> One alternative I'm thinking of is using a workqueue to call 
> blk_queue_ordered, such that we don't have to guess whether or not we're 
> called with queuelock held.  Unfortunately, this will give us a small 
> window where wrong barrier requests can hit the drive.

One thing I wanna add here is that using ->rq_select_barrier() would 
have similar race window.  The race windows is just hidden there in the 
request queue.

> 
> Bartlomiej, any ideas?
> 
> Jens, as this one seems to need some time to settle, I'm gonna post 
> updated patchset for post-2.6.15 without ide-fua patch, so that the 
> other stuff can be pushed into -mm.  I think we can live without ide-fua 
> for a while.  :-)
> 
> Thanks.
> 


-- 
tejun
