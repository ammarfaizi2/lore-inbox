Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbVBCKxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbVBCKxs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVBCKt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:49:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:12979 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262946AbVBCKsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:48:14 -0500
Date: Thu, 3 Feb 2005 02:47:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: nathans@sgi.com, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: RFC: [PATCH-2.6] Add helper function to lock multiple page
 cache pages.
Message-Id: <20050203024755.1792b6c0.akpm@osdl.org>
In-Reply-To: <1107427057.9010.18.camel@imp.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0502021354540.16084@hermes-1.csi.cam.ac.uk>
	<20050202143422.41c29202.akpm@osdl.org>
	<1107427057.9010.18.camel@imp.csi.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> On Wed, 2005-02-02 at 14:34 -0800, Andrew Morton wrote:
> > Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > >
> > > Below is a patch which adds a function 
> > >  mm/filemap.c::find_or_create_pages(), locks a range of pages.  Please see 
> > >  the function description in the patch for details.
> > 
> > This isn't very nice, is it, really?  Kind of a square peg in a round hole.
> 
> Only followed your advice.  (-;  But yes, it is not very nice at all.
> 
> > If you took the approach of defining a custom file_operations.write() then
> > I'd imagine that the write() side of things would fall out fairly neatly:
> > no need for s_umount and i_sem needs to be taken anyway.  No trylocking.
> 
> But the write() side of things don't need s_umount or trylocking with
> the proposed find_or_create_pages(), either...

i_sem nests outside lock_page, normally.  I guess that can be avoided though.

> Unfortunately it is not possible to do this since removing
> ->{prepare,commit}_write() from NTFS would mean that we cannot use loop
> devices on NTFS any more and this is a really important feature for
> several Linux distributions (e.g. TopologiLinux) which install Linux on
> a loopback mounted NTFS file which they then use to place an ext3 (or
> whatever) fs on and use that as the root fs...
> 
> So we definitely need full blown prepare/commit write.  (Unless we
> modify the loop device driver not to use ->{prepare,commit}_write
> first.)
> 
> Any ideas how to solve that one?

I did a patch which switched loop to use the file_operations.read/write
about a year ago.  Forget what happened to it.  It always seemed the right
thing to do..

> > And for the vmscan->writepage() side of things I wonder if it would be
> > possible to overload the mapping's ->nopage handler.  If the target page
> > lies in a hole, go off and allocate all the necessary pagecache pages, zero
> > them, mark them dirty?
> 
> I guess it would be possible but ->nopage is used for the read case and
> why would we want to then cause writes/allocations?

yup, we'd need to create a new handler for writes, or pass `write_access'
into ->nopage.  I think others (dwdm2?) have seen a need for that.

> At the moment I cannot see a way to solve my problem without the
> proposed find_or_create_pages().  )-:

Unpleasant, isn't it.

I guess the path of least resistance is to do it within ntfs for now.
