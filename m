Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264975AbTFYVoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbTFYVoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:44:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:47268 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264975AbTFYVo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:44:28 -0400
Date: Wed, 25 Jun 2003 14:58:35 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hotplug/PPP oddness n 2.5.73-mm1 - scripts not running, bad
 event
Message-Id: <20030625145835.14206ec7.shemminger@osdl.org>
In-Reply-To: <200306252028.h5PKSSnd002877@turing-police.cc.vt.edu>
References: <200306252028.h5PKSSnd002877@turing-police.cc.vt.edu>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003 16:28:28 -0400
Valdis.Kletnieks@vt.edu wrote:

> 
> http://linux-hotplug.sourceforge.net/?selected=net
> says that for 'NET' events, 'register' and 'unregister' are the actions.
> 
> Starting ppp, I get this:
> 
> Jun 25 10:50:22 turing-police /etc/hotplug/net.agent: NET add event not supported
> 
> 'NET add'?? WTF? ;)
> 
> (Fortunately, '/sbin/ifup ppp0' gets invoked anyhow, so it's not THAT crucial)
> 
> /Valdis (who still needs to fix hotplug not being called at all for the wireless card)
> 

Look in the mailing list archives:

> rom: Stephen Hemminger <shemminger@osdl.org>
> To: David S. Miller <davem@redhat.com>, Greg KH <greg@kroah.com>
> Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
> Subject: [PATCH] network hotplug via class_device/kobject
> Date: Fri, 13 Jun 2003 16:41:19 -0700
> Organization: Open Source Development Lab
> X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
> 
> This patch changes network devices to run hotplug out of the kobject/class_device
> infrastructure rather than calling it from the network core. The code gets simpler
> and there is only one place for Greg to fix when he changes the API ;-)
> 
> All hotplug now happens off the chain:
> 	rtnl_unlock -> netdev_run_todo -> netdev_sysfs_{un}register 
> 
> The state flag "deadbeaf" was convertied to a state enumeration to handle the
> necessary book keeping, and adds some defense against drivers that have unexpected
> semantics. Paranoid about some driver doing something like:
> 	rtnl_lock(); register_netdevice(); unregister_netdevice(); rtnl_unlock() BOOM
> 
> This patch causes an external script API change.
> Because network device go through the standard path, the action passed to the script
> is no longer register or unregister but is now "add" or "remove" like other devices.
> This is a good thing.  When testing (at least on RHAT) just change /etc/hotplug/net.agent
> case statement:
> 	
> case $ACTION in
> add|register)
>     # Don't do anything if the network is stopped
>     if [ ! -f /var/lock/subsys/network ]; then
> 	exit 0
>     fi
