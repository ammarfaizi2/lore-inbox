Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264124AbUFBUtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbUFBUtf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUFBUtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:49:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63626 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264124AbUFBUt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:49:29 -0400
Date: Wed, 2 Jun 2004 22:50:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040602205025.GA21555@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


we'd like to announce the availability of the following kernel patch:

     http://redhat.com/~mingo/nx-patches/nx-2.6.7-rc2-bk2-AE

which makes use of the 'NX' x86 feature pioneered in AMD64 CPUs and for
which support has also been announced by Intel. (other x86 CPU vendors,
Transmeta and VIA announced support as well. Windows support for NX has
also been announced by Microsoft, for their next service pack.) The NX
feature is also being marketed as 'Enhanced Virus Protection'. This
patch makes sure Linux has full support for this hardware feature on x86
too.

What does this patch do? The pagetable format of current x86 CPUs does
not have an 'execute' bit. This means that even if an application maps a
memory area without PROT_EXEC, the CPU will still allow code to be
executed in this memory. This property is often abused by exploits when
they manage to inject hostile code into this memory, for example via a
buffer overflow.

The NX feature changes this and adds a 'dont execute' bit to the PAE
pagetable format. But since the flag defaults to zero (for compatibility
reasons), all pages are executable by default and the kernel has to be
taught to make use of this bit.

If the NX feature is supported by the CPU then the patched kernel turns
on NX and it will enforce userspace executability constraints such as a
no-exec stack and no-exec mmap and data areas. This means less chance
for stack overflows and buffer-overflows to cause exploits.

furthermore, the patch also implements 'NX protection' for kernelspace
code: only the kernel code and modules are executable - so even
kernel-space overflows are harder (in some cases, impossible) to
exploit. Here is how kernel code that tries to execute off the stack is 
stopped:

 kernel tried to access NX-protected page - exploit attempt? (uid: 500)
 Unable to handle kernel paging request at virtual address f78d0f40
  printing eip:
 ...

The patch is based on a prototype NX patch written for 2.4 by Intel -
special thanks go to Suresh Siddha and Jun Nakajima @ Intel. The
existing NX support in the 64-bit x86_64 kernels has been written by
Andi Kleen and this patch is modeled after his code.

Arjan van de Ven has also provided lots of feedback and he has
integrated the patch into the Fedora Core 2 kernel. Test rpms are
available for download at:

    http://redhat.com/~arjanv/2.6/RPMS.kernel/

the kernel-2.6.6-1.411 rpms have the NX patch applied.

here's a quickstart to recompile the vanilla kernel from source with the
NX patch:

    http://redhat.com/~mingo/nx-patches/QuickStart-NX.txt

	Ingo
