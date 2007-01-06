Return-Path: <linux-kernel-owner+w=401wt.eu-S1751365AbXAFLrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXAFLrG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 06:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbXAFLrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 06:47:06 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:46124 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbXAFLrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 06:47:05 -0500
Date: Sat, 6 Jan 2007 14:46:49 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: asynchronous memory transfer/transform api(s) (was: Re: [RFC] Heads up on a series of AIO patchsets)
Message-ID: <20070106114649.GA32265@2ka.mipt.ru>
References: <e9c3a7c20701051736i113772aby31ccb34f231633a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <e9c3a7c20701051736i113772aby31ccb34f231633a0@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 06 Jan 2007 14:46:50 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 06:36:39PM -0700, Dan Williams (dan.j.williams@intel.com) wrote:
> >My first impression is that it has too many lists :)
> >
> Ok, I think I can cut this down if I use static allocations for the
> software descriptors.

I did not say, it is bad, it is just first impression :)
I can not say if set of static descriptors is better or worse, it is up
to you to decide what is better for your hardware, since you can test
different cases.

> >Looks good, but IMHO there are steps to implement further.
> >I have not found there any kind of scheduler - what if system has two
> >async engines?
> It supports multiple engines (the iop341 has three), but it only does
> a simple round robin for load balancing.  I'll look to acrypto for
> other load balancing schemes, at the same time I am concerned about
> cpu overhead of a scheduling algorithm.

I meant it is impossible to change engine when for example operation
failed, or when one of them is faster in one type of operations, it will
not be used to select the device.

> >What if sync engine faster than async in some cases (and
> >it is indeed the case for small buffers), and should be selected that time?
> Yes I need to profile for this and make it tunable.

What about creating software copy 'driver', which can be selected from
set of other devices?

> >What if you will want to add additional transformations for some
> >devices like crypto processing or checksumming?
> >
> It would be nice to use an async_tx-style engine to handle the xor and
> GF multiply portions of a crypto algorithm, but how do we handle the
> case when an acrypto-style engine is available to handle the entire
> algorithm from end-to-end?  It seems like there would need to be a
> third layer to hide this distinction from application code, but as
> quoted below maybe a layer is not the right way to go...

Acrypto actaully is not only crypto processing engine - it can be used to
schedule any kind of operations - its plugable scheduler can select from
devices which exports full crypto operations, and any other types - like
copy and GF multiplications.

> >
> >I would just create a driver for low-level engine, and exported its
> >functionality - iop3_async_copy(), iop3_async_checksum(), 
> >iop3_async_crypto_1(),
> >iop3_async_crypto_2() and so on.
> >
> >There will be a lot of potential users of exactly that functionality,
> >but not stricly hardcoded higher layer operations like raidX.
> >
> This is the goal of the async_tx layer, it provides (currently)
> async_memcpy, async_memset, async_xor and async_xor_zero_sum.  The
> iop-adma driver exposes iop_adma_prep_dma_memcpy,
> iop_adma_prep_dma_xor etc... for async_tx to consume.

And eventually async_tx should select one of them to perform requested
operation. It should select just between devices (one of them can be
software implementation). Then each device just exports set of
operations it supports. Then async_tx can be extended to work not only
with copy operations, but any other. 
Then it can be renamed to acrypto :-)

> >More generic solution must be used to select appropriate device.
> >We had a very brief discussion about asynchronous crypto layer (acrypto)
> >and how its ideas could be used for async dma engines - user should not
> >even know how his data has been transferred - it calls async_copy(),
> >which selects appropriate device (and sync copy is just an additional
> >usual device in that case) from the list of devices, exported its
> >functionality, selection can be done in millions of different ways from
> >getting the fisrt one from the list (this is essentially how your
> >approach is implemented right now), or using special (including run-time
> >updated) heueristics (like it is done in acrypto).
> >
> async_memcpy makes an attempt at transparent fallback but currently
> assumes that an engine is always faster.

No need to fallback - it is completely wrong assumption that after we
fallback to something, it will work. What if SW fallback will work _too_
slow or will require a lot of memory, and there are no resources? It
will fail too and thus the whole operation fails, but if we would
'fallback' to another hardware device, it would be completed.

Jump right to the start - select new deivice from the set of devices,
which support requested operation, when first one has failed.

> Dan

-- 
	Evgeniy Polyakov
