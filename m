Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSIGPsE>; Sat, 7 Sep 2002 11:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318248AbSIGPsD>; Sat, 7 Sep 2002 11:48:03 -0400
Received: from packet.digeo.com ([12.110.80.53]:24201 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S317772AbSIGPsD>;
	Sat, 7 Sep 2002 11:48:03 -0400
Message-ID: <3D7A2410.168668CC@digeo.com>
Date: Sat, 07 Sep 2002 09:06:40 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: trond.myklebust@fys.uio.no, Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77C8B7.1534A2DB@zip.com.au> <15735.52512.886434.46650@charged.uio.no> <3D77D879.7F7A3385@zip.com.au> <E17natE-0006OB-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Sep 2002 15:52:35.0445 (UTC) FILETIME=[958D0A50:01C25686]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Friday 06 September 2002 00:19, Andrew Morton wrote:
> > I'm not sure what semantics we really want for this.  If we were to
> > "invalidate" a mapped page then it would become anonymous, which
> > makes some sense.
> 
> There's no need to leave the page mapped, you can easily walk the rmap list
> and remove the references.

Yes, unmapping and forcing a subsequent major fault would make
sense.  It would require additional locking in the nopage pth
to make this 100% accurate.  I doubt if it's worth doing that,
so the unmap-and-refault-for-invalidate feature would probably
be best-effort.  But more accurate than what we have now.


> > If the VM wants to reclaim a page, and it has PG_private set then
> > the vm will run mapping->releasepage() against the page.  The mapping's
> > releasepage must try to clear away whatever is held at ->private.  If
> > that was successful then releasepage() must clear PG_private, decrement
> > page->count and return non-zero.  If the info at ->private is not
> > freeable, releasepage returns zero.  ->releasepage() may not sleep in
> > 2.5.
> >
> > So.  NFS can put anything it likes at page->private.  If you're not
> > doing that then you don't need a releasepage.  If you are doing that
> > then you must have a releasepage().
> 
> Right now, there are no filesystems actually doing anything filesystem
> specific here, are there?  I really wonder if making this field, formerly
> known as buffers, opaque to the vfs is the right idea.

That's right - it is only used for buffers at present.  I was using
page->private in the delayed-allocate code for directly holding the
disk mapping information.  There was some talk of using it for <mumble>
in XFS.  Also it may be used in the NFS server for storing credential
information.  Also it could be used for MAP_SHARED pages for credential
information - to fix the problem wherein kswapd (ie: root) is the
one who instantiates the page's blocks, thus allowing non-root programs
to consume the root-only reserved ext2/ext3 blocks.
