Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270855AbRIAR0d>; Sat, 1 Sep 2001 13:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270849AbRIAR0X>; Sat, 1 Sep 2001 13:26:23 -0400
Received: from tantalophile.demon.co.uk ([193.237.65.219]:4992 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S270855AbRIAR0J>; Sat, 1 Sep 2001 13:26:09 -0400
Date: Sat, 1 Sep 2001 18:17:29 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "David S . Miller" <davem@redhat.com>, Andi Kleen <ak@muc.de>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Excessive TCP retransmits over lossless, high latency link
Message-ID: <20010901181729.A2204@thefinal.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Oops, don't group-reply to the other one which I sent to
vger.rutgers.edu by mistake :-)]

First let me describe the link.

The kernel is standard 2.4.7, i686 on a laptop, all standard settings.

I have been downloading a large email over a "9600 baud" mobile phone
link, over infrared (from phone to computer).  Protocols: PPP over
IRComm over IRDA at 115200 baud.  The modem is in the phone (the phone
responds to AT commands and provides data, over the IRComm protocol).
The phone is a Nokia 6210e.

Packets arrive _very_ slowly -- about 1 packet every 5.2 seconds.
(Showing that "9600 baud" is even worse false advertising than "56k").

The ping time during this download is ~23 seconds.  I've seen it go up
to >60 seconds.  When the link is idle, the ping time oscillates beteen
1 second and 1.5 seconds.  All the responses seem to arrive eventually,
and in order.

(The irdaping time is about 0.2 seconds, when the IRDA link is idle.
When the link is active, irdaping doesn't see any response, except for
once when the call terminated, perhaps due to irdaping.  At least, we
see that the IRDA link time is negligable).

So we can see that the mail download is acting to fill up the router
queues.  Everyone here knows that TCP does tend to fill router queues,
even when that pessimises performance.  Quite why anybody designs
routers with 60 second queues is unclear to me, but they do.

Even with this, I can see that the large mail is downloading far slower
than it ought to.

The appended "tcpdump -i ppp0 -n" trace shows an excessive number of
retransmits from the remote POP server.  The retransmits are triggered
by excessive duplicate ACKs from the local client.  By excessive, I mean
lots of retransmits of the same data.

The interesting thing is that there isn't any evidence of packet loss.

It appears there is a stable cycle of duplicate ACKs and duplicate
retransmits which doesn't go away, even without packet loss.

I think this is fixable problem at the Linux client end.  Linux is
sending many duplicate ACKs in response to data that it has already
received.  Normally, duplicate ACKs are useful to indicate that a packet
is missing and should be retransmitted.  Those ACKs have a sequence
number that is higher than the packet which triggers them.

In this case, there is no missing data, and all the duplicate ACKs do is
cause the server to resend the same data, repeatedly and redundantly.

If this can happen over a low loss but very slow and high latency link,
I guess it can happen over normal links too, but I haven't seen an example.

Is there some /proc/sys setting to fix this, a kernel patch, or is it
perhaps fixed in a newer kernel already?

thanks,
-- Jamie

ps. please don't send me any large emails ATM, thx, they take about 30
minutes per 100k to download :-)


