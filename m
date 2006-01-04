Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWADXG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWADXG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWADXG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:06:28 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:39906 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751168AbWADXG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:06:27 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC/RFT][PATCH -mm 0/5] swsusp: userland interface (rev. 2)
Date: Wed, 4 Jan 2006 23:40:41 +0100
User-Agent: KMail/1.9
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_q7EvDBh8O0U4KEu"
Message-Id: <200601042340.42118.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_q7EvDBh8O0U4KEu
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

This is the second "preview release" of the swsusp userland interface patch=
es.
They have changed quite a bit since the previous post, as I tried to make t=
he
interface more robust against some potential user space bugs (or outright
attempts to abuse it).

The swsusp userland interface is based on a special character device allowi=
ng
a user space process to initiate suspend or resume using ioctls and to writ=
e or read
the system memory snapshot from the device (actually more operations are
defined on the device). =A0The device itself is introduced by the second pa=
tch.

The first patch adds some low-level snapshot-handling functions (the
overall idea is that the in-kernel swap-handling code of swsusp
and the userland interface code should use the same set of low-level functi=
ons
operating on the system memory snapshot).  It also modifies the way in
which allocated swap pages are handled (traced) by swsusp and, consequently,
simplifies the in-kernel swap-writing code (a little).

The last three patches are auxiliary. =A0The third one moves the in-kernel
swap-writing and reading code to a separate file, called swap.c, the fourth
one moves the highmem-handling code to swsusp.c, and the last one
provides some documentation and makes it possible to compile out
the in-kernel swap-writing/reading code (or the userland interface, if
desired).

The patches apply on top of three swsusp-related patches that have just
made it into the -mm tree, so hopefully they will apply to the next -mm.
Anyway, in case you'd like to run some tests, the entire series
applicable on top of 2.6.15-rc5-mm3 is available at:
http://www.sisk.pl/kernel/patches/2.6.15-rc5-mm3/
(the other patches in the series are either bugfixes or debug patches,
and the order is given by the "series" file).

Also available are very simple demo userland utilities using the interface:
http://www.sisk.pl/kernel/utilities/suspend/
that are also attached to this message. =A0The "suspend" utility is designed
to work from the (root) shell, but the "resume" utility should be
invoked from an initrd (I just point /linuxrc to it and start the kernel
with the "noresume" command line parameter to prevent the in-kernel
resume code from reading the image). =A0The utilities are intentionally 100%
compatible with the in-kernel swap-writing and reading code (ie. the
image created by "suspend" can be restored by the in-kernel code etc.).

Any feedback will be very much appreciated.

Greetings,
Rafael


=2D-=20
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin

--Boundary-00=_q7EvDBh8O0U4KEu
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

#define PAGE_SHIFT	12
#define PAGE_SIZE	(1UL << PAGE_SHIFT)

#define SNAPSHOT_IOC_MAGIC	'3'
#define SNAPSHOT_IOCFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 1)
#define SNAPSHOT_IOCUNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
#define SNAPSHOT_IOCATOMIC_SNAPSHOT	_IOW(SNAPSHOT_IOC_MAGIC, 3, void *)
#define SNAPSHOT_IOCATOMIC_RESTORE	_IO(SNAPSHOT_IOC_MAGIC, 4)
#define SNAPSHOT_IOCFREE		_IO(SNAPSHOT_IOC_MAGIC, 5)
#define SNAPSHOT_IOCSET_IMAGE_SIZE	_IOW(SNAPSHOT_IOC_MAGIC, 6, unsigned long)
#define SNAPSHOT_IOCAVAIL_SWAP		_IOR(SNAPSHOT_IOC_MAGIC, 7, void *)
#define SNAPSHOT_IOCGET_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 8, void *)
#define SNAPSHOT_IOCFREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
#define SNAPSHOT_IOCSET_SWAP_FILE	_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned int)
#define SNAPSHOT_IOC_MAXNR	10

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

struct swsusp_header {
	char reserved[PAGE_SIZE - 20 - sizeof(long)];
	unsigned long image;
	char	orig_sig[10];
	char	sig[10];
} __attribute__((packed, aligned(PAGE_SIZE)));

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

