Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWCBNbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWCBNbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 08:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWCBNbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 08:31:19 -0500
Received: from ns2.suse.de ([195.135.220.15]:23697 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750821AbWCBNbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 08:31:19 -0500
From: Andi Kleen <ak@suse.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Thu, 2 Mar 2006 14:33:16 +0100
User-Agent: KMail/1.9.1
Cc: Michael Monnerie <m.monnerie@zmi.at>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
References: <200603020023.21916@zmi.at> <200603021409.25989.ak@suse.de> <20060302131043.GN4329@suse.de>
In-Reply-To: <20060302131043.GN4329@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021433.17235.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - We have in-driver pending stuff, so we can just retry the operation
>   later when some of that completes.
> - We are unlucky enough that someone else holds all the resources, we
>   have nothing to wait for.

I suspect the second is more common - typically the problem seems to happen
when people have multiple devices active that need the IOMMU in parallel.

> The first case is easy, just punt and retry when some of your io
> completes. The last case requires a way to wait on the iommu as you
> describe, which the driver needs to do somewhere safe.

Also where to put the wait queue? The IOMMU code only 
sees the bus devices not the queues and I'm not sure the low level
devices would be the right place to put it because it wouldn't handle
the case of a queue having multiple devices well and in general
would probably violate the layers.

Maybe just using a global one? The situation should be rare anyways.
Would just need a way to detect this case to avoid bouncing the cache lines
of the wait queue in the normal case. Perhaps a simple global counter
would be good enough for that.

e.g. you increase the counter and then the IOMMU code just does a wakeup
on a global waitqueue every time it frees space.

Hrm one problem I guess is that you need to make sure there are no 
races between detection of the low space condition and the increasing
of the counter, but some lazy locking and rechecking might be able 
to cure that.

-Andi
