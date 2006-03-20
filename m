Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965836AbWCTQpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965836AbWCTQpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWCTQpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:45:32 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:23501 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965836AbWCTQpb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:45:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jvfiwQ91Q5EiKlf2+cc+Q41SLxEL1hpcokN46oJAIZtyXWewEHaoiTkScfWHwlOBoq6TasWeOmtYgG8cfYCVTnihyh5E/fnynXm10EHo4Au0sVddI66dTlHV8isrHq0lbsJQLjutNJoZ6mfDjuNyavWb2U9GbIhsm10YndxrfXs=
Message-ID: <661de9470603200845r6c06ae46tc49be9559c5bfc77@mail.gmail.com>
Date: Mon, 20 Mar 2006 22:15:29 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1142871263.11694.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
	 <20060320160500.GA25415@in.ibm.com>
	 <1142871263.11694.4.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, no, no! I am introducing kmem_cache_zalloc() because there are
> existing users in the tree. I plan to kill the slab wrappers from XFS
> completely which is why I need this. We already have object constructors
> for what you're describing.

Ok, please keep the interface - build kmem_cache_zalloc() on top of
what I suggest.

>
> On Mon, 2006-03-20 at 21:35 +0530, Balbir Singh wrote:
> > This could be used to poison allocated memory. Passing 0 would make
> > this equivalent to kmem_cache_zalloc(). Basically, instead of doing
>
> I am not sure I understand what you mean. We already have slab poisoning
> and that's in mm/slab.c. Why would you want to make the callers aware of
> that?
>

 Basically I am not asking for poisoning support as described by
slab.c. I am talking about general poisoining. Let me try and further
clarify with an example.

Lets say I have a structure resp that is allocated on heap. It is a
part of a response structure for a device (say 1394) and is returned
by the device to the driver.

When I allocate the structure - I would like to do

kmem_cache_alloc_set(&resp, GFP_XXXXX, 0xEE)

The device should ideally fill all fields of resp. Fields that look
0xEE after receiving the response -- would indicate that they were not
filled by the device. This would be extremely useful in debugging.
With kmem_cache_zalloc() - 0 is usually almost always a valid value.
It is useful in some cases and no so much in other cases.

I could easily achieve the same thing by doing a

memset(&resp, 0xEE, size)

after the kmem_cache_alloc(). But since there is an API to zero out
allocated memory, I thought we could make it more generic and more
useful.

Lets say we add an API

kmem_cache_alloc_set(cache, flags, byte)
{
    mem = __cache_alloc(...)
    memset(mem, byte, size)
}

we could have

inline kmem_cache_zalloc(cache, flags)
{
   return kmem_cache_alloc_set(cache, flags, 0)
}

Balbir
