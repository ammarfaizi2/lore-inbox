Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282818AbRK0G27>; Tue, 27 Nov 2001 01:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282817AbRK0G2k>; Tue, 27 Nov 2001 01:28:40 -0500
Received: from c38889-c.grlnd1.tx.home.com ([24.4.38.23]:40708 "HELO
	webby.quo.to") by vger.kernel.org with SMTP id <S282816AbRK0G2Y>;
	Tue, 27 Nov 2001 01:28:24 -0500
Message-ID: <00f201c1770c$b4418430$024d460a@neptune>
From: "Jordan Russell" <jr-list-kernel@quo.to>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4 TCP performance difference - feature or flaw?
Date: Tue, 27 Nov 2001 00:28:19 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've encountered an odd difference in TCP performance between the 2.4.15 and
2.2.20 kernels. Perhaps someone can explain this phenomenon...
(I'm not a kernel hacker.)

Background:
I administer my Linux box over a LAN via SSH2 from a Windows 2000 machine.
OpenSSH 3.0.1 is used on the Linux side and PuTTY on the Windows side.

The issue:
I have my keyboard repeat rate set high (31 chars/sec). When I'm SSH'ed into
Linux and I hold down a letter key (for example), it does not repeat
"smoothly" with a 2.4 kernel installed. The characters seem to show up about
2 at a time. It's as if I'm going over a high-latency connection; I'm not.

If I revert to 2.2.20, this effect does not occur. It also does not occur
when I SSH into OpenBSD 2.9.

So apparently the effect is caused by some change in the 2.4 kernel. But I'm
very curious to know what it is, and if there is maybe some way to go back
to the "old" behavior. (It drives me nuts!)

tcpdump seems to shed some light. Here are some tcpdump log excerpts of keys
being repeated and echoed back...

Linux 2.4.15
- Notice that there is a 40 millisecond delay every 5 packets. This won't do
because the keys repeat faster than that!

20:33:47.174648 w2k.1616 > lnx.ssh: P 264:308(44) ack 133 win 16860 (DF)
20:33:47.174675 lnx.ssh > w2k.1616: . ack 308 win 16080 (DF) [tos 0x10]
20:33:47.174902 lnx.ssh > w2k.1616: P 133:177(44) ack 308 win 16080 (DF)
[tos 0x10]
20:33:47.175564 w2k.1616 > lnx.ssh: P 308:352(44) ack 177 win 16816 (DF)
20:33:47.210744 lnx.ssh > w2k.1616: . ack 352 win 16080 (DF) [tos 0x10]
20:33:47.210945 w2k.1616 > lnx.ssh: P 352:396(44) ack 177 win 16816 (DF)
20:33:47.210969 lnx.ssh > w2k.1616: . ack 396 win 16080 (DF) [tos 0x10]
20:33:47.211181 lnx.ssh > w2k.1616: P 177:221(44) ack 396 win 16080 (DF)
[tos 0x10]
20:33:47.211632 w2k.1616 > lnx.ssh: P 396:440(44) ack 221 win 16772 (DF)
20:33:47.250743 lnx.ssh > w2k.1616: . ack 440 win 16080 (DF) [tos 0x10]
20:33:47.250940 w2k.1616 > lnx.ssh: P 440:484(44) ack 221 win 16772 (DF)
20:33:47.250963 lnx.ssh > w2k.1616: . ack 484 win 16080 (DF) [tos 0x10]
20:33:47.251181 lnx.ssh > w2k.1616: P 221:265(44) ack 484 win 16080 (DF)
[tos 0x10]
20:33:47.251629 w2k.1616 > lnx.ssh: P 484:528(44) ack 265 win 16728 (DF)
20:33:47.290744 lnx.ssh > w2k.1616: . ack 528 win 16080 (DF) [tos 0x10]

Linux 2.2.20
- The 40 millisecond delay isn't there. The packets seem to be sent/received
at the right time.

20:39:45.278313 w2k.1628 > lnx.ssh: P 264:308(44) ack 133 win 17388 (DF)
20:39:45.278712 lnx.ssh > w2k.1628: P 133:177(44) ack 308 win 32120 (DF)
[tos 0x10]
20:39:45.279166 w2k.1628 > lnx.ssh: P 308:352(44) ack 177 win 17344 (DF)
20:39:45.298612 lnx.ssh > w2k.1628: . ack 352 win 32120 (DF) [tos 0x10]
20:39:45.309020 w2k.1628 > lnx.ssh: P 352:396(44) ack 177 win 17344 (DF)
20:39:45.309407 lnx.ssh > w2k.1628: P 177:221(44) ack 396 win 32120 (DF)
[tos 0x10]
20:39:45.309816 w2k.1628 > lnx.ssh: P 396:440(44) ack 221 win 17300 (DF)
20:39:45.328613 lnx.ssh > w2k.1628: . ack 440 win 32120 (DF) [tos 0x10]
20:39:45.339798 w2k.1628 > lnx.ssh: P 440:484(44) ack 221 win 17300 (DF)
20:39:45.340039 lnx.ssh > w2k.1628: P 221:265(44) ack 484 win 32120 (DF)
[tos 0x10]
20:39:45.340587 w2k.1628 > lnx.ssh: P 484:528(44) ack 265 win 17256 (DF)
20:39:45.358612 lnx.ssh > w2k.1628: . ack 528 win 32120 (DF) [tos 0x10]


Thanks,
Jordan Russell

