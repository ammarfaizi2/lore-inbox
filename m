Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272403AbTGaGgs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 02:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272804AbTGaGgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 02:36:48 -0400
Received: from dyn-ctb-210-9-243-68.webone.com.au ([210.9.243.68]:61970 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S272403AbTGaGgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 02:36:46 -0400
Message-ID: <3F28B8D5.4040600@cyberone.com.au>
Date: Thu, 31 Jul 2003 16:36:05 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Johoho <johoho@hojo-net.de>, wodecki@gmx.de, Valdis.Kletnieks@vt.edu,
       kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O10int for interactivity
References: <200307280112.16043.kernel@kolivas.org>	<200307281808.h6SI8C5k004439@turing-police.cc.vt.edu>	<20030728114041.2c8ce156.akpm@osdl.org>	<20030728212939.GB6798@gmx.de> <20030728143545.1d989946.akpm@osdl.org>
In-Reply-To: <20030728143545.1d989946.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Wiktor Wodecki <wodecki@gmx.de> wrote:
>
>>On Mon, Jul 28, 2003 at 11:40:41AM -0700, Andrew Morton wrote:
>>
>>>Valdis.Kletnieks@vt.edu wrote:
>>>
>>>>I am, however, able to get 'xmms' to skip.  The reason is that the CPU is being
>>>> scheduled quite adequately, but I/O is *NOT*.
>>>>
>>>>...
>>>> I'm guessing that the anticipatory scheduler is the culprit here.  Soon as I figure
>>>> out the incantations to use the deadline scheduler, I'll report back....
>>>>
>>>Try decreasing the expiry times in /sys/block/hda/queue/iosched:
>>>
>>>read_batch_expire
>>>read_expire
>>>write_batch_expire
>>>write_expire
>>>
>>I noticed that when bringing a huge application out of swap (mozilla,
>>openoffice, also tested the gimp with 50 images open) that dividing
>>everything by 2 in those 4 files I get a decent process fork. Without
>>this tuning the fork (xterm) waits till the application is back up.
>>    
>>
>
>Interesting.  What we have there is pretty much a straight tradeoff between
>latency and throughput.  It could be that the defaults are not centered in
>the right spot.
>

Well it should help a bad case application by about 2x by doing this.
It will very roughly change efficiency of a streaming IO vs other IO
from 80% to 60% which is going too far for a default IMO. A better
idea would be to do the exec prefaulting you had in your tree...

Oh, and the process scheduler can definitely be a contributing factor.
Even if it looks like your process is getting enough cpu, if your
process doesn't get woken in less than 5ms after its read completes,
then AS will give up waiting for it.

>
>It will need some careful characterisation.  Maybe we can persuade Nick to
>generate the mystical Documentation/as-iosched.txt?
>

I did send one to you but not in patch form so I guess you were a
bit lazy with it! I guess I'll be doing this autotuning thing soon
so it is going to change.

