Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbVJRStl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVJRStl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 14:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVJRStl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 14:49:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11670 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751168AbVJRStk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 14:49:40 -0400
Date: Tue, 18 Oct 2005 11:49:33 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: usb: Patch for USBDEVFS_IOCTL from 32-bit programs
Message-Id: <20051018114933.276781da.zaitcev@redhat.com>
In-Reply-To: <20051018171333.GA29504@kroah.com>
References: <20051017181554.77d0d45d.zaitcev@redhat.com>
	<20051018171333.GA29504@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2005 10:13:33 -0700, Greg KH <greg@kroah.com> wrote:

> On Mon, Oct 17, 2005 at 06:15:54PM -0700, Pete Zaitcev wrote:
> > I'm cross-posting to l-k because someone I know was making sounds at
> > a notion of #ifdef CONFIG_COMPAT. But I think this solutions is superior
> > to adding anything outside of devio.c.
> 
> Why not put this in fs/compat_ioctl.c where the other usbfs 32bit ioctls
> are?

This is what Dell people did originally. Here is their code:

+static int do_usbdevfs_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+  struct usbdevfs_ioctl kioc;
+  struct usbdevfs_ioctl32 __user *uioc;
+  mm_segment_t old_fs;
+  u32 udata;
+  int err;
+
+  uioc = compat_ptr(arg);
+  if (get_user(kioc.ifno, &uioc->ifno) ||
+      get_user(kioc.ioctl_code, &uioc->ioctl_code) ||
+      __get_user(udata, &uioc->data))
+    return -EFAULT;
+  
+  kioc.data = compat_ptr(udata);
+
+  old_fs = get_fs();
+  set_fs(KERNEL_DS);
+  err = sys_ioctl(fd, USBDEVFS_IOCTL, (unsigned long)&kioc);
+  set_fs(old_fs);
+
+  return err;
+}

The problem here is that compat_ptr does NOT turn user data pointer
into a kernel pointer. It's still a user pointer, only sized
differently. So, when you do set_fs(KERNEL_DS), this pointer
is invalid (miraclously, it does work on AMD64, so Dell's tests
pass on their new Xeons).

So, you cannot simply to have a small shim. Instead, you have to allocate
the buffer, do copy_from_user(), and then call the ioctl. But then,
it would be a double-copy, when the ioctl allocates the buffer again.

I tweaked this in various ways, and the patch I posted looks like
the cleanest solution. But please tell me if I miss something obvious.

-- Pete
