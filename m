Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWEWNYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWEWNYf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 09:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWEWNYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 09:24:35 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:64724 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932202AbWEWNYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 09:24:35 -0400
Date: Tue, 23 May 2006 15:23:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nathan Scott <nathans@sgi.com>
cc: linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: XFS write speed drop
In-Reply-To: <20060523084309.A239136@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.61.0605231517330.25086@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0605190047430.23455@yvahk01.tjqt.qr>
 <20060522105326.A212600@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.61.0605221308290.11108@yvahk01.tjqt.qr>
 <20060523084309.A239136@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> CASE 1: Copying from one disk to another
>> ========================================
>> Copying a compiled 2.6.17-rc4 tree; 306907 KB in 28566 files in 2090
>> directories.
>
>OK, we can call this a metadata intensive workload - lots of small
>files, lots of creates.  Barriers will hurt the most here, as we'd
>already have been log I/O bound most likely, and I'd expect barriers
>to only slow that further.
>
Yes and the most important thing is that someone made -o barrier the 
default and did not notice. Someone else? :-D

>Yep, note the user/sys shows no change, we're basically IO bound in
>both tests, and barriers are hurting (as expected).


>> CASE 2: Removing
>> ================
>> Remove the copies we created in case 1.
>> 
>> 15:45 (none):/tmp # mount /dev/hdc2 /D -o barrier
>> 15:45 (none):/D # time rm -Rf kernel-0
>> real	3m31.901s
>> user	0m0.050s
>> sys	0m3.140s
>
>versus:
>
>> 15:49 (none):/ # mount /dev/hdc2 /D -o nobarrier
>> 15:49 (none):/D # time rm -Rf kernel-1
>> 
>> real	0m53.471s
>> user	0m0.070s
>> sys	0m1.990s
>> 15:50 (none):/D # cd /
>> 15:50 (none):/ # umount /D
>
>Also metadata intensive, of course.  All the same issues as above,
>and the same techniques should be used to address it.
>
>Odd that the system time jumped here.  Roughly the same decrease in
>performance though (3-4x).

You may, or may not, take that serious. I only ran each test once (since 
3m31s vs 53s shows "enough" of the issue).

>So, I agree, you're seeing the cost of write barriers here, but I
>don't see anything unexpected (unfortunately for you, I guess).
>
>The FAQ entry above will explain why they're enabled by default.
>Try the v2 log change I suggested, hopefully that will mitigate
>the problem somewhat.  Alternatively, buy some decent hardware if
>you're after performance. ;)
>
Well as mentioned, -o nobarrier solved it, and that's it. I do not actually 
need barriers (or an UPS, to poke on another thread), because power 
failures are rather rare in Germany.


Jan Engelhardt
-- 
