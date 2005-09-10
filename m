Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbVIJAq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbVIJAq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 20:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbVIJAq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 20:46:29 -0400
Received: from ppp59-167.lns1.cbr1.internode.on.net ([59.167.59.167]:6675 "EHLO
	triton.bird.org") by vger.kernel.org with ESMTP id S932653AbVIJAq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 20:46:28 -0400
Message-ID: <43222DC3.9080609@acquerra.com.au>
Date: Sat, 10 Sep 2005 10:50:11 +1000
From: Anthony Wesley <awesley@acquerra.com.au>
Reply-To: awesley@acquerra.com.au
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nate.diller@gmail.com
CC: Roger Heflin <rheflin@atipa.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13 buffer strangeness
References: <432151B0.7030603@acquerra.com.au>	 <EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com> <5c49b0ed05090914394dba42bf@mail.gmail.com>
In-Reply-To: <5c49b0ed05090914394dba42bf@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on a better understanding of dirty_ratio and dirty_background ratio (thanks Nate) I just tried
the following test:

dirty_ratio set to 95
dirty_background_ratio set to 1

>From Nate's description of these parameters, this should mean that the disk writes
start almost immediately, and the kernel will allow 95% of RAM to become dirty before
applying the throttle.

Ok, so with 25Mbytes/s coming in, and 17Mbytes/sec going out to disk, the dirty pages should be growing
at 7Mbytes/sec. With these parameters set as above I should see about 3 minutes of full speed
video before the throttle is applied since I have about 1.3Gb of RAM free for buffering..

*But* when I try this experiment I hit the throttle after only 65 seconds - an improvement to 
be sure, but still a long way short of the 180 seconds that it ought to take.

Part of the test works as expected - the disk writes begin almost immediately due to the low
value for dirty_background_ratio, but the rest is a mystery.

It really looks as if the pages aren't being marked as clean fast enough after they're written.

How else can it take only 70 seconds to reach 95% dirty when I have 1.3Gb of available RAM and data coming in at 25MBytes/sec and out at 17MBytes/sec? It doesn't make any sense...

regards, Anthony

Nate Diller wrote:
> yes, on 2.6 there are two tunables which are important here. 
> dirty_background_ratio is the threshold where the kernel will begin
> flushing dirty buffers, so it should change how soon the disk becomes
> active.  dirty_ratio changes when the write-throttling code kicks in,
> which is what Anthony is seeing.  The purpose of the write throttling
> code is to limit the dirtying process to disk bandwidth, so that is a
> Feature.  Anthony, try *increasing* dirty_ratio, you can go up to 100,
> but you could trigger an OOM if you let it get too high, so maybe try
> setting it at 85 or so.  This should effectively disable the write
> throttling and give you the bandwidth you want.
> 
> NATE

-- 
Anthony Wesley
Director and IT/Network Consultant
Smart Networks Pty Ltd
Acquerra Pty Ltd

Anthony.Wesley@acquerra.com.au
Phone: (02) 62595404 or 0419409836
