Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbVD2REo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbVD2REo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 13:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbVD2REo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 13:04:44 -0400
Received: from vanguard.topspin.com ([12.162.17.52]:16960 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S262834AbVD2RE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 13:04:27 -0400
Date: Fri, 29 Apr 2005 10:04:25 -0700
From: Libor Michalek <libor@topspin.com>
To: Caitlin Bestler <caitlin.bestler@gmail.com>
Cc: Bill Jordan <woodennickel@gmail.com>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Timur Tabi <timur.tabi@ammasso.com>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050429100425.A13041@topspin.com>
References: <20050425173757.1dbab90b.akpm@osdl.org> <52wtqpsgff.fsf@topspin.com> <20050426084234.A10366@topspin.com> <52mzrlsflu.fsf@topspin.com> <20050426122850.44d06fa6.akpm@osdl.org> <5264y9s3bs.fsf@topspin.com> <426EA220.6010007@ammasso.com> <20050426133752.37d74805.akpm@osdl.org> <5ebee0d105042907265ff58a73@mail.gmail.com> <469958e005042908566f177b50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <469958e005042908566f177b50@mail.gmail.com>; from caitlin.bestler@gmail.com on Fri, Apr 29, 2005 at 08:56:20AM -0700
X-OriginalArrivalTime: 29 Apr 2005 17:04:27.0003 (UTC) FILETIME=[801154B0:01C54CDD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 08:56:20AM -0700, Caitlin Bestler wrote:
> On 4/29/05, Bill Jordan <woodennickel@gmail.com> wrote:
> > On 4/26/05, Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > Our point is that contemporary microprocessors cannot electrically
> > > do what you want them to do!
> > >
> > > Now, conceeeeeeiveably the kernel could keep track of the state of the
> > > pages down to the byte level, and could keep track of all COWed pages and
> > > could look at faulting addresses at the byte level and could copy sub-page
> > > ranges by hand from one process's address space into another process's
> > > after I/O completion.  I don't think we want to do that.
> > >
> > > Methinks your specification is busted.
> > 
> > I agree in principal. However, I expect this issue will come up with
> > more and more new specifications, and if it isn't addressed once in
> > the linux kernel, it will be kludged and broken many times in many
> > drivers.
> > 
> > I believe we need an kernel level interface that will pin user pages,
> > and lock the user vma in a single step. The interface should be used
> > by drivers when the hardware mappings are done. If the process is
> > split into a user operation to lock the memory, and a driver operation
> > to map the hardware, there will always be opportunity for abuse.
> > 
> > Reference counting needs to be done by this interface to allow
> > different hardware to interoperate.
> > 
> > The interface can't overload the VM_LOCKED flag, or rely on any other
> > attributes that the user can tinker with via any other interface.
> > 
> > And as much as I hate to admit it, I think on a fork, we will need to
> > copy parts of pages at the beginning or end of user I/O buffers.
> > 
> 
> I agree with all but the last part, in my opinion there is no need to deal
> with fork issues as long as solutions do not result in failures. There is
> *no* basis for a child process to expect that it will inherit RDMA resources.
> A child process that uses such resources will get undefined results, nothing
> further needs to be stated, and no heroic efforts are required to avoid them.

  However, you have a potential problem with registered buffers that
do not begin or end on a page boundary, which is common with malloc.
If the buffer resides on a portion of a page, and you mark the vm
which contains that entire page VM_DONTCOPY, to ensure that the parent
has access to the exact physical page after the fork, the child will
not be able to access anything on that entire page. So if the child
expects to access data on the same page that happens to contain the
registered buffer it will get a segment violation.

The four situations we've discussed are:

  1) Physical page does not get used for anything else.
  2) Processes virtual to physical mapping remains fixed.
  3) Same virtual to physical mapping after forking a child.
  4) Forked child has access to all non-registered memory of
     the parent.

The first two are now taken care of with get_user_pages, (we use to
use VM_LOCKED for the second case) third case is handled by setting
the vm to VM_DONTCOPY, and on the fourth case we've always punted,
but the real answer is to break partial pages into seperate vms and
mark them ALWAYS_COPY.

-Libor


