Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267744AbUHJU6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267744AbUHJU6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUHJU6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:58:38 -0400
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:55740 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267744AbUHJU6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:58:13 -0400
Message-ID: <411936BB.9070107@kolivas.org>
Date: Wed, 11 Aug 2004 06:57:31 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, ricklind@us.ibm.com, mbligh@aracnet.com,
       mingo@elte.hu, akpm@osdl.org
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
References: <200408092240.05287.habanero@us.ibm.com> <200408092308.56160.habanero@us.ibm.com> <cone.1092112649.681597.29067.502@pc.kolivas.org> <200408101005.15384.habanero@us.ibm.com>
In-Reply-To: <200408101005.15384.habanero@us.ibm.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCB636F699FFB84F6BD28E374"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB636F699FFB84F6BD28E374
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Theurer wrote:
>>>Also, one big change apparent to me, the elimination of
>>>TIMESLICE_GRANULARITY.
>>
>>Ah well I tuned the timeslice granularity and I can tell you it isn't quite
>>what most people think. The granularity when you get to greater than 4 cpus
>>is effectively _disabled_. So in fact, the timeslices are shorter in
>>staircase (in normal interactive=1, compute=0 mode which is how martin
>>would have tested it), not longer. But this is not the reason either since
>>in "compute" mode they are ten times longer and this also improves
>>throughput further.
> 
> 
> Interesting, I forgot about the "* nr_cpus" that was in the granularity 
> calculation.  That does make me wonder, maybe the timeslices you are 
> calculating could have something similar, but more appropriate.  
> 
> Since the number of runnable tasks on a cpu should play a part in latency (the 
> more tasks, potentially the longer the latency), I wonder if the timeslice 
> would benefit from a modifier like " / task_cpu(p)->nr_running ".  With this 
> the base timeslice could be quite a bit larger to start for better cache 
> warmth, and as we add more tasks to that cpu, the timeslices get smaller, so 
> an acceptable latency is preserved.  

I had a problem with fairness once I made the timeslices too long since 
that also determines priority demotion in the staircase design. That's 
why I have the "compute" mode as quite a separate entity because the 
longer timeslices on their own weren't of any special benefit (in my up 
to 8x testing but could be elsewhere) unless I added the delayed 
preemption which is probably where the main extra cache warmth comes 
from in "compute" design. Of course this comes at a cost which is higher 
latencies... because normal priority preemption is delayed.

>>>Do you have cswitch data?  I would not be surprised if it's a lot higher
>>>on -no-staircase, and cache is thrashed a lot more.  This may be
>>>something you can pull out of the -no-staircase kernel quite easily.
>>
>>Well from what I got on 8x the optimal load (-j x4cpus) and maximal load
>>(-j) on kernbench gives surprisingly similar context switch rates. It's
>>only when I enable compute mode that the context switches drop compared to
>>default staircase mode and mainline. You'd have to ask Martin and Rick
>>about what they got.
> 
> 
> OK, thanks!
> 
> -Andrew Theurer

Cheers,
Con

--------------enigCB636F699FFB84F6BD28E374
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGTa7ZUg7+tp6mRURAgZcAJsERvNVzWBUsZdk89hPxWSIqWTZrgCdF9ON
UKJZqyOvr6FlbqddxRDYekQ=
=Uv89
-----END PGP SIGNATURE-----

--------------enigCB636F699FFB84F6BD28E374--
