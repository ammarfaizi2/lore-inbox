Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbRFMIsv>; Wed, 13 Jun 2001 04:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbRFMIsl>; Wed, 13 Jun 2001 04:48:41 -0400
Received: from ns.suse.de ([213.95.15.193]:15623 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S261347AbRFMIs0>;
	Wed, 13 Jun 2001 04:48:26 -0400
To: Robert Kleemann <robert@kleemann.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <Pine.LNX.4.33.0106121720310.1152-100000@localhost.localdomain.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Jun 2001 10:48:19 +0200
In-Reply-To: Robert Kleemann's message of "13 Jun 2001 02:36:06 +0200"
Message-ID: <oup1yoon4to.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Kleemann <robert@kleemann.org> writes:

> I have a client server program that opens a tcp connection between two
> machines.  Everything is fine until a certain type of data is sent
> across the socket at which point the client refuses to ACK and the
> server continues to resend the packets to no avail.
> 
> I've verified that the client is blocking on a socket read (and not
> coming out) I've also run "tcpdump -lxa -s 5000" on each machine and
> verified that each packet sent by each machine is received by the
> other.  I diffed the data and there appears to be no corruption.
> 
> I first saw this with the server running 2.4.2 and the client running
> 2.2.16 but I have since upgraded the server first to 2.4.5 and then
> also added a patch from 1.4.6-pre2 that had to do with tcp acks.  The
> bug still repros.  I have also upgraded the client to 2.4.2, 2.4.5,
> and 2.4.5 + ack patch with no luck.
> 
> There have been quite a few other people who have experienced these
> symptoms and posted to the list over the past 5 months or so.  I
> haven't seen a resolution for any of them except for requests to try
> the latest kernel since there have been a lot of networking fixes in
> the latest kernels.  I have appened links to these other postings at
> the end of this email in case their data might help.
> 
> I can consistently reproduce this problem on my machines (10mbs
> ethernet lan) and would really like to narrow this bug down to the
> source instead of trying the latest kernels and hoping that they solve
> the problem. The networking code (net/ipv4/tcp*.c) is daunting to me
> but if someone has any suggestions on good places to add debug code,
> building a debug version, or whatever, I can try it on my local system
> and investigate further.  This bug is driving me crazy and I want to
> find it and fix it!
> 
> Are there any other details that would help?  My hardware
> configuration? Network settings? etc?

The packet likely doesn't fit into the socket buffer and is silently 
dropped. The TCP stack doesn't force an ACK in this case, but it 
probably should, although it wouldn't solve the deadlock. The deadlock
will be only solved if the local application reads data and clears the
socket buffer. If you have a single packet that is bigger than the
empty socket buffer / 2 you lose.

You can check the allocated socket buffer size using netstat.  

You can increase it using the /proc/sys/net/core/rmem_{default,max} 
sysctls; in 2.4 there is also a TCP memory limit that can be tuned
using /proc/sys/net/ipv4/tcp_mem. Doubling one of these will probably
fix your problems. 

Normally the socket buffer should not overflow if the sender honors 
the TCP window protocol, but there are some corner cases where it can
still happen, e.g. when the application sends lots of small packets
(which all have fixed metadata overhead) or the device driver always
hands full MTU sized packets to the stack.

2.4.4+ has some fixes that should make these corner cases less likely.
It cannot be completely solved unfortunately.


-Andi

