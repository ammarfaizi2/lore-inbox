Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267807AbUHPSNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267807AbUHPSNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267837AbUHPSNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:13:21 -0400
Received: from [66.199.228.3] ([66.199.228.3]:54802 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S267807AbUHPSNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:13:09 -0400
Date: Mon, 16 Aug 2004 11:13:08 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200408161813.i7GID8ia023528@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Possible 2.4.18 ipv4 memory leak?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a complete shot in the dark. I'm hoping someone has already
fixed this problem. I'm digging into the ipv4 tcp stack of 2.4.18 trying
to track the problem down, and the going is slow.

I have a ppc box running 2.4.18. It is connected over VDSL so we've got
a situation where this is both high bandwidth (> 10mbits) and high latency
(>28 msec), which is unusual.

Mostly the data is flowing into the box, with just a little bit of traffic
coming out. I can get the problem to occur very regularly if I cause a
A
tcp socket to be listening on the ppc box, and if someone on the other
end of the network connects to that port, the ppc box just keeps blasting
null bytes over the link.

What happens from the receiver's end is there is a packet lost in transmission
for whatever reason. More packets are coming in, the receiver starts
sending back SACKs showing the good data received range, and the sender is
supposed to realize there is a gap and retransmit. This does function correctly
sometimes. However when the problem occurs the sender doesn't ever send
the missing data, and eventually it stalls. Both sender + receiver just
stall forever and no more data is sent until one or the other end of the
link is terminated.

Below is a sample tcpdump from the receiver's end. Right after the
packet at 10:52:20.758031 there should be a packet containing the
window from 28172289:28176633. Could be more than one packet also.

Associated with the stall is a large memory loss on the ppc box's end.
My guess is the tcp/networking stack is not freeing up skb's or something.
Every stall is associated with the loss of several megabytes of system
memory that shows up in the buffers used area:
             total       used       free     shared    buffers     cached
Mem:         62884      61708       1176          0        464       8988
-/+ buffers/cache:      52256      10628
                        ^^^^^
Swap:            0          0          0
The 52256 keeps growing with each stall.

Our version of linux-2.4.18 is modified from the stock one to support
our custom hardware. The box is CPM8260 based. I've tried upgrading
the kernel to 2.4.19 but that didn't fix the problem. Beyond that I've
tried cutting the 2.4.20 net/ipv4 files and sticking them into 2.4.19,
but that didn't fix the problem either. Trying to modify 2.4.26 or 2.4.27
to suit our needs looks to be a lengthy task and I want to go there as
a last resort. I'm currently trying to dig into 2.4.18's ipv4/tcp stack
to try to fix the problem myself.

I've also tried turning off SACKing on the receiver, but this didn't
solve the problem. I did it by
echo 0 > /proc/sys/net/ipv4/tcp_sack
That turns off the SACKS from appearing in the tcp option field,
but makes no difference.

I've tried studying changelogs to no avail. I've also tried diff'ing
different versions of the kernel--and find *massive* differences
between sequential versions of the linux networking stack. Is it
really necessary to reinvent the whole thing with each new release?
I don't get it.

If anyone has any clue I'd appreciate advice. The problem is very likely
solved already in a newer version of linux, but it'd make our lives
easier if I can fix the existing version now as opposed to a larger
upgrade that might take a lot more time and possibly introduce new
issues.

Because the situation is somewhat atypical regarding bandwidth and
latency this supports the idea of a bug in the tcp stack--it could be
there but not discovered. Usually you have either an ethernet which
gives you high bandwidth and low latency, or you have a dialup which
gives you low bandwidth and high latency. But our situation is
different in that we've got high bandwidth and high latency together.
Latency is on the order of 28 msec.

Thanks for any help!
-Dave



10:52:19.720466 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28163601 win 63712 <nop,nop,timestamp 110024404 122053> (DF)
10:52:19.721540 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28163601:28165049(1448) ack 1 win 5792 <nop,nop,timestamp 122053 110024399> (DF)
10:52:19.722593 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28165049:28166497(1448) ack 1 win 5792 <nop,nop,timestamp 122053 110024399> (DF)
10:52:19.722605 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28166497 win 63712 <nop,nop,timestamp 110024404 122053> (DF)
10:52:20.754821 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28166497:28167945(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024399> (DF)
10:52:20.754851 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28167945 win 63712 <nop,nop,timestamp 110024507 122159> (DF)
10:52:20.755877 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28167945:28169393(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024399> (DF)
10:52:20.755891 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28169393 win 63712 <nop,nop,timestamp 110024507 122159> (DF)
10:52:20.756975 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28169393:28170841(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024399> (DF)
10:52:20.756988 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28170841 win 63712 <nop,nop,timestamp 110024507 122159> (DF)
10:52:20.758031 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: P 28170841:28172289(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024399> (DF)
10:52:20.758047 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024507 122159> (DF)
10:52:20.759086 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28176633:28178081(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024400> (DF)
10:52:20.759108 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024507 122159,nop,nop, sack 1 {28176633:28178081} > (DF)
10:52:20.760187 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28178081:28179529(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024400> (DF)
10:52:20.760211 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024508 122159,nop,nop, sack 1 {28176633:28179529} > (DF)
10:52:20.761247 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28179529:28180977(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024400> (DF)
10:52:20.761278 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024508 122159,nop,nop, sack 1 {28176633:28180977} > (DF)
10:52:20.762337 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28180977:28182425(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024400> (DF)
10:52:20.762350 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024508 122159,nop,nop, sack 1 {28176633:28182425} > (DF)
10:52:20.763393 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28182425:28183873(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024400> (DF)
10:52:20.763409 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024508 122159,nop,nop, sack 1 {28176633:28183873} > (DF)
10:52:20.764492 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28183873:28185321(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024401> (DF)
10:52:20.764505 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024508 122159,nop,nop, sack 1 {28176633:28185321} > (DF)
10:52:20.765548 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28185321:28186769(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024401> (DF)
10:52:20.765561 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024508 122159,nop,nop, sack 1 {28176633:28186769} > (DF)
10:52:20.766015 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: P 28186769:28187649(880) ack 1 win 5792 <nop,nop,timestamp 122159 110024401> (DF)
10:52:20.766032 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024508 122159,nop,nop, sack 1 {28176633:28187649} > (DF)
10:52:20.767319 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28187649:28189097(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.767332 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024508 122159,nop,nop, sack 1 {28176633:28189097} > (DF)
10:52:20.768372 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28191993:28193441(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.768385 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024508 122159,nop,nop, sack 2 {28191993:28193441}{28176633:28189097} > (DF)
10:52:20.769471 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28193441:28194889(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.769484 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024508 122159,nop,nop, sack 2 {28191993:28194889}{28176633:28189097} > (DF)
10:52:20.770528 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28194889:28196337(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.770559 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024509 122159,nop,nop, sack 2 {28191993:28196337}{28176633:28189097} > (DF)
10:52:20.771625 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28196337:28197785(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.771638 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024509 122159,nop,nop, sack 2 {28191993:28197785}{28176633:28189097} > (DF)
10:52:20.772681 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28197785:28199233(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.772694 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024509 122159,nop,nop, sack 2 {28191993:28199233}{28176633:28189097} > (DF)
10:52:20.773778 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28199233:28200681(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.773790 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024509 122159,nop,nop, sack 2 {28191993:28200681}{28176633:28189097} > (DF)
10:52:20.774833 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28200681:28202129(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.774845 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024509 122159,nop,nop, sack 2 {28191993:28202129}{28176633:28189097} > (DF)
10:52:20.775889 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28202129:28203577(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.775906 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024509 122159,nop,nop, sack 2 {28191993:28203577}{28176633:28189097} > (DF)
10:52:20.776987 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28203577:28205025(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.776999 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024509 122159,nop,nop, sack 2 {28191993:28205025}{28176633:28189097} > (DF)
10:52:20.778043 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28205025:28206473(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.778055 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024509 122159,nop,nop, sack 2 {28191993:28206473}{28176633:28189097} > (DF)
10:52:20.779142 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28206473:28207921(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.779154 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024509 122159,nop,nop, sack 2 {28191993:28207921}{28176633:28189097} > (DF)
10:52:20.780197 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28207921:28209369(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.780222 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024510 122159,nop,nop, sack 2 {28191993:28209369}{28176633:28189097} > (DF)
10:52:20.781295 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28209369:28210817(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.781314 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024510 122159,nop,nop, sack 2 {28191993:28210817}{28176633:28189097} > (DF)
10:52:20.782351 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28210817:28212265(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.782364 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024510 122159,nop,nop, sack 2 {28191993:28212265}{28176633:28189097} > (DF)
10:52:20.783450 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28212265:28213713(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.783462 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024510 122159,nop,nop, sack 2 {28191993:28213713}{28176633:28189097} > (DF)
10:52:20.784505 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28213713:28215161(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.784517 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024510 122159,nop,nop, sack 2 {28191993:28215161}{28176633:28189097} > (DF)
10:52:20.785602 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28215161:28216609(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.785614 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024510 122159,nop,nop, sack 2 {28191993:28216609}{28176633:28189097} > (DF)
10:52:20.786661 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28216609:28218057(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.786691 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024510 122159,nop,nop, sack 2 {28191993:28218057}{28176633:28189097} > (DF)
10:52:20.787756 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28218057:28219505(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.787773 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024510 122159,nop,nop, sack 2 {28191993:28219505}{28176633:28189097} > (DF)
10:52:20.788812 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28219505:28220953(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.788824 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024510 122159,nop,nop, sack 2 {28191993:28220953}{28176633:28189097} > (DF)
10:52:20.789867 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28220953:28222401(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.789879 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024510 122159,nop,nop, sack 2 {28191993:28222401}{28176633:28189097} > (DF)
10:52:20.790964 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28222401:28223849(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.790983 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024511 122159,nop,nop, sack 2 {28191993:28223849}{28176633:28189097} > (DF)
10:52:20.792022 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28223849:28225297(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.792035 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024511 122159,nop,nop, sack 2 {28191993:28225297}{28176633:28189097} > (DF)
10:52:20.793123 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28225297:28226745(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.793138 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024511 122159,nop,nop, sack 2 {28191993:28226745}{28176633:28189097} > (DF)
10:52:20.794174 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28226745:28228193(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.794186 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024511 122159,nop,nop, sack 2 {28191993:28228193}{28176633:28189097} > (DF)
10:52:20.795273 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28228193:28229641(1448) ack 1 win 5792 <nop,nop,timestamp 122159 110024404> (DF)
10:52:20.795286 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024511 122159,nop,nop, sack 2 {28191993:28229641}{28176633:28189097} > (DF)
10:52:20.796329 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28229641:28231089(1448) ack 1 win 5792 <nop,nop,timestamp 122161 110024507> (DF)
10:52:20.796346 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024511 122159,nop,nop, sack 2 {28191993:28231089}{28176633:28189097} > (DF)
10:52:20.797424 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28231089:28232537(1448) ack 1 win 5792 <nop,nop,timestamp 122161 110024507> (DF)
10:52:20.797437 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024511 122159,nop,nop, sack 2 {28191993:28232537}{28176633:28189097} > (DF)
10:52:20.798480 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28232537:28233985(1448) ack 1 win 5792 <nop,nop,timestamp 122161 110024507> (DF)
10:52:20.798492 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024511 122159,nop,nop, sack 2 {28191993:28233985}{28176633:28189097} > (DF)
10:52:20.799579 eth0 < 172.30.32.41.4779 > 172.30.20.2.33879: . 28233985:28235433(1448) ack 1 win 5792 <nop,nop,timestamp 122161 110024507> (DF)
10:52:20.799596 eth0 > 172.30.20.2.33879 > 172.30.32.41.4779: . 1:1(0) ack 28172289 win 63712 <nop,nop,timestamp 110024511 122159,nop,nop, sack 2 {28191993:28235433}{28176633:28189097} > (DF)
