Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbTAYXDV>; Sat, 25 Jan 2003 18:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbTAYXDV>; Sat, 25 Jan 2003 18:03:21 -0500
Received: from packet.digeo.com ([12.110.80.53]:62205 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264001AbTAYXDT>;
	Sat, 25 Jan 2003 18:03:19 -0500
Date: Sat, 25 Jan 2003 15:13:01 -0800
From: Andrew Morton <akpm@digeo.com>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, jack@suse.cz, mason@suse.com
Subject: Re: ext2 FS corruption with 2.5.59.
Message-Id: <20030125151301.18b70ef3.akpm@digeo.com>
In-Reply-To: <20030125153607.A10590@namesys.com>
References: <20030123153832.A860@namesys.com>
	<20030124023213.63d93156.akpm@digeo.com>
	<20030124153929.A894@namesys.com>
	<20030124225320.5d387993.akpm@digeo.com>
	<20030125153607.A10590@namesys.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jan 2003 23:12:25.0372 (UTC) FILETIME=[390155C0:01C2C4C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> wrote:
>
> Here is my version:
> 
> #!/bin/bash
> mke2fs /dev/hdb2
> mount /dev/hdb2 /mnt -t ext2
> cd /mnt
> /tests/fsstress -p10 -n 1000000 -d . &
> while /tests/fsx -c 1234 -N60309 testfile ; do rm -rf testfile*; done
> 
> > So I'm going to have to ask you to investigate further.  Does it happen on
> > other machines?  Other filesystems?  Older kernels?  That sort of thing.
> 
> Ok. I am able to reproduce that same thing on dual Pentium4 2.2GHz (HT enabled), 512M RAM.
> My testing reveals that 2.5.50, 2.5.52 and 2.5.53 do not have the problem.
> 2.5.54, 2.5.55, 2.5.59 have the problem.
> ext3 and reiserfs do not show this problem.
> Looking through 2.5.54, I found that changeset named "[PATCH] quota locking update" forwarded by you
> is the cause for the problem.
> (also by reviewing the changeset it became clear that in order to succesfully reproduce the
> problem one must have CONFIG_QUOTA to be disabled).
> This small patch below fixes the problem for me (just reverts back part of quota locking patch in fact).
> Also I think that taking BKL just to update some inode accounting stuff is kind of expensive,
> so certainly better solution must exist.

aaargggggghhh.  I noticed that when I was reviewing the patch, but promptly
forgot to check it more closely.

However, in reviewing it, I don't see exactly what's going on.  Because only
one process is accessing the stat information of the fsx inode anyway?

Yes, we need to rub out that i_bytes/i_blocks thing, replace it with an
atomically updated loff_t, etc.  But I'd like to understand what the exact
failure is first.  It _seems_ that stat has somehow seen a >4G value of
stat->size, but how can this happen???

I need to breathe life back into my P4 box, see if I can get it to happen
there.

Thanks.
