Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274008AbRISGVZ>; Wed, 19 Sep 2001 02:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274009AbRISGVG>; Wed, 19 Sep 2001 02:21:06 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:21520 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S274008AbRISGU7>; Wed, 19 Sep 2001 02:20:59 -0400
Message-ID: <3BA8394F.EF66C846@zip.com.au>
Date: Tue, 18 Sep 2001 23:21:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: 2.4.10pre11 vm rewrite fixes for mainline inclusion and testing
In-Reply-To: <20010918224317.E720@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> Linus, can you merge this patch in the next pre-patch? Marcelo and
> Andrew, can you test if this fixes your problems properly or if we need
> further work on it for the oom problem?
> 

With the same workload as yesterday (combination of anon load and
shared mappings):

- throughput is more than twice that of 2.4.9-ac10.  I checked
  this several times.  A huge difference.

- there were no zero-order allocation failures, and no oom-killings.

- A few minutes into testing I hit a BUG() in shrink_cache().  Unfortunately
  the BUG() macro doesn't report file-n-line in recent kernels.  I set up
  kgdb and of course it ran happily for an hour.  Typical.

- Ah-hah.  I wound up the VM load a bit and hit the box with 32,000
  pings/sec.  There weren't any allocation failures at all, although
  the box wedged totally once.  I suspect a networking problem in this
  case.

  With this workload we again hit the BUG() in shrink_cache(), this time
  under gdb:

Program received signal SIGTRAP, Trace/breakpoint trap.
shrink_cache (lru=0xc0353de4, max_scan=0xdfff1f74, this_max_scan=0x301, nr_pages=0x1a, 
    classzone=0xc02e2588, gfp_mask=0x1c0) at vmscan.c:475
475                             BUG();
(gdb) l 
470                                     continue;
471                             }
472                     }
473     
474                     if (__builtin_expect(!page->mapping, 0))
475                             BUG();
476     
477                     if (__builtin_expect(!spin_trylock(&pagecache_lock), 0)) {
478                             /* we hold the page lock so the page cannot go away from under us */
479                             spin_unlock(&pagemap_lru_lock);
(gdb) bt
#0  shrink_cache (lru=0xc0353de4, max_scan=0xdfff1f74, this_max_scan=0x301, nr_pages=0x1a, 
    classzone=0xc02e2588, gfp_mask=0x1c0) at vmscan.c:475
#1  0xc012edcf in shrink_caches (priority=0x6, classzone=0xc02e2588, gfp_mask=0x1c0, nr_pages=0x20)
    at vmscan.c:551
#2  0xc012ee4f in try_to_free_pages (classzone=0xc02e2588, gfp_mask=0x1c0, order=0xc132fadc)
    at vmscan.c:572
#3  0xc012ef23 in kswapd_balance_pgdat (pgdat=0xc02e24e0) at vmscan.c:608
#4  0xc012ef9e in kswapd_balance () at vmscan.c:632
#5  0xc012f0cd in kswapd (unused=0x0) at vmscan.c:721
#6  0xc01055ab in kernel_thread (fn=0xd6c3b38c, arg=0xd6c3b390, flags=0xd6c3b394) at process.c:444
#7  0xd6c3b388 in ?? ()

(gdb) p *page
$1 = {list = {next = 0x0, prev = 0x0}, mapping = 0x0, index = 0x8210, next_hash = 0x0, count = {
    counter = 0x1}, flags = 0x89, lru = {next = 0xc11eef5c, prev = 0xc0353de4}, wait = {lock = {
      lock = 0x1}, task_list = {next = 0xc132fae8, prev = 0xc132fae8}}, pprev_hash = 0x0, 
  buffers = 0x0, virtual = 0xccbeb000, zone = 0xc02e2588}

So the page is inactive, locked, uptodate, and has no mapping.

