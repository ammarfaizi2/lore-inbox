Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWC1Oyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWC1Oyg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 09:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWC1Oyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 09:54:36 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:35007 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932267AbWC1Oyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 09:54:35 -0500
Date: Tue, 28 Mar 2006 20:24:41 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       davem@davemloft.net, suparna@in.ibm.com, richardj_moore@uk.ibm.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RFC - Approaches to user-space probes
Message-ID: <20060328145441.GA25465@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060327065447.GA25745@in.ibm.com> <1143445068.2886.20.camel@laptopd505.fenrus.org> <20060327100019.GA30427@in.ibm.com> <1143489794.2886.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143489794.2886.43.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 10:03:14PM +0200, Arjan van de Ven wrote:
> On Mon, 2006-03-27 at 15:30 +0530, Prasanna S Panchamukhi wrote:
> > On Mon, Mar 27, 2006 at 09:37:48AM +0200, Arjan van de Ven wrote:
> > > On Mon, 2006-03-27 at 12:24 +0530, Prasanna S Panchamukhi wrote:
> > > 
> > > > - Low overhead and user can have thousands of active probes on the
> > > >   system and detect any instance when the probe was hit including
> > > >   probes on shared library etc.  > > > 
> > > I suspect this is the only reason for doing it inside the kernel;
> > > anything else still really shouts "do it in userspace via ptrace" to me.
> > > 
> > 
> > Other reasons would be:
> > 
> > - to view some privilaged data, such as system regs while you are
> >   debugging in user-space
> 
> root can do that anyway afaics
> 
> > - to view many arbitrary process address-space that use a common set
> >   of modules - user or kernel space
> 
> that's just a matter of userspace tooling.
> 
> > Yes, insertion of the breakpoint happens at the physical
> > page level and it gets written back to the disc.
> 
> at which point you get to deal with tripwire and other intrusion
> detection systems.... and you prevent doing this on binaries residing on
> read-only mounts (which isn't as uncommon as it sounds, read only
> shared /usr is quite common in enterprise)

Arjan,

The probes are inserted at physical page level and if the
executable is mmaped private, probes never gets written to the disk.
The physical page mmaped will still have probes in it. If the page in
the memory gets discarded due to the low-memory situation, then probes
will get inserted into that page when read in via readpage/s() hooks.
Only thing that will be written to the disk is the corresponding
inode, since we increment and decrement its i_writecount.

But, if we do a objdump on the probed executable, we are seeing the
breakpoints in the disassembly. We are looking into this issue.
Does this mean that breakpoints are written to the disk?

If the executable is mmaped shared, then those mappings will get written
back to the disk.

Writting to the disk is not the requirement for user-space probes, it is
just the side effect and probes are successful even if it is written or
not to the disk.

User-space probes are successful even if it is on "read-only" mounts, since
nothing is written back.

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
