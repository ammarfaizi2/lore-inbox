Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVBRWVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVBRWVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 17:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVBRWVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 17:21:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:32478 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261535AbVBRWVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 17:21:12 -0500
X-Authenticated: #8956447
Subject: Re: [Problem] slow write to dvd-ram since 2.6.7-bk8
From: Droebbel <droebbel.melta@gmx.de>
To: Tino Keitel <tino.keitel@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050217231048.GA4363@dose.home.local>
References: <1108301794.9280.18.camel@localhost.localdomain>
	 <20050213142635.GA2035@animx.eu.org>
	 <20050214085320.GA4910@dose.home.local>
	 <1108376734.9495.8.camel@localhost.localdomain>
	 <20050214105332.GA7163@dose.home.local>
	 <1108379351.9495.22.camel@localhost.localdomain>
	 <20050214111819.GA7691@dose.home.local>
	 <1108590900.7407.11.camel@localhost.localdomain>
	 <1108592965.7407.17.camel@localhost.localdomain>
	 <20050217231048.GA4363@dose.home.local>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 23:21:10 +0100
Message-Id: <1108765270.14370.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2005-02-18 at 00:10 +0100, Tino Keitel wrote:
>On Wed, Feb 16, 2005 at 23:29:24 +0100, Droebbel wrote:
>> On Mi, 2005-02-16 at 22:55 +0100, Droebbel wrote:
>> 
>> >The vmscan-dont-reclaim-too-many-pages.patch led to the said reduction
>> >of writing speed. I reverse-applied it to 2.6.8.1, where it seems to
>> >solve the problem.
>> 
>> Sorry, have to correct that: it seemed to help at my tests with dd
>> (write 1G of zeroes to a file). Copying a file with mc still shows
>> around 1.4MB/s. Could be worse, but is definitely not ok. It *is* better
>> with 2.6.7.
>
>Here are some numbers with my setup. I always wrote 1 GB of data to the
>same DVD-RAM disc (EMTEC), to the device directly and to a fresh ext2
>on
>the disc.
>
>kernel 2.6.10:
>
>$ time { sudo dd if=/dev/zero of=bigfile bs=64k count=16000 ; sync ; }
>
>real    32m5.025s
>
>$ time {sudo dd if=/dev/zero of=/dev/cdrom bs=64k count=16000 ; sync ;}
>
>real    29m41.980s
>
>kernel 2.6.7:
>
>$ time { sudo dd if=/dev/zero of=bigfile bs=64k count=16000 ; sync ; }
>
>real    13m23.688s
>
>$ time {sudo dd if=/dev/zero of=/dev/cdrom bs=64k count=16000 ; sync ;}
>
>real    13m14.609s

This is what I get:
 2.6.8 to 2.6.10: about 30 min. I think that's clear now. I did not run
any mre test with that.

2.6.7 gives less than 10 minutes.

Reverse-Patched 2.6.8.1 and 2.6.10 about 9-11 min.

But what I think is interesting: Other than with 2.6.7, with my 2.6.10
the result seems to be highly dependent on other io activities. I came
to test that when I saw that writing to dvd-ram slowed down when reading
from a cdrom at the same time. System disk, cdrom and dvd-ram are
connected by buses as independent as possible: hda, hdd and scd0 via
on-chip ide2. hdc is inactive and spun down at the times of testing.

Some results (same command as yours, but writing to file only):

2.6.8.1 with vmscan-dont-reclaim-too-many-pages.patch
and vmscan-scan-sanity.patch reversed:

real    9m17.389s
real    10m11.271s
(run twice)

2.6.10, both patches reversed:

real    10m26.374s

same kernel, some io and high (but niced) system load by reading from
hda and gzipping into /dev/null

real    21m46.795s

same kernel, some io and low load by reading from cdrom (raw read with
dd as well) into /dev/null

real    22m11.639s

2.6.7 vanilla, some io and low load by reading from cdrom (raw read with
dd as well) into /dev/null

real	5m58.092

That's too fast - impossible on 3x media with verification. I'll check
that again. But it *really* seemed to be fast.

I also hat the impression that my tests with 2.6.10 and 2.6.8.1 were
much more promising when run from a rather basic testing system without
X, a bit closer to the 2.6.7 results. Haven't got time to check that
till monday. All the above results except the 2.6.7 are from Ubuntu
(Hoary) Systems with X and Gnome running. 

Regards
David



