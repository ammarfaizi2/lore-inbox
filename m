Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVALQgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVALQgT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 11:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVALQgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 11:36:19 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:59619 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261240AbVALQf4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 11:35:56 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] dm snapshot problem
Date: Wed, 12 Jan 2005 10:36:35 -0600
User-Agent: KMail/1.7.1
Cc: "Rajesh S. Ghanekar" <rajesh_ghanekar@persistent.co.in>,
       DevMapper <dm-devel@redhat.com>, LKML <linux-kernel@vger.kernel.org>
References: <41E35950.9040201@persistent.co.in> <200501110834.42839.kevcorry@us.ibm.com> <41E5116E.7000709@persistent.co.in>
In-Reply-To: <41E5116E.7000709@persistent.co.in>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501121036.35928.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajesh,

[Cross-posting to dm-devel and lkml. See 
http://marc.theaimsgroup.com/?t=110507495500002&r=1&w=2
for additional background on this thread. The jist of the issue is that
DM snapshots are causing enormous slab usage, which eventually causes
an out-of-memory situation in the SCSI driver.]

On Wednesday 12 January 2005 6:00 am, Rajesh S. Ghanekar wrote:
> >Could you please send the /proc/slabinfo contents *before* running any of
> > the snapshot tests? I'm trying to determine if the dm_tio and dm_io usage
> > numbers are normal, or if those high numbers are caused by the snapshot
> > test.

I guess I should give some background first. The dm_io and dm_tio slabs
(which are actually backings for mempools) are used by the Device-Mapper
core I/O path. When an I/O request (represented by a bio structure) is
submitted to DM, DM clones that original bio and hangs on to it, and
submits the cloned bio to the next layer down the device stack. The
reason for the cloning is that a large bio submitted to DM may need to
be split into multiple bios due to internal boundaries in the DM device.
For instance, if you have a striped DM device with a 32kB chunk-size,
any I/O request that spans across one of these 32kB boundaries must be
split up, so the relevant portions of the I/O request can be sent to the
correct disks. To track each incoming bio, DM allocates a struct from
the dm_io pool, and to track each of the multiple cloned/split bio that
gets submitted to the next layer, DM allocates a struct from the dm_tio
pool. When each cloned bio completes (from the lower-level device driver),
the associated dm_tio struct is freed, and when all cloned bios for one
original bio complete, the dm_io for that original bio is freed, and the
original bio is marked complete and sent back to the original submitter.

In your non-snapshot test, you've simply got a linear DM device with no
internal boundaries, so an I/O will never need to be split into multiple
bios, and each I/O request will get one dm_io and one dm_tio struct. Also,
DM-linear devices are very simple, and just add some constant value to the
starting offset of the incoming bio. So the request can immediately be
driven down to the next layer. Thus, you see relatively few active objects
and slabs in the dm_io and dm_tio slabs (as we see from your /proc/slabinfo
output).


======================== START ======================================
---------------------
| Without Snapshot  |
---------------------

# dd if=/dev/sda5 of=/dev/evms/evms_lv &

# watch "cat /proc/slabinfo | sed -n 2p ; cat /proc/slabinfo  | grep dm"
# name <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
dm_tio 4771 12204 16 226 1 : tunables 120 60 8 : slabdata 54 54 264
dm_io  4771 11978 16 226 1 : tunables 120 60 8 : slabdata 53 53 264

Note: sometimes during dd test, <active_slabs> and <num_slabs> goes to 
211 (etc.), but it drops to low value immidiately.

After dd test is complete, all values return back to their normal before 
the test:
# cat /proc/slabinfo | sed -n 2p ; cat /proc/slabinfo  | grep dm
# name <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
dm_tio 4352 4520 16 226 1 : tunables 120 60 8 : slabdata 20 20 0
dm_io  4352 4520 16 226 1 : tunables 120 60 8 : slabdata 20 20 0
========================= STOP ======================================


