Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317416AbSGDNzu>; Thu, 4 Jul 2002 09:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317418AbSGDNzt>; Thu, 4 Jul 2002 09:55:49 -0400
Received: from [217.167.51.129] ([217.167.51.129]:22518 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S317416AbSGDNzs>;
	Thu, 4 Jul 2002 09:55:48 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linux-kernel@vger.kernel.org>
Subject: Possible LVM bug in 2.4.19-rc1
Date: Thu, 4 Jul 2002 15:59:55 +0200
Message-Id: <20020704135956.17419@192.168.4.1>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Olaf and I have been tracking down a bug where the kernel died
into lvm_blk_open() during boot on pmac, and later on other PPCs
when trying to access an unconfigured LVM block device (or an
LVM minor not associated yet). This typically happened in the
pmac root discovery code which walks all gendisks, but I beleive
there are other possible exploits.
 
Here's what I've tracked down so far:

  static int lvm_blk_open(struct inode *inode, struct file *file)
  {
  	int minor = MINOR(inode->i_rdev);
  	lv_t *lv_ptr;
  	vg_t *vg_ptr = vg[VG_BLK(minor)];

  	P_DEV("blk_open MINOR: %d  VG#: %d  LV#: %d  mode: %s%s\n",
	        minor, VG_BLK(minor), LV_BLK(minor),
  	      MODE_TO_STR(file->f_mode));

  #ifdef LVM_TOTAL_RESET
	  if (lvm_reset_spindown > 0)
	  	return -EPERM;
  #endif

  	if (vg_ptr != NULL &&
  	    (vg_ptr->vg_status & VG_ACTIVE) &&

  .../...

At this point, no association have been made. That is VG_BLK(minor)
will return vg_lv_map[minor].vg_number which has been initialized
to ABS_MAX_VG in lvm_init_vars().

That means that vg_ptr is set to vg[ABS_MAX_VG], which is right outside
the array bounds, as vg is declared to be

  /* volume group descriptor area pointers */
  vg_t *vg[ABS_MAX_VG];

So, as soon as we dereference vg_ptr, we get whatever garbage is located
right after the array, and not the NULL value we would expect for a non
initialized association.

If my understanding is correct, then a simple fix would be to

  /* volume group descriptor area pointers */
-  vg_t *vg[ABS_MAX_VG];
+  vg_t *vg[ABS_MAX_VG+1];

though it's a bit hackish... maybe we should just test
VG_BLK < ABS_MAX_VG

Also, the loop initializing vg array to NULL can probably be removed
from lvm_init_vars as vg is part of the BSS and thus cleared by default.

Did I miss something ?

Ben.


