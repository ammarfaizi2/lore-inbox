Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbVHaSGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVHaSGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 14:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVHaSGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 14:06:05 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:26715 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S964910AbVHaSGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 14:06:04 -0400
Message-ID: <4315F18A.1060709@tls.msk.ru>
Date: Wed, 31 Aug 2005 22:06:02 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Holger Kiehl <Holger.Kiehl@dwd.de>
CC: Jens Axboe <axboe@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de> <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de> <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de> <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de> <20050831120714.GT4018@suse.de> <Pine.LNX.4.61.0508311339140.16574@diagnostix.dwd.de> <20050831162053.GG4018@suse.de> <Pine.LNX.4.61.0508311648390.16574@diagnostix.dwd.de>
In-Reply-To: <Pine.LNX.4.61.0508311648390.16574@diagnostix.dwd.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Kiehl wrote:
> On Wed, 31 Aug 2005, Jens Axboe wrote:
> 
>> On Wed, Aug 31 2005, Holger Kiehl wrote:
>>
[]
>>> I used the following command reading from all 8 disks in parallel:
>>>
>>>    dd if=/dev/sd?1 of=/dev/null bs=256k count=78125
>>>
>>> Here vmstat output (I just cut something out in the middle):
>>>
>>> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>>>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>>>  3  7   4348  42640 7799984   9612    0    0 322816     0 3532  4987 0 22 0 78
>>>  1  7   4348  42136 7800624   9584    0    0 322176     0 3526  4987 0 23 4 74
>>>  0  8   4348  39912 7802648   9668    0    0 322176     0 3525  4955 0 22 12 66
>>
>> Ok, so that's somewhat better than the writes but still off from what
>> the individual drives can do in total.
>>
>>>> You might want to try the same with direct io, just to eliminate the
>>>> costly user copy. I don't expect it to make much of a difference though,
>>>> feels like the problem is elsewhere (driver, most likely).
>>>>
>>> Sorry, I don't know how to do this. Do you mean using a C program
>>> that sets some flag to do direct io, or how can I do that?
>>
>> I've attached a little sample for you, just run ala
>>
>> # ./oread /dev/sdX
>>
>> and it will read 128k chunks direct from that device. Run on the same
>> drives as above, reply with the vmstat info again.
>>
> Using kernel 2.6.12.5 again, here the results:
> 
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  0  8      0 8005380   4816  41084    0    0 318848    32 3511  4672  0 1 75 24
>  0  8      0 8005380   4816  41084    0    0 320640     0 3512  4877  0 2 75 23
>  0  8      0 8005380   4816  41084    0    0 322944     0 3533  5047  0 2 75 24
>  0  8      0 8005380   4816  41084    0    0 322816     0 3531  5053  0 1 75 24
>  0  8      0 8005380   4816  41084    0    0 322944     0 3531  5048  0 2 75 23
>  0  8      0 8005380   4816  41084    0    0 322944     0 3529  5043  0 1 75 24
>  0  0      0 8008360   4816  41084    0    0 266880     0 3112  4224  0 2 78 20

I went on and did similar tests on our box, which is:

 dual Xeon 2.44GHz with HT (so it's like 4 logical CPUs)
 dual-channel AIC-7902 U320 controller
 8 SEAGATE ST336607LW drives attached to the 2 channels of the
  controller, sd[abcd] to channel 0 and sd[efgh] to channel 1

Each drive is capable to get about 60 megabytes/sec.
The kernel is 2.6.13 from kernel.org.

With direct-reading:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  8     12     87    471   1839    0    0 455296    84 1936  3739  0  3 47 50
 1  7     12     87    471   1839    0    0 456704    80 1941  3744  0  4 48 48
 1  7     12     87    471   1839    0    0 446464    82 1914  3648  0  2 48 50
 0  8     12     87    471   1839    0    0 454016    94 1944  3765  0  2 47 50
 0  8     12     87    471   1839    0    0 458752    60 1944  3746  0  2 48 50

Without direct:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 8  6     12     80    470   1839    0    0 359966   124 1726  2270  1 89  0 10
 2  7     12     80    470   1839    0    0 352813   113 1741  2124  1 88  1 10
 8  4     12     80    471   1839    0    0 358990    34 1669  1934  1 94  0  5
 7  5     12     79    471   1839    0    0 354065   157 1761  2128  1 90  1  8
 6  5     12     80    471   1839    0    0 358062    44 1686  1911  1 93  0  6

So the difference direct vs "indirect" is quite.. significant.  And with
direct-reading, all 8 drives are up to their real speed.  Note the CPU usage
in case of "indirect" reading too - it's about 90%...

And here's an idle system as well:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0     12     89    471   1839    0    0     0    58  151   358  0  0 100  0
 0  0     12     89    471   1839    0    0     0    66  157   167  0  0 99  0

Too bad I can't perform write tests on this system...

/mjt
