Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265606AbUEZSak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265606AbUEZSak (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 14:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbUEZSaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 14:30:39 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:35601 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265606AbUEZS3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 14:29:47 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4] heavy-load under swap space shortage
Date: Wed, 26 May 2004 20:24:34 +0200
User-Agent: KMail/1.6.2
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, j-nomura@ce.jp.nec.com,
       andrea@suse.de, Andrew Morton <akpm@osdl.org>, hugh@veritas.com
References: <20040204.204058.1025214600.nomura@linux.bs1.fc.nec.co.jp> <20040310.195707.521627048.nomura@linux.bs1.fc.nec.co.jp> <20040526124104.GF6439@logos.cnet>
In-Reply-To: <20040526124104.GF6439@logos.cnet>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405262024.34905@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iDOtA92Sc9fWH5x"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_iDOtA92Sc9fWH5x
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 26 May 2004 14:41, Marcelo Tosatti wrote:

Marcelo,

> I think we can merge this patch.

I think this too =)


> Its very safe - default behaviour unchanged.
> Jun, are you willing to do another test for us if this gets merged
> in v2.4.27-pre4 ?
> Maybe we should document the VM tunables somewhere outside source code
> (Documentation/) ?

I think we should merge the attached patches to finally remove utterly bogus 
and non-existent documentation things and clean up stuff a bit and document 
the -aa VM bits.

Agreed?

Kinda same cleanups and more following soon for 2.6-mm.

ciao, Marc


--Boundary-00=_iDOtA92Sc9fWH5x
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="02_add-new-docu-VM.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="02_add-new-docu-VM.patch"

