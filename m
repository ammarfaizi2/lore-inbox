Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280949AbRKLT7G>; Mon, 12 Nov 2001 14:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280954AbRKLT65>; Mon, 12 Nov 2001 14:58:57 -0500
Received: from [195.63.194.11] ([195.63.194.11]:14090 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280949AbRKLT6u>; Mon, 12 Nov 2001 14:58:50 -0500
Message-ID: <3BF0365E.46DAABB0@evision-ventures.com>
Date: Mon, 12 Nov 2001 21:51:42 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: what is teh current meaning of blk_size?
In-Reply-To: <200111121939.UAA04358@nbd.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:
> 
> Is blk_size[][] supposed to contain the size in KB or blocks?
> 
> I'm confused because it looks to me as though it's still in KB,
> but people say that devices can be up to 8 or 16TB, and there's
> not enough room for that within a signed int containing KB
> (2^31 * 2^10 = 2^41 = 2TB).
> 
> Either the rumour is true and it's in blocks, or the rumour
> is false and it's in KB.
> 
> Clue, please!

There is no rumor it's in blocks.

There are three level of block size measurements in linux:

1. FS level one.	(page chunks most of time main exceptions are dos and
isofs)
2. Driver level one.	(nearly always 1024, main exception are ATAPI
cdrom)
3. Hardware device level one. (nearly always 512, only prehistoric SCSI
drives from the stone age are exceptional and providing 256 byte sized
block. We discovered them druing our archeological efforts recently
under 
a thick layer of mood...)

It's left as an exercies to the reader which one of the sparse
matrices in ll_rw_blk.c is declaring which ;-).
...

OK I was to fast to figure it out:


/*
 * blk_size contains the size of all block-devices in units of 1024 byte
 * sectors:
 *
 * blk_size[MAJOR][MINOR]
 *
 * if (!blk_size[MAJOR]) then no minor size checking is done.
 */
int * blk_size[MAX_BLKDEV];

/*
 * blksize_size contains the size of all block-devices:
 *
 * blksize_size[MAJOR][MINOR]
 *
 * if (!blksize_size[MAJOR]) then 1024 bytes is assumed.
 */
int * blksize_size[MAX_BLKDEV];

/*
 * hardsect_size contains the size of the hardware sector of a device.
 *
 * hardsect_size[MAJOR][MINOR]
 *
 * if (!hardsect_size[MAJOR])
 *		then 512 bytes is assumed.
 * else
 *		sector_size is hardsect_size[MAJOR][MINOR]
 * This is currently set by some scsi devices and read by the msdos fs
driver.
 * Other uses may appear later.
 */
int * hardsect_size[MAX_BLKDEV];


read_ahead there is a blunt - it's a "write only array anyway"....
Initialize
it to the system default and don't care.
