Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVL1AlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVL1AlN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 19:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVL1AlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 19:41:13 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:30653 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932420AbVL1AlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 19:41:12 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux PM <linux-pm@osdl.org>
Subject: [RFC/RFT][PATCH -mm 0/4] swsusp: userland interface
Date: Wed, 28 Dec 2005 01:08:46 +0100
User-Agent: KMail/1.9
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PedsD1SYoOPyW/+"
Message-Id: <200512280108.47253.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_PedsD1SYoOPyW/+
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This most probably needs some more work, but I think it's sufficient for
a preview.

The following series of patches creates a user space interface for swsusp
that makes it possible to move the image-writing and reading functionality
of swsusp to the user space.

The interface is based on a special character device allowing a user space
process to initiate suspend or resume using ioctls and to write or read the
system memory snapshot from the device (actually more operations are
defined on the device).  The device itself is introduced by the second patch.

The first patch adds some low-level snapshot-handling functions.  The
overall idea is that the in-kernel swap-handling code of swsusp
and the userland interface code should use the same set of low-level functions
operating on the system memory snapshot.

The last two patches are auxiliary.  The third one moves the in-kernel
swap-writing and reading code to a separate file, called swap.c, and the last
patch moves the highmem-handling code to swsusp.c.

The patches apply on top of the three swsusp-related patches I posted
earlier today.  In case you'd like to run some tests, the entire series
applicable on top of 2.6.15-rc5-mm3 is available at:
http://www.sisk.pl/kernel/patches/2.6.15-rc5-mm3/
(the other patches in the series are either bugfixes or debug patches,
and the order is given by the "series" file).

Also available are very simple demo userland utilities using the interface:
http://www.sisk.pl/kernel/utilities/suspend/
that are also attached to this message.  The "suspend" utility is designed
to work from the (root) shell, but the "resume" utility should be
invoked from an initrd (I just point /linuxrc to it and start the kernel
with the "noresume" command line parameter to prevent the in-kernel
resume code from reading the image).  The utilities are intentionally 100%
compatible with the in-kernel swap-writing and reading code (ie. the
image created by "suspend" can be restored by the in-kernel code etc.).

Any feedback will be very much appreciated.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin

--Boundary-00=_PedsD1SYoOPyW/+
Content-Type: text/x-chdr;
  charset="iso-8859-2";
  name="swsusp.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="swsusp.h"

/*
 * swsusp.h
 *
 * Common definitions for user space suspend and resume handlers.
 *
 * Copyright (C) 2005 Rafael J. Wysocki <rjw@sisk.pl>
 *
 * This file is released under the GPLv2.
 *
 */

#define PAGE_SIZE	4096

#define SNAPSHOT_IOC_MAGIC	'3'
#define SNAPSHOT_IOCFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 1)
#define SNAPSHOT_IOCUNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
#define SNAPSHOT_IOCATOMIC_SNAPSHOT	_IOW(SNAPSHOT_IOC_MAGIC, 3, void *)
#define SNAPSHOT_IOCATOMIC_RESTORE	_IO(SNAPSHOT_IOC_MAGIC, 4)
#define SNAPSHOT_IOCSET_IMAGE_SIZE	_IOW(SNAPSHOT_IOC_MAGIC, 5, unsigned long)
#define SNAPSHOT_IOCAVAIL_SWAP		_IOR(SNAPSHOT_IOC_MAGIC, 6, void *)
#define SNAPSHOT_IOCGET_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 7, void *)
#define SNAPSHOT_IOCFREE_SWAP_PAGE	_IOW(SNAPSHOT_IOC_MAGIC, 8, unsigned long)
#define SNAPSHOT_IOC_MAXNR	8

#define	LINUX_REBOOT_MAGIC1	0xfee1dead
#define	LINUX_REBOOT_MAGIC2	672274793

#define LINUX_REBOOT_CMD_RESTART	0x01234567
#define LINUX_REBOOT_CMD_HALT		0xCDEF0123
#define LINUX_REBOOT_CMD_POWER_OFF	0x4321FEDC
#define LINUX_REBOOT_CMD_RESTART2	0xA1B2C3D4
#define LINUX_REBOOT_CMD_SW_SUSPEND	0xD000FCE2

