Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269197AbRHGGhY>; Tue, 7 Aug 2001 02:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268977AbRHGGhP>; Tue, 7 Aug 2001 02:37:15 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:34533 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S270099AbRHGGhI>; Tue, 7 Aug 2001 02:37:08 -0400
Message-Id: <5.1.0.14.2.20010806230342.00ac2850@pop.we.mediaone.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 06 Aug 2001 23:36:36 -0700
To: linux-kernel@vger.kernel.org
From: Eric Taylor <et@rocketship1.com>
Subject: "[KSWAPD] linux-2.4.8-pre4, <kswapd profile test results>
Cc: eric.a.tailor@jpl.nasa.gov
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kswapd has been seen to get busy for minutes. I used the kernel profiler with a minor mod, to analyse what kswapd is doing during this time. I think that everyone agrees that it is probably running too often, but I wanted to see what it was doing when my system froze.

Eric
please cc at et@rocketship1.com





My test case is simple, esentially the below loop: 

=================================================
32-bit int array = malloc(1.2 gigs of mem);
for(I=0; I < 1.2gig/4 ; I++){
   array[I] = I;
}
=================================================



=================================================
Findings (with approximate numbers):
=================================================

The time spent in kswapd is almost entirely in scan_swap_map (normally inlined in swapfile.c).
Note that it is called like this:

                        swap_device_lock(p);
                        offset = scan_swap_map(p, count);
                        swap_device_unlock(p);

What does swap_device_lock lock, could it explain why nothing else runs while kswapd is scanning?

Over a typical run, scan_swap_map was called 461k  (461,000) times. Only .6k  times did it find a completely empty cluster (approx 1 / 1000). 175k times it found a free page, 286k times it did not find a free page. In this test, the clustering code is not finding many clusters, but seems to be doing a lot of work. The swapfile cluster value is 256 (perhaps this should become a tuning variable).

The counts through the scanning loops reached 2.8 billion. This indicates the hi/lo range is high. The difference between highest and lowest bit values in fact averaged 80k. 

I conclude that these are there to limit the search. However, I don't think that this was working too well for this test. These values are adjusted only when a page is found or when one is freed. If one is not found, then these high/low limits are not changed. The next search will use the same scan limits, unless a page has been freed up. 

But if it knows there are no pages, then it should not keep coming back looking for some. The value of nr_swap_pages is checked to avoid the scan, but does not appear to ever be 0, therefore the scan keeps happening. Could this be computed incorrectly? 

Also, shouldn't something else run to find a victim page to evict before this scan happens again? Or am I confused by the use of this scan. Forgive me but I really don't understand this code enough to talk sensibly about it.


At the check for nr_swap_pages to avoid a scan, my counts indicate this was never zero. I really need someone to verify my logic here? (counts ZZZ(1) and ZZZ(4) are the same, and ZZZ(3) is zero - in get_swap_page indicating that nr_swap_pages is not zero - see below code snipit). 




Here are the steps I took to profile this, in case someone sees an error in my techniques; I was fooled a few times and don't have any cross checks to verify my results. I am about 90% confident in these results.

My system is a 640meg ram (450mhz amd) system, I have 788meg of swapswace. I run my test for about 5 minutes. At this time, the array has been inited to about 1 gig (i.e. it does not finish). The system freezes, so I control-c the test program (in a minute or so, it will get some time and die). I was running 2.4.7 patched to 2.4.8-pre4.

1.      set profile=1 on booting.
2.      I ran my test case until kswapd showed huge cpu time in top. System freeze occurred for minutes.
3.      I checked the profile with readprofile.
4.      All the time was in __get_swap_page
5.      I modifed the profiler to ignore samples not from kswapd (pid 5 on my system)
6.      Repeat test, find same result, time in top matches closely with  total from readprofile.
7.      Look closer at /proc/profile and find individual program counts inside __get_swap_page
8.      Time appears to be in the inlined code from scan_swap_map, so un-inline and rebuild
9.      scan_swap_map now is the hot spot as revealed by readprofile
10.     place counters in scan_swap_map at all paths with ZZZ and ZZZ2 macros.
11.     note highest_bit and lowest_bit values and take an average of the difference each time.






=================================================
Some example data on my counters 
=================================================

Below is the part of swapfile.c that I instrumented. Some counts are 2 xxxxxxxxx for 2 billion plus 2nd number.





=======================================================
swapfile.c - as modified for my profile with run counts
=======================================================

#define SWAPFILE_CLUSTER 256

// counters, these are found with gdb /usr/src/linux/vmlinux /proc/kcore
// first 2 so i know my changes got in.

int vmscandata[62] = {666,7777,  // ZZZs have offset of 2 for these
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,

0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,

0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0};
#define ZZZ(aaa) vmscandata[aaa+2]++
#define ZZZ2(aaa) vmscandata[aaa+2]++;if(vmscandata[aaa+2] >= 1000000000){vmscandata[aaa+2]=0;vmscandata[aaa+2+20]++;}
//#define ZZZ(aaa)

// these use my /proc/sys/debug/bug[123456] variables for some visibility

