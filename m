Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWDZGUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWDZGUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 02:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWDZGUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 02:20:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:1997 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750802AbWDZGUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 02:20:49 -0400
Date: Wed, 26 Apr 2006 07:20:48 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: dbrownell@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: races in drivers/usb/gadget/inode.c, leak fix in the same file
Message-ID: <20060426062048.GG27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

activate_ep_files() allocates a bunch of ep_data, creates inodes and
dentries for them and sticks them into a cyclic list.  inode->u.generic_ip
is set to created ep_data, refcount is 1.

destroy_ep_files() goes through that cyclic list, gets dentry from each
ep_data on it and drops ep_data.  Then it kills dentry and inode by
                /* break link to dcache */
                mutex_lock (&parent->i_mutex);
                d_delete (dentry);
                dput (dentry);
                mutex_unlock (&parent->i_mutex);
Tries to kill, anyway.  The thing is, ep_open() (->open() on that sucker)
does
static int
ep_open (struct inode *inode, struct file *fd)
{
        struct ep_data          *data = inode->u.generic_ip;
        int                     value = -EBUSY;

        if (down_interruptible (&data->lock) != 0)
                return -EINTR;
followed eventually by pinning data (i.e. ep_data for that inode) down.

It's way too late - by the time we enter ep_open(), inode->u.generic_ip
might be already pointing to freed memory.

AFAICS, the cheapest way to deal with that would be to set ->u.generic_ip
to NULL before dropping ep_data in ep_destroy_files(), have that done
under global spinlock and have ep_open() et.al. start with checking if
the pointer is NULL under the same spinlock and grabbing a reference if
it isn't.

There's another question: opened files are opened; what protects them
from gadgetfs_unbind() freeing ep->req while ep is still pinned down
by an opened file?  We do not hold dev->lock or ep->lock there...

One more: what protects dev->state?  I don't see any lock that would
be held over all places that modify it.

Oh, and a trivial leak fix, while we are at it:

Subject: [PATCH] fix leak in activate_ep_files()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/usb/gadget/inode.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

676113fa9fe777d13904017f8da5ae04c214567f
diff --git a/drivers/usb/gadget/inode.c b/drivers/usb/gadget/inode.c
index 42b4570..0eb010a 100644
--- a/drivers/usb/gadget/inode.c
+++ b/drivers/usb/gadget/inode.c
@@ -1614,6 +1614,7 @@ static int activate_ep_files (struct dev
 				data, &ep_config_operations,
 				&data->dentry);
 		if (!data->inode) {
+			usb_ep_free_request(ep, data->req);
 			kfree (data);
 			goto enomem;
 		}
-- 
1.3.0.g0080f

