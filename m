Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWG0IUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWG0IUQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWG0IUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:20:15 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:12955 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750864AbWG0IUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:20:14 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [BUG?] possible recursive locking detected
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, eike-kernel@sf-tec.de,
       linux-kernel@vger.kernel.org, aia21@cantab.net
In-Reply-To: <20060727003806.def43f26.akpm@osdl.org>
References: <200607261805.26711.eike-kernel@sf-tec.de>
	 <20060726225311.f51cee6d.akpm@osdl.org> <44C86271.9030603@yahoo.com.au>
	 <1153984527.21849.2.camel@imp.csi.cam.ac.uk>
	 <20060727003806.def43f26.akpm@osdl.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Thu, 27 Jul 2006 09:19:58 +0100
Message-Id: <1153988398.21849.16.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 00:38 -0700, Andrew Morton wrote:
> On Thu, 27 Jul 2006 08:15:27 +0100
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> 
> > > I'm surprised ext2 is allocating with __GFP_FS set, though. Would that
> > > cause any problem?
> > 
> > That is an ext2 bug IMO.
> 
> There is no bug.
> 
> What there is is an ill-defined set of rules.  If we want to tighten these
> rules we have a choice between

I beg to differ.  It is a bug.  You cannot reenter the file system when
the file system is trying to allocate memory.  Otherwise you can never
allocate memory with any locks held or you are bound to introduce an
A->B B->A deadlock somewhere.

> a) Never enter page reclaim while holding i_mutex or
> 
> b) never take i_mutex on the page reclaim path.
> 
> 
> Implementing a) would be a disaster.  It means that our main write()
> implementation in mm/filemap.c (which holds i_mutex) wouldn't be able to
> reclaim pages to satisfy the write.  And generally, we do want to use the
> strongest memory allocation mode at all times.
> 
> So we'll have a better kernel if we implement b).

b) is impossible for ntfs.  The only potential partial solution would be
to make ntfs use trylock everywhere and if that fails abort whatever the
VFS is trying to do with an EAGAIN and it is up to the VFS to deal with
it.  That would require quite a big rewrite of the VFS given a lot of FS
methods invoked by the VFS do not have a return value at the moment...
For example put_inode and clear_inode would need to accept EAGAIN and
would have to undo what was done before them so they could be retried
later.  To steal your own words, "we would have a better kernel" if the
VFS did error handling and recovery properly...  (-;

Several random examples:

- NTFS holds metadata in page cache pages so if you want to reclaim a
page ntfs has to flush the metadata to disk.  It cannot do that without
holding locks.

- When an inode has to be flushed out due to clear_inode ntfs has to
take i_mutex in order to write the inode to disk properly (which
involves locking all parent directories of the inode in turn and
updating the directory entry for that inode - this has to be done
because the directory entry in ntfs contains not only the filename but
also the stat information such as file size, allocation size on disk,
a/m/c/C time etc and chkdsk in Windows complains if those are not
uptodate.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://www.linux-ntfs.org/ & http://www-stu.christs.cam.ac.uk/~aia21/