Then you create the snapshot device. You'll notice some additional slabs
are created to help with allocating internal snapshot data structures
(dm-snapshot-[in|ex]), and for performing the copying of data from the
origin device to the snapshot device (dm-io-*). At this point, the dm_io
and dm_tio slabs haven't changed much, because there's no additional I/O
yet.


======================== START ======================================
------------------
| With Snapshot  |
------------------

After i enable snapshot on /dev/evms/evms_lv:
# cat /proc/slabinfo | sed -n 2p ; cat /proc/slabinfo  | grep dm
# name <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
dm-io-5         16   16 3072   2 2 : tunables  24 12 8 : slabdata  8  8  0
dm-io-4         32   35 1536   5 2 : tunables  24 12 8 : slabdata  7  7  0
dm-io-3         64   65  768   5 1 : tunables  54 27 8 : slabdata 13 13  0
dm-io-2        128  135  256  15 1 : tunables 120 60 8 : slabdata  9  9  0
dm-io-1        256  305   64  61 1 : tunables 120 60 8 : slabdata  5  5  0
dm-io-0        512  678   16 226 1 : tunables 120 60 8 : slabdata  3  3  0
dm-io-bio      512  527  128  31 1 : tunables 120 60 8 : slabdata 17 17  0
dm-snapshot-in 128  140   56  70 1 : tunables 120 60 8 : slabdata  2  2  0
dm-snapshot-ex   0    0   24 156 1 : tunables 120 60 8 : slabdata  0  0  0
dm_tio        5165 5424   16 226 1 : tunables 120 60 8 : slabdata 24 24 42
dm_io         5165 5424   16 226 1 : tunables 120 60 8 : slabdata 24 24 42
========================= STOP ======================================


However, once you start I/O on the snapshot or origin device, you see the
dm_io and dm_tio slab usage skyrocket (over 1 million active objects and
several thousand slabs).


======================== START ======================================
# dd if=/dev/sda5 of=/dev/evms/evms_lv &

# watch "cat /proc/slabinfo | sed -n 2p ; cat /proc/slabinfo  | grep dm"
# name <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
dm-io-5          16   16  3072   2 2 : tunables  24 12 8 : slabdata    8    8  0
dm-io-4          32   35  1536   5 2 : tunables  24 12 8 : slabdata    7    7  0
dm-io-3         105  120   768   5 1 : tunables  54 27 8 : slabdata   24   24  0
dm-io-2         128  135   256  15 1 : tunables 120 60 8 : slabdata    9    9  0
dm-io-1         256  305    64  61 1 : tunables 120 60 8 : slabdata    5    5  0
dm-io-0         512  678    16 226 1 : tunables 120 60 8 : slabdata    3    3  0
dm-io-bio       637  651   128  31 1 : tunables 120 60 8 : slabdata   21   21  0
dm-snapshot-in 8296 8330    56  70 1 : tunables 120 60 8 : slabdata  119  119  0
dm-snapshot-ex   64  156    24 156 1 : tunables 120 60 8 : slabdata    1    1  0
dm_tio      1046726 1046832 16 226 1 : tunables 120 60 8 : slabdata 4632 4632 60
dm_io       1046726 1046832 16 226 1 : tunables 120 60 8 : slabdata 4632 4632 60

