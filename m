Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTE0XGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTE0XGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:06:45 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:16885 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264436AbTE0XGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:06:42 -0400
Message-ID: <3ED3F21C.B3052C8C@us.ibm.com>
Date: Tue, 27 May 2003 16:17:48 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: LKML <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>,
       "Feldman, Scott" <scott.feldman@intel.com>, Greg KH <greg@kroah.com>,
       Jeff Garzik <jgarzik@pobox.com>, Phil Cayton <phil.cayton@intel.com>,
       Russell King <rmk@arm.linux.org.uk>,
       "David S. Miller" <davem@redhat.com>, shemminger@osdl.org,
       kenistoj@us.ibm.com
Subject: Re: [RFC] [PATCH] Net device error logging (revised)
References: <3ECF0F64.AAD25389@us.ibm.com> <200305240805.h4O85f9O009429@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> 
> On Fri, 23 May 2003 23:21:24 PDT, Jim Keniston said:
> 
> > - With Steve Hemminger's creation of the "net" device class a few days
> > ago, the network device's interface name is now sufficient to find the
> > information about the underlying device in sysfs (even without running
> > ethtool).  So these macros no longer log the device's driver name and
> > bus ID.
> 
> Is something *else* logging the driver name and bus ID?

Short answer: Not in Linux 2.5.70.

Long answer: Some folks in the LTC are designing an error-log analysis (ELA)
system that will have access to sysfs as well as the event stream coming out
of the kernel.  Once the network interface is registered with sysfs -- in
v2.5.70, it's via netdev_register_sysfs, as called from register_netdevice --
you can find the net_device's info in sysfs based on the interface name.
The aforementioned ELA system could then annotate the event record with the
desired additional data out of sysfs (including driver name and bus ID).

Before the net_device is registered (at least), you'd presumably want to log
the driver name and bus ID.  One obvious way to do this is to have the probe
function call dev_* macros instead of netdev_* until register_netdev runs.
Another way could be via netdev_*, if we made netdev_* smart enough to log
the driver name and bus ID if netdev->class_dev.class isn't set yet.

There's clearly a difference of opinion among various developers as to whether
logging the interface name alone is sufficient.  Either way, I think it's a
win to have the net_device's pointer (as opposed to its name, if you're lucky)
handy when logging info about the net device; and to have the message format
live in one spot (netdevice.h) rather than all over drivers/net.

> 
> Just because an interface is called 'eth2' when the message is logged
> doesn't mean it's still eth2 when you actually *read* the message.
> And no, you *can't* rely on finding the "renaming bus-ID to ethN" message
> in the logs - if the system is unstable the last bit of local logging may
> go bye-bye if not synced, and messages about network hardware problems are
> *very* prone to not making it to the syslog server (I wonder why? ;).
> 
> Been there, done that, it's not fun.  Almost swapped out the wrong eth1
> a *second* time before realizing what was really going on...
> 

Was the name slippage due to the intervention of an administrative utility?
Just curious.

Thanks.
Jim Keniston
IBM Linux Technology Center
