Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUBFNFw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 08:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUBFNFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 08:05:52 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:8856 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265218AbUBFNFu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 08:05:50 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andi Kleen <ak@suse.de>
Subject: Re: kgdb support in vanilla 2.6.2
Date: Fri, 6 Feb 2004 18:35:16 +0530
User-Agent: KMail/1.5
Cc: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       piggy@timesys.com, trini@kernel.crashing.org, george@mvista.com
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <200402061728.36989.amitkale@emsyssoft.com> <20040206131639.74dd87cf.ak@suse.de>
In-Reply-To: <20040206131639.74dd87cf.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402061835.16960.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 Feb 2004 5:46 pm, Andi Kleen wrote:
> On Fri, 6 Feb 2004 17:28:36 +0530
>
> "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > On Friday 06 Feb 2004 7:50 am, Andi Kleen wrote:
> > > On Thu, 5 Feb 2004 23:20:04 +0530
> > >
> > > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > > > On Thursday 05 Feb 2004 8:41 am, Andi Kleen wrote:
> > > > > Andrew Morton <akpm@osdl.org> writes:
> > > > > > need to take a look at such things and really convice ourselves
> > > > > > that they're worthwhile.  Personally, I'd only be interested in
> > > > > > the basic stub.
> > > > >
> > > > > What I found always extremly ugly in the i386 stub was that it uses
> > > > > magic globals to talk to the page fault handler. For the x86-64
> > > > > version I replaced that by just using __get/__put_user in the
> > > > > memory accesses, which is much cleaner. I would suggest doing that
> > > > > for i386 too.
> > > >
> > > > May be I am missing something obvious. When debugging a page fault
> > > > handler if kgdb accesses an swapped-out user page doesn't it deadlock
> > > > when trying to hold mm semaphore?
> > >
> > > Modern i386 kernels don't grab the mm semaphore when the access is >=
> > > TASK_SIZE and the access came from kernel space (actually I see x86-64
> > > still does, but that's a bug, will fix). You could only see a deadlock
> > > when using user addresses and you already hold the mm semaphore for
> > > writing (normal read lock is ok). Just don't do that.
> >
> > OK. It don't deadlock when kgdb accesses kernel addresses.
> >
> > When a user space address is accessed through kgdb, won't the kernel
> > attempt to fault in the user page? We don't want that to happen inside
> > kgdb.
>
> Yes, it will. But I don't think it's a bad thing. If the users doesn't want
> that they should not follow user addresses. After all kgdb is for people
> who know what they are doing.

Let kgdb refuse to access any addresses below TASK_SIZE. That's better than 
accidentally typing something and getting lost.

I guess preventing user address accesses is lesser evil compared to using a 
debugger global.

gdb itself may access user addresses in following scenarios. Not allowing user 
accesses doesn't hurt as gdb can accept that and recover gracefully.

1. When a function parameter contains a char pointer.
GDB prints the string pointed to by a function parameter when printing frame 
for the function. 

2. If a kernel variable points to a user string, print command will show its 
contents, unless user explicitely says print/x.

3. When a stack trace goes beyond an interrupt or an exception entrypoint:
The gdb at kgdb.sourceforge.net has some patchup for this problem, though it 
doesn't work all the time. Sometimes we do endup seeing one invalid stack 
frame for which gdb has accessed a user address.

-Amit

