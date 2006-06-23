Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbWFWA7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbWFWA7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWFWA7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:59:37 -0400
Received: from cantor2.suse.de ([195.135.220.15]:63978 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751689AbWFWA7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:59:36 -0400
Date: Thu, 22 Jun 2006 17:56:21 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Message-ID: <20060623005620.GA9496@suse.de>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606221546120.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606221546120.6483@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 04:11:26PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 21 Jun 2006, Greg KH wrote:
> >
> > Here are a lot of USB patches for 2.6.17.  They do the following:
> 
> I think these may be responsible for:
> 
> 	Bluetooth: L2CAP ver 2.8
> 	Bluetooth: L2CAP socket layer initialized
> 	Bluetooth: HIDP (Human Interface Emulation) ver 1.1
> 	Bluetooth: RFCOMM socket layer initialized
> 	Bluetooth: RFCOMM TTY layer initialized
> 	Bluetooth: RFCOMM ver 1.7
> 	BUG: unable to handle kernel paging request at virtual address 5a5a5a5a
> 	 printing eip:
> 	c02a58f8
> 	*pde = 00000000
> 	Oops: 0000 [#1]
> 	SMP 
> 	Modules linked in: rfcomm hidp l2cap hci_usb bluetooth ip_conntrack_netbios_ns ipt_REJECT iptable_filter ip_tables ip6table_filter ip6_tables cpufreq_ondemand lp pcspkr intel_agp agpgart
> 	CPU:    0
> 	EIP:    0060:[<c02a58f8>]    Not tainted VLI
> 	EFLAGS: 00210206   (2.6.17-gd588fcbe #211) 
> 	EIP is at usbdev_open+0xb4/0x1ec
> 	eax: 0bd00005   ebx: 5a5a5a5a   ecx: 5a5a58d2   edx: dd991e4c
> 	esi: de020bdc   edi: c712da68   ebp: c6eeaee8   esp: c6eeaeac
> 	ds: 007b   es: 007b   ss: 0068
> 	Process hid2hci (pid: 3719, threadinfo=c6eea000 task=ddfb8570)
> 	Stack: c854dc28 dd22cd70 00000000 00000005 c6eeaed4 c016bd39 c6eeaf3c 00000001 
> 	       c6eea000 00000000 dd22cd70 c6eeaee8 00000000 c050b8a0 dd22cd70 c6eeaf04 
> 	       c01678a4 c854dc28 c6eeaf04 c854dc28 dd22cd70 00000000 c6eeaf20 c015e424 
> 	Call Trace:
> 	 <c0103c46> show_stack_log_lvl+0x85/0x8f  <c0103dc3> show_registers+0x13b/0x1af
> 	 <c0103fac> die+0x175/0x285  <c011a86d> do_page_fault+0x428/0x522
> 	 <c0103777> error_code+0x4f/0x54  <c01678a4> chrdev_open+0x11a/0x171
> 	 <c015e424> __dentry_open+0xc8/0x1ab  <c015e575> nameidata_to_filp+0x1c/0x2e
> 	 <c015e5b5> do_filp_open+0x2e/0x35  <c015e5fc> do_sys_open+0x40/0xba
> 	 <c015e6a2> sys_open+0x16/0x18  <c0102c0f> sysenter_past_esp+0x54/0x75
> 	Code: 00 8b 35 cc 77 61 c0 8b 8e 9c 00 00 00 81 e9 88 01 00 00 eb 16 8b 45 d0 0d 00 00 d0 0b 39 81 94 01 00 00 74 81 8d 8b 78 
> 	fe ff ff <8b> 99 88 01 00 00 0f 18 03 90 8d 91 88 01 00 00 8d 86 9c 00 00 
> 	EIP: [<c02a58f8>] usbdev_open+0xb4/0x1ec SS:ESP 0068:c6eeaeac
> 
> where that 5a5a5a5a is possibly/probably due to SLAB debugging (it's the 
> "POISON_INUSE" pattern)
> 
> It might have happened before too, of course, I just haven't seen it 
> before (even though I've had SLAB debugging on all the time on that 
> machine).
> 
> It seems to actually be from usbdev_lookup_minor(), which has been inlined 
> (damn compiler), and it's the "node.next" access in the
> 
> 	list_for_each_entry(device, &usb_device_class->devices, node) {
> 
> loop.
> 
> Any ideas? 

Ok, this was a stupid one on my part, I'm really surprised that it
didn't trigger all the time.  Here's a patch for it.  Sorry about this.

This just survived a lot of unloads and reloads and devices disappearing
and added.

thanks,

greg k-h

---------------------

From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Driver core: fix locking issues with the devices that are attached to classes

Doh, that was foolish...

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/core.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- gregkh-2.6.orig/drivers/base/core.c
+++ gregkh-2.6/drivers/base/core.c
@@ -356,6 +356,13 @@ int device_add(struct device *dev)
 	if (parent)
 		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
+	if (dev->class) {
+		/* tie the class to the device */
+		down(&dev->class->sem);
+		list_add_tail(&dev->node, &dev->class->devices);
+		up(&dev->class->sem);
+	}
+
 	/* notify platform of device entry */
 	if (platform_notify)
 		platform_notify(dev);
@@ -456,6 +463,9 @@ void device_del(struct device * dev)
 		sysfs_remove_link(&dev->kobj, "device");
 		sysfs_remove_link(&dev->parent->kobj, class_name);
 		kfree(class_name);
+		down(&dev->class->sem);
+		list_del_init(&dev->node);
+		up(&dev->class->sem);
 	}
 	device_remove_file(dev, &dev->uevent_attr);
 
@@ -602,11 +612,6 @@ struct device *device_create(struct clas
 	if (retval)
 		goto error;
 
-	/* tie the class to the device */
-	down(&class->sem);
-	list_add_tail(&dev->node, &class->devices);
-	up(&class->sem);
-
 	return dev;
 
 error:
@@ -637,9 +642,7 @@ void device_destroy(struct class *class,
 	}
 	up(&class->sem);
 
-	if (dev) {
-		list_del_init(&dev->node);
+	if (dev)
 		device_unregister(dev);
-	}
 }
 EXPORT_SYMBOL_GPL(device_destroy);
