Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTDYERQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 00:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTDYERQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 00:17:16 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:50415 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262931AbTDYERP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 00:17:15 -0400
Date: Thu, 24 Apr 2003 22:27:37 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424222737.X26054@schatzie.adilger.int>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
References: <1051182797.2250.10.camel@laptop-linux> <Pine.GSO.4.21.0304241335210.19942-100000@vervain.sonytel.be> <b8a2le$p88$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b8a2le$p88$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Apr 24, 2003 at 06:22:54PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 24, 2003  18:22 -0700, H. Peter Anvin wrote:
> By author:    Geert Uytterhoeven <geert@linux-m68k.org>
> > This has nothing to do with using a swapfile.
> > 
> > But if you resume from swsusp, you don't really `mount' all file systems.
> > They are implicitly mounted because they were mounted before the suspend
> > operation.
> 
> Shouldn't we be syncing them all before the suspend anyway, to
> minimize corruption in case the user chooses to mount the filesystem
> *without* resuming (think a dual-boot configuration.)  This would be
> another application for the "supersync" operation that was discussed
> at OLS 2002 -- a need for an operation which not only flushes all
> blocks to disk but also forces the journal to be replayed and
> truncated.

This "supersync" already exists, and it is supported by all of the
journaling filesystems for LVM snapshots.  This is the VFS method
write_super_lockfs in the ext3/reiserfs/XFS/JFS super_operations.
Not only does it sync the dirty data to disk, but it also forces
the journal to be empty and marks the filesystem clean, so that it
can be snapshotted and read-only mounted (basically equivalent to
unmounting the filesystem).

Unfortunately, even though the filesystems themselves have supported
this VFS method for a long time, the actual code that calls these
methods (sync_super_lockfs() and unlockfs()) are still only available
as a patch from LVM.  The LVM/reiserfs folks have talked about submitting
it to Marcelo for a long time now, but apparently still haven't done so.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