(gdb) p *page->zone
$2 = {lock = {lock = 0x1}, free_pages = 0x1d7, pages_min = 0xff, pages_low = 0x1fe, 
  pages_high = 0x2fd, need_balance = 0x1, free_area = {{free_list = {next = 0xc1719ac0, 
        prev = 0xc119e200}, map = 0xc18002c0}, {free_list = {next = 0xc119e400, 
        prev = 0xc115db80}, map = 0xc18021c0}, {free_list = {next = 0xc11f1e00, 
        prev = 0xc119df00}, map = 0xc1803140}, {free_list = {next = 0xc115dc00, 
        prev = 0xc119e000}, map = 0xc1803900}, {free_list = {next = 0xc119d800, 
        prev = 0xc115b800}, map = 0xc1803ce0}, {free_list = {next = 0xc115b000, 
        prev = 0xc115b000}, map = 0xc1803ee0}, {free_list = {next = 0xc115a000, 
        prev = 0xc115a000}, map = 0xc1803fe0}, {free_list = {next = 0xc1158000, 
        prev = 0xc1158000}, map = 0xc1804060}, {free_list = {next = 0xc02e2600, 
        prev = 0xc02e2600}, map = 0xc18040a0}, {free_list = {next = 0xc02e260c, 
        prev = 0xc02e260c}, map = 0x0}}, zone_pgdat = 0xc02e24e0, zone_mem_map = 0xc1040000, 
  zone_start_paddr = 0x1000000, zone_start_mapnr = 0x1000, name = 0xc029c508 "Normal", 
  size = 0x1f000}

(gdb) p page->zone
$5 = (struct zone_struct *) 0xc02e2588
(gdb) p classzone
$6 = (zone_t *) 0xc02e2588

Poking around a bit, there's another thread on another CPU spinning
on pagemap_lru_lock:

(gdb) thread 51
[Switching to thread 51 (thread 986)]#0  0xc028cfd4 in stext_lock () at af_packet.c:1870
1870    }
(gdb) bt
#0  0xc028cfd4 in stext_lock () at af_packet.c:1870
#1  0x00000020 in netlink_proto_exit () at clgenfb.c:2479
#2  0xc012edcf in shrink_caches (priority=Cannot access memory at address 0x20
) at vmscan.c:551
#3  0xc012ee4f in try_to_free_pages (classzone=0xc02e2588, gfp_mask=0x1d2, order=0xc132fac0)
    at vmscan.c:572
#4  0xc012f83a in balance_classzone (classzone=0xc02e2588, gfp_mask=0x1d2, order=0x0, 
    freed=0xd89f7e6c) at page_alloc.c:245
#5  0xc012fad1 in __alloc_pages (gfp_mask=0x1d2, order=0x0, zonelist=0xc02e26f8)
    at page_alloc.c:370
#6  0xc012f7d7 in _alloc_pages (gfp_mask=0xc02e2704, order=0x0) at page_alloc.c:226
#7  0xc0125522 in do_anonymous_page (mm=0xc73c3f20, vma=0xdfa2e5c0, page_table=0xd7983428, 
    write_access=0x1, addr=0x4b10a000) at /usr/src/linux-akpm/include/linux/mm.h:389
#8  0xc01255cb in do_no_page (mm=0xc73c3f20, vma=0xdfa2e5c0, address=0x4b10a000, write_access=0x1, 
    page_table=0xd7983428) at memory.c:1238
#9  0xc01256e4 in handle_mm_fault (mm=0xc73c3f20, vma=0xdfa2e5c0, address=0x4b10a000, 
    write_access=0x1) at memory.c:1318
#10 0xc0113f42 in do_page_fault (regs=0xd89f7fc4, error_code=0x6) at fault.c:267
#11 0xc0106f0c in error_code () at af_packet.c:1879

gdb screwed up the call trace - this may be due to FASTCALL...

But we're spinning in line 445 here:

435                             if (try_to_free_buffers(page, gfp_mask)) {
436                                     if (!page->mapping) {
437                                             UnlockPage(page);
438     
439                                             /*
440                                              * Account we successfully freed a page
441                                              * of buffer cache.
(gdb) 
442                                              */
443                                             atomic_dec(&buffermem_pages);
444     
445                                             spin_lock(&pagemap_lru_lock);
446                                             __lru_cache_del(page);
447     
448                                             /* effectively free the page here */

Isn't this the race?  We've just stripped the buffers from an
anon page (presumably after swapin), but it's still on the inactive
list.
