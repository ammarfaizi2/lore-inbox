Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVKKN2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVKKN2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 08:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVKKN2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 08:28:49 -0500
Received: from tornado.reub.net ([202.89.145.182]:59354 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750743AbVKKN2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 08:28:48 -0500
Message-ID: <43749C86.8010009@reub.net>
Date: Sat, 12 Nov 2005 02:28:38 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20051110)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm2
References: <20051110203544.027e992c.akpm@osdl.org>	<43743105.7030201@reub.net>	<20051110220727.13b084f4.akpm@osdl.org>	<43745633.1030802@reub.net> <20051111005513.0dda25f3.akpm@osdl.org>
In-Reply-To: <20051111005513.0dda25f3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2005 9:55 p.m., Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>> The 2.6.14 with your linus.patch works fine, so it looks like an -mm(1|2) 
>> specific problem, which is common to both sky2 and e100 drivers (unlikely to 
>> be e100 specific I guess).
> 
> That's getting us closer.
> 
> Would you be able to revert the git-netdev-all.patch changes in e100.c?  To
> do that, take the drivers/net/e100.c from 2.6.14+linus.patch and simply
> overwrite the e100.c in 2.6.14-mm2 with it.
> 
> Or, prepare a 2.6.14-mm2 tree and use
> http://www.zip.com.au/~akpm/linux/patches/stuff/e100.c, which amounts to
> the same thing.
> 
> Thanks.

Unfortunately made no difference.

However I noticed that I had compiled 2.6.14-mm1+2 with a couple of different
and probably significant config options from rc5-mm1:

CONFIG_PREEMPT=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_KALLSYMS_ALL=y

I reverted those changes and rebuilt -mm2, and it all seems OK now after 6x 
reboots and about 18 or so times removal and reinsertion of the two modules. 
The reason for this being on in the config was that PREEMPT and the debug for 
it was turned on to find the sd.c oopsing problem I had in -mm1, but it was 
obviously not turned off afterwards.  I'm not sure it should have *needed* to 
be turned off though?

Then to double check I put CONFIG_PREEMPT and CONFIG_DEBUG_PREEMPT back into 
that same config via menuconfig the way it was originally, made mrproper and 
rebuilt, and the network failed to come up at all (again) on boot on first 
attempt.  This is consistent with both network drivers and not just the e100 
failing to function, I think, as either both drivers always work, or both 
always fail.

So in summary -

2.6.14-rc5-mm1 (preempt): <didn't test>
2.6.14-rc5-mm1 (no preempt) : works
2.6.14 with linus.patch (preempt): works
2.6.14 with linus.patch (no preempt): works
2.6.14-mm1 (preempt): broken ***
2.6.14-mm1 (no preempt): <didn't test>
2.6.14-mm2 (preempt): broken ***
2.6.14-mm2 (no preempt): works

All tests done with multiple reboots.

-mm2 seems otherwise to be quite OK apart from this issue.


