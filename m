Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262839AbTCSArG>; Tue, 18 Mar 2003 19:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262854AbTCSArG>; Tue, 18 Mar 2003 19:47:06 -0500
Received: from mail-4.tiscali.it ([195.130.225.150]:44483 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S262839AbTCSArE>;
	Tue, 18 Mar 2003 19:47:04 -0500
Date: Wed, 19 Mar 2003 01:58:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.4 delayed acks don't work, fixed
Message-ID: <20030319005803.GL30541@dualathlon.random>
References: <20030318221906.GA30541@dualathlon.random> <200303182235.BAA05440@sex.inr.ac.ru> <20030319002409.GI30541@dualathlon.random> <20030318.163701.56035556.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030318.163701.56035556.davem@redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 04:37:01PM -0800, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Wed, 19 Mar 2003 01:24:09 +0100
> 
>    On Wed, Mar 19, 2003 at 01:35:23AM +0300, kuznet@ms2.inr.ac.ru wrote:
>    > I do not understand this, to be honest. What does clock this sender?
>    > Some internal clock of sender?
>    
>    I don't know the details of the userspace, but the data is generated in
>    real time, it's like if you cat /dev/dsp | netcat -l on the server, and
>    the receiver does netcat streamer xx >/dev/dsp
>    
> This streamer application should buffer at the sending side, in order
> to keep the window full.  Introducing artificial delays on the sending

the dev/dsp netcat was a dumb example, the app does proper buffering of
course.

> side of a unidirectional TCP transfer is really bad for performance
> and I can assure you that more than just "weird delayed ACK" behavior
> will result.
> 
> In fact, it is the most suboptimal way to send data over a TCP socket.
> If you can't keep the window full, you do not end up using the
> bandwidth available on the path.
> 
> I would not be surprised if the news pulling case you mentioned does
> something similar.

the rcv window looks full too doesn't it? the sender pumps the data and
then it keeps pumping until the window is full. there is an initial
buffering at the start of the playback that should take care of this.

But the data is also generated in real time, so the window is full, but
I guess new data to send it's not necessairly available immediatly as
soon as the rcv windows grows.

I don't see obvious inefficiencies in the protocol.

this is a tcpdump after 23 minutes for example (with my patch applied of
course or you would see the overkill number of acks):

01:48:44.030323 linux.43258 > streamer.8300: . ack 4163660229 win 7300 (DF)
01:48:44.171554 streamer.8300 > linux.43258: . 1:1461(1460) ack 0 win 58400 (DF)
01:48:44.201501 streamer.8300 > linux.43258: . 1461:2921(1460) ack 0 win 58400 (DF)
01:48:44.201557 linux.43258 > streamer.8300: . ack 2921 win 5840 (DF)
01:48:44.371461 streamer.8300 > linux.43258: . 2921:4381(1460) ack 0 win 58400 (DF)
01:48:44.411450 streamer.8300 > linux.43258: . 4381:5841(1460) ack 0 win 58400 (DF)
01:48:44.411500 linux.43258 > streamer.8300: . ack 5841 win 7300 (DF)
01:48:44.461430 streamer.8300 > linux.43258: . 5841:7301(1460) ack 0 win 58400 (DF)
01:48:44.501410 streamer.8300 > linux.43258: . 7301:8761(1460) ack 0 win 58400 (DF)
01:48:44.501461 linux.43258 > streamer.8300: . ack 8761 win 5840 (DF)
01:48:44.771374 streamer.8300 > linux.43258: . 8761:10221(1460) ack 0 win 58400 (DF)
01:48:44.811364 streamer.8300 > linux.43258: . 10221:11681(1460) ack 0 win 58400 (DF)
01:48:44.811413 linux.43258 > streamer.8300: . ack 11681 win 7300 (DF)
01:48:44.851352 streamer.8300 > linux.43258: . 11681:13141(1460) ack 0 win 58400 (DF)
01:48:44.881358 streamer.8300 > linux.43258: . 13141:14601(1460) ack 0 win 58400 (DF)
01:48:44.881405 linux.43258 > streamer.8300: . ack 14601 win 5840 (DF)
01:48:44.951348 streamer.8300 > linux.43258: . 14601:16061(1460) ack 0 win 58400 (DF)
01:48:44.981320 streamer.8300 > linux.43258: . 16061:17521(1460) ack 0 win 58400 (DF)
01:48:44.981381 linux.43258 > streamer.8300: . ack 17521 win 2920 (DF)
01:48:45.021321 streamer.8300 > linux.43258: . 17521:18981(1460) ack 0 win 58400 (DF)
01:48:45.051308 streamer.8300 > linux.43258: . 18981:20441(1460) ack 0 win 58400 (DF)
01:48:45.051355 linux.43258 > streamer.8300: . ack 20441 win 2920 (DF)
01:48:45.294200 linux.43258 > streamer.8300: . ack 20441 win 7300 (DF)
01:48:45.311272 streamer.8300 > linux.43258: . 20441:21901(1460) ack 0 win 58400 (DF)
01:48:45.361297 streamer.8300 > linux.43258: . 21901:23361(1460) ack 0 win 58400 (DF)
01:48:45.361352 linux.43258 > streamer.8300: . ack 23361 win 4380 (DF)
01:48:45.691242 streamer.8300 > linux.43258: . 23361:24821(1460) ack 0 win 58400 (DF)
01:48:45.721194 streamer.8300 > linux.43258: . 24821:26281(1460) ack 0 win 58400 (DF)
01:48:45.721245 linux.43258 > streamer.8300: . ack 26281 win 7300 (DF)
01:48:45.771199 streamer.8300 > linux.43258: . 26281:27741(1460) ack 0 win 58400 (DF)
01:48:45.891161 streamer.8300 > linux.43258: . 27741:29201(1460) ack 0 win 58400 (DF)
01:48:45.891207 linux.43258 > streamer.8300: . ack 29201 win 7300 (DF)
01:48:45.921147 streamer.8300 > linux.43258: . 29201:30661(1460) ack 0 win 58400 (DF)
01:48:45.941150 streamer.8300 > linux.43258: . 30661:32121(1460) ack 0 win 58400 (DF)
01:48:45.941182 linux.43258 > streamer.8300: . ack 32121 win 5840 (DF)
01:48:45.981153 streamer.8300 > linux.43258: . 32121:33581(1460) ack 0 win 58400 (DF)
01:48:46.021133 streamer.8300 > linux.43258: . 33581:35041(1460) ack 0 win 58400 (DF)
01:48:46.021189 linux.43258 > streamer.8300: . ack 35041 win 2920 (DF)
01:48:46.051129 streamer.8300 > linux.43258: . 35041:36501(1460) ack 0 win 58400 (DF)
01:48:46.091112 streamer.8300 > linux.43258: . 36501:37961(1460) ack 0 win 58400 (DF)
01:48:46.091162 linux.43258 > streamer.8300: . ack 37961 win 1460 (DF)
01:48:46.201167 streamer.8300 > linux.43258: . 37961:39421(1460) ack 0 win 58400 (DF)
01:48:46.340311 linux.43258 > streamer.8300: . ack 39421 win 4380 (DF)
01:48:46.461074 streamer.8300 > linux.43258: . 39421:40881(1460) ack 0 win 58400 (DF)
01:48:46.491046 streamer.8300 > linux.43258: . 40881:42341(1460) ack 0 win 58400 (DF)
01:48:46.491100 linux.43258 > streamer.8300: . ack 42341 win 2920 (DF)
01:48:46.531039 streamer.8300 > linux.43258: . 42341:43801(1460) ack 0 win 58400 (DF)
01:48:46.653668 linux.43258 > streamer.8300: . ack 43801 win 4380 (DF)
01:48:46.711062 streamer.8300 > linux.43258: . 43801:45261(1460) ack 0 win 58400 (DF)
01:48:46.771007 streamer.8300 > linux.43258: . 45261:46721(1460) ack 0 win 58400 (DF)
01:48:46.771062 linux.43258 > streamer.8300: . ack 46721 win 2920 (DF)
01:48:46.810011 streamer.8300 > linux.43258: . 46721:48181(1460) ack 0 win 58400 (DF)
01:48:46.880996 streamer.8300 > linux.43258: . 48181:49641(1460) ack 0 win 58400 (DF)
01:48:46.881049 linux.43258 > streamer.8300: . ack 49641 win 2920 (DF)
01:48:46.990978 streamer.8300 > linux.43258: . 49641:51101(1460) ack 0 win 58400 (DF)
01:48:47.030972 streamer.8300 > linux.43258: . 51101:52561(1460) ack 0 win 58400 (DF)
01:48:47.031017 linux.43258 > streamer.8300: . ack 52561 win 1460 (DF)
01:48:47.149944 streamer.8300 > linux.43258: . 52561:54021(1460) ack 0 win 58400 (DF)
01:48:47.330327 linux.43258 > streamer.8300: . ack 54021 win 4380 (DF)
01:48:47.440894 streamer.8300 > linux.43258: . 54021:55481(1460) ack 0 win 58400 (DF)
01:48:47.480858 streamer.8300 > linux.43258: . 55481:56941(1460) ack 0 win 58400 (DF)
01:48:47.480912 linux.43258 > streamer.8300: . ack 56941 win 4380 (DF)
01:48:47.520857 streamer.8300 > linux.43258: . 56941:58401(1460) ack 0 win 58400 (DF)
01:48:47.670328 linux.43258 > streamer.8300: . ack 58401 win 5840 (DF)
01:48:47.760838 streamer.8300 > linux.43258: . 58401:59861(1460) ack 0 win 58400 (DF)
01:48:47.800808 streamer.8300 > linux.43258: . 59861:61321(1460) ack 0 win 58400 (DF)
01:48:47.800862 linux.43258 > streamer.8300: . ack 61321 win 5840 (DF)
01:48:47.890787 streamer.8300 > linux.43258: . 61321:62781(1460) ack 0 win 58400 (DF)
01:48:47.930791 streamer.8300 > linux.43258: . 62781:64241(1460) ack 0 win 58400 (DF)
01:48:47.930857 linux.43258 > streamer.8300: . ack 64241 win 4380 (DF)
01:48:47.960770 streamer.8300 > linux.43258: . 64241:65701(1460) ack 0 win 58400 (DF)
01:48:47.999824 streamer.8300 > linux.43258: . 65701:67161(1460) ack 0 win 58400 (DF)
01:48:47.999853 linux.43258 > streamer.8300: . ack 67161 win 2920 (DF)
01:48:48.050760 streamer.8300 > linux.43258: . 67161:68621(1460) ack 0 win 58400 (DF)
01:48:48.133671 linux.43258 > streamer.8300: . ack 68621 win 2920 (DF)
01:48:48.150747 streamer.8300 > linux.43258: . 68621:70081(1460) ack 0 win 58400 (DF)
01:48:48.290329 linux.43258 > streamer.8300: . ack 70081 win 4380 (DF)
01:48:48.350694 streamer.8300 > linux.43258: . 70081:71541(1460) ack 0 win 58400 (DF)
01:48:48.410696 streamer.8300 > linux.43258: . 71541:73001(1460) ack 0 win 58400 (DF)
01:48:48.410748 linux.43258 > streamer.8300: . ack 73001 win 4380 (DF)
01:48:48.460677 streamer.8300 > linux.43258: . 73001:74461(1460) ack 0 win 58400 (DF)
01:48:48.600333 linux.43258 > streamer.8300: . ack 74461 win 5840 (DF)
01:48:48.790637 streamer.8300 > linux.43258: . 74461:75921(1460) ack 0 win 58400 (DF)
01:48:48.830615 streamer.8300 > linux.43258: . 75921:77381(1460) ack 0 win 58400 (DF)
01:48:48.830669 linux.43258 > streamer.8300: . ack 77381 win 5840 (DF)
01:48:49.050551 streamer.8300 > linux.43258: . 77381:78841(1460) ack 0 win 58400 (DF)
01:48:49.090572 streamer.8300 > linux.43258: . 78841:80301(1460) ack 0 win 58400 (DF)
01:48:49.090639 linux.43258 > streamer.8300: . ack 80301 win 7300 (DF)

rcv window is almost full. netstat shows constant 65853/69628 in the
receive queue ready to be copied into userspace at the next recvmsg.

Andrea
