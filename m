Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263066AbTDBRLz>; Wed, 2 Apr 2003 12:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263068AbTDBRLz>; Wed, 2 Apr 2003 12:11:55 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:33762 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S263066AbTDBRLw>;
	Wed, 2 Apr 2003 12:11:52 -0500
Subject: Re: loopback behaviour under high load ...
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.50.0304020821250.1758-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0304011826340.1932-100000@blue1.dev.mcafeelabs.com>
	 <Pine.LNX.4.50.0304020821250.1758-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049304194.25168.56.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 02 Apr 2003 19:23:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-02 at 18:23, Davide Libenzi wrote:
> On Tue, 1 Apr 2003, Davide Libenzi wrote:
> 
> > And netstat shows Recv-Q=0 for the server socket, and Send-Q=N for the
> > client socket. This has been tested on 2.5.66 vanilla.
> 
> An update on this. Kernel 2.4.20+epoll does not have this problem.

I see something similar with 2.5.64-bk10 (seen with earlier 2.5 kernels
as well).

I use distcc on my machine which is running 2.5.64-bk10 and using two
remote servers running 2.4.20 to do the compiling.

Sometimes I see a ~120s stall in the middle of a connection with
Recv-Q=0 on the server (2.4.20) and Send-Q=N on the client (2.5.64-bk10)
(it's the client that's sending data to the server)

x.x.x.x = client
y.y.y.y = server

As you can see there's a long delay between 16:02:09 and 16:04:24

There's some packetloss here (probably a congested interface in the
router on the way). The dump was made on the client.

I've included a lot of the dump to give some context.

It appears the 111073:112497(1424) packet at 16:02:09.597800 going to
the server was dropped and the server continues acking the previous
packet. It takes a very long time until the client resends the missing
packet and it appears it's been dropped once again. Then no packets are
sent in either direction until the missing packet is retransmitted after
a 120s timeout and the connection continues.

(I hope there isn't any missing packets in this dump, libpcap without
mmap dropped a lot but with mmap support it said it didn't drop a single
packet)

