Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVDZDeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVDZDeg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 23:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVDZDec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 23:34:32 -0400
Received: from webmail.houseafrika.com ([12.162.17.52]:23199 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261303AbVDZDbO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 23:31:14 -0400
Date: Mon, 25 Apr 2005 20:31:10 -0700
From: Libor Michalek <libor@topspin.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050425203110.A9729@topspin.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <20050412180447.E6958@topspin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050412180447.E6958@topspin.com>; from libor@topspin.com on Tue, Apr 12, 2005 at 06:04:47PM -0700
X-OriginalArrivalTime: 26 Apr 2005 03:31:10.0282 (UTC) FILETIME=[63B75AA0:01C54A10]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 12, 2005 at 06:04:47PM -0700, Libor Michalek wrote:
> On Mon, Apr 11, 2005 at 05:13:47PM -0700, Andrew Morton wrote:
> > Roland Dreier <roland@topspin.com> wrote:
> > >
> > >     Troy> Do we even need the mlock in userspace then?
> > > 
> > > Yes, because the kernel may go through and unmap pages from userspace
> > > while trying to swap.  Since we have the page locked in the kernel,
> > > the physical page won't go anywhere, but userspace might end up with a
> > > different page mapped at the same virtual address.
> 
> With the last few kernels I haven't had a chance to retest the problem
> that pushed us in the direction of using mlock. I will go back and do
> so with the latest kernel. Below I've given a quick description of the
> issue.
> 
> > That shouldn't happen.  If get_user_pages() has elevated the refcount on a
> > page then the following can happen:
> > 
> > - The VM may decide to add the page to swapcache (if it's not mmapped
> >   from a file).
> > 
> > - Once the page is backed by either swapcache of a (mmapped) file, the VM
> >   may decide the unmap the application's pte's.  A later minor fault by the
> >   app will cause the same physical page to be remapped.
> 
> The driver did use get_user_pages() to elevated the refcount on all the
> pages it was going to use for IO, as well as call set_page_dirty() since
> the pages were going to have data written to them from the device.
> 
> The problem we were seeing is that the minor fault by the app resulted
> in a new physical page getting mapped for the application. The page that
> had the elevated refcount was still waiting for the data to be written
> to by the driver at the time that the app accessed the page causing the
> minor fault. Obviously since the app had a new mapping the data written
> by the driver was lost.
> 
> It looks like code was added to try_to_unmap_one() to address this, so
> hopefully it's no longer an issue...

  I wrote a quick test module and program to confirm that the problem
we saw in older kernels with get_user_pages() no longer exists. The
module creates a character device with three different ioctl commands:

  - Pin the pages of a buffer using get_user_pages()
  - Check the pages by calling get_user_pages() a second time and
    comparing the new and original page list.
  - Relase the pages using put_page()

  The program opens the charcter device file descriptor, pins the pages
and waits for a signal, before checking the pages, which is sent to the
process after running some other program which exercises the VM. On older
kernels the check fails, on my 2.6.11 kernel the check succeeds. So
mlock is not needed on top of get_user_pages() as it was before.

  Thanks for the heads up.

  Module and program attached.

-Libor

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mltest.c"

/*
 * Copyright (c) 2005 Topspin Communications.  All rights reserved.
 *
 * This software is available to you under a choice of one of two
 * licenses.  You may choose to be licensed under the terms of the GNU
 * General Public License (GPL) Version 2, available from the file
 * COPYING in the main directory of this source tree, or the
 * OpenIB.org BSD license below:
 *
 *     Redistribution and use in source and binary forms, with or
 *     without modification, are permitted provided that the following
 *     conditions are met:
 *
 *      - Redistributions of source code must retain the above
 *	copyright notice, this list of conditions and the following
 *	disclaimer.
 *
 *      - Redistributions in binary form must reproduce the above
 *	copyright notice, this list of conditions and the following
 *	disclaimer in the documentation and/or other materials
 *	provided with the distribution.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * $Id: $
 */
#include <linux/init.h>
#include <linux/fs.h>
#include <linux/module.h>
#include <linux/device.h>
#include <linux/err.h>
#include <linux/poll.h>
#include <linux/file.h>
#include <linux/mount.h>
#include <linux/cdev.h>
#include <linux/devfs_fs_kernel.h>

#include <asm/uaccess.h>
#include <asm/highmem.h>

	
MODULE_AUTHOR("Libor Michalek");
MODULE_DESCRIPTION("Get pages test");
MODULE_LICENSE("GPL");

enum {
	TEST_MAJOR = 232,
	TEST_MINOR = 255
};

#define TEST_DEV MKDEV(TEST_MAJOR, TEST_MINOR)

enum {
	TEST_CMD_REGISTER   = 1,
	TEST_CMD_UNREGISTER = 2,
	TEST_CMD_CHECK      = 3
};

struct ioctl_arg {
	__u64 addr;
	__u64 size;
};

struct region_root {
	struct semaphore mutex;
	struct list_head regions; /* list of pending events. */
	struct file *filp;
	int nr_region;
};

struct test_region {
	unsigned long user;
	unsigned long addr;
	unsigned long size;
	int  nr_pages;
	struct page **pages;
	struct region_root *root;
	struct list_head region_list; /* member in root region list */
};

static void test_unlock(struct test_region *region)
{
        long i;

	list_del(&region->region_list);

        for (i = 0; i < region->nr_pages; i++)
                put_page(region->pages[i]);

	printk(KERN_ERR "TEST: Unlocked address <%016lx>\n", region->user);

	kfree(region->pages);
	kfree(region);
}

static struct test_region *test_lookup(struct region_root *root,
				       unsigned long addr)
{
	struct test_region *region;

	list_for_each_entry(region, &root->regions, region_list)
		if (region->user == addr)
			return region;

	return NULL;
}

static int test_lock(struct region_root *root,
		     unsigned long uaddr,
		     unsigned long size)
{
	struct test_region *region;
	int nr_pages;
	int result;

	region = kmalloc(sizeof(*region), GFP_KERNEL);
	if (!region)
		return -ENOMEM;

	region->user = uaddr;
	region->addr = uaddr & PAGE_MASK;
	region->size = PAGE_ALIGN(size + (uaddr & ~PAGE_MASK));
	region->root = root;

        nr_pages = (region->size + PAGE_SIZE-1) >> PAGE_SHIFT;

	region->pages = kmalloc(sizeof(struct page *) * nr_pages, GFP_KERNEL);
	if (!region->pages) {

		result = -ENOMEM;
		goto page_err;
	}

        region->nr_pages = get_user_pages(current, current->mm,
					  region->addr,
					  nr_pages,
					  1, 0, 
					  region->pages, NULL);
	if (region->nr_pages != nr_pages) {
		result = -EFAULT;
		goto get_err;
	}

	list_add_tail(&region->region_list, &root->regions);

	printk(KERN_ERR "TEST:   Locked address <%016lx>\n", region->user);

	return 0;
get_err:
	kfree(region->pages);
page_err:
	kfree(region);
	return result;
}

static int test_check(struct test_region *region)
{
	struct page **pages;
	int nr_pages;
	int result = 0;
	int i;

	pages = kmalloc(sizeof(struct page *) * region->nr_pages, GFP_KERNEL);
	if (!pages)
		return -ENOMEM;

        nr_pages = get_user_pages(current, current->mm,
				  region->addr,
				  region->nr_pages,
				  1, 0, 
				  pages, NULL);
	if (region->nr_pages != nr_pages) {
		result = -EFAULT;
		goto get_err;
	}

	for (i = 0; i < nr_pages; i++) {

		if (region->pages[i] != pages[i])
			printk(KERN_ERR "TEST: Check error <%p:%p> "
			       "page <%u> of <%u>\n",
			       pages[i], region->pages[i], i, nr_pages);
		put_page(pages[i]);
	}

get_err:
	kfree(pages);
	return result;
}

static long test_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
{
	struct region_root *root = filp->private_data;
	struct test_region *region;
	struct ioctl_arg    ureq;
	int result = 0;

	if (!root)
		return -EINVAL;

        if (copy_from_user(&ureq, (void __user *)arg, sizeof(ureq)))
                return -EFAULT;

	down(&root->mutex);

	switch (cmd) {
	case TEST_CMD_REGISTER:

		result = test_lock(root, ureq.addr, ureq.size);
		break;
	case TEST_CMD_UNREGISTER:

		region = test_lookup(root, ureq.addr);
		if (!region)
			result = -ENOENT;
		else
			test_unlock(region);

		break;
	case TEST_CMD_CHECK:

		region = test_lookup(root, ureq.addr);
		if (!region)
			result = -ENOENT;
		else
			result = test_check(region);

		break;
	default:
		result = -ERANGE;
		break;
	}

	up(&root->mutex);
	return result;
}

static int test_open(struct inode *inode, struct file *filp)
{
	struct region_root *root;

	root = kmalloc(sizeof(*root), GFP_KERNEL);
	if (!root)
		return -ENOMEM;

	memset(root, 0, sizeof(*root));

	INIT_LIST_HEAD(&root->regions);
	init_MUTEX(&root->mutex);

	filp->private_data = root;
	root->filp = filp;

	printk(KERN_ERR "TEST: Created root struct\n");

	return 0;
}

static int test_close(struct inode *inode, struct file *filp)
{
	struct region_root *root = filp->private_data;
	struct test_region *region;

	down(&root->mutex);

	while (!list_empty(&root->regions)) {

		region = list_entry(root->regions.next,
				    struct test_region, region_list);
		test_unlock(region);
	}

	up(&root->mutex);

	kfree(root);

	filp->private_data = NULL;

	printk(KERN_ERR "TEST: Deleted root struct\n");
	return 0;
}

static struct file_operations test_fops = {
	.owner          = THIS_MODULE,
	.open 	        = test_open,
	.release        = test_close,
	.compat_ioctl   = test_ioctl,
	.unlocked_ioctl = test_ioctl,
};


static struct cdev test_cdev;

static int __init test_init(void)
{
	int result;

	result = register_chrdev_region(TEST_DEV, 1, "mltest");
	if (result) {
		printk(KERN_ERR "TEST: Error <%d> registering dev\n", result);
		goto err_chr;
	}

	cdev_init(&test_cdev, &test_fops);

	result = cdev_add(&test_cdev, TEST_DEV, 1);
	if (result) {
		printk(KERN_ERR "TEST: Error <%d> adding cdev\n", result);
		goto err_cdev;
	}

	return 0;
err_cdev:
	unregister_chrdev_region(TEST_DEV, 1);
err_chr:
	return result;
}

static void __exit test_cleanup(void)
{
	cdev_del(&test_cdev);
	unregister_chrdev_region(TEST_DEV, 1);
}

module_init(test_init);
module_exit(test_cleanup);

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="umlt.c"

/*
 * Copyright (c) 2005 Topspin Communications.  All rights reserved.
 *
 * This software is available to you under a choice of one of two
 * licenses.  You may choose to be licensed under the terms of the GNU
 * General Public License (GPL) Version 2, available from the file
 * COPYING in the main directory of this source tree, or the
 * OpenIB.org BSD license below:
 *
 *     Redistribution and use in source and binary forms, with or
 *     without modification, are permitted provided that the following
 *     conditions are met:
 *
 *      - Redistributions of source code must retain the above
 *	copyright notice, this list of conditions and the following
 *	disclaimer.
 *
 *      - Redistributions in binary form must reproduce the above
 *	copyright notice, this list of conditions and the following
 *	disclaimer in the documentation and/or other materials
 *	provided with the distribution.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * $Id: $
 */

#include <stdlib.h>
#include <string.h>
#include <glob.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <stdint.h>
#include <poll.h>
#include <unistd.h>
#include <signal.h>

#include <linux/types.h>

#define TEST_DEV_PATH "/dev/mltest"
#define TEST_SLEEP_UTIME 50000

struct ioctl_arg {
	__u64 addr;
	__u64 size;
};

enum {
	TEST_CMD_REGISTER   = 1,
	TEST_CMD_UNREGISTER = 2,
	TEST_CMD_CHECK      = 3
};

static int hold = 1;

void sig_usr(int value)
{
	hold = 0;
}

int main(int argc, char **argv)
{
	struct ioctl_arg req;
	void *data;
	int   param_c = 0;
	int   size;
	int   fd;
	int   result;

	if (2 != argc ||
	    0 > (size = atoi(argv[++param_c]))) { 
		
		fprintf(stderr, "usage: %s <size>\n", argv[0]);
		fprintf(stderr, "  size  - allocated region size in bytes.\n");
		
		exit(1);
	}
	signal(SIGUSR1, sig_usr);

	data = malloc(size);
	if (!data) {
		fprintf(stderr, "Failed to allocated region of size <%d>\n",
			size);
		exit(1);
	}
	
	fd = open(TEST_DEV_PATH, O_RDWR);
	if (fd < 0) {
		
		fprintf(stderr, "Error <%d:%d> opening device <%s>\n",
			fd, errno, TEST_DEV_PATH);
		goto open_err;
	}

	req.addr = (unsigned long)data;
	req.size = size;

	result = ioctl(fd, TEST_CMD_REGISTER, &req);
	if (result) {

		fprintf(stderr, "Error <%d:%d> registering region\n",
			result, errno);
		goto ioctl_err;
	}

	fprintf(stdout, 
		"Address <%016lx> registered, process <%d> waiting...\n",
		data, getpid());

	while (hold) {

		usleep(TEST_SLEEP_UTIME);
	}

	fprintf(stdout, "Process continuing, checking address <%016lx>\n",
		data);

	result = ioctl(fd, TEST_CMD_CHECK, &req);
	if (result) {

		fprintf(stderr, "Error <%d:%d> checking region\n",
			result, errno);
		goto ioctl_err;
	}

	result = ioctl(fd, TEST_CMD_UNREGISTER, &req);
	if (result) {

		fprintf(stderr, "Error <%d:%d> unregistering region\n", 
			result, errno);
		goto ioctl_err;
	}

ioctl_err:
	close(fd);
open_err:
	free(data);

	return 0;
}

--cWoXeonUoKmBZSoM--
