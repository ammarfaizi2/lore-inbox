Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSASPYi>; Sat, 19 Jan 2002 10:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286672AbSASPY3>; Sat, 19 Jan 2002 10:24:29 -0500
Received: from rzfoobar.is-asp.com ([217.11.194.155]:41103 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S286647AbSASPYY>;
	Sat, 19 Jan 2002 10:24:24 -0500
Message-ID: <3C498CC9.6FAED2AF@isg.de>
Date: Sat, 19 Jan 2002 16:12:09 +0100
From: Stefan Rompf <srompf@isg.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Interface operative status detection
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel-people,

while playing with the Zebra routing daemon, I realized that neither
Linux nor Zebra are capable of detecting the operative state of an
interface, f.e. the ethernet link beat. This is a major show stopper
against using Linux for "serious" IP routing.

While my Zebra patches still need some testing, I'd like to present my
ideas for Linux to the community and get some feedback if this is the
right way to go.

Under Unix systems, the flag IFF_UP represents the administrative state
of an interface, while IFF_RUNNING should be set whenever the driver is
convinced that it actually can send and receive data.

Currently, IFF_RUNNING in the net_device->flags is not used at all,
rtnetlink and query ioctls use netif_carrier_ok() that tests the
__LINK_STATE_NO_CARRIER bit in net_device->state. Looking back into the
LKML archives, the reason is that the flags element must not be changed
inside interrupts.

So what about the following idea: The network interface drivers use the
netif_carrier_on() and netif_carrier_off() functions to update their
interface card status (a bunch of drivers already do). To get this
information forwarded to user mode via netlink socket, we use a kernel
thread that goes through the device list, and everytime IFF_RUNNING
and netif_carrier_ok() differ, IFF_RUNNING is updated and a message is
sent via netlink.

Attached you'll find a patch against 2.4.17 for the tulip driver to
forward (again) link beat information for MII tranceivers and a small
kernel module for 2.4 that implements the kernel thread. Please forgive
the crude way of unloading, this is my first kernel hacking attempt
since 1.2 ;-)

If this is the right direction, I'll submit a more elegant patch for 2.5
in the next weeks.

Note that there is still sourcecode in drivers/net that plays with
IFF_RUNNING directly. As I don't own these cards, let me just list the
files so that the maintainers can have a look: bmac.c,
wan/lmc/lmc_main.c, wan/comx-proto-fr.c, tlan.c, eepro100.c,
au1000_eth.c, tokenring/ibmtr.c and bonding.c.



diff -urN -X dontdiff linux-2.4.17/drivers/net/tulip/21142.c linux-2.4.17stefan/drivers/net/tulip/21142.c
--- linux-2.4.17/drivers/net/tulip/21142.c	Fri Nov  9 22:45:35 2001
+++ linux-2.4.17stefan/drivers/net/tulip/21142.c	Sat Jan 19 15:28:57 2002
@@ -39,8 +39,12 @@
 		printk(KERN_INFO"%s: 21143 negotiation status %8.8x, %s.\n",
 			   dev->name, csr12, medianame[dev->if_port]);
 	if (tulip_media_cap[dev->if_port] & MediaIsMII) {
-		tulip_check_duplex(dev);
-		next_tick = 60*HZ;
+		if (tulip_check_duplex(dev) < 0) {
+			netif_carrier_off(dev);
+		} else {
+			netif_carrier_on(dev);
+		}
+		next_tick = 3*HZ;
 	} else if (tp->nwayset) {
 		/* Don't screw up a negotiated session! */
 		if (tulip_debug > 1)
diff -urN -X dontdiff linux-2.4.17/drivers/net/tulip/timer.c linux-2.4.17stefan/drivers/net/tulip/timer.c
--- linux-2.4.17/drivers/net/tulip/timer.c	Wed Jun 20 20:15:44 2001
+++ linux-2.4.17stefan/drivers/net/tulip/timer.c	Sat Jan 19 15:30:35 2002
@@ -137,10 +137,10 @@
 					       medianame[mleaf->media & MEDIA_MASK]);
 				if ((p[2] & 0x61) == 0x01)	/* Bogus Znyx board. */
 					goto actually_mii;
-				/* netif_carrier_on(dev); */
+				netif_carrier_on(dev);
 				break;
 			}
-			/* netif_carrier_off(dev); */
+			netif_carrier_off(dev);
 			if (tp->medialock)
 				break;
 	  select_next_media:
@@ -164,10 +164,11 @@
 		}
 		case 1:  case 3:		/* 21140, 21142 MII */
 		actually_mii:
-			if (tulip_check_duplex(dev) < 0)
-				{ /* netif_carrier_off(dev); */ }
-			else
-				{ /* netif_carrier_on(dev); */ }
+			if (tulip_check_duplex(dev) < 0) {
+				netif_carrier_off(dev);
+			} else {
+				netif_carrier_on(dev);
+			}
 			next_tick = 60*HZ;
 			break;
 		case 2:					/* 21142 serial block has no link beat. */



And the module source code dev_watch.c:

/* Linux network device status watcher

   (C) 2002 Stefan Rompf
   GPL Version 2 applies

   compile with something like
    gcc -c -DMODULE -D__KERNEL__ -O2 dev_watch.c
*/

#include <linux/sched.h>
#include <linux/config.h>
#include <linux/module.h>
#include <linux/netdevice.h>
#include <linux/if.h>
#include <linux/rtnetlink.h>

static volatile pid_t me;

static volatile int running = 1;

static int devwatcher(void *dummy)
{
        struct net_device *dev;
	
	daemonize();
	strcpy(current->comm, "devwatchd");

	while(running) {
		write_lock(&dev_base_lock);
		for (dev=dev_base; dev; dev = dev->next) {

			/* State of netif_carrier_ok() is reflected
			   into dev_flags by this loop, and a netlink
			   message is omitted whenever the state
			   changes */

			if (dev->flags & IFF_RUNNING) {
				if (!netif_carrier_ok(dev)) {
					dev->flags &= ~IFF_RUNNING;
					rtnl_lock();
					netdev_state_change(dev);
					rtnl_unlock();
				}
			} else {
				if (netif_carrier_ok(dev)) {
					dev->flags |= IFF_RUNNING;
					rtnl_lock();
					netdev_state_change(dev);
					rtnl_unlock();
				}
			}
		}
		write_unlock(&dev_base_lock);

		set_current_state(TASK_INTERRUPTIBLE);
		schedule_timeout(HZ);
	}
		

	me = 0;
	return 0;
}

static int __init devwatch_init(void) {
	me = kernel_thread(devwatcher, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);

	if (!me) return 1;

	return 0;
}


static void __exit devwatch_cleanup(void) {
	running = 0;
	while(me) schedule();
}


EXPORT_NO_SYMBOLS;

module_init(devwatch_init);
module_exit(devwatch_cleanup);




Cheers, Stefan

