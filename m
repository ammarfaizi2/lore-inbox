Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281579AbRKVTzC>; Thu, 22 Nov 2001 14:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281591AbRKVTyw>; Thu, 22 Nov 2001 14:54:52 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:49954 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S281579AbRKVTyh>; Thu, 22 Nov 2001 14:54:37 -0500
Date: Thu, 22 Nov 2001 21:54:24 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: What are the recommended software RAID patch(es) for 2.2.20?
Message-ID: <20011122215424.C4809@niksula.cs.hut.fi>
In-Reply-To: <2173081930.1006455144@[195.224.237.69]> <20011122210503.B4809@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011122210503.B4809@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Thu, Nov 22, 2001 at 09:05:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 09:05:03PM +0200, you [Ville Herva] claimed:
> 
> cat /dev/hde | md5sum
> or 
> cat /dev/hdg | md5sum
> (hdg and hde are not the same, but successive hde runs are the same as are
> hdg runs.)
> 
> but
> cat /dev/md0 | md5sum
> 
> is different every time. md0 consists of hde and hdg striped together.
> (Again, I'm not expecting it to be same as hde or hdg, but consistent over
> successive runs.) Successive hde and hdg runs are consistent even when run
> in parallel.
> 
> Any ideas what could cause this? A short read or something else trivial?
> 
> I'll try to go back to 2.2.18pre19 soon, and see if it happens there. Also,
> I'll try to see where the difference is. The first GB of md0 md5sums ok.

Ummh. I'm doing successive runs for /dev/md0 GB at a time, and it seems to
get corrupted in the middle:

#!/usr/bin/perl
for ($i = 0; $i < 75; $i++)
{
   $block = 1024**2;
   $count = 1024;
   $| = 1;
   print "At $i GB\n";
   
   system "(dd if=/dev/md0 bs=$block count=$count skip=".($i*$count).
          "| md5sum) 2>&1";
}

diff -c on (modified) output:

*** 5,11 ****
  At 4 GB 131e2916f3155f7c6df63fe2257e0350  -
  At 5 GB 502be9c039744eb761f89ada152a1745  -
  At 6 GB 07012ffe77ad7d6565f2e9576f1cf91e  -
! At 7 GB ffa5545ee518d3a7724831012d3e4c44  -
  At 8 GB eec233bf66d33fc81bfa895b022c4b04  -
  At 9 GB c62e78b9401f91199ce558242faf5da5  -
  At 10 GB f41d004b63c2481245320c28b9366b08  -
--- 5,11 ----
  At 4 GB 131e2916f3155f7c6df63fe2257e0350  -
  At 5 GB 502be9c039744eb761f89ada152a1745  -
  At 6 GB 07012ffe77ad7d6565f2e9576f1cf91e  -
! At 7 GB 4bbbaeefe786c760e342342f6a85ad4e  -
  At 8 GB eec233bf66d33fc81bfa895b022c4b04  -
  At 9 GB c62e78b9401f91199ce558242faf5da5  -
  At 10 GB f41d004b63c2481245320c28b9366b08  -
(... still running)

I'm puzzled as to why this happens, since (as said) hde and hdg both md5sum
quite ok. Raid stuff, I gather, should be fairly solid, no? 


-- v --

v@iki.fi
