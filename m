Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262591AbTCMWxJ>; Thu, 13 Mar 2003 17:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbTCMWxJ>; Thu, 13 Mar 2003 17:53:09 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:54775 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S262591AbTCMWxH>; Thu, 13 Mar 2003 17:53:07 -0500
Date: Thu, 13 Mar 2003 16:03:34 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030313160334.G12806@schatzie.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <m3el5bmyrf.fsf@lexa.home.net> <20030313015840.1df1593c.akpm@digeo.com> <m3of4fgjob.fsf@lexa.home.net> <20030313142512.69f82864.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030313142512.69f82864.akpm@digeo.com>; from akpm@digeo.com on Thu, Mar 13, 2003 at 02:25:12PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 13, 2003  14:25 -0800, Andrew Morton wrote:
> This is great work.

Agreed.  This is something that has been talked about but not implemented
for a long time now.  Thanks for the efforts.

> a) The algorithm which you are using to distribute the root-reserved
>    blocks across the blockgroups will end up leaving a small number of unused
>    blocks in every blockgroup.  So large files which span multiple
>    blockgroups will have little gaps in them.
> 
>    I think it's probably better to just lump all the root-reserved blocks
>    into as few blockgroups as possible.

I might disagree here.  One of the reasons for having the reserved blocks
is to prevent fragmentation, and not necessarily to reserve space for root.
For the lots of small files cases it makes more sense to leave free space
in each group to prevent fragmentation at the group level.

For the large file case, there is less need to worry about fragmentation,
so we can just ignore the group's reserved percentage for "large" files.
A heuristic which says "if this file is huge, just keep allocating from this
group, and screw the reserved blocks" makes sense.

One such heuristic is if the file is, say, larger than 1/2 or 1/4 of the
entire group in size, it is allowed to continue allocating from the same
group.

We could also say that for the purpose of allocating new files in a directory,
anything more than 95% full is "full" and the inode should be allocated in
a different group regardless of where the parent is.  It may be that the
Orlov allocator already has such a heuristic, but I think that is a different
discussion.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

