Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266022AbVBDPsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbVBDPsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 10:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265821AbVBDPs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 10:48:29 -0500
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:28555 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264925AbVBDPgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 10:36:43 -0500
Subject: Re: RFC: [PATCH-2.6] Add helper function to lock multiple page
	cache pages - nopage alternative
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, nathans@sgi.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <OF29E48791.2D4A4A03-ON88256F9D.0068D5C2-88256F9D.006A8ECF@us.ibm.com>
References: <OF29E48791.2D4A4A03-ON88256F9D.0068D5C2-88256F9D.006A8ECF@us.ibm.com>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Fri, 04 Feb 2005 15:36:32 +0000
Message-Id: <1107531392.12460.14.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-03 at 11:23 -0800, Bryan Henderson wrote:
> >> > > And for the vmscan->writepage() side of things I wonder if it would 
> be
> >> > > possible to overload the mapping's ->nopage handler.  If the target 
> page
> >> > > lies in a hole, go off and allocate all the necessary pagecache 
> pages, zero
> >> > > them, mark them dirty?
> >> > 
> >> > I guess it would be possible but ->nopage is used for the read case 
> and
> >> > why would we want to then cause writes/allocations?
> >> 
> >> yup, we'd need to create a new handler for writes, or pass 
> `write_access'
> >> into ->nopage.  I think others (dwdm2?) have seen a need for that.
> >
> >That would work as long as all writable mappings are actually written to
> >everywhere.  Otherwise you still get that reading the whole mmap()ped
> >are but writing a small part of it would still instantiate all of it on
> >disk.  As far as I understand this there is no way to hook into the mmap
> >system such that we have a hook whenever a mmap()ped page gets written
> >to for the first time.  (I may well be wrong on that one so please
> >correct me if that is the case.)
> 
> I think the point is that we can't have a "handler for writes," because 
> the writes are being done by simple CPU Store instructions in a user 
> program.  The handler we're talking about is just for page faults.  Other 

That was my understanding.

> operating systems approach this by actually _having_ a handler for a CPU 
> store instruction, in the form of a page protection fault handler -- the 
> nopage routine adds the page to the user's address space, but write 
> protects it.  The first time the user tries to store into it, the 
> filesystem driver gets a chance to do what's necessary to support a dirty 
> cache page -- allocate a block, add additional dirty pages to the cache, 
> etc.  It would be wonderful to have that in Linux.

It would.  This would certainly solve this problem.

> Short of that, I don't see any way to avoid sometimes filling in holes due 
> to reads.  It's not a huge problem, though -- it requires someone to do a 
> shared writable mmap and then read lots of holes and not write to them, 
> which is a pretty rare situation for a normal file.
> 
> I didn't follow how the helper function solves this problem.  If it's 
> something involving adding the required extra pages to the cache at 
> pageout time, then that's not going to work -- you can't make adding pages 
> to the cache a prerequisite for cleaning a page -- that would be Deadlock 
> City.

Ouch.  Yes, it would rather, wouldn't it.  How very annoying of it.  I
guess the ->nomap way is the only sane way to deal with this then.  I
suppose it is also possible to do it via writepage by scanning for and
locking pages if present in writepage and if not present go direct to
disk (using bio or bh) whilst holding exclusive lock so no new pages can
be added to the page cache with stale data.  Or actually we wouldn't
even care if stale pages are added as they would still be cleared in
readpage().  And pages found and uptodate and locked simply need to be
marked dirty and released again and if not uptodate they need to be
cleared first.  This might actually turn out the easiest for ntfs at
least and it should avoid the deadlocks that would be caused by trying
to add new pages to the page cache.  Its maybe not as clean as a write
on a read-only page causing a fault handler to be triggered but it
should work I think.  Comments?

> My large-block filesystem driver does the nopage thing, and does in fact 
> fill in files unnecessarily in this scenario.  :-(  The driver for the 
> same filesystems on AIX does not, though.  It has the write protection 
> thing.

Is your driver's source available to look at?

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

