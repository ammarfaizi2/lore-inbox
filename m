Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbUKWRpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUKWRpT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbUKWRou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:44:50 -0500
Received: from webapps.arcom.com ([194.200.159.168]:18698 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261384AbUKWRQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:16:36 -0500
Subject: "deadlock" between smc91x driver and link_watch
From: Ian Campbell <icampbell@arcom.com>
To: Nicolas Pitre <nico@cam.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Tue, 23 Nov 2004 17:16:34 +0000
Message-Id: <1101230194.14370.12.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Nov 2004 17:18:08.0640 (UTC) FILETIME=[66F27000:01C4D180]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing a deadlock in linkwatch_event() when bringing down an
Ethernet interface using the smc91x driver (drivers/net/smc91x.c).

What I am seeing is that smc_close() is calling netif_carrier_off which
has the call chain:
	netif_carrier_off
	-> linkwatch_fire_event
	   -> schedule_work or schedule_delayed_work
The function that is scheduled is linkwatch_event().

smc_close() then goes on to call flush_scheduled_work() in order to
ensure that it's own pending workqueue stuff (smc_phy_configure()) is
completed before powering down the PHY.

What I am seeing is that linkwatch_event() is deadlocking trying take
rtnl_sem via rtnl_shlock(). The lock appears to already be held by a
call to rtnl_lock() from devinet_ioctl().

Any ideas? Perhaps smc_phy_configure calls could just check that the
interface is up before continuing, then there would be no need to flush
the queue to get rid of it.

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200

