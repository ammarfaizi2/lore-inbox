Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273619AbRIVFqB>; Sat, 22 Sep 2001 01:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273630AbRIVFpw>; Sat, 22 Sep 2001 01:45:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56844 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273619AbRIVFpi>; Sat, 22 Sep 2001 01:45:38 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: major VM suckage with 2.4.10pre12 and 2.4.10pre13 and highmem, we will help test
Date: Sat, 22 Sep 2001 05:44:06 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9oh8f6$b76$1@penguin.transmeta.com>
In-Reply-To: <F341E03C8ED6D311805E00902761278C04728F82@xfc04.fc.hp.com>
X-Trace: palladium.transmeta.com 1001137535 5255 127.0.0.1 (22 Sep 2001 05:45:35 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 22 Sep 2001 05:45:35 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <F341E03C8ED6D311805E00902761278C04728F82@xfc04.fc.hp.com>,
HABBINGA,ERIK (HP-Loveland,ex1) <erik_habbinga@hp.com> wrote:
>Kernel 2.4.10pre13 did not help our NFS SPEC testing on a machine with 4GB
>RAM.  Refer to my previous message about those results:
>http://lists.insecure.org/linux-kernel/2001/Sep/3036.html
>
>In a nutshell, kswapd starts grabbing 99% of the CPU for long stretches in
>time, which causes us to drop NFS RPC connections, which causes performance
>to suck.

Duh.

No wonder.

There's this test in page_alloc.c that tests for atomic allocations the
wrong way - it uses "(gfp_mask & __GFP_HIGH)", when the test _should_ be
"!(gfp_mask & __GFP_WAIT)".

Which causes regular kernel allocations to eat into the reserved memory
pool.  Which in turn makes the _real_ atomic allocations really rather
unhappy (resulting in lost packets - which pretty much guarantees sucky
NFS performance ;).

And it probably doesn't make kswapd that happy either... 

You can either fix that single line, or try out pre14 which cleans up
some other things too..

		Linus

-----
pre14:
 - Richard Gooch: devfs update
 - Andrea Arcangeli: clean up/fix ramdisk handling now that it's in page cache
 - Al Viro: follow up the above with initrd cleanups
 - Keith Owens: get rid of drivers/scsi/53c700-mem.c file
 - Trond Myklebust: RPC over TCP race fix
 - Greg KH: USB update (ohci understands USB_ZERO_PACKET)
 - me: clean up reference bit handling, fix silly GFP_ATOMIC allocation bug

pre13:
 - Manfred Spraul: /proc/pid/maps cleanup (and bugfix for non-x86)
 - Al Viro: "block device fs" - cleanup of page cache handling
 - Hugh Dickins: VM/shmem cleanups and swap search speedup
 - David Miller: sparc updates, soc driver typo fix, net updates
 - Jeff Garzik: network driver updates (dl2k, yellowfin and tulip)
 - Neil Brown: knfsd cleanups and fixues
 - Ben LaHaise: zap_page_range merge from -ac

pre12:
 - Alan Cox: much more merging
 - Pete Zaitcev: ymfpci race fixes
 - Andrea Arkangeli: VM race fix and OOM tweak.
 - Arjan Van de Ven: merge RH kernel fixes
 - Andi Kleen: use more readable 'likely()/unlikely()' instead of __builtin_expect()
 - Keith Owens: fix 64-bit ELF types
 - Gerd Knorr: mark more broken PCI bridges, update btaudio driver
 - Paul Mackerras: powermac driver update
 - me: clean up PTRACE_DETACH to use common infrastructure

pre11:
 - Neil Brown: md cleanups/fixes
 - Andrew Morton: console locking merge
 - Andrea Arkangeli: major VM merge

pre10:
 - Alan Cox: continued merging
 - Mingming Cao: make msgrcv/shmat check the queue/segment ID's properly
 - Greg KH: USB serial init failure fix, Xircom serial converter driver
 - Neil Brown: nsfd/raid/md/lockd cleanups
 - Ingo Molnar: multipath RAID personality, raid xor update
 - Hugh Dickins/Marcelo Tosatti: swapin read-ahead race fix
 - Vojtech Pavlik: fix up some of the infrastructure for x86-64
 - Robert Love: AMD 761 AGP GART support
 - Jens Axboe: fix SCSI-generic queue handling race
 - me: be sane about page reference bits

pre9:
 - Greg KH: start migration to new "min()/max()"
 - Roman Zippel: move affs over to "min()/max()".
 - Vojtech Pavlik: VIA update (make sure not to IRQ-unmask a vt82c576)
 - Jan Kara: quota bug-fix (don't decrement quota for non-counted inode)
 - Anton Altaparmakov: more NTFS updates
 - Al Viro: make nosuid/noexec/nodev be per-mount flags, not per-filesystem
 - Alan Cox: merge input/joystick layer differences, driver and alpha merge
 - Keith Owens: scsi Makefile cleanup
 - Trond Myklebust: fix oopsable race in locking code
 - Jean Tourrilhes: IrDA update

pre8:
 - Christoph Hellwig: clean up personality handling a bit
 - Robert Love: update sysctl/vm documentation
 - make the three-argument (that everybody hates) "min()" be "min_t()",
   and introduce a type-anal "min()" that complains about arguments of
   different types. 

pre7:
 - Alan Cox: big driver/mips sync
 - Andries Brouwer, Christoph Hellwig: more gendisk fixups
 - Tobias Ringstrom: tulip driver workaround for DC21143 erratum

pre6:
 - Jens Axboe: remove trivially dead io_request_lock usage
 - Andrea Arcangeli: softirq cleanup and ARM fixes. Slab cleanups
 - Christoph Hellwig: gendisk handling helper functions/cleanups
 - Nikita Danilov: reiserfs dead code pruning
 - Anton Altaparmakov: NTFS update to 1.1.18
 - firestream network driver: patch reverted on authors request
 - NIIBE Yutaka: SH architecture update
 - Paul Mackerras: PPC cleanups, PPC8xx update.
 - me: reverse broken bootdata allocation patch that went into pre5

pre5:
 - Merge with Alan
 - Trond Myklebust: NFS fixes - kmap and root inode special case
 - Al Viro: more superblock cleanups, inode leak in rd.c, minix
   directories in page cache
 - Paul Mackerras: clean up rubbish from sl82c105.c
 - Neil Brown: md/raid cleanups, NFS filehandles
 - Johannes Erdfelt: USB update (usb-2.0 support, visor fix, Clie fix,
   pl2303 driver update)
 - David Miller: sparc and net update
 - Eric Biederman: simplify and correct bootdata allocation - don't
   overwrite ramdisks
 - Tim Waugh: support multiple SuperIO devices, parport doc updates

pre4:
 - Hugh Dickins: swapoff cleanups and speedups
 - Matthew Dharm: USB storage update
 - Keith Owens: Makefile fixes
 - Tom Rini: MPC8xx build fix
 - Nikita Danilov: reiserfs update
 - Jakub Jelinek: ELF loader fix for ET_DYN
 - Andrew Morton: reparent_to_init() for kernel threads
 - Christoph Hellwig: VxFS and SysV updates, vfs_permission fix

pre3:
 - Johannes Erdfelt, Oliver Neukum: USB printer driver race fix
 - John Byrne: fix stupid i386-SMP irq stack layout bug
 - Andreas Bombe, me: yenta IO window fix
 - Neil Brown: raid1 buffer state fix
 - David Miller, Paul Mackerras: fix up sparc and ppc respectively for kmap/kbd_rate
 - Matija Nalis: umsdos fixes, and make it possible to boot up with umsdos
 - Francois Romieu: fix bugs in dscc4 driver
 - Andy Grover: new PCI config space access functions (eventually for ACPI)
 - Albert Cranford: fix incorrect e2fsprog data from ver_linux script
 - Dave Jones: re-sync x86 setup code, fix macsonic kmalloc use
 - Johannes Erdfelt: remove obsolete plusb USB driver
 - Andries Brouwer: fix USB compact flash version info, add blksize ioctls

pre2:
 - Al Viro: block device cleanups
 - Marcelo Tosatti: make bounce buffer allocations more robust (it's ok
   for them to do IO, just not cause recursive bounce IO. So allow them)
 - Anton Altaparmakov: NTFS update (1.1.17)
 - Paul Mackerras: PPC update (big re-org)
 - Petko Manolov: USB pegasus driver fixes
 - David Miller: networking and sparc updates
 - Trond Myklebust: Export atomic_dec_and_lock
 - OGAWA Hirofumi: find and fix umsdos "filldir" users that were broken
   by the 64-bit-cleanups. Fix msdos warnings.
 - Al Viro: superblock handling cleanups and race fixes
 - Johannes Erdfelt++: USB updates

pre1:
 - Jeff Hartmann: DRM AGP/alpha cleanups
 - Ben LaHaise: highmem user pagecopy/clear optimization
 - Vojtech Pavlik: VIA IDE driver update
 - Herbert Xu: make cramfs work with HIGHMEM pages
 - David Fennell: awe32 ram size detection improvement
 - Istvan Varadi: umsdos EMD filename bug fix
 - Keith Owens: make min/max work for pointers too
 - Jan Kara: quota initialization fix
 - Brad Hards: Kaweth USB driver update (enable, and fix endianness)
 - Ralf Baechle: MIPS updates
 - David Gibson: airport driver update
 - Rogier Wolff: firestream ATM driver multi-phy support
 - Daniel Phillips: swap read page referenced set - avoid swap thrashing

