Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSIBSgg>; Mon, 2 Sep 2002 14:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSIBSgg>; Mon, 2 Sep 2002 14:36:36 -0400
Received: from [195.223.140.120] ([195.223.140.120]:1883 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315946AbSIBSgf>; Mon, 2 Sep 2002 14:36:35 -0400
Date: Mon, 2 Sep 2002 20:40:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020902184043.GN1210@dualathlon.random>
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random> <20020815214225.H29874@redhat.com> <20020816150945.A1832@in.ibm.com> <20020816100334.GP14394@dualathlon.random> <20020816165306.A2055@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020816165306.A2055@in.ibm.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could somebody explain the semantics of the io_queue_wait call in the
libaio? If you pass nr == 0 to getevents, getevents will do nothing. I
don't see the point of it so I'm unsure what's the right implementation.

then about the 2.5 API we have such min_nr that allows the "at least
min_nr", instead of the previous default of "at least 1", so that it
allows implementing the aio_nwait of aix.

However the code checks for min_nr being > 0 but a min_nr == 0 will not
make sense. So min_nr should be always > 0 (infact the previous default
was at least 1, because as said at least 0 doesn't make sense). Same
issue with the nr, nr == 0 also doesn't make sense to me, and I think as
well nr should be > 0 (that's my issue with the apparently pointless
io_queue_wait too).

However as far as the API doesn't change much I'm fine, if there are
minor -EINVAL differences with bad inputs there should be not much
compatibility issues, and right now we're more permissive, so if
something 2.6 will be less permissive and it will guarantee apps for 2.6
will work right on current 2.5.

So what I'm doing now is to be in sync with 2.5, and I'm implementing
the io_queue_wait this way:

int io_queue_wait(io_context_t ctx, const struct timespec *timeout)
{
	return io_getevents(ctx, 0, 0, NULL, timeout);
}

My preferred solution is to kill io_queue_wait that apparently only
generates a suprious lookup of the iocontext in-kernel, and then to
force min_nr > 0 and nr > 0. But I need your opinion on this, also
because you certainly know the semantics of io_queue_wait that I
couldn't easily reverse engeneer from the sourcecode (or maybe I
overlooked something in the sourcecode, possible).

Grepping l-k for io_queue_wait shows no results, google only shows the
glibc patches with no comment at all. The regression tests as well never
use it. Of course it's not a surprise since as far I can tell it cannot
do anything either old or new code, but I need to find if it is buggy or
if it should really be dropped.

BTW, the libaio I'm adapting to test on my tree will not have the
libredhat thing anymore, and it will use the mainline 2.5 API since the
API is registered now and in the very worst case a non backwards
compatible API change would happen in late 2.5, replacing libaio.so is
not more complex than replacing libredhat.so anyways ;).

Andrea
