Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbTCJRLd>; Mon, 10 Mar 2003 12:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbTCJRLc>; Mon, 10 Mar 2003 12:11:32 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:17200 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S261367AbTCJRL3>; Mon, 10 Mar 2003 12:11:29 -0500
Message-ID: <3E6CC9BD.5050501@google.com>
Date: Mon, 10 Mar 2003 09:22:05 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG][2.4.18+] kswapd assumes swapspace exists
Content-Type: multipart/mixed;
 boundary="------------000501020901030606040802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000501020901030606040802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


I've verified this in 2.4.21-pre5 by code inspection and can trigger the 
problem on 2.4.18.  It appears to have been fixed in 2.5.

The folowing code vmscan.c assumes that there is available swap space.

        /*
         * this is the non-racy check for busy page.
         */
        if (!page->mapping || !is_page_cache_freeable(page)) {
            spin_unlock(&pagecache_lock);
            UnlockPage(page);
page_mapped:
            if (--max_mapped >= 0)
                continue;

            /*
             * Alert! We've found too many mapped pages on the
             * inactive list, so we start swapping out now!
             */
            spin_unlock(&pagemap_lru_lock);
            swap_out(priority, gfp_mask, classzone);
            return nr_pages;
        }


If there is no swap space, then unfreeable pages are left on the 
inactive queue and the vmtree is walked rather than going through the 
rest of the inactive queue.  I believe something like
        /*
         * this is the non-racy check for busy page.
         */
        if (!page->mapping || !is_page_cache_freeable(page)) {
            spin_unlock(&pagecache_lock);
            UnlockPage(page);
page_mapped:
                        /* If we don't have any swap space left, there
                           is no reason to worry about pages that do
                           not have swap associated with them, there
                           is nothing we can do about it. */
                        if (!page->mapping && !swap_avail()) {
                                /* Let's make the page active since we
                                   cannot swap it out.  It get's it off
                                   the inactive list. */
                                spin_unlock(&pagemap_lru_lock);
                                activate_page(page);
                                ClearPageReferenced(page);
                                spin_lock(&pagemap_lru_lock);
                                continue;
                        }
            if (--max_mapped >= 0)
                continue;

            /*
             * Alert! We've found too many mapped pages on the
             * inactive list, so we start swapping out now!
             */
            spin_unlock(&pagemap_lru_lock);
            swap_out(priority, gfp_mask, classzone);
            return nr_pages;
        }

will work better when there is no swap space available.  If this change 
is made, it may also be necessary to limit refill_inactive to prevent it 
from using too much cpu.  This bug can be triggered with the attached 
code and the correct parameters.  In particular on a 3 gigabyte machine 
with no swap,

for i in $(seq 0 9); do dd if=/dev/zero of=file$i bs=1024k count=512; done
killmm 1032735283 2 9

Usually causes an out of memory error when there is hundreds of 
megabytes of cache.


    Ross

--------------000501020901030606040802
Content-Type: text/plain;
 name="killmm.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="killmm.c"

/*
 *  killmm.c attempts to exploit bugs in the mm to cause a crash or
 *  other undesired behaviour.
 *  Copyright (C) 2002 Google
 *  Written by Ross Biro
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <malloc.h>
#include <errno.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <asm/page.h>

/* 512 Meg */ 
#define BLOCKSIZE 512*1024*1024 
#define USEMLOCK 1

int main(int argc, char *argv[]) {
  size_t memory = atoi(argv[1]);
  int blocks = atoi(argv[2]);
  int maxfiles = atoi(argv[3]);
  unsigned char *cptr; 
  int i, j, k;

  void **ptrs = (void **)malloc(blocks * sizeof(*ptrs));
  if (ptrs == NULL) {
    fprintf (stderr, "Unable to allocate %d bytes: %s\n",
             sizeof(*ptrs) * blocks,
             strerror(errno));
    return -1;
  }
  

  /* The first thing we do is allocate a bunch of memory. */
  cptr = (unsigned char *)malloc(memory);
  if (cptr == NULL) {
    fprintf (stderr, "Unable to allocate %d bytes: %s\n", memory,
             strerror(errno));
    return -1;
  }

  /* now we want to make it all dirty. */
  for (i = 0; i < memory; i++) {
    cptr[i] = (unsigned char)(i&0xff);
    if ((i & 0xffffff) == 0) {
      printf ("Initializing memory: %d\n", i);
    }
  }
  
  /* Now we have a bunch of dirty memory.  Map in huge files. */
  for (i = 0; i < maxfiles; i++) {
    char filename[1024];
    int fd;
    int ind = i%blocks;
    if (ptrs[ind] != NULL) {
      printf ("Unmapping block %d @ %08X\n", ind, ptrs[ind]);
#ifdef USEMLOCK 
     munlock(ptrs[ind], BLOCKSIZE);
#endif
      munmap(ptrs[ind], BLOCKSIZE);
    }
    sprintf (filename, "file%d", i);
    printf ("Loading file %s into slot %d\n",
            filename, ind);
    fd = open (filename, O_RDONLY);
    if (fd < 0) {
      fprintf (stderr, "Unable to open %s: %s\n", filename, strerror(errno));
      return -1;
    }

    ptrs[ind] = mmap (NULL, BLOCKSIZE, PROT_READ, MAP_PRIVATE, fd, 0);
    if (ptrs[ind] == NULL) {
      fprintf (stderr, "Unable to map file %s: %s\n", 
               filename, strerror(errno));
      return -1;
    }

#ifdef USEMLOCK
    if (mlock(ptrs[ind], BLOCKSIZE) < 0) {
      fprintf (stderr, "Unable to lock mem for %s: %s\n",
               filename, strerror(errno));
      return -1;
    }
#else
    // Page in the memory the old fashioned way.
    for (j = 0; j <BLOCKSIZE; j+= PAGE_SIZE) {
      k += ((char *)ptrs[ind])[j];
    }
#endif

    printf ("Block %d at %08X\n", ind, ptrs[ind]);

    close(fd);
         
  }
  
  
}

--------------000501020901030606040802--

