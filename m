Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTJRVK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 17:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTJRVK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 17:10:27 -0400
Received: from vsmtp3.tin.it ([212.216.176.223]:14259 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S261842AbTJRVKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 17:10:16 -0400
Message-ID: <3F91BA19.85364B82@tin.it>
Date: Sat, 18 Oct 2003 22:09:29 +0000
From: "A.D.F." <adefacc@tin.it>
Reply-To: adefacc@tin.it
Organization: Private
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.2.24 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre VM regression?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Oct 16, 2003 at 10:29:16AM -0200, Marcelo Tosatti wrote:
> > 
> > 
> > On Thu, 16 Oct 2003, Andrea Arcangeli wrote:
> > 
> > > On Thu, Oct 16, 2003 at 09:52:30AM -0200, Marcelo Tosatti wrote:
> > > > 
> > > > Andrea, 
> > > > 
> > > > Martin first reported problems with "gzip -dc file | less" (280MB file).
> > > > less was getting killed. He had no swap... I asked him to add some swap
> > > > and it works now. Fine. 
> > > > 
> > > > The thing is that with 2.4.22 less was being killed, but with 2.4.23-pre
> > > > he gets:
> > > 
> > > note, that's a true oom, less needs to allocate 280MB and it doesn't fit
> > > in ram. there's no bug as far as I can tell.
> > >
> > > a `vmstat 1` could confirm that.
> > > 
> > > > >> And yes, the app was killed:
> > > > > >
> > > > > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > > > > VM: killing process named
> > > > > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > > > > VM: killing process gpm
> > > > > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > > > > VM: killing process sendmail
> > > > > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > > > > VM: killing process less
> > > 
> > > here the vm keeps killing until 'less' - the real offender - is nuked.
> > > 
> > > > So a lot of processes which should not get killed are dying. This is
> > > > really bad. I was afraid it could happen and it did.
> > > > 
> > > > What now? Resurrect OOM-killer? 
> > > 
> > > the oom killer has the problem I outlined some email ago, with shared
> > > memory it gets fooled badly etc.., though in a desktop with all tiny
> > > tasks except the memory-hog (`less` in this case) it works well.
> > 
> > Andrea,
> > 
> > There is no memory. Right. Some task has to be killed. But not small
> > programs like sendmail/named/etc. What should be killed is "less". That is
> > clear, right?
> 
> sure. I think I already explained there are downsides in disabling the
> oom killer for desktops where the offender task is normally the biggest
> one too, but those downsides aren't something I care about given the
> cases it gets right w/o it (i.e. huge-shm-SGA/mlock/oomdeadlocks). the
> oom killer can do the wrong decision too sometime, and more
> systematically as well.

No, the hole point of view on this matter is wrong !

Kernel should try hard to not kill any process unless it behaves like
a time bomb (and in any case such a OOM killer should be configurable,
sysadmin should be able to enable or disable it).

memory allocation
-----------------
Kernel should instead do some memory preallocation
for reserved internal tasks and should fail system calls requesting
too much RAM.

Many applications don't know how much RAM the system has,
but they know well what to do when malloc(), calloc(), etc. return NULL
or when mmap() fails with ENOMEM: they usually try to shrink
their own caches and/or unused allocated objects
(well many apps simply exit, but this is their choice).

mmap
----
In the old good days of Kernels 2.0.x and 2.2.x,
you could mmap() a file bigger than RAM + swap size and nothing
too bad happened because kernel tried hard to keep in RAM only
used "window" of "mmapped" area (and it was obvious that to accomplish
such a task, accesses to mmapped area were slowed down a bit).

Now, in 2.4.x, with swap disabled,
what happens when an application mmaps a file bigger than RAM size ?

	1) mmap() succedes;

	2) application starts to read the file sequentially and
	   when it has read as many bytes as the RAM size - n
	   (where n is 1 - 32 MB), then it is brutally killed (kill -9)
	   without any advice.

This is _bad_ !!!

Before answering that no, this might be good, etc.,
think at common systems with 64, 128 or 256 MB RAM
and also at embedded systems that usually have swap disabled.

Conclusion is:  Kernels 2.2.x are stable rocks, kernels 2.4.x aren't yet,
in other words: don't kill, return ENOMEM instead and
use a safe overcommit value of 0.

(Please, CC to me).

-- 
Nick Name:      A.D.F.
E-Mail:         adefacc@tin.it
Content-Type:   text/plain
--
