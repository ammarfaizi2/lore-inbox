Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTD3BYb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 21:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbTD3BYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 21:24:31 -0400
Received: from ns.suse.de ([213.95.15.193]:60687 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261686AbTD3BYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 21:24:30 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
References: <20030429155731.07811707.akpm@digeo.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Apr 2003 03:36:18 +0200
In-Reply-To: <20030429155731.07811707.akpm@digeo.com.suse.lists.linux.kernel>
Message-ID: <p73r87k3gx9.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found a new bad class of bugs (slowly working on fixing them, also
present in 2.4) 

Machine Check handlers use printk in an NMI like (ignoring cli) situation.
This can deadlock on the console or low level character driver (serial, vga) 
locks. Not all MCEs are fatal (e.g. corrected ECC errors) and the kernel
should be safely able to continue.

Need to buffer the printk in an atomic fashion (e.g. in a ring buffer managed
with cmpxchg) and cause an self IPI that triggers an interrupt after
the next sti. This is easy with x86/APIC mode, but difficult with PIC
(the 8259 supports it in theory, but it's not clear that all clones in various
chipsets do; also changing the programming may be risky). Fallback: pick it 
up with the next timer interrupt by adding a check there.

New entries for the x86-64 list
(actually I'm not sure they are all x86-64 specific, just that the
bug has been seen there)

- 32bit core dumps do not dump 32bit SSE data currently. they should
- AT_GID/AT_UID ELF environment vector contains crap currently
This breaks debugging of the shared linker for suid programs because
ld.so always thinks it is suid/not called by root and ignores environment
variables.
- NIS/ypbind breaks with an abort() in glibc. Only happens on 2.5, 2.4 
is fine.
- need /proc/kcore access for kernel mappings that are outside vmalloc
(in particular the kernel and the modules are special mappings on x86-64;
other architectures have the same problem) 
Best would be to put them in the vmalloc mappings list, but that requires
some more fixes in other code that uses it. Also /proc/kcore seems to have
some 64bit signedness bugs (patch for 2.4 exists) 

Generic item: 

- need to share the ioctl 32bit emulation handlers between ports. 
Pavel has a patch, but he's running into difficulties with merging it.

-Andi
