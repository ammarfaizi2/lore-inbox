Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUHDNJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUHDNJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUHDNJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:09:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6862 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265207AbUHDNJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:09:23 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-ia64@vger.kernel.org,
       fastboot@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [BROKEN PATCH] kexec for ia64
References: <200407261524.40804.jbarnes@engr.sgi.com>
	<200407261536.05133.jbarnes@engr.sgi.com>
	<20040730155504.2a51b1fa.rddunlap@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Aug 2004 07:07:04 -0600
In-Reply-To: <20040730155504.2a51b1fa.rddunlap@osdl.org>
Message-ID: <m18ycvhx1j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> On Mon, 26 Jul 2004 15:36:05 -0700 Jesse Barnes wrote:
> 
> | On Monday, July 26, 2004 3:24 pm, Jesse Barnes wrote:
> | >   o userspace tools need ia64 support

Correct.  But all they need are the ia64 bits of the ELF loader,
plus ia64 specific goo.  The generic part of the ELF loader is already
written.

> | >   o need to deal with in-flight DMA (see FIXME in machine_kexec)
> | 
> | After looking at it a little more, I suppose device_shutdown() should 
> | theoretically deal with this.
> | 
> | Also, it would be nice if there were a Documentation/kexec.txt or something in
> 
> | the full patch that describes all the pieces and what the arch dependent 
> | functions are responsible for.  Randy, do you have anything like that written
> 
> | up somewhere that you could include in the next spin of the patch?
> 
> Nope, sorry, I don't have anything like that.
> 
> Eric, do you have anything like Jesse asked about (arch-dependent
> requirements)?

Sort of fundamentally they are arch dependent.  

I believe that DMA FIXME is a red hearing.  Initially that patch
was targeted for a kernel without device_shutdown(), so I was
likely considering the old trick of running through all of the PCI
devices and disabling their bus master bit.

In general there are two arch specific pieces of information here.

1) What is the kernel's argument passing format, what arguments
   does the kernel need, and how do you derive those arguments
   from a running kernel.

   Usually this is at least the kernels memory map.  But the binary
   arguments a kernel accepts/requires vary widely from architecture
   to architecture. 

(This is user space only)

2) The code itself in machine_kexec.c and relocate_kernel.S needs
   to place the machine in a state where virtual and physical addresses
   are identity mapped.  And the arch specific registers are in some
   well defined state.  Usually the least setup you can guarantee to make
   it work the better.  

(This is the kernel side)

We should probably start capturing these pieces of information in
a kexec.3 man page.  Volunteers?

For ia64 in particular I believe the binary arguments are the
FPSWA and EFI memory map, and the firmware entry points (PAL and SAL
and EFI).

As for the physical mode transition state.  I believe that
is largely defined by the current set of kernel bootloaders.

Eric
