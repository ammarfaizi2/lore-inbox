Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266837AbSKKRke>; Mon, 11 Nov 2002 12:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266849AbSKKRke>; Mon, 11 Nov 2002 12:40:34 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:11060 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S266837AbSKKRkb>; Mon, 11 Nov 2002 12:40:31 -0500
Date: Mon, 11 Nov 2002 17:48:17 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christoph Hellwig <hch@lst.de>, "Adam J. Richter" <adam@yggdrasil.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] loop sendfile retval
In-Reply-To: <Pine.LNX.4.44.0211110846270.1805-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211111731160.1174-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2002, Linus Torvalds wrote:
> On Mon, 11 Nov 2002, Hugh Dickins wrote:
> >
> > Buffer I/O error on device loop: its use of sendfile is (trivially)
> > broken - retval is usually count done, only an error when negative.
> 
> Hmm.. Sendfile can return other values than "count" (ie a partial read).  
> This return value change makes "do_lo_receive()" lose that information. As 
> such, the new do_lo_receive() is weaker than the old one.

True, with that patch it's passing back less info than 2.5.47 tried to do;
but no less than 2.5.46 and earlier, which always returned desc.error and
ignored the desc.written, desc.count coming back from do_generic_file_read.
So it's not a regression, but of course you're right that it's weak.

> If fixing the loop code to handle partial IO is too nasty, then I would
> suggest doing maybe something like
> 
> 	if (ret > 0 && ret != bvec->bv_len)
> 		ret = -EIO;
> 
> which at least makes a partial IO an error instead of making it a success 
> case (the code as-is seems to think that any non-negative return value 
> means that the IO was fully successful).
> 
> > Nearby spinlocking clearly bogus, delete instead of remarking on it.
> 
> I'll apply the patch, it looks better than what is there now, but it might 
> be worth fixing this _right_.

Thanks, that gets it going again.  I'll step aside and leave the correct
partial handling to those who know loop much better than I - Adam?

Hugh

