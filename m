Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVBUWlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVBUWlf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 17:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVBUWlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 17:41:35 -0500
Received: from fire.osdl.org ([65.172.181.4]:48033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262162AbVBUWlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 17:41:24 -0500
Date: Mon, 21 Feb 2005 14:41:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ray Bryant <raybry@sgi.com>
Cc: mort@wildopensource.com, pj@sgi.com, linux-kernel@vger.kernel.org,
       hilgeman@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-Id: <20050221144108.40eba4d9.akpm@osdl.org>
In-Reply-To: <421A607B.4050606@sgi.com>
References: <20050214154431.GS26705@localhost>
	<20050214193704.00d47c9f.pj@sgi.com>
	<20050221192721.GB26705@localhost>
	<20050221134220.2f5911c9.akpm@osdl.org>
	<421A607B.4050606@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant <raybry@sgi.com> wrote:
>
> Andrew Morton wrote:
> > Martin Hicks <mort@wildopensource.com> wrote:
> > 
> >>This patch introduces a new sysctl for NUMA systems that tries to drop
> >> as much of the page cache as possible from a set of nodes.  The
> >> motivation for this patch is for setting up High Performance Computing
> >> jobs, where initial memory placement is very important to overall
> >> performance.
> > 
> > 
> > - Using a write to /proc for this seems a bit hacky.  Why not simply add
> >   a new system call for it?
> > 
> 
> We did it this way because it was easier to get it into SLES9 that way.
> But there is no particular reason that we couldn't use a system call.
> It's just that we figured adding system calls is hard.

aarggh.  This is why you should target kernel.org kernels first.  Now we
risk ending up with poor old suse carrying an obsolete interface and
application developers have to be able to cater for both interfaces.

> >   If it does, then userspace could arrange for that concurrency by
> >   starting a number of processes to perform the toss, each with a different
> >   nodemask.
> > 
> 
> That works fine as well if we can get a system call number assigned and
> avoids the hackiness of both /proc and the kernel threads.

syscall numbers are per-arch.  We don't need to assign a syscall number for
this one - we can surely have this ready for 2.6.12.  Simply include i386
and ia64 in the initial patch and other architectures will catch up pretty
quickly.  (It would be nice to generate patches for the arch maintainers,
however).

> > - Dropping "as much pagecache as possible" might be a bit crude.  I
> >   wonder if we should pass in some additional parameter which specifies how
> >   much of the node's pagecache should be removed.
> > 
> >   Or, better, specify how much free memory we will actually require on
> >   this node.  The syscall terminates when it determines that enough
> >   pagecache has been removed.
> 
> Our thoughts exactly.  This is clearly a "big hammer" and we want to
> make a lighter hammer to free up a certain number of pages.  Indeed,
> we would like to have these calls occur automatically from __alloc_pages()
> when we try to allocate local storage and find that there isn't any.
> For our workloads, we want to free up unmapped, clean pagecache, if that
> is what is keeping us from allocating a local page.  Not all workloads
> want that, however, so we would probably use a sysctl() to enable/disable
> this.
> 
> However, the first step is to do this manually from user space.

Yup.  The thing is, lots of people want this feature for various reasons. 
Not just numerical-computing-users-on-NUMA.  We should get it right for
them too.

Especially kernel developers, who have various nasty userspace tools which
will manually reclaim pagecache.  But non-kernel-developers will use it
too, when they think the VM is screwing them over ;)

I think Solaris used to have such a tool - /usr/etc/chill, although I
don't know if it had kernel support.

> > 
> > - To make the syscall more general, we should be able to reclaim mapped
> >   pagecache and anonymous memory as well.
> > 
> > 
> > So what it comes down to is
> > 
> > sys_free_node_memory(long node_id, long pages_to_make_free, long what_to_free)
> > 
> > where `what_to_free' consists of a bunch of bitflags (unmapped pagecache,
> > mapped pagecache, anonymous memory, slab, ...).
> 
> Do we have to implement all of those or just allow for the possibility of that
> being implemented in the future?  E. g. in our case we'd just implement the
> bit that says "unmapped pagecache".

Well...  please take a look at what's involved.  It should just be a matter
of sprinkling a few test such as

+	if (sc->mode & SC_RECLAIM_SLAB) {
	...
+	}

into the existing code.  If things turn nasty then we can take another look
at it.
