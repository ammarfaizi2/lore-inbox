Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278087AbRJPEm1>; Tue, 16 Oct 2001 00:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278088AbRJPEmT>; Tue, 16 Oct 2001 00:42:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21767 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278087AbRJPEmD>; Tue, 16 Oct 2001 00:42:03 -0400
Date: Mon, 15 Oct 2001 21:41:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] large /proc/mounts and friends
In-Reply-To: <Pine.LNX.4.33.0110152110310.8688-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110152132110.8730-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Oct 2001, Linus Torvalds wrote:
>
> So you'd have the start be something like
>
> 	p = m->op->start(m);
> 	if (m->did_lseek) {
> 		m->did_lseek = 0;
> 		p = m->op->seek(m, pos);
> 	}
> 	p = m->op->next(m, p);

Actually, the "seek" is obviously unconditional. Duh.

And we really want to pass in the "file" to the next/seek functions,
because I still think that we don't want this to be just a plain linear
sequence interface - your "/proc/module" thing already shows how it could
be advantageous to have the high pos bits be the module itself.

Example:

	/* module seek */
	s_seek()
	{
		struct mod_sym *v = p;
		int mod_nr = pos >> 32;
		while (mod_nr && v->mod) {
			mod_nr--;
			v->mod = v->mod->next;
		};
	}

where the high 32 bits of the pos are the module count. Something that the
"increment by one" approach simply cannot handle efficiently because it
ends up having to walk every module name, and can't just skip over them.

Again, the other example of this are various hashed data-structures loke
sockets that simply do not _have_ cardinal numbers, and where it is not
really reasonable to walk the chain of (potentially tens of thousands of)
entries one-by-one, when you can do a seek directly to the right hash
bucket, and then just walk a few entries in the hash chain..

		Linus