--- a/Documentation/sysctl/vm.txt	2004-05-26 19:57:15.000000000 +0200
+++ b/Documentation/sysctl/vm.txt	2004-05-26 20:06:20.000000000 +0200
@@ -1,111 +1,143 @@
-Documentation for /proc/sys/vm/*	kernel version 2.4.19
-	(c) 1998, 1999,  Rik van Riel <riel@nl.linux.org>
+Documentation for /proc/sys/vm/*	Kernel version 2.4.26
+=============================================================
 
-For general info and legal blurb, please look in README.
+ (c) 1998, 1999, Rik van Riel <riel@nl.linux.org>
+    - Initial version
 
-==============================================================
+ (c) 2004, Marc-Christian Petersen <m.c.p@linux-systeme.com>
+    - Removed non-existent knobs which were removed in early
+      2.4 stages
+    - Corrected values for bdflush
+    - Documented missing tunables
+    - Documented aa-vm tunables
+
+
+
+For general info and legal blurb, please look in README.
+=============================================================
 
 This file contains the documentation for the sysctl files in
-/proc/sys/vm and is valid for Linux kernel version 2.4.
+/proc/sys/vm and is valid for Linux kernel v2.4.26.
 
 The files in this directory can be used to tune the operation
 of the virtual memory (VM) subsystem of the Linux kernel, and
-one of the files (bdflush) also has a little influence on disk
-usage.
+three of the files (bdflush, max-readahead, min-readahead)
+also have some influence on disk usage.
 
 Default values and initialization routines for most of these
-files can be found in mm/swap.c.
+files can be found in mm/vmscan.c, mm/page_alloc.c and
+mm/filemap.c.
 
 Currently, these files are in /proc/sys/vm:
 - bdflush
+- block_dump
 - kswapd
+- laptop_mode
+- max-readahead
+- min-readahead
 - max_map_count
 - overcommit_memory
 - page-cluster
 - pagetable_cache
+- vm_anon_lru
+- vm_cache_scan_ratio
+- vm_gfp_debug
+- vm_lru_balance_ratio
+- vm_mapped_ratio
+- vm_passes
+- vm_vfs_scan_ratio
+=============================================================
 
-==============================================================
 
-bdflush:
 
+bdflush:
+--------
 This file controls the operation of the bdflush kernel
 daemon. The source code to this struct can be found in
-linux/fs/buffer.c. It currently contains 9 integer values,
+fs/buffer.c. It currently contains 9 integer values,
 of which 6 are actually used by the kernel.
 
-From linux/fs/buffer.c:
---------------------------------------------------------------
-union bdflush_param {
-	struct {
-		int nfract;	/* Percentage of buffer cache dirty to
-				   activate bdflush */
-		int ndirty;	/* Maximum number of dirty blocks to write out per
-				   wake-cycle */
-		int dummy2;	/* old "nrefill" */
-		int dummy3;	/* unused */
-		int interval;	/* jiffies delay between kupdate flushes */
-		int age_buffer;	/* Time for normal buffer to age before we flush it */
-		int nfract_sync;/* Percentage of buffer cache dirty to
-				   activate bdflush synchronously */
-		int nfract_stop_bdflush; /* Percentage of buffer cache dirty to stop bdflush */
-		int dummy5;	/* unused */
-	} b_un;
-	unsigned int data[N_PARAM];
-} bdf_prm = {{30, 500, 0, 0, 5*HZ, 30*HZ, 60, 20, 0}};
---------------------------------------------------------------
-
-int nfract:
-The first parameter governs the maximum number of dirty
-buffers in the buffer cache. Dirty means that the contents
-of the buffer still have to be written to disk (as opposed
-to a clean buffer, which can just be forgotten about).
-Setting this to a high value means that Linux can delay disk
-writes for a long time, but it also means that it will have
-to do a lot of I/O at once when memory becomes short. A low
-value will spread out disk I/O more evenly, at the cost of
-more frequent I/O operations.  The default value is 30%,
-the minimum is 0%, and the maximum is 100%.
-
-int ndirty:
-The second parameter (ndirty) gives the maximum number of
-dirty buffers that bdflush can write to the disk in one time.
-A high value will mean delayed, bursty I/O, while a small
-value can lead to memory shortage when bdflush isn't woken
-up often enough.
-
-int interval:
-The fifth parameter, interval, is the minimum rate at
-which kupdate will wake and flush.  The value is expressed in
-jiffies (clockticks), the number of jiffies per second is
-normally 100 (Alpha is 1024). Thus, x*HZ is x seconds.  The
-default value is 5 seconds, the minimum is 0 seconds, and the
-maximum is 600 seconds.
-
-int age_buffer:
-The sixth parameter, age_buffer, governs the maximum time
-Linux waits before writing out a dirty buffer to disk.  The
-value is in jiffies.  The default value is 30 seconds,
-the minimum is 1 second, and the maximum 6,000 seconds.
-
-int nfract_sync:
-The seventh parameter, nfract_sync, governs the percentage
-of buffer cache that is dirty before bdflush activates
-synchronously.  This can be viewed as the hard limit before
-bdflush forces buffers to disk.  The default is 60%, the
-minimum is 0%, and the maximum is 100%.
-
-int nfract_stop_bdflush:
-The eighth parameter, nfract_stop_bdflush, governs the percentage
-of buffer cache that is dirty which will stop bdflush.
-The default is 20%, the miniumum is 0%, and the maxiumum is 100%.
-==============================================================
+nfract:		The first parameter governs the maximum
+		number of dirty buffers in the buffer
+		cache. Dirty means that the contents of the
+		buffer still have to be written to disk (as
+		opposed to a clean buffer, which can just be
+		forgotten about). Setting this to a high
+		value means that Linux can delay disk writes
+		for a long time, but it also means that it
+		will have to do a lot of I/O at once when
+		memory becomes short. A low value will
+		spread out disk I/O more evenly, at the cost
+		of more frequent I/O operations. The default
+		value is 30%, the minimum is 0%, and the
+		maximum is 100%.
+
+ndirty:		The second parameter (ndirty) gives the
+		maximum number of dirty buffers that bdflush
+		can write to the disk in one time. A high
+		value will mean delayed, bursty I/O, while a
+		small value can lead to memory shortage when
+		bdflush isn't woken up often enough. The
+		default value is 500 dirty buffers, the
+		minimum is 1, and the maximum is 50000.
+
+dummy2:		The third parameter is not used.
+
+dummy3:		The fourth parameter is not used.
+
+interval:	The fifth parameter, interval, is the minimum
+		rate at which kupdate will wake and flush.
+		The value is in jiffies (clockticks), the
+		number of jiffies per second is normally 100
+		(Alpha is 1024). Thus, x*HZ is x seconds. The
+		default value is 5 seconds, the minimum	is 0
+		seconds, and the maximum is 10,000 seconds.
+
+age_buffer:	The sixth parameter, age_buffer, governs the
+		maximum time Linux waits before writing out a
+		dirty buffer to disk. The value is in jiffies.
+		The default value is 30 seconds, the minimum
+		is 1 second, and the maximum 10,000 seconds.
+
+sync:		The seventh parameter, nfract_sync, governs
+		the percentage of buffer cache that is dirty
+		before bdflush activates synchronously. This
+		can be viewed as the hard limit before
+		bdflush forces buffers to disk. The default
+		is 60%,	the minimum is 0%, and the maximum
+		is 100%.
+
+stop_bdflush:	The eighth parameter, nfract_stop_bdflush,
+		governs the percentage of buffer cache that
+		is dirty which will stop bdflush. The default
+		is 20%, the miniumum is 0%, and the maxiumum
+		is 100%.
+
+dummy5:		The ninth parameter is not used.
+
+So the default is: 30 500 0 0 500 3000 60 20 0   for 100 HZ.
+=============================================================
+
+
+
+block_dump:
+-----------
+It can happen that the disk still keeps spinning up and you
+don't quite know why or what causes it. The laptop mode patch
+has a little helper for that as well. When set to 1, it will
+dump info to the kernel message buffer about what process
+caused the io. Be careful when playing with this setting.
+It is advisable to shut down syslog first! The default is 0.
+=============================================================
+
 
