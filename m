Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311397AbSCTWLq>; Wed, 20 Mar 2002 17:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310295AbSCTWLf>; Wed, 20 Mar 2002 17:11:35 -0500
Received: from rzfoobar.is-asp.com ([217.11.194.155]:55499 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S310606AbSCTWLQ>;
	Wed, 20 Mar 2002 17:11:16 -0500
Message-ID: <3C990778.B22F70FF@isg.de>
Date: Wed, 20 Mar 2002 23:04:40 +0100
From: Stefan Rompf <srompf@isg.de>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: greearb@candelatech.com
Subject: Overrunning the netlink socket
Content-Type: multipart/mixed;
 boundary="------------2A2F30AD99BB0ABD22AEE6DB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2A2F30AD99BB0ABD22AEE6DB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

some weeks ago, I've written a module that allows forwarding link state
changes of network interfaces over the netlink socket. Recently I ran
into problems after I added support to the VLAN driver that the link
state of VLAN slave interfaces follow the master interface. My (slightly
tested) patch to the VLAN driver and the module code are attached.

I've attached 32 VLANs to an ethernet interface. After removing the
network cable, the interface driver called netif_carrier_off() (Note
that not many drivers support that, so you may not be able to repeat).
This caused my module to broadcast 32 state changes over the netlink
socket as I expected.

However, these messages cause every receiver, tested with both simple
"ip monitor" command and patched zebra daemon, to lose the first 10
messages due to an overflow in recvmsg(). Increasing
/proc/sys/net/core/rmem_* to 131072 helped for both, adding a
schedule()-call after every netdev_state_change() helped for the ip
command only, but is of course a very bad habit while holding the
rtnl_lock.

Now what looks strange to me is how 32 messages are able to overflow a
64K receive buffer. Anyone can enlighten me or give me a hint on where
to start searching & may be fixing?

Stefan
--------------2A2F30AD99BB0ABD22AEE6DB
Content-Type: text/plain; charset=us-ascii;
 name="dev_watch.c.old"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dev_watch.c.old"


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
		rtnl_lock();
		for (dev=dev_base; dev; dev = dev->next) {

			/* State of netif_carrier_ok() is reflected
			   into dev_flags by this loop, and a netlink
			   message is omitted whenever the state
			   changes */

			if (dev->flags & IFF_RUNNING) {
				if (!netif_carrier_ok(dev)) {
					write_lock(&dev_base_lock);
					dev->flags &= ~IFF_RUNNING;
					write_unlock(&dev_base_lock);
					netdev_state_change(dev);
				}
			} else {
				if (netif_carrier_ok(dev)) {
					write_lock(&dev_base_lock);
					dev->flags |= IFF_RUNNING;
					write_unlock(&dev_base_lock);
					netdev_state_change(dev);
				}
			}
		}
		rtnl_unlock();

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







--------------2A2F30AD99BB0ABD22AEE6DB
Content-Type: text/plain; charset=us-ascii;
 name="vlan-patch.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vlan-patch.c"

--- linux-2.4.17/net/8021q/vlan.c	Sat Jan 19 15:25:21 2002
+++ linux-2.4.17stefan/net/8021q/vlan.c	Tue Mar 19 22:35:46 2002
@@ -468,6 +468,23 @@
 	struct net_device *vlandev = NULL;
 
 	switch (event) {
+	case NETDEV_CHANGE:
+		for (grp = p802_1Q_vlan_list; grp != NULL; grp = grp->next) {
+			for (i = 0; i < VLAN_GROUP_ARRAY_LEN; i++) {
+                                vlandev = grp->vlan_devices[i];
+				if (vlandev && VLAN_DEV_INFO(vlandev)->real_dev == dev) {
+					if (netif_carrier_ok(vlandev) != netif_carrier_ok(dev)) {
+						if (netif_carrier_ok(dev)) {
+							netif_carrier_on(vlandev);
+						} else {
+							netif_carrier_off(vlandev);
+						}
+					}
+				}
+			}
+		}
+		break;
+	
 	case NETDEV_CHANGEADDR:
 		/* Ignore for now */
 		break;

--------------2A2F30AD99BB0ABD22AEE6DB--


