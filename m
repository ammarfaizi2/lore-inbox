Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbVKOXfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbVKOXfM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVKOXfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:35:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:43150 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965074AbVKOXfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:35:10 -0500
Date: Tue, 15 Nov 2005 17:31:57 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>, Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: overlapping resources for platform devices?
Message-ID: <Pine.LNX.4.44.0511151727170.32393-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

I was wondering if there was any issue in changing platform_device_add to
use insert_resource instead of request_resource.  The reason for this
change is to handle several cases where we have device registers that
overlap that two different drivers are handling.

The biggest case of this is with ethernet on a number of PowerPC based 
systems where a subset of the ethernet controllers registers are used for 
MDIO/PHY bus control.  We currently hack around the limitation by having 
the MDIO/PHY bus not actually register an memory resource region.

If the following looks good I'll send a more formal patch.

-- kumar

--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -257,7 +257,7 @@ int platform_device_add(struct platform_
                                p = &ioport_resource;
                }
 
-               if (p && request_resource(p, r)) {
+               if (p && insert_resource(p, r)) {
                        printk(KERN_ERR
                               "%s: failed to claim resource %d\n",
                               pdev->dev.bus_id, i);


