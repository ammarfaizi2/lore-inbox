Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287854AbSANR4m>; Mon, 14 Jan 2002 12:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287848AbSANR4c>; Mon, 14 Jan 2002 12:56:32 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5592 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287854AbSANR4S>;
	Mon, 14 Jan 2002 12:56:18 -0500
Date: Mon, 14 Jan 2002 12:56:15 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [RFLART] kdev_t in ioctls
Message-ID: <Pine.GSO.4.21.0201141227260.224-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, at least some ioctls (e.g. lvm ones) pass kdev_t from/to
userland.  While the common policy with ioctls is "anything goes", this
kind of abuse is IMNSHO over the top.

	Example: ioctl(fd, VG_CREATE, ptr) expects the following:
at ptr -
struct {
	/* bunch of sane fields */
        struct proc_dir_entry *proc;	/* ignored */
        pv_t *pv[ABS_MAX_PV + 1];
        lv_t *lv[ABS_MAX_LV + 1];
      	/* bunch of stuff */
}

and pointers in the second array are to the following:
struct {
	/* lots of stuff */
        kdev_t lv_dev;
	/* lots of other stuff */
}

They _are_ dereferenced and values of ptr->lv[i]->lv_dev are stored in
kernel data structures.  And used afterwards.  As kdev_t.

The same goes for the rest of LVM ioctls - pretty much all of them
pull such stunts.  I'm not going to comment on harmless gross indecencies
like struct proc_dir_entry * passed from the userland (and fortunately
ignored), but kdev_t instances are _not_ harmless.

Public statement along the lines "any API that passes kdev_t values
across the kernel boundary is unacceptable" would be a nice thing...

