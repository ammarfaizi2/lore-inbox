Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbQKGKNP>; Tue, 7 Nov 2000 05:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129845AbQKGKNE>; Tue, 7 Nov 2000 05:13:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38532 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129669AbQKGKMw>;
	Tue, 7 Nov 2000 05:12:52 -0500
Date: Tue, 7 Nov 2000 01:57:46 -0800
Message-Id: <200011070957.BAA03164@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ak@suse.de
CC: jordy@napster.com, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <20001107104136.A5081@gruyere.muc.suse.de> (message from Andi
	Kleen on Tue, 7 Nov 2000 10:41:36 +0100)
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net> <3A07A4B0.A7E9D62@napster.com> <200011070656.WAA02435@pizda.ninka.net> <3A07AC45.DCC961FF@napster.com> <200011070712.XAA02511@pizda.ninka.net> <3A07B01A.1E70EE20@napster.com> <200011070727.XAA02574@pizda.ninka.net> <20001107104136.A5081@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 7 Nov 2000 10:41:36 +0100
   From: Andi Kleen <ak@suse.de>

   I think such a theory would at least need verifying (e.g. by a
   sniffer on the windows end that checks checksums or someone finding
   the checksum failed counters windows probably maintains)

Sure.

BTW, note the pattern of the win98 logs, basically the whole
connection from the WIN98 side is:

repeat:
	LINUX	data(N) --> win98		DIFFERENT sequence number
	LINUX	data(N+1) --> win98		DIFFERENT sequence number

	retimeout

	LINUX	data(N) --> win98		SAME sequence number
	win98 ACK N --> LINUX

	N++; goto repeat

And in all cases except the first data segment sent by Linux, the
sequence numbers are corrupted such that the original 536 byte payload
is reduced to a 534 byte payload.

Now one could argue it might be a bandwidth limiter, because the
first change in sequence numbers is:

22:34:36.069773 64.124.41.179.8888 > 209.179.194.175.1084: P 1:19(18) ack 44 win 5840 (DF)
22:34:36.069837 64.124.41.179.8888 > 209.179.194.175.1084: P 19:553(534) ack 44 win 5840 (DF)

They're changed, but lined up.  However later we get stuff like:

22:34:39.245138 64.124.41.179.8888 > 209.179.194.175.1084: P 21:555(534) ack 44 win 5840 (DF)
22:34:39.245208 64.124.41.179.8888 > 209.179.194.175.1084: P 557:1091(534) ack 56 win 5840 (DF)

Which don't even line up at all.  Furthermore, if the checksums were
correct win98 should have ACK'd fully the <1:19> data packet and the
<19:553> one.  Also for the non-contiguous cases win98 should have
sent an immediate ACK (and a SACK block indicating the non-contiguous
data received).

Now, I could see some buggy bandwidth limiter chopping up the sequence
numbers such that they aren't lined up occaisionally, but corrupting
all the TCP checksums as well?  I find that hard to believe.

Well, if it is what's happening, I wouldn't expect such a company to
be making such products for long :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
