Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263918AbRFMA07>; Tue, 12 Jun 2001 20:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263906AbRFMA0t>; Tue, 12 Jun 2001 20:26:49 -0400
Received: from sense-robertk-129.oz.net ([216.39.160.129]:35712 "HELO
	mail.kleemann.org") by vger.kernel.org with SMTP id <S263918AbRFMA0i>;
	Tue, 12 Jun 2001 20:26:38 -0400
Date: Tue, 12 Jun 2001 17:26:06 -0700 (PDT)
From: Robert Kleemann <robert@kleemann.org>
X-X-Sender: <robert@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Client receives TCP packets but does not ACK
Message-ID: <Pine.LNX.4.33.0106121720310.1152-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a client server program that opens a tcp connection between two
machines.  Everything is fine until a certain type of data is sent
across the socket at which point the client refuses to ACK and the
server continues to resend the packets to no avail.

I've verified that the client is blocking on a socket read (and not
coming out) I've also run "tcpdump -lxa -s 5000" on each machine and
verified that each packet sent by each machine is received by the
other.  I diffed the data and there appears to be no corruption.

I first saw this with the server running 2.4.2 and the client running
2.2.16 but I have since upgraded the server first to 2.4.5 and then
also added a patch from 1.4.6-pre2 that had to do with tcp acks.  The
bug still repros.  I have also upgraded the client to 2.4.2, 2.4.5,
and 2.4.5 + ack patch with no luck.

There have been quite a few other people who have experienced these
symptoms and posted to the list over the past 5 months or so.  I
haven't seen a resolution for any of them except for requests to try
the latest kernel since there have been a lot of networking fixes in
the latest kernels.  I have appened links to these other postings at
the end of this email in case their data might help.

I can consistently reproduce this problem on my machines (10mbs
ethernet lan) and would really like to narrow this bug down to the
source instead of trying the latest kernels and hoping that they solve
the problem. The networking code (net/ipv4/tcp*.c) is daunting to me
but if someone has any suggestions on good places to add debug code,
building a debug version, or whatever, I can try it on my local system
and investigate further.  This bug is driving me crazy and I want to
find it and fix it!

Are there any other details that would help?  My hardware
configuration? Network settings? etc?

Here is the analysis of one of the tcpdump logs for glottis.  glottis
is the client and manny is the server.  Note that the large packet
11006:1254(1448) is received by glottis and an ack is never sent to
manny.

20:07:45.043640 glottis->manny ack 11006
20:07:45.047120 manny->glottis 11006:12454(1448) ack 408 probably contains the remainder of ClientMap
20:07:45.047571 manny->glottis 12454:12936(482) ack 408
20:07:45.047673 glottis->manny ack 11006
20:07:45.272042 manny->glottis 11006:12454(1448) ack 408 resend
20:07:45.732049 manny->glottis 11006:12454(1448) ack 408 resend
20:07:46.652015 manny->glottis 11006:12454(1448) ack 408 resend
20:07:48.491986 manny->glottis 11006:12454(1448) ack 408 resend
20:07:52.171937 manny->glottis 11006:12454(1448) ack 408 resend
20:07:59.531850 manny->glottis 11006:12454(1448) ack 408 resend
web packets as manny is probably pinging session server
20:08:14.251656 manny->glottis 11006:12454(1448) ack 408 resend
20:08:24.078088 glottis->manny 408:437(29) ack 11006 text request in same packet
20:08:24.110417 manny->glottis ack 437
20:08:27.539778 glottis->manny 437:470(33) ack 11006 quit message
20:08:27.540158 manny->glottis 12936:12936(0) ack 470
20:08:27.541574 glottis->manny 470:472(2) ack 11006
20:08:27.542069 manny->glottis 12936:12936(0) ack 472
20:08:27.637385 manny->glottis 12936:12936(0) ack 473
web packets
ntp packets
20:08:43.691285 manny->glottis 11006:12454(1448) ack 473 resend
arp packets

Here are some other threads on the list that may be related to this problem:

http://groups.google.com/groups?hl=en&lr=&safe=off&ic=1&th=ca50bd5b6fab99dd,2&seekm=linux.kernel.3A806260.BB77D017%40denise.shiny.it#p

http://groups.google.com/groups?hl=en&lr=&safe=off&ic=1&th=c2b75d883be146f6,2&seekm=linux.kernel.5.0.2.1.2.20010115152847.00a8a380%40pop.we.mediaone.net#p

http://groups.google.com/groups?hl=en&lr=&safe=off&ic=1&th=5a94424eaed764df,21&seekm=linux.kernel.3A6F3C4A.27E148E9%40colorfullife.com#p

http://groups.google.com/groups?hl=en&lr=&safe=off&ic=1&th=d74b104bfe2da967,14&seekm=200104101738.VAA21467%40ms2.inr.ac.ru#p

http://groups.google.com/groups?hl=en&lr=&safe=off&ic=1&th=c15161c8342be0a0,7&seekm=linux.kernel.Pine.LNX.4.30.0012311601410.9994-100000%40shodan.irccrew.org#p

http://groups.google.com/groups?hl=en&lr=&safe=off&ic=1&th=7268b77eb1e07a38,3&seekm=20010419200905.A2970%40ping.be#p

http://groups.google.com/groups?hl=en&lr=&safe=off&ic=1&th=160b098279e28ca9,8&seekm=linux.kernel.F57chplw8IfbyyOxmQp000170f7%40hotmail.com#p

Please cc me on any replies.

thanx!
Robert

