Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbUKWXbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUKWXbc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbUKWX3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:29:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:16870 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261190AbUKWX1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:27:55 -0500
Date: Tue, 23 Nov 2004 15:31:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Campbell <icampbell@arcom.com>
Cc: nico@cam.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: "deadlock" between smc91x driver and link_watch
Message-Id: <20041123153158.6f20a7d7.akpm@osdl.org>
In-Reply-To: <1101230194.14370.12.camel@icampbell-debian>
References: <1101230194.14370.12.camel@icampbell-debian>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Campbell <icampbell@arcom.com> wrote:
>
> Hi,
> 
> I'm seeing a deadlock in linkwatch_event() when bringing down an
> Ethernet interface using the smc91x driver (drivers/net/smc91x.c).
> 
> What I am seeing is that smc_close() is calling netif_carrier_off which
> has the call chain:
> 	netif_carrier_off
> 	-> linkwatch_fire_event
> 	   -> schedule_work or schedule_delayed_work
> The function that is scheduled is linkwatch_event().
> 
> smc_close() then goes on to call flush_scheduled_work() in order to
> ensure that it's own pending workqueue stuff (smc_phy_configure()) is
> completed before powering down the PHY.
> 
> What I am seeing is that linkwatch_event() is deadlocking trying take
> rtnl_sem via rtnl_shlock(). The lock appears to already be held by a
> call to rtnl_lock() from devinet_ioctl().
> 
> Any ideas? Perhaps smc_phy_configure calls could just check that the
> interface is up before continuing, then there would be no need to flush
> the queue to get rid of it.
> 

linkwatch probably doesn't need the flush_scheduled_work(), because it
correctly does refcounting on the device.  Presumably that
flush_scheduled_work() in smc_close() is there to force out any pending
calls to smc_phy_configure().

One possible fix would be to remove that flush_scheduled_work() and to do
refcounting around smc_phy_configure(): dev_hold() when scheduling the work
(if schedule_work() returned true), dev_put() in the handler.

