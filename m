Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265193AbRF0BEr>; Tue, 26 Jun 2001 21:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbRF0BEi>; Tue, 26 Jun 2001 21:04:38 -0400
Received: from sense-robertk-129.oz.net ([216.39.160.129]:19072 "HELO
	mail.kleemann.org") by vger.kernel.org with SMTP id <S265193AbRF0BEX>;
	Tue, 26 Jun 2001 21:04:23 -0400
Date: Tue, 26 Jun 2001 18:04:19 -0700 (PDT)
From: Robert Kleemann <robert@kleemann.org>
X-X-Sender: <robert@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <Pine.LNX.4.33.0106161643560.1137-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0106261757530.1135-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SUMMARY:

The bad network behavior was due to shared irqs somehow screwing
things up.  This explained most but not all of the problems.

DETAILS:

Many people emailed me that they were experiencing similar problems.
Even though the cause of my problem is not kernel related, I'm hoping
my narrative and eventual solution will helps some folks.  I also
still think this behavior is really weird so those of you with an
abundance of brains and curiosity might want to take a guess at
explaining the behavior that I'm seeing.

When I last posted I had a reproducible test case which spewed a bunch
of packets from a server to a client.  The behavior is that the client
eventually stops ACKing and so the the connection stalls indefinitely.
I spent some time studying the kernel networking code and traced the
code path taken by a tcp packet:

linux/net/core/dev.c:netif_rx() // packet received by eth card
linux/net/ipv4/ip_input.c:ip_rcv()
linux/net/ipv4/ip_input.c:ip_rcv_finish()
linux/net/ipv4/tcp_ipv4.c:tcp_v4_recv()
linux/net/ipv4/tcp_ipv4.c:tcp_v4_do_rcv()
linux/net/ipv4/tcp_input.c:tcp_rcv_established() // packet placed in user queue

Each routine had 2 to 6 conditions that would result in a dropped
packet.  I added printk statements for each of these conditions in
hopes of detecting why the final packet is not acked.  I recompiled
the kernel, and reran the test.  The result was that the packet was
being droped in tcp_rcv_established() due to an invalid checksum.  I
then ran tcpdump to verify that the packets sent from the server were
the same packets that were received by the client.  It turned out that
one byte was being corrupted and it was always the same byte in the
stream that was corrupted.

This was very confusing because my previous logs show _no_ corruption
of the final packet.

Anyway, now it appeared to be a hardware related problem so I started
swapping ethernet cards to no effect.  I then look at the irqs (cat
/proc/interrupts) and noticed that the ethernet card in the client was
sharing an irq with the aic7xxx scsi adapter. The following url made
me think that this could be causing a problem:
http://www.scyld.com/expert/irq-conflict.html

The motherboard on the client is an old Intel PR440FX (dual 200mhz
PPro, onboard LAN, SCSI) and doesn't allow any kind of configuring of
the irqs so I ended up throwing another pci net card in the box just
to juggle the irqs enough so that one of the net cards was not sharing
an irq with the scsi card.  The bug no longer repros!  Neither the
reduced test case nor the original shows any problems.

My only remaining questions are:

1) Does this make sense?  Would a scsi card sharing an irq with a net
   card cause rare but highly reproducable corruption?  I was able to
   run http, telnet, ftp, mail, and games though this card with no
   problems.  It only failed on a specific set of data.  This is what
   initially led me to believe that the problem was not hardware
   related.

2) Now that two net cards are sharing an irq, have I just trading one
   subtle corruption bug for another?  Will some different data set
   cause the same type of corruption?  Is it safe to share irqs?

3) My old tcpdump logs (from several weeks ago) show _no_ corruption.
   I would have believed that I must have screwed up except that I
   still have the logs and the packets sent from the server compare
   exactly with those received by the client.  I can't seem to
   reproduce this behavior.

Robert.

