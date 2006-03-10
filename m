Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWCJOM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWCJOM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 09:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWCJOM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 09:12:27 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:48831 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1751224AbWCJOM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 09:12:27 -0500
Message-ID: <4411893C.6020008@samwel.tk>
Date: Fri, 10 Mar 2006 15:12:12 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Sam Vilain <sam@vilain.net>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Write the inode itself in block_fsync()
References: <87bqwfzixu.fsf@duaron.myhome.or.jp>	<4410D0F1.3030307@vilain.net> <20060309201053.682868db.akpm@osdl.org>
In-Reply-To: <20060309201053.682868db.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Sam Vilain <sam@vilain.net> wrote:
>> OGAWA Hirofumi wrote:
 >>
>>  >For block device's inode, we don't write a inode's meta data
>>  >itself. But, I think we should write inode's meta data for fsync().
>>
>>  Ouch... won't that halve performance of database transaction logs?
> 
> Yes, it could well cause a lot more seeking to do atime and/or mtime
> writes.   Which aren't terribly important, really.
> 
> Unless I'm missing something, I suspect we'd be better off without this,
> even though it's a correctness fix :(

Maybe atime/mtime aren't important, but I would be unhappy if a file 
size change wasn't written to disk on fsync.

Anyway, shouldn't databases be using a combination of fixed-size files 
and fdatasync? fsync doesn't perform well by definition, and I guess the 
only reason databases still use it is because the kernel failed to 
implement the sucky part of the behaviour.

A complex but perhaps viable suggestion: as atime/mtime are stored on 
disk  in second granularity (on ext3 at least, don't know about other 
fss), wouldn't it somehow be possible to only regard atime/mtime changes 
as real changes when i_(a|c)time.tv_sec changes? This would enable fsync 
to write the inode once every second instead of on every fsync. The 
performance drop would be much less dramatic than writing the inode on 
every fsync, and it would at least yield correct behaviour.

Cheers,
Bart
