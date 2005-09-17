Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVIQQK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVIQQK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 12:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVIQQK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 12:10:57 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:33197 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751131AbVIQQK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 12:10:56 -0400
To: linux-kernel@vger.kernel.org
Subject: mmap (2) vs read (2)
From: "Linh Dang" <linhd@nortel.com>
Organization: Null
Date: Sat, 17 Sep 2005 12:10:35 -0400
Message-ID: <wn58xxvhdz8.fsf@linhd-2.ca.nortel.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, how come reading memory from /dev/mem using pread(2) or mmap(2)
will give diffent results?

I run the little prog below 10 times and it always give the following
results

# for i in `seq 1 10`; do ./bar 0x4000000 ; done
04000000: 00000000
pread(04000000): 00cc7d83
04000000: 00000000
pread(04000000): 00cc7d83
04000000: 00000000
pread(04000000): 00cc7d83
04000000: 00000000
pread(04000000): 00cc7d83
04000000: 00000000
pread(04000000): 00cc7d83
04000000: 00000000
pread(04000000): 00cc7d83
04000000: 00000000
pread(04000000): 00cc7d83
04000000: 00000000
pread(04000000): 00cc7d83
04000000: 00000000
pread(04000000): 00cc7d83
04000000: 00000000
pread(04000000): 00cc7d83

thanx


----------------------------------- bar.c ---------------------------------
#include <unistd.h>
#include <stdio.h>
#include <inttypes.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>


int
main(int argc, char** argv)
{
        uint32_t *addr, item;
        uint32_t offset, val;
        int fd, update = 0;
        if (argc < 2)
                return 1;

        offset  = strtoul(argv[1], NULL, 0);
        if (argc > 2) {
                val = strtoul(argv[2], NULL, 0);
                update = 1;
        } 

        fd   = open("/dev/mem", O_RDWR, 0666);
        addr = mmap(NULL, 4096, PROT_READ|PROT_WRITE, 0x8080|MAP_SHARED, fd, offset);

        if (addr)
        {
                printf("%8.8x: %8.8x", offset, *addr);
                if (update) {
                        *addr = val;
                        msync(addr, 4096, MS_SYNC);
                        printf("-> %8.8x\n", *addr);
                } else
                        printf("\n");

                pread(fd, &item, sizeof(item), offset);
                printf("pread(%8.8x): %8.8x\n", offset, item);

                munmap(addr, 4096);
        }

        close(fd);

}
