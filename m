Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265445AbUBFNZo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 08:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbUBFNZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 08:25:44 -0500
Received: from ns.suse.de ([195.135.220.2]:55972 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265445AbUBFNZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 08:25:41 -0500
Date: Fri, 6 Feb 2004 14:24:41 +0100
From: Andi Kleen <ak@suse.de>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       piggy@timesys.com, trini@kernel.crashing.org, george@mvista.com
Subject: Re: kgdb support in vanilla 2.6.2
Message-Id: <20040206142441.23def5f3.ak@suse.de>
In-Reply-To: <200402061835.16960.amitkale@emsyssoft.com>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel>
	<200402061728.36989.amitkale@emsyssoft.com>
	<20040206131639.74dd87cf.ak@suse.de>
	<200402061835.16960.amitkale@emsyssoft.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004 18:35:16 +0530
"Amit S. Kale" <amitkale@emsyssoft.com> wrote:

> On Friday 06 Feb 2004 5:46 pm, Andi Kleen wrote:
> > On Fri, 6 Feb 2004 17:28:36 +0530
> >
> > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > > On Friday 06 Feb 2004 7:50 am, Andi Kleen wrote:
> > > > On Thu, 5 Feb 2004 23:20:04 +0530
> > > >
> > > > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > > > > On Thursday 05 Feb 2004 8:41 am, Andi Kleen wrote:
> > > > > > Andrew Morton <akpm@osdl.org> writes:
> > > > > > > need to take a look at such things and really convice ourselves
> > > > > > > that they're worthwhile.  Personally, I'd only be interested in
> > > > > > > the basic stub.
> > > > > >
> > > > > > What I found always extremly ugly in the i386 stub was that it uses
> > > > > > magic globals to talk to the page fault handler. For the x86-64
> > > > > > version I replaced that by just using __get/__put_user in the
> > > > > > memory accesses, which is much cleaner. I would suggest doing that
> > > > > > for i386 too.
> > > > >
> > > > > May be I am missing something obvious. When debugging a page fault
> > > > > handler if kgdb accesses an swapped-out user page doesn't it deadlock
> > > > > when trying to hold mm semaphore?
> > > >
> > > > Modern i386 kernels don't grab the mm semaphore when the access is >=
> > > > TASK_SIZE and the access came from kernel space (actually I see x86-64
> > > > still does, but that's a bug, will fix). You could only see a deadlock
> > > > when using user addresses and you already hold the mm semaphore for
> > > > writing (normal read lock is ok). Just don't do that.
> > >
> > > OK. It don't deadlock when kgdb accesses kernel addresses.
> > >
> > > When a user space address is accessed through kgdb, won't the kernel
> > > attempt to fault in the user page? We don't want that to happen inside
> > > kgdb.
> >
> > Yes, it will. But I don't think it's a bad thing. If the users doesn't want
> > that they should not follow user addresses. After all kgdb is for people
> > who know what they are doing.
> 
> Let kgdb refuse to access any addresses below TASK_SIZE. That's better than 
> accidentally typing something and getting lost.

That's fine. But can you perhaps add a magic command that enables it again? 
I could imagine in a few cases it will be useful because there may be pages
mapped into the user address space that are not in the direct mapping
(that's mainly on 32bit of course, on amd64 you can always access all 
memory using mappings >TASK_SIZE)

-Andi
