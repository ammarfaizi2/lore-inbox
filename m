Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVHaQvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVHaQvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 12:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVHaQvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 12:51:31 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:42192 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S964869AbVHaQva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 12:51:30 -0400
Date: Wed, 31 Aug 2005 16:51:18 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: Jens Axboe <axboe@suse.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
In-Reply-To: <20050831162053.GG4018@suse.de>
Message-ID: <Pine.LNX.4.61.0508311648390.16574@diagnostix.dwd.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
 <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de>
 <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de>
 <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de> <20050831120714.GT4018@suse.de>
 <Pine.LNX.4.61.0508311339140.16574@diagnostix.dwd.de> <20050831162053.GG4018@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005, Jens Axboe wrote:

> On Wed, Aug 31 2005, Holger Kiehl wrote:
>> On Wed, 31 Aug 2005, Jens Axboe wrote:
>>
>>> Nothing sticks out here either. There's plenty of idle time. It smells
>>> like a driver issue. Can you try the same dd test, but read from the
>>> drives instead? Use a bigger blocksize here, 128 or 256k.
>>>
>> I used the following command reading from all 8 disks in parallel:
>>
>>    dd if=/dev/sd?1 of=/dev/null bs=256k count=78125
>>
>> Here vmstat output (I just cut something out in the middle):
>>
>> procs -----------memory---------- ---swap-- -----io---- --system--
>> ----cpu----^M
>>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
>>  wa^M
>>  3  7   4348  42640 7799984   9612    0    0 322816     0 3532  4987  0 22
>>  0 78
>>  1  7   4348  42136 7800624   9584    0    0 322176     0 3526  4987  0 23
>>  4 74
>>  0  8   4348  39912 7802648   9668    0    0 322176     0 3525  4955  0 22
>>  12 66
>>  1  7   4348  38912 7803700   9636    0    0 322432     0 3526  5078  0 23
>
> Ok, so that's somewhat better than the writes but still off from what
> the individual drives can do in total.
>
>>> You might want to try the same with direct io, just to eliminate the
>>> costly user copy. I don't expect it to make much of a difference though,
>>> feels like the problem is elsewhere (driver, most likely).
>>>
>> Sorry, I don't know how to do this. Do you mean using a C program
>> that sets some flag to do direct io, or how can I do that?
>
> I've attached a little sample for you, just run ala
>
> # ./oread /dev/sdX
>
> and it will read 128k chunks direct from that device. Run on the same
> drives as above, reply with the vmstat info again.
>
Using kernel 2.6.12.5 again, here the results:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  0  0      0 8009648   4764  40592    0    0     0     0 1011    32  0  0 100  0
  0  0      0 8009648   4764  40592    0    0     0     0 1011    34  0  0 100  0
  0  0      0 8009648   4764  40592    0    0     0     0 1008    61  0  0 100  0
  0  0      0 8009648   4764  40592    0    0     0     0 1006    26  0  0 100  0
  0  8      0 8006372   4764  40592    0    0 120192     0 1944  1929  0  1 89 10
  2  8      0 8006372   4764  40592    0    0 319488     0 3502  4999  0  2 75 24
  0  8      0 8006372   4764  40592    0    0 319488     0 3506  4995  0  2 75 24
  0  8      0 8006372   4764  40592    0    0 319744     0 3504  4999  0  1 75 24
  0  8      0 8006372   4764  40592    0    0 319488     0 3507  5009  0  2 75 23
  0  8      0 8006372   4764  40592    0    0 319616     0 3506  5011  0  2 75 24
  0  8      0 8005124   4800  41100    0    0 319976     0 3536  4995  0  2 73 25
  0  8      0 8005124   4800  41100    0    0 323584     0 3534  5000  0  2 75 23
  0  8      0 8005124   4800  41100    0    0 323968     0 3540  5035  0  1 75 24
  0  8      0 8005124   4800  41100    0    0 319232     0 3506  4811  0  1 75 24
  0  8      0 8005504   4800  41100    0    0 317952     0 3498  4747  0  1 75 24
  0  8      0 8005504   4800  41100    0    0 318720     0 3495  4672  0  2 75 23
  1  8      0 8005504   4800  41100    0    0 318720     0 3509  4707  0  1 75 24
  0  8      0 8005504   4800  41100    0    0 318720     0 3499  4667  0  2 75 23
  0  8      0 8005504   4808  41092    0    0 318848    40 3509  4674  0  1 75 24
  0  8      0 8005380   4808  41092    0    0 318848     0 3497  4693  0  2 72 26
  0  8      0 8005380   4808  41092    0    0 318592     0 3500  4646  0  2 75 23
  0  8      0 8005380   4808  41092    0    0 318592     0 3495  4828  0  2 61 37
  0  8      0 8005380   4808  41092    0    0 318848     0 3499  4827  0  1 62 37
  1  8      0 8005380   4808  41092    0    0 318464     0 3495  4642  0  2 75 23
  0  8      0 8005380   4816  41084    0    0 318848    32 3511  4672  0  1 75 24
  0  8      0 8005380   4816  41084    0    0 320640     0 3512  4877  0  2 75 23
  0  8      0 8005380   4816  41084    0    0 322944     0 3533  5047  0  2 75 24
  0  8      0 8005380   4816  41084    0    0 322816     0 3531  5053  0  1 75 24
  0  8      0 8005380   4816  41084    0    0 322944     0 3531  5048  0  2 75 23
  0  8      0 8005380   4816  41084    0    0 322944     0 3529  5043  0  1 75 24
  0  0      0 8008360   4816  41084    0    0 266880     0 3112  4224  0  2 78 20
  0  0      0 8008360   4816  41084    0    0     0     0 1012    28  0  0 100  0

Holger

