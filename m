Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266220AbUHBCxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUHBCxn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 22:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUHBCxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 22:53:43 -0400
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:16844 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266220AbUHBCxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 22:53:40 -0400
Message-ID: <410DAC89.4000002@kolivas.org>
Date: Mon, 02 Aug 2004 12:52:57 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, linux-mm@kvack.org, sjiang@cs.wm.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] token based thrashing control
References: <Pine.LNX.4.58.0407301730440.9228@dhcp030.home.surriel.com>	<Pine.LNX.4.58.0408010856240.13053@dhcp030.home.surriel.com> <20040801175618.711a3aac.akpm@osdl.org>
In-Reply-To: <20040801175618.711a3aac.akpm@osdl.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD6ADDBD8E440CCA8C30E95C5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD6ADDBD8E440CCA8C30E95C5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Rik van Riel <riel@redhat.com> wrote:
> 
>>On Fri, 30 Jul 2004, Rik van Riel wrote:
>>
>> > I have run a very unscientific benchmark on my system to test
>> > the effectiveness of the patch, timing how a 230MB two-process
>> > qsbench run takes, with and without the token thrashing
>> > protection present.
>> > 
>> > normal 2.6.8-rc2:	6m45s
>> > 2.6.8-rc2 + token:	4m24s
>>
>> OK, I've now also ran day-long kernel compilate tests,
>> 3 times each with make -j 10, 20, 30, 40, 50 and 60 on
>> my dual pIII w/ 384 MB and a 180 MB named in the background.
>>
>> For make -j 10 through make -j 50 the differences are in
>> the noise, basically giving the same result for each kernel.
>>
>> However, for make -j 60 there's a dramatic difference between
>> a kernel with the token based swapout and a kernel without.
>>
>> normal 2.6.8-rc2:	1h20m runtime / ~26% CPU use average
>> 2.6.8-rc2 + token:	  42m runtime / ~52% CPU use average
> 
> 
> OK.  My test is usually around 50-60% CPU occupancy so we're not gaining in
> the moderate swapping range.

We have some results that need interpreting with contest.
mem_load:
Kernel    [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.6.8-rc2      4	78	146.2	94.5	4.7	1.30
2.6.8-rc2t     4	318	40.9	95.2	1.3	5.13

The "load" with mem_load is basically trying to allocate 110% of free 
ram, so the number of "loads" although similar is not a true indication 
of how much ram was handed out to mem_load. What is interesting is that 
since mem_load runs continuously and constantly asks for too much ram it 
seems to be receiving the token most frequently in preference to the cc 
processes which are short lived. I'd say it is quite hard to say 
convincingly that this is bad because the point of this patch is to 
prevent swap thrash.

It would get far more complicated to create a list of tasks trying to 
get the token and refuse to hand it back to the same task until it 
cycled through all the other tasks to prevent this... and I'm not even 
sure that would help since these are all short lived tasks... Any other 
thoughts?

To be honest I dont think this contest result is truly a bad thing...

Con

--------------enigD6ADDBD8E440CCA8C30E95C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBDayLZUg7+tp6mRURAiYyAJ0W+OmqBJy37xwsh7rI+hkrn3aLDgCfeM3K
Y5VnhiYmhumFFAPW/7CkFPw=
=9wqa
-----END PGP SIGNATURE-----

--------------enigD6ADDBD8E440CCA8C30E95C5--
