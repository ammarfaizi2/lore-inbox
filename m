Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVJaJVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVJaJVh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 04:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVJaJVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 04:21:37 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:23301 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S932339AbVJaJVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 04:21:37 -0500
Message-ID: <4365E216.5000403@tuxrocks.com>
Date: Mon, 31 Oct 2005 02:21:26 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: Daniele Orlandi <daniele@orlandi.com>, linux-kernel@vger.kernel.org
Subject: Re: An idea on devfs vs. udev
References: <200510301907.11860.daniele@orlandi.com> <200510301557.29024.rob@landley.net>
In-Reply-To: <200510301557.29024.rob@landley.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------090701020700040700050308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090701020700040700050308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rob Landley wrote:
> I'm pondering adding a micro-udev to busybox (it's fairly far down on the todo 
> list).

snip

> function makedev
> {
>   j=`echo "$1" | sed 's .*/\(.*\)/dev \1 '`
>   minor=`cat "$1" | sed 's .*:  '`
>   major=`cat "$1" | sed 's :.*  '`
>   mknod tmpdir/"$j" $2 $major $minor
> }
> 
> for i in `find /sys/block -name "dev"`
> do
>   makedev -m 700 $i b $major $minor
>   echo -n b
> done
> 
> for i in `find /sys/class -name "dev"`
> do
>   makedev -m 700 $i c $major $minor
>   echo -n c
> done
> 
> You think implementing that in C would take more than 4k?

I'm certain that someone can do better than this, but here's a C version
that does it in 4684 bytes (stripped).  It's simple, and runs fast.  I'm
sure that someone could optimize this much further.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDZeIWaI0dwg4A47wRAiWgAJ9LzBcNhfrW5KHP9f8qg+spfGUSKwCdFTlw
grK0kedpIQ/JRDN2yMqLG4U=
=K4vE
-----END PGP SIGNATURE-----

--------------090701020700040700050308
Content-Type: text/x-csrc;
 name="miniudev.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="miniudev.c"

/*
* miniudev - implement a small udev that can run at bootup
* Copyright Frank Sorenson <frank@tuxrocks.com> 2005
*
* Permission is hereby granted to copy, modify and redistribute this code
* in terms of the GNU Library General Public License, Version 2 or later,
* at your option.
*
*/

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/sysmacros.h>

#define DEV_PATH	"/dev"
#define DEV_MODE	0700

int get_device_info(const char *path, int *major, int *minor)
{
	char buf[512];
	int fd;
	int ret;
	char *chr;
	char got_colon = 0;
	int tempval = 0;

	sprintf(buf, "%s/dev", path);
	fd = open(buf, O_RDONLY);
	ret = read(fd, buf, 1024);
	buf[ret - 1] = '\0';
	if (ret == 0)
		return -1;
	close(fd);

	chr = buf;
	while (*chr != '\0') {
		if (*chr == ':') {
			*major = tempval;
			tempval = 0;
			got_colon ++;
		} else {
			tempval *= 10;
			tempval += (*chr - '0');
		}
		chr ++;
	}
	*minor = tempval;

	return 0;
}

int make_device(const char *path, int type)
{
	char buf[512];
	const char *device_name;
	int major;
	int minor;
	int ret;
	int local_errno;

	device_name = path;
	while (*device_name != '\0')
		device_name ++;
	while ((*(device_name - 1) != '/') && (device_name > path)) {
		device_name --;
	}
	get_device_info(path, &major, &minor);
	printf("%s: %d %d\n", device_name, major, minor);

	sprintf(buf, "%s/%s", DEV_PATH, device_name);
	ret = mknod(buf, DEV_MODE | type, makedev(major, minor));
	if (ret != 0) {
		local_errno = errno;
		printf("Could not create device node %s: error %d\n", buf, local_errno);
	}

	return 0;
}

char cmp(const char *s1, const char *s2)
{
	int n = 0;

	while (s1[n] == s2[n]) {
		if (s1[n] == '\0')
			return 1;
		n++;
	}
	return 0;
}

int find_dev(const char *path, int type)
{
	DIR *dir;
	struct dirent *entry;
	char temp_path[512];
	int local_errno;

	dir = opendir(path);
	if (dir == NULL) {
		printf("Could not open path %s: error %d\n", path, local_errno);
		exit(-1);
	}

	do {
		entry = readdir(dir);
		if (entry == NULL)
			break;
		if (cmp(entry->d_name, "."))
			continue;
		if (cmp(entry->d_name, ".."))
			continue;
		if (entry->d_type == DT_DIR) {
			sprintf(temp_path, "%s/%s", path, entry->d_name);
			find_dev(temp_path, type);
		}
		if (cmp(entry->d_name, "dev")) {
			make_device(path, type);
		}
	} while (entry != NULL);
	closedir(dir);

	return 0;
}


int main(int argc, char *argv[])
{
	find_dev("/sys/block", S_IFBLK);
	find_dev("/sys/class", S_IFCHR);

	return 0;
}


--------------090701020700040700050308--