# watch "cat /proc/slabinfo | sed -n 2p ; cat /proc/slabinfo  | grep dm"
# name <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
dm-io-5          16   16 3072   2 2 : tunables  24 12 8 : slabdata    8    8  0
dm-io-4          32   35 1536   5 2 : tunables  24 12 8 : slabdata    7    7  0
dm-io-3         117  120  768   5 1 : tunables  54 27 8 : slabdata   24   24  0
dm-io-2         128  135  256  15 1 : tunables 120 60 8 : slabdata    9    9  0
dm-io-1         256  305   64  61 1 : tunables 120 60 8 : slabdata    5    5  0
dm-io-0         512  678   16 226 1 : tunables 120 60 8 : slabdata    3    3  0
dm-io-bio       595  620  128  31 1 : tunables 120 60 8 : slabdata   20   20  0
dm-snapshot-in 7485 9030   56  70 1 : tunables 120 60 8 : slabdata  129  129  0
dm-snapshot-ex 4096 4212   24 156 1 : tunables 120 60 8 : slabdata   27   27  0
dm_tio       946940 946940 16 226 1 : tunables 120 60 8 : slabdata 4190 4190 60
dm_io        946940 946940 16 226 1 : tunables 120 60 8 : slabdata 4190 4190 60
========================= STOP ======================================


A little more background on snapshotting first. When a I/O write request
is submitted to a snapshot-origin device, and that "chunk" of data on the
origin has not yet been copied to the snapshot, DM puts the submitted bio
on an internal queue associated with that chunk. DM then starts to copy
that chunk from the origin to the snapshot, and when the copy completes,
it must write out a new mapping table to the snapshot device. When all of
this is finished, the original bio (and any other bios that might have also
come in and are waiting for that chunk) can be taken off the queue and
finally submitted to the origin device.

Writes to the snapshot device work very similarly.

The underlying reason for the increased usage in the dm_io and dm_tio
seems to be related to improvements in the page-cache and I/O-schedulers
in the 2.6 kernel.

When you start dd, it reads in as much data as it can from the source
device into the page-cache. At some point, the page-cache starts getting
full, and pdflush decides to start writing those pages to the snapshot-
origin device. Each submitted bio goes through the process described above.
However, as soon as DM puts each bio on its internal per-chunk-queues, DM
can then return back to pdflush, which continues to drive requests to the
snapshot-origin device.

After talking with a friend with a bit more understanding of the workings
of the new I/O scheduler, it seems that the way this process is *intended*
to work is for pdflush to block once a request-queue for a device fills
up to a certain point. Until I/Os have been processed from the full
request-queue, pdflush won't be allowed to submit any new requests, and
everybody gets to make some forward progress.

The problem is that DM doesn't use a proper request-queue in the way that,
say, the IDE or SCSI drivers use them. DM's goal is merely to remap a
given bio and send it down the stack. It doesn't generally want to collect
multiple bios onto a queue to process them later. But we do get into
situations like snapshotting where internal queueing becomes necessary. So,
since DM doesn't have a proper request-queue, it can't force pdflush into
this throttling mode. So pdflush just continually submits I/Os to the
snapshot-origin, all while DM is attempting to copy data chunks from the
origin to the snapshot and update the snapshot metadata. This is why we are
seeing the dm_io and dm_tio usage go into the millions, since every bio
submitted to DM has one of each of these.

So eventually we get into a state where nearly all LowMem is used up,
because all of these data structures are being allocated from kernel
memory (hence you see very little HighMem usage).


======================== START ======================================
# cat /proc/meminfo
MemTotal:      2075584 kB
MemFree:       1166472 kB
Buffers:        600956 kB
Cached:           6420 kB
SwapCached:          0 kB
Active:          22752 kB
Inactive:       589560 kB
HighTotal:     1179584 kB
HighFree:      1164608 kB
LowTotal:       896000 kB
LowFree:          1864 kB
SwapTotal:     1020116 kB
SwapFree:      1020116 kB
Dirty:          105032 kB
Writeback:      483248 kB
Mapped:           7856 kB
Slab:           286120 kB
Committed_AS:    19624 kB
PageTables:        636 kB
VmallocTotal:   114680 kB
VmallocUsed:      2592 kB
VmallocChunk:   110088 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB
========================= STOP ======================================


At some point, the SCSI driver goes to allocate some memory, and the
kernel can't find enough free pages, and you get the panic that you've
been seeing.


