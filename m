Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285338AbRLNLyN>; Fri, 14 Dec 2001 06:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285340AbRLNLxx>; Fri, 14 Dec 2001 06:53:53 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:30218 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S285338AbRLNLxq>; Fri, 14 Dec 2001 06:53:46 -0500
Date: Fri, 14 Dec 2001 05:53:28 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.17-rc1 still has I/O freezing bug
Message-ID: <20011214055328.A26814@asooo.flowerfire.com>
In-Reply-To: <Pine.LNX.4.21.0112131841080.28446-100000@freak.distro.conectiva> <20011214061842.948118A6BA@cx518206-b.irvn1.occa.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011214061842.948118A6BA@cx518206-b.irvn1.occa.home.com>; from barryn@pobox.com on Thu, Dec 13, 2001 at 10:18:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This reproduces for me as well under -rc1 (SMP, ext3, aic7xxx,
1xCeleron).  In my case, dd gets to about 912 MB before stopping, and
during the write up to that point the machines' interactive response
stalls occasionally for a few seconds.  Sync etc stuck in device-wait.

Hopefully whoever wrote the patch can comment.

-- 
Ken.
brownfld@irridia.com

On Thu, Dec 13, 2001 at 10:18:42PM -0800, Barry K. Nathan wrote:
| 2.4.17-rc1 still has the bug that I reported for -pre8, where dd from
| /dev/zero to a file on a loopback-mounted filesystem still freezes after
| a few seconds. (I confirmed this by testing it on my systems here.)
| 
| Instructions to reproduce on a regular system (as opposed to the weird
| setup on my notebook, which I detailed in a previous post to the
| linux-kernel mailing list, that made me notice this problem in real-world
| use):
| 
| 1. dd if=/dev/zero bs=1024k count=1024 of=/tmp/loopf (put the file on
| any non-loopback filesystem -- this works with both IDE and SCSI)
| 
| 2. mke2fs /tmp/loopf
| 
| 3. mount -o loop /tmp/loopf /mnt/disk (or just /mnt, or wherever)
| 
| 4. log into another virtual console or whatever, so you can do
| 'ls -l /mnt/disk' or the equivalent (this is especially important if
| your disk doesn't have a visible activity light)
| 
| 5. dd if=/dev/zero bs=1024k of=/mnt/disk/zero [normally this should fill
| the disk up then exit with an error]
| 
| 6. Watch the activity light, or wait 10 seconds and issue ls commands in
| the other terminal. The activity light will turn off in a few seconds,
| and the /mnt/disk/zero file will stop growing after a few hundred
| megabytes or so, well ahead of the disk actually running out of space.
| Killing the dd command with ^C at the console is impossible, and a kill -9
| also fails. ps shows the dd command and the [loop0] kernel thread both
| stuck in D state, despite the lack of physical disk activity.
| 
| This is 100% reproducible for me, on both of the systems that I have
| tried it on. With -rc1, as with -pre8, *reverting* the following patch
| fixes the problem:
| 
| diff -urN linux-2.4.17-pre1/fs/buffer.c linux/fs/buffer.c
| --- linux-2.4.17-pre1/fs/buffer.c	Wed Nov 21 14:40:17 2001
| +++ linux/fs/buffer.c	Sat Dec  1 00:35:16 2001
| @@ -1036,6 +1036,7 @@
|  	unsigned long dirty, tot, hard_dirty_limit, soft_dirty_limit;
|  
|  	dirty = size_buffers_type[BUF_DIRTY] >> PAGE_SHIFT;
| +	dirty += size_buffers_type[BUF_LOCKED] >> PAGE_SHIFT;
|  	tot = nr_free_buffer_pages();
|  
|  	dirty *= 100;
| 
| -Barry K. Nathan <barryn@pobox.com>
