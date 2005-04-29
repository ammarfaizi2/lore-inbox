Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVD2P5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVD2P5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 11:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVD2P5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 11:57:04 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:50537 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262274AbVD2P4U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:56:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AKvbpxSCHntkVhEvZcjjsvXp/OEFCqzDIqWM2Okg08+8b3lql7ZyOK3Pdg58N77c5slQ1QMc3oAaa0INr2OZFRIHOVG/XLGrwqRyaTBGo0HjLCyxSEokwUhoWpo3yhkD2CEm9YyOFbT6mo+vpWC9l14fhC6bv1mVKPMUoSDR8ug=
Message-ID: <469958e005042908566f177b50@mail.gmail.com>
Date: Fri, 29 Apr 2005 08:56:20 -0700
From: Caitlin Bestler <caitlin.bestler@gmail.com>
Reply-To: Caitlin Bestler <caitlin.bestler@gmail.com>
To: Bill Jordan <woodennickel@gmail.com>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       Timur Tabi <timur.tabi@ammasso.com>
In-Reply-To: <5ebee0d105042907265ff58a73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050425135401.65376ce0.akpm@osdl.org>
	 <20050425173757.1dbab90b.akpm@osdl.org> <52wtqpsgff.fsf@topspin.com>
	 <20050426084234.A10366@topspin.com> <52mzrlsflu.fsf@topspin.com>
	 <20050426122850.44d06fa6.akpm@osdl.org> <5264y9s3bs.fsf@topspin.com>
	 <426EA220.6010007@ammasso.com> <20050426133752.37d74805.akpm@osdl.org>
	 <5ebee0d105042907265ff58a73@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/05, Bill Jordan <woodennickel@gmail.com> wrote:
> On 4/26/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> > Our point is that contemporary microprocessors cannot electrically do what
> > you want them to do!
> >
> > Now, conceeeeeeiveably the kernel could keep track of the state of the
> > pages down to the byte level, and could keep track of all COWed pages and
> > could look at faulting addresses at the byte level and could copy sub-page
> > ranges by hand from one process's address space into another process's
> > after I/O completion.  I don't think we want to do that.
> >
> > Methinks your specification is busted.
> 
> I agree in principal. However, I expect this issue will come up with
> more and more new specifications, and if it isn't addressed once in
> the linux kernel, it will be kludged and broken many times in many
> drivers.
> 
> I believe we need an kernel level interface that will pin user pages,
> and lock the user vma in a single step. The interface should be used
> by drivers when the hardware mappings are done. If the process is
> split into a user operation to lock the memory, and a driver operation
> to map the hardware, there will always be opportunity for abuse.
> 
> Reference counting needs to be done by this interface to allow
> different hardware to interoperate.
> 
> The interface can't overload the VM_LOCKED flag, or rely on any other
> attributes that the user can tinker with via any other interface.
> 
> And as much as I hate to admit it, I think on a fork, we will need to
> copy parts of pages at the beginning or end of user I/O buffers.
> 

I agree with all but the last part, in my opinion there is no need to deal
with fork issues as long as solutions do not result in failures. There is
*no* basis for a child process to expect that it will inherit RDMA resources.
A child process that uses such resources will get undefined results, nothing
further needs to be stated, and no heroic efforts are required to avoid them.

What is definitely needed is kernel counting of locks on user pages.
Finer granularity is not expected, it is the RDMA hardware that works
at finer granularity. All it needs is to know what bus address a given
virtual page maps to -- and it needs to know that said mapping will
not change without advance notice.

Further, any revocation of an existing mapping (to deal with hot page
swapping or whatever) cannot expect the RDMA hardware to respond
any faster than it would to invalidating a memory region.

The RDMA hardware has an inherent need to cache translations.
That is why it cannot guarantee that it will cease updating a memory
region the nanosecond that a request is made to invalidate an STag.
Instead it is allowed to block on such a request and only guarantees
to have ceased access when the invalidate request completes.

The same need for a delay exists for any interface that moves memory
around, or requests to reclaim memory from the application.

This also applies on process death. The hardware cannot stop on a dime.
The best it can do is stop promptly, and given an unambiguous indication
to the OS as to when it has stopped.