extern unsigned long sysctl_debug1,sysctl_debug2,sysctl_debug3,sysctl_debug4,sysctl_debug5;

double hilo = 0.0;
double hiloc = 0.0;






==================
scan_swap_map       
==================






static /* inline */ int scan_swap_map(struct swap_info_struct *si, unsigned short count)
{
        unsigned long offset;
        /* 
         * We try to cluster swap pages by allocating them
         * sequentially in swap.  Once we've allocated
         * SWAPFILE_CLUSTER pages this way, however, we resort to
         * first-free allocation, starting a new cluster.  This
         * prevents us from scattering swap pages all over the entire
         * swap partition, so that we reduce overall disk seek times
         * between swap pages.  -- sct */
ZZZ2(20);461118  
        if (si->cluster_nr) {
                while (si->cluster_next <= si->highest_bit) {
ZZZ2(21);255288
                        offset = si->cluster_next++;
                        if (si->swap_map[offset]) {
ZZZ2(22);80933   
                                continue;
                        }
ZZZ2(23);174355  
                        si->cluster_nr--;
                        goto got_page;
                }
        }
        si->cluster_nr = SWAPFILE_CLUSTER;
ZZZ2(24);286763  
        /* try to find an empty (even not aligned) cluster. */
        offset = si->lowest_bit;
 check_next_cluster:
ZZZ2(25);2 819598027
        if (offset+SWAPFILE_CLUSTER-1 <= si->highest_bit)
        {
                int nr;
                for (nr = offset; nr < offset+SWAPFILE_CLUSTER; nr++) {
ZZZ2(26);2 819668840       
                        if (si->swap_map[nr])
                        {
ZZZ2(27);2 819311264       
                                offset = nr+1;
                                goto check_next_cluster;
                        }
                }
                /* We found a completly empty cluster, so start
                 * using it.
                 */
ZZZ2(28);679     
                goto got_page;
        }
        /* No luck, so now go finegrined as usual. -Andrea */
        for (offset = si->lowest_bit; offset <= si->highest_bit ; offset++) {
                if (si->swap_map[offset]) {
ZZZ2(29);2 836476466
                        continue;
                }
        got_page:
ZZZ2(30);175039  
                if (offset == si->lowest_bit)
                        si->lowest_bit++;
                if (offset == si->highest_bit)
                        si->highest_bit--;
                si->swap_map[offset] = count;
                nr_swap_pages--;
                si->cluster_next = offset+1;
// -- compute average distance between low and high bits
                sysctl_debug1 = si->lowest_bit; // show these in /proc/.../bug1 
                sysctl_debug2 = si->highest_bit;
                sysctl_debug3 = si->highest_bit - si->lowest_bit;
                hiloc = hiloc + 1.0;
                hilo = hilo + (double)sysctl_debug3;
                sysctl_debug4 = (int)(hilo / hiloc);

                return offset;
        }
ZZZ2(31);286079  
        return 0;
}






================
__get_swap_page              
================




swp_entry_t __get_swap_page(unsigned short count)
{
        struct swap_info_struct * p;
        unsigned long offset;
        swp_entry_t entry;
        int type, wrapped = 0;
if(sysctl_debug5) {
        int i;
        for(i=0; i < sizeof(vmscandata)/4 ; i++){
                vmscandata[i] = 0;
        }
        sysctl_debug5 = 0;
}
ZZZ(1);175039
        entry.val = 0;  /* Out of memory */
        if (count >= SWAP_MAP_MAX)
                goto bad_count;
        swap_list_lock();
        type = swap_list.next;
        if (type < 0) {
ZZZ(2);0
                goto out;
        }
        if (nr_swap_pages == 0) {
ZZZ(3);0          <<<<<<============== curious
                goto out;
        }
ZZZ(4);175039  
        while (1) {
ZZZ(5);461118  
                p = &swap_info[type];
                if ((p->flags & SWP_WRITEOK) == SWP_WRITEOK) {
ZZZ(6);461118  
                        swap_device_lock(p);
                        offset = scan_swap_map(p, count);          <<<<<<============== hot spot
                        swap_device_unlock(p);
                        if (offset) {
ZZZ(7);175039  
                                entry = SWP_ENTRY(type,offset);
                                type = swap_info[type].next;
                                if (type < 0 ||
                                        p->prio != swap_info[type].prio) {
                                                swap_list.next = swap_list.head; 
ZZZ(8);175039  
                                } else {
                                        swap_list.next = type; 
ZZZ(9);0
                                }
                                goto out;
                        }
                }
                type = p->next;
                if (!wrapped) {
ZZZ(10);135741  
                        if (type < 0 || p->prio != swap_info[type].prio) {
ZZZ(11);135741  
                                type = swap_list.head;
                                wrapped = 1;
                        }
                } else {
ZZZ(12);150338  
                        if (type < 0) {
ZZZ(13);0
                                goto out;       /* out of swap space */
                        }
                }
        }
out:
ZZZ(14);175039  
        swap_list_unlock();
        return entry;

bad_count:
        printk(KERN_ERR "get_swap_page: bad count %hd from %p\n",
               count, __builtin_return_address(0));
        return entry;
}


