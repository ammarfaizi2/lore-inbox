Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbTIHWYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbTIHWYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:24:47 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:58130
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263685AbTIHWYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:24:44 -0400
Date: Mon, 8 Sep 2003 15:24:57 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Oleg Drokin <green@namesys.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: First impressions of reiserfs4
Message-ID: <20030908222457.GB17441@matchmail.com>
Mail-Followup-To: Oleg Drokin <green@namesys.com>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
	Nikita Danilov <god@namesys.com>
References: <slrnbl12sv.i4g.erik@bender.home.hensema.net> <3F50D986.6080707@namesys.com> <20030831191419.A23940@bitwizard.nl> <20030908081206.GA17718@namesys.com> <20030908105639.B26722@bitwizard.nl> <20030908090826.GB10487@namesys.com> <20030908113304.A28123@bitwizard.nl> <20030908094825.GD10487@namesys.com> <20030908120531.A28937@bitwizard.nl> <20030908101704.GE10487@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908101704.GE10487@namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 02:17:04PM +0400, Oleg Drokin wrote:
> You only can have as many inodes as number of blocks on the fs (at least that's the limit imposed on you
> by mke2fs).

True, but not exactly.  Each file will need one block to store even one byte
on ext2/3.  But your inode tables have about 1/4-1/2 the number of inode entries to
blocks.  This can be changed at mkfs time though.

# mke2fs -n -b 1024 -m0 /dev/md0
mke2fs 1.34-WIP (21-May-2003)
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
39923712 inodes, 319388032 blocks
0 blocks (0.00%) reserved for the super user
First data block=1
38988 block groups
8192 blocks per group, 8192 fragments per group
1024 inodes per group

40M inodes and 319M blocks with a 1k block ext2/3 filesystem.

# mke2fs -n -b 4096 -m0 /dev/md0
mke2fs 1.34-WIP (21-May-2003)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
39927808 inodes, 79847008 blocks
0 blocks (0.00%) reserved for the super user
First data block=0
2437 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group

40M inodes and 80M blocks on a 4k block ext2/3 filesystem.

So with the defaults, you'd have to have 40M files each between 4.1 - 7.9Kb
to run out of inodes, and fill the filesystem.

k# mke2fs -n -b 1024 -m0 -T news /dev/md0
mke2fs 1.34-WIP (21-May-2003)
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
79847424 inodes, 319388032 blocks
0 blocks (0.00%) reserved for the super user
First data block=1
38988 block groups
8192 blocks per group, 8192 fragments per group
2048 inodes per group

80M inodes and 319M blocks on a 1k block ext2/3 filesystem.

Now one question I have...

Is that 32k blocks per group + 32k fragments per group = 64k blocks per
group (since fragments aren't[1] implemented)?

[1] For those interested, the space allocated for fragments was a perfect
fit for tail merging support.  There is a patch in alpha stages floating
around for that...

Hmm, take ext3 with htree, reiser3 & reiser4 (choose the block size 1k, 2k or 4k) with
tail merging off, 1k files per directory and all files the same size as
block size with 40M files.  How would the table look as far as space effency
look comparing them?  For that matter, how do JFS & XFS compare?

Mike
