Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271636AbRIGJVC>; Fri, 7 Sep 2001 05:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271640AbRIGJUw>; Fri, 7 Sep 2001 05:20:52 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:11700 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271636AbRIGJUg>;
	Fri, 7 Sep 2001 05:20:36 -0400
Date: Fri, 07 Sep 2001 10:15:27 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [RFC] Defragmentation proposal: preventative maintenance and cleanup [LONG]
Message-ID: <1427827800.999857726@[169.254.198.40]>
In-Reply-To: <1426827386.999856726@[169.254.198.40]>
In-Reply-To: <1426827386.999856726@[169.254.198.40]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> It becomes effectively useless.  The probability of all 8 pages of a given
>> 8 page unit being free when only 1% of memory is free is (1/100)**8 =
>> 1/(10**16).

> Sorry to sound like a broken record, but apply the
> /proc/memareas patch and you can see this happening. After extensive
> activity, you see practically none of the free pages in order 0
> blocks. You might see only a small number (20 or 30 on a 64k
> machine) of (say) order 3 blocks, but if you run your stats
> you would have an expected value of well less than one, and the
> chance of having 20 or 30 would be vanishingly small.

Ooops, what I wrote was factually correct, but misleading.
What I meant was it looks like this:

   Zone     4kB     8kB    16kB    32kB    64kB   128kB   256kB   512kB  1024kB  2048kB Tot Pages/kb
    DMA     495     348     196      72      10       1       1       0       0       0 =     2807)
  @frag      0%     18%     42%     70%     91%     97%     98%    100%    100%    100% =    11228kB
 Normal       0    1579    1670     667     140      12       3       1       0       0 =    18118)
  @frag      0%      0%     17%     54%     84%     96%     98%     99%    100%    100% =    72472kB

If your model was correct, you would see free pages
per order run like
  N = a (K ^ (2^-o)); (for a>0, K>1, o=order)

This doesn't happen. Instead you get GOOD coalescence
at oder 0 (in the Normal zone they've ALL been coalesced),
and not bad at order 1 (see how many order 2's we have).

8 page unit is order 3 (32k). This system has 20% of
memory free at the point where I took the snap shot.
Probability would be, (1/5)^8 = 2^8 / 10^8 =
roughly p = 2.5 x 10^-6. In a system with 32000 pages
(128Kb), if you were right, I'd expect to see about
0.08 free pages at order 3. But here I see 750.

The chance of seeing more than 500 events of probability
p = 2.5 ^ (10^-6) across 32000 samples, is vanishingly
small. Yet it looks this way all the time.

Hence I conclude your model is wrong :-)

--
Alex Bligh
