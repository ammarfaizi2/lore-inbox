Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282383AbRKXGwU>; Sat, 24 Nov 2001 01:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282381AbRKXGwL>; Sat, 24 Nov 2001 01:52:11 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32468 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282380AbRKXGvw>;
	Sat, 24 Nov 2001 01:51:52 -0500
Date: Sat, 24 Nov 2001 01:51:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <20011124074400.A1601@athlon.random>
Message-ID: <Pine.GSO.4.21.0111240144100.4000-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Andrea Arcangeli wrote:

> I don't care who has to do it, but who has to do it it has to do it in a
> very very very very slow path, and you want to handle it in iput fast
> path instead, cute?

Let's count.  In the place where before -pre9 iput() had
				return;
we have (2.4.15 + patch)
                                if (!sb || sb->s_flags & MS_ACTIVE)
                                        return;
and on the fast path the first is false and second is true.

Price:
	compare with zero
	not taken branch
	test (register + offset), <bit>
	not taken branch
	return
instead of
	return
Compare with the stuff we had done just before that.  Pollution of fast
path sucks, but here it _is_ noise.

I agree that variant in 2.4.15 is crap - hell, it's completely broken.
Please, grab the patch in question, apply to 2.4.15 and look at the
resulting code.

