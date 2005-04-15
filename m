Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVDOPiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVDOPiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 11:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVDOPiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 11:38:10 -0400
Received: from science.horizon.com ([192.35.100.1]:4662 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261837AbVDOPiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 11:38:04 -0400
Date: 15 Apr 2005 15:38:01 -0000
Message-ID: <20050415153801.12619.qmail@science.horizon.com>
From: linux@horizon.com
To: tytso@mit.edu
Subject: Re: Fortuna
Cc: jlcooke@certainkey.com, linux-kernel@vger.kernel.org, mpm@selenic.com
In-Reply-To: <20050415144216.GA9352@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The ISN selection is there only to make it harder to accomplish TCP
> hijacking attacks from people who are on networking path between the
> source and destination.  And you have to guess the ISI before the
> 3-way TCP handshake has been negotiated (or if you can stop the SYN
> packet in flight, before the other side times out the attempted TCP
> connection); and we also rekey every few minutes, so even if you do
> figure out the seed that we are using to generate the ISI (which is
> harder than just merely finding a hash collision; find the preimage
> that we are using as a seed given the only a portion of the crypto
> hash output), it becomes useless and you have to start all over again
> within a few minutes.

Er... are you sure that's right?  I think there are several mistakes
there.

First of all, people *on* the netowrk path can just *see* the packets.
Or modify them.  Or whatever.
The point is to prevent hijacking by people *not* on the path.
Such people can only blindly inject forged packets, and try to send
"passwd\nhax0r\nhax0r\n" into an open telnet connection.  Or sending
FINs to DoS.

Such injection requires guessing the TCP sequence number.  That depends
on the ISN plus the number of bytes sent.  Fortunately, some of the most
interesting protocols to attack are interactive ones like telnet where
the number of bytes sent is small and the uncertainty can be exhausted
with a flood of packets.

The problem was to prevent someone from connecting to endpoints A and B
and using the ISN they received to guess the ISNs that A and B would use
to talk to each other.  The classic TCP ISN algorithm just uses a global
timestamp, so it's pretty easy.

Further, if I capture ISNs from A and B in the same rekey interval as
the initiation of the connection I'm trying to hijack, and that
connection proceeds slowly, then I have the lifetime of the connection
to solve the crypto problem.


All that said, you are quite right (I had just figured it out myself,
actually) that the required attack is a (first) preimage attack (albeit
with partially known plaintext), not a collision, so the published
collision attacks are not directly relevant.  And the fact that the
amount of hash output is not enough to determine the input key material
so you have to make multiple probes with dirrecnt port numbers, and
it's all masked by a high-speed clock that you can only come close to
guessing the value of, makes it all even nastier for a would-be
cryptanalyst.

> Furthermore, if you really cared about preventing TCP hijacks, the
> only real way to do this is to use Real Crypto.  And these days, Cisco
> boxes support Kerberized telnets and ssh connections, which is the
> real Right Answer.

It's just so high-level.  While ipsec is the most general solution,
setting it up is a PITA.  I've often thought about trying to add a TCP
option for stream encryption what could provide opportunistic encryption
for everyone.


> It might be possible to use a more expensive crypto primitive here,
> since CPU's have gotten so much faster, but the reason why we moved to
> MD4, and then cut it down, was because otherwise it was causing a
> noticeable difference in the speed we could establish TCP connections,
> and hence for certain network-based benchmarks.

Yes, I recall.  I was more thinking that the MD5 and SHA0 problems were
insufficient mixing between columns of bits, and even SHA1 still has
the problem.  Notice how much more aggressive the shifting is in the
SHA256 key schedule.

As long as it's homebrew ad-hoc crypto, perhaps some study of the
attacks could suggest a better key schedule than just using the key
words in different orders and with different constants added.

>> Just to be clear, I don't remember it ever throwing entropy away, but
>> it hoards some for years, thereby making it effectively unavailable.
>> Any catastrophic reseeding solution has to hold back entropy for some
>> time.

> It depends on how often you reseed, but my recollection was that it
> was far more than years; it was *centuries*.  And as far as I'm
> concerned, that's equivalent to throwing it away, especially given the
> pathetically small size of the Fortuna pools.

Well, subpool n is added to the main pool every 1/2^n additions of
subpool 0.  So with pool 0 added every 0.1 second (say), then
subpool 31 is added every 6.8 years.

But the whole things depends on a minimum assumed entropy feed rate.
The idea is to be sure that *some* subpool will hoard entropy long
enough to cause catastrophic reseeding.  You can reduce the number
of subpools to fit any arbitrary bound.

E.g. if you think that 24 hours is long enough, and you have the same
0.1 second maximum reseed rate, then 21 pools will have pool 20 added
every 29:07:37.6.

As I keep saying, the small size of the Fortuna pools is a separate
matter, and can be changed without affecting the subpool structure that
is Fortuna's real novel contribution.  That was just what Niels and
Bruce came up with to make the whole thing concrete.
