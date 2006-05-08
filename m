Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWEHPio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWEHPio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWEHPin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:38:43 -0400
Received: from mail.crosswalkinc.com ([72.16.196.98]:36496 "EHLO
	coach.cozx.com") by vger.kernel.org with ESMTP id S932407AbWEHPin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:38:43 -0400
Message-ID: <445F66B4.6010907@cozx.com>
Date: Mon, 08 May 2006 09:41:40 -0600
From: Dave Pitts <dpitts@cozx.com>
Organization: Colorado Zephyrs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How can I boost block I/O performance
References: <445CE6ED.30703@cozx.com> <445CF9E4.3040202@argo.co.il> <445D124E.2020404@cozx.com> <445D81FB.5030808@argo.co.il>
In-Reply-To: <445D81FB.5030808@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:

> Dave Pitts wrote:
>
>> Avi Kivity wrote:
>>
>>> Dave Pitts wrote:
>>>
>>>>
>>>> procs -----------memory---------- ---swap-- -----io---- --system-- 
>>>> ----cpu----
>>>> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs 
>>>> us sy id wa
>>>> 4  0    720  80252   1820 7077456    0    0     9   852    5    11  
>>>> 1 14 84  0
>>>
>>>
>>> [...]
>>>
>>>> 5  0    720  90364   1860 7067080    0    0    40 66956 17995 
>>>> 95384  0 17 82  0
>>>>
>>>> This test is running several NFS clients to a RAID disk storage 
>>>> array. I also see the
>>>> same behavior when running SFTP transfers. What I'd like is a more 
>>>> even block
>>>> out behavior (even at the expense of other apps as this is a file 
>>>> server not an app
>>>> server).  The values that I've been hacking are the 
>>>> dirty_writeback_centisecs,
>>>> dirty_background_ratio, etc. Am I barking up the wrong tree?
>>>
>>>
>>> No  iowait time, plenty of idle time: looks like you are network 
>>> bound. What time of network are you running?
>>>
>> Well, it's an 8 cpu system. Does the idle time reflect the idle time 
>> of all cpu's?
>
>
> It's an average across all cpus. But the numbers are low even for a 
> single cpu system.

OK, I ran some tests, bypassing NFS, and got the following vmstat display:

procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
id wa
 4  1    696  80692    844 7225424    0    0    92 263924 14380  6176  2 
40 46 12
 6  0    696 108668    784 7200936    0    0   456  6444 30515 20641  3 
57 36  3
 5  1    696 100916    768 7211220    0    0   508 97276 31761 19916  3 
65 27  4
 7  0    700  91188    764 7217340    0    0   428 121576 28704 21957  3 
69 24 3
 3  3    700 103356    780 7204472    0    0   408 121748 29513 22603  3 
66 23 8
 7  0    700  92836    780 7216168    0    0   360 43508 28784 21410  3 
54 33 11
 7  0    700  88364    768 7224272    0    0   296 158236 26530 17570  3 
66 21 10
10  0    700  91068    776 7219096    0    0   444 141456 30306 16053  3 
74 16 7
 5  2    700 102212    752 7206676    0    0   340 170076 29249 14872  2 
69 19 10
11  0    700  87884    768 7222096    0    0   392 143312 29743 19808  1 
65 23 11
 8  0    700 104692    744 7204644    0    0   240 159624 25814 18747  3 
58 20 19
 9  0    700 107196    736 7205196    0    0   344 148500 28191 18113  3 
70 21 6
16  1    700  99300    768 7211364    0   12   464 164348 25671 18326  4 
64 18 15
 5  4    700 107412   1052 7204824    0    0   936 170904 28994 17062  3 
73 11 14
 8  1    700  98892   1284 7217512    0    0   596 182708 31520 18424  1 
76 13 10

This ia with 6 concurrent data streams. In addition to the 
/proc/sys/vm/dirty* values I  also adjusted
values in mm/page-writeback.c  eg. MAX_WRITEBACK_PAGES to 8192 . Our 
goal is to blast out
as much as possible per pdflush invocation.

>
>> The network is a Gigabit Ethernet.
>>
>
> I'd make sure the nics know that by running ethtool (on the clients as 
> well as on the server).
>
>
>


-- 
Dave Pitts                   PULLMAN: Travel and sleep in safety and comfort.
dpitts@cozx.com              My other RV IS a Pullman (Colorado Pine).
http://www.cozx.com/~dpitts

