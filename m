Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267583AbUBSXsk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 18:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267589AbUBSXsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 18:48:40 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:26614 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S267583AbUBSXsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 18:48:15 -0500
Date: Thu, 19 Feb 2004 08:42:13 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040219164213.GK1269@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040216190927.GA2969@us.ibm.com> <200402191531.56618.phillips@arcor.de> <1077228402.2070.893.camel@sisko.scot.redhat.com> <200402191731.33473.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402191731.33473.phillips@arcor.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 05:31:33PM -0500, Daniel Phillips wrote:
> Hi Stephen,
> 
> On Thursday 19 February 2004 17:06, Stephen C. Tweedie wrote:
> > Hi,
> >
> > On Thu, 2004-02-19 at 20:56, Daniel Phillips wrote:
> > > OpenGFS and Sistina GFS use zap_page_range directly, essentially doing
> > > the same as invalidate_mmap_range but skipping any vmas belonging to
> > > MAP_PRIVATE mmaps.
> >
> > Well, MAP_PRIVATE maps can contain shared pages too --- any page in a
> > MAP_PRIVATE map that has been mapped but not yet written to is still
> > shared, and still needs shot down on truncate().
> 
> Exactly, and we ought to take this opportunity to do that properly, which is 
> easy.  I'm just curious how GPFS deals with this issue, or if it simply 
> doesn't support MAP_PRIVATE.

GPFS supports MAP_PRIVATE, but does not specify the behavior if you
change the underlying file.  There are a number of things one can do,
but one must keep in mind that different processes can MAP_PRIVATE the
same file at different times, and that some processes might MAP_SHARED it
at the same time that others MAP_PRIVATE it.  Here are the alternatives
I can imagine:

1.	Any time a file changes, create a copy of the old version
	for any MAP_PRIVATE vmas.  This would essentially create
	a point-in-time copy of any file that a process mapped
	MAP_PRIVATE.  This is arguably the most intuitive from the
	user's standpoint, but (a) it would not be a small change and
	(b) I haven't heard of anyone coming up with a good use for it.
	Please enlighten me if I am missing a simple implementation or
	compelling uses.

2.	Modify invalidate_mmap_range() to leave MAP_PRIVATE vmas.
	as suggested by Daniel.  This would mean that a
	process that had mapped a file MAP_PRIVATE and faulted
	in parts of it would see different versions of the file
	in different pages.  This should be straightforward to
	implement, but in what situation is this skewed view of
	the file useful?

3.	Modify invalidate_mmap_range() to leave MAP_PRIVATE vmas,
	but invalidate those pages in the vma that have not yet been
	modified (that are not anonymous) as suggested by Stephen.
	This would mean that a process that had mapped a file MAP_PRIVATE
	and written on parts of it would see different versions of the
	file in different pages.  Again, in what situation is this skewed
	view of the file useful?

5.	The current behavior, where the process's writes do not
	flow through to the file, but all changes to the file are
	visible to the writing process.

6.	Requiring that MAP_PRIVATE be applied only to unchanging
	files, so that (for example) any change to the underlying
	file removes that file from any MAP_PRIVATE address spaces.
	Subsequent accesses would get a SEGV, rather than a
	surprise from silently changing data.

So, please help me out here...  What do applications that MAP_PRIVATE
changing files really expect to happen?

						Thanx, Paul
