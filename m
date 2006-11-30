Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031303AbWK3UHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031303AbWK3UHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031310AbWK3UHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:07:49 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:55946 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1031303AbWK3UHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:07:48 -0500
From: Jens Wilke <jens.wilke@de.ibm.com>
Organization: IBM Deutschland GmbH
To: dm-devel@redhat.com
Subject: Re: [dm-devel] [RFC][PATCH] dm-cache: block level disk cache target for device mapper
Date: Thu, 30 Nov 2006 21:07:39 +0100
User-Agent: KMail/1.9.4
Cc: "Eric Van Hensbergen" <ericvh@gmail.com>,
       Eric Van Hensbergen <ericvh@hera.kernel.org>, ming@acis.ufl.edu,
       linux-kernel@vger.kernel.org
References: <200611271826.kARIQYRi032717@hera.kernel.org> <200611301232.57966.jens.wilke@de.ibm.com> <a4e6962a0611300824qdfa43cbja783da86fe6eb5cf@mail.gmail.com>
In-Reply-To: <a4e6962a0611300824qdfa43cbja783da86fe6eb5cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611302107.40418.jens.wilke@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 November 2006 17:24, Eric Van Hensbergen wrote:
> On 11/30/06, Jens Wilke <jens.wilke@de.ibm.com> wrote:
> > On Monday 27 November 2006 19:26, Eric Van Hensbergen wrote:
> >
> > If this is intended to speed up remote disks, is it possible that the cache content
> > can be paged out on local disks in low-mem situations?
> >
> 
> The main intent was to use local disks as cache to offload centralized
> remote disks.  The logic was that most systems have local disks, if
> only for swap -- so why not use them as a cache to help offload
> centralized storage.  While the in-memory page cache works perfectly
> fine in certain situations -- we were dealing with workloads in which
> the in-memory page-cache wasn't sufficient to hold all the data.

I derived from the code that the cache is actually another block device
and not memory. Maybe you should give a little more description and
a sample 'dmsetup create' statement.

> There are also some additional possibilities we've thought through and
> have been playing with including allowing the local disk cache to be
> persistent across reboots (with varying validation schemes).

Yes, I like the idea. It would be also possible to use NV-Ram 
as write back cache, for example in notebooks, to avoid 
disk spin-ups or to improve transaction performance in
enterprise applications.

Maybe it would also make sense to prefill the cache contents
on startup with a bulk I/O request?

Comments on the code:

- The data of the write back cache should be flushed on suspend and not
  in the destructor.
- You don't keep track of I/O on the fly to the cache that is mapped
  directly in cache_hit(). How do you make sure that this I/O is completed 
  before you replace a cache block?
- The cache block index is hashed, this means the cache data blocks are not 
  clustered. I don't think you can solve this problem with a proper hash function. 
  Perhaps you should consider a (B-)Tree structure for that.

Best,

Jens
