Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317440AbSGIW0z>; Tue, 9 Jul 2002 18:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317439AbSGIW0y>; Tue, 9 Jul 2002 18:26:54 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:16858 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S317440AbSGIW0x>; Tue, 9 Jul 2002 18:26:53 -0400
Date: Tue, 9 Jul 2002 16:29:35 -0600 (MDT)
From: "Hurwitz Justin W." <hurwitz@lanl.gov>
To: linux-kernel@vger.kernel.org
Subject: How many copies to get from NIC RX to user read()?
Message-ID: <Pine.LNX.4.44.0207091625460.2905-100000@alvie-mail.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please Cc: me in your responses.

The story so far: 

I've been continuing to muck around with the stack, trying both to improve
overall performance, and specifically to improve rx relative to tx
performance, primarily in gig-and-beyond (e.g., Quadrics)  environments.

To this end, I have begun by profiling and analyzing the RX side stack.
The profiling is being done as I write, and the analysis is what prompts
me to write.


The direct question:

How many times is data copied between the time that it is received at the
NIC and when the user's call to read() returns the data?


The reason for the question:

I could've sworn I heard the stack was single-copy on both the TX and RX
sides. But, it doesn't look to me like it is. Rather, it looks like there
is one copy in tcp_rcv_estabilshed() (via tcp_copy_to_iovec()), and a
second copy in tcp_recvmsg() (which is called when the user calls read()).
Both of these copies are, I believe, done by skb_copy_datagram_iovec().


The ancilary questions:

If I am wrong about this- does anyone care to publicly humiliate me by
telling me how/why (and possibly calling me stupid)?

If I am right about this- is there a specific reason that it is
implemented this way? Are there any thoughts on changing it? Our specific
inclination is to keep the skbs around until the user calls read(), at
which point we do an iovec memcopy to the userspace buffer, eliminating a
copy- the danger here is if the user doesn't read from the socket, this
might needlessly lock up skbs. To avoid this, we can implement either some
watermark or timeout for skb-consilidation- if the user doesn't call
read() soon enough or before too many skbs are used we copy the skbs to a
socket buffer like normal.


Cheers,
--Gus

