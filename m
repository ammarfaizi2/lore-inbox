Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVHYAqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVHYAqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 20:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVHYAqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 20:46:14 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:35516 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932436AbVHYAqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 20:46:13 -0400
Date: Thu, 25 Aug 2005 02:45:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       George Anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <1124923231.20820.87.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0508250102020.3743@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com> 
 <1123726394.32531.33.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508152115480.3728@scrub.home>
  <1124151001.8630.87.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508162337130.3728@scrub.home>
  <1124241449.8630.137.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0508182213100.3728@scrub.home>  <1124505151.22195.78.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508202204240.3728@scrub.home>  <1124737075.22195.114.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508230134210.3728@scrub.home>  <1124830262.20464.26.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508232321530.3728@scrub.home>  <1124838847.20617.11.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508240134050.3743@scrub.home>  <1124906422.20820.16.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508242043220.3728@scrub.home>  <1124910953.20820.34.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508242142420.3743@scrub.home> <1124923231.20820.87.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 Aug 2005, john stultz wrote:

> Ok, well, I'm still at a loss for understanding how this avoids my
> concern about time inconsistencies.

Let's take a simple example to demonstrate the difference between system 
time and reference time.
NTP tells us to update the reference time by 1000 units every tick and a 
single tick consists of 123 cycles, so the initial multiplier is 8. This 
means after 1 tick the system time is 984 and off by -16:

time (ticks)	reference time	system time	mult	error
0		0		0		8	0
1		1000		984		8	-16
2		2000		1968		8	-32
3		3000		2952		8	-48
4		4000		3936		9	-64

the error is now big enough, so we speed up system time:

5		5000		5043		9	43
6		6000		6150		8	150

and slow it down again:

7		7000		7134		8	134
8		8000		8118		8	118
9		9000		9102		8	102
10		10000		10086		8	86
11		11000		11070		8	70
12		12000		12054		8	54
13		13000		13038		8	38
14		14000		14022		8	22
15		15000		15006		8	6
16		16000		15990		8	-10
17		17000		16974		8	-26
18		18000		17958		8	-42
19		19000		18942		8	-58
20		20000		19926		8	-74

let's assume we're late with the update by 10 cycles 
(gettimeofday=19926+10*8=20006), so a change to the mult also requires a 
adjustment of the system time:

20+10		20000		19916		9	-84

so gettimeofday=19916+10*9=20006

21		21000		21023		9	23
22		22000		22130		8	130

now add a single adjustment of 500 to the reference time:

23		23500		23114		11	-386
24		24500		24467		8	-33

A detail which is missing now in my example code is that we actually 
should look ahead to the next update, so that multiplier is immediately 
adjusted and the error above would never exceed 123/2 unless an update is 
delayed.

It's really not that difficult :), it's just important to understand the 
difference between reference time and system time. All the NTP adjustments 
are done to the reference time and we manipulate the speed of the system 
clock to keep it close. The latter has _nothing_ to do with NTP so I don't 
want to see anything called like ntp_adj there.

bye, Roman
