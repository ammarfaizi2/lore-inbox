Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUCKRIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 12:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUCKRIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 12:08:12 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:31772 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261614AbUCKRHB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 12:07:01 -0500
Subject: Re: 2.6.4-mm1
From: Redeeman <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040310233140.3ce99610.akpm@osdl.org>
References: <20040310233140.3ce99610.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079024816.5325.2.camel@redeeman.linux.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 18:06:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey andrew, i have a problem with this kernel, when it boots, it lists
vp_ide and stuff, and then suddenly after that my screen gets flodded
with sys traces and stuff, i cant even read it, so fast they come, and
the syste doesnet go further, i havent tried 2.6.4 vanilla yet, but i
will now.

if u got any ideas, please tell me, and i will test

On Thu, 2004-03-11 at 08:31, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4/2.6.4-mm1/
> 
> 
> 
> - The CPU scheduler changes in -mm (sched-domains) have been hanging about
>   for too long.  I had been hoping that the people who care about SMT and
>   NUMA performance would have some results by now but all seems to be silent.
> 
>   I do not wish to merge these up until the big-iron guys can say that they
>   suit their requirements, with a reasonable expectation that we will not
>   need to churn this code later in the 2.6 series.
> 
>   So.  If you have been testing, please speak up.  If you have not been
>   testing, please do so.
> 
> 
> - Major surgery against the pagecache, radix-tree and writeback code.  This
>   work is to address the O_DIRECT-vs-buffered data exposure horrors which
>   we've been struggling with for months.
> 
>   As a side-effect, 32 bytes are saved from struct inode and eight bytes
>   are removed from struct page.
> 
>   This change will break any arch code which is using page->list and will
>   also break any arch code which is using page->lru of memory which was
>   obtained from slab.
> 
>   It seems to work OK here, but I suggest people not rush out and convert
>   all of the corporate finance department's servers to 2.6.4-mm1.
> 
>   The basic problem which we (mainly Daniel McNeil) have been struggling
>   with is in getting a really reliable fsync() across the page lists while
>   other processes are performing writeback against the same file.  It's like
>   juggling four bars of wet soap with your eyes shut while someone is
>   whacking you with a baseball bat.  Daniel pretty much has the problem
>   plugged but I suspect that's just because we don't have testcases to
>   trigger the remaining problems.  The complexity and additional locking
>   which those patches add is worrisome.
> 
>   So the approach taken here is to remove the page lists altogether and
>   replace the list-based writeback and wait operations with in-order
>   radix-tree walks.
> 
>   The radix-tree code has been enhanced to support "tagging" of pages, for
>   later searches for pages which have a particular tag set.  This means that
>   we can ask the radix tree code "find me the next 16 dirty pages starting at
>   pagecache index N" and it will do that in O(log64(N)) time.
> 
>   This affects I/O scheduling potentially quite significantly.  It is no
>   longer the case that the kernel will submit pages for I/O in the order in
>   which the application dirtied them.  We instead submit them in file-offset
>   order all the time.
> 
>   This is likely to be advantageous when applications are seeking all over
>   a large file randomly writing small amounts of data.  I haven't performed
>   much benchmarking, but tiobench random write throughput seems to be
>   increased by 30%.  Other tests appear to be unaltered.  dbench may have got
>   10-20% quicker, but it's variable.
> 
>   There is one large file which everyone seeks all over randomly writing
>   small amounts of data: the blockdev mapping which caches filesystem
>   metadata.  The kernel's IO submission patterns for this are now ideal.
> 
> 
>   Because writeback and wait-for-writeback use a tree walk instead of a
>   list walk they are no longer livelockable.  This probably means that we no
>   longer need to hold i_sem across O_SYNC writes and perhaps fsync() and
>   fdatasync().  This may be beneficial for databases: multiple processes
>   writing and syncing different parts of the same file at the same time can
>   now all submit and wait upon writes to just their own little bit of the
>   file, so we can get a lot more data into the queues.
> 
>   It is trivial to implement a part-file-fdatasync() as well, so
>   applications can say "sync the file from byte N to byte M", and multiple
>   applications can do this concurrently.  This is easy for ext2 filesystems,
>   but probably needs lots of work for data-journalled filesystems and XFS and
>   it probably doesn't offer much benefit over an i_semless O_SYNC write.
> 
> - Dropped the hotplug CPU patches: bits of them were merged into Linus's
>   kernel and things broke.
> 
> - Various little fixes as usual.
> 
> 
> 
> 
> Changes since 2.6.4-rc2-mm1:
> 
> 
>  bk-acpi.patch
>  bk-alsa.patch
>  bk-driver-core.patch
>  bk-i2c.patch
>  bk-input.patch
>  bk-netdev.patch
>  bk-pci.patch
>  bk-scsi.patch
>  bk-usb.patch
> 
>  Latest external trees
> 
> -export-filemap_flush.patch
> -vma-corruption-fix.patch
> -centaur-crypto-core-support.patch
> 
>  Merged
> 
> +bk-acpi-warning-fix.patch
> 
>  Fix a warning
> 
> +x86_64-update.patch
> 
>  Latest x86_64 code drop
> 
> +print-kernel-version-in-oops.patch
> 
>  Display the kernel version in the x86 oops message
> 
> +ppc64-iseries-virtual-console-fix.patch
> 
>  iSeries device number fix
> 
> -zap_page_range-debug.patch
> 
>  Turns out the code path which this patch was trying to detect the deadness
>  of is in fact used.
> 
> +sched-stats-64-bit.patch
> 
>  Use 64-bit numbers for various CPU scheduler statistics
> 
> -hotplugcpu-generalise-bogolock.patch
> -hotplugcpu-generalise-bogolock-fix-for-kthread-stop-using-signals.patch
> -hotplugcpu-use-bogolock-in-modules.patch
> -hotplugcpu-core.patch
> -stop_machine-warning-fix.patch
> -hotplugcpu-core-sparc64-build-fix.patch
> -hotplugcpu-core-fix-for-kthread-stop-using-signals.patch
> -migrate_to_cpu-dependency-fix.patch
> -hotplugcpu-core-drain_local_pages-fix.patch
> -hotplugcpu-rcupdate-many-cpus-fix.patch
> 
>  Dropped
> 
> -ext3-dirty-debug-patch.patch
> 
>  This debug trap never triggered
> 
> -fusion-use-min-max.patch
> 
>  Other changes broke this
> 
> +dm-map-rwlock-ng.patch
> 
>  New version of spinlocking for the device mapper map tables
> 
> +dm-remove-__dm_request.patch
> 
>  Remvoe __dm_request()
> 
> +md-array-assembly-major-fix.patch
> 
>  RAID fix
> 
> +fadvise-fixups.patch
> 
>  Fix some fadvise() boundary conditions
> 
> +validate_mm-fixes.patch
> 
>  Enhance validate_mm()
> 
> +3ware-update.patch
> 
>  3ware driver update
> 
> +3c59x-xcvr-fix.patch
> 
>  Fix 3c59x transceiver handling
> 
> +current_is_keventd-speedup.patch
> 
>  Simplify current_is_keventd()
> 
> +root-ramdisk-fix.patch
> 
>  Make "root=/dev/ram" work again
> 
> +cciss-per-device-queues.patch
> 
>  per-device queues for the cciss driver
> 
> +blkdev-fix-final-page.patch
> 
>  Fix reads of the final block of blockdevs
> 
> +wavfront-needs-syscalls_h.patch
> 
>  Warning (and possible oops) fixes
> 
> +edd-legacy-parameters-fix.patch
> 
>  EDD back-compatibility
> 
> +cciss-section-fix.patch
> 
>  __init section fix
> 
> +pte_chain-nowarns.patch
> 
>  Prevent possible-but-expected page allocator warnings
> 
> +macintosh-config-fix.patch
> 
>  Don't offer mac drivers on other platforms
> 
> +applicom-warning-fix.patch
> 
>  Fix a warning
> 
> +CONFIG_NVRAM-dependencies.patch
> 
>  Fix NVRAM dependencies
> 
> +move-job-control-stuff-tosignal_struct.patch
> 
>  Move various job control fields out of the task_struct and into the
>  signal_struct.
> 
> +module_h-attribute_used-fix.patch
> 
>  __attribute_used__ sanity
> 
> +kobject-module-request-64-bit-fix.patch
> 
>  Fix for 64-bit machines
> 
> +sch_htb-fix.patch
> 
>  netfilter 64-bit fix
> 
> +blk-congestion-races.patch
> 
>  Conceivably fix rare races in blk_congestion_wait()
> 
> +vm-lrutopage-cleanup.patch
> 
>  Add a handy macro to tidy up vmscan.c
> 
> +radix-tree-tagging.patch
> 
>  Add search tagging to radix trees.
> 
> +irq-safe-pagecache-lock.patch
> 
>  Make mapping->page_lock irq-safe, and rename it to tree_lock to detect
>  missed conversions.
> 
> +tag-dirty-pages.patch
> 
>  Tag dirty pages as being dirty within their radix trees.
> 
> +tag-writeback-pages.patch
> 
>  Tag writeback pages as being under writeback in their radix trees
> 
> +stop-using-dirty-pages.patch
> +stop-using-io-pages.patch
> +stop-using-locked-pages.patch
> +stop-using-clean-pages.patch
> 
>  Wean the kernel off the four address_space page lists
> 
> +unslabify-pgds-and-pmds.patch
> 
>  We cannot use page->lru to manage slab-derived pages: slab itself wants to
>  use it.
> 
> +slab-stop-using-page-list.patch
> 
>  Switch slab page management from page->list to page->lru.
> 
> +page_alloc-stop-using-page-list.patch
> 
>  Switch the page allocator from using page->list to using page->lru.
> 
> +hugetlb-stop-using-page-list.patch
> 
>  Switch the hugetlbpage implementations from using page->list to using
>  page->lru.
> 
> +pageattr-stop-using-page-list.patch
> 
>  Switch the pageattr code (CONFIG_DEBUG_PAGEALLOC) from using page->list to
>  using page->lru.
> 
> +readahead-stop-using-page-list.patch
> 
>  Switch the readpages() API from using page->list over to using page->lru.
> 
> +compound-pages-stop-using-lru.patch
> 
>  Teach the compound page management to use page fields other than page->list.
> 
> +remove-page-list.patch
> 
>  Remove the `list' field from struct page.
> 
> +remap-file-pages-prot-ia64-2.6.4-rc2-mm1-A0.patch
> 
>  Implement the per-page-permissions-in-remap_file_pages for ia64.  Hasn't
>  been tested.
> 
> -4g4g-THREAD_SIZE-fixes.patch
> -4g4g-handle_BUG-fix.patch
> 
>  Folded into 4g-2.6.0-test2-mm2-A5.patch
> 
> O_DIRECT-vs-buffered-fix.patch
> O_DIRECT-vs-buffered-fix-pdflush-hang-fix.patch
> serialise-writeback-fdatawait.patch
> restore-writeback-trylock.patch
> 
>  Dropped.   Hopefully we don't need these any more.
> 
> 
> 
> 
> 
> 
> All 258 patches:
> 
> 
> 
> bk-acpi.patch
> 
> bk-alsa.patch
> 
> bk-driver-core.patch
> 
> bk-i2c.patch
> 
> bk-input.patch
> 
> bk-netdev.patch
> 
> bk-pci.patch
> 
> bk-scsi.patch
> 
> bk-usb.patch
> 
> mm.patch
>   add -mmN to EXTRAVERSION
> 
> dma_sync_for_device-cpu.patch
>   dma_sync_for_{cpu,device}()
> 
> bk-acpi-warning-fix.patch
>   bk-acpi warning fixes
> 
> x86_64-update.patch
>   x86-64 merge for 2.6.4
> 
> move-dma_consistent_dma_mask.patch
>   move consistent_dma_mask to the generic device
> 
> move-dma_consistent_dma_mask-x86_64-fix.patch
> 
> move-dma_consistent_dma_mask-sn-fix.patch
>   Fix dma_mask patch for sn platform
> 
> print-kernel-version-in-oops.patch
>   print kernel version in oops messages
> 
> kgdb-ga.patch
>   kgdb stub for ia32 (George Anzinger's one)
>   kgdbL warning fix
>   kgdb buffer overflow fix
>   kgdbL warning fix
>   kgdb: CONFIG_DEBUG_INFO fix
>   x86_64 fixes
>   correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
> 
> kgdb-ga-recent-gcc-fix.patch
>   kgdb: fix for recent gcc
> 
> kgdboe-netpoll.patch
>   kgdb-over-ethernet via netpoll
> 
> kgdboe-non-ia32-build-fix.patch
> 
> kgdb-warning-fixes.patch
>   kgdb warning fixes
> 
> kgdb-x86_64-support.patch
>   kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
> 
> kgdb-THREAD_SIZE-fixes.patch
>   THREAD_SIZE fixes for kgdb
> 
> must-fix.patch
>   must fix lists update
>   must fix list update
>   mustfix update
> 
> must-fix-update-5.patch
>   must-fix update
> 
> ppc64-iseries-virtual-console-fix.patch
>   ppc64: fix iSeries virtual console devices
> 
> ppc64-reloc_hide.patch
> 
> compat-signal-noarch-2004-01-29.patch
>   Generic 32-bit compat for copy_siginfo_to_user
> 
> compat-generic-ipc-emulation.patch
>   generic 32 bit emulation for System-V IPC
> 
> remove-sys_ioperm-stubs.patch
>   Clean up sys_ioperm stubs
> 
> readdir-cleanups.patch
>   readdir() cleanups
> 
> ext3-journalled-quotas-2.patch
>   ext3: journalled quota
> 
> invalidate_inodes-speedup.patch
>   invalidate_inodes speedup
>   more invalidate_inodes speedup fixes
> 
> cfq-4.patch
>   CFQ io scheduler
>   CFQ fixes
> 
> config_spinline.patch
>   uninline spinlocks for profiling accuracy.
> 
> pdflush-diag.patch
> 
> get_user_pages-handle-VM_IO.patch
>   fix get_user_pages() against mappings of /dev/mem
> 
> pci_set_power_state-might-sleep.patch
> 
> CONFIG_STANDALONE-default-to-n.patch
>   Make CONFIG_STANDALONE default to N
> 
> extra-buffer-diags.patch
> 
> CONFIG_SYSFS.patch
>   From: Pat Mochel <mochel@osdl.org>
>   Subject: [PATCH] Add CONFIG_SYSFS
> 
> CONFIG_SYSFS-boot-from-disk-fix.patch
> 
> slab-leak-detector.patch
>   slab leak detector
>   mm/slab.c warning in cache_alloc_debugcheck_after
> 
> scale-nr_requests.patch
>   scale nr_requests with TCQ depth
> 
> truncate_inode_pages-check.patch
> 
> local_bh_enable-warning-fix.patch
> 
> sched-stats-64-bit.patch
>   Use 64-bit counters for scheduler stats
> 
> sched-find_busiest_node-resolution-fix.patch
>   sched: improved resolution in find_busiest_node
> 
> sched-domains.patch
>   sched: scheduler domain support
>   sched: fix for NR_CPUS > BITS_PER_LONG
>   sched: clarify find_busiest_group
>   sched: find_busiest_group arithmetic fix
> 
> sched-domains-improvements.patch
>   sched domains kernbench improvements
> 
> sched-clock-fixes.patch
>   fix sched_clock()
> 
> sched-sibling-map-to-cpumask.patch
>   sched: cpu_sibling_map to cpu_mask
>   p4-clockmod sibling_map fix
>   p4-clockmod: handle more than two siblings
> 
> sched-domains-i386-ht.patch
>   sched: implement domains for i386 HT
>   sched: Fix CONFIG_SMT oops on UP
>   sched: fix SMT + NUMA bug
>   Change arch_init_sched_domains to use cpu_online_map
>   Fix build with NR_CPUS > BITS_PER_LONG
> 
> sched-domain-tweak.patch
>   i386-sched-domain code consolidation
> 
> sched-no-drop-balance.patch
>   sched: handle inter-CPU jiffies skew
> 
> sched-directed-migration.patch
>   sched_balance_exec(): don't fiddle with the cpus_allowed mask
> 
> sched-domain-debugging.patch
>   sched_domain debugging
> 
> sched-domain-balancing-improvements.patch
>   scheduler domain balancing improvements
> 
> sched-group-power.patch
>   sched-group-power
>   sched-group-power warning fixes
> 
> sched-domains-use-cpu_possible_map.patch
>   sched_domains: use cpu_possible_map
> 
> sched-smt-nice-handling.patch
>   sched: SMT niceness handling
> 
> sched-smt-nice-optimisation.patch
>   sched: SMT-ice optimisation
> 
> fa311-mac-address-fix.patch
>   wrong mac address with netgear FA311 ethernet card
> 
> laptop-mode-2.patch
>   laptop-mode for 2.6, version 6
>   Documentation/laptop-mode.txt
>   laptop-mode documentation updates
>   Laptop mode documentation addition
>   laptop mode simplification
> 
> pid_max-fix.patch
>   Bug when setting pid_max > 32k
> 
> use-soft-float.patch
>   Use -msoft-float
> 
> DRM-cvs-update.patch
>   DRM cvs update
> 
> drm-include-fix.patch
> 
> process-migration-speedup.patch
>   Reduce TLB flushing during process migration
> 
> nfs-31-attr.patch
>   NFSv2/v3/v4: New attribute revalidation code
> 
> nfs-reconnect-fix.patch
> 
> nfs-mount-fix.patch
>   Update to NFS mount....
> 
> nfs-d_drop-lowmem.patch
>   NFS: handle nfs_fhget() error
> 
> nfs-avoid-i_size_write.patch
>   NFS: avoid unlocked i_size_write()
> 
> nfs_unlink-oops-fix.patch
>   nfs: fix "busy inodes after umount"
> 
> nfs-remove-XID-spinlock.patch
>   nfs: Remove an unnecessary spinlock from XID generation...
> 
> nfs-misc-rpc-fixes.patch
>   nfs: Misc RPC fixes...
> 
> nfs-improved-writeback-strategy.patch
>   nfs: improve writeback caching
> 
> nfs-simplify-config-options.patch
>   nfs: simplify client configuration options.
> 
> nfs-fix-msync.patch
>   nfs: fix msync()
> 
> nfs-mount-return-useful-errors.patch
>   nfs: make mount command return more useful errors
> 
> nfs-misc-minor-fixes.patch
>   nfs: misc minor fixes
> 
> nfs-lockd-sync-01.patch
>   nfs: sync lockd to 2.4.x
> 
> nfs-lockd-sync-02.patch
>   nfs: sync lockd to 2.4.x
> 
> nfs-lockd-sync-03.patch
>   nfs: sync lockd to 2.4.x
> 
> nfs-lockd-sync-04.patch
>   nfs: sync lockd to 2.4.x
> 
> nfs-rpc-remove-redundant-memset.patch
>   nfs: remove unnecessary memset() in RPC
> 
> nfs-tunable-rpc-slot-table.patch
>   nfs: make the RPC slot table size a tunable value.
> 
> nfs-short-read-fix.patch
>   nfs: fix an NFSv2 read bug
> 
> nfs-server-in-root_server_path.patch
>   Pull NFS server address out of root_server_path
> 
> non-readable-binaries.patch
>   Handle non-readable binfmt_misc executables
> 
> binfmt_misc-credentials.patch
>   binfmt_misc: improve calaulation of interpreter's credentials
> 
> initramfs-search-for-init.patch
>   search for /init for initramfs boots
> 
> adaptive-lazy-readahead.patch
>   adaptive lazy readahead
> 
> sysfs_remove_dir-race-fix.patch
>   sysfs_remove_dir-vs-dcache_readdir race fix
> 
> sysfs_remove_subdir-dentry-leak-fix.patch
>   Fix dentry refcounting in sysfs_remove_group()
> 
> per-node-rss-tracking.patch
>   Track per-node RSS for NUMA
> 
> aic7xxx-deadlock-fix.patch
>   aic7xxx deadlock fix
> 
> futex_wait-debug.patch
>   futex_wait debug
> 
> module_exit-deadlock-fix.patch
>   module unload deadlock fix
> 
> selinux-inode-race-trap.patch
>   Try to diagnose Bug 2153
> 
> ufs2-01.patch
>   read-only support for UFS2
> 
> ide-scsi-error-handling-fixes.patch
>   ide-scsi error handling fixes
> 
> ide-scsi-error-handling-update.patch
>   ide-scsi error handler update
> 
> fb_console_init-fix.patch
>   fb_console_init fix
> 
> poll-select-longer-timeouts.patch
>   poll()/select(): support longer timeouts
> 
> poll-select-range-check-fix.patch
>   poll()/select() range checking fix
> 
> poll-select-handle-large-timeouts.patch
>   poll()/select(): handle long timeouts
> 
> pcmcia-debugging-rework-1.patch
>   Overhaul PCMCIA debugging (1)
> 
> cs_err-compile-fix.patch
>   pcmcia: workaround for gcc-2.95 bug in cs_err()
> 
> pcmcia-debugging-rework-2.patch
>   Overhaul PCMCIA debugging (2)
> 
> distribute-early-allocations-across-nodes.patch
>   Manfred's patch to distribute boot allocations across nodes
> 
> time-interpolator-fix.patch
>   time interpolator fix
> 
> kmsg-nonblock.patch
>   teach /proc/kmsg about O_NONBLOCK
> 
> mixart-build-fix.patch
>   CONFIG_SND_MIXART doesn't compile
> 
> add-a-slab-for-ethernet.patch
>   Add a kmalloc slab for ethernet packets
> 
> remove-__io_virt_debug.patch
>   remove __io_virt_debug
> 
> genrtc-cleanups.patch
>   genrtc: cleanups
> 
> piix_ide_init-can-be-__init.patch
>   piix_ide_init can be __init
> 
> i386-early-memory-cleanup.patch
>   i386 very early memory detection cleanup patch
> 
> modular-mce-handler.patch
>   Allow X86_MCE_NONFATAL to be a module
> 
> remove-more-KERNEL_SYSCALLS.patch
>   further __KERNEL_SYSCALLS__ removal
>   build fix for remove-more-KERNEL_SYSCALLS.patch
>   fix the build for remove-more-KERNEL_SYSCALLS
> 
> 
> mq-01-codemove.patch
>   posix message queues: code move
> 
> mq-02-syscalls.patch
>   posix message queues: syscall stubs
> 
> mq-03-core.patch
>   posix message queues: implementation
> 
> mq-03-core-update.patch
>   posix message queues: update to core patch
> 
> mq-04-linuxext-poll.patch
>   posix message queues: linux-specific poll extension
> 
> mq-05-linuxext-mount.patch
>   posix message queues: made user mountable
> 
> mq-update-01.patch
>   posix message queue update
> 
> mq-security-fix.patch
>   security bugfix for mqueue
> 
> dm-01-endio-method.patch
>   dm: endio method
> 
> dm-03-list_for_each_entry-audit.patch
>   dm: list_for_each_entry audit
> 
> dm-04-default-queue-limits-fix.patch
>   dm: default queue limits
> 
> dm-05-list-targets-command.patch
>   dm: list targets cmd
> 
> dm-06-stripe-width-fix.patch
>   dm: stripe width fix
> 
> queue-congestion-callout.patch
>   Add queue congestion callout
> 
> queue-congestion-dm-implementation.patch
>   Implement queue congestion callout for device mapper
> 
> dm-maplock.patch
>   devicemapper: use rwlock for map alterations
> 
> dm-map-rwlock-ng.patch
>   Another DM maplock implementation
> 
> dm-remove-__dm_request.patch
>   dmL remove __dm_request
> 
> use-wait_task_inactive-in-kthread_bind.patch
>   use wait_task_inactive() in kthread_bind()
> 
> HPFS1-hpfs2-RC4-rc1.patch
> 
> HPFS2-hpfs_namei-RC4-rc1.patch
> 
> selinux-cleanup-binary-mount-data.patch
>   selinux: clean up binary mount data
> 
> udffs-update.patch
>   UDF filesystem update
> 
> kbuild-redundant-CFLAGS.patch
>   kbuild: Remove CFLAGS assignment in i386/mach-*/Makefile
> 
> numa-aware-zonelist-builder.patch
>   NUMA-aware zonelist builder
>   numa-aware zonelist builder fix
>   numa-aware node builder fix #2
> 
> remove-redundant-unplug_timer-deletion.patch
>   Redundant unplug_timer deletion
> 
> queue_work_on_cpu.patch
>   Add queue_work_on_cpu() workqueue function
> 
> m68k-rename-sys_functions.patch
>   m68k: rename sys_* functions
> 
> pdc202xx_new-update.patch
>   ide: update for pdc202xx_new driver
> 
> siimage-update.patch
>   ide: update for siimage driver
> 
> ide-cleanups-01.patch
>   ide: IDE cleanups
> 
> ide-cleanups-02.patch
>   ide: IDE cleanups
> 
> ide-cleanups-03.patch
>   ide: IDE cleanups
> 
> cdromaudio-use-dma.patch
>   use DMA for CDROM audio reading
> 
> sysfs-pin-kobject.patch
>   sysfs: pin kobjects to fix use-after-free crashes
> 
> ATI-IXP-IDE-support.patch
>   ATI IXP IDE support
> 
> ipmi-updates-3.patch
>   IPMI driver updates
> 
> ipmi-socket-interface.patch
>   IPMI: socket interface
> 
> md-use-schedule_timeout.patch
>   md: use "shedule_timeout(2)" instead of yield()
> 
> md-array-assembly-fix.patch
>   md: allow assembling of partitioned arrays at boot time.
> 
> md-array-assembly-major-fix.patch
>   md array assembly major number fix
> 
> compiler_h-scope-fixes.patch
>   compiler.h scoping fixes
> 
> nmi_watchdog-local-apic-fix.patch
>   Fix nmi_watchdog=2 and P4 HT
> 
> nmi-1-hz.patch
>   set nmi_hz to 1 with nmi_watchdog=2 and SMP
> 
> elf-mmap-fix.patch
>   Fix elf mapping of the zero page
> 
> kbuild-more-cleaning.patch
>   kbuild: Cause `make clean' to remove more files
> 
> LOOP_CHANGE_FD.patch
>   LOOP_CHANGE_FD ioctl
> 
> loop-setup-race-fix.patch
>   loop setup race fix
> 
> handle-dot-o-paths.patch
>   kbuild: fix usage with directories containing '.o'
> 
> acpi-asmlinkage-fix.patch
>   gcc-3.5: acpi build fix
> 
> ipc-sem-extra-sem_unlock.patch
>   Remove unneeded unlock in ipc/sem.c
> 
> procfs-dangling-subdir-fix.patch
>   /proc data corruption check
> 
> AMD-768MPX-bootmem-fix.patch
>   Work around an AMD768MPX erratum
> 
> i810fb-on-x86_64.patch
>   Enable i810 fb on x86-64
> 
> ext23-remove-acl-limits.patch
>   Remove arbitrary #acl entries limits on ext[23] when reading
> 
> watchdog-moduleparam-patches.patch
>   watchdog: moduleparam-patches
> 
> amd-elan-fix.patch
>   AMD ELAN Kconfig fix
> 
> pcmcia-netdev-ordering-fixes.patch
>   PCMCIA netdevice ordering issues
> 
> fadvise-fixups.patch
>   fadvise(POSIX_FADV_DONTNEED) fixups
> 
> validate_mm-fixes.patch
>   Fix and harden validate_mm
> 
> 3ware-update.patch
>   3ware driver update
> 
> 3c59x-xcvr-fix.patch
>   Fix 3c59x transceiver handling
> 
> current_is_keventd-speedup.patch
>   current_is_keventd() speedup
> 
> root-ramdisk-fix.patch
>   Fix rootfs on ramdisk
> 
> cciss-per-device-queues.patch
>   cciss: per device queues
> 
> blkdev-fix-final-page.patch
>   Fix reading the last block on a bdev
> 
> wavfront-needs-syscalls_h.patch
>   wavfront.c needs syscalls.h
> 
> edd-legacy-parameters-fix.patch
>   EDD: Get Legacy Parameters
> 
> cciss-section-fix.patch
>   cciss: init section fix
> 
> pte_chain-nowarns.patch
>   add nowarn to a few pte chain allocators
> 
> macintosh-config-fix.patch
>   Disable Macintosh device drivers for all but PPC || MAC
> 
> applicom-warning-fix.patch
>   Applicom warning
> 
> CONFIG_NVRAM-dependencies.patch
>   Fix CONFIG_NVRAM dependencies
> 
> move-job-control-stuff-tosignal_struct.patch
>   moef job control fields from task_struct to signal_struct
> 
> module_h-attribute_used-fix.patch
>   module.h __attribute_used__ fix
> 
> kobject-module-request-64-bit-fix.patch
>   Fix a 64bit bug in kobject module request
> 
> sch_htb-fix.patch
>   net: fix sch_htb on 64-bit
> 
> instrument-highmem-page-reclaim.patch
>   vm: per-zone vmscan instrumentation
> 
> blk_congestion_wait-return-remaining.patch
>   return remaining jiffies from blk_congestion_wait()
> 
> blk-congestion-races.patch
>   Narrow blk_congestion_wait races
> 
> vmscan-remove-priority.patch
>   mm/vmscan.c: remove unused priority argument.
> 
> kswapd-throttling-fixes.patch
>   kswapd throttling fixes
> 
> vm-refill_inactive-preserve-referenced.patch
>   vmscan: preserve page referenced info in refill_inactive()
> 
> shrink_slab-precision-fix.patch
>   shrink_slab: math precision fix
> 
> try_to_free_pages-shrink_slab-evenness.patch
>   vm: shrink slab evenly in try_to_free_pages()
> 
> vmscan-total_scanned-fix.patch
>   vmscan: fix calculation of number of pages scanned
> 
> shrink_slab-for-all-zones-2.patch
>   vm: scan slab in response to highmem scanning
> 
> zone-balancing-fix-2.patch
>   vmscan: zone balancing fix
> 
> vmscan-control-by-nr_to_scan-only.patch
>   vmscan: drive everything via nr_to_scan
> 
> vmscan-balance-zone-scanning-rates.patch
>   Balance inter-zone scan rates
> 
> vmscan-dont-throttle-if-zero-max_scan.patch
>   vmscan: avoid bogus throttling
> 
> kswapd-avoid-higher-zones.patch
>   kswapd: avoid unnecessary reclaiming from higher zones
> 
> kswapd-avoid-higher-zones-reverse-direction.patch
>   kswapd: fix lumpy page reclaim
> 
> kswapd-avoid-higher-zones-reverse-direction-fix.patch
>   fix the kswapd zone scanning algorithm
> 
> vmscan-throttle-later.patch
>   vmscan: less throttling of page allocators and kswapd
> 
> vm-batch-inactive-scanning.patch
>   vmscan: batch up inactive list scanning work
> 
> vm-batch-inactive-scanning-fix.patch
>   fix vm-batch-inactive-scanning.patch
> 
> vm-balance-refill-rate.patch
>   vm: balance inactive zone refill rates
> 
> vm-lrutopage-cleanup.patch
>   vmscan: add lru_to_page() helper
> 
> slab-no-higher-order.patch
>   slab: avoid higher-order allocations
> 
> O_DIRECT-race-fixes-rollup.patch
>   O_DIRECT data exposure fixes
> 
> O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch
>   Fix race between ll_rw_block() and block_write_full_page()
> 
> blockdev-direct-io-speedup.patch
>   blockdev direct-io speedups
> 
> dio-aio-fixes.patch
>   direct-io AIO fixes
> 
> aio-fallback-bio_count-race-fix-2.patch
>   AIO+DIO bio_count race fix
> 
> aio-direct-io-oops-fix.patch
>   AIO/direct-io oops fix
> 
> radix-tree-tagging.patch
>   radix-tree tags for selective lookup
> 
> irq-safe-pagecache-lock.patch
>   make the pagecache lock irq-safe.
> 
> tag-dirty-pages.patch
>   tag dirty pages as such in the radix tree
> 
> tag-writeback-pages.patch
>   tag writeback pages as such in their radix tree
> 
> stop-using-dirty-pages.patch
>   stop using the address_space dirty_pages list
> 
> stop-using-io-pages.patch
>   remove address_space.io_pages
> 
> stop-using-locked-pages.patch
>   Stop using address_space.locked_pages
> 
> stop-using-clean-pages.patch
>   stop using address_space.clean_pages
> 
> unslabify-pgds-and-pmds.patch
>   revert the slabification of i386 pgd's and pmd's
> 
> slab-stop-using-page-list.patch
>   slab: stop using page.list
> 
> page_alloc-stop-using-page-list.patch
>   stop using page.list in the page allocator
> 
> hugetlb-stop-using-page-list.patch
>   stop using page->list in the hugetlbpage implementations
> 
> pageattr-stop-using-page-list.patch
>   stop using page.list in pageattr.c
> 
> readahead-stop-using-page-list.patch
>   stop using page.list in readahead
> 
> compound-pages-stop-using-lru.patch
>   stop using page->lru in compound pages
> 
> remove-page-list.patch
>   remove page.list
> 
> remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch
>   per-page protections for remap_file_pages()
> 
> remap-file-pages-prot-ia64-2.6.4-rc2-mm1-A0.patch
>   remap_file_pages page-prot implementation for ia64
> 
> list_del-debug.patch
>   list_del debug check
> 
> oops-dump-preceding-code.patch
>   i386 oops output: dump preceding code
> 
> lockmeter.patch
>   lockmeter
> 
> lockmeter-ia64-fix.patch
>   ia64 CONFIG_LOCKMETER fix
> 
> 4g-2.6.0-test2-mm2-A5.patch
>   4G/4G split patch
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g/4g usercopy atomicity fix
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g/4g usercopy atomicity fix
>   4G/4G preempt on vstack
>   4G/4G: even number of kmap types
>   4g4g: fix __get_user in slab
>   4g4g: Remove extra .data.idt section definition
>   4g/4g linker error (overlapping sections)
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g4g: show_registers() fix
>   4g/4g usercopy atomicity fix
>   4g4g: debug flags fix
>   4g4g: Fix wrong asm-offsets entry
>   cyclone time fixmap fix
>   4G/4G preempt on vstack
>   4G/4G: even number of kmap types
>   4g4g: fix __get_user in slab
>   4g4g: Remove extra .data.idt section definition
>   4g/4g linker error (overlapping sections)
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g4g: show_registers() fix
>   4g/4g usercopy atomicity fix
>   4g4g: debug flags fix
>   4g4g: Fix wrong asm-offsets entry
>   cyclone time fixmap fix
>   use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
>   4G/4G might_sleep warning fix
>   4g/4g pagetable accounting fix
>   Fix 4G/4G and WP test lockup
>   4G/4G KERNEL_DS usercopy again
>   Fix 4G/4G X11/vm86 oops
>   Fix 4G/4G athlon triplefault
>   4g4g SEP fix
>   Fix 4G/4G split fix for pre-pentiumII machines
>   4g/4g PAE ACPI low mappings fix
>   zap_low_mappings() cannot be __init
>   4g/4g: remove printk at boot
>   4g4g: fix handle_BUG()
>   4g4g: acpi sleep fixes
> 
> 4g4g-locked-userspace-copy.patch
>   Do a locked user-space copy for 4g/4g
> 
> ia32-4k-stacks.patch
>   ia32: 4Kb stacks (and irqstacks) patch
> 
> ia32-4k-stacks-build-fix.patch
>   4k stacks build fix
> 
> 4k-stacks-in-modversions-magic.patch
>   Add 4k stacks to module version magic
> 
> ppc-fixes.patch
>   make mm4 compile on ppc
> 
> ppc-fixes-dependency-fix.patch
>   ppc-fixes dependency fix
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Regards, Redeeman
redeeman@metanurb.dk

