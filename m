Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTDPApd (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 20:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264180AbTDPApc 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 20:45:32 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:42212 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264178AbTDPApU 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 20:45:20 -0400
Date: Wed, 16 Apr 2003 02:57:10 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: linux-kernel@vger.kernel.org
Subject: firmware separation filesystem (fwfs)
Message-ID: <20030416005710.GB29682@ranty.ddts.net>
Reply-To: ranty@debian.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Hello all,

 A little context: I am writing support for Orinoco USB devices, and
 they require some firmware to work. But I got the firmware from
 communication dumps and a windows .sys file, which doesn't qualify for
 redistribution.

 After reading the linux-kernel thread started by Pavel Roskin I
 implemented a little filesystem for this purpose. It was based on
 ramfs.  And after some feedback from Pavel Roskin and David Gibson it
 became what it is now. I'll try to make a resume:

 I couldn't find the blobs support patch that someone talked about, so I
 did it myself. I called it 'fwfs' for obvious reasons, but I would
 gladly change the name for something more general if required.

 The idea is making the filesystem as simple as possible and making it
 as easy and codeless as possible to be used from drivers.

 From userspace it would be as simple as:

 # mount -t fwfs fwfs /firmware/
 # cp my_firmware_data /firmware/orinoco_ezusb_fw
 # modprobe orinoco_usb

 On the simplest case the usage could be:

        static const struct fwfs_entry *fwfs_entry;

        int init_module(void)
        {
                fwfs_entry = fwfs_get("orinoco_ezusb_fw")
                if(!fwfs_entry)
                        -EAGAIN;
                /* fwfs_entry->size holds the size of the firmware */
                /* fwfs_entry->data holds a pointer to the firmware data */
                /* Both will be there until we fwfs_put it so we don't
                 * even have to copy it */
        }

        void exit_module(void)
        {
                fwfs_put(fwfs_entry);
        }

 In its current implementation, to get dynamic firmware updates, what I
 do in orinoco_usb.c is:

        static const struct fwfs_entry *fwfs_entry;

        static void * skel_probe(struct usb_device *udev, unsigned int
                                 ifnum, const struct usb_device_id *id)
        {
                const struct fwfs_entry *fwfs_entry_new;


                if((fwfs_entry_new = fwfs_get("orinoco_ezusb_fw"))){
                        fwfs_put(fwfs_entry);
                        if (fwfs_entry != fwfs_entry_new){
                                fwfs_entry = fwfs_entry_new;
                                firmware.size = fwfs_entry->size;
                                firmware.code = fwfs_entry->data;
                                find_fw_variant_offset(&firmware);
                        }
                }
        }
        int init_module(void)
        {
        	if(firmware.size)
                	fwfs_write_default("orinoco_ezusb_fw", firmware.code,
                        	           firmware.size);
	}
        void exit_module(void)
        {
                fwfs_put(fwfs_entry);
        }

 With the second, you can copy a new firmware from userspace and it
 gets used for the next device you plug.

 Interesting ideas:
 	- Integrate something like this with sysfs.
		- It looks like sysfs is limited in size to PAGE_SIZE,
		  which wouldn't be appropriate here.
        - allow registering a callback with fwfs to get informed when
          the firmware gets loaded/updated from userspace.
        - Transparently calling a userspace helper if there is no entry
          with the specified name.
	- implement a modified version of insmod that would  load any
	  binary as module with any given name.
	- Make the drivers read directly from the page cache, although
	  that would complicate the interface. An alternative interface
	  could be added, so drivers with huge firmwares could expend a
	  little more code and save some memory.

>From the linux-kernel thread:
> 1) Register a file on procfs and use "cat" to load the firmware into
> the
>    kernel.
>
> 2) Register a device for the same purpose.
>
> 3) Register a device, but use ioctl().
>
> 4) Open a network socket and use ioctl() on it (like ifconfig does).
[snip]
> 7) Encode the firmware into a header file, add it to the driver and
>    pretend that the copyright issue doesn't exist (like it's done in
>    the
>    Keyspan USB driver).

 This implementation is equivalent to 1), 2), 3) and 4) but involves
 less code on the driver. And has very simple userspace like 1) and 2).

 7) A default firmware can be included in a header and registered via
 fwfs_write_default(), this:
	- gives userspace access to the inkernel image.
	- makes it easy to update it at runtime.
	- enables the Debian guys to remove the firmware without
	  removing the whole driver.

