Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266198AbUFPG7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUFPG7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 02:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUFPG7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 02:59:48 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:44785 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S266202AbUFPG7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 02:59:01 -0400
Message-ID: <40CFEFAD.2060207@ThinRope.net>
Date: Wed, 16 Jun 2004 15:58:53 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, it's out there. The most notable change may be the one-liner that 
> should fix the embarrassing FP exception problem. Other than that, we've 
> had a random collection of fixes and updates since rc3. cifs, ntfs, 
> cpufreq. ide, sparc, s390.
> 
> Full 2.6.6->2.6.7 changelog available at the same places the release is.
> 
> 		Linus
> 
> --
> 
> Summary of changes from v2.6.7-rc3 to v2.6.7
> ============================================
> 
> Alan Cox:
>   o ethtool power manglement hooks
>   o epic100 fixes
> 
> Andi Kleen:
>   o Remove unnecessary printk in es7000 code
>   o Disable UDF debugging
>   o Fix fwait on x86-64 too
>   o More fixes for the x86-64 machine check handler
>   o Fix exception trace printing on x86-64
>   o Fix x86-64 VIA systems with IOMMU debug
> 
> Andreas Dilger:
>   o [IPV4]: Fix bug in arp_tables.c fix
> 
> Andrew Morton:
>   o make buildcheck missing hunk
>   o i386 defconfig update
>   o wake_up_forked_thread() fix
>   o jbd: descriptor buffer state fix
>   o unalign struct page_state
>   o ext3: journal_flush() needs journal_lock_updates()
>   o aio.c sparse warning fix
>   o [NETFILTER]: Fix arp_tables.c build
>   o NUMAQ kconfig fix
>   o vmscan: handle synchronous writepage()
>   o vmscan: try harder for GFP_NOFS allocators
>   o Implement read_page_state
>   o vmscan.c: use read_page_state()
>   o page-writeback.c: use read_page_state()
>   o sync_inodes_sb() stack reduction
>   o es7000plat.c warning fix
>   o fix the exit-vs-timer race fix
>   o ramdisk: buffer_uptodate fix
> 
> Andrew Zabolotny:
>   o [ARM PATCH] 1925/1: ARM 'System Type' kernel config menu cleanup
> 
> Andy Whitcroft:
>   o fix uts sysctl write size
>   o fix modprobe_path and hotplug_path sizes and sysctl
> 
> Anil:
>   o speedup flush_workqueue for singlethread_workqueue
>   o flush_workqueue locking simplification
> 
> Anton Altaparmakov:
>   o NTFS: Implement writing of mft records (fs/ntfs/mft.[hc]), which
>     includes keeping the mft mirror in sync with the mft when mirrored
>     mft records are written.  The functions are
>     write_mft_record{,_nolock}().  The implementation is quite
>     rudimentary for now with lots of things not implemented yet but I
>     am not sure any of them can actually occur so I will wait for
>     people to hit each one and only then implement it.
>   o NTFS: Commit open system inodes at umount time.  This should make
>     it virtually impossible for sync_mft_mirror_umount() to ever be
>     needed.
>   o NTFS: Implement ->write_inode (fs/ntfs/inode.c::ntfs_write_inode())
>     for the ntfs super operations.  This gives us inode writing via the
>     VFS inode dirty code paths.  Note:  Access time updates are not
>     implemented yet.
>   o NTFS: - Implement fs/ntfs/mft.[hc]::{,__}mark_mft_record_dirty()
>     and make fs/ntfs/aops.c::ntfs_writepage() and ntfs_commit_write()
>     use it, thus finally enabling resident file overwrite!  (-8  This
>     also includes a placeholder for ->writepage (ntfs_mft_writepage()),
>     which for now just redirties the page and returns.  Also, at umount
>     time, we for now throw away all mft data page cache pages after the
>     last call to ntfs_commit_inode() in the hope that all inodes will
>     have been written out by then and hence no dirty (meta)data will be
>     lost.  We also check for this case and emit an error message
>     telling the user to run chkdsk.
>   o NTFS: Use set_page_writeback()/end_page_writeback() in
>     ntfs_writepage() resident attribute write code path as otherwise
>     the radix-tree tag PAGECACHE_TAG_DIRTY remains set even though the
>     page is clean.
>   o NTFS: Implement ntfs_mft_writepage() so it now checks if any of the
>     mft records in the page are dirty and if so redirties the page and
>     returns.  Otherwise it just returns (after doing
>     set_page_writeback(), unlock_page(), end_page_writeback() or the
>     radix-tree tag PAGECACHE_TAG_DIRTY  remains set even though the
>     page is clean), thus alowing the VM to do with the page as it
>     pleases.  Also, at umount time, now only throw away dirty mft
>     (meta)data pages if dirty inodes are present and ask the user to
>     email us if they see this happening.
>   o NTFS: Add functions ntfs_{clear,set}_volume_flags(), to modify the
>     volume information flags (fs/ntfs/super.c).
>   o NTFS: 2.1.13 - Enable overwriting of resident files and
>     housekeeping of system files
>   o NTFS: 2.1.14 - Fix an NFSd caused deadlock reported by several
>     users
>   o Update Documentation/filesystems/Locking
> 
> Arnaldo Carvalho de Melo:
>   o [NET] Introduce sk_reset_timer and sk_stop_timer
>   o [NET] generalise tcp_eat_skb into sk_eat_skb
>   o [NET] introduce sk_wait_evend and generalise tcp_data_wait
>   o [NET] generalize some simple tcp sk_ack_backlog handling routines
> 
> Arnd Bergmann:
>   o s390: fix kmem_bufctl_t definition
>   o sparse: user annotations for s390 architecture
>   o sparse: __user annotations for s390 drivers
> 
> Bartlomiej Zolnierkiewicz:
>   o ide: PCI hotplugging fixes
>   o ide: kill some useless headers for PCI drivers
>   o ide: ide-pnp update
>   o ide: remove ALTERNATE_STATE_DIAGRAM_MULTI_OUT from ide-taskfile.c
>   o ide: fix ide-cd to not retry REQ_DRIVE_TASKFILE requests
>   o ide: fix REQ_DRIVE_* requests error handling in ide-scsi
>   o ide: cleanup taskfile PIO handlers (CONFIG_IDE_TASKFILE_IO=n)
>   o ide: tiny task_mulout_intr() (CONFIG_IDE_TASKFILE_IO=n) cleanup
>   o ide: kill task_[un]map_rq()
>   o ide: check no. of sectors for in/out commands in
>     ide_diag_taskfile()
> 
> Ben Collins:
>   o ieee1394: CSR1212 Extended ROM bug fixes
>   o ieee1394: Fix possible NULL ptr dereference with calls to
>     find_ctx()
>   o ieee1394: Handle swsusp better in kernel threads
>   o ohci1394: Handle invalid max-packet-size
>   o ieee1394: Revision sync
>   o ohci1394: Fix incorrect HPSB_WARNING to HPSB_ERR
> 
> Ben Dooks:
>   o [ARM PATCH] 1919/1: S3C2410 - Serial configuration bugfix (missing
>     SERIAL_CORE_CONSOLE)
>   o [ARM PATCH] 1920/1: S3C2410 - register definition fix
> 
> Benjamin Herrenschmidt:
>   o ppc64: Add definition for Apple Xserve G5 motherboard
>   o ppc64: fix out_be64
> 
> Bruno Ducrot:
>   o define for_each_cpu_mask() for uniprocessor
> 
> Carl-Daniel Hailfinger:
>   o Fix tulip deadlocks on device removal
> 
> Chris Mason:
>   o writeback_inodes can race with unmount
> 
> Chris Wedgwood:
>   o stat nlink resolution fix
> 
> Chris Wright:
>   o __user annotation for dummy_shm_shmat
> 
> Christoph Hellwig:
>   o runtime selection of CONFIG_PARIDE_EPATC8
> 
> Clay Haapala:
>   o [CRYPTO]: Fix digest.c kmapping sg entries > page in length
> 
> Cornelia Huck:
>   o s390: common i/o layer
> 
> Dave Airlie:
>   o The dev->devname being passed to request_irq in drm_irq.h is null
>   o gamma_dma_priority and gamma_dma_send_buffers both deref
>     d->send_indices and/or d->send_sizes.  When these functions are
>     called from gamma_dma, these pointers are user pointers and are
>     thus not safe to deref.  This patch copies over the pointers inside
>     gamma_dma_priority and gamma_dma_send_buffers.
> 
> Dave Jones:
>   o [CPUFREQ] Reset longhaul to max speed on unload
>   o [CPUFREQ] Now that maxmult is a global, don't need to pass it
>     around in longhaul driver
>   o [CPUFREQ] Fix longhaul's debug printk
>   o [CPUFREQ] convert elanfreq MODULE_PARM to module_param
>   o [CPUFREQ] convert gx-suspmod MODULE_PARM to module_param
>   o [CPUFREQ] powernow-k8: ignore double lo freq table entries
>   o [CPUFREQ] powernow-k8: preempt fix
>   o [CPUFREQ] Add documentation on AMD powernow drivers From Paul
>     Devriendt.
>   o [CPUFREQ] Limit return value of speedstep_get_state()
>   o [CPUFREQ] Remove notify in speedstep_set_state [1/2] Remove
>     'notify' in speedstep_set_state for speedstep-lib
>   o [CPUFREQ] Remove notify in speedstep_set_state [2/2]
>   o [CPUFREQ] Fix cpufreq on ARM
>   o [CPUFREQ] Detect P4M's in speedstep lib From: Christian Hoelbling
>     Signed-off-by: Dave Jones <davej@redhat.com>
>   o [CPUFREQ] small codingstyle fixes Signed-off-by: Dave Jones
>     <davej@redhat.com>
>   o [CPUFREQ] replace for_each_cpu with for_each_cpu_mask in
>     p4-clockmod
>   o [CPUFREQ] Add missing include to p4-clockmod Signed-off-by: Dave
>     Jones <davej@redhat.com>
>   o [CPUFREQ] AMD powernow documentation updates
>   o [CPUFREQ] speedstep-ich: SMT/HT support, fix for notify change
>     Propagate the notify moving to speedstep-ich, and add SMT (HT)
>     awareness to the speedstep-ich.
> 
> Dave Kleikamp:
>   o JFS: check default acl for correctness before setting it
>   o JFS: fix hang in __get_metapage
>   o JFS: Handle out of space errors more gracefully
>   o JFS: Better RAS when btstack is overrun
> 
> David Howells:
>   o Fix semaphore downgrade_write()
> 
> David S. Miller:
>   o [TG3]: Use HOST TXDs always
>   o [NETFILTER]: Put arpt_mutex back into arp_tables.c
>   o [SPARC64]: Uninline find_*_bit() like ia64 did
>   o [SPARC64]: Update defconfig
>   o [TCP]: Receive buffer moderation fixes
>   o [IPV4]: Fix unaligned accesses in arp_tables.c
>   o [TG3]: Chip support update and a power-save bug fix
>   o [TG3]: Update driver version and reldate
>   o [SPARC64]: Preemption fixes, use get_cpu() et al. where applicable
>   o [SPARC]: Report si_addr in SIGINFO more accurately
> 
> David Woodhouse:
>   o Add PPC 8280 support, calculate core clock frequency
>   o PPC 8260 FCC Ethernet: Fix skb leak when TX ring overflows
>   o Fix handle_sysrq() call in PPC 8260 uart driver
>   o Add support for WindRiver PowerQUICC II
>   o [PPC sbc82xx] Use mfspr macro for reading PVR in boot setup
>   o Wind River PowerQUICC II SBC82xx update
>   o Add WindRiver PowerQUICC II flash map driver
> 
> Davide Libenzi:
>   o spoll_create size check
> 
> Duncan Sands:
>   o USB devio.c: deadlock fix
> 
> François Romieu:
>   o more drivers/atm/horizon.c polishing
> 
> Geert Uytterhoeven:
>   o SCSI_DPT_I2O should depend on PCI
>   o ide: ide-proc fix for m68k
> 
> Guillaume Morin:
>   o s390: improve memory detection logic
> 
> Harald Welte:
>   o [NETFILTER]: Missing skb->len check in
>     ip_conntrack_proto_tcp.c:tcp_packet()
>   o [NETFILTER]: Don't assign new helper after NAT when there are
>     already expectations present
>   o [NETFILTER]: Prevent orphan expectations
> 
> Herbert Xu:
>   o Fix netdev leak on probe failure in 3c527
>   o Fixed MCA resource bugs in at1700
>   o vga16fb.c: fix bogus mem_start value
> 
> Hideaki Yoshifuji:
>   o [IPV6]: Add IP6CB
>   o [NET]: Add dst->ifdown callback
>   o [IPV6] IPSEC: fix double kfree_skb() in error path. (reported by
>     Ken-ichirou MATSUZAWA <chamas@h4.dion.ne.jp>)
> 
> Hugh Dickins:
>   o dup_mmap() memory accounting fix
> 
> Ivan Kokshaysky:
>   o __ARCH_WANT_SYS_RT_SIGACTION fix
> 
> Jens Axboe:
>   o cdrom hardware defect mgt header length
>   o fix ide-cd racy completions
> 
> Jesper Juhl:
>   o [NET]: Remove junk from packet_mmap.txt
> 
> Jesse Brandeburg:
>   o e1000: fix napi crash on ifdown during traffic
> 
> John Rose:
>   o insert_resource fix
> 
> John Stultz:
>   o cyclone: PIT sanity checking
> 
> Jörn Engel:
>   o ncpfs MAINTAINERS update
> 
> Kai Engert:
>   o USB: enable pwc usb camera driver
> 
> Karsten Keil:
>   o i4l: Tigerjet 320 chipset fix
> 
> Keith M. Wesolowski:
>   o [SPARC]: Fix warning for changed section attributes
>   o [SPARC]: Fix warning for missing struct device
>   o [SPARC]: Consolidate pagetable definitions
> 
> Kenneth W. Chen:
>   o ia64: fix race in fsys_bubble_down to avoid fp-register corruption
> 
> Linus Torvalds:
>   o Mark compaq Fibre Channel driver broken
>   o Fix x86 "clear_cpu()" macro
>   o sparse cleanup of #include file
>   o Revert wakeup-affinity fixes
>   o Linux 2.6.7
> 
> Marc Singer:
>   o [ARM PATCH] 1915/1: lh7a40x #4 (1/1) hardware.h bug fix
>   o [ARM PATCH] 1916/1: lh7a40x #5 (1/1) revision B support
> 
> Martin Schwidefsky:
>   o s390: add support for 6 system call arguments (FUTEX_CMP_REQUEUE)
>   o s390: speedup strn{cpy,len}_from_user
>   o s390: simplify single stepped svc code
>   o s390: cleanup string functions
>   o s390: xpram device driver
> 
> Michael Hunold:
>   o Make tda1004x DVB frontend driver work again
> 
> Mika Kukkonen:
>   o sparse fix for void return in selinux/hooks.c
>   o Sparse fix to mm/vmscan.c
>   o __user annotation for shm_shmat hook declaration
>   o __user annotation for selinux_shm_shmat
> 
> Neil Brown:
>   o md: fix BUG in raid6 resync code
> 
> Nick Piggin:
>   o vmscan.c: struct scan_control
>   o Fix nfs writepage behaviour
> 
> Nikita Danilov:
>   o vmscan.c: move ->writepage invocation into its own function
> 
> Nitin A. Kamble:
>   o x86-64: Fix use of uninitialized memory in ioremap
> 
> Olaf Hering:
>   o ppc32: fix missing option in binutils version check
> 
> Oleg Nesterov:
>   o dup_mmap() double memory accounting
> 
> Paul Mackerras:
>   o Single-stepping emulated instructions
>   o Make paca xCurrent field be a pointer
> 
> Peter Korsgaard:
>   o Typo in Documentation/fb/framebuffer.txt
> 
> Randy Dunlap:
>   o kernel/sysctl annotations for sparse
> 
> Russell King:
>   o [ARM] Add ucontext bits for sigaltstack handling
>   o [ARM] Clean up io-acorn
>   o [ARM] uaccess.h should include asm/memory.h not asm/arch/memory.h
>   o [ARM] Update ARM memory layout documentation
>   o [ARM] Tidy up patch 1925/1
>   o [ARM] Resurect EBSA110 machine class
>   o [PCMCIA] Add TI1620 device IDs and tell yenta about it
>   o [SERIAL] Fix missing __devexit_p
> 
> Scott Feldman:
>   o e100: stepping over err return code
>   o e100: fix skb leak in tx timeout
>   o e100: fix sender hang after tx timeout
> 
> Shirley Ma:
>   o [IPV6]: Initialize pmtu/advmss in ndisc dst entries
>   o [IPV6]: Fix ICMP6 type checking tests in ah6.c and esp6.c
> 
> Siegfried Hildebrand:
>   o USB: Fix problems with cyberjack usb-serial-module since kernel
>     2.6.2
> 
> Stefan Bader:
>   o s390: tape driver changes
> 
> Stephen Hemminger:
>   o [TCP]: Update tcp_get_info() comments in net/tcp.h
>   o [TCP]: Add receive DRS info to tcp_info
> 
> Stephen Rothwell:
>   o ppc64: iSeries vio_dev cleanups
> 
> Steve French:
>   o cifs_prepare_write fixes to remove problem in which we were not
>     populating page data from the server copy when writing to
>     non-uptodate page
>   o No matter what the blocksize, we are required to use fake blocksize
>     of 512 when calculating number of blocks in a file (otherwise this
>     confuses the du command)
>   o Remove temporary debug message
>   o Update cifs change log for cifs 1.17
>   o Handle out of memory on allocating dentry or inode during filldir
>   o Initial protocol definitions for cifs dirnotify (directory change
>     notification) support
>   o whitespace and comment cleanup
>   o Fix race in updating tcpStatus field
>   o Add 2 missing kmalloc failure checks during cifs mount time
>   o fix up whitespace
>   o Make stats display more consistent - under /proc/fs/cifs/Stats
>   o handle partial page update of page in cache that is not uptodate
>     better for the situation in which file is open writeonly
>   o Fix sparse tool compile warnings for cifs
>   o flush write behind cached data, for files reopened after session
>     reconnection after session drop
>   o Handle rename of hardlinked files properly (treat as a noop)
>   o Add missing EA info levels
>   o Extended Attributes part 1
>   o remove compile warning
>   o lock session when reconnecting so we do not oops in retrying
>     sendmsg
>   o do not filemap_fdatawrite when reconnecting in write to avoid
>     potential deadlock
>   o fix listxattr error path
>   o fix fealist struct (xattr support part 3)
>   o Fix i_size corruption in case of overlapped readdir changing cached
>     file size and local cached write extending file
> 
> Thomas Spatzier:
>   o s390: qeth network driver
> 
> Tony Lindgren:
>   o [ARM PATCH] 1923/1: OMAP update 1/2: arch files (replaces patch
>     1903/1)
>   o [ARM PATCH] 1922/1: OMAP update 2/2: include files (replaces patch
>     1904/1)
>   o [ARM PATCH] 1908/1: Remove old OMAP header files
>   o [ARM PATCH] 1905/1: Add OMAP compressed boot debug serial output
> 
> Venkatesh Pallipadi:
>   o [CPUFREQ] Cpufreq hotplug
> 
> William Lee Irwin III:
>   o numaq mempolicy.c build fix
>   o Voyager doesn't support MCE
>   o voyager linkage fix
> 
> Wim Van Sebroeck:
>   o [WATCHDOG] v2.6.6 pcwd.c-keepalive+single_open-patch
>   o [WATCHDOG] pcwd_pci.c-single_open+set_heartbeat+init-patch
>   o [WATCHDOG] pcwd_usb.c-single_open+set_heartbeat+init-patch
> 

Well, I guess now everybody (and their CPU) is busy compiling :-)