static inline int free_snapshot(int dev)
{
	return ioctl(dev, SNAPSHOT_IOCFREE, 0);
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
 *	written to a swap partition.  It consists of many swap_map_page
 *	structures that contain each an array of MAP_PAGE_SIZE swap entries.
 *	These structures are stored on the swap and linked together with the
 *	help of the .next_swap member.
 *
 *	The swap map is created during suspend.  The swap map pages are
 *	allocated and populated one at a time, so we only need one memory
 *	page to set up the entire structure.
 *
 *	During resume we also only need to use one swap_map_page structure
 *	at a time.
 */

#define MAP_PAGE_ENTRIES	(PAGE_SIZE / sizeof(long) - 1)

struct swap_map_page {
	unsigned long		entries[MAP_PAGE_ENTRIES];
	unsigned long		next_swap;
};

#define SNAPSHOT_DEVICE	"/dev/snapshot"
#define RESUME_DEVICE "/dev/hdc3"

#define DEFAULT_IMAGE_SIZE	500


--Boundary-00=_q7EvDBh8O0U4KEu
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
static struct swsusp_header swsusp_header;

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

static inline int free_swap_pages(void)
{
	return ioctl(dev, SNAPSHOT_IOCFREE_SWAP_PAGES, 0);
}

static inline int set_swap_file(dev_t blkdev)
{
	return ioctl(dev, SNAPSHOT_IOCSET_SWAP_FILE, blkdev);
}

/**
 *	write_page - Write one page to given swap location.
 *	@fd:		File handle of the resume partition
 *	@buf:		Pointer to the area we're writing.
 *	@swap_offset:	Offset of the swap page we're writing to.
 */

static int write_page(int fd, void *buf, unsigned long swap_offset)
{
	off_t offset;
	int res = -EINVAL;
	ssize_t cnt = 0;

	if (swap_offset) {
		offset = swap_offset * PAGE_SIZE;
		if (lseek(fd, offset, SEEK_SET) == offset) 
			cnt = write(fd, buf, PAGE_SIZE);
		if (cnt == PAGE_SIZE)
			res = 0;
		else
			res = cnt < 0 ? cnt : -EIO;
	}
	return res;
}

/*
 *	The swap_map_handle structure is used for handling swap in
 *	a file-alike way
 */

struct swap_map_handle {
	struct swap_map_page cur;
	unsigned long cur_swap;
	unsigned int k;
	int fd;
};

static inline int init_swap_writer(struct swap_map_handle *handle, int fd)
{
	memset(&handle->cur, 0, PAGE_SIZE);
	handle->cur_swap = get_swap_page();
	if (!handle->cur_swap)
		return -ENOSPC;
	handle->k = 0;
	handle->fd = fd;
	return 0;
}

static int swap_write_page(struct swap_map_handle *handle, void *buf)
{
	int error;
	unsigned long offset;

	offset = get_swap_page();
	error = write_page(handle->fd, buf, offset);
	if (error)
		return error;
	handle->cur.entries[handle->k++] = offset;
	if (handle->k >= MAP_PAGE_ENTRIES) {
		offset = get_swap_page();
		if (!offset)
			return -ENOSPC;
		handle->cur.next_swap = offset;
		error = write_page(handle->fd, &handle->cur, handle->cur_swap);
		if (error)
			return error;
		memset(&handle->cur, 0, PAGE_SIZE);
		handle->cur_swap = offset;
		handle->k = 0;
	}
	return 0;
}

static inline int flush_swap_writer(struct swap_map_handle *handle)
{
	if (handle->cur_swap)
		return write_page(handle->fd, &handle->cur, handle->cur_swap);
	else
		return -EINVAL;
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
			error = swap_write_page(handle, buffer);
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

static int mark_swap(int fd, unsigned long start)
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
	static struct swap_map_handle handle;
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
	error = init_swap_writer(&handle, fd);
	if (!error) {
		start = handle.cur_swap;
		error = swap_write_page(&handle, header);
	}
	if (!error)
		error = save_image(&handle, header->pages - 1);
	if (!error) {
		flush_swap_writer(&handle);
		printf( "S" );
		error = mark_swap(fd, start);
		printf( "|\n" );
	}
	fsync(fd);
	close(fd);
	return error;
}

int main(int argc, char *argv[])
{
	char *snapshot_device_name, *resume_device_name;
	struct stat *stat_buf;
	int image_size;
	int error;
	int in_suspend;

	resume_device_name = argc <= 2 ? RESUME_DEVICE : argv[2];
	snapshot_device_name = argc <= 1 ? SNAPSHOT_DEVICE : argv[1];

	stat_buf = (struct stat *)buffer;
	if (stat(resume_device_name, stat_buf)) {
		fprintf(stderr, "Could not stat the resume device file\n");
		return -ENODEV;
	}
	if (!S_ISBLK(stat_buf->st_mode)) {
		fprintf(stderr, "Invalid resume device\n");
		return -EINVAL;
	}

	sync();
	setvbuf(stdout, NULL, _IONBF, 0);
	setvbuf(stderr, NULL, _IONBF, 0);

	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
		fprintf(stderr, "Could not lock myself\n");
		return 1;
	}

	error = 0;
	dev = open(snapshot_device_name, O_RDONLY);
	if (dev < 0)
		return -ENOENT;
	if (set_swap_file(stat_buf->st_rdev)) {
		fprintf(stderr, "Could not set the resume device file\n");
		error = errno;
		goto Close;
	}
	image_size = check_free_swap();
	if (image_size <= 0) {
		fprintf(stderr, "No swap space for suspend\n");
		error = -ENOSPC;
		goto Close;
	}
	if (image_size > DEFAULT_IMAGE_SIZE)
		image_size = DEFAULT_IMAGE_SIZE;
	if (freeze(dev)) {
		fprintf(stderr, "Could not freeze processes\n");
		error = errno;
		goto Close;
	}
	while (image_size >= 0) {
		if (set_image_size(dev, image_size)) {
			fprintf(stderr, "Could not set the image size\n");
			error = errno;
			goto Unfreeze;
		}
		if (!atomic_snapshot(dev, &in_suspend)) {
			if (!in_suspend)
				break;
			if (!write_image(resume_device_name)) {
				power_off();
			} else {
				free_swap_pages();
				free_snapshot(dev);
				image_size -= DEFAULT_IMAGE_SIZE;
			}
		}
	}
Unfreeze:
	unfreeze(dev);
Close:
	close(dev);

	return error;
}

