Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129529AbQKGHLa>; Tue, 7 Nov 2000 02:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129560AbQKGHLL>; Tue, 7 Nov 2000 02:11:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39042 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129529AbQKGHLG>;
	Tue, 7 Nov 2000 02:11:06 -0500
Date: Mon, 6 Nov 2000 22:56:07 -0800
Message-Id: <200011070656.WAA02435@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: jordy@napster.com
CC: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <3A07A4B0.A7E9D62@napster.com> (message from Jordan Mendelson on
	Mon, 06 Nov 2000 22:44:00 -0800)
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net> <3A07A4B0.A7E9D62@napster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 06 Nov 2000 22:44:00 -0800
   From: Jordan Mendelson <jordy@napster.com>

   Attached to this message are dumps from the windows 98 machine using
   windump and the linux 2.4.0-test10. Sorry the time stamps don't match
   up.

Ok, something is "odd" at the win98 side, I quote the win98 log:

   22:34:36.069773 64.124.41.179.8888 > 209.179.194.175.1084: P 1:19(18) ack 44 win 5840 (DF)
   22:34:36.069837 64.124.41.179.8888 > 209.179.194.175.1084: P 19:553(534) ack 44 win 5840 (DF)

Linux sends 1-->553

Since this is in the win98 log, it saw this data, but refuses to
acknowledge it and the retransmit timeout expires on the Linux side.

   22:34:39.049788 64.124.41.179.8888 > 209.179.194.175.1084: P 1:21(20) ack 44 win 5840 (DF)

So Linux resends 1-->21

   22:34:39.051638 209.179.194.175.1084 > 64.124.41.179.8888: P 44:56(12) ack 21 win 65260 (DF)

Win98 sends data, and only acknowledges the resent data from Linux.

   22:34:39.245138 64.124.41.179.8888 > 209.179.194.175.1084: P 21:555(534) ack 44 win 5840 (DF)
   22:34:39.245208 64.124.41.179.8888 > 209.179.194.175.1084: P 557:1091(534) ack 56 win 5840 (DF)

Win98 machine receives bytes 21-->1091 from Linux, Linux also is
acknowledging Win98's data up to 56, but...

   22:34:41.739438 209.179.194.175.1084 > 64.124.41.179.8888: P 44:456(412) ack 21 win 65260 (DF)

Win98 still claims it only saw up to byte 21 from Linux.  Win98 also
resends its data, therefore it has not seen Linux's ACKs either.

And this goes on and on.

Just to be absolutely sure, 64.124.41.179 is the Linux machine, right?
If so, Win98 is dropping packets it did in fact receive correctly,
before Win98's TCP has a look at them.

WHOA, wait a second!  From the Linux side log:

23:36:16.261533 64.124.41.179.8888 > 209.179.194.175.1084: P 1:21(20) ack 44 win 5840 (DF)
23:36:16.261669 64.124.41.179.8888 > 209.179.194.175.1084: P 21:557(536) ack 44 win 5840 (DF)
23:36:19.261055 64.124.41.179.8888 > 209.179.194.175.1084: P 1:21(20) ack 44 win 5840 (DF)

The equivalent packets from the win98 log:

22:34:36.069773 64.124.41.179.8888 > 209.179.194.175.1084: P 1:19(18) ack 44 win 5840 (DF)
22:34:36.069837 64.124.41.179.8888 > 209.179.194.175.1084: P 19:553(534) ack 44 win 5840 (DF)
22:34:39.049788 64.124.41.179.8888 > 209.179.194.175.1084: P 1:21(20) ack 44 win 5840 (DF)

(ie. Linux sends bytes 1:21 both the first time, and when it
 retransmits that data.  However win98 "sees" this as 1:19 the first
 time and 1:21 during the retransmit by Linux)

That is bogus.  Something is mangling the packets between the Linux
machine and the win98 machine.  You mentioned something about
bandwidth limiting at your upstream provider, any chance you can have
them turn this bandwidth limiting device off?

Or maybe earthlink is using some packet mangling device?

It is clear though, that something is messing with or corrupting the
packets.  One thing you might try is turning off TCP header
compression for the PPP link, does this make a difference?

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
