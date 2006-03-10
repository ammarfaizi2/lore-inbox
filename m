Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWCJPSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWCJPSe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWCJPSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:18:33 -0500
Received: from mail.parknet.jp ([210.171.160.80]:59406 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1750771AbWCJPS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:18:29 -0500
X-AuthUser: hirofumi@parknet.jp
To: Bart Samwel <bart@samwel.tk>
Cc: Andrew Morton <akpm@osdl.org>, Sam Vilain <sam@vilain.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Write the inode itself in block_fsync()
References: <87bqwfzixu.fsf@duaron.myhome.or.jp> <4410D0F1.3030307@vilain.net>
	<20060309201053.682868db.akpm@osdl.org> <4411893C.6020008@samwel.tk>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 11 Mar 2006 00:18:14 +0900
In-Reply-To: <4411893C.6020008@samwel.tk> (Bart Samwel's message of "Fri, 10 Mar 2006 15:12:12 +0100")
Message-ID: <8764mms4zt.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Samwel <bart@samwel.tk> writes:

> Andrew Morton wrote:
>> Sam Vilain <sam@vilain.net> wrote:
>>> OGAWA Hirofumi wrote:
>  >>
>>>  >For block device's inode, we don't write a inode's meta data
>>>  >itself. But, I think we should write inode's meta data for fsync().
>>>
>>>  Ouch... won't that halve performance of database transaction logs?
>> 
>> Yes, it could well cause a lot more seeking to do atime and/or mtime
>> writes.   Which aren't terribly important, really.
>> 
>> Unless I'm missing something, I suspect we'd be better off without this,
>> even though it's a correctness fix :(
>
> Maybe atime/mtime aren't important, but I would be unhappy if a file 
> size change wasn't written to disk on fsync.

Please don't worry, we should be doing a right thing for normal files
already. This patch is just for block device file.

> Anyway, shouldn't databases be using a combination of fixed-size files 
> and fdatasync? fsync doesn't perform well by definition, and I guess the 
> only reason databases still use it is because the kernel failed to 
> implement the sucky part of the behaviour.

Yes, I agree. The changes of atime/mtime only sets I_DIRTY_SYNC, so,
usually this patch doesn't change fdatasync() at all.

Umm... however, I also can understand what akpm says.... check some databases.

	berkeley db 4.4: use fdatasync() if available
        mysql 5.0:	 use fdatasync() if available (innobase)
			 use fsync() (bdb)
	postgresql:	 use fdatasync() if available
	sqlite:		 use fsync

After all, I don't know.

> A complex but perhaps viable suggestion: as atime/mtime are stored
> on disk in second granularity (on ext3 at least, don't know about
> other fss), wouldn't it somehow be possible to only regard
> atime/mtime changes as real changes when i_(a|c)time.tv_sec changes?
> This would enable fsync to write the inode once every second instead
> of on every fsync. The performance drop would be much less dramatic
> than writing the inode on every fsync, and it would at least yield
> correct behaviour.

Yes, and we are already doing it.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
