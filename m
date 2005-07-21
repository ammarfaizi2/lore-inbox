Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVGUMQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVGUMQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 08:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVGUMQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 08:16:04 -0400
Received: from NS4.Sony.CO.JP ([137.153.0.44]:12030 "EHLO ns4.sony.co.jp")
	by vger.kernel.org with ESMTP id S261768AbVGUMQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 08:16:03 -0400
Message-ID: <42DF91FD.3050800@sm.sony.co.jp>
Date: Thu, 21 Jul 2005 08:15:57 -0400
From: Hiroyuki Machida <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFD] FAT robustness
References: <42D9FDAC.3010109@sm.sony.co.jp> <87fyuaq20z.fsf@devron.myhome.or.jp>
In-Reply-To: <87fyuaq20z.fsf@devron.myhome.or.jp>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

OGAWA Hirofumi wrote:
> Hiroyuki Machida <machida@sm.sony.co.jp> writes:
> 
> 
>>We currently plan to add following features to address FAT corruption.
>>
>>    - Utilize standard 2.6 features as much as possible
>>	- Implement as options of fat, vfat and uvfat
> 
> 
> What is the uvfat? typo (xvfat)?  Why is this an option (does it have
> the big demerit)?

uvfat is another variant of vfat, like umsdos.
Xvfat for 2.4 has following directories and file organization;
	most files are located at fs/xvfat.
	and most of them, copied from fs/fat and fs/vfat and renamed
	to have prefix like 'xvfat_'.
For 2.6, I feel that the above organization need to be changed.
And xvfat for 2.4 had some performance degradation. So I guess 'option'
is better.

> 
>>	- Utilize noop elevator to cancel unexpected operation reordering
> 
> 
> Why don't you use the barrier?

You mean that using requests with barrier flag is enough and there is
no reason to specify IO-sched ?

It is better to preserve order of updating data, some circumstance
like appending data. 

At xvfat for 2.4 had own elevator function, to preserve EraseBlock unit
ordering for memory card device. 

To begin consideration for 2.6, I'd like to make it simple. But later
we need to address to this issue. So I thought at first using "noop",
later switch special elevator function to handle device better.


> 
>>    - Coordinate order of operations so that update data first, meta
>>	 data later with transaction control
> 
> 
> Is this meaning the SoftUpdates? What does this guarantee? How does
> this handle the rename(), and cyclic dependency of updates?

In <42DE91E7.2060603@sm.sony.co.jp>, I mentioned about this.
 
> 
>>    - With O_SYNC, close() make flush all related data and
>>	 meta-data, then wait completion of I/O
> 
> 
> What is this meaning? Why does O_SYNC only flush at close()?

>From application's point of view, application wants to believe 
close()ed file is correctly written, without any corruption.

At least close() need to guarantee this. It's ok every write()
flush meta data and data and wait compeletion I/O.

At least fat on 2.4.20, VFS sync inode on write() with O_SYNC,
however it don't take care about super block. At FAT side 
don't care about O_SYNC. That's problem.


> Almost things in your email is needing the detail.

> I'm thinking the SoftUpdates is best solution for now. Could you tell
> the detail of your solution?

In <42DE91E7.2060603@sm.sony.co.jp>, I mentioned about this.