struct new_utsname {
	char sysname[65];
	char nodename[65];
	char release[65];
	char version[65];
	char machine[65];
	char domainname[65];
};

struct swsusp_info {
	struct new_utsname	uts;
	unsigned int		version_code;
	unsigned long		num_physpages;
	int			cpus;
	unsigned long		image_pages;
	unsigned long		pages;
} __attribute__((aligned(PAGE_SIZE)));

#define SWSUSP_SIG	"S1SUSPEND"

static struct swsusp_header {
	char reserved[PAGE_SIZE - 20 - sizeof(long)];
	unsigned long image;
	char	orig_sig[10];
	char	sig[10];
} __attribute__((packed, aligned(PAGE_SIZE))) swsusp_header;

static inline int freeze(int dev)
{
	return ioctl(dev, SNAPSHOT_IOCFREEZE, 0);
}

static inline int unfreeze(int dev)
{
	return ioctl(dev, SNAPSHOT_IOCUNFREEZE, 0);
}

static inline int atomic_snapshot(int dev, int *in_suspend)
{
	return ioctl(dev, SNAPSHOT_IOCATOMIC_SNAPSHOT, in_suspend);
}

static inline int atomic_restore(int dev)
{
	return ioctl(dev, SNAPSHOT_IOCATOMIC_RESTORE, 0);
}

static inline int set_image_size(int dev, unsigned int size)
{
	return ioctl(dev, SNAPSHOT_IOCSET_IMAGE_SIZE, size);
}

static inline void reboot(void)
{
	syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
		LINUX_REBOOT_CMD_RESTART, 0);
}

static inline void power_off(void)
{
	syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
		LINUX_REBOOT_CMD_POWER_OFF, 0);
}

/*
 *	The swap map is a data structure used for keeping track of each page
 *	written to the swap.  It consists of many swap_map_page structures
 *	that contain each an array of MAP_PAGE_SIZE swap entries.
 *	These structures are linked together with the help of either the
 *	.next (in memory) or the .next_swap (in swap) member.
 *
 *	The swap map is created during suspend.  At that time we need to keep
 *	it in memory, because we have to free all of the allocated swap
 *	entries if an error occurs.  The memory needed is preallocated
 *	so that we know in advance if there's enough of it.
 *
 *	The first swap_map_page structure is filled with the swap entries that
 *	correspond to the first MAP_PAGE_SIZE data pages written to swap and
 *	so on.  After the all of the data pages have been written, the order
 *	of the swap_map_page structures in the map is reversed so that they
 *	can be read from swap in the original order.  This causes the data
 *	pages to be loaded in exactly the same order in which they have been
 *	saved.
 *
 *	During resume we only need to use one swap_map_page structure
 *	at a time, which means that we only need to use two memory pages for
 *	reading the image - one for reading the swap_map_page structures
 *	and the second for reading the data pages from swap.
 */

#define MAP_PAGE_SIZE	((PAGE_SIZE - sizeof(long) - sizeof(void *)) \
			/ sizeof(long))

struct swap_map_page {
	unsigned long		entries[MAP_PAGE_SIZE];
	unsigned long		next_swap;
	struct swap_map_page	*next;
};

/*
 *	The swap_map_handle structure is used for handling the swap map in
 *	a file-alike way
 */

struct swap_map_handle {
	struct swap_map_page *cur;
	unsigned int k;
	int fd;
};

#define SNAPSHOT_DEVICE	"/dev/snapshot"
#define RESUME_DEVICE "/dev/hdc3"

#define DEFAULT_IMAGE_SIZE	500


--Boundary-00=_PedsD1SYoOPyW/+
Content-Type: text/x-csrc;
  charset="iso-8859-2";
  name="suspend.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="suspend.c"

