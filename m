Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbTCJNDn>; Mon, 10 Mar 2003 08:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261308AbTCJNDm>; Mon, 10 Mar 2003 08:03:42 -0500
Received: from [195.223.140.107] ([195.223.140.107]:12431 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261306AbTCJNDl>;
	Mon, 10 Mar 2003 08:03:41 -0500
Date: Mon, 10 Mar 2003 14:16:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, daniel@osdl.org,
       linux-kernel@vger.kernel.org, shemminger@osdl.org,
       torvalds@transmeta.com
Subject: Re: [PATCH 2.5.64 2/2] i_size atomic access
Message-ID: <20030310131611.GA14627@dualathlon.random>
References: <1047082543.2636.98.camel@ibm-c.pdx.osdl.net> <20030307163001.43805e11.akpm@digeo.com> <1047086790.2634.105.camel@ibm-c.pdx.osdl.net> <20030308042555.GA31650@delft.aura.cs.cmu.edu> <20030307203340.5e025ef0.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307203340.5e025ef0.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 08:33:40PM -0800, Andrew Morton wrote:
> Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> >
> > On Fri, Mar 07, 2003 at 05:26:31PM -0800, Daniel McNeil wrote:
> > > On Fri, 2003-03-07 at 16:30, Andrew Morton wrote:
> > > > Daniel McNeil <daniel@osdl.org> wrote:
> > > > > This adds i_seqcnt to inode structure and then uses i_size_read() and
> > > > > i_size_write() to provide atomic access to i_size.
> > > > 
> > > > Ho hum.  Everybody absolutely hates this, but I guess we should do it :(
> > 
> > I am really curious whether this patch is really all that useful, has
> > anyone ever noticed enough lock contention on inode semaphore caused by
> > accessing i_size? Whenever i_size changes it needs to be locked down
> > either way because mappings have to be extended or truncated.
> 
> The problem is not lock contention.  The problem is that the read() paths are
> performing nonatomic reads of a 64-bit value.  If a writer is updating i_size
> at the same time the reader can see grossly incorrect values.
> 
> It's such a remote problem that nobody really has the heart to do anything
> about it.  But it's there...

well really this is fixed in my tree and in some distribution kernels
for half an year, it's true only the major fs are been taken care of,
but definitely somebody had the heart to do something about it 8)

> > A quick grep shows that there are 619 references to ->i_size in the
> > various filesystem subdirs.
> 
> Most of these are not inode->i_size.  Yes, there are i_size references in
> filesystems, but not many.  And the infrastructure is there to mop those up.
> 
> If we choose to.  I'm still not sure I want to do this :(

There is no other way, some cpu can't even do it atomically (hence the
need of the sequence number approch).

Also note that the atomicity isn't needed everywhere, for example if you
read i_size in the write paths you don't need to use i_size_read, but
you can read with inode->i_size as usual, which is faster and in turn
recommended.

I described the locking rules here:

	http://groups.google.com/groups?q=i_size_read&hl=en&lr=&ie=UTF-8&selm=20020717225504.GA994%40dualathlon.random&rnum=2

	  The rules are: 1) i_size_write must be used for all i_size
	  updates (at least when there can be potential parallel readers
	  outside the i_sem), 2) i_size_read must be used for all lockless
	  reads when an i_size change can happen from under us.
	  
Andrea
