Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319457AbSIGI1m>; Sat, 7 Sep 2002 04:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319458AbSIGI1m>; Sat, 7 Sep 2002 04:27:42 -0400
Received: from dsl-213-023-021-052.arcor-ip.net ([213.23.21.52]:8631 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319457AbSIGI1l>;
	Sat, 7 Sep 2002 04:27:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, trond.myklebust@fys.uio.no
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Sat, 7 Sep 2002 10:24:23 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3D77C8B7.1534A2DB@zip.com.au> <15735.52512.886434.46650@charged.uio.no> <3D77D879.7F7A3385@zip.com.au>
In-Reply-To: <3D77D879.7F7A3385@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17natE-0006OB-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 September 2002 00:19, Andrew Morton wrote:
> I'm not sure what semantics we really want for this.  If we were to
> "invalidate" a mapped page then it would become anonymous, which
> makes some sense.

There's no need to leave the page mapped, you can easily walk the rmap list
and remove the references.

> If the VM wants to reclaim a page, and it has PG_private set then
> the vm will run mapping->releasepage() against the page.  The mapping's
> releasepage must try to clear away whatever is held at ->private.  If
> that was successful then releasepage() must clear PG_private, decrement
> page->count and return non-zero.  If the info at ->private is not
> freeable, releasepage returns zero.  ->releasepage() may not sleep in
> 2.5.
> 
> So.  NFS can put anything it likes at page->private.  If you're not
> doing that then you don't need a releasepage.  If you are doing that
> then you must have a releasepage().

Right now, there are no filesystems actually doing anything filesystem
specific here, are there?  I really wonder if making this field, formerly
known as buffers, opaque to the vfs is the right idea.

-- 
Daniel
