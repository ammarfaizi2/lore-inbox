Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbUKXROn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbUKXROn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUKXREC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:04:02 -0500
Received: from modemcable166.48-200-24.mc.videotron.ca ([24.200.48.166]:47258
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S262759AbUKXQ5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:57:55 -0500
Date: Wed, 24 Nov 2004 11:57:50 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Ian Campbell <icampbell@arcom.com>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: "deadlock" between smc91x driver and link_watch
In-Reply-To: <1101311558.31459.21.camel@icampbell-debian>
Message-ID: <Pine.LNX.4.61.0411241125280.8946@xanadu.home>
References: <1101230194.14370.12.camel@icampbell-debian> 
 <20041123153158.6f20a7d7.akpm@osdl.org>  <1101289309.10841.9.camel@icampbell-debian>
  <20041124014650.47af8ae4.akpm@osdl.org>  <1101290297.10841.15.camel@icampbell-debian>
  <Pine.LNX.4.61.0411241014160.8946@xanadu.home> <1101311558.31459.21.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004, Ian Campbell wrote:

> On Wed, 2004-11-24 at 10:21 -0500, Nicolas Pitre wrote:
> 
> > How do you ensure that smc_phy_configure() can't end up being called 
> > after smc_phy_powerdown() here?
> 
> Hmm, I think that smc_phy_configure() is only called from
> smc_drv_resume() and smc_timeout() (via the workqueue).

There is smc_open() as well, but only smc_timeout() is really 
problematic because of the schedule_work() call.

> The other solution might be to set phy_type to 0 in smc_phy_powerdown()
> and then redetect it in smc_open() and smc_resume(). Or just use another
> flag altogether.

Please make it another flag.  You could replace your dev_hold(dev) with 
lp->work_pending = 1 and dev_put() with lp->work_pending = 0, then 
adding a while (lp->work_pending) schedule() in place of the 
flush_scheduled_work().

And while you're at it, could you replace:

smc_phy_configure(void *data)

with

smc_phy_configure(struct net_device *dev)

The parameter doesn't have to be void *data anymore now that you 
introduced smc_phy_configure_wq().

And finally, please tell about the reason why flush_scheduled_work() 
can't be used in your comment.


Nicolas
