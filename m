Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262608AbSJGR2v>; Mon, 7 Oct 2002 13:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262606AbSJGR2v>; Mon, 7 Oct 2002 13:28:51 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:1554 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262608AbSJGR2s>; Mon, 7 Oct 2002 13:28:48 -0400
Date: Mon, 7 Oct 2002 18:34:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark Peloquin <peloquin@us.ibm.com>
Cc: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 3/4: evms_ioctl.h
Message-ID: <20021007183415.A22316@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
	viro@math.psu.edu, linux-kernel@vger.kernel.org,
	evms-devel@lists.sourceforge.net
References: <OFEADEC58E.F70F8BE4-ON85256C4B.004F8C03@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OFEADEC58E.F70F8BE4-ON85256C4B.004F8C03@pok.ibm.com>; from peloquin@us.ibm.com on Mon, Oct 07, 2002 at 11:43:30AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 11:43:30AM -0500, Mark Peloquin wrote:
> > Can't you use normal revalidate/media change operations?
> 
> For most plugins, except the device manager, this operation
> was nothing more than an exercise in routing the operation
> requests to the underlying devices. Since this routing code
> already exists in the ioctl interface, it seemed reasonable
> to just reuse it for this purpose as well. As a result,
> each plugin had to add 0 lines of code to support this.

I don't think that basing kernel internal interfaces on ioctl is
a smart idea.  Just add another function pionter to your operations
vector for every operation you want supported on volumes.

That way the uppermost layer can do the translation from the ugly
ioctl interface (or a future nice fs-based interface) to the operations
once instead of carrying the user-defined syscalls (aka ioctls)
around through your whole architecture.

> > if you need open/close ioctl you got some abstraction wrong..
> 
> In EVMS, because of removable media devices, we chose to
> open/close the underlying devices only when an actual
> open/close is received for a volume residing on the
> devices. This allows removable media devices to remain
> unlocked until they are in use.

Again, why can't you have open/close _methods_ for it instead of abusing
the ioctl interface.  It would be even nicer if you could extend
the block device operations with your new volume-mangment methods
instead of adding another API for blockdevices/disks outside the higher
level kernel code.

> > You don't use an ioctl to read into a user supplied buffer??
> 
> This ioctl is used by our userspace tools. EVMS stores
> metadata at the very end of devices. This ioctl was
> initially done to avoid the problem of "short writes"
> to those last sectors. It also allows the core to
> control which devices userspace can address.

Umm.  I'd suggest you fix the read/write access instead of duplicating those
two core unix syscalls in an messy ioctl API.

> > An ioctl to compute a checksum??
> 
> MD uses checksum routines. Rather than duplicating
> this code, we provided a method, for our usertools,
> of using the kernel routines, especially considering
> there is multiple methods based on various
> characteristics.

Based on that argumentation we should make memcpy a syscall..

