Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVADALH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVADALH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVADAHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:07:10 -0500
Received: from cantor.suse.de ([195.135.220.2]:51860 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262001AbVADAFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:05:09 -0500
Date: Tue, 4 Jan 2005 01:04:57 +0100
From: Olaf Hering <olh@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pin files in memory after read
Message-ID: <20050104000457.GA23361@suse.de>
References: <20050103180718.GA22138@suse.de> <1104776680.4192.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1104776680.4192.20.camel@laptopd505.fenrus.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jan 03, Arjan van de Ven wrote:

> you could write a small userspace daemon that mmaps the file and mlock's
> it....

Thanks.
It seems to work ok with this thing. I used this patch to find the files
with an absolute path. Any idea how to get to the relative path like
"./x" and print an absolute path for these files?

--- ../linux-2.6.10.orig/fs/open.c      2004-12-31 09:29:25.000000000 +0100
+++ ./fs/open.c 2005-01-04 00:48:30.000000000 +0100
@@ -961,6 +961,17 @@ asmlinkage long sys_open(const char __us
 out:
                putname(tmp);
        }
+       if (0 && fd >= 0) {
+               if (filename[0] == '/' && filename[1] != '\0' && !(
+                                       !memcmp(filename,"/home/olaf/Mail",15) ||
+                                       !memcmp(filename,"/events",7) ||
+                                       !memcmp(filename,"/proc",5) ||
+                                       !memcmp(filename,"/sys",4) ||
+                                       !memcmp(filename,"/dev",4) ||
+                                       !memcmp(filename,"/var",4)
+                                       ))
+                       printk("OP%s %s\n",current->comm, filename);
+       }
        return fd;
 
 out_error:



#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#define file_list "/home/olaf/x"

size_t total;
void map(unsigned char *file, struct stat *sb)
{
	int fd;
	register unsigned char *p, c;
	if (stat(file, sb) < 0)
		return;
	fd = open(file, O_RDONLY);
	if (fd < 0)
		return;
	p = mmap(NULL, sb->st_size, PROT_READ, MAP_SHARED | MAP_LOCKED, fd, 0);
	if (p != MAP_FAILED && (total += sb->st_size))
		while (sb->st_size)
			c = p[sb->st_size--];
	close(fd);
	return;
}

int main(int argc, char *argv[])
{
	struct stat sb;
	int fd, ret, line_count;
	size_t len;
	off_t fs;
	void *flp;
	unsigned char *p1, *p2;
	fd = open(file_list, O_RDONLY);
	if (fd < 0) {
		perror(file_list);
		ret = fd;
		goto out;
	}
	ret = stat(file_list, &sb);
	if (ret < 0)
		goto out;
	flp = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED | MAP_LOCKED, fd, 0);
	if (flp == MAP_FAILED) {
		perror("mmap");
		goto out;
	}
	total += sb.st_size;
	p1 = flp;
	line_count = 0;
	fs = sb.st_size;
	while (fs > 0) {
		line_count++;
		printf("line %d ", line_count);
		len = 0;
		while (1) {
			//              printf("len %d\n", len);
			fs--;
			if (p1[len] != '\n') {
				len++;
				continue;
			}
			p2 = malloc(len);
			if (p2) {
				memcpy(p2, p1, len);
				p2[len] = '\0';
				printf("%u %s\n", len, p2);
				map(p2, &sb);
				free(p2);
				p1 = p1 + len + 1;
			}
			break;
		}
	}
	printf("sleeping ... %u\n", total);
	while (1)sleep(123456789);
      out:
	return ret;
}
