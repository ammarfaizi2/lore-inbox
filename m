Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135920AbREIJHY>; Wed, 9 May 2001 05:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135925AbREIJHF>; Wed, 9 May 2001 05:07:05 -0400
Received: from pcow029o.blueyonder.co.uk ([195.188.53.123]:19975 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S135920AbREIJG5>;
	Wed, 9 May 2001 05:06:57 -0400
From: Eric Barton <eric@bartonsoftware.com>
To: linux-kernel@vger.kernel.org
Subject: kiobuf setup overhead
Message-ID: <08c845508090951PCOW029M@blueyonder.co.uk>
Date: 9 May 2001 10:08:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've noticed that alloc_kiovec() calls alloc_kiobuf_bhs(), which...

> int alloc_kiobuf_bhs(struct kiobuf * kiobuf)
> {
> 	int i;
> 
> 	for (i = 0; i < KIO_MAX_SECTORS; i++)
> 		if (!(kiobuf->bh[i] = kmem_cache_alloc(bh_cachep, SLAB_KERNEL))) {
> 			while (i--) {
> 				kmem_cache_free(bh_cachep, kiobuf->bh[i]);
> 				kiobuf->bh[i] = NULL;
> 			}
> 			return -ENOMEM;
> 		}
> 	return 0;
> }

...where KIO_MAX_SECTORS is currently 1024.  This makes a kiobuf quite a
heavy-weight object to allocate and free.  

Was this high-overhead initialisation left in because kiobufs shouldn't be
allocated and freed at the drop of a hat in any case?

If not, allocating the kiobuf->bh[i], could be delayed until the number
required is known.

This would be beneficial for direct I/O in the scsi generic driver, which
currently allocates and frees a kiobuf on each read/write.

-- 

                Cheers,
                        Eric