/*
 * suspend.c
 *
 * A simple user space suspend handler for swsusp.
 *
 * Copyright (C) 2005 Rafael J. Wysocki <rjw@sisk.pl>
 *
 * This file is released under the GPLv2.
 *
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <syscall.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include "swsusp.h"

static int dev;
static char buffer[PAGE_SIZE];

static inline unsigned int check_free_swap(void)
{
	int error;
	unsigned int free_swap;

	error = ioctl(dev, SNAPSHOT_IOCAVAIL_SWAP, &free_swap);
	if (!error)
		return free_swap;
	else
		printf("Error: errno = %d\n", errno);
	return 0;
}

static inline unsigned long get_swap_page(void)
{
	int error;
	unsigned long offset;

	error = ioctl(dev, SNAPSHOT_IOCGET_SWAP_PAGE, &offset);
	if (!error)
		return offset;
	return 0;
}

static inline int free_swap_page(unsigned long offset)
{
	return ioctl(dev, SNAPSHOT_IOCFREE_SWAP_PAGE, offset);
}

/**
 *	write_page - Write one page to a fresh swap location.
 *	@fd:	File handle of the resume partition
 *	@buf:	Pointer to the area we're writing.
 *	@offp:	Place to store the swap offset we used.
 */

static int write_page(int fd, void *buf, unsigned long *offp)
{
	unsigned long swap_offset;
	off_t offset;
	int res = -ENOSPC;
	ssize_t cnt = 0;

	swap_offset = get_swap_page();
	if (swap_offset) {
		offset = swap_offset * PAGE_SIZE;
		if (lseek(fd, offset, SEEK_SET) == offset) 
			cnt = write(fd, buf, PAGE_SIZE);
		if (cnt == PAGE_SIZE) {
			*offp = swap_offset;
			res = 0;
		} else {
			free_swap_page(swap_offset);
			if (cnt < 0)
				res = cnt;
		}
	}
	return res;
}

static inline void free_swap_map(struct swap_map_page *swap_map)
{
	struct swap_map_page *swp;

	while (swap_map) {
		swp = swap_map->next;
		free(swap_map);
		swap_map = swp;
	}
}

static struct swap_map_page *alloc_swap_map(unsigned int nr_pages)
{
	struct swap_map_page *swap_map, *swp;
	unsigned n = 0;

	if (!nr_pages)
		return NULL;

	printf("alloc_swap_map(): nr_pages = %d\n", nr_pages);
	swap_map = malloc(PAGE_SIZE);
	memset(swap_map, 0, PAGE_SIZE);
	swp = swap_map;
	for (n = MAP_PAGE_SIZE; n < nr_pages; n += MAP_PAGE_SIZE) {
		swp->next = malloc(PAGE_SIZE);
		memset(swp->next, 0, PAGE_SIZE);
		swp = swp->next;
		if (!swp) {
			free_swap_map(swap_map);
			return NULL;
		}
	}
	return swap_map;
}

/**
 *	reverse_swap_map - reverse the order of pages in the swap map
 *	@swap_map
 */

static inline struct swap_map_page *reverse_swap_map(struct swap_map_page *swap_map)
{
	struct swap_map_page *prev, *next;

	prev = NULL;
	while (swap_map) {
		next = swap_map->next;
		swap_map->next = prev;
		prev = swap_map;
		swap_map = next;
	}
	return prev;
}

/**
 *	free_swap_map_entries - free the swap entries allocated to store
 *	the swap map @swap_map (this is only called in case of an error)
 */
static inline void free_swap_map_entries(struct swap_map_page *swap_map)
{
	while (swap_map) {
		if (swap_map->next_swap)
			free_swap_page(swap_map->next_swap);
		swap_map = swap_map->next;
	}
}

/**
 *	save_swap_map - save the swap map used for tracing the data pages
 *	stored in the swap
 */

static int save_swap_map(int fd, struct swap_map_page *swap_map, unsigned long *start)
{
	unsigned long offset = 0;
	int error;

	while (swap_map) {
		swap_map->next_swap = offset;
		if ((error = write_page(fd, swap_map, &offset)))
			return error;
		swap_map = swap_map->next;
	}
	*start = offset;
	return 0;
}

/**
 *	free_image_entries - free the swap entries allocated to store
 *	the image data pages (this is only called in case of an error)
 */