Pavel Roskin wrote:
> I believe the reply will be that it's 2.7 material.  You could consider
> variants when an existing filesystem is reused as the file repository
> for drivers - it could increase chances that something will be done
> before 2.6 kernel.

 I removed all the filesystem code, and used ramfs directly as storage,
 just giving it the "fwfs" name for mounting from userspace.

David Gibson wrote:
> I think it would be better to leave the image in the page cache, and
> just put it together when the driver actually uses it.  It might make
> the driver interface a bit more complicated, but I think it's worth
> it.  And actually it shouldn't be too bad, because you could use
> vmalloc()-like methods to make a virtually contiguous mapping of the
> pages from the page cache.

 All kinds of comments/suggestions/criticism are welcomed.

 Have a nice day

 	ranty
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--61jdw2sOBCFtR2d/
Content-Type: text/x-chdr; charset=us-ascii
Content-Disposition: inline; filename="fwfs.h"

#ifndef _LINUX_FWFS_H
#define _LINUX_FWFS_H
struct fwfs_entry {
	size_t size;
	u8 *data;
	/* the rest is private */
	atomic_t use_count;
	struct dentry *dentry;
	time_t ctime;
};
const struct fwfs_entry *fwfs_get(const char *name);
void fwfs_put(const struct fwfs_entry *entry);
void fwfs_write_default(const char *name, const u8 *data, size_t size);

#endif

--61jdw2sOBCFtR2d/
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: inline; filename="fwfs.c"

/* firmware filesystem 
 *
 * Copyright (C) 2003 Manuel Estrada Sainz <ranty@debian.org>.
 * 
 */

/* The main idea is making it easy both to users and driver developers to
 * provide binary firmware from userspace to the kernel drivers.
 * Although any other kind of binary data could be handled */

#include <linux/module.h>
#include <linux/fs.h>
#include <linux/pagemap.h>
#include <linux/init.h>
#include <linux/string.h>
#include <linux/locks.h>
#include <linux/types.h>
#include <linux/slab.h>
#include <linux/spinlock.h>
#include <asm/uaccess.h>

#include "fwfs.h"

static struct vfsmount *fwfs_mnt;
static spinlock_t fwfs_lock = SPIN_LOCK_UNLOCKED;

static struct fwfs_entry *fwfs_grab_image(struct inode *inode,
					  struct dentry *dentry);

/* Refcounting fwfs_entrys is probably not worth it.
 * In the general case, there will be just one client per entry, so allocating
 * on fwfs_get and freeing on fwfs_put should be good enough.
 * But since I wrote it, here it is for consideration. */

static void put_entry(struct fwfs_entry *entry)
{
	spin_lock(&fwfs_lock);
	if (entry && atomic_dec_and_test(&entry->use_count)){
		if(entry->dentry->d_inode->u.generic_ip == entry)
			entry->dentry->d_inode->u.generic_ip = NULL;
		kfree(entry->data);
		kfree(entry);
	}
	spin_unlock(&fwfs_lock);
}

static struct fwfs_entry *get_entry(struct inode *inode)
{
	struct fwfs_entry *entry;
	spin_lock(&fwfs_lock);
	entry = inode->u.generic_ip;
	if(entry){
		atomic_inc(&entry->use_count);
	}
	spin_unlock(&fwfs_lock);
	return entry;
}
static struct fwfs_entry *alloc_entry(size_t size)
{
	struct fwfs_entry *entry = kmalloc(sizeof(struct fwfs_entry),
					   GFP_KERNEL);
	if(entry){
		entry->dentry = NULL;
		atomic_set(&entry->use_count, 1);
		entry->size = size;
		if(size){
			entry->data = kmalloc(size, GFP_KERNEL);
			if(!entry->data){
				kfree(entry);
				entry = NULL;
			}
		} else {
			entry->data = NULL;
		}
	}
	return entry;
}

