Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUAGT3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUAGT1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:27:48 -0500
Received: from paja.kn.vutbr.cz ([147.229.191.135]:40717 "EHLO
	paja.kn.vutbr.cz") by vger.kernel.org with ESMTP id S266211AbUAGT0k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:26:40 -0500
Message-ID: <3FFC5D5E.8040303@stud.feec.vutbr.cz>
Date: Wed, 07 Jan 2004 20:26:22 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6 fix for mremap is incorrect?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

When you fixed the mremap vulnerability, you said:
> I'd actually personally prefer a stronger test than the one in 2.4.24, and
> my personal preference would be for just disallowing the degenerate cases
> entirely. I don't see a "mremap away" as being a valid thing to do, since
> if that is what you want, why not just do a "munmap()"?

I think that your fix doesn't prevent these degenerate cases from 
happening. To disallow them, the following patch should be applied:


--- linux-2.6.1-rc2/mm/mremap.c	2004-01-07 17:20:03.000000000 +0100
+++ linux/mm/mremap.c	2004-01-07 19:30:39.000000000 +0100
@@ -316,7 +316,7 @@
  	new_len = PAGE_ALIGN(new_len);

  	/* Don't allow the degenerate cases */
-	if (!(old_len | new_len))
+	if (!old_len || !new_len)
  		goto out;

  	/* new_addr is only valid if MREMAP_FIXED is specified */


Here is a testing program which shows the difference:

/*  mremap test by Michal Schmidt
  *  based on proof-of-concept exploit code for do_mremap()
  *   by Christophe Devine and Julien Tinnes
  *  GPL v2 */

#include <stdio.h>
#include <asm/unistd.h>
#include <sys/mman.h>
#include <unistd.h>
#include <errno.h>

#define MREMAP_MAYMOVE  1
#define MREMAP_FIXED    2

#define __NR_real_mremap __NR_mremap

static inline _syscall5( void *, real_mremap, void *, old_address,
                          size_t, old_size, size_t, new_size,
                          unsigned long, flags, void *, new_address );

void list_maps(void)
{
     char str[50];
     fflush(stdout);
     sprintf(str,"cat /proc/%u/maps",getpid());
     system(str);
}

int main( void )
{
     void *base;
     void *remapped;

     printf("start\n");
     list_maps();
     base = mmap( NULL, 8192, PROT_READ | PROT_WRITE,
                  MAP_PRIVATE | MAP_ANONYMOUS, 0, 0 );
     printf("mmap at: %p\n",base);
     list_maps();

     remapped=real_mremap( base, 8192, 0, MREMAP_MAYMOVE | MREMAP_FIXED,
                  (void *) 0xC0000000 );
     printf("mremap to: %p\n",remapped);
     list_maps();

     return( 0 );
}
/* -----------EOF------------ */

Under 2.6.1-rc2 I get this output:

start
08048000-08049000 r-xp 00000000 03:05 355347     /home/michich/c/mremap
08049000-0804a000 rw-p 00000000 03:05 355347     /home/michich/c/mremap
40000000-40014000 r-xp 00000000 03:05 22062      /lib/ld-2.3.2.so
40014000-40015000 rw-p 00013000 03:05 22062      /lib/ld-2.3.2.so
40015000-40016000 rw-p 00000000 00:00 0
40026000-40152000 r-xp 00000000 03:05 22068      /lib/libc.so.6
40152000-40157000 rw-p 0012b000 03:05 22068      /lib/libc.so.6
40157000-40179000 rw-p 00000000 00:00 0
bfffe000-c0000000 rwxp fffff000 00:00 0
ffffe000-fffff000 ---p 00000000 00:00 0
mmap at: 0x40179000
08048000-08049000 r-xp 00000000 03:05 355347     /home/michich/c/mremap
08049000-0804a000 rw-p 00000000 03:05 355347     /home/michich/c/mremap
40000000-40014000 r-xp 00000000 03:05 22062      /lib/ld-2.3.2.so
40014000-40015000 rw-p 00013000 03:05 22062      /lib/ld-2.3.2.so
40015000-40016000 rw-p 00000000 00:00 0
40026000-40152000 r-xp 00000000 03:05 22068      /lib/libc.so.6
40152000-40157000 rw-p 0012b000 03:05 22068      /lib/libc.so.6
40157000-4017b000 rw-p 00000000 00:00 0
bfffe000-c0000000 rwxp fffff000 00:00 0
ffffe000-fffff000 ---p 00000000 00:00 0
mremap to: 0xffffffff
08048000-08049000 r-xp 00000000 03:05 355347     /home/michich/c/mremap
08049000-0804a000 rw-p 00000000 03:05 355347     /home/michich/c/mremap
40000000-40014000 r-xp 00000000 03:05 22062      /lib/ld-2.3.2.so
40014000-40015000 rw-p 00013000 03:05 22062      /lib/ld-2.3.2.so
40015000-40016000 rw-p 00000000 00:00 0
40026000-40152000 r-xp 00000000 03:05 22068      /lib/libc.so.6
40152000-40157000 rw-p 0012b000 03:05 22068      /lib/libc.so.6
40157000-40179000 rw-p 00000000 00:00 0
bfffe000-c0000000 rwxp fffff000 00:00 0
ffffe000-fffff000 ---p 00000000 00:00 0

.... so the mremap failed (it returned -1) but it has already unmapped 
the area - it did the "mremap away" thing you wanted to prevent.

With my patch, mremap will also return -1, but doesn't change the memory 
map - I believe that's better behaviour.

Michal Schmidt
