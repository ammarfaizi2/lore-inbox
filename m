Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUGQWe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUGQWe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUGQWe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:34:57 -0400
Received: from digitalimplant.org ([64.62.235.95]:10217 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262079AbUGQWeq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:34:46 -0400
Date: Sat, 17 Jul 2004 15:34:37 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [0/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there.

About a year ago, I became frustrated with the process of trying to merge
a bunch of cleanups that I had done to the swsusp (suspend-to-disk) code.
The reasons for this were numerous, but largely irrelevant at this point.
In an attempt to accelerate things, I forked the code, called it pmdisk,
and merged the cleanups. I had intended to merge the two, but circumstance
took another turn for the worst, and I was left with absolutely no time to
tend to it, leaving the net effect a major detriment to the overall
effort.

Forking the code was the wrong thing to do. I apologize to Pavel for
slighting him, and the users that are still left with a suspend-to-disk
implementation in limbo.

I've managed to shave off a bit of time, and have cut a set of patches
that merge the two, applicable against Linus's latest BK tree. No
functionality has been lost, and the cumulative benefit should be better
than the previous two efforts. The short summary of the patches follow
this email. The patches themselves are in seperate emails. I do not have a
publically accessible BK tree, but I can work on that if anyone desires
it.

In the end, these patches remove pmdisk from the kernel and clean up the
swsusp code base. The result is a single code base with greatly improved
code, that will hopefully help others underestand it better.

The swsusp code has also been integrated with the rest of the, albeit
small, Power Managment core. This removes a bit of code duplication, and
simplifies the main entry points a bit. The major benefit of this is that
swsusp does not depend on /proc/acpi/sleep or a modified sys_reboot()
system call to be present. It can be used by writing to /sys/power/state.
The other major plus is that it can leverage the real low-power states of
the platform (e.g. the ACPI S4 state), rather than always shutting the
machine down.

I've done a minimal amount of testing, as I am literally on my way out the
door Ottawa, but I have verified that it works on at least 1 Pentium-M
based laptop (a Compaq Evo N620c). I have not had a chance to port the
low-level changes to the x86-64 architecture. It's on the remaining TODO
list, along with writing a more formal explanation of the technical
changes for Documentation/

I'm interested to hear what people have to say about the patches and
encourage everyone to give them a try. [Though, considering many people
will be in Ottawa over the next week, I expect most feedback to come from
there.. ]

Thanks,


	Pat



Please pull from

	bk://kernel.bkbits.net:/home/mochel/linux-2.6-power

This will update the following files:

 arch/i386/power/pmdisk.S |   56 -
 kernel/power/pmdisk.c    |   35
 arch/i386/power/Makefile |    1
 arch/i386/power/pmdisk.S |    4
 arch/i386/power/swsusp.S |   78 --
 include/linux/suspend.h  |   20
 kernel/power/Kconfig     |   49 -
 kernel/power/Makefile    |    3
 kernel/power/disk.c      |   73 +
 kernel/power/main.c      |   15
 kernel/power/pmdisk.c    | 1321 ++---------------------------------
 kernel/power/power.h     |   23
 kernel/power/swsusp.c    | 1730 +++++++++++++++++++++++------------------------
 13 files changed, 1082 insertions(+), 2326 deletions(-)

through these ChangeSets:

<mochel@digitalimplant.org> (04/07/17 1.1867)
   [swsusp] Fix nasty typo.

<mochel@digitalimplant.org> (04/07/17 1.1866)
   [Power Mgmt] Merge swsusp entry points with the PM core.

   - Add {enable,disable}_nonboot_cpus() to prepare() and finish() in
     kernel/power/disk.c
   - Move swsusp __setup options there. Remove resume_status variable in favor
     of simpler 'noresume' variable, and check it in pm_resume().
   - Remove software_resume() from swsusp; rename pm_resume() to software_resume().
     The latter is considerably cleaner, and leverages the core code.
   - Move software_suspend() to kernel/power/main.c and shrink it down a
     wrapper that  takes pm_sem and calls pm_suspend_disk(), which does the
     same as the old software_suspend() did.
     This keeps the same entry points (via ACPI sleep and the reboot() syscall),
     but actually allows those to use the low-level power states of the system
     rather than always shutting off the system.
   - Remove now-unused functions from swsusp.

<mochel@digitalimplant.org> (04/07/17 1.1865)
   [swsusp] Remove unneeded suspend_pagedir_lock.

<mochel@digitalimplant.org> (04/07/17 1.1864)
   [Power Mgmt] Remove pmdisk.

   - Remove kernel/power/pmdisk.c.
   - Remove CONFIG_PM_STD config option.
   - Fix up Makefile.

<mochel@digitalimplant.org> (04/07/17 1.1863)
   [Power Mgmt] Make default partition config option part of swsusp.

   - Remove from pmdisk.
   - Remove pmdisk= command line option.

<mochel@digitalimplant.org> (04/07/17 1.1862)
   [Power Mgmt] Remove pmdisk_free()

   - Change name of free_suspend_pagedir() to swsusp_free().
   - Call from kernel/power/disk.c

<mochel@digitalimplant.org> (04/07/17 1.1861)
   [Power Mgmt] Merge pmdisk and swsusp write wrappers.

   - Merge suspend_save_image() from both into one.
   - Rename to swsusp_write().
   - Remove pmdisk_write().
   - Fixup call in kernel/power/disk.c and software_suspend().
   - Mark lock_swapdevices() static again.

<mochel@digitalimplant.org> (04/07/17 1.1860)
   [Power Mgmt] Merge pmdisk and swsusp read wrappers.

   - Merge pmdisk_read() and __read_suspend_image() and rename to swsusp_read()
   - Fix up call in kernel/power/disk.c to call new name.
   - Remove extra error checking from software_resume().

<mochel@digitalimplant.org> (04/07/17 1.1859)
   [Power Mgmt] Merge pmdisk and swsusp pagedir handling.

   This embodies the core of the swsusp->pmdisk cleanups. Instead of using the
   ->dummy variable at the end of each pagedir for a linked list of the page
   dirs, this uses a static array, which is kept in the empty space of the
   swsusp header.

   There are 768 entries, and could be scaled up based on the size of the page
   and the amount of room remaining. 768 should be enough anyway, since each
   entry is a swp_entry_t to a page-length array of pages. With larger systems
   and more memory come larger pages, so each page-sized array will
   automatically scale up.

   This replaces the read_suspend_image() and write_suspend_image() in swsusp
   with the much more concise pmdisk versions (not that big of change at this
   point) and fixes up the callers so software_resume() gets it right.

   Also, mark the helpers only used in swsusp as static again.

<mochel@digitalimplant.org> (04/07/17 1.1858)
   [Power Mgmt] Merge pmdisk and swsusp signature handling.

   - Move struct pmdisk_header definition to swsusp and change name to struct
     swsusp_header.
   - Statically allocate one (swsusp_header), and use it during mark_swapfiles()
     and when checking sig on resume.
   - Move check_sig() from pmdisk to swsusp.
   - Wrap with swsusp_verify(), and move check_header() there.
   - Fix up calls in pmdisk and swsusp.
   - Make new wrapper swsusp_close_swap() and call from write_suspend_image().
   - Look for swsusp_info info in swsusp_header.swsusp_info, instead of magic
     location at end of struct.

<mochel@digitalimplant.org> (04/07/17 1.1857)
   [swsusp] Fix nasty bug in calculating next address to read from.

   - The bio code already does this for us..

<mochel@digitalimplant.org> (04/07/17 1.1856)
   [Power Mgmt] Merge swsusp and pmdisk info headers.

   - Move definition of struct pmdsik_info to power.h and rename to struct
     swsusp_info.
   - Kill struct suspend_header.
   - Move helpers from pmdisk into swsusp: init_header(), dump_info(),
     write_header(), sanity_check(), check_header().
   - Fix up calls in pmdisk to call the right ones.
   - Clean up swsusp code to use helpers; delete duplicates.

<mochel@digitalimplant.org> (04/07/17 1.1855)
   [Power Mgmt] Merge pmdisk/swsusp image reading code.

   - Create swsusp_data_read() and call from read_suspend_image() in both
     swsusp and pmdisk.
   - Mark swsusp_pagedir_relocate() as static again.

<mochel@digitalimplant.org> (04/07/17 1.1854)
   [Power Mgmt] Consolidate pmdisk and swsusp early swap access.

   - Move bio helpers to swsusp.
   - Convert swsusp to use them, rathen buffer_heads.
   - Expose and fix up calls in pmdisk.
   - Clean up swsusp::read_suspend_image() a bit.

<mochel@digitalimplant.org> (04/07/17 1.1853)
   [Power Mgmt] Fix up call in kernel/power/disk.c to swsusp_suspend().

<mochel@digitalimplant.org> (04/07/17 1.1852)
   [Power Mgmt] Remove arch/i386/power/pmdisk.S

<mochel@digitalimplant.org> (04/07/17 1.1851)
   [Power Mgmt] Consolidate pmdisk and swsusp low-level handling.

   - Split do_magic into swsusp_arch_suspend() and swsusp_arch_resume().
   - Clean up based on pmdisk implementation
     - Only save registers we need to.
     - Use rep;movsl for copying, rather than doing each byte.
   - Create swsusp_suspend and swsusp_resume wrappers for calling the assmebly
     routines that:
     - Call {save,restore}_processor_state() in each.
     - Disable/enable interrupts in each.
   - Call swsusp_{suspend,restore} in software_{suspend,resume}
   - Kill all the do_magic_* functions.
   - Remove prototypes from linux/suspend.h
   - Remove similar pmdisk functions.
   - Update calls in kernel/power/disk.c to use swsusp versions.

<mochel@digitalimplant.org> (04/07/17 1.1850)
   [swsusp] Add helper suspend_finish, move common code there.

   - Move call out of assembly-callbacks and into software_suspend() after
     do_magic() returns.

<mochel@digitalimplant.org> (04/07/17 1.1849)
   [Power Mgmt] Consolidate page count/copy code of pmdisk and swsusp.

   - Split count_and_copy_data_pages() into count_data_pages() and
     copy_data_pages().
   - Move helper saveable() from pmdisk to swsusp, and update to work with
     page zones.
   - Get rid of uneeded defines in pmdisk.

<mochel@digitalimplant.org> (04/07/17 1.1848)
   [Power Mgmt] Consolidate code for allocating image pages in pmdisk and swsusp

   - Move helpers calc_order(), alloc_pagedir(), alloc_image_pages(),
     enough_free_mem(), and enough_swap() into swsusp.
   - Wrap them all with a new function - swsusp_alloc().
   - Fix up pmdisk to just call that.
   - Fix up suspend_prepare_image() to call that, instead of doing it inline.

<mochel@digitalimplant.org> (04/07/17 1.1847)
   [Power Mgmt] Merge first part of image writing code.

   - Introduce helpers to swsusp - swsusp_write_page(), swsusp_data_write() and
     swsusp_data_free().
   - Delete duplicate copies from pmdisk and fixup names in calls.
   - Clean up write_suspend_image() in swsusp and use the helpers.

<mochel@digitalimplant.org> (04/07/17 1.1846)
   [Power Mgmt] Share variables between pmdisk and swsusp.

   - In pmdisk, change pm_pagedir_nosave back to pagedir_nosave, and
     pmdisk_pages back to nr_copy_pages.
   - Mark them, and other page count/pagedir variables extern.
   - Make sure they're not static in swsusp.
   - Remove mention from include/linux/suspend.h, since no one else needs them.

<mochel@digitalimplant.org> (04/07/17 1.1845)
   [Power Mgmt] Remove more duplicate code from pmdisk.

   - Use read_swapfiles() in swsusp and rename to swsusp_swap_check().
   - Use lock_swapdevices() in swsusp and rename to swsusp_swap_lock().

<mochel@digitalimplant.org> (04/07/17 1.1844)
   [Power Mgmt] Remove duplicate relocate_pagedir() from pmdisk.

   - Expose and use version in swsusp.

<mochel@digitalimplant.org> (04/07/17 1.1843)
   [Power Mgmt] Make pmdisk dependent on swsusp.

