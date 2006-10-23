Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWJWNOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWJWNOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 09:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWJWNOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 09:14:30 -0400
Received: from swan.nt.tuwien.ac.at ([128.131.67.158]:47520 "EHLO
	swan.nt.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S964806AbWJWNO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 09:14:29 -0400
Date: Mon, 23 Oct 2006 15:14:25 +0200
From: Thomas Zeitlhofer <tzeitlho+lkml@nt.tuwien.ac.at>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mkdir on read-only NFS is broken in 2.6.18
Message-ID: <20061023131425.GA6127@swan.nt.tuwien.ac.at>
References: <20061023092329.GA5231@swan.nt.tuwien.ac.at> <1161599622.5755.16.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161599622.5755.16.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 06:33:42AM -0400, Trond Myklebust wrote:
> On Mon, 2006-10-23 at 11:23 +0200, Thomas Zeitlhofer wrote:
> > Hello,
> > 
> > there is a problem in 2.6.18/.1 when mkdir is called for an existing
> > directory on a read-only mounted NFS filesystem.
> > 
> > Lets consider a server that exports the directory /export which contains
> > the directory-tree a/b/c:
> > 
> > 1) If /export is mounted ro and the first access to a, b, or c  is
> > mkdir, then this directory and all directories underneath become
> > inaccessible:
> > 
> >   client:# mount server:/export /mnt -o ro
> >   client:# mkdir /mnt/a/b
> >   mkdir: cannot create directory `/mnt/a/b': Read-only file system
> >   client:# find /mnt
> >   /mnt
> >   /mnt/a
> >   find: /mnt/a/b: No such file or directory
[...]
> > As a consequence of 1), autofs does not work with mountpoints on NFS
> > (ro) because the automount daemon calls mkdir for all directories in the
> > path to the mountpoint. This seems related to the discussion [1], and,
> > as suggested in [1], the issue is fixed by reverting the patch:
> 
> There should already be a fix for this issue in 2.6.19-rc1. See
> 
>   http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fd6840714d9cf6e93f1d42b904860a94df316b85

Yes, this patch fixes the issue for 2.6.18 too. 

Just a note, there still seems to be some inconsistency regarding the
errno returned by mkdir:

   client:# mount server:/export /mnt -o ro                         
   client:# mkdir /mnt/a/b
   mkdir: cannot create directory `/mnt/a/b': Read-only file system
   client:# find /mnt
   /mnt
   /mnt/a
   /mnt/a/b
   /mnt/a/b/c
   client:# mkdir /mnt/a/b
   mkdir: cannot create directory `/mnt/a/b': File exists

Depending on the context, mkdir returns EROFS or EEXIST - shouldn't we
get always the same errno?  Using the patch from my previous mail (or a
2.6.17 kernel), mkdir will always return EEXIST in this case. 

Thanks,
 Thomas