17:39:38.872919 < 194.217.242.22.pop3 > 193.237.65.219.32772: . 4294964376:4294965836(1460) ack 1 win 8760 (DF)
17:39:38.873003 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 1:1(0) ack 1460 win 62780 (DF)
17:39:44.122914 < 194.217.242.22.pop3 > 193.237.65.219.32772: . 4294965836:0(1460) ack 1 win 8760 (DF)
17:39:44.123006 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 1:1(0) ack 1460 win 62780 (DF)
17:39:49.372887 < 194.217.242.22.pop3 > 193.237.65.219.32772: . 0:1460(1460) ack 1 win 8760 (DF)
17:39:49.372986 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 1:1(0) ack 1460 win 62780 (DF)
17:39:54.612626 < 194.217.242.22.pop3 > 193.237.65.219.32772: . 1460:2920(1460) ack 1 win 8760 (DF)
17:39:54.612712 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 1:1(0) ack 2920 win 62780 (DF)
17:39:57.742873 < 194.217.242.22.pop3 > 193.237.65.219.32772: . 2920:3812(892) ack 1 win 8760 (DF)
17:39:57.742962 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 1:1(0) ack 3812 win 62780 (DF)
17:40:03.482921 < 194.217.242.22.pop3 > 193.237.65.219.32772: . 3812:5272(1460) ack 1 win 8760 (DF)
17:40:03.483010 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 1:1(0) ack 5272 win 62780 (DF)
17:40:08.732901 < 194.217.242.22.pop3 > 193.237.65.219.32772: . 1460:2920(1460) ack 1 win 8760 (DF)
17:40:08.732991 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 1:1(0) ack 5272 win 62780 (DF)
17:40:13.972868 < 194.217.242.22.pop3 > 193.237.65.219.32772: . 1460:2920(1460) ack 1 win 8760 (DF)
17:40:13.972954 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 1:1(0) ack 5272 win 62780 (DF)
17:40:19.712883 < 194.217.242.22.pop3 > 193.237.65.219.32772: . 1460:2920(1460) ack 1 win 8760 (DF)
17:40:19.712975 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 1:1(0) ack 5272 win 62780 (DF)
17:40:24.923064 < 194.217.242.22.pop3 > 193.237.65.219.32772: . 1460:2920(1460) ack 1 win 8760 (DF)
17:40:24.923157 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 1:1(0) ack 5272 win 62780 (DF)
17:40:30.102989 < 194.217.242.22.pop3 > 193.237.65.219.32772: . 2920:4380(1460) ack 1 win 8760 (DF)
17:40:30.103082 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 1:1(0) ack 5272 win 62780 (DF)
17:40:35.312885 < 194.217.242.22.pop3 > 193.237.65.219.32772: . 3812:5272(1460) ack 1 win 8760 (DF)
17:40:35.312978 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 1:1(0) ack 5272 win 62780 (DF)
17:40:40.522880 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 5272:6671(1399) ack 1 win 8760 (DF)
17:40:40.522968 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 1:1(0) ack 6671 win 62780 (DF)
17:40:40.632511 > 193.237.65.219.32772 > 194.217.242.22.pop3: P 1:10(9) ack 6671 win 62780 (DF)
17:40:45.301126 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 5272:6671(1399) ack 1 win 8760 (DF)
17:40:45.301236 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 10:10(0) ack 6671 win 62780 (DF)
17:40:50.503077 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 5272:6671(1399) ack 1 win 8760 (DF)
17:40:50.503179 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 10:10(0) ack 6671 win 62780 (DF)
17:40:55.723023 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 5272:6671(1399) ack 1 win 8760 (DF)
17:40:55.723123 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 10:10(0) ack 6671 win 62780 (DF)
17:40:57.402665 > 193.237.65.219.32772 > 194.217.242.22.pop3: P 1:10(9) ack 6671 win 62780 (DF)
17:41:00.522888 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 5272:6671(1399) ack 1 win 8760 (DF)
17:41:00.523004 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 10:10(0) ack 6671 win 62780 (DF)
17:41:00.522899 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 6671:6677(6) ack 10 win 8760 (DF)
17:41:00.523073 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 10:10(0) ack 6677 win 62780 (DF)
17:41:00.523535 > 193.237.65.219.32772 > 194.217.242.22.pop3: P 10:27(17) ack 6677 win 62780 (DF)
17:41:00.542914 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 6671:6677(6) ack 10 win 8760 (DF)
17:41:00.543035 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 27:27(0) ack 6677 win 62780 (DF)
17:41:00.542921 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 6671:6677(6) ack 10 win 8760 (DF)
17:41:00.543091 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 27:27(0) ack 6677 win 62780 (DF)
17:41:00.560282 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 6671:6677(6) ack 10 win 8760 (DF)
17:41:00.560382 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 27:27(0) ack 6677 win 62780 (DF)
17:41:06.792902 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 6677:8137(1460) ack 27 win 8760 (DF)
17:41:06.793004 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 27:27(0) ack 8137 win 62780 (DF)
17:41:08.882933 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 8137:8706(569) ack 27 win 8760 (DF)
17:41:08.883022 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 27:27(0) ack 8706 win 62780 (DF)
17:41:08.904657 > 193.237.65.219.32772 > 194.217.242.22.pop3: P 27:36(9) ack 8706 win 62780 (DF)
17:41:13.592879 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 6677:8137(1460) ack 27 win 8760 (DF)
17:41:13.592967 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 36:36(0) ack 8706 win 62780 (DF)
17:41:18.819646 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 6677:8137(1460) ack 27 win 8760 (DF)
17:41:18.819733 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 36:36(0) ack 8706 win 62780 (DF)
17:41:20.912868 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 8137:8706(569) ack 27 win 8760 (DF)
17:41:20.912983 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 36:36(0) ack 8706 win 62780 (DF)
17:41:20.912875 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 8706:8712(6) ack 36 win 8760 (DF)
17:41:20.913050 > 193.237.65.219.32772 > 194.217.242.22.pop3: . 36:36(0) ack 8712 win 62780 (DF)
17:41:20.912884 < 194.217.242.22.pop3 > 193.237.65.219.32772: P 8706:8712(6) ack 36 win 8760 (DF)
