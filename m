Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSKCOR7>; Sun, 3 Nov 2002 09:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbSKCOR7>; Sun, 3 Nov 2002 09:17:59 -0500
Received: from mx1.toplink-plannet.de ([212.126.200.57]:17555 "EHLO
	mx1.toplink-plannet.de") by vger.kernel.org with ESMTP
	id <S261907AbSKCOR6>; Sun, 3 Nov 2002 09:17:58 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Found weird packets using ULOG accounting
Mail-Copies-To: nobody
From: Hilko Bengen <bengen@vdst-ka.inka.de>
Date: 03 Nov 2002 15:22:48 +0100
Message-ID: <87smyiybpj.fsf@ataraxia.vodkafone.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Netfilter's userspace logging target target seemed perfect for doing
IP accounting, so I wrote an accounting daemon that collects the
beginning of IP packets from this target and creates IP accounting
information from the packets gathered. The program's name is
ulog-acctd. Part of the code stems from net-acct, and can be
downloaded from http://savannah.nongnu.org/projects/ulog-acctd/ .

For IP accounting purposes, copy_range 44 is usually okay--we haven't
seen any IPv4 packets here with IP header lengths > 40, so far, and
from UDP/TCP/ICMP headers, we only need the first four bytes.. 
Queue_threshold is set to 50, which is the highest possible value.

I open a socket

    capture_sd=socket(PF_NETLINK, SOCK_RAW, NETLINK_NFLOG);

from which I get Netlink messages which in turn contain IP packets or
parts of IP packets as their payload.

This generally works quite well; however, every now and then the
payload of some of the Netlink messages is considerably shorter than
the copy range (mostly between 20 and 24 bytes) and even the tot_len
field in the IP header is too short.

Here are some example packets (I have masked source and destination
address) that were observed on different routers running Linux 2.4.19.

45 00 00 14 51 3A 00 00 2C 11 79 E2 xx xx xx xx yy yy yy yy
45 00 00 14 51 3B 00 00 2C 11 79 E1 xx xx xx xx yy yy yy yy
45 00 00 14 51 3C 00 00 2C 11 79 E0 xx xx xx xx yy yy yy yy
45 00 00 14 51 3D 00 00 2C 11 79 DF xx xx xx xx yy yy yy yy

45 10 00 17 07 B4 00 B9 FD 2F DF EA xx xx xx xx yy yy yy yy 3E 0D 0A
45 10 00 17 07 B9 00 B9 FD 2F DF E5 xx xx xx xx yy yy yy yy 3E 0D 0A
45 00 00 16 00 51 00 B9 FD 2F E7 5E xx xx xx xx yy yy yy yy 3E 0A

45 10 00 17 03 B0 00 B9 FD 2F E3 EE xx xx xx xx yy yy yy yy 3E 0D 0A 

45 00 00 16 02 2D 00 B9 FD 2F E5 82 xx xx xx xx yy yy yy yy 0D 0A 

45 00 00 17 00 45 00 B9 FD 2F E7 69 xx xx xx xx yy yy yy yy 00 00 00 

45 00 00 15 A8 15 00 B9 FA 2F 42 9B xx xx xx xx yy yy yy yy 0A 

45 08 00 15 00 1B 00 B9 FD 2F E7 8D xx xx xx xx yy yy yy yy 0A 
45 08 00 15 00 21 00 B9 FD 2F E7 87 xx xx xx xx yy yy yy yy 0A 

45 00 00 16 05 9E 00 B9 FD 2F E2 11 xx xx xx xx yy yy yy yy 0D 0A 

Looks like the packets were too short to begin with.

What disturbs me most is that none of these packets seem to have a
function. The first four packets are UDP packets and don't even have a
UDP header. The other packets are Generic Routing Encapsulation (GRE)
packets, and according to RfC2874, the GRE header size is 8 bytes.
Therefore none of these packets are valid!

Are these short packets just an attack on the target hosts, or could
this be a bug somewhere in the kernel's IP handling or Netfilter
itself?

-Hilko