-kswapd:
 
+kswapd:
+-------
 Kswapd is the kernel swapout daemon. That is, kswapd is that
 piece of the kernel that frees memory when it gets fragmented
-or full. Since every system is different, you'll probably want
-some control over this piece of the system.
+or full. Since every system is different, you'll probably
+want some control over this piece of the system.
 
 The numbers in this page correspond to the numbers in the
 struct pager_daemon {tries_base, tries_min, swap_cluster
@@ -117,39 +149,83 @@ tries_base	The maximum number of pages k
 		number. Usually this number will be divided
 		by 4 or 8 (see mm/vmscan.c), so it isn't as
 		big as it looks.
-		When you need to increase the bandwidth to/from
-		swap, you'll want to increase this number.
+		When you need to increase the bandwidth to/
+		from swap, you'll want to increase this
+		number.
+
 tries_min	This is the minimum number of times kswapd
 		tries to free a page each time it is called.
 		Basically it's just there to make sure that
 		kswapd frees some pages even when it's being
 		called with minimum priority.
+
 swap_cluster	This is the number of pages kswapd writes in
 		one turn. You want this large so that kswapd
 		does it's I/O in large chunks and the disk
-		doesn't have to seek often, but you don't want
-		it to be too large since that would flood the
-		request queue.
+		doesn't have to seek often, but you don't
+		want it to be too large since that would
+		flood the request queue.
+
+The default value is: 512 32 8.
+=============================================================
 
-==============================================================
 
-overcommit_memory:
 
-This value contains a flag that enables memory overcommitment.
-When this flag is 0, the kernel checks before each malloc()
-to see if there's enough memory left. If the flag is nonzero,
-the system pretends there's always enough memory.
+laptop_mode:
+------------
+Setting this to 1 switches the vm (and block layer) to laptop
+mode. Leaving it to 0 makes the kernel work like before. When
+in laptop mode, you also want to extend the intervals
+desribed in Documentation/laptop-mode.txt.
+See the laptop-mode.sh script for how to do that.
+
+The default value is 0.
+=============================================================
 
-This feature can be very useful because there are a lot of
-programs that malloc() huge amounts of memory "just-in-case"
-and don't use much of it.
 
-Look at: mm/mmap.c::vm_enough_memory() for more information.
 
-==============================================================
+max-readahead:
+--------------
+This tunable affects how early the Linux VFS will fetch the
+next block of a file from memory. File readahead values are
+determined on a per file basis in the VFS and are adjusted
+based on the behavior of the application accessing the file.
+Anytime the current position being read in a file plus the
+current read ahead value results in the file pointer pointing
+to the next block in the file, that block will be fetched
+from disk. By raising this value, the Linux kernel will allow
+the readahead value to grow larger, resulting in more blocks
+being prefetched from disks which predictably access files in
+uniform linear fashion. This can result in performance
+improvements, but can also result in excess (and often
+unnecessary) memory usage. Lowering this value has the
+opposite affect. By forcing readaheads to be less aggressive,
+memory may be conserved at a potential performance impact.
+
+The default value is 31.
+=============================================================
 
-max_map_count:
 
+
+min-readahead:
+--------------
+Like max-readahead, min-readahead places a floor on the
+readahead value. Raising this number forces a files readahead
+value to be unconditionally higher, which can bring about
+performance improvements, provided that all file access in
+the system is predictably linear from the start to the end of
+a file. This of course results in higher memory usage from
+the pagecache. Conversely, lowering this value, allows the
+kernel to conserve pagecache memory, at a potential
+performance cost.
+
+The default value is 3.
+=============================================================
+
+
+
+max_map_count:
+--------------
 This file contains the maximum number of memory map areas a
 process may have. Memory map areas are used as a side-effect
 of calling malloc, directly by mmap and mprotect, and also
@@ -159,10 +235,29 @@ While most applications need less than a
 certain programs, particularly malloc debuggers, may consume 
 lots of them, e.g. up to one or two maps per allocation.
 
-==============================================================
+The default value is 65536.
+=============================================================
+
+
+
+overcommit_memory:
+------------------
+This value contains a flag to enable memory overcommitment.
+When this flag is 0, the kernel checks before each malloc()
+to see if there's enough memory left. If the flag is nonzero,
+the system pretends there's always enough memory.
+
+This feature can be very useful because there are a lot of
+programs that malloc() huge amounts of memory "just-in-case"
+and don't use much of it. The default value is 0.
+
+Look at: mm/mmap.c::vm_enough_memory() for more information.
+=============================================================
+
 
-page-cluster:
 
+page-cluster:
+-------------
 The Linux VM subsystem avoids excessive disk seeks by reading
 multiple pages on a page fault. The number of pages it reads
 is dependent on the amount of memory in your machine.
@@ -170,11 +265,12 @@ is dependent on the amount of memory in 
 The number of pages the kernel reads in at once is equal to
 2 ^ page-cluster. Values above 2 ^ 5 don't make much sense
 for swap because we only cluster swap data in 32-page groups.
+=============================================================
 
-==============================================================
 
-pagetable_cache:
 
+pagetable_cache:
+----------------
 The kernel keeps a number of page tables in a per-processor
 cache (this helps a lot on SMP systems). The cache size for
 each processor will be between the low and the high value.
@@ -188,3 +284,98 @@ For large systems, the settings are prob
 systems they won't hurt a bit. For small systems (<16MB ram)
 it might be advantageous to set both values to 0.
 
+The default value is: 25 50.
+=============================================================
+
+
+
+vm_anon_lru:
+------------
+select if to immdiatly insert anon pages in the lru.
+Immediatly means as soon as they're allocated during the page
+faults. If this is set to 0, they're inserted only after the
+first swapout.
+  
+Having anon pages immediatly inserted in the lru allows the
+VM to know better when it's worthwhile to start swapping
+anonymous ram, it will start to swap earlier and it should
+swap smoother and faster, but it will decrease scalability
+on the >16-ways of an order of magnitude. Big SMP/NUMA
+definitely can't take an hit on a global spinlock at
+every anon page allocation.
+
+Low ram machines that swaps all the time want to turn
+this on (i.e. set to 1).
+
+The default value is 1.
+=============================================================
+
+
+
+vm_cache_scan_ratio:
+--------------------
+is how much of the inactive LRU queue we will scan in one go.
+A value of 6 for vm_cache_scan_ratio implies that we'll scan
+1/6 of the inactive lists during a normal aging round.
+
+The default value is 6.
+=============================================================
+
+
+
+vm_gfp_debug:
+------------
+is when __alloc_pages fails, dump us a stack. This will
+mostly happen during OOM conditions (hopefully ;)
+
+The default value is 0.
+=============================================================
+
+
+
+vm_lru_balance_ratio:
+---------------------
+controls the balance between active and inactive cache. The
+bigger vm_balance is, the easier the active cache will grow,
+because we'll rotate the active list slowly. A value of 2
+means we'll go towards a balance of 1/3 of the cache being
+inactive.
+
+The default value is 2.
+=============================================================
+
+
+
+vm_mapped_ratio:
+----------------
+controls the pageout rate, the smaller, the earlier we'll
+start to pageout.
+
+The default value is 100.
+=============================================================
+
+
+
+vm_passes:
+----------
+is the number of vm passes before failing the memory
+balancing. Take into account 3 passes are needed for a
+flush/wait/free cycle and that we only scan
+1/vm_cache_scan_ratio of the inactive list at each pass.
+
+The default value is 60.
+=============================================================
+
+
+
+vm_vfs_scan_ratio:
+------------------
+is what proportion of the VFS queues we will scan in one go.
+A value of 6 for vm_vfs_scan_ratio implies that 1/6th of the
+unused-inode, dentry and dquot caches will be freed during a
+normal aging round.
+Big fileservers (NFS, SMB etc.) probably want to set this
+value to 3 or 2.
+
+The default value is 6.
+=============================================================
--- a/Documentation/filesystems/proc.txt	2004-05-23 00:08:31.000000000 +0200
+++ b/Documentation/filesystems/proc.txt	2004-05-23 02:33:41.000000000 +0200
@@ -936,172 +936,7 @@ program to load modules on demand.
 
 2.4 /proc/sys/vm - The virtual memory subsystem
 -----------------------------------------------
-
-The files  in  this directory can be used to tune the operation of the virtual
-memory (VM)  subsystem  of  the  Linux  kernel.  In addition, one of the files
-(bdflush) has some influence on disk usage.
-
-bdflush
--------
-
-This file  controls  the  operation of the bdflush kernel daemon. It currently
-contains nine  integer  values,  six of which are actually used by the kernel.
-They are listed in table 2-2.
-
-
-Table 2-2: Parameters in /proc/sys/vm/bdflush 
-..............................................................................
- Value      Meaning                                                            
- nfract     Percentage of buffer cache dirty to activate bdflush              
- ndirty     Maximum number of dirty blocks to  write out per wake-cycle        
- dummy      Unused                                                             
- dummy      Unused                                                             
- interval   jiffies delay between kupdate flushes
- age_buffer Time for normal buffer to age before we flush it                   
- nfract_sync Percentage of buffer cache dirty to activate bdflush synchronously
- nfract_stop_bdflush Percetange of buffer cache dirty to stop bdflush
- dummy      Unused                                                             
-..............................................................................
-
-nfract
-------
-
-This parameter  governs  the  maximum  number  of  dirty buffers in the buffer
-cache. Dirty means that the contents of the buffer still have to be written to
-disk (as  opposed  to  a  clean  buffer,  which  can just be forgotten about).
-Setting this  to  a  higher value means that Linux can delay disk writes for a
-long time, but it also means that it will have to do a lot of I/O at once when
-memory becomes short. A lower value will spread out disk I/O more evenly.
-
-interval
---------
-
-The interval between two kupdate runs. The value is expressed in
-jiffies (clockticks),  the  number of jiffies per second is 100.
-
-ndirty
-------
-
-Ndirty gives the maximum number of dirty buffers that bdflush can write to the
-disk at  one  time.  A high value will mean delayed, bursty I/O, while a small
-value can lead to memory shortage when bdflush isn't woken up often enough.
-
-age_buffer
-----------
-
-Finally, the age_buffer parameter govern the maximum time Linux
-waits before  writing  out  a  dirty buffer to disk. The value is expressed in
-jiffies (clockticks),  the  number of jiffies per second is 100.
-
-nfract_sync
------------
-
-nfract_stop_bdflush
--------------------
-
-kswapd
-------
-
-Kswapd is  the  kernel  swap  out daemon. That is, kswapd is that piece of the
-kernel that  frees  memory when it gets fragmented or full. Since every system
-is different, you'll probably want some control over this piece of the system.
-
-The file contains three numbers:
-
-tries_base
-----------
-
-The maximum  number  of  pages kswapd tries to free in one round is calculated
-from this  number.  Usually  this  number  will  be  divided  by  4  or 8 (see
-mm/vmscan.c), so it isn't as big as it looks.
-
-When you  need to increase the bandwidth to/from swap, you'll want to increase
-this number.
-
-tries_min
----------
-
-This is  the  minimum number of times kswapd tries to free a page each time it
-is called. Basically it's just there to make sure that kswapd frees some pages
-even when it's being called with minimum priority.
-
-overcommit_memory
------------------
-
-This file  contains  one  value.  The following algorithm is used to decide if
-there's enough  memory:  if  the  value of overcommit_memory is positive, then
-there's always  enough  memory. This is a useful feature, since programs often
-malloc() huge  amounts  of  memory 'just in case', while they only use a small
-part of  it.  Leaving  this value at 0 will lead to the failure of such a huge
-malloc(), when in fact the system has enough memory for the program to run.
-
-On the  other  hand,  enabling this feature can cause you to run out of memory
-and thrash the system to death, so large and/or important servers will want to
-set this value to 0.
-
-pagetable_cache
----------------
-
-The kernel  keeps a number of page tables in a per-processor cache (this helps
-a lot  on  SMP systems). The cache size for each processor will be between the
-low and the high value.
-
-On a  low-memory,  single  CPU system, you can safely set these values to 0 so
-you don't  waste  memory.  It  is  used  on SMP systems so that the system can
-perform fast  pagetable allocations without having to acquire the kernel memory
-lock.
-
-For large  systems,  the  settings  are probably fine. For normal systems they
-won't hurt  a  bit.  For  small  systems  (  less  than  16MB ram) it might be
-advantageous to set both values to 0.
-
-swapctl
--------
-
-This file  contains  no less than 8 variables. All of these values are used by
-kswapd.
-
-The first four variables
-* sc_max_page_age,
-* sc_page_advance,
-* sc_page_decline and
-* sc_page_initial_age
-are used  to  keep  track  of  Linux's page aging. Page aging is a bookkeeping
-method to  track  which pages of memory are often used, and which pages can be
-swapped out without consequences.
-
-When a  page  is  swapped in, it starts at sc_page_initial_age (default 3) and
-when the  page  is  scanned  by  kswapd,  its age is adjusted according to the
-following scheme:
-
-* If  the  page  was used since the last time we scanned, its age is increased
-  by sc_page_advance  (default  3).  Where  the  maximum  value  is  given  by
-  sc_max_page_age (default 20).
-* Otherwise  (meaning  it wasn't used) its age is decreased by sc_page_decline
-  (default 1).
-
-When a page reaches age 0, it's ready to be swapped out.
-
-The variables  sc_age_cluster_fract, sc_age_cluster_min, sc_pageout_weight and
-sc_bufferout_weight, can  be  used  to  control  kswapd's  aggressiveness  in
-swapping out pages.
-
-Sc_age_cluster_fract is used to calculate how many pages from a process are to
-be scanned by kswapd. The formula used is
-
-(sc_age_cluster_fract divided by 1024) times resident set size
-
-So if you want kswapd to scan the whole process, sc_age_cluster_fract needs to
-have a  value  of  1024.  The  minimum  number  of  pages  kswapd will scan is
-represented by sc_age_cluster_min, which is done so that kswapd will also scan
-small processes.
-
-The values  of  sc_pageout_weight  and sc_bufferout_weight are used to control
-how many  tries  kswapd  will make in order to swap out one page/buffer. These
-values can  be used to fine-tune the ratio between user pages and buffer/cache
-memory. When  you find that your Linux system is swapping out too many process
-pages in  order  to  satisfy  buffer  memory  demands,  you may want to either
-increase sc_bufferout_weight, or decrease the value of sc_pageout_weight.
+Please read Documentation/sysctl/vm.txt
 
 2.5 /proc/sys/dev - Device specific parameters
 ----------------------------------------------
@@ -1719,10 +1719,3 @@ need to  recompile  the kernel, or even 
 command to write value into these files, thereby changing the default settings
 of the kernel.
 ------------------------------------------------------------------------------
-
-
-
-
-
-
-

--Boundary-00=_iDOtA92Sc9fWH5x
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="01_remove-old-docu-VM.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="01_remove-old-docu-VM.patch"

--- a/Documentation/sysctl/vm.txt	2002-11-28 16:53:08.000000000 -0700
+++ b/Documentation/sysctl/vm.txt	2003-11-12 17:35:11.000000000 -0700
@@ -18,13 +18,10 @@
 
 Currently, these files are in /proc/sys/vm:
 - bdflush
-- buffermem
-- freepages
 - kswapd
 - max_map_count
 - overcommit_memory
 - page-cluster
-- pagecache
 - pagetable_cache
 
 ==============================================================
@@ -102,38 +99,6 @@
 of buffer cache that is dirty which will stop bdflush.
 The default is 20%, the miniumum is 0%, and the maxiumum is 100%.
 ==============================================================
-buffermem:
-
-The three values in this file correspond to the values in
-the struct buffer_mem. It controls how much memory should
-be used for buffer memory. The percentage is calculated
-as a percentage of total system memory.
-
-The values are:
-min_percent	-- this is the minimum percentage of memory
-		   that should be spent on buffer memory
-borrow_percent  -- UNUSED
-max_percent     -- UNUSED
-
-==============================================================
-freepages:
-
-This file contains the values in the struct freepages. That
-struct contains three members: min, low and high.
-
-The meaning of the numbers is:
-
-freepages.min	When the number of free pages in the system
-		reaches this number, only the kernel can
-		allocate more memory.
-freepages.low	If the number of free pages gets below this
-		point, the kernel starts swapping aggressively.
-freepages.high	The kernel tries to keep up to this amount of
-		memory free; if memory comes below this point,
-		the kernel gently starts swapping in the hopes
-		that it never has to do real aggressive swapping.
-
-==============================================================
 
 kswapd:
 
@@ -208,24 +173,6 @@
 
 ==============================================================
 
-pagecache:
-
-This file does exactly the same as buffermem, only this
-file controls the struct page_cache, and thus controls
-the amount of memory used for the page cache.
-
-In 2.2, the page cache is used for 3 main purposes:
-- caching read() data from files
-- caching mmap()ed data and executable files
-- swap cache
-
-When your system is both deep in swap and high on cache,
-it probably means that a lot of the swapped data is being
-cached, making for more efficient swapping than possible
-with the 2.0 kernel.
-
-==============================================================
-
 pagetable_cache:
 
 The kernel keeps a number of page tables in a per-processor
--- a/Documentation/filesystems/proc.txt	2004-05-21 22:54:13.000000000 +0200
+++ b/Documentation/filesystems/proc.txt	2004-05-23 00:08:09.000000000 +0200
@@ -999,54 +999,6 @@ nfract_sync
 nfract_stop_bdflush
 -------------------
 
-buffermem
----------
-
-The three  values  in  this  file  control  how much memory should be used for
-buffer memory.  The  percentage  is calculated as a percentage of total system
-memory.
-
-The values are:
-
-min_percent
------------
-
-This is  the  minimum  percentage  of  memory  that  should be spent on buffer
-memory.
-
-borrow_percent
---------------
-
-When Linux is short on memory, and the buffer cache uses more than it has been
-allotted, the  memory  management  (MM)  subsystem will prune the buffer cache
-more heavily than other memory to compensate.
-
-max_percent
------------
-
-This is the maximum amount of memory that can be used for buffer memory.
-
-freepages
----------
-
-This file contains three values: min, low and high:
-
-min
----
-When the  number  of  free  pages  in the system reaches this number, only the
-kernel can allocate more memory.
-
-low
----
-If the number of free pages falls below this point, the kernel starts swapping
-aggressively.
-
-high
-----
-The kernel  tries  to  keep  up to this amount of memory free; if memory falls
-below this point, the kernel starts gently swapping in the hopes that it never
-has to do really aggressive swapping.
-
 kswapd
 ------
 
@@ -1073,16 +1025,6 @@ This is  the  minimum number of times ks
 is called. Basically it's just there to make sure that kswapd frees some pages
 even when it's being called with minimum priority.
 
-swap_cluster
-------------
-
-This is probably the greatest influence on system performance.
-
-swap_cluster is  the  number  of  pages kswapd writes in one turn. You'll want
-this value  to  be  large  so that kswapd does its I/O in large chunks and the
-disk doesn't  have  to  seek  as  often, but you don't want it to be too large
-since that would flood the request queue.
-
 overcommit_memory
 -----------------
 
@@ -1097,15 +1039,6 @@ On the  other  hand,  enabling this feat
 and thrash the system to death, so large and/or important servers will want to
 set this value to 0.
 
-pagecache
----------
-
-This file  does exactly the same job as buffermem, only this file controls the
-amount of memory allowed for memory mapping and generic caching of files.
-
-You don't  want  the  minimum level to be too low, otherwise your system might
-thrash when memory is tight or fragmentation is high.
-
 pagetable_cache
 ---------------
 

--Boundary-00=_iDOtA92Sc9fWH5x--
