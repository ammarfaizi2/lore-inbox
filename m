Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbTIKRRy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTIKRRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:17:53 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:15114
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261429AbTIKRPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:15:13 -0400
Date: Thu, 11 Sep 2003 10:15:13 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Oleg Drokin <green@namesys.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Reiser3/4 & Ext2/3 was: First impressions of reiserfs4
Message-ID: <20030911171513.GA18399@matchmail.com>
Mail-Followup-To: Oleg Drokin <green@namesys.com>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
	Nikita Danilov <god@namesys.com>
References: <20030908105639.B26722@bitwizard.nl> <20030908090826.GB10487@namesys.com> <20030908113304.A28123@bitwizard.nl> <20030908094825.GD10487@namesys.com> <20030908120531.A28937@bitwizard.nl> <20030908101704.GE10487@namesys.com> <20030908222457.GB17441@matchmail.com> <20030909070421.GJ10487@namesys.com> <20030909191044.GB28279@matchmail.com> <20030911102938.GE29357@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911102938.GE29357@namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 02:29:38PM +0400, Oleg Drokin wrote:
> Hello!
> 
> On Tue, Sep 09, 2003 at 12:10:44PM -0700, Mike Fedyk wrote:
> 
> > > But my experiments quickly shown that if you ask mkfs to create inode tables with
> > > free inodes that exceed blocks count for the device, then mkfs will only create as much free inodes
> > > as there are free blocks on the device (I was needing that when I experimented with 60 millions files
> > > on ext2/reiserfs/xfs and stuff and I only had 20G partition.)
> > Hmm, didn't know this, but it makes sence for ext2/3 since they use 1 block
> > per file/directory.  It wouldn't do much good to waste more space for inode
> > tables than you could even theoretically use.
> 
> Well, in fact empty files do not need this block.
> 

True.  Do you know if ext2/3 allocates the block even for empty files?  So
if you create the file, it should be sparse until you write something to it,
right?  Does the touch command do this?

> > > > tail merging off, 1k files per directory and all files the same size as
> > > > block size with 40M files.  How would the table look as far as space effency
> > > Hm. I will probably try this once.
> > > For reiserfs:
> > > I can tell you that 60M+ empty files (cannot remember exact number, but I still have the script to create those)
> > > took ~5.5G of space. 
> > With how many directories?  Do you run into drive speed limitations with
> 
> Ok. I looked at the script. There should be 182900000 files created. (182.9M)
> 100 files per dir.
> the dir structure was like this (in number of dirs per level):
> 31/59/25/40
> Files were only created at the end of hierarchy.
> See the script at the end if you are interested or want to try it yourself.
> (script was donated to us by somebody, only it was shell script,
> also I changed variable-names to hide identity).
> 

Hmm, any experiments with more files per dir (maybe 500 or 1000)?  I'm not
sure if you're going to use a directory full block with 100 files per dir in
ext2/3.

> > inodes?  In ext2/3 they're currently 128 bytes I believe plus some static
> > bitmaps in the block groups.  The only thing variable in ext2/3 are the
> > directory sizes (and they don't shrink... :( )
> 
> Well in reiserfs we have statdata (each object should have one), this is sort of
> like ext2 inode, only not static. It's size is 44 bytes (plus 24 bytes item
> header overhead). Each metadata block has header of 24 bytes.
> If you write to file (not looking at tail case yet), you create "indirect"
> items in which block pointers are stored.
> (4 bytes per pointer, when you use all space in metadata block, next block is
> allocated (24 bytes of overhead + pointer in higher level block) plus
> new indirect item (24 bytes of overhead again))

Are these indirects stored in the tree, or do you have many partially filled
indirect blocks?

> Also bitmaps are static (1 block per 128M of space in case of 4k blocksize)
> as are superblock, journal and journal header.
> 

How many superblocks are there in reiser3?  Also, the bitmap locations are
static, and allocated at mkfs time?  How is that done so fast for large
filesystems?

