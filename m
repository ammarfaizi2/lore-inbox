Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVDURiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVDURiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVDURiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:38:55 -0400
Received: from pirx.hexapodia.org ([199.199.212.25]:40067 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261572AbVDURiW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:38:22 -0400
Date: Thu, 21 Apr 2005 10:38:21 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Troy Benjegerdes <hozer@hozed.org>, Bernhard Fischer <blist@aon.at>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050421173821.GA13312@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42671901.4000805@ammasso.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 10:07:45PM -0500, Timur Tabi wrote:
> Troy Benjegerdes wrote:
> >Someone (aka Tospin, infinicon, and Amasso) should probably post a patch
> >adding '#define VM_REGISTERD 0x01000000', and some extensions to
> >something like 'madvise' to set pages to be registered.
> >
> >My preference is said patch will also allow a way for the kernel to
> >reclaim registered memory from an application under memory pressure.
> 
> I don't know if VM_REGISTERED is a good idea or not, but it should be 
> absolutely impossible for the kernel to reclaim "registered" (aka pinned) 
> memory, no matter what. For RDMA services (such as Infiniband, iWARP, etc), 
> it's normal for non-root processes to pin hundreds of megabytes of memory, 
> and that memory better be locked to those physical pages until the 
> application deregisters them.

If you take the hardline position that "the app is the only thing that
matters", your code is unlikely to get merged.  Linux is a
general-purpose OS.

I don't think that Troy was suggesting the kernel should deregister
memory without notifying the application.  Personally, I envision
something like the NetBSD Scheduler Activations (SA) work, where the
kernel can notify the app of changes to its state in a very efficient
manner.  (According to the NetBSD design whitepaper, the kernel does an
upcall whenever the multithreaded app gains or loses a CPU!)

In a Linux context, I doubt that fullblown SA is necessary or
appropriate.  Rather, I'd suggest two new signals, SIGMEMLOW and
SIGMEMCRIT.  The userland comms library registers handlers for both.
When the kernel decides that it needs to reclaim some memory from the
app, it sends SIGMEMLOW.  The comms library then has the responsibility
to un-reserve some memory in an orderly fashion.  If a reasonable [1]
time has expired since SIGMEMLOW and the kernel is still hungry, the
kernel sends SIGMEMCRIT.  At this point, the comms lib *must* unregister
some memory [2] even if it has to drop state to do so; if it returns
from the signal handler without having unregistered the memory, the
kernel will SIGKILL.

[1] Part of the interface spec should cover the expectation as to how
    long the library is allowed to take; I'd guess that 2 timeslices
    should suffice.
[2] Is there a way for the kernel to pass down to userspace how many
    pages it wants, maybe in the sigcontext?

> If kernel really thinks it needs to unpin those pages, then at the very 
> least it should kill the process, and the syslog better have a very clear 
> message indicating why.  That way, the application doesn't continue 
> thinking that everything's still going to work.  If those pages become 
> unpinned, the applications are going to experience serious data corruption.

You might want to consider what happens with your communication system
in a machine running power-saving modes (in the limit, suspend-to-disk).
Of course most machines with Infiniband adapters aren't running swsusp,
but it's not inconceivable that blade servers might sleep to lower power
and cooling costs.

-andy
