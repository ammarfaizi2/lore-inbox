Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTENKNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 06:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTENKNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 06:13:18 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:63545 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261631AbTENKNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 06:13:10 -0400
Date: Wed, 14 May 2003 03:27:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6 must-fix list, v3
Message-Id: <20030514032712.0c7fa0d1.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 10:25:52.0590 (UTC) FILETIME=[32327EE0:01C31A03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quite a lot of changes here.  Mostly additions, but some things have been
crossed off.

Also at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix

--- notes/must-fix-1.txt	12 May 2003 22:53:08 -0000	1.10
+++ notes/must-fix-1.txt	14 May 2003 02:33:30 -0000	1.17
@@ -11,7 +11,21 @@
 
   - Other problems: aviro, dipankar, Alan have details.
 
+  - somebody will have to document the tty driver and ldisc API
 
+drivers/char/rtc/
+-----------------
+
+- rmk: I think we need a generic RTC driver (which is backed by real RTCs).
+   Integrator-based stuff has a 32-bit 1Hz counter RTC with alarm, as has the
+  SA11xx, and probably PXA.  There's another implementation for the RiscPC
+  and ARM26 stuff.  I'd rather not see 4 implementations of the RTC userspace
+  API, but one common implementation so that stuff gets done in a consistent
+  way.
+
+  We postponed this at the beginning of 2.4 until 2.5 happened.  We're now
+  at 2.5, and I'm about to add at least one more (the Integrator
+  implementation.) This isn't sane imo.
 
 drivers/block/
 --------------
@@ -58,7 +72,62 @@
   seems to be some cases that don't work too well.  Don't really have a
   handle on those :/
 
