Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTI2V6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbTI2V6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:58:20 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:44957 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S261957AbTI2V6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:58:18 -0400
Subject: 2.6.0-test6: a few __init bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: scottm@somanetworks.com, greg@kroah.com, rgooch@atnf.csiro.au,
       mingo@redhat.com, pavel@suse.cz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Sep 2003 14:58:12 -0700
Message-Id: <1064872693.5733.42.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are several places where non-__init functions call __init functions
or reference __init data.  I've looked at all of them and believe that
they are all either legitimate bugs or opportunities to declare more
code as __init to save memory.  Thanks for looking over these, and sorry
if I've made any mistakes.

Best,
Rob

P.S. All these bugs were found with Cqual, the bug-finding tool
developed by Jeff Foster, John Kodumal, and many others, and available
at http://www.cs.umd.edu/~jfoster/cqual/, although the currently
released version of cqual only has primitive support for 
__init bug-finding.

Linux 2.6.0-test6:

** Possible bug:
** drivers/pci/quirks.c:asus_hides_smbus_hostbridge()                  (__init)
   in table: drivers/pci/quirks.c:pci_fixups                           (not __init)
     indirect call f->hook(): drivers/pci/quirks.c:pci_do_fixups()     (not __init)
       called by: drivers/pci/quirks.c:pci_fixup_device()              (not __init)
         called by: drivers/pci/probe.c:pci_scan_slot()                (not __init)
           called by lots of hotplug enable() functions, e.g.
           drivers/pci/hotplug/ibmphp_core.c:ibm_configure_device()    (not __init)
             called by drivers/pci/hotplug/ibmphp_core.c:enable_slot() (not __init)

Note: It looks like this may have been originally designed to initialize the
      pci bus at startup, but has been re-used in the hotplug code, which means it 
      can be run after the __init segments have gone away.

Fix: Delete all the __init declarations on the quirks hooks.


** Code can be declared __init:
** arch/i386/kernel/cpu/mtrr/generic.c:get_fixed_ranges()              (__init)
     called by: arch/i386/kernel/cpu/mtrr/generic.c:get_mtrr_state()   (not __init)
       only caller: arch/i386/kernel/cpu/mtrr/main.c:init_other_cpus() (not __init)
         only caller: arch/i386/kernel/cpu/mtrr/main.c:mtrr_init()     (__init)
Fix: Declare get_mtrr_state()  __init
Fix: Declare init_other_cpus() __init


** Code can be declared __init:
** arch/i386/kernel/io_apic.c:io_apic_set_pci_routing() (not __init)
     all callers are __init
Fix: Declare io_apic_set_pci_routing() __init


** Code should be declared __init?
** name_to_dev_t()                                                     (__init)
     called by kernel/power/swsusp.c:read_suspend_image()              (not __init)
       called by kernel/power/swsusp.c:software_resume()               (not __init)
Fix: declare read_suspend_image() __init
Fix: declare software_resume() __init

Note: read_suspend_image() in pmdisk.c is declared __init.


