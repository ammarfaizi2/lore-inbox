Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269255AbTGJMjX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269256AbTGJMjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:39:23 -0400
Received: from news.cistron.nl ([62.216.30.38]:25611 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S269255AbTGJMjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:39:21 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: 2.5.74-mm3 OOM killer fubared ?
Date: Thu, 10 Jul 2003 12:54:01 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bejnl9$m9l$1@news.cistron.nl>
References: <bejhrj$dgg$1@news.cistron.nl> <20030710112728.GX15452@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1057841641 22837 62.216.29.200 (10 Jul 2003 12:54:01 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030710112728.GX15452@holomorphy.com>,
William Lee Irwin III  <wli@holomorphy.com> wrote:
>On Thu, Jul 10, 2003 at 11:14:59AM +0000, Miquel van Smoorenburg wrote:
>> Enough memory free, no problems at all .. yet every few minutes
>> the OOM killer kills one of my innfeed processes.
>> I notice that in -mm3 this was deleted relative to -vanilla:
>> 
>> -
>> -       /*
>> -        * Enough swap space left?  Not OOM.
>> -        */
>> -       if (nr_swap_pages > 0)
>> -               return;
>> .. is that what causes this ? In any case, that should't vene matter -
>> there's plenty of memory in this box, all buffers and cached, but that
>> should be easily freed ..
>
>This means we're calling into it more often than we should be.
>Basically, we hit __alloc_pages() with __GFP_WAIT set, find nothing
>we're allowed to touch, dive into try_to_free_pages(), fall through
>scanning there, sleep in blk_congestion_wait(), wake up again, try
>to shrink_slab(), find nothing there either, repeat that 11 more times,
>and then fall through to out_of_memory()... and this happens at at
>least 10Hz.
>
>        since = now - lastkill;
>        if (since < HZ*5)
>                goto out_unlock;
>
>try s/goto out_unlock/goto reset/ and let me know how it goes.

But that will only change the rate at which processes are killed,
not the fact that they are killed in the first place, right ?

As I said I've got plenty memory free ... perhaps I need to tune
/proc/sys/vm because I've got so much streaming I/O ? Possibly,
there are too many dirty pages so cleaning them out faster might
help (and let pflushd do it instead of my single-threaded app)

# cd /proc/sys/vm
# echo 200 > dirty_writeback_centisecs
# echo 60 > dirty_ratio
# echo 500 > dirty_expire_centisecs

I'll let it run like this for a while first.

If this helps, perhaps it means that the VM doesn't write out
dirty pages fast enough when low on memory ?

Mike.