I posted this for 2.6.6, but got a single reply, reposting again.
( See http://bugzilla.kernel.org/show_bug.cgi?id=2669 )

When I unpack linux sources (`tar xjvf linux-${KV}.tar.bz2`), I usually do that in /usr/src/ and do it as root the first time.
Later (if I need to patch something, etc.) I cat copy this dir as a non-root user.
I always use KBUILD_OUTPUT=/var/tmp/kernel-output/$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) to build as non-root user.

The problem is that several files are NOT world readable and this prevents non-root builds by using KBUILD_OUTPUT.
And reading some Documentation as normal user (like Documentation/scsi/ChangeLog.megaraid) !!!

For 2.6.7:

# find /usr/src/linux-2.6.7 ! -perm -004 -exec ls -l {} \;
-rw-r-----  1 500 500 9511 Jun 16 14:19 /usr/src/linux-2.6.7/drivers/char/drm/drm_irq.h
-rw-r-----  1 500 500 13235 Jun 16 14:20 /usr/src/linux-2.6.7/drivers/char/agp/isoch.c
-rw-r-----  1 500 500 17056 Jun 16 14:20 /usr/src/linux-2.6.7/drivers/input/joystick/grip_mp.c
-rw-r-----  1 500 500 3106 Jun 16 14:19 /usr/src/linux-2.6.7/Documentation/networking/netif-msg.txt
-rw-r-----  1 500 500 1593 Jun 16 14:20 /usr/src/linux-2.6.7/Documentation/scsi/ChangeLog.megaraid

To fix your tree you can (safely?) use:

find /usr/src/linux-2.6.7 ! -perm -004 -exec chmod o+r {} \;

or for future:

find /usr/src/linux-2.6.7 -type f ! -perm -004 -exec chmod o+r {} \;
find /usr/src/linux-2.6.7 -type d ! -perm -005 -exec chmod o+rx {} \;

No idea how exactly the tarball is build, but there can be a check proces like the above before making it final.

There is clearly no reason why 5 out of 15655 (16629 with directories) are with such "weird" permissions.
Is this such a pain to fix?

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
|||\/<" 
|||\\ ' 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
