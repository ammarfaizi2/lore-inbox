Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUK2XSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUK2XSM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbUK2XRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:17:02 -0500
Received: from mail.dif.dk ([193.138.115.101]:3265 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261856AbUK2XOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 18:14:09 -0500
Date: Tue, 30 Nov 2004 00:23:51 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Gadi Oxman <gadio@netvision.net.il>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2/2] ide-tape: small cleanups - handle   copy_to|from_user()
 failures
In-Reply-To: <41ABA6EE.6080502@tmr.com>
Message-ID: <Pine.LNX.4.61.0411300018240.3389@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411281731050.3389@dragon.hygekrogen.localhost><Pine.LNX.4.61.0411281731050.3389@dragon.hygekrogen.localhost>
 <1101663266.16761.43.camel@localhost.localdomain> <41ABA6EE.6080502@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004, Bill Davidsen wrote:

> Alan Cox wrote:
> > On Sul, 2004-11-28 at 16:32, Jesper Juhl wrote:
> > 
> > > #endif /* IDETAPE_DEBUG_BUGS */
> > > 		count = min((unsigned int)(bh->b_size -
> > > atomic_read(&bh->b_count)), (unsigned int)n);
> > > -		copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf,
> > > count);
> > > +		if (copy_from_user(bh->b_data + atomic_read(&bh->b_count),
> > > buf, count))
> > > +			return -EFAULT;
> > > 		n -= count;
> > > 		atomic_add(count, &bh->b_count);
> > > 		buf += count;
> > 
> > 
> > If you do this then you don't fix up tape->bh for further operations.
> > Have you tested these changes including the I/O errors ?
> 
> But (a) do you have enough information to backout or fixup correctly? And (b)
> won't this result in the whole i/o being treated as invalid?
> 
That was my original thought "if copy_from_user fails then something 
really bad is happening and we should just fail the entire IO operation".
Then when Alan pointed out that I'd probably be messing up tape->bh I got 
nervous becourse it seemed to me that he probably had a point, but when I 
went back and looked at the code again I ended up with the conclusion that 
even if we did mess it up it wouldn't actually matter since we'll be 
failing the entire IO since I also added code in the caller to test for 
the <0 return from this function and abort the entire operation in that 
case.
Alan: Would you mind explaining why this is not safe? If there's something 
I'm missing I'd really like to know.

-- 
Jesper Juhl


