Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVGUO53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVGUO53 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 10:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVGUO53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 10:57:29 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:13068 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261784AbVGUO52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 10:57:28 -0400
To: Hiroyuki Machida <machida@sm.sony.co.jp>
Cc: Paulo Marques <pmarques@grupopie.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFD] FAT robustness
References: <42D9FDAC.3010109@sm.sony.co.jp> <42DB9911.9010106@grupopie.com>
	<42DE91E7.2060603@sm.sony.co.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 21 Jul 2005 23:56:53 +0900
In-Reply-To: <42DE91E7.2060603@sm.sony.co.jp> (Hiroyuki Machida's message of "Wed, 20 Jul 2005 14:03:19 -0400")
Message-ID: <87wtnknr62.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiroyuki Machida <machida@sm.sony.co.jp> writes:

>>>	- Utilize noop elevator to cancel unexpected operation reordering
>> Why don't you use the barrier?
>
> You mean that using requests with barrier flag is enough and there is
> no reason to specify IO-sched ?
>
> It is better to preserve order of updating data, some circumstance
> like appending data. 
>
> At xvfat for 2.4 had own elevator function, to preserve EraseBlock unit
> ordering for memory card device. 
>
> To begin consideration for 2.6, I'd like to make it simple. But later
> we need to address to this issue. So I thought at first using "noop",
> later switch special elevator function to handle device better.

Um.. The independent updates is merged at special elevator, yes?

If so, to merge also can do it well by fs-layer, then normal elevator
can optimize the seek for HDD, no?  If it's possible, I'd not like to
depend to special elevator.

>>>    - With O_SYNC, close() make flush all related data and
>>>	 meta-data, then wait completion of I/O
>> What is this meaning? Why does O_SYNC only flush at close()?
>
> From application's point of view, application wants to believe 
> close()ed file is correctly written, without any corruption.
>
> At least close() need to guarantee this. It's ok every write()
> flush meta data and data and wait compeletion I/O.
>
> At least fat on 2.4.20, VFS sync inode on write() with O_SYNC,
> however it don't take care about super block. At FAT side don't care
> about O_SYNC. That's problem.

Ah, 2.6.12 was added the support of O_SYNC.  Yes, it should be the
every write().  If application need it at close() only, can use fsync().

Hiroyuki Machida <machida@sm.sony.co.jp> writes:

> I need to explain background information more. My descriptions tends
> to be depend on some knowledge about current xvfat for 2.4 kernel.
>
> I'm not a author of xvfat fo 2.4 kernel, but can explain little more.
>
> Current xvfat for 2.4 is designed to some specific flash memory card
> controller which can guarantee atomicity of operation on ERASE-BLOCK size
> unit. Xvfat for 2.4 try to merge operations on same ERASE-BLOCK under
> some ordering constrain.
>
> And xvfat for 2.4 uses own version of transaction control using
> in-core memory, not storage device like HDD nor flash ram,
> to accomplish the above goal, with minimal changes on existing
> FAT implementation. And this transaction control let FAT operations
> came from different threads to fee from mixed up, where potentially
> operation ordering problems would be caused.
>
> We'll start with HDD, however later we'll cover memory devices.
> For memory devices we may prepare another elevator functions,
> depending on property of devices or lower layer. E.g. NAND/AND flash
> have  different operation units for read/write and erase,
> and have some translation layer.

[...]

> As other messages said, some developers suggest "SoftUpdate" to be used.
> I need to consider about situation where memory devices are used, not HDD.

SoftUpdates itself is not depending to blocksize of atomicity
operation.  And same robustness with xvfat will be provided by it,
although probably multiple blocksize of atomicity operation may be
complex.

It is controling the dependency at very fine-granularity.  And by
default it will be used, because performance is very good.

This is why I'm thinking SoftUpdates is best solution and I'd like to
hear the detail.
--
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
