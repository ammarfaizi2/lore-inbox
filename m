Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUHWCUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUHWCUn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 22:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266492AbUHWCUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 22:20:43 -0400
Received: from mail.aei.ca ([206.123.6.14]:43716 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S266459AbUHWCSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 22:18:23 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4 - failed opcode was: 0xe7
Date: Sun, 22 Aug 2004 22:18:05 -0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>
References: <20040822013402.5917b991.akpm@osdl.org>
In-Reply-To: <20040822013402.5917b991.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408222218.05780.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have been away on vacation.  When I updated my kernel to 8.1-mm4 ide reports:

Aug 22 22:01:06 bert kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 22 22:01:06 bert kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 22 22:01:06 bert kernel: PIIX4: IDE controller at PCI slot 0000:00:14.1
Aug 22 22:01:06 bert kernel: PIIX4: chipset revision 1
Aug 22 22:01:06 bert kernel: PIIX4: not 100%% native mode: will probe irqs later
Aug 22 22:01:06 bert kernel:     ide0: BM-DMA at 0x10e0-0x10e7, BIOS settings: hda:DMA, hdb:DMA
Aug 22 22:01:06 bert kernel:     ide1: BM-DMA at 0x10e8-0x10ef, BIOS settings: hdc:DMA, hdd:pio
Aug 22 22:01:06 bert kernel: Probing IDE interface ide0...
Aug 22 22:01:06 bert kernel: hda: WDC AC26400R, ATA DISK drive
Aug 22 22:01:06 bert kernel: hdb: Maxtor 6E030L0, ATA DISK drive
Aug 22 22:01:06 bert kernel: Using anticipatory io scheduler
Aug 22 22:01:06 bert kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 22 22:01:06 bert kernel: Probing IDE interface ide1...
Aug 22 22:01:06 bert kernel: hdc: HL-DT-ST RW/DVD GCC-4480B, ATAPI CD/DVD-ROM drive
Aug 22 22:01:06 bert kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 22 22:01:06 bert kernel: pnp: the driver 'ide' has been registered
Aug 22 22:01:06 bert kernel: Probing IDE interface ide2...
Aug 22 22:01:06 bert kernel: ide2: Wait for ready failed before probe !
Aug 22 22:01:06 bert kernel: Probing IDE interface ide3...
Aug 22 22:01:06 bert kernel: ide3: Wait for ready failed before probe !
Aug 22 22:01:06 bert kernel: Probing IDE interface ide4...
Aug 22 22:01:06 bert kernel: ide4: Wait for ready failed before probe !
Aug 22 22:01:06 bert kernel: Probing IDE interface ide5...
Aug 22 22:01:06 bert kernel: ide5: Wait for ready failed before probe !
Aug 22 22:01:06 bert kernel: hda: max request size: 128KiB
Aug 22 22:01:06 bert kernel: hda: 12594960 sectors (6448 MB) w/512KiB Cache, CHS=13328/15/63, UDMA(33)
Aug 22 22:01:06 bert kernel: hda: cache flushes supported
Aug 22 22:01:06 bert kernel:  hda: hda1 hda2 hda3
Aug 22 22:01:06 bert kernel: hdb: max request size: 128KiB
Aug 22 22:01:06 bert kernel: hdb: 60058656 sectors (30750 MB) w/2048KiB Cache, CHS=59582/16/63, UDMA(33)
Aug 22 22:01:06 bert kernel: hdb: cache flushes supported
Aug 22 22:01:06 bert kernel:  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 >

and later I get several:

Aug 22 22:02:49 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Aug 22 22:02:49 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
Aug 22 22:02:49 bert kernel: ide: failed opcode was: 0xe7

Looks like some one has been playing in the ide code and has broken cache flush detection.  hda
does _not_ support flushes...

My previous kernel is 2.6.8-rc2-mm2, which reports:

Aug 22 22:05:05 bert kernel: hda: max request size: 128KiB
Aug 22 22:05:05 bert kernel: hda: 12594960 sectors (6448 MB) w/512KiB Cache, CHS=13328/15/63, UDMA(33)
Aug 22 22:05:05 bert kernel: hda: cache flushes not supported
Aug 22 22:05:05 bert kernel:  hda: hda1 hda2 hda3

ideas?

Ed Tomlinson








On Sunday 22 August 2004 04:34, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm4/
> 
> - Added the kexec code.  Again.  This was in -mm a year or so ago but didn't
>   make it.
> 
> - This kernel has an x86 patch which alters the copy_*_user() functions so
>   they will return -EFAULT on a fault rather than the number of bytes which
>   remain to be copied.  This is a bit of an experiment, because this seems to
>   be the preferred API for those functions.   It's a see-what-breaks thing.
> 
>   And things will break.  If weird behaviour is observed, please revert
>   usercopy-return-EFAULT.patch and send a report.
> 
> 
> 
> Changes since 2.6.8.1-mm3:
> 
> 
>  linus.patch
>  bk-acpi.patch
>  bk-agpgart.patch
>  bk-alsa.patch
>  bk-arm.patch
>  bk-cifs.patch
>  bk-dma-declare-coherent-memory.patch
>  bk-cpufreq.patch
>  bk-driver-core.patch
>  bk-drm.patch
>  bk-fb.patch
>  bk-ia64.patch
>  bk-ieee1394.patch
>  bk-input.patch
>  bk-jfs.patch
>  bk-kbuild.patch
>  bk-libata.patch
>  bk-mmc.patch
>  bk-netdev.patch
>  bk-ntfs.patch
>  bk-pci.patch
>  bk-pcmcia.patch
>  bk-pnp.patch
>  bk-power.patch
>  bk-scsi.patch
>  bk-usb.patch
>  bk-watchdog.patch
> 
>  External trees
> 
> -add-ssleep-kill-scsi_sleep.patch
> 
>  Merged
> 
> +context-switching-overhead-in-x-ioport.patch
> 
>  Fix x86 TSS switching CPU consumption problem
> 
> +add_pin_to_irq-section-fix.patch
> 
>  Fix __init section in x86 apic code
> 
> +use-global-system_state-to-avoid-system-state-confusion.patch
> 
>  power management work
> 
> +alsa-build-fix.patch
> 
>  Fix ALSA build
> 
> +ppc32-fix-warnings-on-ebony-mtd-build.patch
> 
>  Warning fix
> 
> +ppc64-extend-ioremap-iounmap-infrastructure.patch
> +ppc64-use-correct-buffer-size-in-rtas-call.patch
> +ppc64-mf_proc-file-position-fix.patch
> +hvcs-fixes-suggested-by-jeff-garzik-on-july-29th.patch
> 
>  ppc64 stuff
> 
> +fix-visws-kernel-build.patch
> 
>  SGI visual workstation build fix
> 
> +sched-domain-node-span-4-fix2.patch
> 
>  sched-domains fix
> 
> +sched-smt-fixes.patch
> +sched-smt-fixes-fix.patch
> 
>  CPu scheduler SMT fixes
> 
> +make-uml-build-and-run.patch
> 
>  UML foxes
> 
> +fbdev-do-the-deletion-of-mode-entries-at-fbdev-level.patch
> +fbdev-support-for-bold-attribute-for-monochrome-framebuffers.patch
> +fbdev-use-8-bit-dac-for-capable-hardware.patch
> +rivafb-directcolor-mode-and-miscellaneous-fixes.patch
> +epson1355fb-salvage-epson1355-code-from-james-tree.patch
> +neofb-salvage-neofb-from-james-tree.patch
> +neofb-build-fix.patch
> +sgivwfb-salvage-sgivwfb-from-james-tree.patch
> +tdfxfb-salvage-tdfxfb-from-james-tree.patch
> 
>  Frame buffer updates
> 
> +hotplug-cpu-fix-apic-queued-timer-vector-race.patch
> 
>  Fix i386-hotplug-cpu.patch
> 
> +key-management-patch-cleanup.patch
> 
>  Clean up in-kernel key management code
> 
> +remove-notify_parent.patch
> 
>  Clode cleanup
> 
> +kexec-i8259-shutdowni386.patch
> +kexec-i8259-sysfsx86_64.patch
> +kexec-x86_64-i8259-fixes.patch
> +kexec-apic-virtwire-on-shutdowni386patch.patch
> +kexec-apic-virtwire-on-shutdownx86_64.patch
> +kexec-ioapic-virtwire-on-shutdowni386.patch
> +kexec-ioapic-virtwire-on-shutdownx86_64.patch
> +kexec-e820-64bit.patch
> +kexec-kexec-generic.patch
> +kexec-machine_shutdownx86_64.patch
> +kexec-kexecx86_64.patch
> +kexec-machine_shutdowni386.patch
> +kexec-kexeci386.patch
> +kexec-use_mm.patch
> +kexec-kexecppc.patch
> 
>  kexec
> 
> +reiser4-4kstacks-fix.patch
> 
>  Disallow reiser4 if 4k stacks are selected
> 
> +reiser4-doc-update.patch
> 
>  Fix reiser4 documentation
> 
> +copy_mount_options-size-fix.patch
> 
>  Fix some problems with copy_mount_options() and arch-specific
>  copy_from_user() limitations.
> 
> +fix-bad-url-in-bsd-acct-help-entry.patch
> 
>  Documentation fix
> 
> +dothan-speedstep-fix.patch
> 
>  cpufreq fix
> 
> +shows-active-inactive-on-per-node-meminfo.patch
> +shows-active-inactive-on-per-node-meminfo-speedup.patch
> 
>  Display per-node page LRU stats on NUMA
> 
> +minix-nblocks-retval-fix.patch
> 
>  minixfs fix
> 
> +usercopy-return-EFAULT.patch
> 
>  Change the x86 copy_*_user() return values.
> 
> +intel8x0-latency-fix.patch
> 
>  scheduling latency fix
> 
> +inode-time-update-funnies-in-ncpfs.patch
> 
>  ncpfs fixes/cleanups
> 
> +improve-oprofile-on-many-way-systems.patch
> +fix-oprofile-events-with-zero-event-values.patch
> +oprofile-ia64-performance-counter-support.patch
> 
>  oprofile udpates
> 
> +pci-driver-function-documentation-fix.patch
> +vlan-missing-kconfig-help.patch
> +remove-obsolete-htab-reclaim-in-documentation-sysctl-kerneltxt.patch
> +remove-obsolete-zero-paged-in-documentation-sysctl-kerneltxt.patch
> 
>  Documentation fixes
> 
> +legousbtower-module_param-fix.patch
> 
>  USB warning fix
> 
> +fix-pid-hash-sizing.patch
> +use-hlist-for-pid-hash.patch
> +use-hlist-for-pid-hash-cache-friendliness.patch
> 
>  Fidddle with the PID hashing tables
> 
> 
> number of patches in -mm: 720
> number of changesets in external trees: 995
> number of patches in -mm only: 694
> total patches: 1689
> 
> 
> 
> All patches:
> 
> 
> linus.patch
> 
> context-switching-overhead-in-x-ioport.patch
>   context-switching overhead in X, ioport()
> 
> add_pin_to_irq-section-fix.patch
>   tg3 section fix
> 
> procfs-taskname-locking.patch
>   proc fs task name locking fix
> 
> fix-reading-string-module-parameters-in-sysfs.patch
>   fix reading string module parameters in sysfs
> 
> sysfs-backing-store-prepare-file_operations.patch
>   sysfs backing store - prepare sysfs_file_operations helpers
> 
> sysfs-backing-store-prepare-file_operations-fix.patch
>   fix oops with firmware loading
> 
> sysfs-backing-store-add-sysfs_dirent.patch
>   sysfs backing store - add sysfs_direct structure
> 
> sysfs-backing-store-use-sysfs_dirent-tree-in-removal.patch
>   sysfs backing store: use sysfs_dirent based tree in file removal
> 
> sysfs-backing-store-use-sysfs_dirent-tree-in-dir-file_operations.patch
>   sysfs backing store: use sysfs_dirent based tree in dir file operations
> 
> sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves.patch
>   sysfs backing store: stop pinning dentries/inodes for leaf entries
> 
> bk-acpi.patch
> 
> bk-agpgart.patch
> 
> bk-alsa.patch
> 
> bk-arm.patch
> 
> bk-cifs.patch
> 
> bk-dma-declare-coherent-memory.patch
> 
> bk-cpufreq.patch
> 
> bk-driver-core.patch
> 
> bk-drm.patch
> 
> bk-fb.patch
> 
> bk-ia64.patch
> 
> bk-ieee1394.patch
> 
> bk-input.patch
> 
> bk-jfs.patch
> 
> bk-kbuild.patch
> 
> bk-libata.patch
> 
> bk-mmc.patch
> 
> bk-netdev.patch
> 
> bk-ntfs.patch
> 
> bk-pci.patch
> 
> bk-pcmcia.patch
> 
> bk-pnp.patch
> 
> bk-power.patch
> 
> bk-scsi.patch
> 
> bk-usb.patch
> 
> bk-watchdog.patch
> 
> mm.patch
>   add -mmN to EXTRAVERSION
> 
> mm-swsusp-make-sure-we-do-not-return-to-userspace-where-image-is-on-disk.patch
>   -mm swsusp: make sure we do not return to userspace where image is on disk
> 
> mm-swsusp-copy_page-is-harmfull.patch
>   -mm swsusp: copy_page is harmfull
> 
> swsusp-fix-highmem.patch
>   swsusp: fix highmem
> 
> swsusp-do-not-disable-platform-swsusp-because-s4bios-is-available.patch
>   swsusp: do not disable platform swsusp because S4bios is available
> 
> swsusp-fix-default-powerdown-mode.patch
>   swsusp: fix default powerdown mode
> 
> mark-old-power-managment-as-deprecated-and-clean-it-up.patch
>   Mark old power managment as deprecated and clean it up
> 
> use-global-system_state-to-avoid-system-state-confusion.patch
>   Use global system_state to avoid system-state confusion
> 
> sound-control-build-fix.patch
>   sound/core/control.c build fix
> 
> i2c-keywestc-build-fix.patch
>   i2c-keywest.c build fix
> 
> ipr-build-fix.patch
>   ipr.c build fix
> 
> megaraid-build-fix.patch
>   [un]register_ioctl32_conversion() stubs
> 
> alsa-build-fix.patch
>   alsa build fix
> 
> nmi-trigger-switch-support-for-debuggingupdated.patch
>   NMI trigger switch support for debugging(updated)
>   nmi-trigger-switch-support-for-debuggingupdated-fix
>   nmi-build-fix
>   more NMI build fixes
> 
> make-i386-die-more-resilient-against-recursive-errors.patch
>   Make i386 die() more resilient against recursive errors
> 
> i386_exception_notifiers.patch
>   i386 exceptions notifier for kprobes
> 
> kprobes-base.patch
>   kprobes base patch
> 
> kprobes-unset-fix.patch
>   kprobes: fix things when CONFIG_KPROBES is unset
> 
> kprobes-func-args.patch
>   Jumper Probes to provide function arguments
> 
> kprobes-build-fix.patch
>   kprobes build fix
> 
> network-packet-tracer-module-using-kprobes-interface.patch
>   Network packet tracer module using kprobes interface.
> 
> kgdb-ga.patch
>   kgdb stub for ia32 (George Anzinger's one)
>   kgdbL warning fix
>   kgdb buffer overflow fix
>   kgdbL warning fix
>   kgdb: CONFIG_DEBUG_INFO fix
>   x86_64 fixes
>   correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
>   kgdb: fix for recent gcc
>   kgdb warning fixes
>   THREAD_SIZE fixes for kgdb
>   Fix stack overflow test for non-8k stacks
>   kgdb-ga.patch fix for i386 single-step into sysenter
>   fix TRAP_BAD_SYSCALL_EXITS on i386
>   add TRAP_BAD_SYSCALL_EXITS config for i386
> 
> kgdb-is-incompatible-with-kprobes.patch
>   kgdb-is-incompatible-with-kprobes
> 
> kgdboe-netpoll.patch
>   kgdb-over-ethernet via netpoll
>   kgdboe: fix configuration of MAC address
> 
> kgdb-x86_64-support.patch
>   kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
>   kgdb-x86_64-warning-fixes
> 
> kgdb-ia64-support.patch
>   IA64 kgdb support
>   ia64 kgdb repair and cleanup
>   ia64 kgdb fix
> 
> kgdb-ia64-fixes.patch
>   kgdb: ia64 fixes
> 
> make-tree_lock-an-rwlock.patch
>   make mapping->tree_lock an rwlock
> 
> must-fix.patch
>   must fix lists update
>   must fix list update
>   mustfix update
>   must-fix update
>   mustfix lists
> 
> ppc32-remove-hardcoded-offsets-from-ppc-asm.patch
>   ppc32: remove hardcoded offsets from ppc asm
> 
> ppc32-optimize-fix-timer_interrupt-loop.patch
>   ppc32: optimize/fix timer_interrupt loop
> 
> ppc32-make-ppc40x-large-tlb-mapping-optional.patch
>   ppc32: make PPC40x large tlb mapping optional
> 
> ppc32-handle-misaligned-string-multiple-insns.patch
>   ppc32: handle misaligned string/multiple insns
> 
> ppc32-emulate-obsolete-instructions.patch
>   ppc32: emulate obsolete instructions
> 
> ppc32-emulate-obsolete-instructions-fix.patch
>   ppc32-emulate-obsolete-instructions fix
> 
> ppc32-add-docs-for-ppc-noltlbs-and-nobats-parameters.patch
>   ppc32: add docs for noltlbs and nobats parameters
> 
> ppc32-export-__dma_sync-__dma_sync_page.patch
>   ppc32: export __dma_sync & __dma_sync_page
> 
> ppc32-fix-bug-in-altivec-emulation.patch
>   ppc32: Fix bug in altivec emulation
> 
> ppc32-fix-booting-on-some-oldwolrd-macs.patch
>   ppc32: Fix booting on some OldWolrd Macs
> 
> ppc32-fix-warnings-on-ebony-mtd-build.patch
>   ppc32: fix warnings on Ebony MTD build
> 
> ppc64-reduce-stack-overflow-warning-threshold.patch
>   ppc64: reduce stack overflow warning threshold
> 
> ppc64-remove-old-asm-offsets.patch
>   ppc64: remove old asm offsets
> 
> ppc64-set-time-related-systemcfg-fields.patch
>   ppc64: set time-related systemcfg fields
> 
> ppc64-include-profilec-in-kernel-irqc.patch
>   ppc64: include profile.c in kernel/irq.c
> 
> ppc64-1-4-use-platform-numbering-of-cpus-for-hypervisor-calls.patch
>   ppc64: use platform numbering of cpus for hypervisor calls.
> 
> ppc64-2-4-use-cpu_present_map-in-ppc64.patch
>   ppc64: use cpu_present_map in ppc64
> 
> ppc64-3-4-rework-secondary-smt-thread-setup-at-boot.patch
>   ppc64: rework secondary SMT thread setup at boot
> 
> ppc64-4-4-remove-unnecessary-cpu-maps.patch
>   ppc64: remove unnecessary cpu maps
> 
> ppc64-power4-oprofile-update.patch
>   ppc64: POWER4 oprofile update
> 
> ppc64-disable-oprofile-debug-messages.patch
>   ppc64: disable oprofile debug messages
> 
> ppc64-allow-oprofile-module-to-be-safely-unloaded.patch
>   ppc64: allow oprofile module to be safely unloaded
> 
> ppc64-add-missing-export_symbols-for-oprofile.patch
>   ppc64: add missing EXPORT_SYMBOLS for oprofile
> 
> ppc64-fix-oprofile-error-messages.patch
>   ppc64: Fix oprofile error messages
> 
> ppc64-set-tbl-it_type-in-iommu-code.patch
>   ppc64: set tbl->it_type in iommu code
> 
> ppc64-dont-call-scheduler-on-offline-cpu.patch
>   ppc64: Don't call scheduler on offline cpu
> 
> ppc64-fix-idle-loop-for-offline-cpu.patch
>   ppc64: fix idle loop for offline cpu
> 
> ppc64-c99-initializers-in-init_thread.patch
>   ppc64: C99 initializers in INIT_THREAD
> 
> ppc64-log-firmware-errors-during-boot.patch
>   ppc64: log firmware errors during boot
> 
> ppc64-fix-unbalanced-pci_dev_put-in-eeh-code.patch
>   ppc64 Fix unbalanced pci_dev_put in EEH code
> 
> ppc64-reduce-verbosity-of-rtas-error-logs.patch
>   ppc64: Reduce verbosity of RTAS error logs
> 
> ppc64-fix-v_regs-pointer-setup.patch
>   ppc64: Fix v_regs pointer setup
> 
> ppc64-hvsi-driver.patch
>   ppc64: HVSI driver
> 
> ppc64-bolted-slb-entry-for-iseries.patch
>   ppc64: bolted SLB entry for iSeries
> 
> ppc64-switch-screen_info-init-to-c99.patch
>   ppc64: switch screen_info init to C99
> 
> ppc64-cpu-death-sched-timeout.patch
>   ppc64: tweak schedule_timeout in __cpu_die
> 
> ppc64-memcpy_toio-function-signature.patch
>   ppc64: fix eeh_memcpy_toio() prototype
> 
> ppc64-rtas_call-was-calling-kmalloc-too-early.patch
>   ppc64: rtas_call was calling kmalloc too early
> 
> ppc64-better-little-endian-bitops.patch
>   ppc64: better little-endian bitops
> 
> ppc64-iseries-virtual-dvd-ram.patch
>   ppc64 iSeries virtual DVD-RAM
> 
> ppc64-extend-ioremap-iounmap-infrastructure.patch
>   ppc64: Extend ioremap/iounmap infrastructure
> 
> ppc64-use-correct-buffer-size-in-rtas-call.patch
>   ppc64: Use correct buffer size in RTAS call
> 
> ppc64-mf_proc-file-position-fix.patch
>   ppc64: mf_proc file position fix
> 
> hvcs-fixes-suggested-by-jeff-garzik-on-july-29th.patch
>   HVCS fixes
> 
> ibmveth-module-tag-fixes.patch
>   ibmveth: module tag fixes
> 
> ibmveth-race-fix.patch
>   ibmveth: race fixes
> 
> ibmveth-hypervisor-retval-fix.patch
>   ibmveth: hypervisor return value fix
> 
> ibmveth-hypervisor-memory-barrier.patch
>   ibmveth: add memory barrier for hypervisor synchronisation
> 
> ppc64-reloc_hide.patch
> 
> invalidate_inodes-speedup.patch
>   invalidate_inodes speedup
>   more invalidate_inodes speedup fixes
> 
> dev-mem-restriction-patch.patch
>   /dev/mem restriction patch
> 
> get_user_pages-handle-VM_IO.patch
>   fix get_user_pages() against mappings of /dev/mem
> 
> pid_max-fix.patch
>   Bug when setting pid_max > 32k
> 
> fix-visws-kernel-build.patch
>   fix visws kernel build
> 
> jbd-remove-livelock-avoidance.patch
>   JBD: remove livelock avoidance code in journal_dirty_data()
> 
> journal_add_journal_head-debug.patch
>   journal_add_journal_head-debug
> 
> list_del-debug.patch
>   list_del debug check
> 
> oops-dump-preceding-code.patch
>   i386 oops output: dump preceding code
> 
> lockmeter.patch
>   lockmeter
>   ia64 CONFIG_LOCKMETER fix
> 
> lockmeter-build-fix.patch
>   lockmeter-build-fix
> 
> unplug-can-sleep.patch
>   unplug functions can sleep
> 
> firestream-warnings.patch
>   firestream warnings
> 
> ext3_rsv_cleanup.patch
>   ext3 block reservation patch set -- ext3 preallocation cleanup
> 
> ext3_rsv_base.patch
>   ext3 block reservation patch set -- ext3 block reservation
>   ext3 reservations: fix performance regression
>   ext3 block reservation patch set -- mount and ioctl feature
>   ext3 block reservation patch set -- dynamically increase reservation window
>   ext3 reservation ifdef cleanup patch
>   ext3 reservation max window size check patch
>   ext3 reservation file ioctl fix
> 
> ext3-reservation-default-on.patch
>   ext3 reservation: default to on
> 
> ext3-lazy-discard-reservation-window-patch.patch
>   ext3 lazy discard reservation window patch
>   ext3 discard reservation in last iput fix patch
>   Fix lazy reservation discard
>   ext3 reservations: bad_inode fix
>   ext3 reservation discard race fix
> 
> really-ptrace-single-step-2.patch
>   ptrace single-stepping fix
> 
> ipr-ppc64-depends.patch
>   Make ipr.c require ppc
> 
> disk-barrier-core.patch
>   disk barriers: core
>   disk-barrier-core-tweaks
> 
> disk-barrier-ide.patch
>   disk barriers: IDE
>   disk-barrier-ide-symbol-expoprt
>   disk-barrier ide warning fix
>   barrier update
>   barrier flushing fix
>   final ide barrier bug!
>   ide: print failed opcode on IO errors
>   From: Jens Axboe <axboe@suse.de>
>   Subject: Re: ide errors in 7-rc1-mm1 and later
> 
> disk-barrier-scsi.patch
>   disk barriers: scsi
> 
> disk-barrier-dm.patch
>   disk barriers: devicemapper
> 
> disk-barrier-md.patch
>   disk barriers: MD
>   barriers: md fix
>   md: fix multipath for readhead requests
> 
> sync_dirty_buffer-retval.patch
>   make sync_dirty_buffer() return something useful
> 
> add-bh_eopnotsupp-for-testing.patch
>   add BH_Eopnotsupp for testing async barrier failures
> 
> reiserfs-v3-barrier-support.patch
>   reiserfs v3 barrier support
>   reiserfs-v3-barrier-support-tweak
> 
> ext3-barrier-support.patch
>   ext3 barrier support
>   jbd: barrier fallback on failure
>   Handle async barrier failures
> 
> blk_queue_free_tags-fix.patch
>   blk_queue_free_tags() fix
> 
> blk_resize_tags-fix.patch
>   blk_resize_tags() fix
> 
> blk_queue_tags_resize_failure.patch
>   handle blk_queue_tags_resize() allocation failures
> 
> multipath-readahead-fix-fix.patch
>   multipath readahead fix fix
> 
> tty_io-hangup-locking.patch
>   tty_io.c hangup locking
> 
> perfctr-core.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
>   CONFIG_PERFCTR=n build fix
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc
> 
> perfctr-i386.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386
>   perfctr #if/#ifdef cleanup
>   perfctr Dothan support
>   perfctr x86_tests build fix
>   perfctr x86 init bug
>   perfctr: K8 fix for internal benchmarking code
>   perfctr x86 update
> 
> perfctr-x86_64.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64
> 
> perfctr-ppc.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC
>   perfctr ppc32 update
>   perfctr update 4/6: PPC32 cleanups
>   perfctr ppc32 buglet fix
> 
> perfctr-virtualised-counters.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters
>   perfctr update 6/6: misc minor cleanups
>   perfctr update 3/6: __user annotations
>   perfctr-cpus_complement-fix
>   perfctr cpumask cleanup
>   perfctr SMP hang fix
> 
> perfctr-ifdef-cleanup.patch
>   perfctr ifdef cleanup
> 
> perfctr-update-2-6-kconfig-related-updates.patch
>   perfctr update 2/6: Kconfig-related updates
> 
> perfctr-update-5-6-reduce-stack-usage.patch
>   perfctr update 5/6: reduce stack usage
> 
> perfctr-low-level-documentation.patch
>   perfctr low-level documentation
>   perfctr documentation update
> 
> perfctr-inheritance-1-3-driver-updates.patch
>   perfctr inheritance 1/3: driver updates
>   perfctr inheritance illegal sleep bug
> 
> perfctr-inheritance-2-3-kernel-updates.patch
>   perfctr inheritance 2/3: kernel updates
> 
> perfctr-inheritance-3-3-documentation-updates.patch
>   perfctr inheritance 3/3: documentation updates
> 
> perfctr-inheritance-locking-fix.patch
>   perfctr inheritance locking fix
> 
> ext3-online-resize-patch.patch
>   ext3: online resizing
>   ext3-online-resize-warning-fix
> 
> sched-timeslice-fix.patch
>   sched: fix timeslice calculations for HZ=1000.
> 
> sched-clean-init-idle.patch
>   sched: cleanup init_idle()
> 
> sched-clean-fork.patch
>   sched: cleanup, improve sched <=> fork APIs
>   sched: rename wake_up_new_process -> wake_up_new_task
> 
> kernelthread-idle-fix-2.patch
>   kernel thread idle fix
> 
> sched-misc-cleanups-2.patch
>   sched: misc cleanups #2
> 
> sched-unlikely-rt_task.patch
>   sched: make rt_task unlikely
> 
> sched-misc.patch
>   sched: sched misc changes
>   sched: fix RT scheduling & interactivity estimator
> 
> sched-no-balance-clone.patch
>   sched: disable balance on clone
> 
> sched-remove-balance-clone.patch
>   sched: remove balance on clone
> 
> sched-fork-hotplug-cleanuppatch.patch
>   sched: fork hotplug hanling cleanup
> 
> sched-consolidate-sched-domains.patch
>   sched: consolidate sched domains
>   sched-consolidate-sched-domains ppc64 fix
>   sched: fix for sched-consolidate-domains
>   another sched consolidate domains fix
> 
> sched-domain-node-span-4.patch
>   sched: limit cpuspan of node scheduler domains
>   sched: merge fix
>   sched-domain-node-span-4-warning-fix
> 
> sched-domain-node-span-4-update.patch
>   sched-domain-node-span-4 update
> 
> sched-domain-node-span-4-update-warning-fix.patch
>   sched-domain-node-span-4-update-warning-fix
> 
> sched-domain-node-span-4-fix2.patch
>   sched-domain-node-span-4 fix
> 
> sched-isolated-sched-domains.patch
>   sched: isolated sched domains
>   sched-isolated-sched-domains-fix
> 
> create-cpu_sibling_map-for-ppc64.patch
>   Create cpu_sibling_map for PPC64
>   create-cpu_sibling_map-for-ppc64-fix
> 
> sched-adjust-p4-per-cpu-gain.patch
>   sched: adjust p4 per-cpu gain
> 
> schedstat-v10.patch
>   scheduler statistics
> 
> move-config_schedstats-to-arch-ppc64-kconfigdebug.patch
>   move CONFIG_SCHEDSTATS to arch/ppc64/Kconfig.debug
> 
> sched-init_idle-fork_by_hand-consolidation.patch
>   sched: consolidate init_idle() and fork_by_hand()
> 
> sched-sparc32-fix.patch
>   sched: sparc32 fixes
>   sun4d fork_idle() fix
> 
> schedstat-up-fix.patch
>   schedstat: UP fix
>   
>   SMP fix --
>   for_each_domain() is not defined if not CONFIG_SMP, so show_schedstat
>   needed a couple of extra ifdefs.
>   
>   Signed-off-by: Rick Lindsley <ricklind@us.ibm.com>
>   Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> sched-whitespace-cleanups.patch
>   sched: whitespace cleanups
> 
> sched-nonlinear-timeslicespatch.patch
>   sched: nonlinear timeslices
> 
> sched-new-task-fix.patch
>   sched: new task fix
> 
> release_task-may-sleep.patch
>   permit sleeping in release_task()
> 
> sched-self-reap-fix.patch
>   sched: self-reaping atomicity fix
> 
> sched-smt-fixes.patch
>   sched: smt fixes
> 
> sched-smt-fixes-fix.patch
>   sched-smt-fixes fix
> 
> nicksched.patch
>   nicksched
> 
> memory-backed-inodes-fix.patch
>   memory-backed inodes fix
> 
> ext3_bread-cleanup.patch
>   ext3_bread() cleanup
> 
> flexible-mmap-2.6.7-mm3-A8.patch
>   i386 virtual memory layout rework
>   flexible-mmap BUG fix
>   flexible-mmap update
> 
> flexmmap-patchkit-fix-for-32-bit-emu-for-64-bit-arches.patch
>   flexmmap patchkit: fix for 32 bit emu for 64 bit arches
> 
> sysctl-tunable-for-flexmmap.patch
>   sysctl tunable for flexmmap
>   legacy_va_layout docs
>   legacy_va_layout-docs-fix
>   legacy_va_layout compile error with SYSCTL=n
> 
> flex-mmap-for-s390x.patch
>   flex mmap for s390(x)
> 
> flex-mmap-for-ppc64.patch
>   flexible-mmap for ppc64
> 
> pcmcia-implement-driver-model-support.patch
>   pcmcia: implement driver model support
> 
> pcmcia-update-network-drivers.patch
>   pcmcia: update network drivers
> 
> pcmcia-update-wireless-drivers.patch
>   pcmcia: update wireless drivers
> 
> pcmcia-fix-eject-lockup.patch
>   pcmcia: fix eject lockup
> 
> pcmcia-add-hotplug-support.patch
>   pcmcia: add *hotplug support
> 
> posix-locking-posix_same_owner-fixes.patch
>   posix locking: posix_same_owner() fixes
> 
> posix-locking-hook-functions.patch
>   posix locking: add hook functions
> 
> posix-locking-nfsv4-server.patch
>   posix locking: nfsv4 server updates
> 
> posix-locking-lockd-fixes.patch
>   posix locking: NLM: fix lockd to use the new posix locking callbacks
> 
> posix-locking-lifetime-fixes.patch
>   posix locking: ->fl_owner lifetime fixes
> 
> posix-locking-move-file-lock-fields.patch
>   posix locking: move file_lock fields
> 
> posix-locking-filesystems-call-posix_lock_file.patch
>   posix locking: make filesystems call posix_lock_file()
> 
> dvdrw-support-for-267-bk13.patch
>   DVD+RW support for 2.6.7-bk13
> 
> cdrw-packet-writing-support-for-267-bk13.patch
>   CDRW packet writing support
>   packet: remove #warning
>   packet writing: door unlocking fix
>   pkt_lock_door() warning fix
>   Fix race in pktcdvd kernel thread handling
>   Fix open/close races in pktcdvd
>   packet writing: review fixups
>   Remove pkt_dev from struct pktcdvd_device
>   packet writing: convert to seq_file
> 
> dvd-rw-packet-writing-update.patch
>   Packet writing support for DVD-RW and DVD+RW discs.
>   Get blockdev size right in pktcdvd after switching discs
> 
> packet-writing-docco.patch
>   packet writing documentation
>   Trivial CDRW packet writing doc update
> 
> control-pktcdvd-with-an-auxiliary-character-device.patch
>   Control pktcdvd with an auxiliary character device
>   Subject: Re: 2.6.8-rc2-mm2
>   control-pktcdvd-with-an-auxiliary-character-device-fix
> 
> simplified-request-size-handling-in-cdrw-packet-writing.patch
>   Simplified request size handling in CDRW packet writing
> 
> fix-setting-of-maximum-read-speed-in-cdrw-packet-writing.patch
>   Fix setting of maximum read speed in CDRW packet writing
> 
> packet-writing-reporting-fix.patch
>   Packet writing reporting fixes
> 
> speed-up-the-cdrw-packet-writing-driver.patch
>   Speed up the cdrw packet writing driver
> 
> packet-writing-avoid-bio-hackery.patch
>   packet writing: avoid BIO hackery
> 
> cdrom-buffer-size-fix.patch
>   cdrom: buffer sizing fix
> 
> r8169_napi-help-text-2.patch
>   R8169_NAPI help text
> 
> no-sysgood-for-ptrace-singlestep.patch
>   Don't use SYSGOOD for ptrace singlestep
> 
> err2-6-hashbin_remove_this-locking-fix.patch
>   err2-6: hashbin_remove_this() locking fix
> 
> dm-use-idr.patch
>   devicemapper: use an IDR tree for tracking minors
> 
> ipc-1-3-add-refcount-to-ipc_rcu_alloc.patch
>   ipc: Add refcount to ipc_rcu_alloc
> 
> ipc-2-3-remove-sem_revalidate.patch
>   ipc: remove sem_revalidate
> 
> ipc-3-3-enforce-semvmx-limit-for-undo.patch
>   ipc: enforce SEMVMX limit for undo
> 
> cleanup-of-ipc-msgc.patch
>   cleanup of ipc/msg.c
> 
> sk98lin-procfs-fix.patch
>   sk98lin procfs fix
> 
> cpufreq-driver-for-nforce2-kernel-267.patch
>   cpufreq driver for nForce2
> 
> allow-modular-ide-pnp.patch
>   allow modular ide-pnp
> 
> uml-base-patch.patch
>   uml: Uml base patch
> 
> uml-remove-cow-driver.patch
>   UML: remove the COW block driver
> 
> uml-updates-2.patch
>   UML updates
> 
> uml-sched-update.patch
>   uml: CPU scheduler update
> 
> rename-uml-console-device.patch
>   uml: rename console_device
> 
> uml-readds-just-for-now-ghashh-for-uml.patch
>   uml: Readds (just for now) ghash.h for UML
> 
> uml-avoid-that-gcc-breaks-uml-with-unit-at-a-time-compilation-mode.patch
>   uml: Avoid that gcc breaks UML with "unit at a time" compilation mode.
> 
> uml-fixes-an-host-fd-leak-caused-by-hostfs.patch
>   uml: Fixes an host fd leak caused by hostfs.
> 
> uml-adds-legacy_pty-config-option.patch
>   uml: Adds LEGACY_PTY config option
> 
> uml-makes-make-help-arch=um-work.patch
>   uml: Makes "make help ARCH=um" work.
> 
> uml-fixes-fixdepc-to-support-arch-um-include-uml-configh.patch
>   uml: Fixes "fixdep.c" to support arch/um/include/uml-config.h.
> 
> uml-kill-useless-warnings.patch
>   uml: Kill useless warnings
> 
> uml-avoids-compile-failure-when-host-misses-tkill.patch
>   uml: Avoids compile failure when host misses tkill().
> 
> uml-reduces-code-in-_user-files-by-moving-it-in-_kern-files-if-already-possible.patch
>   uml: Reduces code in *_user files, by moving it in _kern files if already possible.
> 
> uml-fixes-raw-and-uses-it-in-check_one_sigio-also-fixes-a-silly-panic-eintr-returned-by-call.patch
>   uml: Fixes raw() and uses it in check_one_sigio; also fixes a silly panic (EINTR returned by call).
> 
> uml-folds-hostaudio_userc-into-hostaudio_kernc.patch
>   uml: Folds hostaudio_user.c into hostaudio_kern.c.
> 
> uml-use-ptrace_scemu-the-so-called-sysemu-to-reduce-syscall-cost.patch
>   uml: Use PTRACE_SCEMU (the so-called SYSEMU) to reduce syscall cost.
> 
> uml-adds-the-nosysemu-command-line-parameter-to-disable-sysemu.patch
>   uml: Adds the "nosysemu" command line parameter to disable SYSEMU
> 
> uml-adds-proc-sysemu-to-toggle-sysemu-usage.patch
>   uml: Adds /proc/sysemu to toggle SYSEMU usage.
> 
> uml-fix-for-sysemu-patches.patch
>   uml: Fix for sysemu patches
> 
> uml-handles-correctly-errno-==-eintr-in-lots-of-places.patch
>   uml: Handles correctly errno == EINTR in lots of places.
> 
> uml-adds-some-exports.patch
>   uml: Adds some exports
> 
> uml-avoids-a-panic-for-a-legal-situation.patch
>   uml: Avoids a panic for a legal situation
> 
> uml-removes-dead-code-in-trap_kernc.patch
>   uml: Removes dead code in trap_kern.c
> 
> uml-make-malloc-call-vmalloc-if-needed-needed-for-hostfs-on-26-host.patch
>   uml: Make malloc() call vmalloc if needed. Needed for hostfs on 2.6 host.
> 
> uml-little-kmalloc.patch
>   uml: little-kmalloc
> 
> uml-fix-os_process_pc-and-os_process_parent-for-corner-cases.patch
>   uml: Fix os_process_pc and os_process_parent for corner cases.
> 
> uml-remove-a-group-of-unused-bh-functions.patch
>   uml: remove a group of unused bh functions
> 
> uml-updates.patch
>   UML updates
> 
> uml-fixes.patch
>   UML fixes
> 
> make-uml-build-and-run.patch
>   Make UML build and run
> 
> fix-warnings-in-net-irda.patch
>   sparse: fix warnings in net/irda/*
> 
> i810_audio-fix-the-error-path-of-resource-management.patch
>   i810_audio: Fix the error path of resource management
> 
> fix-drivers-isdn-hisax-avm_pcic-build-warning-when.patch
>   Fix drivers/isdn/hisax/avm_pci.c build warning when !CONFIG_ISAPNP
> 
> idr-stale-comment.patch
>   idr.c: remove stale comment
>   idr comments updates
> 
> schedule-profiling.patch
>   schedule() profiling
>   From: Arjan van de Ven <arjanv@redhat.com>
>   Subject: Re: schedule profileing
> 
> add-a-few-might_sleep-checks.patch
>   Add a few might_sleep() checks
>   add-a-few-might_sleep-checks fix
>   even more might_sleep() checks
> 
> tmpfs-atomicity-fix.patch
>   tmpfs atomicity fix
> 
> crc16-renaming-in-via-velocity-ethernet-driver.patch
>   CRC16 renaming in VIA Velocity ethernet driver
> 
> per_cpu-per_cpu-cpu_gdt_table.patch
>   percpu: cpu_gdt_table
> 
> per_cpu-per_cpu-cpu_gdt_table-fix.patch
>   per_cpu-per_cpu-cpu_gdt_table-fix
> 
> per_cpu-per_cpu-init_tss.patch
>   percpu: init_tss
> 
> per_cpu-per_cpu-cpu_tlbstate.patch
>   percpu: cpu_tlbstate
> 
> gcc35-alps_tdlb7.c.patch
>   gcc-3.5 fixes
> 
> gcc35-always-inline.patch
>   gcc-3.5 fixes
> 
> gcc35-auerswald.c.patch
>   gcc-3.5 fixes
> 
> gcc35-dabusb.c.patch
>   gcc-3.5 fixes
> 
> gcc35-ds.c.patch
>   gcc-3.5 fixes
> 
> gcc35-fixmap.h.patch
>   gcc-3.5: fixmap.h fix
> 
> gcc35-mtrr.h.patch
>   gcc-3.5 fixes
> 
> gcc35-sonypi.patch
>   gcc-3.5 fixes
> 
> gcc35-sp887x.c.patch
>   gcc-3.5 fixes
> 
> gcc35-tda1004x.c.patch
>   gcc-3.5 fixes
> 
> gcc35-transport.h.patch
>   gcc-3.5 fixes
> 
> gcc35-ufs_fs.h.patch
>   gcc-3.5 fixes
> 
> gcc35-videodev.c.patch
>   gcc-3.5 fixes
> 
> gcc35-wavefront_fx.c.patch
>   gcc-3.5 fixes
> 
> dev-zero-vs-hugetlb-mappings.patch
>   /dev/zero vs hugetlb mappings.
> 
> hugetlbfs-private-mappings.patch
>   hugetlbfs private mappings
> 
> net-kconfig-crc16-fix.patch
>   net/Kconfig crc16 warning fix
> 
> preset-loops_per_jiffy-for-faster-booting.patch
>   preset loops_per_jiffy for faster booting
> 
> define-inline-as-__attribute__always_inline-also-for-gcc-=-34.patch
>   #define inline as __attribute__((always_inline)) also for gcc >= 3.4
> 
> gcc-34-and-broken-inlining.patch
>   clean up __always_inline__ usage
> 
> split-generic_file_aio_write-into-buffered-and-direct-i-o-parts.patch
>   split generic_file_aio_write into buffered and direct I/O parts
> 
> making-i-dhash_entries-cmdline-work-as-it-use-to.patch
>   Make i/dhash_entries cmdline work as it use to.
> 
> making-i-dhash_entries-cmdline-work-as-it-use-to-fix.patch
>   making-i-dhash_entries-cmdline-work-as-it-use-to-fix
> 
> jbd-recovery-latency-fix.patch
>   jbd recovery latency fix
> 
> truncate_inode_pages-latency-fix.patch
>   truncate_inode_pages-latency-fix
> 
> journal_clean_checkpoint_list-latency-fix.patch
>   journal_clean_checkpoint_list latency fix
> 
> journal_clean_checkpoint_list-latency-fix-fix.patch
>   journal_clean_checkpoint_list-latency-fix-fix
> 
> kjournald-smp-latency-fix.patch
>   kjournald-smp-latency-fix
> 
> unmap_vmas-smp-latency-fix.patch
>   unmap_vmas-smp-latency-fix
> 
> __cleanup_transaction-latency-fix.patch
>   __cleanup_transaction-latency-fix
> 
> prune_dcache-latency-fix.patch
>   prune_dcache-latency-fix
> 
> filemap_sync-latency-fix.patch
>   filemap_sync-latency-fix
> 
> slab-latency-fix.patch
>   slab-latency-fix
> 
> get_user_pages-latency-fix.patch
>   get_user_pages-latency-fix
> 
> send_IPI_mask_bitmask-build-fix.patch
>   send_IPI_mask_bitmask() build fix
> 
> e1000-build-fix.patch
>   e1000 build fix
> 
> e1000-inlining-fix.patch
>   e1000 inlining fix
> 
> pty_write-latency-fix.patch
>   pty_write-latency-fix
> 
> enable-all-events-for-initramfs.patch
>   Enable all events for initramfs
> 
> arch-i386-kernel-smpc-gcc341-inlining-fix.patch
>   arch/i386/kernel/smp.c gcc341 inlining fix
> 
> 268-rc2-mm2-warning-on-numa-q.patch
>   warning on NUMA-Q
> 
> was-removal-of-sync-in-panic.patch
>   remove sync() from panic
> 
> move-cache_reap-out-of-timer-context.patch
>   Move cache_reap out of timer context
>   move-cache_reap-out-of-timer-context-fix
> 
> gettimeofday-nanoseconds-patch-makes-it-possible-for-the-posix-timer.patch
>   gettimeofday nanoseconds patch
> 
> x86-64-singlestep-through-sigreturn-system-call-2.patch
>   Fix x86-64 singlestep through sigreturn system call
> 
> create-nodemask_t.patch
>   Create nodemask_t
>   nodemask fix
>   nodemask build fix
> 
> add-ixdp2x01-board-support-to-cs89x0-driver.patch
>   Add IXDP2x01 board support to CS89x0 driver
> 
> remove-dead-prototypes.patch
>   remove dead prototypes
> 
> s390-use-include-asm-generic-dma-mapping-brokenh.patch
>   s390: Use include/asm-generic/dma-mapping-broken.h
> 
> cdrom-get_last_written-fix.patch
>   Subject: cdrom.c get_last_written fixup
> 
> get_random_bytes-returns-the-same-on-every-boot.patch
>   get_random_bytes() returns the same on every boot
> 
> locking-optimization-for-cache_reap.patch
>   slab: locking optimization for cache_reap
> 
> b44-add-47xx-support.patch
>   b44: add 47xx support
> 
> signal-race-fix.patch
>   signal handling race fix
> 
> signal-race-fix-ia64.patch
>   signal-race-fix: ia64
> 
> signal-race-fix-s390.patch
>   signal-race fixes for s390
>   s390 signal handling fixes
> 
> signal-race-fix-x86_64.patch
>   signal-race-fixes: x86-64 support
>   x86_64 signal handling fix
> 
> ppc-signal-handling-fixes.patch
>   ppc signal handling fixes
> 
> signal-race-fixes-sparc-sparc64.patch
>   signal handling race fixes: sparc and sparc64
> 
> signal-race-fixes-ppc64.patch
>   pPC64 signal race fix patch
> 
> signal-race-fix-alpha.patch
>   alpha signal race fixes
> 
> allow-x86_64-to-reenable-interrupts-on-contention.patch
>   Allow x86_64 to reenable interrupts on contention
> 
> move-pit-code-to-timer_pit.patch
>   x86: move PIT code to timer_pit
>   move-pit-code-to-timer_pit-warning-fix
> 
> i2o-build_111.patch
>   i20 rewrite
>   i2o-build_99-gcc295-fixes
>   i2o: resync with post-2.6.6 changes
>   i2o: more resyncing with post-2.6.6 changes
>   i2o devfs fix
> 
> i2o-build_111-build-fix.patch
>   i2o-build_111-build-fix
> 
> i2o-add-functionality-to-scsi_add_device-to-preset-hostdata.patch
>   I2O: add functionality to scsi_add_device to preset hostdata
> 
> i2o-remove-on-demand-allocation-of-scsi_hosts-in-i2o_scsi.patch
>   I2O: remove on-demand allocation of Scsi_Host's in i2o_scsi
> 
> i2o-run-linux-i2oh-and-linux-i2o-devh-through-lindent.patch
>   I2O: run linux/i2o.h and linux/i2o-dev.h through Lindent
> 
> i2o-fixes-compiler-warning-on-x86_64-in-i2o_config.patch
>   I2O: fixes compiler warning on x86_64 in i2o_config
> 
> i2o-removes-multiplexer-notification-and-use-type-safe.patch
>   I2O: removes multiplexer notification and use type-safe  functions
> 
> i2o-maintainer.patch
>   i2o maintainer
> 
> apic-output-reduction.patch
>   IO-APIC debug message reduction
> 
> fix-ide-probe-double-detection.patch
>   Fix ide probe double detection
> 
> fix-smm-failures-on-e750x-systems.patch
>   fix SMM failures on E750x systems
> 
> serial-cs-and-unusable-port-size-ranges.patch
>   serial-cs and unusable port size ranges
> 
> make-shrinker_sem-an-rwsem.patch
>   make shrinker_sem an rwsem
> 
> vlan-support-for-3c59x-3c90x.patch
>   VLAN support for 3c59x/3c90x
> 
> break-out-zone-free-list-initialization.patch
>   break out zone free list initialization
> 
> radeonfb-cleanup-and-little-fixes.patch
>   radeonfb: cleanup and little fixes
> 
> rivafb-i2c-fixes.patch
>   Rivafb I2C fixes
> 
> fbmon-edd-blacklist.patch
>   fbcom: EDD-based blacklisting
> 
> fbcon-differentiate-bits_per_pixel-from-color-depth.patch
>   fbcon: ifferentiate bits_per_pixel from color depth
>   fbcon-differentiate-bits_per_pixel-from-color-depth-fixup
>   fbcon-differentiate-bits_per_pixel-from-color-depth-export
> 
> fbdev-set-color-fields-correctly.patch
>   fbdev: set color fields correctly
> 
> fbdev-attn-maintainers-set-correct-hardware-capabilities.patch
>   fbdev: ATTN: Maintainers - Set correct hardware capabilities
> 
> rivafb-do-not-tap-vga-ports-if-not-x86.patch
>   rivafb: Do not tap VGA ports if not X86
> 
> i810fb-fixes.patch
>   i810fb fixes
>   i810fb fixes #2
> 
> fbdev-find-correct-logo-for-directcolor-24bpp.patch
>   fbdev: find correct logo for directcolor < 24bpp
> 
> rivafb-kill-riva_chip_info-and-riva_chips.patch
>   rivafb: kill riva_chip_info and riva_chips
> 
> include-compilerh-in-videodevh.patch
>   include "compiler.h" in videodev.h
> 
> fbdev-kconfig-dependency-fix.patch
>   fbdev Kconfig dependency fixes
> 
> video-mode-handling-linked-list-of-video-modes.patch
>   Video Mode Handling - Linked list of video modes
>   video-mode-handling-linked-list-of-video-modes-build-fix
> 
> video-mode-handling-save-per-display-graphics-display-settings.patch
>   Video Mode Handling - Save per-display graphics/display settings
> 
> video-mode-handling-delete-entries-from-mode-list.patch
>   Video Mode Handling - Delete entries from mode list
> 
> video-mode-handling-reduce-memory-footprint-of-fbdev.patch
>   Video Mode Handling - Reduce memory footprint of fbdev
> 
> fbdev-do-the-deletion-of-mode-entries-at-fbdev-level.patch
>   fbdev: do the deletion of mode entries at fbdev level
> 
> fbdev-support-for-bold-attribute-for-monochrome-framebuffers.patch
>   fbdev: support for bold attribute for monochrome framebuffers
> 
> fbdev-use-8-bit-dac-for-capable-hardware.patch
>   fbdev: use 8-bit DAC for capable hardware
> 
> rivafb-directcolor-mode-and-miscellaneous-fixes.patch
>   rivafb: directcolor mode and miscellaneous fixes
> 
> epson1355fb-salvage-epson1355-code-from-james-tree.patch
>   epson1355fb: salvage epson1355 code from James' tree
> 
> neofb-salvage-neofb-from-james-tree.patch
>   neofb: salvage neofb from James' tree
> 
> neofb-build-fix.patch
>   neofb-build-fix
> 
> sgivwfb-salvage-sgivwfb-from-james-tree.patch
>   sgivwfb: salvage sgivwfb from James' tree
> 
> tdfxfb-salvage-tdfxfb-from-james-tree.patch
>   tdfxfb: salvage tdfxfb from James' tree
> 
> net-smc9194c-fix-inline-compile-errors-fwd.patch
>   net/smc9194.c: fix gcc-3.5 inline compile errors
> 
> net-hamachic-remove-bogus-inline-at-function-prototype.patch
>   net/hamachi.c: gcc-3.5 build fixes
> 
> scsi-qla2xxx-fix-inline-compile-errors.patch
>   qla2xxx gcc-3.5 fixes
> 
> net-rrunnerc-fix-inline-compile-error.patch
>   net/rrunner.c: gcc-3.5 fixes
> 
> istallion-remove-inlines.patch
>   istallion: gcc-3.5 fixes
> 
> mxserc-fix-inlines-fwd.patch
>   mxser.c: gcc-3.5 fixes
> 
> radio-maestroc-remove-an-inline-fwd.patch
>   radio-maestro.c: gcc-3.5 fixes
> 
> net-tulip-dmfec-fix-inline-compile-errors-fwd.patch
>   net/tulip/dmfe.c: gcc-3.5 fixes
> 
> fix-inlining-errors-in-drivers-scsi-aic7xxx-aic79xx_osmc.patch
>   inlining errors in drivers/scsi/aic7xxx/aic79xx_osm.c
> 
> fix-inline-related-gcc-34-build-failures-in.patch
>   fix inline related gcc 3.4 build failures in drivers/net/wan/dscc4.c
> 
> igxb_main-gcc-34-build-fix.patch
>   ixgb_main.c: fix inline compile errors
> 
> ext2_readdir-filp-f_pos-fix.patch
>   ext2_readdir() filp->f_pos fix
> 
> do_general_protection-doesnt-disable-irq.patch
>   do_general_protection doesn't disable irq
> 
> proc_pid_cmdline-race-fix.patch
>   proc_pid_cmdline() race fix
> 
> support-for-exar-xr17c158-octal-uart.patch
>   Support for Exar XR17C158 Octal UART
> 
> x86_64-merge-2.patch
>   New x86-64 merge
> 
> x86_64-merge-2-build-fix.patch
>   x86_64-merge-2 build fix
> 
> fix-o=-compilation-on-x86-64.patch
>   Fix O= compilation on x86-64
> 
> altix-system-controller-communication-driver.patch
>   Altix system controller communication driver
> 
> snsc-build-fix.patch
>   snsc-build-fix
> 
> more-altix-system-controller-changes.patch
>   More Altix system controller changes
> 
> altix-system-controller-fixes.patch
>   Altix system controller fixes
> 
> move-duplicate-bug-and-warn_on-bits-to-asm-generic.patch
>   move duplicate BUG and WARN_ON bits to asm-generic
> 
> move-duplicate-bug-and-warn_on-bits-to-asm-generic-fix.patch
>   Fix missing backslash in asm-generic/bug.h
> 
> fix-con_buf_size-usage.patch
>   Fix CON_BUF_SIZE usage
> 
> vprintk-support.patch
>   vprintk support
> 
> vprintk-for-ext2-errors.patch
>   vprintk for ext2 errors
> 
> vprintk-for-ext3-errors.patch
>   vprintk for ext3 errors
> 
> prio_tree-kill-vma_prio_tree_init.patch
>   prio_tree: kill vma_prio_tree_init()
> 
> prio_tree-iterator-vma_prio_tree_next-cleanup.patch
>   prio_tree: iterator + vma_prio_tree_next cleanup
> 
> rcu-cpu-offline-cleanup.patch
>   RCU - cpu-offline-cleanup
> 
> rcu-rcu-cpu-offline-fix.patch
>   RCU - cpu offline fix
> 
> rcu-low-latency-rcu.patch
>   RCU: low latency rcu
> 
> rcu-clean-up-code.patch
>   rcu: clean up code
> 
> rcu-fix-spaces-in-rcupdateh.patch
>   rcu: fix spaces in rcupdate.h
> 
> rcu-introduce-call_rcu_bh.patch
>   rcu: introduce call_rcu_bh()
> 
> rcu-use-call_rcu_bh-in-route-cache.patch
>   rcu: use call_rcu_bh() in route cache
> 
> rcu-document-rcu-api.patch
>   rcu: document RCU api
> 
> rcu-abstracted-rcu-dereferencing.patch
>   rcu: abstracted RCU dereferencing
> 
> alpha-print-the-symbol-of-pc-and-ra-during-oops.patch
>   alpha: print the symbol of pc and ra during Oops
> 
> first-next_cpu-returns-values-nr_cpus.patch
>   first/next_cpu returns values > NR_CPUS
>   first-next_cpu-returns-values-nr_cpus fix
> 
> add-support-for-it8212-ide-controllers.patch
>   Add support for IT8212 IDE controllers
> 
> drivers-net-wan-cycx_x25c189-warning-conflicting-types.patch
>   drivers/net/wan/cycx_x25.c:189: warning: conflicting types for built-in function 'log2'
> 
> watchdog-fix-warning-defined-but-not-used.patch
>   watchdog: fix warning "defined but not used"
> 
> i386-hotplug-cpu.patch
>   i386 Hotplug CPU
> 
> hotplug-cpu-fix-apic-queued-timer-vector-race.patch
>   Hotplug cpu: Fix APIC queued timer vector race
> 
> token-based-thrashing-control.patch
>   token based thrashing control
>   token-based-thrashing-control-remove-debug
>   laod control: fix the build with CONFIG_SWAP=n
> 
> writeback-page-range-hint.patch
>   Writeback page range hint
> 
> fix-writeback-page-range-to-use-exact-limits.patch
>   Fix writeback page range to use exact limits
> 
> mpage-writepages-range-limit-fix.patch
>   mpage writepages range limit fix
> 
> filemap_fdatawrite-range-interface.patch
>   filemap_fdatawrite range interface
> 
> concurrent-o_sync-write-support.patch
>   Concurrent O_SYNC write support
> 
> nfsd-force-server-side-tcp-when-nfsv4-enabled.patch
>   nfsd: force server-side TCP when NFSv4 enabled
> 
> nfsd-nfsd-is-missing-a-put_group_info-in-the-auth_null.patch
>   nfsd: nfsd is missing a put_group_info in the auth_null
> 
> nfsd-make-cache_init-initialize-reference-count-to-1.patch
>   nfsd: make cache_init initialize reference count to 1
> 
> nfsd-simplify-auth_domain_lookup.patch
>   nfsd: simplify auth_domain_lookup
> 
> nfsd-fix-ip_map-cache-reference-count-leak.patch
>   nfsd: fix ip_map cache reference count leak.
> 
> nfsd-basic-v4-acl-definitions.patch
>   nfsd: basic v4 ACL definitions
> 
> nfsd-posix-nfsv4-acl-translation-for-nfsd.patch
>   nfsd: POSIX<->NFSv4 acl translation for nfsd
> 
> nfsd-acl-support-for-the-nfsv4-server.patch
>   nfsd: ACL support for the NFSv4 server
> 
> knfsd-fix-brokenness-with-fsid=-export-option.patch
>   kNFSd: fix brokenness with fsid= export option
> 
> knfsd-get-rid-of-open_private_file.patch
>   kNFSd: get rid of open_private_file
> 
> knfsd-minor-memory-leak-fix.patch
>   From: NeilBrown <neilb@cse.unsw.edu.au>
>   Subject: [PATCH kNFSd 2 of 4] Minor memory leak fix.
> 
> knfsd-fix-two-xdr-encode-bugs-for-readdirplus-reply.patch
>   kNFSd: fix two xdr-encode bugs for readdirplus reply
> 
> knfsd-fix-race-with-flushing-nfsd-cache.patch
>   kNFSd: fix race with flushing nfsd cache.
> 
> knfsd-server-permissions-fix.patch
>   knfsd: fix server permission handling
> 
> cdrom-event-notification-fixes.patch
>   cdrom event notification fixes
> 
> new-device-driver-to-enable-the-ibm-multiport-serial-adapter.patch
>   new device driver to enable the IBM Multiport Serial Adapter
> 
> iteraid.patch
>   ITE RAID driver
>   iteraid cleanup
>   iteraid warning fix
>   iteraid: pci_enable_device() for IRQ routing
> 
> kill-udf-registration-unregistration-messages.patch
>   kill UDF registration/unregistration messages
> 
> sparc-remove-undefined-symbol.patch
>   sparc: remove undefined symbol
> 
> nbd-fix-struct-request-race-condition.patch
>   nbd: fix struct request race condition
> 
> profile-consolidate-prof_cpu_mask.patch
>   profiling: consolidate prof_cpu_mask
> 
> profile-introduce-profile_pc.patch
>   profiling: introduce profile_pc()
> 
> profile-consolidate-hit-count-increments-in-profile_tick.patch
>   profiling: consolidate hit count increments in profile_tick()
> 
> profile-move-profile_operations.patch
>   profiling: move profile_operations
> 
> profile-make-private-profile-state-static.patch
>   profiling: make private profile state static
> 
> profile-make-prof_buffer-atomic_t.patch
>   profiling: make prof_buffer atomic_t
> 
> remove-iseries-profiling.patch
>   ppc64: remove iseries profiling
> 
> ipmi-watchdog-patch.patch
>   IPMI Watchdog handling updates
> 
> ipmi-driver-updates.patch
>   IPMI driver updates
> 
> ipmi-driver-updates-build-fix.patch
>   ipmi-driver-updates build fix
> 
> dio-bio-sizing-fix.patch
>   direct-io: size the BIOs more accurately
> 
> dio-pages-in-io-accounting-fix.patch
>   DIO pages-in-io accounting fix
> 
> is_err-is-unlikely.patch
>   mark IS_ERR as unlikely()
> 
> is_err-unlikeliness-cleanup.patch
>   IS_ERR() unlikeliness cleanup
> 
> igxb-speedup.patch
>   igxb-speedup
> 
> fix-netpoll-cleanup-on-abort-without-dev.patch
>   Fix netpoll cleanup on abort without dev
> 
> aioc-rename-struct-timeout-to-struct-aio_timeout.patch
>   aio.c: rename 'struct timeout' to 'struct aio_timeout'
> 
> fix-compiling-oldconfig-with-gcc-35.patch
>   fix compiling oldconfig with gcc-3.5
> 
> dont-pass-mem_map-into-init-functions.patch
>   don't pass mem_map into init functions
>   don't pass mem_map into init functions: ia64 fix
>   don't pass mem_map into init functions: other architectures
>   dont-pass-mem_map-into-init-functions-ia64-fix-2
>   dont-pass-mem_map-into-init-functions x86_64 fix
>   dont-pass-mem_map-into-init-functions x86 fix
>   dont-pass-mem_map-into-init-functions more fixes
> 
> might-sleep-in-atomic-while-dumping-elf.patch
>   fix might-sleep-in-atomic while dumping elf
> 
> awe_wave-oss-too-much-__exit.patch
>   awe_wave (OSS): too much __exit
> 
> serialize-access-to-ide-devices.patch
>   serialize access to ide devices
> 
> mark-loop_change_fd-as-an-ulong-compat-ioctl.patch
>   mark LOOP_CHANGE_FD as an ULONG compat ioctl
> 
> readahead-simplification.patch
>   readahead: simplify recent fixes
> 
> consolidated-readahead-fixes.patch
>   readahead fixes
> 
> mlock-as-user-for-268-rc2-mm2.patch
>   rlimit-based mlocks for unprivileged users
>   mlock-as-user fixes
> 
> increase-mlock-limit-to-32k.patch
>   increase per-user mlock limit default to 32k
>   increase mlock limit to 32k cleanup
> 
> idt77252c-add-missing-pci_enable_device.patch
>   idt77252.c: add missing pci_enable_device()
> 
> ip2mainc-add-missing-pci_enable_device.patch
>   ip2main.c: add missing pci_enable_device()
> 
> tpam_mainc-add-missing-pci_enable_device.patch
>   tpam_main.c: add missing pci_enable_device()
> 
> ibmasm-add-missing-pci_enable_device.patch
>   ibmasm: add missing pci_enable_device()
> 
> hp100c-add-missing-pci_enable_device.patch
>   hp100.c: add missing pci_enable_device()
> 
> ioc3-ethc-add-missing-pci_enable_device.patch
>   ioc3-eth.c: add missing pci_enable_device()
> 
> de4x5c-add-missing-pci_enable_device.patch
>   de4x5.c: add missing pci_enable_device()
> 
> cpqfc-add-missing-pci_enable_device.patch
>   cpqfc: add missing pci_enable_device()
> 
> remove-unconditional-pci-acpi-irq-routing.patch
>   remove unconditional PCI ACPI IRQ routing
> 
> add-pci_fixup_enable-pass.patch
>   pci: add pci_fixup_enable pass
> 
> fix-gcc-35-compile-issue-in-mm-mempolicyc.patch
>   Fix gcc 3.5 compile issue in mm/mempolicy.c
> 
> eata_pio-warning-fix.patch
>   eata_pio.c warning fix
> 
> via-agpc-resume-suspend-support.patch
>   via-agp.c resume/suspend support
> 
> disable-atykb-warning.patch
>   disable atykb "too many keys pressed" warning
> 
> collected-aio-retry-fixes-and-enhancements.patch
>   AIO: retry infrastructure fixes and enhancements
>   collected-aio-retry-fixes-and-enhancements-cleanup
> 
> aio-splice-runlist-for-fairness-across-io-contexts.patch
>   AIO: Splice runlist for fairness across io contexts
> 
> aio-workqueue-context-switch-reduction.patch
>   AIO: workqueue context switch reduction
> 
> x86_64-numa-emulation.patch
>   x86_64: emulate NUMA on non-NUMA hardware
> 
> make-max_init_args-25.patch
>   Make MAX_INIT_ARGS 32
> 
> wireless-extension-v17-for-linus.patch
>   Wireless Extension v17 for Linus
> 
> wireless-drivers-update-for-we-17.patch
>   Wireless drivers update for WE-17
> 
> request_region-for-winbond-and-smsc-parport-drivers.patch
>   request_region for winbond and smsc parport drivers
> 
> make-md-no-device-warning-kern_warning.patch
>   md: make MD no device warning KERN_WARNING
> 
> ia64-dma_mapping-fix.patch
>   ia64: dma_mapping fix
> 
> automatically-enable-bigsmp-on-big-hp-machines.patch
>   Automatically enable bigsmp on big HP machines
> 
> rss-ulimit-enforcement.patch
>   RSS ulimit enforcement
> 
> fix-proc-pid-statm-documentation.patch
>   Fix /proc/pid/statm documentation
> 
> cciss-update-fixes-to-32-64-bit-conversions.patch
>   cciss: fixes to 32/64-bit conversions
> 
> cciss-updates-zero-out-buffer-in-passthru-ioctls-for-hp.patch
>   cciss: zero out buffer in passthru ioctls for HP utilities
> 
> cciss-updates-proc-fixes-for-268-rc3.patch
>   cciss: /proc fixes
> 
> cciss-updates-cylinder-calculation-fix-for-268-rc3.patch
>   cciss: cylinder calculation fix
> 
> cciss-updates-id-change-for-v100-controller-for-268-rc3.patch
>   cciss: id change for V100 controller
> 
> cciss-updates-id-change-for-v100-controller-for-268-rc3-fix.patch
>   cciss: V100 PCI ID fix again
> 
> cciss-updates-pdev-intr-fix-for-268-rc3.patch
>   cciss: pdev->intr fix
> 
> cciss-update-7-read_ahead-bumped-to-1024.patch
>   cciss: read_ahead bumped to 1024
> 
> cciss-update-8-maintainers-update-for-hp.patch
>   cciss update 8 maintainers update for HP
> 
> cciss-congig-dependency-fix.patch
>   cciss /proc dependency fix
> 
> rmaplock-1-5-pageanon-in-mapping.patch
>   rmaplock: PageAnon in mapping
> 
> rmaplock-2-5-kill-page_map_lock.patch
>   rmaplock: kill page_map_lock
> 
> rmaplock-3-5-slab_destroy_by_rcu.patch
>   rmaplock: SLAB_DESTROY_BY_RCU
> 
> rmaplock-4-5-mm-lock-ordering.patch
>   rmaplock: mm lock ordering
> 
> rmaplock-5-5-swapoff-use-anon_vma.patch
>   rmaplock: swapoff use anon_vma
> 
> x86-bitopsh-commentary-on-instruction-reordering.patch
>   x86 bitops.h commentary on instruction reordering
> 
> clarify-get_task_mm-mmgrab.patch
>   clarify get_task_mm (mmgrab)
> 
> simple-fs-stop-ve-dentries.patch
>   simple fs stop -ve dentries
> 
> 8139too-rx-fifo-overflow-recovery.patch
>   8139too: Rx fifo/overflow recovery
> 
> 8139too-be-sure-to-progress-durin-rtl8139_rx.patch
>   8139too: be sure to progress durin rtl8139_rx()
> 
> via-velocity-more-inetaddr_notifier-fix.patch
>   via-velocity: more inetaddr_notifier fix
> 
> vm-tune-writeback.patch
>   vm: writeout watermark tuning
> 
> alloc-pages-watermark-fixes.patch
>   vm: alloc_pages watermark fixes
> 
> alloc-pages-priority-tuning.patch
>   alloc_pages priority tuning
> 
> fix-d_path-errors.patch
>   Correctly handle d_path error returns
> 
> emu10k1-maintainer-update.patch
>   emu10k1 maintainer update
> 
> ptr_ok-cleanup.patch
>   x86: remove hard-coded numbers from ptr_ok()
> 
> mpage_readpage-unable-to-handle-bigger-requests.patch
>   Fix mpage_readpage() for big requests
>   mpage_readpage-unable-to-handle-bigger-requests warning fix
> 
> improve-speed-of-freeing-bootmem.patch
>   improve speed of freeing bootmem
> 
> implement-in-kernel-keys-keyring-management.patch
>   implement in-kernel keys & keyring management
> 
> implement-in-kernel-keys-keyring-management-update.patch
>   keys & keyring management update patch
> 
> implement-in-kernel-keys-keyring-management-update-build-fix.patch
>   implement-in-kernel-keys-keyring-management-update-build-fix
> 
> implement-in-kernel-keys-keyring-management-update-build-fix-2.patch
>   implement-in-kernel-keys-keyring-management-update-build-fix-2
> 
> key-management-patch-cleanup.patch
>   key management patch cleanup
> 
> keys-keyring-management-keyfs-patch.patch
>   keys & keyring management: keyfs patch
> 
> keyfs-build-fix.patch
>   keyfs build fix
> 
> implement-in-kernel-keys-keyring-management-afs-workaround.patch
>   implement-in-kernel-keys-keyring-management afs workaround
> 
> consolidate-clone_idletask-masking.patch
>   sched: consolidate CLONE_IDLETASK masking
> 
> kill-clone_idletask.patch
>   kill CLONE_IDLETASK
>   kill-clone_idletask fix
> 
> oprofile-xscale-fixes-for-pxa270-xscale2.patch
>   OProfile/XScale fixes for PXA270/XScale2
> 
> remove-magic-1-from-shm-segment-count.patch
>   remove magic +1 from shm segment count
> 
> 268-rc3-jffs2-unable-to-read-filesystems.patch
>   jffs2 unable to read filesystems
> 
> via-rhine-suspend-resume-support.patch
>   via-rhine: suspend/resume support
> 
> via-rhine-de-isolate-phy.patch
>   via-rhine: de-isolate PHY
> 
> via-rhine-small-fixes.patch
>   via-rhine: small fixes
> 
> fix-i386-x86_64-idle-routine-selection.patch
>   fix i386/x86_64 idle routine selection
> 
> fix-i386-x86_64-idle-routine-selection-comment-updates.patch
>   fix-i386-x86_64-idle-routine-selection comment updates
> 
> x86-pae-swapspace-expansion.patch
>   x86 PAE swapspace expansion
> 
> executable-hugetlb-pages.patch
>   hugetlb: permit executable mappings
> 
> md-fix-problems-with-checksum-handling-in-md-superblocks.patch
>   md: fix problems with checksum handling in MD superblocks.
> 
> sk98lin-no-procfs-build-fix.patch
>   sk98lin/skge.c doesn't compile with PROC_FS=n
> 
> fix-net-hamradio-dmascc-with-gcc-34-fwd.patch
>   fix net/hamradio/dmascc with gcc 3.4
> 
> fix-warnings-in-es7000.patch
>   Fix warnings in es7000
> 
> reduce-aacraid-namespace-pollution.patch
>   reduce aacraid namespace polution
> 
> reduce-bkl-usage-in-do_coredump.patch
>   Reduce bkl usage in do_coredump
> 
> ide-do-spin-up-for-all-platforms.patch
>   IDE: do spin up for all platforms
> 
> apm_infodisabled-fix.patch
>   apm_info.disabled fix
> 
> 267-rc3-mm2-inlining-failures.patch
>   fix inlining failures
> 
> qlogic-isp2x00-remove-needless-busyloop.patch
>   QLogic ISP2x00: remove needless busyloop
> 
> high2lowuid-warning-fix.patch
>   hige2lowuid warning fixes
> 
> new-cpu_has_-flags.patch
>   New cpu_has_ flags
> 
> get_nodes-mask-miscalculation.patch
>   Fix get_nodes() mask miscalculation
> 
> use-posix-headers-in-sumversionc.patch
>   Use posix headers in sumversion.c
> 
> x86-esr-print-quietness.patch
>   x86: quieten the "ESR value" printks
> 
> intel8x0c-sound-use-pci_vendor_id-rather-than-bare-numbers.patch
>   intel8x0.c sound: use PCI_VENDOR_ID* rather than bare numbers
> 
> fix-rxrpc-compile-errors-with-sysctl=n.patch
>   fix rxrpc compile errors with SYSCTL=n
> 
> dnotify-autofs-may-create-signal-restart-syscall-loop.patch
>   dnotify + autofs may create signal/restart syscall loop
> 
> ix86x86_64-cpu-features.patch
>   ix86,x86_64 cpu features
> 
> libfs-move-transaction-file-ops-into-libfs.patch
>   libfs: move transaction file ops into libfs
> 
> dont-print-per-cpu-delay-loop-calibration.patch
>   don't print per-cpu delay loop calibration
> 
> fix-sn_console-for-config_smp=n.patch
>   fix sn_console for CONFIG_SMP=n
> 
> via-velocity-wrong-module-name-in-kconfig-documentation.patch
>   via-velocity: wrong module name in Kconfig documentation
> 
> reduce-ptyc-ifdef-clutter.patch
>   reduce pty.c ifdef clutter
> 
> bug-on-inconsistant-dcache-tree-in-may_delete.patch
>   BUG() on inconsistant dcache tree in may_delete
> 
> using-get_cycles-for-add_timer_randomness.patch
>   Using get_cycles for add_timer_randomness
> 
> remove-dead-config_kernel_elf-kconfig-entry.patch
>   ppc32: remove dead CONFIG_KERNEL_ELF Kconfig entry
> 
> fix-some-comments-about-epoch-in-arch-alpha-kernel-timec.patch
>   fix some comments about epoch in arch/alpha/kernel/time.c
> 
> small-simplification-for-two-security-dependencies.patch
>   small simplification for two SECURITY dependencies
> 
> configurable-selinux-bootparam-value.patch
>   configurable SELinux bootparam value
> 
> fix-typos-in-security-securityc.patch
>   Fix typos in security/security.c
> 
> use-simple_read_from_buffer-in-selinuxfs.patch
>   use simple_read_from_buffer in selinuxfs
> 
> use-simple_read_from_buffer-in-proc_info_read-and-proc_pid_attr_read.patch
>   use simple_read_from_buffer in proc_info_read and proc_pid_attr_read
> 
> fw-new-linux-268-rc4-mm1-ipv6-in-ipv6-undefined-references.patch
>   Fix IPv6-in-IPv6 undefined references
> 
> ttys0-vs-ttys00-confusion.patch
>   Fix ttyS0 vs. ttyS00 confusion
> 
> reduce-size-of-struct-buffer_head-on-64bit.patch
>   reduce size of struct buffer_head on 64bit
> 
> reduce-size-of-struct-dentry-on-64bit.patch
>   reduce size of struct dentry on 64bit
> 
> waitid-system-call.patch
>   waitid system call
> 
> waitid-system-call-update.patch
>   waitid system call update
> 
> waitid-ia64-build-fix.patch
>   waitid-ia64-build-fix
> 
> waitid-system-call-cleanups.patch
>   waitid-system-call cleanups
> 
> remove-cacheline-alignment-from-inode-slabs.patch
>   remove cacheline alignment from inode slabs
> 
> read-cpumasks-every-time-when-exporting-through-sysfs.patch
>   Read cpumasks every time when exporting through sysfs
> 
> centralize-i386-constants.patch
>   Centralize i386 Constants
> 
> fix-permissions-on-module_param-usage.patch
>   Fix Permissions on module_param Usage
> 
> module-parameters-in-sysfs-for-built-in-modules.patch
>   Move param section out of init area, for export of built-in module params
> 
> remove-module_parm-from-main-part-of-kernel.patch
>   Remove MODULE_PARM from main part of kernel
> 
> filemap_index_overflow.patch
>   fix pagecache reading off-by-one
> 
> synclinkc-replace-syncppp-with-genhdlc.patch
>   synclink.c: replace syncppp with genhdlc
> 
> synclinkmpc-replace-syncppp-with-genhdlc.patch
>   synclinkmp.c: replace syncppp with genhdlc
> 
> synclink_csc-replace-syncppp-with-genhdlc.patch
>   synclink_cs.c: replace syncppp with genhdlc
> 
> reiserfs-xattr-acl-fixes.patch
>   reiserfs: xattr/acl fixes
> 
> files-up-to-4-gb-support-for-iso9660-filesystems.patch
>   Fix access of files up to 4 GB support for ISO9660 filesystems
> 
> selinux-add-null-device-node-to-selinuxfs-remove-open_devnull.patch
>   SELinux: add null device node to selinuxfs, remove open_devnull
> 
> selinux-revalidate-access-to-controlling-tty.patch
>   SELinux: revalidate access to controlling tty
> 
> selinux-defer-inode-security-initialization.patch
>   SElinux; defer inode security initialization
> 
> selinux-fix-name_bind-audit.patch
>   SELinux: fix name_bind audit
> 
> reduce-selinux-kernel-memory-use-on-64-bit-systems.patch
>   Reduce SELinux kernel memory use on 64-bit systems
> 
> remove-last-suser-call-drivers-char-rocketc.patch
>   remove last suser() call from drivers/char/rocket.c
> 
> serial-8250-optionally-skip-autodetection.patch
>   Serial 8250 optionally skip autodetection
> 
> serial-8250-omap-support.patch
>   Serial 8250 OMAP support
> 
> add-pci-dependencies-to-drivers-media-dvb-ttpci-kconfig.patch
>   Add pci dependencies to drivers/media/dvb/ttpci/Kconfig
> 
> add-to-snd-intel8x0-ac97-quirk-list.patch
>   add to snd-intel8x0 AC97 quirk list
> 
> compat_do_execve-fix.patch
>   compat_do_execve() fix
> 
> defxx-trivial-updates.patch
>   defxx trivial updates
> 
> defxx-device-name-fixes.patch
>   defxx device name fixes
> 
> fix-4k-ext2fs-support-in-26-initrds.patch
>   fix 4K ext2fs support in 2.6 initrd's
> 
> coding-style-do_thisab-vs-do_thisa-b.patch
>   Coding style: do_this(a,b) vs. do_this(a, b)
> 
> typo-in-laptop_modetxt.patch
>   typo in laptop_mode.txt
> 
> tainted-sysctl-permissions-fix.patch
>   fix permissions on the `tainted' sysctl
> 
> s390-core-changes.patch
>   s390: core changes
> 
> s390-zfcp-host-adapter.patch
>   s390: zfcp host adapter
> 
> s390-lcs-network-driver.patch
>   s390: lcs network driver
> 
> bio_uncopy_user-mem-leak.patch
>   fix bio_uncopy_user() mem leak
> 
> bio_uncopy_user-mem-leak-fix.patch
>   bio_uncopy_user mem leak fix
> 
> notify_parent-cleanup.patch
>   notify_parent() cleanup
> 
> remove-notify_parent.patch
>   remove notify_parent()
> 
> i386-unbusy-tss-cleanup.patch
>   i386-unbusy-tss cleanup
> 
> jffs2-mount-options-discarded.patch
>   JFFS2 mount options discarded
> 
> kexec-i8259-shutdowni386.patch
>   kexec: i8259-shutdown.i386
> 
> kexec-i8259-sysfsx86_64.patch
>   kexec: i8259-sysfs.x86_64
> 
> kexec-x86_64-i8259-fixes.patch
>   kexec-x86_64-i8259-fixes
> 
> kexec-apic-virtwire-on-shutdowni386patch.patch
>   kexec: apic-virtwire-on-shutdown.i386.patch
> 
> kexec-apic-virtwire-on-shutdownx86_64.patch
>   kexec: apic-virtwire-on-shutdown.x86_64
> 
> kexec-ioapic-virtwire-on-shutdowni386.patch
>   kexec: ioapic-virtwire-on-shutdown.i386
> 
> kexec-ioapic-virtwire-on-shutdownx86_64.patch
>   kexec: ioapic-virtwire-on-shutdown.x86_64
> 
> kexec-e820-64bit.patch
>   kexec: e820-64bit
> 
> kexec-kexec-generic.patch
>   kexec: kexec-generic
> 
> kexec-machine_shutdownx86_64.patch
>   kexec: machine_shutdown.x86_64
> 
> kexec-kexecx86_64.patch
>   kexec: kexec.x86_64
> 
> kexec-machine_shutdowni386.patch
>   kexec: machine_shutdown.i386
> 
> kexec-kexeci386.patch
>   kexec: kexec.i386
> 
> kexec-use_mm.patch
>   kexec: use_mm
> 
> kexec-kexecppc.patch
>   kexec: kexec.ppc
> 
> new-bitmap-list-format-for-cpusets.patch
>   new bitmap list format (for cpusets)
> 
> cpusets-big-numa-cpu-and-memory-placement.patch
>   cpusets - big numa cpu and memory placement
> 
> reiser4-sb_sync_inodes.patch
>   reiser4: vfs: add super_operations.sync_inodes()
> 
> reiser4-sb_sync_inodes-cleanup.patch
>   reiser4-sb_sync_inodes-cleanup
> 
> reiser4-allow-drop_inode-implementation.patch
>   reiser4: export vfs inode.c symbols
> 
> reiser4-allow-drop_inode-implementation-cleanup.patch
>   reiser4-allow-drop_inode-implementation-cleanup
> 
> reiser4-truncate_inode_pages_range.patch
>   reiser4: vfs: add truncate_inode_pages_range()
> 
> reiser4-truncate_inode_pages_range-cleanup.patch
>   reiser4-truncate_inode_pages_range-cleanup
> 
> reiser4-export-remove_from_page_cache.patch
>   reiser4: export pagecache add/remove functions to modules
> 
> reiser4-export-page_cache_readahead.patch
>   reiser4: export page_cache_readahead to modules
> 
> reiser4-reget-page-mapping.patch
>   reiser4: vfs: re-check page->mapping after calling try_to_release_page()
> 
> reiser4-rcu-barrier.patch
>   reiser4: add rcu_barrier() synchronization point
> 
> reiser4-rcu-barrier-fix.patch
>   reiser4-rcu-barrier fix
> 
> reiser4-export-inode_lock.patch
>   reiser4: export inode_lock to modules
> 
> reiser4-export-inode_lock-cleanup.patch
>   reiser4-export-inode_lock-cleanup
> 
> reiser4-export-pagevec-funcs.patch
>   reiser4: export pagevec functions to modules
> 
> reiser4-export-pagevec-funcs-cleanup.patch
>   reiser4-export-pagevec-funcs-cleanup
> 
> reiser4-export-radix_tree_preload.patch
>   reiser4: export radix_tree_preload() to modules
> 
> reiser4-radix-tree-tag.patch
>   reiser4: add new radix tree tag
> 
> reiser4-radix_tree_lookup_slot.patch
>   reiser4: add radix_tree_lookup_slot()
> 
> reiser4-aliased-dir.patch
>   reiser4: vfs: handle aliased directories
> 
> reiser4-kobject-umount-race.patch
>   reiser4: introduce filesystem kobjects
> 
> reiser4-kobject-umount-race-cleanup.patch
>   reiser4-kobject-umount-race-cleanup
> 
> reiser4-perthread-pages.patch
>   reiser4: per-thread page pools
> 
> reiser4-unstatic-kswapd.patch
>   reiser4: make kswapd() unstatic for debug
> 
> reiser4-include-reiser4.patch
>   reiser4: add to build system
> 
> reiser4-4kstacks-fix.patch
>   resier4-4kstacks-fix
> 
> reiser4-doc.patch
>   reiser4: documentation
> 
> reiser4-doc-update.patch
>   Update Documentation/Changes for reiser4
> 
> reiser4-only.patch
>   reiser4: main fs
> 
> reiser4-remove-debug.patch
>   resier4: remove debug stuff
> 
> reiser4-spinlock-debugging-build-fix-2.patch
>   reiser4-spinlock-debugging-build-fix-2
> 
> reiser4-sparc64-build-fix.patch
>   reiser4 sparc64 build fix
> 
> sys_reiser4-sparc64-build-fix.patch
>   sys_reiser4 sparc64 build fix
> 
> reiser4-printk-warning-fixes.patch
>   reiser4 printk warning fixes
> 
> proc-pid-cmdline-truncates-arguments-early.patch
>   /proc/PID/cmdline truncates arguments early
> 
> fix-rusage-semantics.patch
>   fix rusage semantics
> 
> update-aci-mixer-driver-webpage.patch
>   Update ACI MIXER DRIVER webpage
> 
> remove-read-only-immutable-checks-from-fat_truncate.patch
>   remove read-only/immutable checks from fat_truncate
> 
> ext3-documentation.patch
>   ext3 documentation
> 
> fix-mt-reparenting-when-thread-group-leader-dies.patch
>   fix MT reparenting when thread group leader dies
> 
> acpi-based-floppy-controller-enumeration.patch
>   ACPI-based floppy controller enumeration
> 
> ad1816-sound-driver-web-page-and-email-address.patch
>   ad1816 sound driver web page and email address
> 
> firmware-loader-is-orphan.patch
>   Firmware Loader is orphan
> 
> possible-dcache-bug-debugging-patch.patch
>   Possible dcache BUG: debugging patch
> 
> remove-struct-bus_type-add.patch
>   Remove struct bus_type->add()
> 
> file_ra_state_init-speedup.patch
>   file_ra_state_init speedup
> 
> dev-random-fix-latency-in-rekeying-sequence-number.patch
>   dev/random: Fix latency in rekeying sequence number
> 
> dev-random-add-pool-name-to-entropy-store.patch
>   /dev/random: Add pool name to entropy store
> 
> dev-random-use-separate-entropy-store-for-dev-urandom.patch
>   /dev/random: Use separate entropy store for /dev/urandom
> 
> dev-random-remove-rndgetpool-ioctl.patch
>   /dev/random: Remove RNDGETPOOL ioctl
> 
> copy_mount_options-size-fix.patch
>   copy_mount_options size fix
> 
> fix-bad-url-in-bsd-acct-help-entry.patch
>   Fix bad URL in BSD acct help entry
> 
> dothan-speedstep-fix.patch
>   dothan speedstep fix
> 
> shows-active-inactive-on-per-node-meminfo.patch
>   show Active/Inactive on per-node meminfo
> 
> shows-active-inactive-on-per-node-meminfo-speedup.patch
>   shows-active-inactive-on-per-node-meminfo speedup
> 
> minix-nblocks-retval-fix.patch
>   minixfs: nblocks() return value fix
> 
> usercopy-return-EFAULT.patch
>   usercopy: return EFAULT
> 
> intel8x0-latency-fix.patch
>   intel8x0 latency fix
> 
> inode-time-update-funnies-in-ncpfs.patch
>   inode time update funnies in ncpfs
> 
> improve-oprofile-on-many-way-systems.patch
>   improve OProfile on many-way systems
> 
> fix-oprofile-events-with-zero-event-values.patch
>   fix OProfile events with zero event values
> 
> oprofile-ia64-performance-counter-support.patch
>   OProfile ia64 performance counter support
> 
> pci-driver-function-documentation-fix.patch
>   pci-driver: function documentation fix
> 
> vlan-missing-kconfig-help.patch
>   vlan: missing Kconfig help
> 
> remove-obsolete-htab-reclaim-in-documentation-sysctl-kerneltxt.patch
>   remove obsolete htab-reclaim in Documentation/sysctl/kernel.txt
> 
> remove-obsolete-zero-paged-in-documentation-sysctl-kerneltxt.patch
>   remove obsolete zero-paged in Documentation/sysctl/kernel.txt
> 
> legousbtower-module_param-fix.patch
>   legousbtower.c module_param fix
> 
> fix-pid-hash-sizing.patch
>   fix PID hash sizing
> 
> use-hlist-for-pid-hash.patch
>   use hlist for pid hash
> 
> use-hlist-for-pid-hash-cache-friendliness.patch
>   use hlist for pid hash: cache friendliness
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