static struct fwfs_entry *entry_lookup(const char *str_name)
{
	struct dentry *dentry;
	struct dentry *parent = dget(fwfs_mnt->mnt_root);
	struct qstr name= {str_name, strlen(str_name), 0};
	struct fwfs_entry *entry;

	name.hash = full_name_hash(name.name, name.len);
	dentry = d_lookup(parent, &name);
	dput(parent);
	if(!dentry)
		return NULL;
	if (!dentry->d_inode){
		dput(dentry);
		return NULL;
	}
	entry = fwfs_grab_image(dentry->d_inode, dentry);
	if (!entry)
		dput(dentry);
	return entry;
}

const struct fwfs_entry *fwfs_get(const char *name)
{
	struct fwfs_entry *entry;

	entry = entry_lookup(name);
	if (entry && !entry->data){
		dput(entry->dentry);
		entry = NULL;
	}
	return entry;
}
void fwfs_put(const struct fwfs_entry *entry)
{
	if(entry){
		struct dentry *dentry = entry->dentry;
		put_entry((struct fwfs_entry *)entry);
		dput(dentry);
	}
}

static struct fwfs_entry *fwfs_grab_image(struct inode *inode,
					  struct dentry *dentry)
{
	struct fwfs_entry *fwfs_entry_old = get_entry(inode);
	struct fwfs_entry *fwfs_entry;
	struct address_space *mapping = inode->i_mapping;
	unsigned long index, end_index;

	down(&inode->i_sem);

	if(fwfs_entry_old && inode->i_ctime == fwfs_entry_old->ctime){
		printk("fwfs_entry is up to date\n");
		up(&inode->i_sem);
		return fwfs_entry_old;
	}

#if 0
	/* There is a race here, if userspace is writing the file
	   while we read it, we can get just a piece of it.

	   Locking i_sem is not enough.

	   The following looks neat to me, but I don't have a file
	   pointer to do it.

	   I would appreciate any sugestions.
	*/
	while (deny_write_access(struct file)){
		set_current_state(TASK_UNINTERRUPTIBLE);
		schedule_timeout(HZ);
	}
	/* get the data */
	allow_write_access(struct file);
#else
	/* This at least reduces the chances of the problem */
	while (atomic_read(&inode->i_writecount) > 0) {
		printk(KERN_WARNING "fwfs: inode busy\n");
		set_current_state(TASK_UNINTERRUPTIBLE);
		schedule_timeout(HZ);
	}
#endif

	fwfs_entry = alloc_entry(inode->i_size);
	if(!fwfs_entry){
		up(&inode->i_sem);
		return fwfs_entry_old;
	}
	fwfs_entry->dentry = dentry;
	fwfs_entry->ctime = inode->i_ctime;
	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
	for (index=0; index <= end_index; index++) {
		struct page *page, **hash;
		unsigned long bytes;
		u8 *buf = fwfs_entry->data + index * PAGE_CACHE_SIZE;


		bytes = PAGE_CACHE_SIZE;
		if (index == end_index) {
			bytes = inode->i_size & ~PAGE_CACHE_MASK;
			if(!bytes)
				break;
		}

		/* in ramfs, the data is always in the page cache , right? */
		hash = page_hash(mapping, index);
		page = __find_get_page(mapping, index, hash);
		BUG_ON(!Page_Uptodate(page));

		memcpy(buf, kmap(page), bytes);
		kunmap(page);

		page_cache_release(page);
	}
	UPDATE_ATIME(inode);

	put_entry(fwfs_entry_old);
	spin_lock(&fwfs_lock);
	inode->u.generic_ip=fwfs_entry;
	spin_unlock(&fwfs_lock);
	up(&inode->i_sem);
	return fwfs_entry;
}

