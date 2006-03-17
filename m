Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752573AbWCQIVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbWCQIVm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 03:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbWCQIVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 03:21:39 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:10474 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752571AbWCQIVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 03:21:37 -0500
Date: Fri, 17 Mar 2006 17:20:12 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 000/017]Memory hotplug for new nodes v.4.
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060317161948.C637.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'll post newest patches for memory hotadd with pgdat allocation as V4.
This includes some of small fixes
  - Fix compile errors on config HOTADD /NO HOTADD, NUMA/non NUMA, etc.
  - Add/update some comments.
  - etc.

This patches are for 2.6.16-rc6-mm1.
I tested these patch on just Tiger4(ia64) with emulation now.
Unfortunately, x86-64 box which I can use has been busy in this week.
So, I couldn't make/test patch for it yet. :-(
But, probably, remain x86-64's issue is just making arch_register_node() to 
create sysfs file for new node like 17th patch.
When I can use it again, I'll make and test it.

Andrew-san.
Please apply.



---------------------------------------

This is memory hotadd code when new node is added.
In this patch, pgdat is allocated when new node is comming.
To initialize pgdat and zones, a set of patches are necessary.
  - to allcate and initialize pgdat, zone, zonelist.
  - to make new kswapd
  - to initialize node_data[] array (ia64)
  - to register sysfs file for new node.
  - to call memory_hotplug code from acpi container driver
    which receive ACPI's notification from firmware.

Ia64 big NUMA box needs this feature. I heard that x86-64 needs this too.
Powerpc might use some of this code.

Note:
 - kzalloc is used for pgdat allocation in this version.
   So, even if pgdat is allocated, it will be allocated on the other node.
   This is only to simplify patches a bit. :-P

-----------------------------
Followings are updates.


Updates from V3 to V4.
  - update for 2.6.16-rc6-mm1.
  - Fix compile errors against Hotadd/NoHotadd, NUMA/NonNUMA, etc.
  - Add/update some comments.
  - Some functions which can be static become static.
  - not call add_memory() for already exist memory at
    acpi_memory_enable_device()

Updates from V2 to V3.
  - update for 2.6.16-rc5-mm3.
  - The caller function of pgdat allcation and so on become common code.
  - Passing node id at add_memory().
  - build_zonelists() is called after that pages are onlined.
  - Updating NODE_DATA() for ia64 become simple and become 
    common code between booting and hotadd.
    (But other consideration will be necessary for hot-remove.)
  - kswapd is called by kthread_run().
  - finding node id by acpi use handle of its memory device.

Updates from V1 to V2.
  - update for 2.6.16-rc5-mm2.
  - not only ia64, This is tested on x86_64 with NUMA emulation too. :-)
  - wait_table_size() allcation is changed.
      - Take max size as much as possible.
      - Change using GFP_ATOMIC. It is inside of zone_init_lock.
        (Warining message of might_sleep() is very well.)
  - stop_machine_run(build_zonelists) is move to outside of lock.
  - pgdat_insert() is moved to generic code to be used by x86_64.
  - add decision of ZONE_DMA32 or ZONE_NORMAL to x86_64's add_memory().
  - Make a separated patch to change from __init to __meminit.
  - Fix some typo


-- 
Yasunori Goto 


