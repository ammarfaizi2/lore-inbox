Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVASIG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVASIG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVASIFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:05:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54719 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261641AbVASHdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:44 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/29] overview
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <overview-11061198973484@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew the following patchset is against 2.6.11-rc1-mm1 with
all of the kexec patches removed.  The list of removed patches
is included below.

This patchsset is a major refresh of the kexec on panic
functionality in the kernel.  The primary aim of which was to take
the requirements capture of the kernel crashdump patches and
start integrating the functionality cleanly into the kexec
patches.  

Major accomplishments:
- Compat syscall support has been added.
- The crashdump capture code has been separated from the kexec on panic code.
- The kernel to jump to on panic is now loaded in place.
- A long standing bug that allowed 2 sources pages to copy data
  to a single destination page has been caught and fixed.
- Support for loading an x86_64 kernel in a reserved of memory has been completed.

The crashdump code is currently slightly broken.  I have attempted to
minimize the breakage so things can quick be made to work again.

With respect to a final design discussion there are two remaining 
open issues.  The first is how little hardware shutdown we can get away
with in the kernel that is panicing.  I believe we can reduce this
to a simply NMI to the other cpus telling them to stop.  This has
been address as a major concern in previous conversations.

The second is an issue is the most significant with respect to the
design of a kernel based crash dump capture implementation.  How does
the crashdump capture process discover relevant information about the
kernel that just crashed?  There are two options.

1) As represented by the current crashdump patches the crashdump
   kernel and the kernel in which it loads are kept in sync so that
   it has uptodate versions all of crashed kernels data structures
   because it is built from the same source.  So it only needs to
   find the address of the data structures it would like to look at.

2) The relevant information if it is available when sys_kexec_load
   is called is exported to user space, or the machine_crash_shutdown
   method marshalls what little information must be captured when the
   machine dies in a well known standard format (most likely ELF
   notes).  Allowing the crashdump capture process to simply pass
   on the information or utilize it as appropriate.

   If the second method can successfully represent all of the
   interesting information then we can allow kernel version
   skew, between the two kernels, and potentially implement
   the entire crash dump capture process in user space.

As best as I have been able to discover the interesting information
includes.  The cpu state (registers) at the time of the crash/panic.
The list of memory regions the kernel that has crashed was using.
And potentially the list of pages dedicated to kernel data as opposed
to user space, so the the people with insane amounts of memory (1TB+)
don't require unmanagely large core files.


Andrew earlier when asked about the possibility of merghing the kexec
on panic code you said:

> I don't want us to be in a position of merging all that code and then
> finding out that it cannot be made to work "sufficiently well",
> forcing us to revert it and find a new crashdump solution.  You guys
> know far better than I when we will reach that threshold.  If the
> kexec/dump developers can say "yup, this is going to work (because X)"
> then I'm happy.

So here is my subjective view.
- This code needs to sit in a development tree for a little while 
  to shake out whatever bugs still linger from my massive refactoring.
- Through the kexec patches the code and design appears to be sound.
  Given that machine_kexec is little more than a jump there are few
  possible implementations that will be able to use it.  The only
  exception I can see are running special dump drivers from the kernel
  that crashed, and I believe no one thinks the that will work well.
- Once we finish sorting out the best way to get information out of
  the kernel that crashed I think we will have a complete architecture
  that is largely portable to any architecture.

In the interests of full disclosure my main interesting is using the
kernel as a bootloader for other kernels and that has been working 
fairly for years now :)

Eric



# Patches to remove from 2.6.11-rc1-mm1 before applying this patchset:
#
assign_irq_vector-section-fix.patch
kexec-i8259-shutdowni386.patch
kexec-i8259-shutdown-x86_64.patch
kexec-apic-virtwire-on-shutdowni386patch.patch
kexec-apic-virtwire-on-shutdownx86_64.patch
kexec-ioapic-virtwire-on-shutdowni386.patch
kexec-apic-virt-wire-fix.patch
kexec-ioapic-virtwire-on-shutdownx86_64.patch
kexec-e820-64bit.patch
kexec-kexec-generic.patch
kexec-ide-spindown-fix.patch
kexec-ifdef-cleanup.patch
kexec-machine_shutdownx86_64.patch
kexec-kexecx86_64.patch
kexec-kexecx86_64-4level-fix.patch
kexec-kexecx86_64-4level-fix-unfix.patch
kexec-machine_shutdowni386.patch
kexec-kexeci386.patch
kexec-use_mm.patch
kexec-loading-kernel-from-non-default-offset.patch
kexec-loading-kernel-from-non-default-offset-fix.patch
kexec-enabling-co-existence-of-normal-kexec-kernel-and-panic-kernel.patch
kexec-ppc-support.patch
#kexec-kexecppc.patch
#
crashdump-documentation.patch
crashdump-memory-preserving-reboot-using-kexec.patch
crashdump-memory-preserving-reboot-using-kexec-fix.patch
kdump-config_discontigmem-fix.patch
crashdump-routines-for-copying-dump-pages.patch
crashdump-routines-for-copying-dump-pages-kmap-fiddle.patch
crashdump-kmap-build-fix.patch
crashdump-register-snapshotting-before-kexec-boot.patch
crashdump-elf-format-dump-file-access.patch
crashdump-linear-raw-format-dump-file-access.patch
crashdump-minor-bug-fixes-to-kexec-crashdump-code.patch
crashdump-cleanups-to-the-kexec-based-crashdump-code.patch
#
x86-rename-apic_mode_exint.patch
x86-local-apic-fix.patch
#
