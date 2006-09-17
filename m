Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWIQRWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWIQRWP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 13:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWIQRWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 13:22:15 -0400
Received: from xenotime.net ([66.160.160.81]:64657 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965022AbWIQRWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 13:22:14 -0400
Date: Sun, 17 Sep 2006 10:23:12 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Samuel Tardieu <sam@rfc1149.net>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [RFC-patch 1/3] SuperIO locks coordinator
Message-Id: <20060917102312.35995be6.rdunlap@xenotime.net>
In-Reply-To: <450900FF.7000603@gmail.com>
References: <87fyf5jnkj.fsf@willow.rfc1149.net>
	<1157815525.6877.43.camel@localhost.localdomain>
	<20060909220256.d4486a4f.vsu@altlinux.ru>
	<4508FF2F.5020504@gmail.com>
	<450900FF.7000603@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006 01:13:03 -0600 Jim Cromie wrote:

> diff -ruNp -X dontdiff -X exclude-diffs 6locks-1/drivers/isa/Kconfig 6locks-2/drivers/isa/Kconfig
> --- 6locks-1/drivers/isa/Kconfig	1969-12-31 17:00:00.000000000 -0700
> +++ 6locks-2/drivers/isa/Kconfig	2006-09-13 09:54:18.000000000 -0600
> @@ -0,0 +1,7 @@
> +
> +config SUPERIO_LOCKS
> +	tristate "Super-IO port sharing"
> +	help
> +	  this module provides locks for use by drivers which need to

          This

> +	  share access to a multi-function device via its superio port, 
> +	  and which register that port.

> diff -ruNp -X dontdiff -X exclude-diffs 6locks-1/drivers/isa/superio_locks.c 6locks-2/drivers/isa/superio_locks.c
> --- 6locks-1/drivers/isa/superio_locks.c	1969-12-31 17:00:00.000000000 -0700
> +++ 6locks-2/drivers/isa/superio_locks.c	2006-09-13 14:56:32.000000000 -0600
> @@ -0,0 +1,169 @@
> +
> +/**
> +   module provides a means for modules to register their use of a
> +   Super-IO port, and provides an access-lock for the registering
> +   modules to use to coordinate with each other.  Consider it a
> +   parking-attendant's key-board.  Design is perhaps ISA centric,
> +   maybe formalize this, with (platform|isa)_driver.
> +*/

Two comments about that comment:

a.  Kernel long-comment style is:

/*
 * This module provides a means for modules to register
 * their use of a Super-IO port, ...
 */

b.  Don't use "/**" to begin a comment block unless the comment block
contains kernel-doc formatted comments.  (This one does not.)


> +
> +/* superio_get() checks whether the expected SuperIO device is
> +   present at a specific cmd-addr.  Use in loop to scan.
> +*/

For functions that are not static (and when you want this merged,
not just RFC), please include kernel-doc comments describing the
function and its parameters.  See Documentation/kernel-doc-nano-HOWTO.txt
for more info.

> +struct superio* superio_get(u16 cmd_addr, u8 dev_id_addr,
> +			    u8 want_devid)
> +{
> +	int slot, rc, mydevid;
> +
> +	mutex_lock(&reservation_lock);
> +
> +	/* share any already allocated lock for this cmd_addr, device-id */
> +	for (slot = 0; slot < max_locks; slot++) {
> +		if (sio_locks[slot].users 
> +		    && cmd_addr == sio_locks[slot].sioaddr
> +		    && want_devid == sio_locks[slot].devid) {
> +
> +			if (sio_locks[slot].users == 255) {
> +				dprintk("too many drivers sharing port %x\n", cmd_addr);
> +				mutex_unlock(&reservation_lock);
> +				return 0;
> +			}
> +			sio_locks[slot].users++;
> +			dprintk("sharing port:%x dev:%x users:%d\n",
> +				cmd_addr, want_devid, sio_locks[slot].users);
> +			mutex_unlock(&reservation_lock);
> +			return &sio_locks[slot];
> +		}
> +	}
> +	/* read the device-id-address */
> +	outb(dev_id_addr, cmd_addr);
> +	mydevid = inb(cmd_addr+1);
> +
> +	/* but 1st, check that the cmd register remembers the val just written */
> +	rc = inb(cmd_addr);
> +	if (rc != dev_id_addr) {
> +		dprintk("superio_cmdaddr %x absent %d\n", cmd_addr, rc);
> +		mutex_unlock(&reservation_lock);
> +		return NULL;
> +	}
> +	/* test for the desired device id value */
> +	if (mydevid != want_devid) {
> +		mutex_unlock(&reservation_lock);
> +		return NULL;
> +	}
> +	/* find 1st unused slot */
> +	for (slot = 0; slot < max_locks; slot++)
> +		if (!sio_locks[slot].users)
> +			break;
> +
> +	if (slot >= max_locks) {
> +		printk(KERN_ERR "No superio-locks left. increase max_locks\n");
> +		mutex_unlock(&reservation_lock);
> +		return NULL;
> +	}
> +	dprintk("allocating slot %d, addr %x for device %x\n",
> +		slot, cmd_addr, want_devid);
> +
> +	sio_locks[slot].sioaddr = cmd_addr;
> +	sio_locks[slot].devid = want_devid;
> +	sio_locks[slot].users = 1;
> +	num_locks++;
> +
> +	mutex_unlock(&reservation_lock);
> +	return &sio_locks[slot];
> +}
> +EXPORT_SYMBOL_GPL(superio_get);
> +
> +/* array args must be null terminated */

Also needs kernel-doc function comment header.

> +struct superio* superio_find(u16 cmd_addrs[], u8 devid_addr,
> +			     u8 want_devids[])
> +{
> +	int i, j;
> +	struct superio* gate;
> +
> +	for (i = 0; cmd_addrs[i]; i++) {
> +		for (j = 0; want_devids[j]; j++) {
> +			gate = superio_get(cmd_addrs[i], devid_addr,
> +					   want_devids[j]);
> +			if (gate) {
> +				dprintk("found devid:%x port:%x\n",
> +					want_devids[j], cmd_addrs[i]);
> +				return gate;
> +			} else
> +				dprintk("no devid:%x at port:%x\n",
> +					want_devids[j], cmd_addrs[i]);
> +		}
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(superio_find);
> +
> +void superio_release(struct superio* const gate)

Ditto.

> +{
> +	if (gate < &sio_locks[0] || gate >= &sio_locks[max_locks]) {
> +		printk(KERN_ERR
> +		       " superio: attempt to release corrupted superio-lock"
> +		       " %p vs %p\n", gate, &sio_locks);
> +		return;
> +	}
> +	if (!(--gate->users))
> +		dprintk("releasing last user of superio-port %x\n", gate->sioaddr);
> +	return;
> +}
> +EXPORT_SYMBOL_GPL(superio_release);
> +

> diff -ruNp -X dontdiff -X exclude-diffs 6locks-1/include/linux/superio-locks.h 6locks-2/include/linux/superio-locks.h
> --- 6locks-1/include/linux/superio-locks.h	1969-12-31 17:00:00.000000000 -0700
> +++ 6locks-2/include/linux/superio-locks.h	2006-09-13 14:21:08.000000000 -0600
> @@ -0,0 +1,55 @@
> +#include <linux/mutex.h>
> +#include <asm/io.h>
> +
> +/* Super-IO ports are found in low-pin-count hardware (typically ISA,
> +   any others ?).  They usually provide access to many functional
> +   units, so many drivers must share the superio port.  This struct
> +   provides a lock that allows the drivers to coordinate access to that
> +   port.
> +*/

Use long-comment style, please.

> +struct superio {
> +	struct mutex lock;	/* lock shared amongst user drivers */
> +	u16 sioaddr;		/* port's tested cmd-address */
> +	u8 devid;		/* devid found by the registering driver */
> +	u8 users;		/* I cant imagine >256 user drivers */
> +};
> +
> +/* array args must be null terminated */
> +struct superio* superio_find(u16 sioaddrs[], u8 devid_addr, u8 devid_vals[]);
> +struct superio* superio_get(u16 sioaddr, u8 devid_addr, u8 devid_val);
> +void superio_release(struct superio* const gate);
> +
> +/* these locking ops do not address the idling & activation of some
> +   superio devices, which will, once 'locked', ignore accesses until
> +   the 'unlock' sequence is done 1st.  Unfortunately these sequences
> +   vary by device, and in any case don't protect 2 drivers from
> +   stepping on each other's operations.
> +
> +   Callbacks are a possible approach, but every driver using a device
> +   would have to provide them, and only the 1st loaded module would
> +   actually succeed in registering them.  Furthermore, if any driver
> +   accessing a port uses the idle/activate sequences, they all must.
> +   On the whole, this is complexity w/o benefit.
> +*/

long-comment style, please.

---
~Randy
