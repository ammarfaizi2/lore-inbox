Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289026AbSAUEGe>; Sun, 20 Jan 2002 23:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289028AbSAUEGY>; Sun, 20 Jan 2002 23:06:24 -0500
Received: from [194.195.64.32] ([194.195.64.32]:16530 "EHLO mail.netsurf.de")
	by vger.kernel.org with ESMTP id <S289026AbSAUEGR>;
	Sun, 20 Jan 2002 23:06:17 -0500
Date: Mon, 21 Jan 2002 05:05:25 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.2 API change summary
Message-ID: <20020121040525.GA9569@storm.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A bit late, but here it is.  No guarantees for correctness of the
explanations, it's what I've gathered from context and reading a bit of
source code.  Corrections welcome.

These are just the actual changes in the 2.5.2 patch, if you want the
bigger picture visit Randy Dunlap's page where he collects pointers to
mailing list threads of relevance for driver writers:
	http://www.osdl.org/archive/rddunlap/linux-port-25x.html

And here it goes:


	GENERAL CHANGES:

	include/linux/list.h:

- New typedef of list_t to struct list_head.


	include/linux/crc32.h (new):

- Central implementation of CRC32, which was previously implemented in 5
  places in the kernel.


	include/linux/devfs_fs_kernel.h:

- devfs_put() exported (put (release) reference to a devfs entry).

- New function devfs_get_handle() to get the devfs handle corresponding
  to a name or major/minor combination.


	include/linux/kdev_t.h:

- kdev_t changed from basic type (unsigned short) to opaque struct type
  to prepare for future expansion to larger major/minor numbers.

- New macros major() and minor() to replace MAJOR() and MINOR() for
  extracting those from a kdev_t.  MAJOR()/MINOR() are for the user
  level dev_t only now.

- New functions kdev_val() and val_to_kdev() to convert a kdev_t to/from
  an unsigned int cookie.

- New macro mk_kdev() to convert a major/minor combination into a
  kdev_t.


	include/linux/namespace.h (new):
	include/linux/sched.h:

- Added task namespace functions.

- New CLONE_NEWNS cloning flag for namespaces.


	include/linux/mm.h:
	include/linux/gfp.h (new):

- All GFP macros and page allocation functions moved to new gfp.h from
  mm.h.

- New function get_user_pages().


	BLOCK DEVICES / FILE SYSTEMS:

	include/linux/bio.h:

- New #define BIO_MAX_SIZE to accompany BIO_MAX_SECTORS, defined as
  (BIO_MAX_SECTORS << 9).


	include/linux/acct.h:

- acct_auto_close() now takes a struct super_block* instead of kdev_t as
  argument.


	include/linux/fs.h:

- create_empty_buffers() does not have a kdev_t parameter anymore.

- fsync_no_super() and brw_page() now take a struct super_block* where
  they took a kdev_t as argument.

- The following functions are now wrappers mapping kdev_t to struct
  super_block* of the real function:

	get_hash_table() => __get_hash_table()
	getblk()         => __getblk()
	bread()          => __bread()

- New functions sb_set_blocksize() and sb_min_blocksize() (to set
  super_block block size) and map_bh().


	SCSI:

	drivers/scsi/hosts.h:

- Field host_lock in struct Scsi_Host changed from spinlock_t to
  spinlock_t*, which defaults to point to the new field default_lock.
  Function scsi_assign_lock() to set that field added.

- Fully dynamic host and device handling: scsi_(un)register_module()
  removed, scsi_unregister_device() and scsi_(un)register_host()
  added.


	USB:

	drivers/usb/hcd.h (new):

- New host controller driver framework.  "Plugs into usbcore (usb_bus)
  and lets HCDs share code, minimizing HCD-specific behaviors/bugs."


	include/linux/usb.h:

- typedef devrequest is now struct usb_ctrlrequest.


-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
