Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVDYXiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVDYXiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 19:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVDYXiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 19:38:05 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:7088 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261229AbVDYXh6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 19:37:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZV3OB3JNe019H8dTUvCj7bJH17oxLQk0e5juIkgrPhgSOk1dlQ46pdSXD71RJYuacENnCGe/iiz4tx2k/UvYD4x2hnVzOuWE1AwpvZPZaYtEoWEDxwLg78+rJU8otmf1t7sieQppstpyaVl3kyD0c+x5zbFnxG8ksVsCXI1P2ao=
Message-ID: <469958e00504251637350cc8c@mail.gmail.com>
Date: Mon, 25 Apr 2005 16:37:56 -0700
From: Caitlin Bestler <caitlin.bestler@gmail.com>
Reply-To: Caitlin Bestler <caitlin.bestler@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Cc: Libor Michalek <libor@topspin.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       timur.tabi@ammasso.com
In-Reply-To: <20050425162405.0889093e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050418164316.GA27697@infradead.org>
	 <426BABF4.3050205@ammasso.com> <52is2bvvz5.fsf@topspin.com>
	 <20050425135401.65376ce0.akpm@osdl.org> <521x8yv9vb.fsf@topspin.com>
	 <20050425151459.1f5fb378.akpm@osdl.org> <426D6DFA.4090908@ammasso.com>
	 <20050425153542.70197e6a.akpm@osdl.org>
	 <20050425161713.A9002@topspin.com>
	 <20050425162405.0889093e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/05, Andrew Morton <akpm@osdl.org> wrote:

> 
> > > This is because there is no file descriptor or anything else associated
> > > with the pages which permits the kernel to clean stuff up on unclean
> > > application exit.  Also there are the obvious issues with permitting
> > > pinning of unbounded amounts of memory.
> >
> >   Correct, the driver must be able to determine that the process has died
> > and clean up after it, so the pinned region in most implementations is
> > associated with an open file descriptor.
> 
> How is that association created?


There is not a file descrptor, but there is an rnic handle. Both DAPL
and IT-API require that process death will result in the handle and all
of its dependent objects being released.

The rnic handle can always be declared to be a "file descriptor" if
that makes it follow normal OS conventions more precisiely.

There is also a need for some form of resource manager to approve
creation of Memory Regions. Obviously you cannot have multiple
applications claiming half of physical memory.

But if you merely require the user to have root privileges in order
to create a Memory Region, and then take a first-come first-served
attitude, I don't think you end up with something that is truly a
general purpose capability.

A general purpose RDMA capability requires the ability to indefinitely
pin large portions of user memory. It makes sense to integrate that
with OS policy control over resource utilization and to integrate it with
memory suspend/resume capabilities so that hotplug memory can
be supported. What you can't do is downgrade a Memory Region so
that it is no longer a memory region. Doing that means that you are
not truly supporting RDMA.
