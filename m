Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWHALBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWHALBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWHALBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:01:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56036 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932559AbWHALBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:01:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: [RFC] ELF Relocatable x86 and x86_64 bzImages
Date: Tue, 01 Aug 2006 04:58:49 -0600
Message-ID: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem:

We can't always run the kernel at 1MB or 2MB, and so people who need
different addresses must build multiple kernels.  The bzImage format
can't even represent loading a kernel at other than it's default address.
With kexec on panic now starting to be used by distros having a kernel
not running at the default load address is starting to become common.

The goal of this patch series is to build kernels that are relocatable
at run time, and to extend the bzImage format to make it capable of
expressing a relocatable kernel.

In extending the bzImage format I am replacing the existing unused bootsector
with an ELF header.  To express what is going on the ELF header will
have type ET_DYN.  Just like the kernel loading an ET_DYN executable
bootloaders are not expected to process relocations.  But the executable
may be shifted in the address space so long as it's alignment requirements
are met.

The x86_64 kernel is simply built to live at a fixed virtual address
and the boot page tables are relocated.  The i386 kernel is built
to process relocations generated with --embedded-relocs (after vmlinux.lds.S)
has been fixed up to sort out static and dynamic relocations.

Currently there are 33 patches in my tree to do this.

The weirdest symptom I have had so far is that page faults did not
trigger the early exception handler on x86_64 (instead I got a reboot).

There is one outstanding issue where I am probably requiring too much alignment
on the arch/i386 kernel.  

Can anyone find anything else?

Eric
