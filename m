Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSJDPHP>; Fri, 4 Oct 2002 11:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261964AbSJDPGj>; Fri, 4 Oct 2002 11:06:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23788 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261963AbSJDPFg>;
	Fri, 4 Oct 2002 11:05:36 -0400
Date: Fri, 4 Oct 2002 11:11:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Hellwig <hch@infradead.org>
cc: Kevin Corry <corryk@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EVMS core 1/4: evms.c
In-Reply-To: <20021004155639.A32001@infradead.org>
Message-ID: <Pine.GSO.4.21.0210041104490.19491-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Oct 2002, Christoph Hellwig wrote:

> I don't think this is_busy check is a good idea.  Anyways
> it should be better something like this (then in block_dev.c):
> 
> int bd_busy(struct block_device *bdev)
> {
> 	int res = 0;
> 	spin_lock(&bdev_lock);
> 	if (bdev->bd_holder)
> 		res = -EBUSY;
> 	spin_unlock(&bdev_lock);
> 	return res;
> }

It's completely useless - any code that actually relies on its value is
racy, since there's nothing to prevent bd_claim() from being called
just as we drop bdev_lock.

The same applies to original version - if you want to protect some area,
use bd_claim() and don't release it until you are out of critical area,
damnit.

