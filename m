Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSKNFBd>; Thu, 14 Nov 2002 00:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSKNFBd>; Thu, 14 Nov 2002 00:01:33 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:51679 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S261529AbSKNFBb>; Thu, 14 Nov 2002 00:01:31 -0500
Message-ID: <XFMail.20021114000819.f.duncan.m.haldane@worldnet.att.net>
X-Mailer: XFMail 1.5.3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Thu, 14 Nov 2002 00:08:19 -0500 (EST)
From: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] Help needed for usb semaphore lock in 2.4.20-rc1 (since 2.4.13)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am the current maintainer of the cpia webcam driver.

I am tracking down a kernel Oops in 2.4.20-rc1 that was first
introduced in 2.4.13 by usb semaphore locking changes in usb.c,
and which was reported a while back on this list. See:
 http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.1/1504.html
The Ooops occurs when the  system boots  if usb, video4linux , 
cpia and cpia_usb are compiled into the kernel.
There is no problem if they are compiled as modules.


No changes in the cpia drivers occurred when the Ooops was
introduced in 2.4.13.  usb_cpia-init() in drivers/media/video/cpia_usb.c 
calls usb_register() in drivers/usb/usb.c to register itself.   \
usb_register() calls usb_scan_devices().  The Oops occurs when
the usb list is locked  in usb_scan_devices(), by a call to 
" down (&usb_bus_list_lock);". 
The result is: "Unable to handle kernel NULL pointer dereference at 
virtual address 00000000","Oops: 0002".

If I comment out the lock, things work again. (no OOPS, cpa works).
So the problem is isolated.   Whats the fix?


Assuming this is a usb.c problem , I'm out of my depth here.


Or should some new entries to initialize something be added to
the "static struct usb_driver cpia_driver" declaration in cpia_usb.c below?
Please give me some hints on what to fix if some new initialization
in cpia_usb.c is needed since the 2.4.13 usb semaphore changes. 

Thanks!

Please cc me directly: 

duncan_haldane@users.sourceforge.net

----(drivers/media/video/cpia_usb.c)---------------
<snip>
static struct usb_driver cpia_driver = {
        name:           "cpia",
        probe:          cpia_probe,
        disconnect:     cpia_disconnect,
        id_table:       cpia_id_table,
};
<snip>
static int __init usb_cpia_init(void)
{
        cam_list = NULL;
        spin_lock_init(&cam_list_lock_usb);
        return usb_register(&cpia_driver);
}
<snip>

----(2.4.20-rc2 drivers/usb/usb.c)----------------------------

<snip>
LIST_HEAD(usb_driver_list);
LIST_HEAD(usb_bus_list);
struct semaphore usb_bus_list_lock;
<snip>

int usb_register(struct usb_driver *new_driver)
{
        if (new_driver->fops != NULL) {
                if (usb_minors[new_driver->minor/16]) {
                         err("error registering %s driver", new_driver->name);
                        return -EINVAL;
                }
                usb_minors[new_driver->minor/16] = new_driver;
        }

        info("registered new driver %s", new_driver->name);

        init_MUTEX(&new_driver->serialize);

        /* Add it to the list of known drivers */
        list_add_tail(&new_driver->driver_list, &usb_driver_list);

        usb_scan_devices();

        return 0;
}

<snip>

void usb_scan_devices(void)
{
        struct list_head *tmp;

        //      down (&usb_bus_list_lock);  <= WORKS IF THIS IS COMMENTED OUT!
        tmp = usb_bus_list.next;
        while (tmp != &usb_bus_list) {
                struct usb_bus *bus = list_entry(tmp,struct usb_bus, bus_list);

                tmp = tmp->next;
                usb_check_support(bus->root_hub);
        }
        //   up (&usb_bus_list_lock);       <= WORKS IF THIS IS COMMENTED OUT!
}

<snip>

-----------(old (working) lock in  2.4.12 drivers/usb/usb.c)--------------

rwlock_t usb_bus_list_lock = RW_LOCK_UNLOCKED;

        read_lock_irq (&usb_bus_list_lock);
         ....
        read_unlock_irq (&usb_bus_list_lock);

--------------------------------------------------------------------


----------------------------------
E-Mail: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
Date: 13-Nov-2002
Time: 23:35:59

This message was sent by XFMail
----------------------------------
