Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbSJ0Vpw>; Sun, 27 Oct 2002 16:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSJ0Vpw>; Sun, 27 Oct 2002 16:45:52 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:46844 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262653AbSJ0Vpv>; Sun, 27 Oct 2002 16:45:51 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sun, 27 Oct 2002 14:49:13 -0700
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
Message-ID: <20021027214913.GA17533@clusterfs.com>
Mail-Followup-To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <20021027121318.GA2249@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021027121318.GA2249@averell>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 27, 2002  13:13 +0100, Andi Kleen wrote:
> Move time_t members in struct stat to struct timespec and allow subsecond
> timestamps for files.  Too big to post on the list, because it edits
> a lot of file systems and drivers in a straight forward way.
> 
> This is required for reliable "make" on fast computers.
> 
> File systems that support nsec storage are currently: XFS, JFS, NFSv3
> (if the filesystem on the server supports it), VFAT (not quite nanosecond),
> CIFS (unit in 100ns which is above what linux supports), SMBFS (for 
> newer servers)

Two notes I might make about this:
1) It would be good if it were possible to select this with a config
   option (I don't care which way the default goes), so that people who
   don't need/care about the increased resolution don't need the extra
   space in their inodes and minor extra overhead.  To make this a lot
   easier to code, having something akin to the inode_update_time()
   which does all of the i_[acm]time updates as appropriate.
2) Updating i_atime based on comparing the nsec timestamp is going to be
   a killer.  I think AKPM saw dramatic performance improvements when he
   changed the code to only do the update once/second, and even though
   you are "only" updating the atime if the times are different, in
   practise this will be always.  Even without the "per superblock interval"
   you suggest we should probably only update the atime once a second (I
   don't think anything is keyed off such high resolution atimes, unlike
   make and mtime/ctime).
3) The fields you are usurping in struct stat are actually there for the
   Y2038 problem (when time_t wraps).  At least that's what Ted said when
   we were looking into nsec times for ext2/3.  Granted, we may all be
   using 64-bit systems by 2038...  I've always thought 64 bits is much
   to large for time_t, so we could always use 20 or 30 bits for sub-second
   times, and the remaining bits for extending time_t at the high end,
   and mask those off for now, but that is a separate issue...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