--Boundary-00=_q7EvDBh8O0U4KEu
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
static struct swsusp_header swsusp_header;

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

/*
 *	The swap_map_handle structure is used for handling the swap map in
 *	a file-alike way
 */

struct swap_map_handle {
	struct swap_map_page cur;
	unsigned int k;
	int fd;
};

/**
 *	The following functions allow us to read data using a swap map
 *	in a file-alike way
 */

static inline int init_swap_reader(struct swap_map_handle *handle,
                                      int fd, unsigned long start)
{
	int error;

	if (!start)
		return -EINVAL;
	memset(&handle->cur, 0, PAGE_SIZE);
	error = read_page(fd, &handle->cur, start);
	if (error)
		return error;
	handle->fd = fd;
	handle->k = 0;
	return 0;
}

static inline int swap_read_page(struct swap_map_handle *handle, void *buf)
{
	unsigned long offset;
	int error;

	offset = handle->cur.entries[handle->k++];
	if (!offset)
		return -EFAULT;
	error = read_page(handle->fd, buf, offset);
	if (error)
		return error;
	if (handle->k >= MAP_PAGE_ENTRIES) {
		handle->k = 0;
		offset = handle->cur.next_swap;
		if (offset)
			error = read_page(handle->fd, &handle->cur, offset);
		else
			error = -EINVAL;
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
		error = swap_read_page(handle, buffer);
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
	static struct swap_map_handle handle;
	int fd, ret, error = 0;
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
		error = init_swap_reader(&handle, fd, swsusp_header.image);
		if (!error) {
			header = (struct swsusp_info *)buffer;
			error = swap_read_page(&handle, header);
		}
		if (!error) {
			nr_pages = header->pages - 1;
			ret = write(dev, buffer, PAGE_SIZE);
			if (ret < PAGE_SIZE)
				error = ret < 0 ? ret : -EIO;
		}
		if (!error)
			error = load_image(&handle, dev, nr_pages);
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
	int error = 0;

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
		error = errno;
		goto Close;
	}
	if (freeze(dev)) {
		fprintf(stderr, "resume: Could not freeze processes\n");
		error = errno;
		goto Close;
	}
	atomic_restore(dev);
	unfreeze(dev);
Close:
	close(dev);
	return error;
}

--Boundary-00=_q7EvDBh8O0U4KEu--

