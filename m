Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266989AbUBMMy0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 07:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266993AbUBMMy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 07:54:26 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:28871 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S266989AbUBMMyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 07:54:21 -0500
Date: Fri, 13 Feb 2004 13:55:15 +0100 (CET)
From: der.eremit@email.de
To: Randy Dunlap <rddunlap@osdl.org>
cc: spam99@2thebatcave.com, linux-kernel@vger.kernel.org
Subject: Re: getting usb mass storage to finish before running init?
In-Reply-To: <2181.4.5.45.142.1076645210.squirrel@www.osdl.org>
Message-ID: <Pine.LNX.4.58.0402131348530.163@neptune.local>
References: <1oAMR-6St-13@gated-at.bofh.it>        <E1ArSm1-0003ei-Pv@localhost>
 <2181.4.5.45.142.1076645210.squirrel@www.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Randy Dunlap wrote:

> > Check available devices for root filesystem (in case you're booting from
> > IDE). If it's not there, wait a moment, then look for additional
> > devices. If nothing shows up, repeat.
>
> That's basically what my usb-boot patch for 2.4.22 does:
>   http://www.xenotime.net/linux/usb/usbboot-2422.patch
>
> I haven't tried to port it to 2.6.x.

I don't think this requires in-kernel code once an initrd or
initramfs is going.

Here's what I use for CD-ROM booting (compiles to 370k statically
linked code using glibc):

#include <sys/klog.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/mount.h>

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int pivot_root(const char *new_root, const char *put_old);

#define KLOG_GET_MESSAGES	3
#define KLOG_SET_LOGLEVEL	8

#define BUFSIZE		65536
#define DEVNAMEMAX	16
#define UNIQUEFILE	"/mnt/etc/rc.d/rc.cdrom"

void halt_system(void)
{
	while (1)
		;
}

void check_okay(int res, const char *errmsg)
{
	if (res < 0) {
		printf("Error: %s\n", errmsg);
		halt_system();
	}
}

int correct_medium(const char *devname)
{
	int res;
	struct stat buf;

	res = mount(devname, "/mnt", "iso9660", (0xC0ED << 16) | MS_RDONLY, 0);
	if (res == -1) {
		printf("No suitable medium on %s\n", devname);
		return 0;
	}

	res = stat(UNIQUEFILE, &buf);
	if (res == -1) {
		umount("/mnt");
		printf("Unrelated filesystem on %s\n", devname);
		return 0;
	}

	printf("Root filesystem found on %s\n", devname);
	return 1;
}

void change_root(void)
{
	int res;

	res = chdir("/mnt");
	check_okay(res, "could not cd into CD-ROM root filesystem");

	res = pivot_root("/mnt", "/mnt/initrd");
	check_okay(res, "could not change / to CD-ROM root filesystem");

	execl("/sbin/init", "/sbin/init");

	check_okay(-1, "could not execute /sbin/init");
}

int main(int argc, char **argv)
{
	char buf[BUFSIZE];
	char devname[DEVNAMEMAX];
	char *work, *line, *sub;
	int res, found = 0;

	puts("Attempting to locate CD-ROM device");

	klogctl(KLOG_SET_LOGLEVEL, NULL, 1);

	memset(buf, 0, BUFSIZE);

	res = klogctl(KLOG_GET_MESSAGES, buf, BUFSIZE);
	check_okay(res, "could not read kernel messages");

	work = buf;
	while (work) {
		line = strsep(&work, "\n");

		sub = strstr(line, "ATAPI CD/DVD-ROM drive");
		if (sub) {
			memset(devname, 0, DEVNAMEMAX);
			strcpy(devname, "/dev/");
			memcpy(devname+5, line+3, 3);

			printf("ATAPI CD-ROM at: %s\n", devname);

			if (correct_medium(devname))
				change_root();

			found = 1;
		}

		sub = strstr(line, "Attached scsi CD-ROM sr");
		if (sub) {
			memset(devname, 0, DEVNAMEMAX);
			strcpy(devname, "/dev/scd");
			memcpy(devname+8, line+26, 1);

			printf("SCSI CD-ROM at: %s\n", devname);

			if (correct_medium(devname))
				change_root();

			found = 1;
		}
	}

	if (!found)
		puts("No CD-ROM device found");
	else
		puts("Root filesystem not found on CD-ROM device(s)");

	halt_system();

	/* NOT REACHED */
	return 0;
}

-- 
Ciao,
Pascal
