Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWJCMhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWJCMhy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 08:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWJCMhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 08:37:54 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:22977 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750807AbWJCMhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 08:37:53 -0400
Message-ID: <45225876.1080705@jp.fujitsu.com>
Date: Tue, 03 Oct 2006 21:32:54 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org,
       MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>,
       Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>,
       Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       shemminger@osdl.org, ak@suse.de, davem@davemloft.net
Subject: Re: The change "PCI: assign ioapic resource at hotplug" breaks my
 system
References: <adar6xqwsuw.fsf@cisco.com>
In-Reply-To: <adar6xqwsuw.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> The change "PCI: assign ioapic resource at hotplug" (commit
> 23186279658cea6d42a050400d3e79c56cb459b4 in Linus's tree) makes
> networking stop working on my system (SuperMicro H8QC8 with four
> dual-core Opteron 885 CPUs).  In particular, the on-board NIC stops
> working, probably because it gets assigned the wrong IRQ (225 in the
> non-working case, 217 in the working case)
> 
> With that patch applied, e1000 doesn't work.  Reverting just that
> patch (shown below) from Linus's latest tree fixes things for me.
> 
> Please let me know what other debug information might be useful.
> 

The cause of this problem might be an wrong assumption that the 'start'
member of resource structure for ioapic device has non-zero value if the
resources are assigned by firmware. The 'start' member of ioapic device
seems not to be set even though the resources were actually assigned to
ioapic devices by firmware.

I made a patch to fix this problem against 2.6.18-git18. This patch
checks command register instead of checking 'start' member to see if
the ioapic is already enabled by firmware. Unfortunately, I don't have
any system to reproduce this problem. Could you please try it and let
me know whether the problem is fixed? If the patch below fixes the
problem, I'll resend it with description and Signed-off-by.

Thanks,
Kenji Kaneshige

---
 drivers/pci/setup-bus.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.18-git18/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.18-git18.orig/drivers/pci/setup-bus.c	2006-10-03 13:26:49.000000000 +0900
+++ linux-2.6.18-git18/drivers/pci/setup-bus.c	2006-10-03 13:35:00.000000000 +0900
@@ -55,16 +55,16 @@
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 class = dev->class >> 8;
 
-		/* Don't touch classless devices or host bridges. */
+		/* Don't touch classless devices or host bridges or ioapics.  */
 		if (class == PCI_CLASS_NOT_DEFINED ||
 		    class == PCI_CLASS_BRIDGE_HOST)
 			continue;
 
-		/* Don't touch ioapics if it has the assigned resources. */
+		/* Don't touch ioapic devices already enabled by firmware */
 		if (class == PCI_CLASS_SYSTEM_PIC) {
-			res = &dev->resource[0];
-			if (res[0].start || res[1].start || res[2].start ||
-			    res[3].start || res[4].start || res[5].start)
+			u16 command;
+			pci_read_config_word(dev, PCI_COMMAND, &command);
+			if (command & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
 				continue;
 		}
 
