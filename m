Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUAVS6e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266320AbUAVS6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:58:34 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:28944 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S266319AbUAVS6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:58:33 -0500
From: Terence Ripperda <tripperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Terence Ripperda <tripperda@nvidia.com>
Date: Thu, 22 Jan 2004 12:58:07 -0600
From: <tripperda@nvidia.com>
Subject: 2.6 agpgart and acpi standby/resume
Message-ID: <20040122185807.GD506@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when working on supporting the 2.6 kernel's acpi support, I ran into some issues on a Dell Inspiron 4100 notebook (w/ Intel Corp. 82830 830 Chipset Host Bridge) when resuming from standby. the basic problem was that agp configuration was lost in the host bridge's pci config space, causing dma problems with our chip.

I checked through the agpgart code (specifically the intel-agp.c driver) and saw that the driver did support acpi resume and attempted to reconfigure the chipset when resuming. but the problem is that the driver only does this if the bridge is using the generic or 845 driver. in my case, the 830mp driver was being used. I hacked in support for my driver and everything worked fine.

I'm curious why support was only added for 2 cases, instead of reconfiguring the chipset in every case. Is this because there were problems with some drivers, or is support added only on an "as-needed" basis?

(in this case, I happen to be testing with 2.6.0, but I see the same problem in the 2.6.1 code)

Thanks,
Terence

this fixed my problem:

--- intel-agp.c.orig    2004-01-22 12:51:31.000000000 -0600
+++ intel-agp.c 2004-01-22 12:51:20.000000000 -0600
@@ -1432,6 +1432,8 @@
                intel_configure();
        else if (bridge->driver == &intel_845_driver)
                intel_845_configure();
+       else if (bridge->driver == &intel_830mp_driver)
+               intel_830mp_configure();
 
        return 0;
 }
