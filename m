Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRBSSEO>; Mon, 19 Feb 2001 13:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129696AbRBSSEF>; Mon, 19 Feb 2001 13:04:05 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:20740 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129406AbRBSSDw>;
	Mon, 19 Feb 2001 13:03:52 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102191803.VAA12658@ms2.inr.ac.ru>
Subject: Re: SO_SNDTIMEO: 2.4 kernel bugs
To: chris@scary.beasts.org (Chris Evans)
Date: Mon, 19 Feb 2001 21:03:32 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <Pine.LNX.4.30.0102190025270.19003-100000@ferret.lmh.ox.ac.uk> from "Chris Evans" at Feb 19, 1 01:04:28 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> You are right - our sendfile() implementation is broken. I have fixed it

Thank you!


> Investigation shows that the Linux network layer is behaving oddly. It
> seems that we are writing 4096 bytes to a socket. This proceeds in 4096
> byte chunks until the send buffer on the socket is full, and a 4096 byte
> write blocks. This blocking write is eventually interrupted by the
> timeout, and the write call returns.. wait for it.. 4096! This suggests
> there was socket space after all, and the call should not have blocked.

Wakeup does not happen until _enough_ (1/3 of snbuf) of space in sndbuf
is released, otherwise you will overschedule. So, as soon as
write() goes to sleep, it will sleep waiting until 1/3 is released.

If it is interrupted, it use all the released space immediately before exit.
Again, to make more for in this context. This can be even wrong and, probably,
we should return instantly with -EAGAIN/-EINTR/partial count, but it is most
likely suboptimal (though I have already changed this to instant return).
But this does not look essential from caller's viewpoint, except for
sendfile() of course. 8)

Alexey
