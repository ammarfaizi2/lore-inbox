Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318283AbSGRSL7>; Thu, 18 Jul 2002 14:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318284AbSGRSL7>; Thu, 18 Jul 2002 14:11:59 -0400
Received: from air-2.osdl.org ([65.172.181.6]:388 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318283AbSGRSL5>;
	Thu, 18 Jul 2002 14:11:57 -0400
Date: Thu, 18 Jul 2002 11:11:53 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: driverfs updates
Message-ID: <Pine.LNX.4.44.0207181050330.2542-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a set of driverfs updates. These updates completely replace the 
patch that I posted last week, and actually have overlapping changesets. 

Short summary:

- break kernel interface to driverfs into fs/driverfs/lib.c
- change show/store callbacks to take void *, instead of struct device *
- Fix compilation warnings for all users
- Change driverfs_remove_file and device_remove_file to take 
  struct driver_file_entry *, instead of char * (so you can use the same
  paramter that you used to creat the file to remove it)
- Fix all users of those functions
- Make struct driver_dir_entry dynamically allocated
- Free it on dentry removal, instead of when object is removed
- Put pointer to object owning directory in directory entry, so we have 
  something handy to pass to show() and store()
- Change named initializers (keeping tabs in place) 

There is nothing in these changesets to deal with object locking or 
reference counting. Though they're related, they are separate issues, and 
will be dealt with separately. 

These changes basically make driverfs generic enough to handle any type of 
object or subsystem creating files and directories in it. 

The next set of patches (probably today) will add glue so that bus and
device drivers can create files of their own (instead of on behalf of a
device). Along with the udpated documentation, they will serve as an 
example of how any subsystem can exploit driverfs.

A patch is available at 

http://kernel.org/pub/linux/kernel/people/mochel/patches/driverfs-18072002.diff.gz

	-pat

Please pull from

	http://ldm.bkbits.net/linux-2.5-driverfs

This will update the following files:

 drivers/base/base.h         |    1 
 drivers/base/bus.c          |   78 +++++++--
 drivers/base/driver.c       |   18 +-
 drivers/base/fs.c           |   39 +++-
 drivers/base/interface.c    |    9 -
 drivers/cdrom/cdrom.c       |    5 
 drivers/pci/proc.c          |    6 
 drivers/scsi/scsi_scan.c    |    5 
 drivers/scsi/sg.c           |   11 -
 drivers/scsi/sr.c           |    7 
 fs/driverfs/Makefile        |    4 
 fs/driverfs/inode.c         |  361 +++++---------------------------------------
 fs/driverfs/lib.c           |  297 +++++++++++++++++++++++++++++++++++-
 fs/partitions/check.c       |   15 -
 include/linux/device.h      |   12 -
 include/linux/driverfs_fs.h |   13 +
 16 files changed, 497 insertions(+), 384 deletions(-)

through these ChangeSets:

<mochel@osdl.org> (02/07/18 1.739)
   driverfs:
   Change named initializers from 
   	name:	value
   to
   	.name	= value

<mochel@osdl.org> (02/07/17 1.639.3.20)
   device driverfs files:
   set object pointer in directory, not for individual files

<mochel@osdl.org> (02/07/17 1.639.3.19)
   driverfs:
   - move pointer to object that owns file to driver_dir_entry, since the same object will own all files in that directory

<mochel@osdl.org> (02/07/17 1.639.3.18)
   bus directories in driverfs:
   - don't free directories, since that's done now when the dentry is deleted

<mochel@osdl.org> (02/07/17 1.639.3.17)
   driverfs:
   add d_delete callback for directories that frees driver_dir_entry, now that all users dynamically allocate it

<mochel@osdl.org> (02/07/17 1.639.3.16)
   driver directories in driverfs:
   dynamically allocate directories

<mochel@osdl.org> (02/07/17 1.639.3.15)
   bus symlinks in driverfs:
   make sure we use right pointer to parent when creating symlink

<mochel@osdl.org> (02/07/17 1.639.3.14)
   bus driver directories:
   - make sure we get parent right when creating directories
   - make sure we memset them when we allocate them

<mochel@osdl.org> (02/07/17 1.639.3.13)
   bus drivers:
   - make bus's directories dynamically allocated. 
   - update creation and deletion functions to handle that

<mochel@osdl.org> (02/07/17 1.639.3.12)
   devices:
   - make struct device::dir dynamically allocated, instead of static
   - change functions that use it to treat it as such

<mochel@osdl.org> (02/07/17 1.639.3.11)
   fs/partitions/check.c:
   change calls to device_remove_file to take pointer to driver_file_entry, instead of just the name

<mochel@osdl.org> (02/07/17 1.639.3.10)
   drivers/scsi/sg.c:
   change call device_remove_file to take pointer to the driver_file_entry, insetad of the name

<mochel@osdl.org> (02/07/17 1.639.3.9)
   #ifdef out this code that removes driverfs files that it didn't create. 
   That sounds buggy...

<mochel@osdl.org> (02/07/17 1.639.3.8)
   device model:
   - change device_remove_file to take pointer to driver_file_entry instead of char * to match change in driverfs interface
   - implement device_remove_symlink, that manaualy searches dir's list of files to obtain a struct driver_file_entry to pass to driverfs_remove_file

<mochel@osdl.org> (02/07/17 1.639.3.7)
   driverfs - 
   Change driverfs_remove_file to take struct driver_file_entry * instead of char *
   Walk list of dir's files to find matching entry (so entry passed in can be re-used for multiple objects) on file removal
   But, now creation and removal take the same parameter

<mochel@osdl.org> (02/07/17 1.639.3.6)
   fs/partitions/check.c
   Change driverfs callbacks to take void * and cast to struct device *

<mochel@osdl.org> (02/07/17 1.639.3.5)
   drivers/scsi/*c:
   Change driverfs callbacks to take void * and cast to struct device *

<mochel@osdl.org> (02/07/17 1.639.3.4)
   drivers/pci/proc.c:
   Change driverfs callbacks to take void * and cast to struct device *

<mochel@osdl.org> (02/07/17 1.639.3.3)
   driverfs/base/interface.c:
   Change driverfs callbacks to take void * and cast to struct device

<mochel@osdl.org> (02/07/17 1.639.3.2)
   driverfs:
   - Add void * object pointer in driver_file_entry
   - Change show() and store() callbacks to take a void *, instead of struct device *
   - Use object pointer in read() and write() instead of doing list_entry on the driver_file_entry
   - Make sure that device_create_file sets object pointer when creating a file

<mochel@osdl.org> (02/07/15 1.639.3.1)
   driverfs:
   split apart kernel interface from the standard file operations


