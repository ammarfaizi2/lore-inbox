Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266406AbSKZQK6>; Tue, 26 Nov 2002 11:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266407AbSKZQK6>; Tue, 26 Nov 2002 11:10:58 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:5326 "EHLO fed1mtao03.cox.net")
	by vger.kernel.org with ESMTP id <S266406AbSKZQK4>;
	Tue, 26 Nov 2002 11:10:56 -0500
Date: Tue, 26 Nov 2002 09:49:08 -0700
From: Matt Porter <porter@cox.net>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] 64-bit struct resource fields
Message-ID: <20021126094908.A23772@home.com>
References: <3DE2AE04.5030209@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DE2AE04.5030209@us.ibm.com>; from haveblue@us.ibm.com on Mon, Nov 25, 2002 at 03:11:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 03:11:00PM -0800, Dave Hansen wrote:
> We need some way to replicate the e820 tables for kexec.  This 
> modifies struct resource to use u64's for its start and end fields. 
> This way we can export the whole e820 table on PAE machines.
> 
> resource->flags seems to be used often to mask out things in 
> resource->start/end, so I think it needs to be u64 too.  But, Is it 
> all right to let things like pcibios_update_resource() truncate the 
> resource addresses like they do?
> 
> With my config, it has no more warnings than it did before.

I could make use of this on my PPC440 systems which have all I/O
(onboard and PCIX host bridge) above 4GB.  However, the patch
I have been playing with typedefs a phys_addr_t so that only
systems which are 32-bit/36-bit+ split like PAE ia32, AUxxxx (MIPS),
and PPC440 have to do long long manipulation.  If you explicitly
use u64 everywhere it forces all native 32-bit/32-bit systems to
do unnecessary long long manipulation.

In the past there has been quite a bit of resistance to even
introducing a physical address typedef due to some claims of
gcc not handling long longs very well [1].  I don't see how
having _everybody_ that is 32-bit native handle long longs is
going to be more acceptable but I could be surprised.

That said, I think when we have existence of systems that require
long long types and gcc is "buggy" in this respect, then using
a phys_addr_t is the lesser of two evils (even though everybody hates
typedefs).  We already have this type defined local to PPC because
it is necessary to cleanly handle ioremap and local page mapping
functionality.  going to u64 or phys_addr_t resources would be a
huge improvement on a horribly kludgy hack we use to crate the
most significant 32-bits for our 64-bit ioremaps.

BTW, since u64 is long long on 32-bit platforms and long on 64-bit
platforms, you will get warnings from every printk that dumps
resource infos.  My thought is to provide some macros to massage
resource values to strings for display.

[1] I get feedback from many people using the PPC440 port and have 
    yet to find any instances of gcc mishandling long longs. (though
    this is just anecdotal evidence).

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
