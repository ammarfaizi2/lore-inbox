Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbSJCPM7>; Thu, 3 Oct 2002 11:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbSJCPM7>; Thu, 3 Oct 2002 11:12:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38410 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261511AbSJCPMz>; Thu, 3 Oct 2002 11:12:55 -0400
Date: Thu, 3 Oct 2002 16:18:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@digeo.com>, David Miller <davem@redhat.com>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH,RFC] Add gfp_mask to get_vm_area()
Message-ID: <20021003161816.I2304@flint.arm.linux.org.uk>
References: <20021001044226.GS10265@zax> <3D992DB0.9A8942D@digeo.com> <20021001053417.GW10265@zax> <20021003043948.GN1102@zax> <20021003045644.GO1102@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021003045644.GO1102@zax>; from david@gibson.dropbear.id.au on Thu, Oct 03, 2002 at 02:56:44PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 02:56:44PM +1000, David Gibson wrote:
> Blah.  It gets worse.  Making map_page() or remap_page_range()
> interrupt-safe would require making mm->page_table_lock irq-safe too
> :-(
> 
> Maybe non-coherent architectures should should pre-allocate a chunk of
> virtual memory for consistent allocations, and pre-allocate all its
> page tables.

There are a growing number of applications out there for ARM stuff where
this would be impractical.  Those wanting about 3GB of kernel space vs
1GB user space.

Doubling the virtual requirement for the SDRAM will make Linux unusable
in these situations, and then you'll have nice people from Intel and
Montavista banging on your door asking you why you killed their product
line.

The current situation on ARM works for 95% of cases.  If the choice is
between "95% working" and "cutting off the hand that feeds you" I'd
prefer the former.

On a more constructive note, I believe there is a way around the
mm->page_table_lock problem.  I believe we should completely split the
handling of the user space page tables from the kernel space page tables.

User space can carry on using mm->page_table_lock and be happy; it should
never ever touch the kernel page tables.

We then only have to worry about making things that touch the kernel page
tables irq-safe.  How many of those are there?  Two.  ioremap and vmalloc.
Neither of these two functions has any business touching anything other
than pid0's tables, and certainly has no business touching user space
page tables.  The problem is now far easier to deal with.

remap_page_range() shouldn't be a problem - its supposed to map pages
into user space, and if you're calling that from IRQ context, you're
doing something really wrong.

If I can get out of my current circle of never-ending problems and paid-
for work on other areas of ARM stuff, I might be able to look at this.
I've currently got an estimated backlog of one whole week on anything I
do atm.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

