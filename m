Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163540AbWLGWds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163540AbWLGWds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163542AbWLGWds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:33:48 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:62331 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163540AbWLGWdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:33:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gTGoFeAnrRvoHaIE0BEhzLg55rMTXF419FHICM3dOQF+bH5wiAVheQ1GXTBOISWHudl5Xl+4QGKFnMrw/lc4oQ4nA2WbZ9C2mk8Iw4PLttiQKsGodO7PCNEYXHPLNQElEDgwZXKR5td7tpTZU9pp4EVYQzZkfotqjeqEGq+qXOU=
Message-ID: <5c49b0ed0612071433o3a77be20h9b19326bf6a70281@mail.gmail.com>
Date: Thu, 7 Dec 2006 14:33:46 -0800
From: "Nate Diller" <nate.diller@gmail.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [patch] speed up single bio_vec allocation
Cc: "Jens Axboe" <jens.axboe@oracle.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <000201c71a4a$0fa32280$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5c49b0ed0612071346g5bccedd5q709e5ba66808c7fc@mail.gmail.com>
	 <000201c71a4a$0fa32280$ff0da8c0@amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/06, Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> Nate Diller wrote on Thursday, December 07, 2006 1:46 PM
> > the current code is straightforward and obviously correct.  you want
> > to make the alloc/dealloc paths more complex, by special-casing for an
> > arbitrary limit of "small" I/O, AFAICT.  of *course* you can expect
> > less overhead when you're doing one large I/O vs. two small ones,
> > that's the whole reason we have all this code to try to coalesce
> > contiguous I/O, do readahead, swap page clustering, etc.  we *want*
> > more complexity if it will get us bigger I/Os.  I don't see why we
> > want more complexity to reduce the *inherent* penalty of doing smaller
> > ones.
>
> You should check out the latest proposal from Jens Axboe which treats
> all biovec size the same and stuff it along with struct bio.  I think
> it is a better approach than my first cut of special casing 1 segment
> biovec.  His patch will speed up all sized I/O.

i rather agree with his reservations on that, since we'd be making the
allocator's job harder by requesting order 1 pages for all allocations
on x86_64 large I/O patterns.  but it reduces complexity instead of
increasing it ... can you produce some benchmarks not just for your
workload but for one that triggers the order 1 case?  biovec-(256)
transfers are more common than you seem to think, and if the allocator
can't do it, that forces the bio code to fall back to 2 x biovec-128,
which, as you indicated above, would show a real penalty.

NATE