======================== START ======================================
# dmesg
kcopyd: page allocation failure. order:0, mode:0x20
 [<c01469cb>] __alloc_pages+0x1cb/0x370
 [<c0146b8f>] __get_free_pages+0x1f/0x40
 [<c014a06e>] kmem_getpages+0x1e/0xd0
 [<c014ad6f>] cache_grow+0xbf/0x150
 [<c014aed0>] cache_alloc_refill+0xd0/0x210
 [<c025b780>] as_remove_queued_request+0x70/0x100
 [<c014b1f8>] kmem_cache_alloc+0x58/0x70
 [<c028a263>] __scsi_get_command+0x23/0x80
 [<c028a2d1>] scsi_get_command+0x11/0x90
 [<c028ff43>] scsi_prep_fn+0x133/0x1f0
 [<c0148a6c>] pdflush_operation+0xac/0xd0
 [<c025384a>] elv_next_request+0x4a/0xf0
 [<c025570c>] blk_remove_plug+0x3c/0x70
 [<c0145554>] mempool_alloc+0xf4/0x170
 [<c0255762>] __generic_unplug_device+0x22/0x30
 [<c0255785>] generic_unplug_device+0x15/0x30
 [<c0255f58>] get_request_wait+0x78/0xf0
 [<c01230b0>] autoremove_wake_function+0x0/0x50
 [<c0255c87>] freed_request+0xa7/0xb0
 [<c01230b0>] autoremove_wake_function+0x0/0x50
 [<c02569c3>] __make_request+0xf3/0x4b0
 [<c0256eed>] generic_make_request+0x16d/0x1f0
 [<c01454ee>] mempool_alloc+0x8e/0x170
 [<c01665fd>] bio_clone+0xd/0x80
 [<f8a81361>] __map_bio+0x41/0x110 [dm_mod]
 [<f8a815ec>] __clone_and_map+0xcc/0x310 [dm_mod]
 [<c01230b0>] autoremove_wake_function+0x0/0x50
 [<c0120c16>] find_busiest_group+0xf6/0x340
 [<f8a818d7>] __split_bio+0xa7/0x120 [dm_mod]
 [<f8a819d4>] dm_request+0x84/0xb0 [dm_mod]
 [<c0256eed>] generic_make_request+0x16d/0x1f0
 [<c014aea7>] cache_alloc_refill+0xa7/0x210
 [<c0145651>] mempool_free+0x81/0x90
 [<f89df97f>] flush_bios+0x1f/0x30 [dm_snapshot]
 [<f89e1193>] persistent_commit+0xd3/0xe0 [dm_snapshot]
 [<f89dfca0>] copy_callback+0x40/0x50 [dm_snapshot]
 [<f8a88519>] segment_complete+0x169/0x240 [dm_mod]
 [<f8a883b0>] segment_complete+0x0/0x240 [dm_mod]
 [<f8a8805d>] run_complete_job+0x4d/0x70 [dm_mod]
 [<f8a88010>] run_complete_job+0x0/0x70 [dm_mod]
 [<f8a882b2>] process_jobs+0x62/0xe0 [dm_mod]
 [<f8a8833f>] do_work+0xf/0x30 [dm_mod]
 [<c0134a7d>] worker_thread+0x1bd/0x260
 [<f8a88330>] do_work+0x0/0x30 [dm_mod]
 [<c0121850>] default_wake_function+0x0/0x10
 [<c0121850>] default_wake_function+0x0/0x10
 [<c01348c0>] worker_thread+0x0/0x260
 [<c01388ac>] kthread+0x9c/0xb0
 [<c0138810>] kthread+0x0/0xb0
 [<c01052dd>] kernel_thread_helper+0x5/0x18
Now at this point everything seems to be locked. No repsonse at all.
========================= STOP ======================================


