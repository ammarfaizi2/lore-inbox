Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278523AbRJPEa1>; Tue, 16 Oct 2001 00:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278524AbRJPEaS>; Tue, 16 Oct 2001 00:30:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6151 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278523AbRJPEaD>; Tue, 16 Oct 2001 00:30:03 -0400
Date: Mon, 15 Oct 2001 21:29:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] large /proc/mounts and friends
In-Reply-To: <Pine.GSO.4.21.0110152355010.11608-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0110152110310.8688-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Oct 2001, Alexander Viro wrote:
> >
> > Al, do you see any problems in this?  I bet a lot of /proc files will fit
> > this model, and need only a fairly simple "fillme()" function..
>
> It's _very_ close to what I've done.

Ok, now that I read it right, I agree. And not wasting the low bits of the
position should allows some sparse indexing..

One comment: I really think your "lseek()+read()" interaction is fairly
disgusting, though. the

	for (p=m->op->start(m), i=0; i<pos; p=m->op->next(m, p), i++) {
		...

thing makes it impossible to "jump" to the right location directly, which
might be perfectly sane and easy for many uses. Maybe simply through a
simple "seek()" interface (that could have a fall-back with the "one entry
at a time" loop using the "next" interface if you think that's going to be
common), and a flag that says "lseek has happened".

So you'd have the start be something like

	p = m->op->start(m);
	if (m->did_lseek) {
		m->did_lseek = 0;
		p = m->op->seek(m, pos);
	}
	p = m->op->next(m, p);

instead of that for-loop..

		Linus

