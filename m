Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTEUWLe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 18:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbTEUWLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 18:11:34 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:29504 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262176AbTEUWLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 18:11:22 -0400
Date: Wed, 21 May 2003 15:22:55 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: must-fix list, v5
Message-Id: <20030521152255.4aa32fba.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2003 22:24:24.0933 (UTC) FILETIME=[BC0C3950:01C31FE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/

For verson 6 I shall go through the "late features" list and prioritise
things.


Changes since v5:

--- must-fix-4.txt	Wed May 21 15:18:28 2003
+++ must-fix-5.txt	Wed May 21 15:17:25 2003
@@ -11,20 +11,23 @@
 
   o Other problems: aviro, dipankar, Alan have details.
 
   o somebody will have to document the tty driver and ldisc API
 
 o Lack of test cases and/or stress tests is a problem.  Contributions and
   suggestions are sought.
 
 o Lots of drivers are using cli/sti and are broken.
 
+o willy: random.c is completely lockfree, and not in a good way.  i had
+  some patches but nothing got seriously tested.
+
 drivers/tty
 ~~~~~~~~~~~
 
 o viro: we need to fix refcounting for tty_driver (oopsable race, must fix
   anyway, hopefully about a week until it's merged) then we can do
   tty/misc/upper levels of sound and hopefully upper level of USB.
 
   USB is a place where we _really_ need to deal with dynamic allocation of
   device numbers and that will bite.
 
@@ -72,31 +75,37 @@
 
   We need to understand whether the proposed BIO split code will suffice
   for this.
 
 o CD burning.  There are still a few quirks to solve wrt SG_IO and ide-cd.
 
   Jens: The basic hang has been solved (double fault in ide-cd), there still
   seems to be some cases that don't work too well.  Don't really have a
   handle on those :/
 
+o lmb: Last time I looked at the multipath code (2.5.50 or so) it also
+  looked pretty broken; I plan to port forward the changes we did on 2.4
+  before KS.
+
+o elevator-noop is broken.
+
 drivers/input/
 ~~~~~~~~~~~~~~
 
 o rmk: unconverted keyboard/mouse drivers (there's a deadline of 2.6.0
   currently on these remaining in my/Linus' tree.)
 
 o viro: large absence of locking.
 
 o synaptic touchpad support
 
-  Apparently there's a userspace `tpconfig'
+  Jens Taprogge <jens.taprogge@rwth-aachen.de> is working on this.
 
 o andi: also the input keyboard stuff still has unusably obscure config
   options for standard PC hardware.
 
 o viro: parport is nearly as bad as that and there the code is more hairy. 
   IMO parport is more of "figure out what API changes are needed for its
   users, get them done ASAP, then fix generic layer at leisure"
 
 drivers/misc/
 ~~~~~~~~~~~~~
@@ -141,20 +150,24 @@
   (bugzilla, please?)
 
 o We have multiple drivers walking the pci device lists and also using
   things like pci_find_device in unsafe ways with no refcounting.  I think
   we have to make pci_find_device etc refcount somewhere and add
   pci_device_put as was done with networking.
   http://bugzilla.kernel.org/show_bug.cgi?id=709
 
   (gregkh will work on this)
 
+o willy: PCI Domain support.  The 'must-fix' bit of this is getting sysfs
+  to present the right interface to userspace so we can adapt pciutils & X to
+  use it.
+
 drivers/pcmcia/
 ~~~~~~~~~~~~~~~
 
 o alan: Most drivers crash the system on eject randomly with timer bugs.  I
   think after RMK's stuff is in most of the pcmcia/cardbus ones go except the
   locking disaster.
 
   (rmk, brodo: in progress)
 
 drivers/pld/
@@ -245,50 +258,74 @@
   In progress.
 
 o forward-port sct's O_DIRECT fixes
 
 o viro: there is some generic stuff for namei/namespace/super, but that's a
   slow-merge and can go in 2.6 just fine
 
 o andi: also soft needs to be fixed - there are quite a lot of
   uninterruptible waits in sunrpc/nfs
 
-kernel/
-~~~~~~~
+o trond: NFS has a mmap-versus-truncate problem
+
+kernel/sched.c/
+~~~~~~~~~~~~~~~
 
 o O(1) scheduler starvation, poor behaviour seems unresolved.
 
   Jens: "I've been running 2.5.67-mm3 on my workstation for two days, and
   it still doesn't feel as good as 2.4.  It's not a disaster like some
   revisisons ago, but it still has occasional CPU "stalls" where it feels
   like a process waits for half a second of so for CPU time.  That's is very
   noticable."
 
    Also see Mike Galbraith's work.
 
   Conclusion: the scheduler has issues, lots of people working on it.  Rick
   Lindsley, Andrew Theurer.
 
-o drepper: there are at least two big problems with the interaction between
-  futex and O(1).  Ingo has already patches.  But we need much more testing
-  on big boxes.  Only 4p+ machines have problems
+o "Persistent starvation"
+
+  http://www.hpl.hp.com/research/linux/kernel/o1-starve.php
+
+  ingo: "this is mostly invalid".
+
+o Overeager affinity in presence of repeated yields
+
+  http://www.hpl.hp.com/research/linux/kernel/o1-openmp.php
+
+  ingo: this is valid.  fix is in progress.
+
+o The "thud.c" test app.  This is a exploit for the interactivity
+  estimator.  it's unlikely to bite in real-world cases.  Needs watching. 
+  Can be ameliorated by setting nice values.
+
+o generic interactivity problems need watching.  We've closed down a number
+  of items recently without introducing new ones, so i'm confident this is
+  heading in the right direction.
+
+kernel/
+~~~~~~~
 
 o Alan: 32bit uid support is *still* broken for process accounting.
 
   Create a 32bit uid, turn accounting on.  Shock horror it doesn't work
   because the field is 16bit.  We need an acct structure flag day for 2.6
   IMHO
 
   (alan has patch)
 
 o nasty task refcounting bug is taking ages to track down.  (bugzilla ref?)
 
+o viro: core sysctl code is racy.  And its interaction wiuth sysfs
+
+o gettimeofday goes backwards.  Merge up David M-T's fixes?
 
 mm/
 ~~~
 
 o Overcommit accounting gets wrong answers
 
   o underestimates reclaimable slab, gives bogus failures when
     dcache&icache are large.
 
   o gets confused by reclaimable-but-not-freed truncated ext3 pages. 
@@ -419,43 +456,58 @@
 Not-ready features and speedups
 ===============================
 
 
 drivers/block/
 ~~~~~~~~~~~~~~
 
 o Framework for selecting IO schedulers.  This is the main one really. 
   Once this is in place we can drop in new schedulers any old time, no risk.
 
-o Runtime-selectable disk scheduler framework.
-
 o Anticipatory scheduler.  Working OK now, still has problems with seeky
   OLTP-style loads.
 
 o CFQ scheduler.  Seems to work but Jens planning significant rework.
 
-o The feral.com qlogic driver: needs work.
+o cryptoloop: jmorris: There's no cryptoloop in the 2.4 mainline kernel,
+  but I think every distro ships some version.  It would probably be useful
+  to have crypto natively supported in 2.6, with backward compatibility for
+  the majority of 2.4 users.
+
+  problem: lack of a loop maintainer
+
+o viro: paride drivers need a big cleanup
 
 drivers/char/rtc/
 ~~~~~~~~~~~~~~~~~
 
 o rmk: I think we need a generic RTC driver (which is backed by real RTCs).
    Integrator-based stuff has a 32-bit 1Hz counter RTC with alarm, as has the
   SA11xx, and probably PXA.  There's another implementation for the RiscPC
   and ARM26 stuff.  I'd rather not see 4 implementations of the RTC userspace
   API, but one common implementation so that stuff gets done in a consistent
   way.
 
   We postponed this at the beginning of 2.4 until 2.5 happened.  We're now
   at 2.5, and I'm about to add at least one more (the Integrator
   implementation.) This isn't sane imo.
 
+device mapper
+~~~~~~~~~~~~~
+
+o ioctl interface cleanup patch is ready (redo the structure layouts)
+
+o A port of the 2.4 snapshot target is in progress
+
+o the fs interface to dm needs to be redone.  gregkh was going to work on
+  this.  viro is interested in seeing work thus-far.
+
 drivers/net/wireless/
 ~~~~~~~~~~~~~~~~~~~~~
 
   (Jean Tourrilhes <jt@bougret.hpl.hp.com>)
 
 o get latest orinoco changes from David.
 
 o get the latest airo.c fixes from CVS.  This will hopefully fix problems
   people have reported on the LKML.
 
@@ -476,26 +528,26 @@
 drivers/usb/gadget/
 ~~~~~~~~~~~~~~~~~~~
 
 o rmk: SA11xx USB client/gadget code (David B has been doing some work on
   this, and keeps trying to prod me, but unfortunately I haven't had the time
   to look at his work, sorry David.)
 
 fs/
 ~~~
 
-o reiserfs_file_write() speedup.  There are concerns that some applications
-  do the wrong thing with large stat.st_blksize.
-
 o ext3 lock_kernel() removal: that part works OK and is mergeable.  But
   we'll also need to make lock_journal() a spinlock, and that's deep surgery.
 
+o ext3 and ext2 block allocators have serious failure modes - interleaved
+  allocations.
+
 o 32bit quota needs a lot more testing but may work now
 
 o Integrate Chris Mason's 2.4 reiserfs ordered data and data journaling
   patches.  They make reiserfs a lot safer.
 
 o (Trond:) Yes: I'm still working on an atomic "open()", i.e.  one
            where we short-circuit the usual VFS path_walk() + lookup() +
            permission() + create() + ....  bullsh*t...
 
            I have several reasons for wanting to do this (all of
@@ -519,58 +571,70 @@
 
    I'd very much like for something like Peter Braam's 'lookup with
    intent' or (better yet) for a proper dentry->open() to be integrated with
    path_walk()/open_namei().  I'm still working on the latter (Peter has
    already completed the lookup with intent stuff).
 
 o rmk: update acorn partition parsing code - making all acorn schemes
   appear in check.c so we don't have to duplicate the scanning of multiple
   types, and adding support for eesox partitions.
 
+o atomic i_size patches
+
+o viro: cleaning up options-parsers in filesystems.  (patch exists, needs
+  porting).
+
+o aio: fs IO isn't async at present.  suparna has restart patches, they're
+  in -mm.  Need to get Ben to review/comment.
+
 
 kernel/
 ~~~~~~~
 
-  (Rusty)
-
-o Zippel's Reference count simplification.  Tricky code, but cuts about 120
-  lines from module.c.  Patch exists, needs stressing.
+o rusty: Zippel's Reference count simplification.  Tricky code, but cuts
+  about 120 lines from module.c.  Patch exists, needs stressing.
 
-o /proc/kallsyms.  What most people really wanted from /proc/ksyms.  Patch
-  exists.
+o rusty: /proc/kallsyms.  What most people really wanted from /proc/ksyms. 
+  Patch exists.
 
-o Fix module-failed-init races by starting module "disabled".  Patch
+o rusty: Fix module-failed-init races by starting module "disabled".  Patch
   exists, requires some subsystems (ie.  add_partition) to explicitly say
-  "make module live now".  Without patch we are no worse off than 2.4 etc. 
+  "make module live now".  Without patch we are no worse off than 2.4 etc.  
 
 o Integrate userspace irq balancing daemon.
 
 o kexec.  Seems to work, is in -mm.
 
 o rmk: modules / /proc/kcore / vmalloc This needs sorting and testing to
   ensure that stuff like gdb vmlinux /proc/kcore works as expected.  I
   believe this is the only show stopper preventing any ARM platform being
   built in Linus' kernel.
 
+o kcore is a problem for ia64 (Tony Luck)
+
 o rmk: lib/inflate.c must not use static variables (causes these to be
   referenced via GOTOFF relocations in PIC decompressor.  We have a PIC
   decompressor to avoid having to hard code a per platform zImage link
   address into the makefiles.)
 
+o klibc merge?
+
 mm/
 ~~~
 
 o objrmap: concerns over page reclaim performance at high sharing levels,
   and interoperation with nonlinear mappings is hairy.
 
-o Readd and make /proc/sys/vm/freepages writable again so that boxes can be
-  tuned for heavy interrupt load.
+o Reintroduce and make /proc/sys/vm/freepages writable again so that boxes
+  can be tuned for heavy interrupt load.
+
+o oxymoron's async write-error-handling patch
 
 net/
 ~~~~
 
   (davem)
 
 o Real serious use of IPSEC is hampered by lack of MPLS support.  MPLS is a
   switching technology that works by switching based upon fixed length labels
   prepended to packets.  Many people use this and IPSEC to implement VPNs
   over public networks, it is also used for things like traffic engineering.
@@ -628,50 +692,38 @@
   platform-specific methods along the way. 
 
 o A better suspend-to-disk mechanism than swsusp. 
 
   There are various other details to be worked out, which are the real fun
   part.  And of course, driver support, but that is something that can happen
   at any time.  
 
   (Alan)
 
-o PCI locking
-
 o Frame buffer restore codepaths (that requires some deep PCI magic)
 
 o XFree86 hooks
 
 o AGP restoration
 
 o DRI restoration
 
-o IDE suspend/resume without races (Ben is looking at this a little)
-
-o How to deal with devices that babble (some stuff we have to global IRQ
-  off to save, and global IRQ on -after- we recover with APM)
+  (davej/Alan: not super-critical, can crash laptop on restore.  davej
+  looking into it.)
 
-o Pat's swsusp rework?
+o IDE suspend/resume without races (Ben is looking at this a little)
 
 o Pat: There are already CPU device structures; MTRRs should be a
   dynamically registered interface of CPUs, which implies there needs
   to be some other glue to know that there are MTRRs that need to be
   saved/restored.
 
-arch/i386/
-~~~~~~~~~~
-
-o Also PC9800 merge needs finishing to the point we want for 2.6 (not all).
-
-o ES7000 wants merging (now we are all happy with it).  That shouldn't be a
-  big problem.
-
 global
 ~~~~~~
 
 o 64-bit dev_t.  Seems almost ready, but it's not really known how much
   work is still to do.  Patches exist in -mm but with the recent rise of the
   neo-viro I'm not sure where things are at.
 
 o We need a kernel side API for reporting error events to userspace (could
   be async to 2.6 itself)
 
@@ -683,26 +735,30 @@
 
 o general confusion over firmware policy:
 
   o do we mandate that it be uploaded from userspace?
 
   o Is binary-blob-in-kernel-image OK?
 
   o Each driver (wireless, scsi, etc) seems to do it in a different,
     private manner.
 
+  gregkh: patch exists, drivers can be ported to use new infrastructure at
+  any time.
 
+o larger cpumask_t - supporting more than BITS_PER_LONG CPUs.
 
-
+  wli: patch exists.  ia32, ppc are done.  ppc64 in progress.  Needs work
+  for other architectures.
 
 drivers
-=======
+~~~~~~~
 
 o Some network drivers don't even build
 
 o Alan: Cardbus/PCMCIA requires all Russell's stuff is merged to do
   multiheader right and so on
 
 drivers/acpi/
 ~~~~~~~~~~~~~
 
 o davej: ACPI has a number of failures right now.  There are a number of
@@ -710,25 +766,32 @@
   "network card doesn't recieve packets" booting with 'acpi=off noapic' fixes
   it.
 
   alan: VIA APIC stuff is one bit of this, there are also some other
   reports that were caused by ACPI not setting level v edge trigger some
   times
 
 o davej: There's also another nasty 'doesnt boot' bug which quite a few
   people (myself included) are seeing on some boxes (especially laptops).
 
+o mochel: it seems the acpi irq routing code could use a serious rewrite.
+
+o mochel: ACPI suspend doesn't work.  Important, not cricital.  Pat is
+  working it.
+
 drivers/block/
 ~~~~~~~~~~~~~~
 
 o Floppy is almost unusably buggy still
 
+  akpm: we need more people to test & report.
+
 drivers/char/
 ~~~~~~~~~~~~~
 
 o Alan: Multiple serious bugs in the DRI drivers (most now with patches
   thankfully).  "The badness I know about is almost entirely IRQ mishandling.
    DRI failing to mask PCI irqs on exit paths."
 
   (might be fixed due to DRI updates?)
 
 o Various suspect things in AGP.
@@ -783,65 +846,82 @@
 
 o davej: Either Wireless network drivers or PCMCIA broke somewhen.  A
   configuration that worked fine under 2.4 doesn't receive any packets.  Need
   to look into this more to make sure I don't have any misconfiguration that
   just 'happened to work' under 2.4
 
 
 drivers/scsi/
 ~~~~~~~~~~~~~
 
-o Half of SCSI doesn't compile
+o qlogic follies:
+
+  - jejb: Merge the feral driver.  It covers all qlogic chips: 1020 all
+    the way up to 23xxx.  mjacob is promising a "major" rewrite which
+    eliminates this as a candidate for immediate inclusion.  Panics on my
+    parisc hardware, works on my ia64.  BK tree is
+    http://linux-scsi.bkbits.net/scsi-isp-2.5
+
+  - qla2xxx: only for FC chips.  Has significant build issues.  hch
+    promises to send me a "must fix" list for this.  I plan not to merge this
+    until I at least see how Qlogic responds to the issues.  Can't currently
+    build this for my only fibre card (a qla2100).  BK tree is at
+    http://linux-scsi.bkbits.net/scsi-qla2xxx-2.5
+
+  - I think the best plan currently is not to merge either of these, but
+    keep shadow BK trees for them (thus holding out the possibility of
+    merger) to see how they evolve.  I agree with hch that feral seems to be
+    in the better shape but, barring directions to the contrary, I can't see
+    why both shouldn't be included eventually.
 
 arch/i386/
 ~~~~~~~~~~
 
+o Also PC9800 merge needs finishing to the point we want for 2.6 (not all).
+
+o ES7000 wants merging (now we are all happy with it).  That shouldn't be a
+  big problem.
+
+o davej: PAT support (for mtrr exhaustion w/ AGP)
+
 o 2.5.x won't boot on some 440GX
 
   alan: Problem understood now, feasible fix in 2.4/2.4-ac.  (440GX has two
   IRQ routers, we use the $PIR table with the PIIX, but the 440GX doesnt use
   the PIIX for its IRQ routing).  Fall back to BIOS for 440GX works and Intel
   concurs.
 
 o 2.5.x doesn't handle VIA APIC right yet.
 
   1. We must write the PCI_INTERRUPT_LINE
 
   2. We have quirk handlers that seem to trash it.
 
 o ACPI needs the relax patches merging to work on lots of laptops
 
-o ECC driver questions are not yet sorted (DaveJ is working on this)
-
-o PC9800 is not fully merged - most of this I think is 2.7 stuff but a few
-  bits might be 2.6 candidate
+o ECC driver questions are not yet sorted (DaveJ is working on this) (Dan
+  Hollis)
 
 arch/x86_64/
 ~~~~~~~~~~~~
 
   (Andi)
 
 o time handling is broken. Need to move up 2.4 time.c code.
 
 o Another report of a crash at shutdown on Simics with no iommu when all
   memory was used.  Could be related to the one above.
 
 o NMI watchdog seems to tick too fast
 
-o some fixes from 2.4 still need to be merged
-
 o not very well tested. probably more bugs lurking.
 
-o 32bit vsyscalls seem to be broken
-
-o 32bit elf coredumps are broken
-
 o need to coredump 64bit vsyscall code with dwarf2
 
 o move 64bit signal trampolines into vsyscall code and add dwarf2 for it.
 
 o describe kernel assembly with dwarf2 annotations for kgdb (currently
   waiting on some binutils changes for this) 
 
 arch/alpha/
 ~~~~~~~~~~~
 
@@ -855,10 +935,12 @@
   Haven't even looked into this at all.  This could be messy since there
   isn't an ARM architecture standard.  I'm presently hoping that it won't be
   an issue.  If it does, I guess we'll see drivers/char/keyboard.c explode.
 
 arch/others/
 ~~~~~~~~~~~~
 
 o SH/SH-64 need resyncing, as do some other ports.  No impact on
   mainstream platforms hopefully.
 
+o IA64 needs merging, has impact on core code
+