[snip]
16:02:09.445650 x.x.x.x.57798 > y.y.y.y.3632: . 95409:96833(1424) ack 1 win 730 <nop,nop,timestamp 1466331049 143345355> (DF)
16:02:09.445665 x.x.x.x.57798 > y.y.y.y.3632: P 96833:98257(1424) ack 1 win 730 <nop,nop,timestamp 1466331049 143345355> (DF)
16:02:09.445683 x.x.x.x.57798 > y.y.y.y.3632: . 98257:99681(1424) ack 1 win 730 <nop,nop,timestamp 1466331049 143345355> (DF)
16:02:09.445695 x.x.x.x.57798 > y.y.y.y.3632: . 99681:101105(1424) ack 1 win 730 <nop,nop,timestamp 1466331049 143345355> (DF)
16:02:09.451822 y.y.y.y.3632 > x.x.x.x.57798: . ack 84017 win 64080 <nop,nop,timestamp 143345356 1466331042> (DF)
16:02:09.452573 y.y.y.y.3632 > x.x.x.x.57798: . ack 86865 win 64080 <nop,nop,timestamp 143345356 1466331048> (DF)
16:02:09.452740 y.y.y.y.3632 > x.x.x.x.57798: . ack 89713 win 64080 <nop,nop,timestamp 143345356 1466331048> (DF)
16:02:09.452989 y.y.y.y.3632 > x.x.x.x.57798: . ack 92561 win 64080 <nop,nop,timestamp 143345356 1466331048> (DF)
16:02:09.453352 y.y.y.y.3632 > x.x.x.x.57798: . ack 95409 win 64080 <nop,nop,timestamp 143345356 1466331049> (DF)
16:02:09.454195 y.y.y.y.3632 > x.x.x.x.57798: . ack 98257 win 64080 <nop,nop,timestamp 143345356 1466331049> (DF)
16:02:09.454400 y.y.y.y.3632 > x.x.x.x.57798: . ack 101105 win 64080 <nop,nop,timestamp 143345356 1466331049> (DF)
16:02:09.597688 x.x.x.x.57798 > y.y.y.y.3632: P 101105:102529(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.597702 x.x.x.x.57798 > y.y.y.y.3632: . 102529:103953(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.597721 x.x.x.x.57798 > y.y.y.y.3632: . 103953:105377(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.597734 x.x.x.x.57798 > y.y.y.y.3632: P 105377:106801(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.597755 x.x.x.x.57798 > y.y.y.y.3632: . 106801:108225(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.597768 x.x.x.x.57798 > y.y.y.y.3632: . 108225:109649(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.597787 x.x.x.x.57798 > y.y.y.y.3632: . 109649:111073(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.597800 x.x.x.x.57798 > y.y.y.y.3632: . 111073:112497(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.597818 x.x.x.x.57798 > y.y.y.y.3632: P 112497:113921(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.597832 x.x.x.x.57798 > y.y.y.y.3632: . 113921:115345(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.597849 x.x.x.x.57798 > y.y.y.y.3632: . 115345:116769(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.597862 x.x.x.x.57798 > y.y.y.y.3632: P 116769:118193(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.597903 x.x.x.x.57798 > y.y.y.y.3632: . 118193:119617(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.597915 x.x.x.x.57798 > y.y.y.y.3632: . 119617:121041(1424) ack 1 win 730 <nop,nop,timestamp 1466331201 143345356> (DF)
16:02:09.610011 y.y.y.y.3632 > x.x.x.x.57798: . ack 103953 win 64080 <nop,nop,timestamp 143345372 1466331201> (DF)
16:02:09.610486 y.y.y.y.3632 > x.x.x.x.57798: . ack 106801 win 64080 <nop,nop,timestamp 143345372 1466331201> (DF)
16:02:09.610899 y.y.y.y.3632 > x.x.x.x.57798: . ack 109649 win 64080 <nop,nop,timestamp 143345372 1466331201> (DF)
16:02:09.611921 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345372 1466331201,nop,nop,sack sack 1 {113921:115345} > (DF)
16:02:09.611944 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345372 1466331201,nop,nop,sack sack 1 {113921:116769} > (DF)
16:02:09.611963 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345372 1466331201,nop,nop,sack sack 1 {113921:118193} > (DF)
16:02:09.611996 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345372 1466331201,nop,nop,sack sack 1 {113921:119617} > (DF)
16:02:09.703860 x.x.x.x.57798 > y.y.y.y.3632: P 121041:122465(1424) ack 1 win 730 <nop,nop,timestamp 1466331307 143345372> (DF)
16:02:09.703873 x.x.x.x.57798 > y.y.y.y.3632: . 122465:123889(1424) ack 1 win 730 <nop,nop,timestamp 1466331307 143345372> (DF)
16:02:09.703892 x.x.x.x.57798 > y.y.y.y.3632: . 123889:125313(1424) ack 1 win 730 <nop,nop,timestamp 1466331307 143345372> (DF)
16:02:09.703908 x.x.x.x.57798 > y.y.y.y.3632: P 125313:126737(1424) ack 1 win 730 <nop,nop,timestamp 1466331307 143345372> (DF)
16:02:09.703926 x.x.x.x.57798 > y.y.y.y.3632: . 126737:128161(1424) ack 1 win 730 <nop,nop,timestamp 1466331307 143345372> (DF)
16:02:09.703939 x.x.x.x.57798 > y.y.y.y.3632: . 128161:129585(1424) ack 1 win 730 <nop,nop,timestamp 1466331307 143345372> (DF)
16:02:09.705559 x.x.x.x.57798 > y.y.y.y.3632: P 129585:131009(1424) ack 1 win 730 <nop,nop,timestamp 1466331307 143345372> (DF)
16:02:09.705565 x.x.x.x.57798 > y.y.y.y.3632: . 131009:132433(1424) ack 1 win 730 <nop,nop,timestamp 1466331307 143345372> (DF)
16:02:09.705570 x.x.x.x.57798 > y.y.y.y.3632: . 132433:133857(1424) ack 1 win 730 <nop,nop,timestamp 1466331307 143345372> (DF)
16:02:09.705574 x.x.x.x.57798 > y.y.y.y.3632: P 133857:135281(1424) ack 1 win 730 <nop,nop,timestamp 1466331307 143345372> (DF)
16:02:09.705578 x.x.x.x.57798 > y.y.y.y.3632: . 135281:136705(1424) ack 1 win 730 <nop,nop,timestamp 1466331307 143345372> (DF)
16:02:09.714200 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345382 1466331201,nop,nop,sack sack 2 {121041:122465}{113921:119617} > (DF)
16:02:09.714499 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345382 1466331201,nop,nop,sack sack 2 {121041:123889}{113921:119617} > (DF)
16:02:09.714698 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345382 1466331201,nop,nop,sack sack 2 {121041:125313}{113921:119617} > (DF)
16:02:09.714772 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345382 1466331201,nop,nop,sack sack 2 {121041:126737}{113921:119617} > (DF)
16:02:09.715358 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345382 1466331201,nop,nop,sack sack 2 {121041:128161}{113921:119617} > (DF)
16:02:09.715361 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345382 1466331201,nop,nop,sack sack 2 {121041:129585}{113921:119617} > (DF)
16:02:09.715550 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345382 1466331201,nop,nop,sack sack 2 {121041:131009}{113921:119617} > (DF)
16:02:09.715552 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345382 1466331201,nop,nop,sack sack 2 {121041:132433}{113921:119617} > (DF)
16:02:09.715672 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345383 1466331201,nop,nop,sack sack 2 {121041:133857}{113921:119617} > (DF)
16:02:09.715675 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345383 1466331201,nop,nop,sack sack 2 {121041:135281}{113921:119617} > (DF)
16:02:09.715677 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345383 1466331201,nop,nop,sack sack 2 {121041:136705}{113921:119617} > (DF)
16:02:09.808712 x.x.x.x.57798 > y.y.y.y.3632: . 136705:138129(1424) ack 1 win 730 <nop,nop,timestamp 1466331412 143345382> (DF)
16:02:09.808735 x.x.x.x.57798 > y.y.y.y.3632: P 138129:139548(1419) ack 1 win 730 <nop,nop,timestamp 1466331412 143345382> (DF)
16:02:09.808784 x.x.x.x.57798 > y.y.y.y.3632: . 111073:112497(1424) ack 1 win 730 <nop,nop,timestamp 1466331412 143345382> (DF)
16:02:09.808813 x.x.x.x.57798 > y.y.y.y.3632: P 112497:113921(1424) ack 1 win 730 <nop,nop,timestamp 1466331412 143345382> (DF)
16:02:09.808838 x.x.x.x.57798 > y.y.y.y.3632: . 119617:121041(1424) ack 1 win 730 <nop,nop,timestamp 1466331412 143345383> (DF)
16:02:09.822496 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345393 1466331201,nop,nop,sack sack 2 {121041:138129}{113921:119617} > (DF)
16:02:09.822498 y.y.y.y.3632 > x.x.x.x.57798: . ack 111073 win 64080 <nop,nop,timestamp 143345393 1466331201,nop,nop,sack sack 2 {121041:139548}{113921:119617} > (DF)
16:04:24.936079 x.x.x.x.57798 > y.y.y.y.3632: . 111073:112497(1424) ack 1 win 730 <nop,nop,timestamp 1466466560 143345393> (DF)
16:04:24.938582 y.y.y.y.3632 > x.x.x.x.57798: . ack 112497 win 62656 <nop,nop,timestamp 143358906 1466466560,nop,nop,sack sack 2 {121041:139548}{113921:119617} > (DF)
16:04:24.939909 x.x.x.x.57798 > y.y.y.y.3632: P 112497:113921(1424) ack 1 win 730 <nop,nop,timestamp 1466466563 143358906> (DF)
16:04:24.939937 x.x.x.x.57798 > y.y.y.y.3632: . 119617:121041(1424) ack 1 win 730 <nop,nop,timestamp 1466466563 143358906> (DF)
16:04:24.942568 y.y.y.y.3632 > x.x.x.x.57798: . ack 119617 win 55536 <nop,nop,timestamp 143358906 1466466563,nop,nop,sack sack 1 {121041:139548} > (DF)
16:04:24.942573 y.y.y.y.3632 > x.x.x.x.57798: . ack 139548 win 46992 <nop,nop,timestamp 143358906 1466466563> (DF)
16:04:25.038755 y.y.y.y.3632 > x.x.x.x.57798: P 1:1166(1165) ack 139548 win 64080 <nop,nop,timestamp 143358916 1466466563> (DF)
16:04:25.038765 y.y.y.y.3632 > x.x.x.x.57798: F 1166:1166(0) ack 139548 win 64080 <nop,nop,timestamp 143358916 1466466563> (DF)
16:04:25.038893 x.x.x.x.57798 > y.y.y.y.3632: . ack 1166 win 1019 <nop,nop,timestamp 1466466662 143358916> (DF)
16:04:25.039286 x.x.x.x.57798 > y.y.y.y.3632: F 139548:139548(0) ack 1167 win 1019 <nop,nop,timestamp 1466466663 143358916> (DF)
16:04:25.041470 y.y.y.y.3632 > x.x.x.x.57798: . ack 139549 win 64080 <nop,nop,timestamp 143358916 1466466663> (DF)


-- 
/Martin