static inline void free_image_entries(struct swap_map_page *swp)
{
	unsigned k;

	while (swp) {
		for (k = 0; k < MAP_PAGE_SIZE; k++)
			if (swp->entries[k])
				free_swap_page(swp->entries[k]);
		swp = swp->next;
	}
}

static inline void init_swap_map_handle(struct swap_map_handle *handle,
                                        int fd, struct swap_map_page *map)
{
	handle->cur = map;
	handle->k = 0;
	handle->fd = fd;
}

static inline int swap_map_write_page(struct swap_map_handle *handle, void *buf)
{
	int error;

	error = write_page(handle->fd, buf, handle->cur->entries + handle->k);
	if (error)
		return error;
	if (++handle->k >= MAP_PAGE_SIZE) {
		handle->cur = handle->cur->next;
		handle->k = 0;
	}
	return 0;
}

/**
 *	save_image - save the suspend image data
 */

static int save_image(struct swap_map_handle *handle,
                      unsigned int nr_pages)
{
	unsigned int m;
	int ret;
	int error = 0;

	printf("suspend: Saving image data pages (%u pages) ...     ", nr_pages);
	m = nr_pages / 100;
	if (!m)
		m = 1;
	nr_pages = 0;
	do {
		ret = read(dev, buffer, PAGE_SIZE);
		if (ret > 0) {
			error = swap_map_write_page(handle, buffer);
			if (error)
				break;
			if (!(nr_pages % m))
				printf("\b\b\b\b%3d%%", nr_pages / m);
			nr_pages++;
		}
	} while (ret > 0);
	if (!error)
		printf(" done\n");
	return error;
}

/**
 *	enough_swap - Make sure we have enough swap to save the image.
 *
 *	Returns TRUE or FALSE after checking the total amount of swap
 *	space avaiable from the resume partition.
 */

static int enough_swap(unsigned int nr_pages)
{
	unsigned int free_swap = check_free_swap();

	printf("suspend: Free swap pages: %u\n", free_swap);
	return free_swap > nr_pages;
}

static int mark_swapfiles(int fd, unsigned long start)
{
	int error = 0;

	lseek(fd, 0, SEEK_SET);
	if (read(fd, &swsusp_header, PAGE_SIZE) < PAGE_SIZE)
		return -EIO;
	if (!memcmp("SWAP-SPACE", swsusp_header.sig, 10) ||
	    !memcmp("SWAPSPACE2", swsusp_header.sig, 10)) {
		memcpy(swsusp_header.orig_sig, swsusp_header.sig, 10);
		memcpy(swsusp_header.sig, SWSUSP_SIG, 10);
		swsusp_header.image = start;
		lseek(fd, 0, SEEK_SET);
		if (write(fd, &swsusp_header, PAGE_SIZE) < PAGE_SIZE)
			error = -EIO;
	} else {
		printf("suspend: Device is not a swap space.\n");
		error = -ENODEV;
	}
	return error;
}

/**
 *	write_image - Write entire image and metadata.
 */

int write_image(char *resume_dev_name)
{
	struct swap_map_page *swap_map;
	struct swap_map_handle handle;
	struct swsusp_info *header;
	unsigned long start;
	int fd;
	int error;

	fd = open(resume_dev_name, O_RDWR | O_SYNC);
	if (fd < 0) {
		printf("suspend: Could not open resume device\n");
		return error;
	}
	error = read(dev, buffer, PAGE_SIZE);
	if (error < PAGE_SIZE)
		return error < 0 ? error : -EFAULT;
	header = (struct swsusp_info *)buffer;
	if (!enough_swap(header->pages)) {
		printf("suspend: Not enough free swap\n");
		return -ENOSPC;
	}
	swap_map = alloc_swap_map(header->pages);
	if (!swap_map)
		return -ENOMEM;
	init_swap_map_handle(&handle, fd, swap_map);

	error = swap_map_write_page(&handle, header);
	if (!error)
		error = save_image(&handle, header->pages - 1);
	if (error)
		goto Free_image_entries;

	swap_map = reverse_swap_map(swap_map);
	error = save_swap_map(fd, swap_map, &start);
	if (error)
		goto Free_map_entries;

	printf( "S" );
	error = mark_swapfiles(fd, start);
	printf( "|\n" );
	if (error)
		goto Free_map_entries;

Free_swap_map:
	free_swap_map(swap_map);
	fsync(fd);
	close(fd);
	return error;

Free_map_entries:
	free_swap_map_entries(swap_map);
Free_image_entries:
	free_image_entries(swap_map);
	goto Free_swap_map;
}

