Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWCHNlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWCHNlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWCHNlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:41:09 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:51353 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751081AbWCHNlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:41:07 -0500
Date: Wed, 08 Mar 2006 22:41:03 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH: 000/017] (RFC)Memory hotplug for new nodes v.3.
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, linux-ia64@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060308212316.0022.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'll post newest patches for memory hotadd with pgdat allocation as V3.
There are many changes to make more common code.

This may be too many patches, but I would like to show
total feature of this code now.

This patches are for 2.6.16-rc5-mm3.
I tested these patch on just Tiger4(ia64) with emulation now.
But, I'll test them for x86-64 too after this post.

Please comment.

---------------------------------------

This is memory hotadd code when new node is added.
In this patch, pgdat is allocated when new node is comming.
To initialize pgdat and zones, a set of patches are necessary.
  - to allcate and initialize pgdat, zone, zonelist.
  - to make new kswapd
  - to initialize node_data[] array (ia64)
  - to register sysfs file for new node.
  - to call memory_hotplug code from acpi container driver.

Note:
 - kzalloc is used for pgdat allocation in this version.
   So, even if pgdat is allocated, it will be allocated on the other node.
   This is only to simplify patches a bit. :-P

-----------------------------
Followings are updates.

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
  - 

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


