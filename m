Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVBCKjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVBCKjl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVBCKjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:39:41 -0500
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:46497 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262944AbVBCKhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:37:41 -0500
Subject: Re: RFC: [PATCH-2.6] Add helper function to lock multiple page
	cache pages.
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: nathans@sgi.com, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20050202143422.41c29202.akpm@osdl.org>
References: <Pine.LNX.4.60.0502021354540.16084@hermes-1.csi.cam.ac.uk>
	 <20050202143422.41c29202.akpm@osdl.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Thu, 03 Feb 2005 10:37:37 +0000
Message-Id: <1107427057.9010.18.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 14:34 -0800, Andrew Morton wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> >
> > Below is a patch which adds a function 
> >  mm/filemap.c::find_or_create_pages(), locks a range of pages.  Please see 
> >  the function description in the patch for details.
> 
> This isn't very nice, is it, really?  Kind of a square peg in a round hole.

Only followed your advice.  (-;  But yes, it is not very nice at all.

> If you took the approach of defining a custom file_operations.write() then
> I'd imagine that the write() side of things would fall out fairly neatly:
> no need for s_umount and i_sem needs to be taken anyway.  No trylocking.

But the write() side of things don't need s_umount or trylocking with
the proposed find_or_create_pages(), either...

Unfortunately it is not possible to do this since removing
->{prepare,commit}_write() from NTFS would mean that we cannot use loop
devices on NTFS any more and this is a really important feature for
several Linux distributions (e.g. TopologiLinux) which install Linux on
a loopback mounted NTFS file which they then use to place an ext3 (or
whatever) fs on and use that as the root fs...

So we definitely need full blown prepare/commit write.  (Unless we
modify the loop device driver not to use ->{prepare,commit}_write
first.)

Any ideas how to solve that one?

> And for the vmscan->writepage() side of things I wonder if it would be
> possible to overload the mapping's ->nopage handler.  If the target page
> lies in a hole, go off and allocate all the necessary pagecache pages, zero
> them, mark them dirty?

I guess it would be possible but ->nopage is used for the read case and
why would we want to then cause writes/allocations?  Example: I create a
sparse file of 2TiB size and put some data in relevant places.  Then an
applications mmap()s it and does loads of reads on the mmap()ped file
and perhaps a write here or there.  Do we really want that to start
allocating and filling in all read holes?  That seems worse than having
a square peg for a round hole that is hidden away in a single function.

There is nothing in the proposed find_or_create_pages() that means it
needs to go into mm/filemap.c.  It could easily be a private function in
fs/ntfs/aops.c.  I just thought that other fs who want to support
writing to large block sizes might find it useful and having a shared
copy in mm/filemap.c would be better in that case.  But if it is too
ugly to go in mm/filemap.c then that is fine, too.

At the moment I cannot see a way to solve my problem without the
proposed find_or_create_pages().  )-:

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

