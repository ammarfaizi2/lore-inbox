Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275359AbRIZR0C>; Wed, 26 Sep 2001 13:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275361AbRIZRZx>; Wed, 26 Sep 2001 13:25:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19979 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275359AbRIZRZj>; Wed, 26 Sep 2001 13:25:39 -0400
Date: Wed, 26 Sep 2001 10:25:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, <bcrl@redhat.com>,
        <marcelo@conectiva.com.br>, <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <E15mHjL-0000t8-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109261003480.8327-200000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168447515-654106168-1001525118=:8327"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--168447515-654106168-1001525118=:8327
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 26 Sep 2001, Alan Cox wrote:
> >
> > Your Athlons may handle exclusive cache line acquisition more
> > efficiently (due to memory subsystem performance) but it still
> > does cost something.
>
> On an exclusive line on Athlon a lock cycle is near enough free, its
> just an ordering constraint. Since the line is in E state no other bus
> master can hold a copy in cache so the atomicity is there. Ditto for newer
> Intel processors

You misunderstood the problem, I think: when the line moves from one CPU
to the other (the exclusive state moves along with it), that is
_expensive_.

Even when you have a backside bus (or cache pushout content snooping)  to
allow the cacheline to move directly from one CPU to the other without
having to go through memory, that's a really expensive thing to do.

So re-aquring the lock on the same CPU is pretty much free (18 cycles for
Intel, if I remember correctly, and that's _entirely_ due to the pipeline
flush to ensure in-order execution around it).

[ Oh, just for interest I checked my P4, which has a much longer pipeline:
  the cost of an exclusive locked access is a whopping 104 cycles. But we
  already knew that the first-generation P4 does badly on many things.

  Just reading the cycle counter is apparently around 80 cycles on a P4,
  it's 32 cycles on a PIII. Looks like that also stalls the pipeline or
  something. But cpuid is _really_ horrible. Test out the attached
  program.

	PIII:
		nothing: 32 cycles
		locked add: 50 cycles
		cpuid: 170 cycles

	P4:
		nothing: 80 cycles
		locked add: 184 cycles
		cpuid: 652 cycles

   Remember: these are for the already-exclusive-cache cases. ]

What are the athlon numbers?

		Linus

--168447515-654106168-1001525118=:8327
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="t.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0109261025180.8327@penguin.transmeta.com>
Content-Description: 
Content-Disposition: attachment; filename="t.c"

I2RlZmluZSByZHRzYyhsb3cpIFwNCiAgIF9fYXNtX18gX192b2xhdGlsZV9f
KCJyZHRzYyIgOiAiPWEiIChsb3cpIDogOiAiZWR4IikNCg0KI2RlZmluZSBU
SU1FKHgseSkgXA0KCW1pbiA9IDEwMDAwMDsJCQkJCQlcDQoJZm9yIChpID0g
MDsgaSA8IDEwMDA7IGkrKykgewkJCQlcDQoJCXVuc2lnbmVkIGxvbmcgc3Rh
cnQsZW5kOwkJCVwNCgkJcmR0c2Moc3RhcnQpOwkJCQkJXA0KCQl4OwkJCQkJ
CVwNCgkJcmR0c2MoZW5kKTsJCQkJCVwNCgkJZW5kIC09IHN0YXJ0OwkJCQkJ
XA0KCQlpZiAoZW5kIDwgbWluKQkJCQkJXA0KCQkJbWluID0gZW5kOwkJCQlc
DQoJfQkJCQkJCQlcDQoJcHJpbnRmKHkgIjogJWQgY3ljbGVzXG4iLCBtaW4p
Ow0KDQojZGVmaW5lIExPQ0sJYXNtIHZvbGF0aWxlKCJsb2NrIDsgYWRkbCAk
MCwwKCVlc3ApIikNCiNkZWZpbmUgQ1BVSUQJYXNtIHZvbGF0aWxlKCJjcHVp
ZCI6IDogOiJheCIsICJkeCIsICJjeCIsICJieCIpDQoNCmludCBtYWluKCkN
CnsNCgl1bnNpZ25lZCBsb25nIG1pbjsNCglpbnQgaTsNCg0KCVRJTUUoLyog
Ki8sICJub3RoaW5nIik7DQoJVElNRShMT0NLLCAibG9ja2VkIGFkZCIpOw0K
CVRJTUUoQ1BVSUQsICJjcHVpZCIpOw0KfQ0K
--168447515-654106168-1001525118=:8327--
