Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVBPW77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVBPW77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 17:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVBPW77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 17:59:59 -0500
Received: from dsl-210-15-250-66.NSW.netspace.net.au ([210.15.250.66]:15055
	"EHLO ptraci.internal.sensorynetworks.com") by vger.kernel.org
	with ESMTP id S262107AbVBPW7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 17:59:55 -0500
Date: Thu, 17 Feb 2005 09:59:32 +1100
From: Erik de Castro Lopo <erikd+lkml@sensorynetworks.com>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.10 : kernel BUG at mm/rmap.c:483!
Message-Id: <20050217095932.196c2f8b.erikd+lkml@sensorynetworks.com>
In-Reply-To: <Pine.LNX.4.61.0502160655330.16056@goblin.wat.veritas.com>
References: <20050216120752.4da9c36b.erik.de.castro.lopo@sensorynetworks.com>
	<Pine.LNX.4.61.0502160655330.16056@goblin.wat.veritas.com>
Organization: Sensory Networks
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2005 08:07:11 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> Yes, I believe /dev/mem handling on 2.4 and 2.6 is much the same,
> but the rmap.c BUG you're hitting in 2.6 had no equivalent in 2.4 -
> maybe the 2.4 case has actually been unsafe too, or maybe not.

OK, that makes sense.

> Though there have been other reports of this BUG, some remaining
> mysterious, some down to bad ram, your case is almost certainly
> due to mismatched PageReserved accounting.
> 
> mmap of /dev/mem only works usefully when the mapped pages are
> outside of ordinary ram, 

This is memory on a PCI card which is definitely not part of
ordinary ram.

> or temporarily marked PageReserved, normally by the relevant driver.
>
> I may be wrong, but I think it's fair to say that usually when
> there's to be cooperation between driver and user space of this
> kind, the driver would offer its own device and mmap entry point,
> user space would be mapping that rather than /dev/mem, and file

Since I wrote the driver, thats definitely a possibility.

> reference counting would avoid the possibility that driver clears
> PageReserved while the page is mapped.

Ahh, here's a clue. My driver uses ioremap_nocache() to get virtual
pointers to physical register/memory (addresses obtain using 
pci_resource_start etc) on the card and calls iounmap() when the 
driver is unloaded. However, while the driver is loaded, the user 
space program mmaps a superset of the same memory. Is it possible 
that this is screwing up the page accounting?

> Beyond this particular BUG, clearing PageReserved too soon is
> likely to lead to freeing an already freed page - noticed with
> a warning if the page is still free, but mayhem if by then reused.

The driver is very strict about mapping memory on load and
unmapping memory on unload. I'm pretty confident that this is
working correctly because the driver can be repeatedly loaded
and unloaded without errors. During normal operation, it does 
not fiddle with mmapping.

> Which is the driver involved?

Its a driver I wrote for a piece of hardware designed by the 
company I work for.

> Or, might the user space application be (arguably) at fault,
> mmap'ing an indeterminate uncontrolled area of /dev/mem, some
> pages of which may or may not be PageReserved at any instant?

Nope, very, very unlikely. My driver is not doing anything 
complicated with memory mapping and I know the user space code 
is reading the right memory location because the read data is 
valid.

Thanks Hugh. Your input was very helpful.

Erik
-- 
-------------------------------------------------------
[N] Erik de Castro Lopo, Senior Computer Engineer
[E] erik.de.castro.lopo@sensorynetworks.com
[W] http://www.sensorynetworks.com
[T] +61 2 83022726
[F] +61 2 94750316
[A] L6/140 William St, East Sydney NSW 2011, Australia
-------------------------------------------------------
A good debugger is no substitute for a good test suite.