So, if my understanding of pdflush is correct (someone please correct me
if my explaination above is wrong), we need to be doing some sort of
throttling in the snapshot code when we reach a certain number of
internally queued bios. Such a throttling mechanism would not be difficult
to add. Just add a per-snapshot counter for the total number of bios that
are currently waiting for chunks to be copied. If this number goes over
some limit, simply block the thread until the number goes back below the
limit.

Hopefully someone on lkml can advise us as to whether this is the correct
approach. And if it is, how should we determine the queue limit value?
Also, are there any other memory usage issues we should be aware of that I
haven't mentioned yet?

Here is more test methodology information from Rajesh if anyone would
like to try to duplicate his tests.

Thanks for any feedback anyone might have about this!

> # fdisk -l /dev/sda
> This disk has both DOS and BSD magic.
> Give the 'b' command to go to BSD mode.
>
> Disk /dev/sda: 913.3 GB, 913309696000 bytes
> 255 heads, 63 sectors/track, 111036 cylinders
> Units = cylinders of 16065 * 512 = 8225280 bytes
>
>    Device Boot    Start       End    Blocks   Id  System
> /dev/sda1   *         1     10199  81923436   83  Linux
> /dev/sda2         10200     10326   1020127+  82  Linux swap
> /dev/sda3         10327     12880  20515005   83  Linux
> /dev/sda4         12881    111036 788438070    f  Win95 Ext'd (LBA)
> /dev/sda5         12881     13142   2104483+  83  Linux
> /dev/sda6         13143     13392   2008093+  83  Linux
> /dev/sda7         13393     13642   2008093+  83  Linux
> /dev/sda8         13643     13892   2008093+  83  Linux
> /dev/sda9         13893     14142   2008093+  83  Linux
> /dev/sda10        14143     14392   2008093+  83  Linux
> /dev/sda11        14393     14642   2008093+  83  Linux
> /dev/sda12        14643     14892   2008093+  83  Linux
> /dev/sda13        14893     15142   2008093+  83  Linux
> /dev/sda14        15143     15392   2008093+  83  Linux
> /dev/sda15        15393     15642   2008093+  83  Linux
>
> I am using partitions sda1-sda3 for my own use, sda5 for data copy
> in/out, and partitions
> sda6-sda15 for EVMS and LVM2.
>
> Without Snapshot:
> -----------------------
> # dd if=/dev/sda5 of=/dev/evms/evms_lv                  -> works
> # dd if=/dev/evms/evms_lv of=/dev/sda5                  -> works
> # mount /dev/evms/evms_lv /mnt/testdata
> Copy data to /mnt/testdata to its full capacity.
> # cp -a /usr/* /mnt/testdata/
> # tar cf /mnt/data/data.tar /mnt/testdata                       -> works
> Remove all the data from /mnt/testdata
> # rm -rf /mnt/testdata/*
> # tar xf /mnt/data/data.tar -C /mnt/testdata                  -> works
>
> With Snapshot:
> -------------------
> A. Origin volume
>
> # dd if=/dev/sda5 of=/dev/evms/evms_lv                  -> doesn't work
> (locks - OOM)
> # dd if=/dev/evms/evms_lv of=/dev/sda5                  -> works
> # mount /dev/evms/evms_lv /mnt/testdata
> Copy data to /mnt/testdata to its full capacity.
> # cp -a /usr/* /mnt/testdata/
> # tar cf /mnt/data/data.tar /mnt/testdata                       -> works
> Remove all the data from /mnt/testdata
> # rm -rf /mnt/testdata/*
> # tar xf /mnt/data/data.tar -C /mnt/testdata                  -> works
>
> B. Snapshot volume
> These tests and their results are same as that of Origin volume.
>
> Sysctl values that i am using:
> echo 0 > /proc/sys/vm/swappiness
> echo 500 > /proc/sys/vm/lower_zone_protection
> echo 876 > /proc/sys/vm/min_free_kbytes
> Note: Changing these values doesn't have any effect on tests.


-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
