Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVDZNqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVDZNqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 09:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVDZNqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 09:46:14 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:19168 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261452AbVDZNpq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 09:45:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DOu17Pb8Esmr+wkA1QsDOtLu3IrjTGAnbpQlK5vieEsKbn161foPlKVB45l7RXskpDPn83t2SZadtObIF/LvLDQHs6M39gHexIvatBY3swDhPlvDej83VEXvwBrMogzxbF1OgZVJ+hzM+sRqRHH1tY3Cumvvt28DRdFDRRZtQT0=
Message-ID: <469958e00504260645dd2218d@mail.gmail.com>
Date: Tue, 26 Apr 2005 06:45:42 -0700
From: Caitlin Bestler <caitlin.bestler@gmail.com>
Reply-To: Caitlin Bestler <caitlin.bestler@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Roland Dreier <roland@topspin.com>,
       Andrew Morton <akpm@osdl.org>, timur.tabi@ammasso.com, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
In-Reply-To: <20050426061236.GA27220@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4263DEC5.5080909@ammasso.com> <4263E445.8000605@ammasso.com>
	 <20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com>
	 <52is2bvvz5.fsf@topspin.com> <20050425135401.65376ce0.akpm@osdl.org>
	 <521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org>
	 <52r7gytnfn.fsf@topspin.com> <20050426061236.GA27220@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/05, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Apr 25, 2005 at 05:02:36PM -0700, Roland Dreier wrote:
> > The idea is that applications manage the lifetime of pinned memory
> > regions.  They can do things like post multiple I/O operations without
> > any page-walking overhead, or pass a buffer descriptor to a remote
> > host who will send data at some indeterminate time in the future.  In
> > addition, InfiniBand has the notion of atomic operations, so a cluster
> > application may be using some memory region to implement a global lock.
> >
> > This might not be the most kernel-friendly design but it is pretty
> > deeply ingrained in the design of RDMA transports like InfiniBand and
> > iWARP (RDMA over IP).
> 
> Actuallky, no it isn't.   All these transports would work just fine with
> the mmap a character device to hand out memory from the kernel approach
> I told you to use multiple times and Andrew mentioned in this thread aswell.
> What doesn't work with that design are the braindead designed by comittee
> APIs in the RDMA world - but I don't think we should care about them too
> much.
> 


RDMA registers and uses the memory the user specifies. That is why byte
granularity and multiple redundant registrations are explicitly specified.

The mechanism by which this requirement is implemented is of course
OS dependent. But the requirements are that the application specifies
what portion of their memory they want registered (or what set of physical
pages if they have sufficient privilege) and that request is either honored
or refused by a resource manager (one preferably as integrated with
general OS resource management as possible).

The other aspect is that remotely enabled memory regions and memory
windows most be enabled for hardware access for the duration of 
the region or window -- indefinitely until process death or explicit
termination by the application layer.

Theoretically there is nothing in the wire protocols that requires source
buffers to be pinned indefinitely, but that is the only way any RDMA
interface has ever worked -- so "brain death" must be pretty widespread.

The fact that this problem must be solved for remotely accessible
buffers, and that for cluster applications like MPI there is no distinction
between buffers used for inbound messages and outbound messages,
might have something to do with this.

User verbs needs to deal with these actual Memory Registration requirements,
including the very real application need for Memory Windows. The solution
should map to existing OS controls as much as possible.
