Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129699AbRBBSYK>; Fri, 2 Feb 2001 13:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129750AbRBBSYB>; Fri, 2 Feb 2001 13:24:01 -0500
Received: from [62.172.234.2] ([62.172.234.2]:47990 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129699AbRBBSXw>;
	Fri, 2 Feb 2001 13:23:52 -0500
Date: Fri, 2 Feb 2001 18:24:36 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP Race in brelse
In-Reply-To: <0102021907250D.15914@gimli>
Message-ID: <Pine.LNX.4.21.0102021824030.716-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

That is very well known (I posted about it many years ago :) but, as Ingo
(or someone else? maybe sct or Alan? actually, I think it was Andrea)
explained it is not a bug -- for that if() is only for purpose of catching
bad callers (which, in perfect world, shouldn't exist). The whole brelse()
could just contain a single atomic_dec() and that is all.

Regards,
Tigran

PS. Having thought about it -- it was neither sct, nor Alan, nor even
Andrea -- it was Linus who explained it :)


On Fri, 2 Feb 2001, Daniel Phillips wrote:

> There is a rare SMP race in brelse:
> 
> 1138 void __brelse(struct buffer_head * buf)
> 1139 {
> 1140         if (atomic_read(&buf->b_count)) {
> 1141                 atomic_dec(&buf->b_count);
> 1142                 return;
> 1143         }
> 1144         printk("VFS: brelse: Trying to free free buffer\n");
> 1145 }
> 
>                 cpu1                                 cpu2
> 
> Starting with buf->b_count = 1, if we have:
> 
>    if (atomic_read(&buf->b_count))
> 					 if (atomic_read(&buf->b_count))
>        atomic_dec(&buf->b_count);
> 					      atomic_dec(&buf->b_count);
> 
> buf->b_count is now 0, but it should be -1, we fail to to report
> an erroneous extra brelse.
> 
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
