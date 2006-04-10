Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWDJLpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWDJLpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 07:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWDJLpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 07:45:40 -0400
Received: from alpha.polcom.net ([83.143.162.52]:1691 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1751141AbWDJLpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 07:45:40 -0400
Date: Mon, 10 Apr 2006 13:45:32 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: Slow swapon for big (12GB) swap
In-Reply-To: <20060410025419.65456ca9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0604101332490.31989@alpha.polcom.net>
References: <Pine.LNX.4.63.0604091338030.31989@alpha.polcom.net>
 <20060410004030.5e48be79.akpm@osdl.org> <Pine.LNX.4.63.0604101218380.31989@alpha.polcom.net>
 <20060410025419.65456ca9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2006, Andrew Morton wrote:
> Grzegorz Kulewski <kangur@polcom.net> wrote:
>> On Mon, 10 Apr 2006, Andrew Morton wrote:
>>> Grzegorz Kulewski <kangur@polcom.net> wrote:
>>>> I am using big swap here (as a backing for potentially huge tmpfs). And I
>>>>  wonder why swapon on such big (like 12GB) swap takes about 7 minutes
>>>>  (continuous disk IO).
>>>
>>> It's a bit quicker here:
>>>
>>> vmm:/usr/src/25# mkswap /dev/hda6
>>> Setting up swapspace version 1, size = 54031826 kB
>>> vmm:/usr/src/25# time swapon /dev/hda6
>>> swapon /dev/hda6  0.00s user 0.04s system 74% cpu 0.054 total
>>>
>>>
>>>> Is this expected?
>>>
>>> Nope.
>>>
>>>> Why it is like that?
>>>
>>> Are you using a swapfile or a swap partition?
>>
>> Swap file.
>>
>>
>>> If it's a swapfile then perhaps the filesystem is being inefficient in its
>>> bmap() function.  Which filesystem is it?
>>
>> Ext3.
>>
>
> OK.  A 12G file is around 3000 indirect blocks.  At 10 milliseconds each
> I'd expect it to take 30-odd seconds.  A 14G swapfile here takes 20 second
> for swapon.

That is what I would expect.


> Maybe your disks are slow, or the fs is already quite full+fragmented.

Well, the disk is slow but not that slow... For example dd creating this 
file goes at about 20-25MB/s and takes about 10 minutes IIRC, so it is not 
*that* bad...

The disk is not full or even close to:
/dev/hda4          /mnt/data        52552,1  27343,6  24140,4  54%  ext3

and file count is not that high too:
/dev/hda4            6836224   42333 6793891    1% /mnt/data

and it should not be fragmented in any way. It is rather new (3 months 
old) filesystem with several bigger files and small amount of smaller. 
Used mainly as a data store and backup. Very infrequently written to (new 
blocks/files).

I think I will test new kernel soon. Maybe with and without -ck. Maybe 
disk scheduler (probably CFQ) does something stupid... Or swap prefetch... 
Or anything...


Thanks,

Grzegorz Kulewski

