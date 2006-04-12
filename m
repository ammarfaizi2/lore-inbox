Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWDLRU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWDLRU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWDLRU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:20:27 -0400
Received: from detroit.securenet-server.net ([209.51.153.26]:16805 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S932263AbWDLRU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:20:26 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Ian Romanick <idr@us.ibm.com>
Subject: Re: Special handling of sysfs device resource files?
Date: Wed, 12 Apr 2006 10:20:11 -0700
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <443C1ECA.1040308@us.ibm.com> <443C42EA.1050608@us.ibm.com>
In-Reply-To: <443C42EA.1050608@us.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LbTPE5iR3xdb5+N"
Message-Id: <200604121020.11309.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_LbTPE5iR3xdb5+N
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, April 11, 2006 4:59 pm, Ian Romanick wrote:
> I was a little mistaken about this.  The BAR that causes the problem
> is not I/O.  It *is* memory.
>
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450
> (rev 03) (prog-if 00 [VGA])
>         Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
>         Flags: bus master, medium devsel, latency 64, IRQ 11
>         Memory at cc000000 (32-bit, prefetchable) [size=32M]
>         Memory at cfefc000 (32-bit, non-prefetchable) [size=16K]
>         Memory at cf000000 (32-bit, non-prefetchable) [size=8M]
>         Expansion ROM at cfee0000 [disabled] [size=64K]
>
> When I open and mmap resource0 (the framebuffer) I get 0x2b9aa48ea000.
> When I open and mmap resource1 (the card's registers) I get
> 0x2b9aa68ea000.  I can access the resource0 pointer all day long
> without problems.  The firs access to the resource1 pointer results in
> a segfault.

Just tested on my x86-64 machine with this dumb little test program.  It 
seems to work ok, though I haven't tried writing data to the resource.

Jesse

--Boundary-00=_LbTPE5iR3xdb5+N
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="mapdump.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mapdump.c"

#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>

int main(int argc, char *argv[])
{
	size_t len;
	int fd, i;
	void *ptr;
	uint32_t *val;

	if (argc != 3) {
		fprintf(stderr, "usage: %s <file> <mapsize>\n",
			argv[0]);
		return -1;
	}

	len = atoi(argv[2]);

	fd = open(argv[1], O_RDONLY);
	if (fd == -1) {
		fprintf(stderr, "open failed: %s\n", strerror(errno));
		return errno;
	}

	ptr = mmap(NULL, len, PROT_READ, MAP_SHARED, fd, 0);
	if (ptr == MAP_FAILED) {
		fprintf(stderr, "mmap failed: %s\n", strerror(errno));
		return errno;
	}

	val = ptr;
	len = len / sizeof(uint32_t);
	for (i = 0; i < len; i += 4) {
		printf("%08x: 0x%08x 0x%08x 0x%08x 0x%08x\n", i * 4, val[i],
		       val[i+1], val[i+2], val[i+3]);
	}

	munmap(ptr, len); /* ignore any errors, we don't care */
	close(fd);
	return 0;
}

--Boundary-00=_LbTPE5iR3xdb5+N--
