Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265400AbVBFDc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265400AbVBFDc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 22:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269202AbVBFDc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 22:32:28 -0500
Received: from [211.58.254.17] ([211.58.254.17]:19115 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S268802AbVBFDb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 22:31:28 -0500
Message-ID: <42058F89.70008@home-tj.org>
Date: Sun, 06 Feb 2005 12:31:21 +0900
From: Tejun Heo <tj@home-tj.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2] ide: merge do_rw_taskfile() and flagged_taskfile()
 into do_taskfile()
References: <20050206021331.GA25337@htj.dyndns.org> <58cb370e050205190469dcb967@mail.gmail.com>
In-Reply-To: <58cb370e050205190469dcb967@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Bartlomiej Zolnierkiewicz wrote:
> On Sun, 6 Feb 2005 11:13:31 +0900, Tejun Heo <tj@home-tj.org> wrote:
> 
>> Hello, Bartlomiej.
> 
> 
> Hi,
> 
> 
>> This is a new version of ide_do_taskfile.patch.  Compared to the
>>original do_rw_task(), only one more 'if' is used in the hot path, so
>>I think the performance issue can be ignored now.  Also, there's no
>>userland visible change with this patch.  Everything should work just
>>as it did with do_rw_taskfile()/flagged_taskfile().
>>
>> do_taskfile() is different from do_rw_taskfile() in that
> 
> 
> Is there any gain in changing name to do_taskfile()?
>  

  Well, I was just thinking

  do_rw_taskfile + (do_)flagged_taskfile -> do_taskfile.

  If you like do_rw_taskfile better, I guess that's okay too. :-)

> 
>> - It uses task->data_phase to determine whether it's a DMA command
>>   or not.
> 
> 
> this is user-space visible change
> (it is right thing to do, I just wanted to point the fact)
> 

  Oops, I forgot that.  Still, it was kind of weird before.  If any of 
tf_{in|out}_flags is set, flagged_taskfile() is called and ->data_phase 
was used, but, if none of the flags was set, do_rw_taskfile() was called 
and the command is used to determine the same thing.  But, yeah, it's 
user-visible.

> 
>> do_taskfile() is different from flagged_taskfile() in that
>>
>> - No (TASKFILE_MULTI_IN && !mult_count) check.  ide_taskfile_ioctl()
>>   checks the same thing, so it doesn't change anything.
> 
> 
> The check may be needed.  AFAIR drive->mult_count may change
> before our taskfile request is started.
> 

  Okay, I'll resurrect that test.

> 
>> - No task->tf_out_flags handling.  ide_end_drive_cmd() ignores it
>>   anyway, so, again, it doesn't change anything.
> 
> 
> I guess you mean ->tf_in_flags?
> 

  Yes.

> 
>> So, what do you think?
> 
> 
> This patch looks much better but could you move writing taskfile
> registers to separate helpers (one for non-flagged and one for flagged)?
> 
> Probably splitting non-flagged taskfile load helper off do_rw_taskfile()
> should be done in separate patch.  We can then use this helper in
> ide-disk.c for __ide_do_rw_taskfile() (we can't do direct conversion
> to do_rw_taskfile() yet for various reasons).

  Sure, I'll do it now.

  Thanks.

-- 
tejun

