Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbSKKQq5>; Mon, 11 Nov 2002 11:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265800AbSKKQq4>; Mon, 11 Nov 2002 11:46:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52746 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265787AbSKKQqz>; Mon, 11 Nov 2002 11:46:55 -0500
Date: Mon, 11 Nov 2002 08:53:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] loop sendfile retval
In-Reply-To: <Pine.LNX.4.44.0211111626160.9968-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0211110846270.1805-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Nov 2002, Hugh Dickins wrote:
>
> Buffer I/O error on device loop: its use of sendfile is (trivially)
> broken - retval is usually count done, only an error when negative.

Hmm.. Sendfile can return other values than "count" (ie a partial read).  
This return value change makes "do_lo_receive()" lose that information. As 
such, the new do_lo_receive() is weaker than the old one.

If fixing the loop code to handle partial IO is too nasty, then I would
suggest doing maybe something like

	if (ret > 0 && ret != bvec->bv_len)
		ret = -EIO;

which at least makes a partial IO an error instead of making it a success 
case (the code as-is seems to think that any non-negative return value 
means that the IO was fully successful).

> Nearby spinlocking clearly bogus, delete instead of remarking on it.

I'll apply the patch, it looks better than what is there now, but it might 
be worth fixing this _right_.

		Linus

