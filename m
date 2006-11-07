Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752286AbWKGGsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbWKGGsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 01:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWKGGsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 01:48:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47553 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751191AbWKGGsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 01:48:17 -0500
Message-ID: <45502C2E.20103@osdl.org>
Date: Mon, 06 Nov 2006 22:48:14 -0800
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: TCP stack sometimes loses ACKs ... or something
References: <17744.10620.389409.136737@cse.unsw.edu.au>
In-Reply-To: <17744.10620.389409.136737@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> I upgraded my notebook from 2.6.16 to 2.6.18 recently and noticed that
> I couldn't talk to my VOIP device (which has a WEB interface).
> Watching traffic I see the three-way-handshake working perfectly, and
> then the first data packet is sent (a partial HTTP request: 
> GET / HTTP/1.1 ....) and an ACK comes back from the device.
> Then the next data packet (remainder of the HTTP request) is sent, but
> tcpdump never sees the ACK, nor does the TCP stack.  So the data gets
> recent repeatedly.  No ack. Ever.
>
> With 2.6.16, The ack comes back just fine and the connection proceeds
> as you would expect.
>
> As it was a very reproducible problem I decided to try "git bisect"
> and found 
>
>  bad: [7b4f4b5ebceab67ce440a61081a69f0265e17c2a] [TCP]: Set default max buffers from memory pool size
>
> I double checked as this seemed a fairly unlikely patch to cause the
> problem, but this definitely is it.
> The net effect of this patch is to change the last of the three
> numbers in 
>     cat /proc/sys/net/ipv4/tcp_[rw]mem 
> from well below 2^20 to well above. 2^20 seems to be a significant
> number. I set tcp_wmem to that and the ACK was lost.  I set it to
> one less and the first ACK (at least) was accepted.
> I ended up setting both r and w to 100000 and everything is fine.
>
> Exploring more deeply, and comparing:
>   - a failing connection (to VIOP box, [rw]mem large)
>   - a working connection to VOIP box ([rw]mem small)
>   - a working connection to another machine ([rw]mem irrelevant).
> I find:
>
>   The VIOP returns MSS=1360 in the SYN/ACK packet.  Other machine
>     returns MSS=1460
>
>   The ack that is getting lost contains data as well as the
>   ACK. i.e. the same packet that ACKs at the TCP level includes the
>   HTTP level reply.
>   The matching ACK from the other machine (some Linux 2.6.8 I think)
>    is a data-less ACK followed very quickly by the HTTP reply in
>    a separate packet.
>
>   The 'Timestamps' option coming back from the VOIP box is a little
>   odd.  The Timestamp in the SYN/ACK is the same as the timestamp in
>   the next ACK (the ack for the first partial HTTP request).
>   The Timestamp in the next packet which is the one that gets lost has
>   exactly the same TSval as previous packets, and TSecr is one more
>   than in the previous packet.
>
> I assume that one (or more) of these differences combined with the
> large tcp_[rw]mem value cause the packet loss, but I have no idea
> which.
>
> Help?
>
> I can make the tcp traces available if needed, but these are really
> the only non-trivial differences.
>
> I'm willing to test patches.
>
> NeilBrown
>   

You almost certainly have a windows scale corrupting firewall in your path.
 See http://lwn.net/Articles/92727/

2.6.18 increased the maximum window size, so it aggravated a pre-existing
condition in your network. You can turn off window scaling globally 
(with sysctl)
or per route congestion window limit.

It could also be that VOIP application is getting aggravated by TCP ABC.
That can be turned off with sysctl (net.ipv4.tcp_abc=0)