int main(int argc, char *argv[])
{
	char *snapshot_device_name, *resume_device_name;
	int image_size;
	int in_suspend;

	resume_device_name = argc <= 2 ? RESUME_DEVICE : argv[2];
	snapshot_device_name = argc <= 1 ? SNAPSHOT_DEVICE : argv[1];

	sync();
	setvbuf(stdout, NULL, _IONBF, 0);
	setvbuf(stderr, NULL, _IONBF, 0);

	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
		fprintf(stderr, "Could not lock myself\n");
		return 1;
	}

	image_size = DEFAULT_IMAGE_SIZE;
	while (image_size >= 0) {
		dev = open(snapshot_device_name, O_RDONLY);
		if (dev < 0)
			return -ENOENT;
		if (set_image_size(dev, image_size)) {
			fprintf(stderr, "Could not set the image size\n");
			return errno;
		}
		if (freeze(dev)) {
			fprintf(stderr, "Could not freeze processes\n");
			return errno;
		}
		if (!atomic_snapshot(dev, &in_suspend)) {
			if (!in_suspend) {
				unfreeze(dev);
				close(dev);
				return 0;
			}
			if (!write_image(resume_device_name))
				power_off();
			else
				image_size -= DEFAULT_IMAGE_SIZE;
		}
		unfreeze(dev);
		close(dev);
	}

	return 0;
}

--Boundary-00=_PedsD1SYoOPyW/+
Content-Type: text/x-csrc;
  charset="iso-8859-2";
  name="resume.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="resume.c"

/*
 * resume.c
 *
 * A simple user space resume handler for swsusp.
 *
 * Copyright (C) 2005 Rafael J. Wysocki <rjw@sisk.pl>
 *
 * This file is released under the GPLv2.
 *
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <syscall.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include "swsusp.h"

static char buffer[PAGE_SIZE];

/**
 *	read_page - Read one page from a swap location.
 *	@fd:	File handle of the resume partition
 *	@buf:	Pointer to the area we're reading into.
 *	@off:	Swap offset of the place to read from.
 */

static int read_page(int fd, void *buf, unsigned long off)
{
	off_t offset;
	int res = 0;
	ssize_t cnt = 0;

	if (off) {
		offset = off * PAGE_SIZE;
		if (lseek(fd, offset, SEEK_SET) == offset) 
			cnt = read(fd, buf, PAGE_SIZE);
		if (cnt < PAGE_SIZE) {
			if (cnt < 0)
				res = cnt;
			else
				res = -EIO;
		}
	}
	return res;
}

/**
 *	The following functions allow us to read data using a swap map
 *	in a file-alike way
 */

static inline void release_swap_map_reader(struct swap_map_handle *handle)
{
	if (handle->cur)
		free(handle->cur);
	handle->cur = NULL;
}

static inline int get_swap_map_reader(struct swap_map_handle *handle,
                                      int fd, unsigned long start)
{
	int error;

	if (!start)
		return -EINVAL;
	handle->cur = (struct swap_map_page *)malloc(PAGE_SIZE);
	if (!handle->cur)
		return -ENOMEM;
	memset(handle->cur, 0, PAGE_SIZE);
	error = read_page(fd, handle->cur, start);
	if (error) {
		release_swap_map_reader(handle);
		return error;
	}
	handle->fd = fd;
	handle->k = 0;
	return 0;
}

