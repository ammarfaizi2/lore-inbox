Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWGKNWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWGKNWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWGKNWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:22:34 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:9028 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750754AbWGKNWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:22:33 -0400
Date: Tue, 11 Jul 2006 15:22:32 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Xavier Roche <roche+kml2@exalead.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Huge performance issue with cciss driver on HP DL385 servers (2.6.13 -> 2.6.17)
Message-ID: <20060711132231.GG9790@harddisk-recovery.com>
References: <44B3A178.2060908@exalead.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B3A178.2060908@exalead.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 03:02:48PM +0200, Xavier Roche wrote:
> Hi folks,

[snip]

> Test program:
> -------------
> 
> #define _XOPEN_SOURCE 500
> #define _GNU_SOURCE
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <stdio.h>
> #include <errno.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/socket.h>
> #include <netinet/in.h>
> #include <arpa/inet.h>
> #include <fcntl.h>
> 
> /* a running ttytst source IP */
> #define CHARGEN_IP "192.168.115.175"
> 
> int main(int argc, char **argv) {
>   if (argc != 3) {
>     fprintf(stderr, "usage: %s FILE BUFSIZE\n", argv[0]);
>     return -1;
>   }
> 
>   char* fname = argv[1];
>   size_t bufflen = strtol(argv[2], NULL, 10);
>   if (bufflen % 512 != 0 || bufflen == 0) {
>     fprintf(stderr, "illegal buffer size: %s\n", argv[2]);
>     return -1;
>   }
> 
>   /* Allocate a 512-bytes aligned buffer for O_DIRECT transfers. */
>   void* buffer = malloc(bufflen + 512);
>   size_t delta = 512 - ((size_t) buffer) % 512;
>   void *abuffer = buffer + delta;

AFAIK buffers for direct IO need to be *page* aligned. Use something
like:

    abuffer = memalign(getpagesize(), bufflen);

Or:

    abuffer = valloc(bufflen);

I guess you got away with it cause your 512 byte alignment happened to
align on a page, but you shouldn't count on that. However...

[...]

>     /* The following pwrite call is pathologically slow when the following
>      * conditions are met:
>      *
>      *  - "fd" is opened with the O_DIRECT flag
>      *  - "bufflen" is greater than 1024K
>      *  - the file is located on an ext3 filesystem
>      *  - the program must be run just after a reboot, with an idle machine
>      */
>     pwrite(fd, abuffer, bufflen, offset);

You should check the return value of pwrite(). It could very well be
that you get errors due to unaligned writes. IIRC the glibc memory
allocator can decide from what memory pool it allocates memory
depending on the request size. It could very well be that the alignment
changes with the size. Anyway, try to recreate the problem with a page
aligned buffer.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
