Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291063AbSBLOFe>; Tue, 12 Feb 2002 09:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291062AbSBLOFO>; Tue, 12 Feb 2002 09:05:14 -0500
Received: from 24.159.201.38.roc.nc.chartermi.net ([24.159.201.38]:3001 "EHLO
	24.159.201.38.roc.nc.chartermi.net") by vger.kernel.org with ESMTP
	id <S291061AbSBLOFD>; Tue, 12 Feb 2002 09:05:03 -0500
Date: Tue, 12 Feb 2002 08:05:00 -0600 (CST)
From: Dave Larson <davlarso@acm.org>
X-X-Sender: <davlarso@linus.davelarson.net>
To: <linux-kernel@vger.kernel.org>
cc: <tsbogend@alpha.franken.de>, <davlarso@acm.org>
Subject: Is this a bug in TCP or the PCNet32 driver?
Message-ID: <Pine.GSO.4.31.0202120728000.24018-100000@linus.davelarson.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been working on tracking down a problem I'm having with WinCE
maintainging a TCP connection with a linux system and I've now determined
that it is definitely an issue with linux, although specific to the
PCNet32 driver. Please bear with me, as this isn't the easiest thing to
explain.

The TCP code uses 2 variables to keep track of how much data it has
queued and how much data is pending transmission. sk->wmem_queued is
increased when it adds a skb to the tcp write queue, and decreased when an
ACK is received for the data in the skb. When actually sending data down
to the IP layer, it creates a clone of the skb on it's write queue and
calls skb_set_owner_w which will increase sk->wmem_alloc. That cloned skb
(at least in the cases I'm seeing) will make it down to the hardware driver
and wmem_alloc will be decreased when the skb is freed after transmission
is complete.

Then in the retransmission path there is this check, which I'm now
thinking is simply designed to prevent TCP from sending more data down to
the driver if it hasn't tranismissed what we've allready sent down to it.

/* Do not sent more than we queued. 1/4 is reserved for possible
 * copying overhead: frgagmentation, tunneling, mangling etc.
 */
if (atomic_read(&sk->wmem_alloc) > min(sk->wmem_queued+(sk->wmem_queued>>2),sk->sndbuf))
     return -EAGAIN;

Unfortunately this has a bad side effect when combined with a feature of
the PCNet32 driver designed to reduce the number of interrupts. Some of
the chipsets supported by this driver have a feature that allows tha driver
to selectively choose if it wants to received a interrupt when transmission
of a frame on the tx ring is complete. The current driver uses this to
only receive tx done interrupts when over half of the tx ring entries are
in use. This allows it to only take 1 tx done interrupt for about every 8
frames that are sent. But this also means that an skb whose data is on the
tx ring may not be freed until several other frames are transmitted, which
if there is only 1 active connection may take a very long time.

So here is what happens:

I have a device that opens a TCP connection with linux, but is very bad
about missing frames and is reliant on the retransmit timer in linux
retransmitting the frames that it missed. The window size advertised by
this device is very small, about 8k, wmem_queued usually ranges between
1000-7500 bytes for this connection. Depending on when the other side of
the connection misses a segment, the check in the TCP code can prevent
that segment from ever being retransmitted. It's waiting for wmem_alloc
to go below wmem_queued, but that will never happen unless there is other
network activity on the box that will cause the PCNet32 driver to start to
fill up it's tx ring and enable tx done interrupts.

So is this a bug with the TCP code, or is it a bug in the PCNet32 driver?

The way things are today, the TCP code rely on the hardware drivers to
free an skb as soon as it is transmitted. But in that case of PCNet32,
that doesn't happen. On the other hand, PCNet32 does seem reasonable in
it's attempts to reduce the number of interrupts, although that breaks the
tcp code in this case were these isn't much network activity.




