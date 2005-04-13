Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVDMP6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVDMP6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 11:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVDMP6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 11:58:05 -0400
Received: from alog0200.analogic.com ([208.224.220.215]:62651 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261377AbVDMP57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 11:57:59 -0400
Date: Wed, 13 Apr 2005 11:57:28 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Dave Jones <davej@redhat.com>
cc: Yuri Vilmanis <vilmanis@internode.on.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: EXPORT_SYMBOL_GPL for __symbol_get replacing EXPORT_SYMBOL for
 deprecated inter_module_get
In-Reply-To: <20050413145424.GA4797@redhat.com>
Message-ID: <Pine.LNX.4.61.0504131138570.13502@chaos.analogic.com>
References: <200504131855.00806.vilmanis@internode.on.net>
 <20050413145424.GA4797@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005, Dave Jones wrote:

> On Wed, Apr 13, 2005 at 06:55:00PM +0930, Yuri Vilmanis wrote:
>
> > The case in point for me is ATI's binary openGL accelerated drivers (fglrx) -
> > these used inter_module_get() to communicate with the agp gart module, for
> > obvious reasons - this AGP communication is essential to the functionality of
> > the driver. No, I don't like ATI only having closed-source drivers any more
> > than you, but given the extremely competetive nature of high end video card
> > sales, I can see why they want to do it this way.
> > ....
> > Am I take it to mean that no closed-source / binary-only driver may use AGP
> > acceleration in the future, including ones that have in the past?
>
> They can use the in-kernel GART driver just fine. Of course, they choose
> to take a bastardised version from some ancient tree, mangle it to
> all hell, strip off the GPL MODULE_VERSION, and weld it to their
> own driver, but that's their decision. Which is btw, whats partly
> causing your problem.  (They still would've needed to change some
> code, but the AGP side of the fence would be taken care of).
>
> 		Dave

As a practical matter, one can make or modify the source-code
of a driver to use any symbols available in System.map. One
can even make a "preloader" program that gets the right stuff
for the correct kernel, puts it into the module, then has
the standard module loader load it.

There is way too much effort being applied to hiding kernel
symbols. As long as you have the tools available to build
a kernel, you have the tools available to use any symbol.

Here is the kernel offset of 'sys_call_table' and 'sys_ni_syscall'

TABLE := $(shell grep sys_call_table /boot/System.map | cut -f1 -d' ')
NISYS := $(shell grep sys_ni_syscall /boot/System.map | cut -f1 -d' ')
DEFS   = -D__KERNEL__ -DMODULE -DMAJOR_NR=$(MAJR) -DCONFIG_SMP
DEFS  += -DMODNAME=$(NAME) -DTABLE=0x$(TABLE) -DNISYS=0x$(NISYS)

You just initialize your module pointers to these values and
you have access to these objects. Simple.

Although I haven't tried it, I think one can even borrow a
__mod_licensexxx by using /proc/kallsyms. The point being that
trying to prevent one from using existing kernel code in
kernel modules will, eventually, fail completely unless we
only get binaries with no source-code. Even in that case,
many symbols within /proc/kallsyms are useful.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
