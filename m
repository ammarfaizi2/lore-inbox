Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVBCL3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVBCL3A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbVBCLYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:24:50 -0500
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:10887 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262295AbVBCLXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:23:50 -0500
Subject: Re: RFC: [PATCH-2.6] Add helper function to lock multiple page
	cache pages.
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: nathans@sgi.com, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20050203024755.1792b6c0.akpm@osdl.org>
References: <Pine.LNX.4.60.0502021354540.16084@hermes-1.csi.cam.ac.uk>
	 <20050202143422.41c29202.akpm@osdl.org>
	 <1107427057.9010.18.camel@imp.csi.cam.ac.uk>
	 <20050203024755.1792b6c0.akpm@osdl.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Thu, 03 Feb 2005 11:23:29 +0000
Message-Id: <1107429809.9010.27.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-03 at 02:47 -0800, Andrew Morton wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > On Wed, 2005-02-02 at 14:34 -0800, Andrew Morton wrote:
> > > Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > > >
> > > > Below is a patch which adds a function 
> > > >  mm/filemap.c::find_or_create_pages(), locks a range of pages.  Please see 
> > > >  the function description in the patch for details.
> > > 
> > > This isn't very nice, is it, really?  Kind of a square peg in a round hole.
> > 
> > Only followed your advice.  (-;  But yes, it is not very nice at all.
> > 
> > > If you took the approach of defining a custom file_operations.write() then
> > > I'd imagine that the write() side of things would fall out fairly neatly:
> > > no need for s_umount and i_sem needs to be taken anyway.  No trylocking.
> > 
> > But the write() side of things don't need s_umount or trylocking with
> > the proposed find_or_create_pages(), either...
> 
> i_sem nests outside lock_page, normally.  I guess that can be avoided though.

I meant that the write() side of things (i.e. ->{prepare,commit}_write)
already has i_sem held on entry.

> > Unfortunately it is not possible to do this since removing
> > ->{prepare,commit}_write() from NTFS would mean that we cannot use loop
> > devices on NTFS any more and this is a really important feature for
> > several Linux distributions (e.g. TopologiLinux) which install Linux on
> > a loopback mounted NTFS file which they then use to place an ext3 (or
> > whatever) fs on and use that as the root fs...
> > 
> > So we definitely need full blown prepare/commit write.  (Unless we
> > modify the loop device driver not to use ->{prepare,commit}_write
> > first.)
> > 
> > Any ideas how to solve that one?
> 
> I did a patch which switched loop to use the file_operations.read/write
> about a year ago.  Forget what happened to it.  It always seemed the right
> thing to do..

Yes, I remember seeing something like that on LKML.  I guess it would
enable readahead on the loop devices.  Whether this is a good or bad
thing is I guess entirely dependent on the usage scenario.

> > > And for the vmscan->writepage() side of things I wonder if it would be
> > > possible to overload the mapping's ->nopage handler.  If the target page
> > > lies in a hole, go off and allocate all the necessary pagecache pages, zero
> > > them, mark them dirty?
> > 
> > I guess it would be possible but ->nopage is used for the read case and
> > why would we want to then cause writes/allocations?
> 
> yup, we'd need to create a new handler for writes, or pass `write_access'
> into ->nopage.  I think others (dwdm2?) have seen a need for that.

That would work as long as all writable mappings are actually written to
everywhere.  Otherwise you still get that reading the whole mmap()ped
are but writing a small part of it would still instantiate all of it on
disk.  As far as I understand this there is no way to hook into the mmap
system such that we have a hook whenever a mmap()ped page gets written
to for the first time.  (I may well be wrong on that one so please
correct me if that is the case.)

> > At the moment I cannot see a way to solve my problem without the
> > proposed find_or_create_pages().  )-:
> 
> Unpleasant, isn't it.
> 
> I guess the path of least resistance is to do it within ntfs for now.

Ok, I will do that.  ntfs_find_or_create_pages() will be hitting
fs/ntfs/aops.c soon...

As always, thanks a lot for your help!

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

