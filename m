Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267710AbUBTCxz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 21:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUBTCxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 21:53:54 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:48215 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S267710AbUBTCxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 21:53:51 -0500
Date: Thu, 19 Feb 2004 11:47:51 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040219194751.GN1269@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040216190927.GA2969@us.ibm.com> <200402191731.33473.phillips@arcor.de> <20040219164213.GK1269@us.ibm.com> <200402192106.02086.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402192106.02086.phillips@arcor.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 09:06:55PM -0500, Daniel Phillips wrote:
> On Thursday 19 February 2004 11:42, Paul E. McKenney wrote:
> > GPFS supports MAP_PRIVATE, but does not specify the behavior if you
> > change the underlying file.  There are a number of things one can do,
> > but one must keep in mind that different processes can MAP_PRIVATE the
> > same file at different times, and that some processes might MAP_SHARED it
> > at the same time that others MAP_PRIVATE it.  Here are the alternatives
> > I can imagine:
> >
> > 1.	Any time a file changes, create a copy of the old version
> > 	for any MAP_PRIVATE vmas.  This would essentially create
> > 	a point-in-time copy of any file that a process mapped
> > 	MAP_PRIVATE.  This is arguably the most intuitive from the
> > 	user's standpoint, but (a) it would not be a small change and
> > 	(b) I haven't heard of anyone coming up with a good use for it.
> > 	Please enlighten me if I am missing a simple implementation or
> > 	compelling uses.
> 
> This is MAP_COPY I think.  Even if somebody did manage to sneak it by Linus 
> one day it would certainly not be under the guise of MAP_PRIVATE.

Whew!  That is a relief!!!  ;-)

> > 2.	Modify invalidate_mmap_range() to leave MAP_PRIVATE vmas.
> > 	as suggested by Daniel.
> 
> I did not suggest that, rather I described the existing practice in OpenGFS 
> and Sistina GFS, which at least does not destroy anonymous data.  The correct 
> behaviour is the one you describe in option 3, and we are perfectly willing 
> to change GFS to obtain that behaviour.  To be precise: I suggest we change 
> invalidate_mmap_range to skip anon pages, and change vmtruncate to use 
> something else, having the current semantics.
> 
> As a historical note: the behavior GFS obtains from option 2 is 
> Posix-compliant, but falls short of Linus-compliance, who insists on 
> completely accurate invalidation behavior as is right and proper.

OK, this is the OpenGFS zap_inode_mapping(), right?

> > 	This would mean that a
> > 	process that had mapped a file MAP_PRIVATE and faulted
> > 	in parts of it would see different versions of the file
> > 	in different pages.  This should be straightforward to
> > 	implement, but in what situation is this skewed view of
> > 	the file useful?
> 
> You've got me there ;)  However, Posix explicitly blesses this sloppy 
> behaviour.  I suppose that with additional user space locking, applications 
> could make it work reliably.  But it's still sloppy, and worse, it's 
> different from Linux's local filesystem behaviour.

;-)

> > 3.	Modify invalidate_mmap_range() to leave MAP_PRIVATE vmas,
> > 	but invalidate those pages in the vma that have not yet been
> > 	modified (that are not anonymous) as suggested by Stephen.
> > 	This would mean that a process that had mapped a file MAP_PRIVATE
> > 	and written on parts of it would see different versions of the
> > 	file in different pages.
> 
> This is the correct behaviour and is the current behaviour for local 
> filesystems.  In particular, all processes on all nodes will see the current 
> contents of any file page that they have not yet faulted in, as of the last 
> time any process wrote that file page via mmap or otherwise.
> 
> Our goal for GFS, and the goal I'd like to hold up as definitive for any 
> distributed filesystem, is to imitate local filesystem semantics exactly, 
> even across the cluster.

OK, I surrender.  I got some private email agreeing with this
viewpoint.  Any dissenters, speak soon, or...

> > Again, in what situation is this skewed view of the file useful?
> 
> It's not skewed in any way that I can see.  Though I am no linker expert, I 
> dimly recall that these are precisely the semantics ld relies on.

I thought that the linker relied on people refraining (or being
prevented) from updating executables while they are in use.
But I am also no linker expert.

> > 5.	The current behavior, where the process's writes do not
> > 	flow through to the file, but all changes to the file are
> > 	visible to the writing process.
> 
> We all agree that's broken, I hope.

I can buy DFSes implementing semantics that are the same as local
filesystems.  But no one has yet shown me anything that it breaks!

> > 6.	Requiring that MAP_PRIVATE be applied only to unchanging
> > 	files, so that (for example) any change to the underlying
> > 	file removes that file from any MAP_PRIVATE address spaces.
> > 	Subsequent accesses would get a SEGV, rather than a
> > 	surprise from silently changing data.
> 
> Creative :)  Well, data that changes "silently" is a fact of life whenever 
> data is shared.  It's up to applications to ensure that shared data changes 
> predictably.

Glad you liked it.  ;-)

I think that predictability when using MAP_PRIVATE requires that one
refrain from modifying the underlying file while someone has it mmap()ed
with MAP_PRIVATE.  I would welcome an example proving me wrong.

> > So, please help me out here...  What do applications that MAP_PRIVATE
> > changing files really expect to happen?
> 
> Number 3, is that ok with you?  Incidently, your list doesn't include the 
> semantics we'd get by just exporting and using invalidate_mmap_range.  I 
> presume that is because you agree it's not correct (it will clobber CoWed 
> anonymous pages).

I will give it a shot, though I would still like to hear about examples
where the difference in semantics affects a real application.
BTW, my list didn't include exporting and using the current
invalidate_mmap_range() because I didn't say what I meant to say.
Hate it when that happens!  ;-)

						Thanx, Paul