-- IDE tcq. Either kill it or fix it. Not a "big todo", as such.
+drivers/input/
+--------------
+
+- rmk: unconverted keyboard/mouse drivers (there's a deadline of 2.6.0
+  currently on these remaining in my/Linus' tree.)
+
+- synaptic touchpad support
+
+drivers/misc/
+-------------
+
+- rmk: UCB1[23]00 drivers, currently sitting in drivers/misc in the ARM
+  tree.  (touchscreen, audio, gpio, type device.)
+
+drivers/net/
+------------
+
+- rmk: network drivers.  ARM people like to add tonnes of #ifdefs into
+  these to customise them to their hardware platform (eg, chip access
+  methods, addresses, etc.) I cope with this by not integrating them into my
+  tree.  The result is that many ARM platforms can't be built from even my
+  tree without extra patches.  This isn't sane, and has bred a culture of
+  network drivers not being submitted.  I don't see this changing for 2.6
+  though.
+
+drivers/net/irda/
+-----------------
+
+- dongle drivers need to be converted to sir-dev
+
+- irport need to be converted to sir-kthread
+
+- new drivers (irtty-sir/smsc-ircc2/donauboe) need more testing
+
+- rmk: Refuse IrDA initialisation if sizeof(structures) is incorrect (I'm
+  not sure if we still need this; I think gcc 2.95.3 on ARM shows this
+  problem though.)
+
+drivers/pci/
+------------
+
+- alan: Some cardbus crashes the system
+
+- alan: Hotplug locking is hosed
+
+drivers/pcmcia/
+---------------
+
+- alan: Most drivers crash the system on eject randomly with timer bugs.  I
+  think after RMK's stuff is in most of the pcmcia/cardbus ones go except the
+  locking disaster.
+
+drivers/pld/
+------------
+
+- rmk: EPXA (ARM platform) PLD hotswap drivers (drivers/pld)
 
 drivers/video/
 --------------
@@ -70,6 +139,8 @@
 
 - hch: large parts of the locking are hosed or not existant
 
+  (Mike Anderson, Patrick Mansfield, Badari Pulavarty)
+
   - shost->my_devices isn't locked down at all
 
   - the host list ist locked but not refcounted, mess can happen when the
@@ -84,32 +155,38 @@
 
   - there's some global variables incremented without any locks
 
+- Convert am53c974, dpt_i2o, initio and pci2220i to DMA-mapping
 
-  (Mike Anderson, Patrick Mansfield, Badari Pulavarty)
+- Make inia100, cpqfc, pci2000 and dc390t compile
 
-  - large parts of the locking are hosed or non existent
+- Convert
 
-    -- shost->my_devices isn't locked at all
+   wd33c99 based: a2091 a3000 gpv11 mvme174 sgiwd93 53c7xx based:
+   amiga7xxx bvme6000 mvme16x initio am53c974 pci2000 pci2220i qla1280
+   sym53c8xx dc390t
 
-    -- host list locked but not refcounted
+  To new error handling
 
-    -- lots of members of struct scsi_host/scsi_device/ scsi_cmd with
-       very unclear locking
+  I think the sym53c8xx could probably be pulled out of the tree because
+  the sym_2 replaces it.  I'm also looking at converting the qla1280.
 
-    -- lots of volatile abuse in scsi code
+  It also might be possible to shift the 53c7xx based drivers over to
+  53c700 which does the new EH stuff, but I don't have the hardware to check
+  such a shift.
 
-    -- global variables incremented without locks.
+  For the non-compiling stuff, I've probably missed a few that just aren't
+  compilable on my platforms, so any updates would be welcome.  Also, are
+  some of our non-compiling or unconverted drivers obsolete?
 
-fs/
----
-
-- NFS client gets an OOM deadlock.
+drivers/usb/gadget/
+-------------------
 
-  - Some fixes exist in -mm.  Seem to mostly work.
+- rmk: SA11xx USB client/gadget code (David B has been doing some work on
+  this, and keeps trying to prod me, but unfortunately I haven't had the time
+  to look at his work, sorry David.)
 
-- NFS client runs very slowly consuming 100% CPU under heavy writeout.
-
-  - Unsubtle fix exists in -mm.  (Looks like it's fixed anyway).
+fs/
+---
 
 - ext3 data=journal mode is bust.
 
@@ -119,13 +196,6 @@
 
   - Easy fix is to only allow the feature for S_ISBLK files.
 
-- davej: NFS seems to have a really bad time for some people.  (Including
-  myself on one testbox).  The common factor seems to be a high spec client
-  torturing an underpowered NFS server with lots of IO.  (fsx/fsstress etc
-  show this up).  Lots of "NFS server cheating" messages get dumped, and a
-  whole lot of bogus packets start appearing.  They look severely corrupted,
-  (they even crashed ethereal once 8-)
-
 - hch: devfs: there's a fundamental lookup vs devfsd race that's only
   fixable by introducing a lookup vs devfs deadlock.  I can't see how this is
   fixable without getting rid of the current devfsd design.  Mandrake seems
@@ -147,7 +217,9 @@
 
 - Alan: 32bit uid support is *still* broken for process accounting.
 
-  (Test case?)
+  Create a 32bit uid, turn accounting on.  Shock horror it doesn't work
+  because the field is 16bit.  We need an acct structure flag day for 2.6
+  IMHO
 
 mm/
 ---
@@ -175,8 +247,13 @@
 
 - Per-cpu support inside modules (have patch, in testing).
 
-- driver class code is getting redone.  I have this now working, and will
-  send it out in a few days.
+- shemminger: The module remove rework that Rusty and Dave are working on
+  needs to be fixed before 2.6.  Right now, it is impossible to write a
+  protocol or network device that can be safely unloaded when it is a module.
+
+  See:
+        http://pizda.ninka.net/~davem/modules.html
+
 
 net/
 ----
@@ -219,7 +296,6 @@
   Someone has to get a good log in order for us to effectively debug this.
 
 
-
 net/*/netfilter/
 ----------------
 
@@ -231,6 +307,19 @@
 
 - Module relationship bogosity fix (trivial, have patch).
 
+sound/
+------
+
+- rmk: several OSS drivers for SA11xx-based hardware in need of
+  ALSA-ification and L3 bus support code for these.
+
+- rmk: linux/sound/drivers/mpu401/mpu401.c and
+  linux/sound/drivers/virmidi.c complained about 'errno' at some time in the
+  past, need to confirm whether this is still a problem.
+
+- rmk: need to complete ALSA-ification of the WaveArtist driver for both
+  NetWinder and other stuff (there's some fairly fundamental differences in
+  the way the mixer needs to be handled for the NetWinder.)
 
 global
 ------
@@ -255,8 +344,6 @@
 - Framework for selecting IO schedulers.  This is the main one really. 
   Once this is in place we can drop in new schedulers any old time, no risk.
 
-- Dynamic disk request allocation.  Patch exists.
-
 - Runtime-selectable disk scheduler framework.
 
 - Anticipatory scheduler.  Working OK now, still has problems with seeky
@@ -309,6 +396,10 @@
    path_walk()/open_namei().  I'm still working on the latter (Peter has
    already completed the lookup with intent stuff).
 
+- rmk: update acorn partition parsing code - making all acorn schemes
+  appear in check.c so we don't have to duplicate the scanning of multiple
+  types, and adding support for eesox partitions.
+
 
 kernel/
 -------
@@ -329,6 +420,16 @@
 
 - kexec.  Seems to work, is in -mm.
 
+- rmk: modules / /proc/kcore / vmalloc This needs sorting and testing to
+  ensure that stuff like gdb vmlinux /proc/kcore works as expected.  I
+  believe this is the only show stopper preventing any ARM platform being
+  built in Linus' kernel.
+
+- rmk: lib/inflate.c must not use static variables (causes these to be
+  referenced via GOTOFF relocations in PIC decompressor.  We have a PIC
+  decompressor to avoid having to hard code a per platform zImage link
+  address into the makefiles.)
+
 mm/
 ---
 
@@ -372,14 +473,6 @@
   This is low priority, because technically it creates suboptimal behavior
   rather than mis-operation.
 
-- IPV4 output engine changes for IPSEC need to be moved over to IPV6.
-
-  IPV6 ipsec works but gravely suboptimally in some cases.  It is also for
-  this reason that the zerocopy UDP stuff isn't functional on the ipv6 side.
-
-  The USAGI project (www.linux-ipv6.org) is working with Alexey on this
-  work.
-
 net/*/netfilter/
 ----------------
 
@@ -474,15 +567,12 @@
 drivers
 =======
 
-- Alan: PCI random reordering from 2.4 to 2.5 isnt understood yet (might be
-  fixed now?)
-
 - Alan: We have multiple drivers walking the pci device lists and also
   using things like pci_find_device in unsafe ways with no refcounting.  I
   think we have to make pci_find_device etc refcount somewhere and add
   pci_device_put as was done with networking.
 
-- Lots of network drivers don't even build
+- Some network drivers don't even build
 
 - Alan: PCI hotplug is unsafe (locking is totally screwed)
 
@@ -499,17 +589,16 @@
   "network card doesn't recieve packets" booting with 'acpi=off noapic' fixes
   it.
 
+  alan: VIA APIC stuff is one bit of this, there are also some other
+  reports that were caused by ACPI not setting level v edge trigger some
+  times
+
 - davej: There's also another nasty 'doesnt boot' bug which quite a few
   people (myself included) are seeing on some boxes (especially laptops).
 
 drivers/block/
 --------------
 
-- Alan: Partition handling is hosed for DM users.  (I have some partly
-  debugged patches in the -ac tree, but Andries objects to them and I think
-  his user knows magic options hack is unacceptable too.  Mostly this is
-  figuring out the right answer)
-
 - Floppy is almost unusably buggy still
 
 drivers/char/
@@ -519,6 +608,8 @@
   thankfully).  "The badness I know about is almost entirely IRQ mishandling.
    DRI failing to mask PCI irqs on exit paths."
 
+  (might be fixed due to DRI updates?)
+
 - Various suspect things in AGP.
 
 drivers/ide/
@@ -528,18 +619,25 @@
 
 - IDE requires bio walking
 
+  "Bartlomiej has IDE multisector working" (does that mean it's fixed?)
+
+
 - IDE PIO has occasional unexplained PIO disk eating reports
 
 - IDE has multiple zillions of races/hangs in 2.5 still
 
-- IDE eats disks with HPT372N on 2.5.x
-
 - IDE scsi needs rewriting
 
 - IDE needs significant reworking to handle Simplex right
 
 - IDE hotplug handling for 2.5 is completely broken still
 
+- IDE tcq. Either kill it or fix it. Not a "big todo", as such.
+
+- There are lots of other IDE bugs that wont go away until the taskfile
+  stuff is included, the locking bugs that allow any user to hang the IDE
+  layer in 2.5, and some other updates are forward ported.  (esp.  HPT372N).
+
 drivers/isdn/
 -------------
 
@@ -561,9 +659,6 @@
   Alternatively, we could re-introduce the fallback to driver ioctl parsing
   for these if not enough drivers get updated.
 
-- fixup the usb-serial core and drivers to provide support for this
-  patch.
-
 drivers/net/
 ------------
 
@@ -583,12 +678,24 @@
 
 - 2.5.x won't boot on some 440GX
 
-- 2.5.x doesn't handle VIA APIC right yet - dont know why
+  alan: Problem understood now, feasible fix in 2.4/2.4-ac.  (440GX has two
+  IRQ routers, we use the $PIR table with the PIIX, but the 440GX doesnt use
+  the PIIX for its IRQ routing).  Fall back to BIOS for 440GX works and Intel
+  concurs.
+
+- 2.5.x doesn't handle VIA APIC right yet.
+
+  1. We must write the PCI_INTERRUPT_LINE
+
+  2. We have quirk handlers that seem to trash it.
 
 - ACPI needs the relax patches merging to work on lots of laptops
 
 - ECC driver questions are not yet sorted (DaveJ is working on this)
 
+- PC9800 is not fully merged - most of this I think is 2.7 stuff but a few
+  bits might be 2.6 candidate
+
 arch/x86_64/
 ------------
 
@@ -596,19 +703,37 @@
 
 - time handling is broken. Need to move up 2.4 time.c code.
 
-- memory corruption with IOMMU pci_free_consistent - often causes crashes
-  at shutdown.  This is rather mysterious, the code is basically identical to
-  2.4 which works fine.  Can only be seen on systems with >4GB of memory or
-  with iommu=force
-
 - Another report of a crash at shutdown on Simics with no iommu when all
   memory was used.  Could be related to the one above.
 
-- change_page_attr corrupts memory/crashes. Breaks some AGP users.
-
 - NMI watchdog seems to tick too fast
 
 - some fixes from 2.4 still need to be merged
 
 - not very well tested. probably more bugs lurking.
+
+- 32bit vsyscalls seem to be broken
+
+- 32bit elf coredumps are broken
+
+- need to coredump 64bit vsyscall code with dwarf2
+
+- move 64bit signal trampolines into vsyscall code and add dwarf2 for it.
+
+- describe kernel assembly with dwarf2 annotations for kgdb (currently
+  waiting on some binutils changes for this) 
+
+arch/arm/
+---------
+
+- rmk: missing raw keyboard translation tables for all ARM machines. 
+  Haven't even looked into this at all.  This could be messy since there
+  isn't an ARM architecture standard.  I'm presently hoping that it won't be
+  an issue.  If it does, I guess we'll see drivers/char/keyboard.c explode.
+
+arch/others/
+------------
+
+- SH3/SH3-64 need resyncing, as do some other ports.  No impact on
+  mainstream platforms hopefully.
 


