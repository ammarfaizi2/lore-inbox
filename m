Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317083AbSGHSmQ>; Mon, 8 Jul 2002 14:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSGHSmP>; Mon, 8 Jul 2002 14:42:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7040 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317083AbSGHSmL>;
	Mon, 8 Jul 2002 14:42:11 -0400
Date: Mon, 8 Jul 2002 11:41:52 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Driverfs updates
Message-ID: <Pine.LNX.4.33.0207051554580.961-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quick Summary

- Add struct module * owner field to struct device_driver
- Change {get,put}_driver to use it

- Add void * object to struct driver_file_entry that points to owner of 
  file.
- Add struct driverfs_subsys with {get,put}_object callbacks to do generic 
  reference counting on file open/release

- Convert driverfs interface to struct devices to use above mechnanism
- Add 'bindings' between struct device_driver and struct bus_type, using 
  above mechanism to do proper reference counting on objects. 

Pull from bk://ldm.bkbits.net/linux-2.5-driverfs

Patch also available from:

http://kernel.org/pub/linux/kernel/people/mochel/patches/driverfs-patch-08072002.gz


Changelog and diffstat appended. 

Explanation:

driverfs currently does reference counting on struct device on file open() 
and release(). It accesses the device by doing a list_entry on the 
parent directory entry of the driver_file_entry (which is in the inode's 
u.generic_ip). 

This works fine, but is not very extensible to other objects that we want 
to export files for, like struct device_driver. One way to do it is create 
separate open/release callbacks for each object type that does a similar
list_entry. But, I considered that bulky and instead genericized a sole 
pair of open and release calls. 

To make it work for all objects, I added 

        void    * object;

to struct driver_file_entry, and created 

struct driverfs_subsys {
        int     (*get_object)(void * obj);
        void    (*put_object)(void * obj);
};

and 
        struct driverfs_subsys  * subsys;

in struct driver_dir_entry to do reference counting on that object.

Wait, come back; it should work. 


Each type of object that is represented in driverfs gets a directory that 
is created when registered with the subsystem they belong to. When this 
directory is created, the subsystem is responsible for setting the 
subsys pointer in the directory entry. 

To create files, there should be wrapper functions for each type of object 
that take an explicit pointer to that object. E.g. 

device_create_file
driver_create_file
etc. 

The subsystem is responsibile for setting the object pointer on file 
creation. 

During open(), we get the driver_file_entry from the inode's u.generic_ip. 
>From that, we get the parent driver_dir_entry and the subsys structure. We 
pass the driver_file_entry::object to the subsys's get_object() callback. 
The subsystem pins the object in memory, and life is a bit happier. 

On release, we do the same in order to call put_object().

Having get/set functions that take opaque pointers can appear to 
completely sacrifice type-safety. However, the fact that the only thing we 
have to work with initially is an opaque pointer in u.generic_ip makes 
that point, IMHO. 

Plus, the driverfs code never relies on the validity of that pointer. It 
simply passes it back to the subsystem to verify it and refcount. It's the 
sole responsibility of the subsystem to not do something stupid. 

It is possible to change the contents of the object pointer, the
driver_file_entry, or the inode after the file has been created. But, if
you aim the gun at your foot, and your finger slips off the trigger, it's
not my fault...


