Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUJ3W5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUJ3W5O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbUJ3W4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:56:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:55011 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261415AbUJ3Wwm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:52:42 -0400
Date: Sat, 30 Oct 2004 15:52:58 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: kj <kernel-janitors@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-kjt1: ixgb_ethtool.c doesn't compile
Message-ID: <20041030225258.GA1697@us.ibm.com>
References: <20041024151241.GA1920@stro.at> <20041029235137.GG6677@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029235137.GG6677@stusta.de>
X-Operating-System: Linux 2.6.9 (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 01:51:37AM +0200, Adrian Bunk wrote:
> On Sun, Oct 24, 2004 at 05:12:41PM +0200, maximilian attems wrote:
> >...
> > splitted out 168 patches:
> > http://debian.stro.at/kjt/2.6.10-rc1-kjt1/split/
> 
> Could you provide a .tar.gz (or .tar.bz) of the splitted patches 
> (similar to how Andrew does for -mm)?
> 
> > thanks for feedback.
> > maks
> >...
> 
> msleep_interruptible-drivers_net_ixgb_ixgb_ethtool.patch doesn't 
> compile:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/net/ixgb/ixgb_ethtool.o
> drivers/net/ixgb/ixgb_ethtool.c: In function `ixgb_ethtool_led_blink':
> drivers/net/ixgb/ixgb_ethtool.c:407: error: `id' undeclared (first use in this function)
> drivers/net/ixgb/ixgb_ethtool.c:407: error: (Each undeclared identifier is reported only once
> drivers/net/ixgb/ixgb_ethtool.c:407: error: for each function it appears in.)
> make[3]: *** [drivers/net/ixgb/ixgb_ethtool.o] Error 1

Here's the corrected patch, thanks again for catching this Adrian:

Description: Uses msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-rc1-vanilla/drivers/net/ixgb/ixgb_ethtool.c	2004-10-30 15:33:27.000000000 -0700
+++ 2.6.10-rc1/drivers/net/ixgb/ixgb_ethtool.c	2004-10-30 15:49:43.000000000 -0700
@@ -31,6 +31,7 @@
 #include "ixgb.h"
 
 #include <asm/uaccess.h>
+#include <linux/delay.h>
 
 extern char ixgb_driver_name[];
 extern char ixgb_driver_version[];
@@ -402,11 +403,10 @@ ixgb_ethtool_led_blink(struct net_device
 
 	mod_timer(&adapter->blink_timer, jiffies);
 
-	set_current_state(TASK_INTERRUPTIBLE);
 	if (data)
-		schedule_timeout(data * HZ);
+		msleep_interruptible(data * 1000);
 	else
-		schedule_timeout(MAX_SCHEDULE_TIMEOUT);
+		msleep_interruptible(jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT));
 
 	del_timer_sync(&adapter->blink_timer);
 	ixgb_led_off(&adapter->hw);
