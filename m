Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUIELoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUIELoN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUIELoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:44:13 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:33801 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S266488AbUIELnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:43:40 -0400
Message-ID: <20040905154336.B9202@castle.nmd.msu.ru>
Date: Sun, 5 Sep 2004 15:43:36 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q about pagecache data never written to disk
References: <20040905120147.A9202@castle.nmd.msu.ru> <20040905035233.6a6b5823.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20040905035233.6a6b5823.akpm@osdl.org>; from "Andrew Morton" on Sun, Sep 05, 2004 at 03:52:33AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sun, Sep 05, 2004 at 03:52:33AM -0700, Andrew Morton wrote:
> Andrey Savochkin <saw@saw.sw.com.sg> wrote:
> >
> > Let's suppose an mmap'ed (SHARED, RW) file has a hole.
> >  AFAICS, we allow to dirty the file pages without allocating the space for the
> >  hole - filemap_nopage just "reads" the page filling it with zeroes, and
> >  nothing is done about the on-disk data until writepage.
> > 
> >  So, if the page can't be written to disk (no space), the dirty data just
> >  stays in the pagecache.  The data can be read or seen via mmap, but it isn't
> >  and never be on disk.  The pagecache stays unsynchronized with the on-disk
> >  content forever.
> 
> The kernel will make one attampt to write the data to disk.  If that write
> hits ENOSPC, the page is not redirtied (ie: the data can be lost).
> 
> When that write hits ENOSPC an error flag is set in the address_space and
> that will be returned from a subsequent msync().  The application will then
> need to do something about it.
> 
> If your application doesn't msync() the memory then it doesn't care about
> its data anyway.  If your application _does_ msync the pages then we
> reliably report errors.

This question came to my mind when I was thinking about journal_start in
ext3_prepare_write and copy_from_user issue...
Did you follow that discussion?

In the considered scenario not only the application is not
guaranteed anything till msync(), but all other programs doing regular read()
may also be fooled about the file content, and this idea surprised me.
On the other hand, after a write() other programs also see the new content
without a guarantee that this content corresponds with what is on the disk...

> 
> >  Is it the intended behavior?
> >  Shouldn't we call the filesystem to fill the hole at the moment of the first
> >  write access?
> 
> That would be a retrograde step - it would be nice to move in the other
> direction: perform disk allocation at writeback time rather than at write()
> time, even for regular write() data.  To do that we (probably) need space
> reservation APIs.  And yes, we perhaps could reserve space in the
> filesystem when that page is first written to.
> 
> But then what would we do if there's no space?  SIGBUS?  SIGSEGV? 
> Inappropriate.  SIGENOSPC?

Should the space be allocated on close()?
Who will get the signal if nobody accesses the file anymore?
I'm also thinking about various shell scripts with redirects to files...

	Andrey
