Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTKKGDB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 01:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTKKGDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 01:03:01 -0500
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:44015 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264267AbTKKGC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 01:02:59 -0500
Date: Mon, 10 Nov 2003 23:00:55 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Valdis.Kletnieks@vt.edu
Cc: Daniel Gryniewicz <dang@fprintf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031110230055.S10197@schatzie.adilger.int>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Daniel Gryniewicz <dang@fprintf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1068512710.722.161.camel@cube> <20031110205011.R10197@schatzie.adilger.int> <1068523406.4156.7.camel@localhost> <200311110414.hAB4EZA8007309@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200311110414.hAB4EZA8007309@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Mon, Nov 10, 2003 at 11:14:35PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10, 2003  23:14 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 10 Nov 2003 23:03:26 EST, Daniel Gryniewicz said:
> > Plus a sys_copy() syscall could be used as a generic way for filesystems
> > to set up Copy-on-Write.  Right now, you'd need to have userspace call
> > sys-reiser4 or something like that.
> 
> This is fast turning into a creeping horror of aggregation.  I defy anybody
> to create an API to cover all the options mentioned so far and *not* have it
> look like the process_clone horror we so roundly derided a few weeks ago.

	int sys_copy(int fd_src, int fd_dst)

It is up to the filesystem to decide if both files are on the same device
and can be copied with a copy RPC (or whatever).  If the filesystem returns
-EOPNOTSUPP then the VFS goes into a simple readpages/writepages loop to do
the copy instead, maybe also copying ACLs or other things the VFS understands.

All of the "extra functionality" is being handled in the filesystem itself
and not the VFS or the API.  Copy-on-write is an fs-internal issue depending
on whether fs supports it, how it was mounted, etc.  Remote copy is also an
fs-internal issue depending on whether inodes are in same filesystem, support,
etc.  You might get into fun things like doing zero-copy.

Telling the filesystem we are doing a copy vs. a bunch of reads mixed
with a bunch of writes is just semantically something that the filesystem
should know about.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

