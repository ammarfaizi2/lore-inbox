Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSGSWOr>; Fri, 19 Jul 2002 18:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSGSWOr>; Fri, 19 Jul 2002 18:14:47 -0400
Received: from air-2.osdl.org ([65.172.181.6]:63634 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317114AbSGSWOn>;
	Fri, 19 Jul 2002 18:14:43 -0400
Date: Fri, 19 Jul 2002 15:15:01 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, <greg@kroah.com>
Subject: [BK PATCH] driverfs updates 3
Message-ID: <Pine.LNX.4.44.0207191501490.2542-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the 3rd round of driverfs updates. 

The big change in this update is to move some fields of struct 
driver_file_entry into struct driver_attribute. Now, instead of drivers 
declaring and using the former, they use the latter. It looks like this:

struct driver_attribute {
        char            * name;
        mode_t          mode;
        driverfs_show   show;
        driverfs_store  store;
};

struct driver_file_entry {
        struct driver_dir_entry * parent;
        struct list_head        node;
        struct dentry           * dentry;
        struct driver_attribute * attr;
};

struct driver_file_entry is still around, and there is still one allocated 
for each file that is created. However, it used only by the driverfs core. 
And, instead of copying the original driver_file_entry into each allocated 
one, the code now simply has a pointer to the struct driver_attribute that 
describes the file. 

All users of struct driver_file_entry have been updated, as well as the 
documentation.

Appended is the diffstat output and changelogs for the most recent change,
relative to the previous two updates, as well as the diffstat output and
changelogs for all three updates. 

Please pull from:

	bk://ldm.bkbits.net/linux-2.5-driverfs-3

It contains the cumulative changes.

	-pat

Changes relative to last update:

 Documentation/filesystems/driverfs.txt |   36 +++++++++--------------
 drivers/base/fs/bus.c                  |    8 ++---
 drivers/base/fs/device.c               |   16 +++++-----
 drivers/base/fs/driver.c               |    8 ++---
 drivers/base/fs/lib.c                  |   26 +++++------------
 drivers/base/interface.c               |    6 +--
 drivers/pci/proc.c                     |    4 +-
 drivers/scsi/scsi_scan.c               |    2 -
 drivers/scsi/sg.c                      |    4 +-
 drivers/scsi/sr.c                      |    4 +-
 drivers/scsi/st.c                      |   19 ++++++------
 drivers/usb/core/usb.c                 |   10 +++---
 fs/driverfs/inode.c                    |   12 +++----
 fs/driverfs/lib.c                      |   50 +++++++++++++++++++++------------
 fs/partitions/check.c                  |    4 +-
 include/linux/device.h                 |   12 +++----
 include/linux/driverfs_fs.h            |   19 +++++++-----
 17 files changed, 121 insertions(+), 119 deletions(-)

through these ChangeSets:

<mochel@osdl.org> (02/07/19 1.662)
   Update driverfs documentation

<mochel@osdl.org> (02/07/19 1.639.6.26)
   fs/partitions/check.c:
   s/driver_file_entry/driver_attribute/

<mochel@osdl.org> (02/07/19 1.639.6.25)
   usb driverfs files:
   s/driver_file_entry/driver_attribute/

<mochel@osdl.org> (02/07/19 1.639.6.24)
   SCSI driverfs files:
   s/driver_file_entry/driver_attribute/
   Fix previous compile errors in st.c

<mochel@osdl.org> (02/07/19 1.639.6.23)
   pci driverfs files:
   s/driver_file_entry/driver_attribute/

<mochel@osdl.org> (02/07/19 1.639.6.22)
   device model, basic files:
   s/driver_file_entry/driver_attribute/

<mochel@osdl.org> (02/07/19 1.639.6.21)
   device model symlinks:
   Change symlink creation and deletion to pass a struct driver_attribute, instead of allocating a new 
   driver_file_entry

<mochel@osdl.org> (02/07/19 1.639.6.20)
   device model driverfs interface:
   Change driver and device file creation and removal functions to take and pass a struct driver_attribute, 
   instead of a driver_file_entry

<mochel@osdl.org> (02/07/19 1.639.6.19)
   driverfs:
   add struct driver_attribute, which is what should now be used instead of struct driver_file_entry
   The latter still stays around, but is used only by the driverfs core.
   'driver_attribute' more accurately reflects what is being exported. 
   Plus, by making separate structures, we can reference the same attribute structure for each object that
   exports that attribute, instead of allocating memory for and copying the same data.


Cumulative Changes:

 drivers/base/fs.c                      |  216 --------------
 Documentation/filesystems/driverfs.txt |  479 +++++++++++++++++++++++----------
 drivers/base/Makefile                  |    6 
 drivers/base/base.h                    |    8 
 drivers/base/bus.c                     |  152 ++++------
 drivers/base/driver.c                  |   41 +-
 drivers/base/fs.c                      |   39 +-
 drivers/base/fs/Makefile               |   18 -
 drivers/base/fs/bus.c                  |  207 +++++++++-----
 drivers/base/fs/device.c               |  161 ++++++++---
 drivers/base/fs/driver.c               |   56 +++
 drivers/base/fs/fs.h                   |    7 
 drivers/base/fs/lib.c                  |  378 +++++++++++++++++---------
 drivers/base/interface.c               |   15 -
 drivers/cdrom/cdrom.c                  |    5 
 drivers/pci/proc.c                     |   10 
 drivers/scsi/scsi_scan.c               |    7 
 drivers/scsi/sg.c                      |   15 -
 drivers/scsi/sr.c                      |   11 
 drivers/scsi/st.c                      |   19 -
 drivers/usb/core/usb.c                 |   29 +
 fs/driverfs/Makefile                   |    4 
 fs/driverfs/inode.c                    |  392 +++------------------------
 fs/driverfs/lib.c                      |  375 ++++++++++++++++++++++++-
 fs/partitions/check.c                  |   19 -
 include/linux/device.h                 |   29 +
 include/linux/driverfs_fs.h            |   34 +-
 27 files changed, 1568 insertions(+), 1164 deletions(-)

through these ChangeSets:

<mochel@osdl.org> (02/07/19 1.662)
   Update driverfs documentation

<mochel@osdl.org> (02/07/19 1.639.6.26)
   fs/partitions/check.c:
   s/driver_file_entry/driver_attribute/

<mochel@osdl.org> (02/07/19 1.639.6.25)
   usb driverfs files:
   s/driver_file_entry/driver_attribute/

<mochel@osdl.org> (02/07/19 1.639.6.24)
   SCSI driverfs files:
   s/driver_file_entry/driver_attribute/
   Fix previous compile errors in st.c

<mochel@osdl.org> (02/07/19 1.639.6.23)
   pci driverfs files:
   s/driver_file_entry/driver_attribute/

<mochel@osdl.org> (02/07/19 1.639.6.22)
   device model, basic files:
   s/driver_file_entry/driver_attribute/

<mochel@osdl.org> (02/07/19 1.639.6.21)
   device model symlinks:
   Change symlink creation and deletion to pass a struct driver_attribute, instead of allocating a new 
   driver_file_entry

<mochel@osdl.org> (02/07/19 1.639.6.20)
   device model driverfs interface:
   Change driver and device file creation and removal functions to take and pass a struct driver_attribute, 
   instead of a driver_file_entry

<mochel@osdl.org> (02/07/19 1.639.6.19)
   driverfs:
   add struct driver_attribute, which is what should now be used instead of struct driver_file_entry
   The latter still stays around, but is used only by the driverfs core.
   'driver_attribute' more accurately reflects what is being exported. 
   Plus, by making separate structures, we can reference the same attribute structure for each object that
   exports that attribute, instead of allocating memory for and copying the same data.

<mochel@osdl.org> (02/07/18 1.639.6.18)
   Update driverfs documentation

<mochel@osdl.org> (02/07/18 1.639.6.17)
   driverfs:
   Remove all struct device references.
   Don't touch device's reference count on open() and close()

<mochel@osdl.org> (02/07/18 1.639.6.16)
   add functions for creating/removing driverfs files for device drivers

<mochel@osdl.org> (02/07/18 1.639.6.15)
   bus driver driverfs interface:
   include fs.h
   fix compile error

<mochel@osdl.org> (02/07/18 1.639.6.14)
   Move driverfs directory creation for drivers to drivers/base/fs/driver.c

<mochel@osdl.org> (02/07/18 1.639.6.13)
   Add helpers make_one_dir and remove_one_dir for ease of creating and removing driverfs directories

<mochel@osdl.org> (02/07/18 1.639.6.12)
   fixup callers of driverfs_create_file to just pass template to it (and not do own duplication of the template)

<mochel@osdl.org> (02/07/18 1.639.6.11)
   driverfs:
   - make driverfs_create_file do duplication of driver_file_entry passed in (instead of making each caller do it)

<mochel@osdl.org> (02/07/18 1.639.6.10)
   Implement bus_{create,remove}_file, to allow creation of files for bus drivers in the bus's driverfs directory

<mochel@osdl.org> (02/07/18 1.639.6.9)
   Make root bus directory dynamically allocated, like the rest of the directories in the world...

<mochel@osdl.org> (02/07/18 1.639.6.8)
   Make sure mode is set when creating bus directory

<mochel@osdl.org> (02/07/18 1.639.6.7)
   Move functions for bus drivers interfacing with driverfs from drivers/base/bus.c to drivers/base/fs/bus.c

<mochel@osdl.org> (02/07/18 1.639.6.6)
   Move interface for creating driverfs files for devices from drivers/base/fs/lib.c to drivers/base/fs/device.c

<mochel@osdl.org> (02/07/18 1.639.6.5)
   Move drivers/base/fs.c to drivers/base/fs/lib.c

<mochel@osdl.org> (02/07/18 1.639.6.4)
   driverfs:
   - remove stray references to struct device

<greg@kroah.com> (02/07/18 1.639.6.3)
   USB: change driverfs callbacks to take void * and cast to struct device *

<mochel@osdl.org> (02/07/18 1.639.6.2)
   driverfs:
   Change named initializers from 
   	name:	value
   to
   	.name	= value

<mochel@osdl.org> (02/07/17 1.639.5.20)
   device driverfs files:
   set object pointer in directory, not for individual files

<mochel@osdl.org> (02/07/17 1.639.5.19)
   driverfs:
   - move pointer to object that owns file to driver_dir_entry, since the same object will own all files in that directory

<mochel@osdl.org> (02/07/17 1.639.5.18)
   bus directories in driverfs:
   - don't free directories, since that's done now when the dentry is deleted

<mochel@osdl.org> (02/07/17 1.639.5.17)
   driverfs:
   add d_delete callback for directories that frees driver_dir_entry, now that all users dynamically allocate it

<mochel@osdl.org> (02/07/17 1.639.5.16)
   driver directories in driverfs:
   dynamically allocate directories

<mochel@osdl.org> (02/07/17 1.639.5.15)
   bus symlinks in driverfs:
   make sure we use right pointer to parent when creating symlink

<mochel@osdl.org> (02/07/17 1.639.5.14)
   bus driver directories:
   - make sure we get parent right when creating directories
   - make sure we memset them when we allocate them

<mochel@osdl.org> (02/07/17 1.639.5.13)
   bus drivers:
   - make bus's directories dynamically allocated. 
   - update creation and deletion functions to handle that

<mochel@osdl.org> (02/07/17 1.639.5.12)
   devices:
   - make struct device::dir dynamically allocated, instead of static
   - change functions that use it to treat it as such

<mochel@osdl.org> (02/07/17 1.639.5.11)
   fs/partitions/check.c:
   change calls to device_remove_file to take pointer to driver_file_entry, instead of just the name

<mochel@osdl.org> (02/07/17 1.639.5.10)
   drivers/scsi/sg.c:
   change call device_remove_file to take pointer to the driver_file_entry, insetad of the name

<mochel@osdl.org> (02/07/17 1.639.5.9)
   #ifdef out this code that removes driverfs files that it didn't create. 
   That sounds buggy...

<mochel@osdl.org> (02/07/17 1.639.5.8)
   device model:
   - change device_remove_file to take pointer to driver_file_entry instead of char * to match change in driverfs interface
   - implement device_remove_symlink, that manaualy searches dir's list of files to obtain a struct driver_file_entry to pass to driverfs_remove_file

<mochel@osdl.org> (02/07/17 1.639.5.7)
   driverfs - 
   Change driverfs_remove_file to take struct driver_file_entry * instead of char *
   Walk list of dir's files to find matching entry (so entry passed in can be re-used for multiple objects) on file removal
   But, now creation and removal take the same parameter

<mochel@osdl.org> (02/07/17 1.639.5.6)
   fs/partitions/check.c
   Change driverfs callbacks to take void * and cast to struct device *

<mochel@osdl.org> (02/07/17 1.639.5.5)
   drivers/scsi/*c:
   Change driverfs callbacks to take void * and cast to struct device *

<mochel@osdl.org> (02/07/17 1.639.5.4)
   drivers/pci/proc.c:
   Change driverfs callbacks to take void * and cast to struct device *

<mochel@osdl.org> (02/07/17 1.639.5.3)
   driverfs/base/interface.c:
   Change driverfs callbacks to take void * and cast to struct device

<mochel@osdl.org> (02/07/17 1.639.5.2)
   driverfs:
   - Add void * object pointer in driver_file_entry
   - Change show() and store() callbacks to take a void *, instead of struct device *
   - Use object pointer in read() and write() instead of doing list_entry on the driver_file_entry
   - Make sure that device_create_file sets object pointer when creating a file

<mochel@osdl.org> (02/07/15 1.639.5.1)
   driverfs:
   split apart kernel interface from the standard file operations


