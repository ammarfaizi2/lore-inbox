Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWGXRyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWGXRyH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWGXRyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:54:06 -0400
Received: from hera.kernel.org ([140.211.167.34]:22691 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932250AbWGXRyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:54:03 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Problems with sky2 driver.
Date: Mon, 24 Jul 2006 10:53:03 -0700
Organization: OSDL
Message-ID: <20060724105303.2c4d529f@localhost.localdomain>
References: <20060724133829.49bf7979@akemi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1153763612 18399 10.8.0.54 (24 Jul 2006 17:53:32 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 24 Jul 2006 17:53:32 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006 13:38:29 -0400
Todd Showalter <tshowalter@silverbirchstudios.com> wrote:

>     I've been having trouble with the sky2 driver.  It appears to work
> most of the time, but it will quite often wedge during transfers.  The
> 2.6.17.* kernels actually seem worse than 2.6.16.19, but none of them
> work perfectly.
> 
>     What typically happens is that after working perfectly for a while,
> existing net connections hang, and subsequent net connections don't
> seem to start at all.  firefox gets stuck with a bunch of half-loaded
> pages, for instance, and I've watched an scp of a large file to a
> colleague's machine stall and remain stalled.
> 
>     Once the machine is behaving this way, a reboot is the only way I
> have found of recovering it.
> 
>     We have two identical machines here that are both behaving this
> way, so I'm assuming it's not a hardware problem per se.  The machines
> are Intel Pentium D 940 (3GHz) processors.  They have ASUS P5LD2
> motherboards, with builtin Marvell PCIe 88E8053 gigabit ethernet
> controllers.
> 
>     I'm not running any binary modules; it's an untainted kernel.  I'm
> running a Gentoo system, but I'm using the vanilla-sources kernel (ie:
> a pure kernel.org release, not the Gentoo-specific patched version).
> 
>     What can I do to help solve this?


To find out where to report problems on a specific device, look in the
MAINTAINERS file. I developed and maintain that driver. 
Also, the mailing list for network drivers is netdev@vger.kernel.org

There is a receive problem that shows up under load, that is fixed
in the latest version (2.6.18 git), the patch is queued for the stable
tree as well.

--- sky2.orig/drivers/net/sky2.c	2006-07-17 06:02:27.000000000 -0700
+++ sky2/drivers/net/sky2.c	2006-07-17 06:06:56.000000000 -0700
@@ -50,7 +50,7 @@
 #include "sky2.h"
 
 #define DRV_NAME		"sky2"
-#define DRV_VERSION		"1.4"
+#define DRV_VERSION		"1.5"
 #define PFX			DRV_NAME " "
 
 /*
@@ -2204,9 +2204,6 @@
 	int work_done = 0;
 	u32 status = sky2_read32(hw, B0_Y2_SP_EISR);
 
-	if (!~status)
-		goto out;
-
 	if (status & Y2_IS_HW_ERR)
 		sky2_hw_intr(hw);
 
@@ -2243,7 +2240,7 @@
 
 	if (sky2_more_work(hw))
 		return 1;
-out:
+
 	netif_rx_complete(dev0);
 
 	sky2_read32(hw, B0_Y2_SP_LISR);
