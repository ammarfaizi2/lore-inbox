Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVBYPjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVBYPjB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 10:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVBYPhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 10:37:52 -0500
Received: from wasp.net.au ([203.190.192.17]:50144 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S262723AbVBYPhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 10:37:33 -0500
Message-ID: <421F4629.5080309@wasp.net.au>
Date: Fri, 25 Feb 2005 19:37:13 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050115)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Campbell <brad@wasp.net.au>
CC: lkml <linux-kernel@vger.kernel.org>,
       RAID Linux <linux-raid@vger.kernel.org>
Subject: Re: Raid-6 hang on write.
References: <421DE9A9.4090902@wasp.net.au>
In-Reply-To: <421DE9A9.4090902@wasp.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> G'day all,
> 
> I have a painful issue with a RAID-6 box. It only manifests itself on a 
> fully complete and synced up array, and I can't reproduce it on an array 
> smaller than the entire drives which means after every attempt at 
> debugging I have to endure a 12 hour resync before I try again.
> 

Having done a dodgy and managed to get a clean set of superblocks to play with, I have now managed 
to narrow it down a lot more.

It's going to lunch in get_active_stripe at
                                 wait_event_lock_irq(conf->wait_for_stripe,
                                                     !list_empty(&conf->inactive_list) &&
                                                     (atomic_read(&conf->active_stripes) < 
(NR_STRIPES *3/4)
                                                      || !conf->inactive_blocked),
                                                     conf->device_lock,
                                                     unplug_slaves(conf->mddev);
                                         );

Feb 25 16:50:06 storage1 kernel: conf->active_stripes 256
Feb 25 16:50:06 storage1 kernel: conf->inactive_blocked 1
Feb 25 16:50:06 storage1 kernel: list_empty(conf->inactive_list) 1
Feb 25 16:50:06 storage1 kernel: NR_STRIPES *3/4 192

So it appears it's unable to get a free stripe, and it just sits with the device_lock held, which 
prevents anything else from happening.

On further investigation it occurs when raid6d is calls md_check_recovery and this never returns, 
preventing raid6d from handling any stripes.

Turning on debugging in raid6main.c and md.c make it much harder to hit. So I'm assuming something 
timing related.

raid6d --> md_check_recovery --> generic_make_request --> make_request --> get_active_stripe

We are now out of stripes. Deadlock here. I put some debugging counters in md_check_recovery and it 
calls generic_make_request ~244 times and then deadlocks. (Depending on how many stripes were free 
before of course)

I have tried just increasing the number of stripes to 2048 but that just took longer to hit and when 
it does the machine hard locks. (Whereas at least with 256 it just locks the md subsystem)

I'm now at a loss.

I guess the main issue is lots of drives on a slow IO bus, but there must be something I'm missing.
Pointers or thumps with the clue bat would be appreciated.

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