int fwfs_write_image(struct inode *inode, const u8 *buf, size_t size)
{
	struct address_space *mapping = inode->i_mapping;
	loff_t          pos = 0;
	struct page     *page, *cached_page=NULL;
	long            retval = 0;
	unsigned        bytes;

	down(&inode->i_sem);

	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
	mark_inode_dirty_sync(inode);
	do {
		unsigned long index;
		char *kaddr;
		index = pos >> PAGE_CACHE_SHIFT;
		bytes = PAGE_CACHE_SIZE;
		if (bytes > size)
			bytes = size;
		page = grab_cache_page(mapping, index);
		if (!page){
			retval = -ENOMEM;
			break;
		}
		BUG_ON (!PageLocked(page));
		kaddr = kmap(page);
		/* prepare_write and commit_write never fail in ramfs, and
		 * they don't use the 'file' argument */
		mapping->a_ops->prepare_write(NULL, page, 0, bytes);
		memcpy(kaddr, buf, bytes);
		flush_dcache_page(page);
		mapping->a_ops->commit_write(NULL, page, 0, bytes);
		size -= bytes;
		pos += bytes;
		buf += bytes;
		
		kunmap(page);
		SetPageReferenced(page);
		UnlockPage(page);
		page_cache_release(page);
	} while (size);

	if (cached_page)
		page_cache_release(cached_page);

	up(&inode->i_sem);
	return retval;
	
}
void fwfs_write_default(const char *name, const u8 *data, size_t size)
{
	struct dentry * dentry;
	struct dentry * parent = fwfs_mnt->mnt_root;
	int error;
	struct qstr d_name = { name, strlen(name) };
	d_name.hash = full_name_hash(d_name.name, d_name.len);

	down(&parent->d_inode->i_sem);
	dentry = lookup_hash(&d_name, parent);
	if(dentry->d_inode){
		/* We already have an image */
		printk("we already have %s\n", name);
		goto up_parent;
	}
	error = vfs_create(parent->d_inode, dentry, 0644);
	if(error){
		printk("%d\n", error);
		goto up_parent;
	}
	if((error = fwfs_write_image(dentry->d_inode, data, size)))
		printk("fwfs_write_image: status %d\n", error);
	
up_parent:
	up(&parent->d_inode->i_sem);
	dput(dentry);
	return;
}
EXPORT_SYMBOL(fwfs_get);
EXPORT_SYMBOL(fwfs_put);
EXPORT_SYMBOL(fwfs_write_default);

static DECLARE_FSTYPE(fwfs_fs_type, "fwfs", NULL,
		      FS_LITTER|FS_SINGLE);

static int can_unload (void)
{
	/* kern_mount makes the module busy for ever, so I have to keep track
	 * of busyness myself */
	int usecount = atomic_read(&THIS_MODULE->uc.usecount);
	int s_active = atomic_read(&fwfs_mnt->mnt_sb->s_active);

	if (usecount == 1 && s_active == 1)
		/* both will go on kern_umount */
		return 0;
	
	return usecount;
}

static int __init init_fwfs_fs(void)
{
	int err;
	struct file_system_type *ramfs_fs_type = get_fs_type("ramfs");

	if (!ramfs_fs_type)
		return -ENOENT;

	fwfs_fs_type.read_super = ramfs_fs_type->read_super;

	err = register_filesystem(&fwfs_fs_type);
	if (err)
		return err;
	fwfs_mnt = kern_mount(&fwfs_fs_type);
	if (IS_ERR(fwfs_mnt)){
		unregister_filesystem(&fwfs_fs_type);
		return PTR_ERR(fwfs_mnt);
	}
	THIS_MODULE->can_unload = can_unload;
	return 0;
}

static void __exit exit_fwfs_fs(void)
{
	kern_umount(fwfs_mnt);
	BUG_ON(MOD_IN_USE);
	unregister_filesystem(&fwfs_fs_type);
}

module_init(init_fwfs_fs)
module_exit(exit_fwfs_fs)


MODULE_LICENSE("GPL");


--61jdw2sOBCFtR2d/--
