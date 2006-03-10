Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751970AbWCJRdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbWCJRdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbWCJRdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:33:13 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:23749 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1751970AbWCJRdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:33:11 -0500
Message-ID: <4411B844.1080108@samwel.tk>
Date: Fri, 10 Mar 2006 18:32:52 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Andrew Morton <akpm@osdl.org>, Sam Vilain <sam@vilain.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Write the inode itself in block_fsync()
References: <87bqwfzixu.fsf@duaron.myhome.or.jp> <4410D0F1.3030307@vilain.net>	<20060309201053.682868db.akpm@osdl.org> <4411893C.6020008@samwel.tk> <8764mms4zt.fsf@duaron.myhome.or.jp>
In-Reply-To: <8764mms4zt.fsf@duaron.myhome.or.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> Bart Samwel <bart@samwel.tk> writes:
> 
>> Andrew Morton wrote:
>>> Sam Vilain <sam@vilain.net> wrote:
>>>> OGAWA Hirofumi wrote:
>>  >>
>>>>  Ouch... won't that halve performance of database transaction logs?
>>> Yes, it could well cause a lot more seeking to do atime and/or mtime
>>> writes.   Which aren't terribly important, really.
>>>
>>> Unless I'm missing something, I suspect we'd be better off without this,
>>> even though it's a correctness fix :(
>> Maybe atime/mtime aren't important, but I would be unhappy if a file 
>> size change wasn't written to disk on fsync.
> 
> Please don't worry, we should be doing a right thing for normal files
> already. This patch is just for block device file.

Ahhh, I missed that. I interpreted:

 >For block device's inode, we don't write a inode's meta data
 >itself. But, I think we should write inode's meta data for fsync().

as "for block devices we don't, for normal files, yes", but apparently 
that's not what you meant. :-)

>> Anyway, shouldn't databases be using a combination of fixed-size files 
>> and fdatasync? fsync doesn't perform well by definition, and I guess the 
>> only reason databases still use it is because the kernel failed to 
>> implement the sucky part of the behaviour.
> 
> Yes, I agree. The changes of atime/mtime only sets I_DIRTY_SYNC, so,
> usually this patch doesn't change fdatasync() at all.
> 
> Umm... however, I also can understand what akpm says.... check some databases.
> 
> 	berkeley db 4.4: use fdatasync() if available
>         mysql 5.0:	 use fdatasync() if available (innobase)
> 			 use fsync() (bdb)
> 	postgresql:	 use fdatasync() if available
> 	sqlite:		 use fsync

Nice piece of info. Apparently all of the "large" database engines can 
use fdatasync, only the smaller ones (bdb, sqlite) don't. I've done some 
extra research:

* From a quick look at the docs it seems to me that bdb can't be 
configured to put its transaction log directly on a block device, so bdb 
won't be affected.

* SQLite definitely can't write logs to a block device, the docs 
explicitly say that the transaction log is a regular file with a 
specific name, so we can write off sqlite as well. (It does seem to use 
fdatasync btw, since version 3.2.6, see http://www.sqlite.org/changes.html.)

If we've missed none, that leaves only proprietary databases at risk. 
But I would be genuinely surprised if a database like Oracle would use 
fsync. If we assume that Oracle et al. are not a problem, the risks of 
this patch are very low.

Cheers,
Bart