static inline int swap_map_read_page(struct swap_map_handle *handle, void *buf)
{
	unsigned long offset;
	int error;

	if (!handle->cur)
		return -EINVAL;
	offset = handle->cur->entries[handle->k];
	if (!offset)
		return -EFAULT;
	error = read_page(handle->fd, buf, offset);
	if (error)
		return error;
	if (++handle->k >= MAP_PAGE_SIZE) {
		handle->k = 0;
		offset = handle->cur->next_swap;
		if (!offset)
			release_swap_map_reader(handle);
		else
			error = read_page(handle->fd, handle->cur, offset);
	}
	return error;
}

/**
 *	load_image - load the image using the swap map handle
 *	@handle and the snapshot handle @snapshot
 *	(assume there are @nr_pages pages to load)
 */

static inline int load_image(struct swap_map_handle *handle, int dev,
                      unsigned int nr_pages)
{
	unsigned int m, n;
	int ret;
	int error = 0;

	printf("Loading image data pages (%u pages) ...     ", nr_pages);
	m = nr_pages / 100;
	if (!m)
		m = 1;
	n = 0;
	do {
		error = swap_map_read_page(handle, buffer);
		if (error)
			break;
		if ((ret = write(dev, buffer, PAGE_SIZE)) < PAGE_SIZE) {
			error = ret < 0 ? ret : -ENOSPC;
			break;
		}
		if (!(n % m))
			printf("\b\b\b\b%3d%%", n / m);
		n++;
	} while (n < nr_pages);
	if (!error)
		printf("\b\b\b\bdone\n");
	return error;
}

static int read_image(int dev, char *resume_dev_name)
{
	int fd, ret, error = 0;
	struct swap_map_handle handle;
	struct swsusp_info *header;
	unsigned int nr_pages;


	fd = open(resume_dev_name, O_RDWR | O_SYNC);
	if (fd < 0) {
		printf("resume: Could not open resume device\n");
		return -ENOENT;
	}
	memset(&swsusp_header, 0, sizeof(swsusp_header));
	ret = read(fd, &swsusp_header, PAGE_SIZE);
	if (ret == PAGE_SIZE) {
		if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
			memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
			/* Reset swap signature now */
			if (lseek(fd, 0, SEEK_SET) == 0) {
				ret = write(fd, &swsusp_header, PAGE_SIZE);
				if (ret < PAGE_SIZE)
					error = ret < 0 ? ret : -EIO;
			} else {
				error = -EIO;
			}
		} else {
			error = -EINVAL;
		}
	} else {
		error = ret < 0 ? ret : -EIO;
	}
	if (!error) {
		error = get_swap_map_reader(&handle, fd, swsusp_header.image);
		if (!error) {
			header = (struct swsusp_info *)buffer;
			error = swap_map_read_page(&handle, header);
		}
		if (!error) {
			nr_pages = header->pages - 1;
			ret = write(dev, buffer, PAGE_SIZE);
			if (ret < PAGE_SIZE)
				error = ret < 0 ? ret : -EIO;
		}
		if (!error)
			error = load_image(&handle, dev, nr_pages);
		release_swap_map_reader(&handle);
	}
	fsync(fd);
	close(fd);
	if (!error)
		printf("resume: Reading resume file was successful\n");
	else
		printf("resume: Error %d resuming\n", error);
	return error;
}

int main(int argc, char *argv[])
{
	char *snapshot_device_name, *resume_device_name;
	int dev;

	resume_device_name = argc <= 2 ? RESUME_DEVICE : argv[2];
	snapshot_device_name = argc <= 1 ? SNAPSHOT_DEVICE : argv[1];

	setvbuf(stdout, NULL, _IONBF, 0);
	setvbuf(stderr, NULL, _IONBF, 0);

	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
		fprintf(stderr, "resume: Could not lock myself\n");
		return 1;
	}

	dev = open(snapshot_device_name, O_WRONLY);
	if (dev < 0)
		return -ENOENT;
	if (read_image(dev, resume_device_name)) {
		fprintf(stderr, "resume: Could not read the image\n");
		return errno;
	}
	if (freeze(dev)) {
		fprintf(stderr, "resume: Could not freeze processes\n");
		return errno;
	}
	atomic_restore(dev);
	unfreeze(dev);
	close(dev);
	return 0;
}

--Boundary-00=_PedsD1SYoOPyW/+--

