Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWJBRGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWJBRGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbWJBRGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:06:19 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:44590 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S965091AbWJBRGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:06:18 -0400
X-IronPort-AV: i="4.09,245,1157353200"; 
   d="scan'208"; a="1856175752:sNHT64640176"
To: linux-kernel@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>,
       Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>,
       Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: The change "PCI: assign ioapic resource at hotplug" breaks my system
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 02 Oct 2006 10:05:43 -0700
Message-ID: <adar6xqwsuw.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Oct 2006 17:05:44.0817 (UTC) FILETIME=[FFAA8E10:01C6E644]
Authentication-Results: sj-dkim-7.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The change "PCI: assign ioapic resource at hotplug" (commit
23186279658cea6d42a050400d3e79c56cb459b4 in Linus's tree) makes
networking stop working on my system (SuperMicro H8QC8 with four
dual-core Opteron 885 CPUs).  In particular, the on-board NIC stops
working, probably because it gets assigned the wrong IRQ (225 in the
non-working case, 217 in the working case)

With that patch applied, e1000 doesn't work.  Reverting just that
patch (shown below) from Linus's latest tree fixes things for me.

Please let me know what other debug information might be useful.

Thanks,
  Roland

Here's the patch I revert.  I'm not sure what it's trying to do, or
why it breaks my systems.  But anyway, reverting this fixes things for
me:

Author: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
Date:   Tue Sep 12 10:21:44 2006 -0700

    PCI: assign ioapic resource at hotplug
    
    We need to assign resources to ioapics being hot-added. This patch
    changes pbus_assign_resources_sorted() to assign resources if the
    ioapic has no assigned resources.
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
    Signed-off-by: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
    Signed-off-by: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
    Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 47c1071..5440491 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -55,12 +55,19 @@ pbus_assign_resources_sorted(struct pci_
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 class = dev->class >> 8;
 
-		/* Don't touch classless devices or host bridges or ioapics.  */
+		/* Don't touch classless devices or host bridges. */
 		if (class == PCI_CLASS_NOT_DEFINED ||
-		    class == PCI_CLASS_BRIDGE_HOST ||
-		    class == PCI_CLASS_SYSTEM_PIC)
+		    class == PCI_CLASS_BRIDGE_HOST)
 			continue;
 
+		/* Don't touch ioapics if it has the assigned resources. */
+		if (class == PCI_CLASS_SYSTEM_PIC) {
+			res = &dev->resource[0];
+			if (res[0].start || res[1].start || res[2].start ||
+			    res[3].start || res[4].start || res[5].start)
+				continue;
+		}
+
 		pdev_sort_resources(dev, &head);
 	}