Anyway, it is now really easy to extend driverfs to support any type of   
object. To add 'bindings' for a particular object type, it is literally   
about 45 lines (excluding comments). See drivers/base/fs/*.c for examples.


Concerning reference counting on objects that aren't devices; i.e.  
drivers: Drivers can be modular, and the refcount wasn't tied to the
module refcount. I went around a few times with Kai about this, about a
month ago. What I ended doing was adding an owner field to the
device_driver structure, and using that to do refcounting.

During normal operation, the refcount stays at 0, so the module can be 
removed. During any access to the driver, it bumps up the refcount. (This 
likely still suffers from the same module race conditions, but it's a step 
in the right direction.)


I've also updated the driverfs documentation to reflect the recent changes 
and removed most gross inaccuracies. 


	-pat


ChangeSet@1.447.23.1, 2002-06-10 09:12:20-07:00, mochel@osdl.org
  driver refcounting:
  Make {get,put}_driver simply wrappers for touching module reference count
  Get rid of driver's release callback
  Rename remove_driver to driver_unregister

diffstat results: 
 drivers/base/driver.c    |   53 +++++++++++++++++++++++------------------------
 drivers/pci/pci-driver.c |    2 -
 include/linux/device.h   |   14 ++----------
 3 files changed, 31 insertions, 38 deletions

ChangeSet@1.604.3.13, 2002-07-03 13:40:09-07:00, mochel@osdl.org
  Don't set module owner in driver_register, that's just dumb. Drivers need to do it explicitly. 

diffstat results: 
 drivers/base/driver.c |    1 -
 1 files changed, 1 deletion

ChangeSet@1.604.3.14, 2002-07-03 13:59:55-07:00, mochel@osdl.org
  driverfs: Break out file creation functions from inode.c into lib.c

diffstat results: 
 fs/driverfs/Makefile |    4 
 fs/driverfs/inode.c  |  278 -------------------------------------------------
 fs/driverfs/lib.c    |  289 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 292 insertions, 279 deletions

ChangeSet@1.604.3.15, 2002-07-03 14:21:45-07:00, mochel@osdl.org
  driverfs:
  - typedef show and store callbacks in driver_file_entry
  - Add an object pointer that points to the object that owns the file

diffstat results: 
 include/linux/driverfs_fs.h |    9 +++++++--
 1 files changed, 7 insertions, 2 deletions

ChangeSet@1.604.3.16, 2002-07-03 14:22:41-07:00, mochel@osdl.org
  driverfs file creation for devices:
  Set the object pointer in the struct driver_file_entry when creating a file for the device

diffstat results: 
 drivers/base/fs.c |    2 ++
 1 files changed, 2 insertions

ChangeSet@1.604.3.17, 2002-07-03 14:24:04-07:00, mochel@osdl.org
  driverfs:
  - Use the object field of struct driver_file_entry when calling the owner's show and store callbacks
  - Use the object field on open and release, instead of using list_entry

diffstat results: 
 fs/driverfs/inode.c |   14 ++++----------
 1 files changed, 4 insertions, 10 deletions

ChangeSet@1.604.3.18, 2002-07-03 15:31:56-07:00, mochel@osdl.org
  driverfs:
  - add driverfs_subsys to describe a subsystem that owns a class of objects that are represented in driverfs
  Previously, all directories in driverfs mapped to struct device's. This assumption was used to do reference 
  counting on the devices. They were also passed to the show and store callbacks of the file owners. 
  
  However, now we want to be able to add files for other types of objects. We want to do reference counting on these 
  objects, and pass them downstream. The show and store callbacks were modified to take void *, instead of creating
  a different type of show and store for each type of object that can have files. 
  
  Reference counting takes place in file open and release. Instead of defining a completely separate open and release
  for each subsystem or type of object, I've implemented only what we need - callbacks to increment and decrement
  the reference count of the target objects. 
  
  It's assumed that each object that has presence in driverfs has a directory. When this directory is created (by the
  subsystem that owns it), it the subsys field needs to be set appropriately. 
  

diffstat results: 
 include/linux/driverfs_fs.h |    6 ++++++
 1 files changed, 6 insertions

ChangeSet@1.604.3.19, 2002-07-03 15:37:54-07:00, mochel@osdl.org
  driverfs:
  Use the driverfs_subsys types in open and release to do reference counting on the object that owns the file
  It tries to be stringent about the whole situation:
  - Return an error if 
  	- no subsys is present
  	- get_object() fails (returns 0)
  - Don't return error if 
  	- get_object() isn't implemented (no ref counting on objects)
  	- get_object() returns 1
  
  On release, it's assumed the subsys pointer is valid, since we wouldn't have allowed file open if it wasn't.

diffstat results: 
 fs/driverfs/inode.c |   31 ++++++++++++++++++++++---------
 1 files changed, 22 insertions, 9 deletions

ChangeSet@1.604.3.20, 2002-07-03 15:39:08-07:00, mochel@osdl.org
  device <-> driverfs interface:
  Declare a driverfs_device_subsys, complete with get_object and put_object callbacks
  Set the pointer in device's directory entry when their directory is created

diffstat results: 
 drivers/base/fs.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions

ChangeSet@1.604.3.21, 2002-07-03 16:58:18-07:00, mochel@osdl.org
  device model:
  Move driverfs interface (fs.c) to drivers/base/fs/

diffstat results: 
 drivers/base/fs.c        |  217 -----------------------------------------------
 drivers/base/Makefile    |    4 
 drivers/base/fs/Makefile |    5 +
 drivers/base/fs/fs.c     |  217 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 225 insertions, 218 deletions

ChangeSet@1.604.3.22, 2002-07-03 17:04:29-07:00, mochel@osdl.org
  device model - driverfs bindings:
  Move device <-> driverfs binding to separate file; pave way for new bindings to come 

diffstat results: 
 drivers/base/fs/Makefile |    4 -
 drivers/base/fs/device.c |  127 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/fs/fs.c     |  116 ------------------------------------------
 drivers/base/fs/fs.h     |    5 +
 4 files changed, 134 insertions, 118 deletions

ChangeSet@1.604.3.23, 2002-07-03 17:42:02-07:00, mochel@osdl.org
  device model:
  - move driverfs <-> bus bindings into drivers/base/fs/bus.c
  - add helpers to create/remove files for buses

diffstat results: 
 drivers/base/base.h      |    3 +
 drivers/base/bus.c       |   38 -----------------
 drivers/base/fs/Makefile |    4 -
 drivers/base/fs/bus.c    |  105 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions, 39 deletions

ChangeSet@1.604.3.24, 2002-07-03 17:54:20-07:00, mochel@osdl.org
  device model driverfs bindings:
  Implement device_dup_file for use by various specific bindings:
  - allocate new driver_file_entry
  - copy template in
  - create driverfs file
  - return error to caller

diffstat results: 
 drivers/base/fs/bus.c    |   22 +++++-----------------
 drivers/base/fs/device.c |   24 ++++++------------------
 drivers/base/fs/fs.c     |   18 ++++++++++++++++++
 drivers/base/fs/fs.h     |    2 ++
 4 files changed, 31 insertions, 35 deletions

ChangeSet@1.604.3.25, 2002-07-05 13:55:01-07:00, mochel@osdl.org
  device model <-> driverfs bindings
  Rename device_dup_file to common_create_file
  Make it inc/dec reference count on object that's passed in
  Add common_remove_file that touches reference count of object and calls driverfs to remove file

diffstat results: 
 drivers/base/fs/fs.c |   35 +++++++++++++++++++++++++----------
 drivers/base/fs/fs.h |    3 ++-
 2 files changed, 27 insertions, 11 deletions

ChangeSet@1.604.3.26, 2002-07-05 13:57:30-07:00, mochel@osdl.org
  Add device driver <-> driverfs bindings

diffstat results: 
 drivers/base/base.h      |    3 ++
 drivers/base/driver.c    |   10 -------
 drivers/base/fs/driver.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions, 10 deletions

ChangeSet@1.604.3.27, 2002-07-05 13:58:13-07:00, mochel@osdl.org
  add driver.o target in drivers/base/fs/

diffstat results: 
 drivers/base/fs/Makefile |    4 ++--
 1 files changed, 2 insertions, 2 deletions

ChangeSet@1.604.3.28, 2002-07-05 13:59:26-07:00, mochel@osdl.org
  device model, bus drivers
  Convert bus_create_file to use common_create_file and bus_remove_file to use common_remove_file (and let them handle reference counting)
  Export bus_{create,remove}_file

diffstat results: 
 drivers/base/fs/bus.c |   19 +++++--------------
 1 files changed, 5 insertions, 14 deletions

ChangeSet@1.604.3.29, 2002-07-05 14:00:42-07:00, mochel@osdl.org
  Convert device_{create,remove}_file to use common_{create,remove}_file

diffstat results: 
 drivers/base/fs/device.c |   24 +++++++-----------------
 1 files changed, 7 insertions, 17 deletions

ChangeSet@1.604.3.30, 2002-07-05 14:01:40-07:00, mochel@osdl.org
  Add prototypes for {bus,driver}_{create,remove}_file to include/linux/device.h

diffstat results: 
 include/linux/device.h |    8 ++++++++
 1 files changed, 8 insertions

ChangeSet@1.604.3.31, 2002-07-05 15:54:13-07:00, mochel@osdl.org
  Rewrite driverfs documentation

diffstat results: 
 Documentation/filesystems/driverfs.txt |  366 ++++++++++++++++++++++-----------
 1 files changed, 251 insertions, 115 deletions


