Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbSJCU0k>; Thu, 3 Oct 2002 16:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbSJCU0k>; Thu, 3 Oct 2002 16:26:40 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43162 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261369AbSJCU0h>;
	Thu, 3 Oct 2002 16:26:37 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 4/4: evms_biosplit.h
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF2FC09D0D.E4C956E8-ON85256C47.006ECCC8@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Thu, 3 Oct 2002 15:36:24 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/03/2002 04:31:02 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/03/2002 at 10:05 AM, Christoph Hellwig wrote:

>> +static mempool_t *my_bio_split_pool, *my_bio_pool;
>> +static kmem_cache_t *my_bio_split_slab, *my_bio_pool_slab;

> Umm, static variables in header files?

Yupp, that wasn't accidental.

Based on the conclusions mutually agreed on in the OLS
BOF on bio splitting, it was decided that each driver
having the need to split bios *should* have their own
private bio pools to use exclusively for this purpose.
Thus any plugin that includes this header gets their
own private copies of these variables.

>> +
>> +/**
>> + * slab_pool_alloc
>> + * @gfp_mask: GFP allocation flag
>> + * @data:     mempool prototype required fields
>> + *
>> + * mempool allocate function
>> + **/
>> +static void *
>> +slab_pool_alloc(int gfp_mask, void *data)
>> +{
>> +  return kmem_cache_alloc(data, gfp_mask);
>> +}
>> +
>> +/**
>> + * slab_pool_free
>> + * @ptr:      mempool prototype required fields
>> + * @data:     mempool prototype required fields
>> + *
>> + * mempool free function
>> + **/
>> +static void
>> +slab_pool_free(void *ptr, void *data)
>> +{
>> +  kmem_cache_free(data, ptr);
>> +}

> I think these two could go to slab.c instead.

I agree. I've seen a few other static versions of the
same thing floating around.

>> +  if (!my_bio_split_slab) {
>> +        panic("unable to create EVMS Bio Split cache.");

> What about graceful error handling?

Alan already questioned this as well... and I agree. I've
already made the necessary changes.

> All in all I think this should rather be a source file, I can't
> see anything EVMS-specific either.

There may likely be generic code to perform bio splitting
at some (hopefully soon) point in time. I'm not even going
to assume that what EVMS has done will or should be it.
This support was a temporary implementation that does
allow several plugins in EVMS to work correctly with the
large I/Os now available in 2.5. I do agree, what ever is
done should be placed in some commonly usable location.

Mark


