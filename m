Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275511AbRIZTNc>; Wed, 26 Sep 2001 15:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275510AbRIZTNX>; Wed, 26 Sep 2001 15:13:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10001 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275514AbRIZTNJ>; Wed, 26 Sep 2001 15:13:09 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Locking comment on shrink_caches()
Date: Wed, 26 Sep 2001 19:12:54 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9ot9bm$8gu$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109261123380.8558-100000@penguin.transmeta.com> <Pine.LNX.4.30.0109262036480.8655-100000@Appserv.suse.de>
X-Trace: palladium.transmeta.com 1001531590 1896 127.0.0.1 (26 Sep 2001 19:13:10 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 26 Sep 2001 19:13:10 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0109262036480.8655-100000@Appserv.suse.de>,
Dave Jones  <davej@suse.de> wrote:
>On Wed, 26 Sep 2001, Linus Torvalds wrote:
>
>> > > cpuid: 72 cycles
>> > cpuid: 79 cycles
>> > Only slightly worse, but I'd not expected this.
>> That difference can easily be explained by the compiler and options.
>
>Actually repeated runs of the test on that box show it deviating by up
>to 10 cycles, making it match the results that Alan posted.
>-O2 made no difference, these deviations still occur. They seem more
>prominent on the C3 than other boxes I've tried, even with the same
>compiler toolchain.

Does the C3 do any kind of frequency shifting?

For example, on a transmeta CPU, the TSC will run at a constant
"nominal" speed (the highest the CPU can go), although the real CPU
speed will depend on the load of the machine and temperature etc.  So on
a crusoe CPU you'll see varying speeds (and it depends on the speed
grade, because that in turn depends on how many longrun steps are being
actively used). 

For example, on a mostly idle machine I get

	torvalds@kiwi:~ > ./a.out 
	nothing: 54 cycles
	locked add: 54 cycles
	cpuid: 91 cycles

while if I have another window that does an endless loop to keep the CPU
busy, the _real_ frequency of the CPU scales up, and the machine
basically becomes faster:

	torvalds@kiwi:~ > ./a.out 
	nothing: 36 cycles
	locked add: 36 cycles
	cpuid: 54 cycles

(The reason why the "nothing" TSC read is expensive on crusoe is because
of the scaling of the TSC - rdtsc literally has to do a floating point
multiply-add to scale the clock to the right "nominal" frequency.  Of
course, "expensive" is still a lot less than the inexplicable 80 cycles
on a P4). 

(That's a 600MHz part going down to to 400MHz in idle, btw)

On a 633MHz part (I don't actually have access to any of the high speed
grades ;) it ends up being 

fast:
	nothing: 39 cycles
	locked add: 40 cycles
	cpuid: 68 cycles

slow: 
	nothing: 82 cycles
	locked add: 84 cycles
	cpuid: 122 cycles

which corresponds to a 633MHz part going down to 300MHz in idle.

And of course, you can get pretty much anything in between, depending on
what the load is...

		Linus
