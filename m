Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264327AbTLEUD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 15:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTLEUD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 15:03:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53694 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264327AbTLEUDw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 15:03:52 -0500
Message-ID: <3FD0E498.8070703@pobox.com>
Date: Fri, 05 Dec 2003 15:03:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Keniston <jkenisto@us.ibm.com>
CC: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@oss.sgi.com>,
       Andrew Morton <akpm@osdl.org>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       Larry Kessler <kessler@us.ibm.com>,
       "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2.6.0-test11] Net device error logging
References: <3FD0E1FE.1D5B1883@us.ibm.com>
In-Reply-To: <3FD0E1FE.1D5B1883@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Keniston wrote:
> The enclosed patch implements the netdev_* error-logging macros for
> network drivers.  These macros have been discussed at length on the
> linux-kernel and linux-netdev lists.  With the v2.6.0-test6 version of
> these macros, we addressed all the issues that reviewers had raised.
> This is just an update for v2.6.0-test11.
> 
> As previously discussed, these macros are in demand now (e.g., for
> the e1000 driver) and have essentially no impact on drivers that
> don't use them.
> 
> RECAP (from previous posts):
> Calls to the netdev_* macros (netdev_printk and wrappers such as
> netdev_err) are intended to replace calls to printk in network device
> drivers.  These macros have the following characteristics:
> - Same format + args as the corresponding printk call.
> - Approximately the same amount of text as the corresponding printk call.
> - The first arg is a pointer to the net_device struct.
> - The second arg, which is a NETIF_MSG_* message level, can be used to
> implement verbosity control.
> - Standard message prefixes: verbose (interface name, driver name, bus ID)
> during probe, or just the interface name once the device is registered.
> - The current implementation just calls printk.  However, the netdev_*
> interface (and availability of the net_device pointer) opens the door
> for logging additional information (via printk, via evlog/netlink, etc.)
> as desired, with no change to driver code.
> 
> Examples:
>         netdev_err(netdev, RX_ERR, "No mem: dropped packet\n");
> logs a message such as the following if the NETIF_MSG_RX_ERR bit is set
> in netdev->msg_enable.
>         eth2: No mem: dropped packet
> 
>         netdev_fatal(netdev, PROBE, "The EEPROM Checksum Is Not Valid\n");
> or
>         netdev_err(netdev, ALL, "The EEPROM Checksum Is Not Valid\n");
> unconditionally logs a message such as:
>         eth%d (e1000 0000:00:03.0): The EEPROM Checksum Is Not Valid
> The message's prefix includes the driver name and bus ID because the
> message is logged at probe time, before netdev is registered.
> 
> SAMPLE DRIVERS
> As examples of how the netdev_* macros could be used, patches for the
> v2.6.0-test11 e100, e1000, and tg3 drivers are available on request.
> 
> LINUX v2.4 SUPPORT
> Since there is no v2.6-style struct device underlying the net_device,
> a v2.4.23-compatible version of netdev_printk would always log the
> interface name as the message prefix:
> 
> #define netdev_printk(sevlevel, netdev, msglevel, format, arg...)	\
> do {									\
> 	if (NETIF_MSG_##msglevel == NETIF_MSG_ALL			\
> 	    || (netdev->msg_enable & NETIF_MSG_##msglevel)) {		\
> 		printk(sevlevel "%s: " format , netdev->name , ## arg);	\
> 	}								\
> } while (0)


I discussed this a bit with David.  My personal feelings are that I 
prefer just leaving all the printk's as they are.  But Linus and GregKH 
have been accepting patches into other parts of the tree like this one, 
and logging additional already-computer-parsed information is probably 
not a bad thing long-term, so perhaps I've been being a bit of a Luddite 
on this issue.

It's definitely too late for 2.6.0-testX mainline merging, until Andrew 
(2.6) and Linus (2.7) re-open their respective trees, but a good first 
step would be for me to merge this into the net-drivers-2.5-exp queue.

	Jeff



