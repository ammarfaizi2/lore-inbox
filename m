Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263650AbVBCT0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbVBCT0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 14:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbVBCT0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 14:26:32 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:53384 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263524AbVBCTZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 14:25:05 -0500
In-Reply-To: <1107429809.9010.27.camel@imp.csi.cam.ac.uk>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, nathans@sgi.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Subject: Re: RFC: [PATCH-2.6] Add helper function to lock multiple page cache pages
 - nopage alternative
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF29E48791.2D4A4A03-ON88256F9D.0068D5C2-88256F9D.006A8ECF@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 3 Feb 2005 11:23:29 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 02/03/2005 14:24:57,
	Serialize complete at 02/03/2005 14:24:57
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > And for the vmscan->writepage() side of things I wonder if it would 
be
>> > > possible to overload the mapping's ->nopage handler.  If the target 
page
>> > > lies in a hole, go off and allocate all the necessary pagecache 
pages, zero
>> > > them, mark them dirty?
>> > 
>> > I guess it would be possible but ->nopage is used for the read case 
and
>> > why would we want to then cause writes/allocations?
>> 
>> yup, we'd need to create a new handler for writes, or pass 
`write_access'
>> into ->nopage.  I think others (dwdm2?) have seen a need for that.
>
>That would work as long as all writable mappings are actually written to
>everywhere.  Otherwise you still get that reading the whole mmap()ped
>are but writing a small part of it would still instantiate all of it on
>disk.  As far as I understand this there is no way to hook into the mmap
>system such that we have a hook whenever a mmap()ped page gets written
>to for the first time.  (I may well be wrong on that one so please
>correct me if that is the case.)

I think the point is that we can't have a "handler for writes," because 
the writes are being done by simple CPU Store instructions in a user 
program.  The handler we're talking about is just for page faults.  Other 
operating systems approach this by actually _having_ a handler for a CPU 
store instruction, in the form of a page protection fault handler -- the 
nopage routine adds the page to the user's address space, but write 
protects it.  The first time the user tries to store into it, the 
filesystem driver gets a chance to do what's necessary to support a dirty 
cache page -- allocate a block, add additional dirty pages to the cache, 
etc.  It would be wonderful to have that in Linux.  I saw hints of such 
code in a Linux kernel once (a "write_protect" address space operation or 
something like that); I don't know what happened to it.

Short of that, I don't see any way to avoid sometimes filling in holes due 
to reads.  It's not a huge problem, though -- it requires someone to do a 
shared writable mmap and then read lots of holes and not write to them, 
which is a pretty rare situation for a normal file.

I didn't follow how the helper function solves this problem.  If it's 
something involving adding the required extra pages to the cache at 
pageout time, then that's not going to work -- you can't make adding pages 
to the cache a prerequisite for cleaning a page -- that would be Deadlock 
City.

My large-block filesystem driver does the nopage thing, and does in fact 
fill in files unnecessarily in this scenario.  :-(  The driver for the 
same filesystems on AIX does not, though.  It has the write protection 
thing.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems

