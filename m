Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTIHUMz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTIHUMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:12:55 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:11772 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263667AbTIHUMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:12:51 -0400
Date: Mon, 8 Sep 2003 14:11:34 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Oleg Drokin <green@namesys.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: First impressions of reiserfs4
Message-ID: <20030908141133.M18482@schatzie.adilger.int>
Mail-Followup-To: Oleg Drokin <green@namesys.com>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
	Nikita Danilov <god@namesys.com>
References: <slrnbl12sv.i4g.erik@bender.home.hensema.net> <3F50D986.6080707@namesys.com> <20030831191419.A23940@bitwizard.nl> <20030908081206.GA17718@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030908081206.GA17718@namesys.com>; from green@namesys.com on Mon, Sep 08, 2003 at 12:12:06PM +0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 08, 2003  12:12 +0400, Oleg Drokin wrote:
> Hello!
> On Sun, Aug 31, 2003 at 07:14:19PM +0200, Rogier Wolff wrote:
> 
> > Would it be possible to do something like: "pretend that there
> > are always 100 million inodes free", and then report sensible
> > numbers to "df -i"? 
> 
> This won't work. No sensible numbers would be there.
> 
> > There  is no installation program that will fail with: "Sorry, 
> > you only have 100 million inodes free, this program will need
> > 132 million after installation", and it allows me a quick way 
> > of counting the number of actual files on the disk.... 
> 
> You cannot. statfs(2) only exports "Total number of inodes on disk" and
> "number of free inodes on disk" values for fs. df substracts one from
> another one to get "number of inodes in use".
> Actually we export necessary numbers through sysfs for now. And we have
> patch in our tree that just sets statfs(2) inode stuff to zero. You should
> see it after next snapshot is released.

In a way, it would have been nice if "sys_statfs64()" had implemented the
values as "files in use" and "files total" instead of the older (and less
useful "files free").

However, that doesn't mean you can't return something useful to statfs().
Since the linux VFS limits us to 2^32 - 1 inodes for now, you could still
return 2^32 - 1 - num_in_use for "f_ffree" and 2^32 -1 for f_files, so that
"df -i" shows a useful number for IUsed.


Sadly, the sys_statfs64() API is broken such that the filesystem can't make
a distinction between being called from sys_statfs64() and sys_statfs(),
so you have to assume the 32-bit limits even for the 64-bit API.  We should
really have a new FS method which is "statfs64()" that is optionally called
from sys_statfs64() so the FS has a chance to return something different for
64-bit callers.

For Lustre, we can't be guaranteed to fit into the 32-bit f_blocks counts
with 100TB filesystems, so we scale the f_bsize until the f_blocks fits into
32 bits.  However, we would like to be able to return the correct values to
sys_statfs64() if possible.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

