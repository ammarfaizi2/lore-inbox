Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVDZALq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVDZALq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 20:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVDZALp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 20:11:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:26599 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261228AbVDZAL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 20:11:26 -0400
Date: Mon, 25 Apr 2005 17:10:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Caitlin Bestler <caitlin.bestler@gmail.com>
Cc: libor@topspin.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, timur.tabi@ammasso.com
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
 verbs implementation
Message-Id: <20050425171050.5ba25918.akpm@osdl.org>
In-Reply-To: <469958e00504251637350cc8c@mail.gmail.com>
References: <20050418164316.GA27697@infradead.org>
	<426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com>
	<20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com>
	<20050425151459.1f5fb378.akpm@osdl.org>
	<426D6DFA.4090908@ammasso.com>
	<20050425153542.70197e6a.akpm@osdl.org>
	<20050425161713.A9002@topspin.com>
	<20050425162405.0889093e.akpm@osdl.org>
	<469958e00504251637350cc8c@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Caitlin Bestler <caitlin.bestler@gmail.com> wrote:
>
> > 
> > > > This is because there is no file descriptor or anything else associated
> > > > with the pages which permits the kernel to clean stuff up on unclean
> > > > application exit.  Also there are the obvious issues with permitting
> > > > pinning of unbounded amounts of memory.
> > >
> > >   Correct, the driver must be able to determine that the process has died
> > > and clean up after it, so the pinned region in most implementations is
> > > associated with an open file descriptor.
> > 
> > How is that association created?
> 
> 
> There is not a file descrptor, but there is an rnic handle. Both DAPL
> and IT-API require that process death will result in the handle and all
> of its dependent objects being released.

What's an "rnic handle", in Linux terms?

> The rnic handle can always be declared to be a "file descriptor" if
> that makes it follow normal OS conventions more precisiely.

Does that mean that the code has not yet been implemented?

Yes, a Linux fd is appropriate.  But we don't have any sane way right now
of saying "you need to run put_page() against all these pages in the
->release() handler".  That'll need to be coded by yourselves.

> There is also a need for some form of resource manager to approve
> creation of Memory Regions. Obviously you cannot have multiple
> applications claiming half of physical memory.

The kernel already has considerable resource management capabilities. 
Please consider using/extending/generalising those before inventing
anything new.  RLIMIT_MEMLOCK would be a starting point.

> But if you merely require the user to have root privileges in order
> to create a Memory Region, and then take a first-come first-served
> attitude, I don't think you end up with something that is truly a
> general purpose capability.

We don't want code in the kernel which will permit hostile unprivileged
users to trivially cause the box to lock up.  RLIMIT_MEMLOCK and, if
necessary, CAP_IPC_LOCK sound appropriate here.

> A general purpose RDMA capability requires the ability to indefinitely
> pin large portions of user memory. It makes sense to integrate that
> with OS policy control over resource utilization and to integrate it with
> memory suspend/resume capabilities so that hotplug memory can
> be supported. What you can't do is downgrade a Memory Region so
> that it is no longer a memory region. Doing that means that you are
> not truly supporting RDMA.
