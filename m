Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262151AbSJKIlm>; Fri, 11 Oct 2002 04:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbSJKIlm>; Fri, 11 Oct 2002 04:41:42 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.200]:31230 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id <S262151AbSJKIlk>; Fri, 11 Oct 2002 04:41:40 -0400
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: usbfs race while mounting/umounting
From: Wolfram Gloger <wg@malloc.de>
X-URL: http://www.malloc.de/
Message-Id: <E17zvS7-00041g-00@mrvdomng.kundenserver.de>
Date: Fri, 11 Oct 2002 10:47:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me on replies, thx]

I use usbfs, but normally have only a single USB device connected, a
generic mouse.  When usbfs is unmounted on shutdown, I see "BUG at
inode.c:1034" in between 5% and 50% of all cases, the backtrace being
iput(), free_inode(), usbdevfs_put_super(), kill_super(), __mntput(),
etc.

I believe this to be a long standing problem, I remember seeing this
in 2.2.x as well, more than a year ago.  Then I moved the mouse to a
2.4.x system, and I've seen the problem ever since.  As a workaround,
I have moved the "umount /proc/bus/usb" after all disk umounts, but I
believe I've now finally tracked down the cause.

drivers/usb/inode.c says that all calls of its inode-list-manipulating
functions must occur with the kernel lock held.  usbdevfs_read_super()
does _not_ do this, however, and I strongly suspect that my mouse is
auto-detected (occasionally) exactly while usbfs is being mounted.
The result is that the same inode ends up twice in usbfs's lists,
hence the "BUG in inode.c:1034" when it is iput() twice on shutdown.
The appended patch has fixed the problem for me, although I've only
done a few boot cycles with it.

Regards,
Wolfram.

--- drivers/usb/inode.c.orig	Sat Aug  3 02:39:45 2002
+++ drivers/usb/inode.c	Fri Oct 11 10:13:13 2002
@@ -628,6 +628,7 @@
         s->s_root = d_alloc_root(root_inode);
         if (!s->s_root)
                 goto out_no_root;
+	lock_kernel();
 	list_add_tail(&s->u.usbdevfs_sb.slist, &superlist);
 	for (i = 0; i < NRSPECIAL; i++) {
 		if (!(inode = iget(s, IROOT+1+i)))
@@ -639,13 +640,12 @@
 		list_add_tail(&inode->u.usbdev_i.slist, &s->u.usbdevfs_sb.ilist);
 		list_add_tail(&inode->u.usbdev_i.dlist, &special[i].inodes);
 	}
-	down (&usb_bus_list_lock);
 	for (blist = usb_bus_list.next; blist != &usb_bus_list; blist = blist->next) {
 		bus = list_entry(blist, struct usb_bus, bus_list);
 		new_bus_inode(bus, s);
 		recurse_new_dev_inode(bus->root_hub, s);
 	}
-	up (&usb_bus_list_lock);
+	unlock_kernel();
         return s;
 
  out_no_root:

