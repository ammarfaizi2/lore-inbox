Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266097AbUGILro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUGILro (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266113AbUGILro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:47:44 -0400
Received: from mx2.magma.ca ([206.191.0.250]:19686 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S266097AbUGILpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:45:20 -0400
Subject: Re: 2.6.7-mm7
From: Jesse Stockall <stockall@magma.ca>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <40EE732C.5020404@gts.it>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	 <40EE5418.2040000@gts.it> <20040709024112.7ef44d1d.akpm@osdl.org>
	 <40EE732C.5020404@gts.it>
Content-Type: text/plain
Message-Id: <1089373506.8067.7.camel@homer.blizzard.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 09 Jul 2004 07:45:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 06:27, Stefano Rivoir wrote:
> 
> It seems that hotplug "subsystem" is having problems (I use debian/sid), 
> because it stucks during
> 
> /sbin/modprobe -s -q ehci_hcd
> 
> Note that I'm seeing this after a /etc/init.d/hotplug start (after a 
> successfull boot), but just before I had a kernel oops (see attached 
> file) when issuing a /etc/init.d/hotplug stop.

Hi

This is a known issue that appeared in 2.6.7-mm6. See below for a
temporary fix. Check the [2.6.7-mm6 -  USB problems] thread on
linux-usb-devel@lists.sourceforge.net for more info.

Jesse

<-- msg from Alan Stern -->

This patch fixes a problem with my recent set of locking changes for
USB.
The problem is that rw-semaphores don't have the semantics I need.  I
need
something where, if the semaphore is locked for reading and a writer is
waiting for the lock, another reader will be granted a readlock
immediately.  That's because there are several places where a thread
holding the readlock will acquire the readlock again, in a nested or
recursive fashion.  If a writer is waiting for the first readlock to be
released, the standard semantics will yield deadlock.

This patch implements those alternate semantics by putting writers on a 
separate wait queue.  It's a little bit awkward and has a definite 
roll-you-own flavor, but it works.  Please apply.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

===== drivers/usb/core/usb.c 1.281 vs edited =====
--- 1.281/drivers/usb/core/usb.c        Wed Jun 30 09:44:26 2004
+++ edited/drivers/usb/core/usb.c       Wed Jul  7 15:47:23 2004
@@ -64,6 +64,7 @@
                        /* Not honored on modular build */
 
 static DECLARE_RWSEM(usb_all_devices_rwsem);
+static DECLARE_WAIT_QUEUE_HEAD(usb_all_devices_wqh);
 
 
 static int generic_probe (struct device *dev)
@@ -933,6 +934,7 @@
 {
        up(&udev->serialize);
        up_read(&usb_all_devices_rwsem);
+       wake_up(&usb_all_devices_wqh);
 }
 
 /**
@@ -940,10 +942,15 @@
  *
  * This is necessary when registering a new driver or probing a bus,
  * since the driver-model core may try to use any usb_device.
+ *
+ * Unfortunately we have to use a separate wait queue, because we need
+ * to make sure that a thread waiting for a writelock won't block other
+ * threads from acquiring a readlock.
  */
 void usb_lock_all_devices(void)
 {
-       down_write(&usb_all_devices_rwsem);
+       wait_event(usb_all_devices_wqh,
+                       down_write_trylock(&usb_all_devices_rwsem));
 }
 
 /**
@@ -952,6 +959,7 @@
 void usb_unlock_all_devices(void)
 {
        up_write(&usb_all_devices_rwsem);
+       wake_up(&usb_all_devices_wqh);
 }

-- 
Jesse Stockall <stockall@magma.ca>

