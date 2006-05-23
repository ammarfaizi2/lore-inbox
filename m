Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWEWABN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWEWABN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 20:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWEWABN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 20:01:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:45756 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751320AbWEWABM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 20:01:12 -0400
Date: Tue, 23 May 2006 02:01:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Zachary Amsden <zach@vmware.com>, jakub@redhat.com,
       rusty@rustcorp.com.au, kraxel@suse.de, linux-kernel@vger.kernel.org
Subject: [patch 0/3] vdso: -V3
Message-ID: <20060523000111.GA9934@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is the third, reworked version of the VDSO randomization (and 
hypervisor-helping) patchset. In particular FC1 is booting now fine, via 
the CONFIG_COMPAT_VDSO (default=y) kernel option.

besides the security implications, this feature also helps debuggers, 
which can COW a vma-backed VDSO just like a normal DSO and can thus do 
single-stepping and other debugging features.

It's good for hypervisors (Xen, VMWare) too, which typically live in the 
same high-mapped address space as the VDSO, hence whenever the VDSO is 
used, they get lots of guest pagefaults and have to fix such guest 
accesses up - which slows things down instead of speeding things up (the 
primary purpose of the VDSO).

If the CONFIG_COMPAT_VDSO option is disabled then there is no 
(user-visible) high VDSO mapping, the VDSO resides in a low-mapped vma.

If the CONFIG_COMPAT_VDSO option is enabled then the VDSO is prelinked 
at kernel build time and is high-mapped to the usual 0xffffe000 address. 
The same page is also installed into a low vma - sharing all the 
codepath with the !compat code. Signal returns, sysexit returns and 
syscall addresses point to the low mapping - only the DSO metadata 
header (AT_SYSINFO_EHDR) points to the high address.

I have checked that the FC1 version of glibc (which is a pre-release 
2.3.2 glibc, i.e. pretty much the worst-case scenario in terms of VDSO 
relocation bugs) still works fine and the system boots up. Likewise, FC1 
still boots even if CONFIG_COMPAT_VDSO is disabled, if the vdso=0 boot 
option is specified.

I have also included a print-fatal-signals add-on patch: it will now 
print out the "/proc/*/maps" file of segfaulting processes - this was 
very helpful when debugging the VDSO patchset, and can be useful to 
debug other early-bootup application-crash problems too.

	Ingo
