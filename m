Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263685AbRFCRn4>; Sun, 3 Jun 2001 13:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263695AbRFCRnq>; Sun, 3 Jun 2001 13:43:46 -0400
Received: from WARSL401PIP7.highway.telekom.at ([195.3.96.115]:52575 "HELO
	email04.aon.at") by vger.kernel.org with SMTP id <S263685AbRFCRnj>;
	Sun, 3 Jun 2001 13:43:39 -0400
Date: Sun, 3 Jun 2001 19:43:38 +0200
From: Eduard Hasenleithner <eduardh@aon.at>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.[45] 8139too nfs performance
Message-ID: <20010603194338.A8341@moserv.hasi>
Mail-Followup-To: Eduard Hasenleithner <eduardh@aon.at>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Starting with kernel 2.4.4 the nfs performance with the 8139too driver
is very bad. It seems there are interrupts missing, but the 8139
interrupt is not stuck.

Look at this tcpdump:

Server side ..

19:12:42.840489 192.168.1.1.2049 > 192.168.1.2.3717744806: reply ok 1472 (frag 29651:1480@0+)
19:12:42.840583 192.168.1.1 > 192.168.1.2: (frag 29651:1480@1480+)
19:12:42.840651 192.168.1.1 > 192.168.1.2: (frag 29651:1480@2960+)
19:12:42.840760 192.168.1.1 > 192.168.1.2: (frag 29651:1480@4440+)
19:12:42.840868 192.168.1.1 > 192.168.1.2: (frag 29651:1480@5920+)
19:12:42.840970 192.168.1.1 > 192.168.1.2: (frag 29651:928@7400)
19:12:43.525919 192.168.1.2.3717744806 > 192.168.30.1.2049: 116 read fh 0,24/3019440128 [|nfs] (DF)
19:12:43.526761 192.168.1.1.2049 > 192.168.1.2.3717744806: reply ok 1472 (frag 29652:1480@0+)
19:12:43.526857 192.168.1.1 > 192.168.1.2: (frag 29652:1480@1480+)

... and a similar event at the client side ...

19:20:22.665977 192.168.1.1.2049 > 192.168.1.2.1301891238: reply ok 1472 (frag 29741:1480@0+)
19:20:22.666099 192.168.1.1 > 192.168.1.2: (frag 29741:1480@1480+)
19:20:22.666222 192.168.1.1 > 192.168.1.2: (frag 29741:1480@2960+)
19:20:22.666342 192.168.1.1 > 192.168.1.2: (frag 29741:1480@4440+)
19:20:22.666467 192.168.1.1 > 192.168.1.2: (frag 29741:1480@5920+)
19:20:23.360031 192.168.1.2.1301891238 > 192.168.30.1.2049: 116 read fh 0,24/3019440128 [|nfs] (DF)
19:20:23.361095 192.168.1.1 > 192.168.1.2: (frag 29741:928@7400)
19:20:23.361114 192.168.1.1.2049 > 192.168.1.2.1301891238: reply ok 1472 (frag 29742:1480@0+)
19:20:23.361224 192.168.1.1 > 192.168.1.2: (frag 29742:1480@1480+)


Please notice the huge time lag of the last nfs reply fragment (frag 29741). 
Short after the client re-asks the server, it also gets the missing packet,
which is the last fragment of the IP Packet.

Sending ping(8) over the same link improves the performance a bit. The nfs
timeout is reduced to the time of the next ICMP echo request arriving.
So this IP packet can be seen as a reanimate packet for a lost interrupt.

There was already a Message on this list
"NFS-performance drop with 2.4.4 and 8139too"
but no result was posted. I tried the recommended patch with 2.4.5, but the
patch (for sched.c) was incompatible with 2.4.5.

It is strange to me that these effects do not happen with ftp traffic.
I perceive very good performance with ftp. Maybe because ftp is not using
fragmented IP packets.

any ideas?

PS:
I have a second linux client, with almost the same configuration (8139too) and
the same kernel (identical binary). On this host, the effects are also
existent, but happen far less often as with the reported host.
Even more confusing.
-- 
Eduard Hasenleithner
student of
Salzburg University of Applied Sciences and Technologies
