Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWHUDAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWHUDAw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 23:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWHUDAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 23:00:52 -0400
Received: from hera.kernel.org ([140.211.167.34]:1997 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932531AbWHUDAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 23:00:48 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: torvalds@osdl.org
Subject: [GIT PATCH] ACPI for 2.6.18-rc4
Date: Sun, 20 Aug 2006 23:02:34 -0400
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
References: <200606230437.50845.len.brown@intel.com>
In-Reply-To: <200606230437.50845.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608202302.35229.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This is a batch of low-risk patches that are appropriate for 2.6.18-final.
They have all been through -mm.

thanks!

-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.18/acpi-release-20060707-2.6.18-rc4.diff.gz

 MAINTAINERS                    |    6 
 arch/i386/kernel/acpi/boot.c   |    2 
 arch/i386/kernel/acpi/wakeup.S |    5 
 arch/ia64/kernel/acpi.c        |    2 
 drivers/acpi/ac.c              |    2 
 drivers/acpi/acpi_memhotplug.c |    8 
 drivers/acpi/battery.c         |    3 
 drivers/acpi/bus.c             |   11 -
 drivers/acpi/hotkey.c          |  281 ++++++++++++-----------------
 drivers/acpi/i2c_ec.c          |    2 
 drivers/acpi/osl.c             |   10 +
 drivers/acpi/sbs.c             |    3 
 drivers/acpi/scan.c            |   12 +
 drivers/acpi/utils.c           |    2 
 drivers/pci/hotplug/Kconfig    |    2 
 drivers/pci/quirks.c           |   57 +++++
 16 files changed, 229 insertions(+), 179 deletions(-)

through these commits:

Bjorn Helgaas:
      PCI: quirk to disable e100 interrupt if RESET failed to

Handle X:
      ACPI: hotkey.c fixes, fix for potential crash of hotkey.c

Jean Delvare:
      ACPI: fix kfree in i2c_ec error path

Kristen Carlson Accardi:
      ACPI: add Dock Station driver to MAINTAINERS file
      ACPIPHP: allow acpiphp to build without ACPI_DOCK

Len Brown:
      ACPI: restore some dmesg to DEBUG-only, ala 2.6.17
      ACPI: skip smart battery init when acpi=off
      ACPI: avoid irqrouter_resume might_sleep oops on resume from S4

Pavel Machek:
      ACPI: fix boot with acpi=off

Randy Dunlap:
      ACPI: handle firmware_register init errors
      ACPI: scan: handle kset/kobject errors
      ACPI: add message if firmware_register() init fails
      ACPI: verbose on kset/kobject_register errors

Starikovskiy, Alexey Y:
      ACPI: relax BAD_MADT_ENTRY check to allow LSAPIC variable length string UIDs

William Morrrow:
      ACPI: Handle BIOS that resumes from S3 to suspend routine rather than resume vector

Yasunori Goto:
      ACPI: memory hotplug: remove useless message at boot time

with this log:

commit da547d775fa9ba8d9dcaee7bc4e960540e2be576
Merge: ef7d1b2... 5b9c9bf... df6fd31... 4e6e650... 5672bde... 16a7474...
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 20 21:49:29 2006 -0400

    Merge trivial low-risk suspend hotkey bugzilla-5918 into release

commit df6fd31995cb2e38b2a7e94bc8f1559b8f55404e
Author: Starikovskiy, Alexey Y <alexey.y.starikovskiy@intel.com>
Date:   Fri Aug 18 11:23:00 2006 -0400

    ACPI: relax BAD_MADT_ENTRY check to allow LSAPIC variable length string UIDs
    
    ACPI 3.0 appended a variable length UID string to the LAPIC structure
    as part of support for > 256 processors.  So the BAD_MADT_ENTRY() sanity
    check can no longer compare for equality with a fixed structure length.
    
    Signed-off-by: Alexey Y Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d68909f4c3eee09c13d4e5c86512c6c075553dbd
Author: Len Brown <len.brown@intel.com>
Date:   Wed Aug 16 19:16:58 2006 -0400

    ACPI: avoid irqrouter_resume might_sleep oops on resume from S4
    
    __might_sleep+0x8e/0x93
    acpi_os_wait_semaphore+0x50/0xa3
    acpi_ut_acquire_mutex+0x28/0x6a
    acpi_ns_get_node+0x46/0x88
    acpi_ns_evaluate+0x2d/0xfc
    acpi_rs_set_srs_method_data+0xc5/0xe1
    acpi_set_current_resources+0x31/0x3f
    acpi_pci_link_set+0xfc/0x1a5
    irqrouter_resume+0x48/0x5f
    
    and
    
    __might_sleep+0x8e/0x93
    kmem_cache_alloc+0x2a/0x8f
    acpi_evaluate_integer+0x32/0x96
    acpi_bus_get_status+0x30/0x84
    acpi_pci_link_set+0x12a/0x1a5
    irqrouter_resume+0x48/0x5f
    
    http://bugzilla.kernel.org/show_bug.cgi?id=6810
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5672bde6355f2d12c49df1eec083d25afe489063
Author: Handle X <xhandle@gmail.com>
Date:   Mon Aug 14 22:37:27 2006 -0700

    ACPI: hotkey.c fixes, fix for potential crash of hotkey.c
    
    While going through the code, I found out some memory leaks and potential
    crashes in drivers/acpi/hotkey.c Please find the patch to fix them.
    
    This patch does the following,
    
    1. Fixes memory leaks in error paths of hotkey_write_config
    
    2. Fixes freeing unallocated pointers in the error paths of hotkey_write_config
    
    3. Uses a loop instead of linear searching for parsing the userspace
       input in get_params
    
    4. Uses array of char * instead of passing 4 pointer parameters
       explicitly into the init_{poll_}hotkey_* static functions
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Acked-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4e6e6504a4572dee3afcb0925ce92ad559e1e0db
Author: William Morrrow <william.morrow@amd.com>
Date:   Mon Aug 14 22:37:31 2006 -0700

    ACPI: Handle BIOS that resumes from S3 to suspend routine rather than resume vector
    
    A BIOS has been found that resumes from S3 to the routine that invoked suspend,
    ignoring the resume vector.  This appears to the OS as a failed S3 attempt.
    
    This same system suspend/resume's properly with Windows.
    
    It is possible to invoke the protected mode register restore routine (which
    would normally restore the sysenter registers) when the BIOS returns from
    S3.  This has no effect on a correctly running system and repairs the
    damage from the deviant BIOS.
    
    Signed-off-by: William Morrow <william.morrow@amd.com>
    Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b5240b32b9b2b75917c478d768191862a2b190cc
Author: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Date:   Wed Jul 26 13:32:00 2006 -0400

    ACPIPHP: allow acpiphp to build without ACPI_DOCK
    
    Change the build options for acpiphp so that it may build without being
    dependent on the ACPI_DOCK option, but yet does not allow the option of
    acpiphp being built-in when dock is built as a module.
    This does not change the previous patch for ACPI_IBM_DOCK Kconfig.
    
    For the following matrix of config options, I built an i386 kernel.
    
    Dock		acpiphp		should it build?	confirmed
    y		y		y			y
    y		n		y			y
    y		m		y			y
    m		y		no - acpiphp should	acpiphp was
    				     convert to m	converted to m
    m		n		y			y
    m		m		y			y
    n		y		y			y
    n		n		y			y
    n		m		y			y
    
    
    Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
    Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 07dd4855e7fffeb50565826e5e736509ee8f6129
Author: Yasunori Goto <y-goto@jp.fujitsu.com>
Date:   Mon Aug 14 22:37:32 2006 -0700

    ACPI: memory hotplug: remove useless message at boot time
    
    This is to remove noisy useless message at boot.  The message is a ton of
    "ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device"
    
    In my emulation, number of memory devices are not so many (only 6), but,
    this messages are displayed 114 times.
    
    It is showed by acpi_memory_register_notify_handler() which is called by
    acpi_walk_namespace().
    
    acpi_walk_namespace() parses all of ACPI's namespace and execute
    acpi_memory_register_notify_handler().  So, it is called for all of the
    device which is defined in namespace.  If the parsing device is not memory,
    acpi_memhotplug ignores it due to "no match" and will parse next device.
    This is normal route, not an exception.
    
    Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e9a315bcae3b9e0c54fb68ef90d0095956314480
Author: Randy Dunlap <rdunlap@xenotime.net>
Date:   Mon Aug 14 22:37:24 2006 -0700

    ACPI: verbose on kset/kobject_register errors
    
    Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7daef60721e03809c7e5f8aa8491df4190f6b56f
Author: Randy Dunlap <rdunlap@xenotime.net>
Date:   Mon Aug 14 22:37:24 2006 -0700

    ACPI: add message if firmware_register() init fails
    
    Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b20d2aeb0ad322cbe7fd9120acae6118231b17a3
Author: Len Brown <len.brown@intel.com>
Date:   Tue Aug 15 23:21:37 2006 -0400

    ACPI: skip smart battery init when acpi=off
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4d8316d5ea4dcf0bf15d8a06d539ed7c99e9cfbe
Author: Pavel Machek <pavel@ucw.cz>
Date:   Mon Aug 14 22:37:22 2006 -0700

    ACPI: fix boot with acpi=off
    
    Fix acpi_ac/battery boot with acpi=off
    
    Signed-off-by: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0ee6a17389ceef65f1a86c38872fa98f08489022
Author: Jean Delvare <khali@linux-fr.org>
Date:   Fri Aug 11 08:30:31 2006 +0200

    ACPI: fix kfree in i2c_ec error path
    
    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5b9c9bf6c92274a6eb74fc8f86586ab592a7a1ec
Author: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Date:   Wed Jul 26 13:59:00 2006 -0400

    ACPI: add Dock Station driver to MAINTAINERS file
    
    Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 16a74744231e57e354253567490ab9e4ccd2d605
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Wed Apr 5 08:47:00 2006 -0400

    PCI: quirk to disable e100 interrupt if RESET failed to
    
    Without this quirk, e100 can be pulling on a shared
    interrupt line when another device (eg. USB) loads,
    causing the interrupt to scream and get disabled.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5918
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9805cb76f7bcd3108e012270d9ef2fd8ea3bea55
Author: Len Brown <len.brown@intel.com>
Date:   Tue Jul 25 13:30:57 2006 -0400

    ACPI: restore some dmesg to DEBUG-only, ala 2.6.17
    
    The ACPI_EXCEPTION() patch enabled a bunch of messages to print
    even in the non-DEBUG kernel.  Need to change a couple back,
    and note that ACPI_EXCEPTION takes no \n, but ACPI_DEBUG_PRINT does.
    
    No context for object [%p]\n
    Device `[%s]' is not power manageable\n
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9b6d97b64eff08b368375efcf9c1d01eba582ea2
Author: Randy Dunlap <rdunlap@xenotime.net>
Date:   Wed Jul 12 02:08:00 2006 -0400

    ACPI: scan: handle kset/kobject errors
    
    Check and handle kset_register() and kobject_register() init errors.
    
    Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d568df84f987a9321c1f5826a6c8678ef2bb2b70
Author: Randy Dunlap <rdunlap@xenotime.net>
Date:   Wed Jul 12 01:47:00 2006 -0400

    ACPI: handle firmware_register init errors
    
    Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
    Signed-off-by: Len Brown <len.brown@intel.com>
