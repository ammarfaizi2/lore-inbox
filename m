Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUFJGDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUFJGDn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUFJGDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:03:43 -0400
Received: from ip-65-77-168-70-muca.aerosurf.net ([65.77.168.70]:4564 "EHLO
	bedevere.spamaps.org") by vger.kernel.org with ESMTP
	id S266129AbUFJGDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:03:41 -0400
Date: Wed, 9 Jun 2004 23:03:38 -0700
Subject: Re: 2.6 vm/elevator loading down disks where 2.4 does not
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: Ray Lee <ray-lk@madrabbit.org>
From: Clint Byrum <cbyrum@spamaps.org>
In-Reply-To: <1086829384.13085.10.camel@orca.madrabbit.org>
Message-Id: <EAAE7256-BAA3-11D8-B30D-000A95730E92@spamaps.org>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.553)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday, June 9, 2004, at 06:03 PM, Ray Lee wrote:

>> Upon investigation, we saw that the 2.6 box was reading from the disk
>> about 5 times as much as 2.4.
>
> I don't think this will account for the entire change in disk activity,
> but 2.6.7-pre? contains a fix for the read ahead code to prevent it 
> from
> reading extra sectors when unneeded.
>
> The fix applies to 'seeky database type loads' which...
>
>> The data access patterns are generally "search through index files in
>> a tree-walking type of manner, then seek to data records in data
>> files."
>
> ...sounds like it may apply to you.
>
> So, if you and your server have some time, you might try 2.6.7rc3 and
> see if it changes any of the numbers.
>

I updated my 2.6 box to 2.6.7-rc3 a few hours ago. While its not really 
fair to pass judgement during such low-traffic times, things look about 
the same. Where i see the 2.4 box not even touching the disks for a 
minute or longer, the 2.6 box will hit it every 10 seconds at least, 
and hit it with 40 blocks or more. 3 hours should be plenty of time to 
get the indexes and data files mostly cached.

It almost seems to me like 2.6 is caching too much with each read, and 
therefore having to free other pages that really should have been left 
alone. This might even explain why 2.4 is maintaining a lot more free 
memory (75-80MB versus 2.6 having only 15-20MB free) and less cache. 
Oddly enough, I noticed that the blockdev command reports 256 as the 
readahead in 2.6.x, but 1024 in 2.4.x. I tried mucking with that value 
but it didn't make a whole lot of difference.

Might it help to have some swap available, if for nothing else but to 
make the algorithms work better? Really the box should never use it; 
there are no daemons that go unused for longer than 10 minutes ...  and 
when I have turned on swap in the past, it uses less than 2MB of it. 
This machine, for all intents and purposes, should spend most of its 
time searching an index and database that are already cached.. 90% of 
the searches are on similar terms.

That brings up an interesting point... is there a system wide stat that 
tells me how effective the file cache is? I guess majfaults/s fits that 
bill to some degree.

