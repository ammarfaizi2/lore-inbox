Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTE3Xa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 19:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTE3Xa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 19:30:26 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:13052 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264066AbTE3X2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 19:28:32 -0400
Date: Fri, 30 May 2003 16:39:07 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: must-fix, version 6
Message-Id: <20030530163907.27f11b86.akpm@digeo.com>
In-Reply-To: <20030530163720.399a8bac.akpm@digeo.com>
References: <20030530163720.399a8bac.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2003 23:41:52.0600 (UTC) FILETIME=[0BFDAD80:01C32705]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The should-fix list, version 6.


Not-ready features and speedups
===============================

Legend:

PRI1:	We're totally lame if this doesn't get in
PRI2:	Would be nice
PRI3:	Not very important

drivers/block/
~~~~~~~~~~~~~~

o Framework for selecting IO schedulers.  This is the main one really. 
  Once this is in place we can drop in new schedulers any old time, no risk.

  PRI1

o Anticipatory scheduler.  Working OK now, still has problems with seeky
  OLTP-style loads.

  PRI1

o CFQ scheduler.  Seems to work but Jens planning significant rework.

  PRI2

o cryptoloop: jmorris: There's no cryptoloop in the 2.4 mainline kernel,
  but I think every distro ships some version.  It would probably be useful
  to have crypto natively supported in 2.6, with backward compatibility for
  the majority of 2.4 users.

  problem: lack of a loop maintainer

  PRI2

o viro: paride drivers need a big cleanup

  PRI2

drivers/char/rtc/
~~~~~~~~~~~~~~~~~

o rmk, trini: add support for alarms to the existing generic rtc driver.

  PRI2

device mapper
~~~~~~~~~~~~~

o ioctl interface cleanup patch is ready (redo the structure layouts)

  PRI1

o A port of the 2.4 snapshot target is in progress

  PRI1

o the fs interface to dm needs to be redone.  gregkh was going to work on
  this.  viro is interested in seeing work thus-far.

  PRI2

drivers/net/wireless/
~~~~~~~~~~~~~~~~~~~~~

  (Jean Tourrilhes <jt@bougret.hpl.hp.com>)

o get latest orinoco changes from David.

  PRI1

o get the latest airo.c fixes from CVS.  This will hopefully fix problems
  people have reported on the LKML.

  PRI1

o get HostAP driver in the kernel.  No consolidation of the 802.11
  management across driver can happen until this one is in (which is probably
  2.7.X material).  I think Jouni is mostly ready but didn't find time for
  it.

  PRI2

o get more wireless drivers into the kernel.  The most "integrable" drivers
  at this point seem the NWN driver, Pavel's Spectrum driver and the Atmel
  driver.

  PRI1

o The last two drivers mentioned above are held up by firmware issues (see
  flamewar on LKML a few days ago).  So maybe fixing those firmware issues
  should be a requirement for 2.6.X, because we can expect more wireless
  devices to need firmware upload at startup coming to market.

  (in progress?)

  PRI1

drivers/usb/gadget/
~~~~~~~~~~~~~~~~~~~

o rmk: SA11xx USB client/gadget code (David B has been doing some work on
  this, and keeps trying to prod me, but unfortunately I haven't had the time
  to look at his work, sorry David.)

  PRI3

fs/
~~~

o ext3 lock_kernel() removal: that part works OK and is mergeable.  But
  we'll also need to make lock_journal() a spinlock, and that's deep surgery.

  Patches exist in -mm.

  PRI1

o ext3 and ext2 block allocators have serious failure modes - interleaved
  allocations.

  PRI3

o 32bit quota needs a lot more testing but may work now

  PRI2

o Integrate Chris Mason's 2.4 reiserfs ordered data and data journaling
  patches.  They make reiserfs a lot safer.

  Ordered: PRI2
  data journalled: PRI3

o (Trond:) Yes: I'm still working on an atomic "open()", i.e.  one
           where we short-circuit the usual VFS path_walk() + lookup() +
           permission() + create() + ....  bullsh*t...

           I have several reasons for wanting to do this (all of
           them related to NFS of course, but much of the reasoning applies
           to *all* networked file systems).

   1) The above sequence is simply not atomic on *any* networked
      filesystem.

   2) It introduces a sh*tload of completely unnecessary RPC calls (why
      do a 'permission' RPC call when the server is in *any* case going to
      tell you whether or not this operations is allowed.  Why do a
      'lookup()' when the 'create()' call can be made to tell you whether or
      not a file already exists).

   3) It is incompatible with some operations: the current create()
      doesn't pass an 'EXCLUSIVE' flag down to the filesystems.

   4) (NFS specific?) open() has very different cache consistency
      requirements when compared to most other VFS operations.

   I'd very much like for something like Peter Braam's 'lookup with
   intent' or (better yet) for a proper dentry->open() to be integrated with
   path_walk()/open_namei().  I'm still working on the latter (Peter has
   already completed the lookup with intent stuff).

   PRI2 (?)

o (Chuck Lever <cel@citi.umich.edu>): NFS O_DIRECT support must be
  completed.  The best approach is to fall back to something like the 2.4 NFS
  O_DIRECT support, which issues RPCs synchronously and uses the RPC
  completion mechanism to wait for I/O completion.

  PRI2

o rmk: update acorn partition parsing code - making all acorn schemes
  appear in check.c so we don't have to duplicate the scanning of multiple
  types, and adding support for eesox partitions.

  PRI2

o atomic i_size patches

  PRI1

o viro: cleaning up options-parsers in filesystems.  (patch exists, needs
  porting).

  PRI2

o aio: fs IO isn't async at present.  suparna has restart patches, they're
  in -mm.  Need to get Ben to review/comment.

  PRI1.

kernel/
~~~~~~~

o rusty: Zippel's Reference count simplification.  Tricky code, but cuts
  about 120 lines from module.c.  Patch exists, needs stressing.

  PRI3

o rusty: /proc/kallsyms.  What most people really wanted from /proc/ksyms. 
  Patch exists.

  PRI3

o rusty: Fix module-failed-init races by starting module "disabled".  Patch
  exists, requires some subsystems (ie.  add_partition) to explicitly say
  "make module live now".  Without patch we are no worse off than 2.4 etc.  

  PRI1

o Integrate userspace irq balancing daemon.

  PRI2

o kexec.  Seems to work, was in -mm.

  PRI3

o rmk: modules / /proc/kcore / vmalloc This needs sorting and testing to
  ensure that stuff like gdb vmlinux /proc/kcore works as expected.  I
  believe this is the only show stopper preventing any ARM platform being
  built in Linus' kernel.

  Patch exists in -mm, nobody has tested it for the above afaik.

  PRI1

o kcore is a problem for ia64 (Tony Luck)

  Patch exists in -mm.

  PRI1

o rmk: lib/inflate.c must not use static variables (causes these to be
  referenced via GOTOFF relocations in PIC decompressor.  We have a PIC
  decompressor to avoid having to hard code a per platform zImage link
  address into the makefiles.)

  PRI2

o klibc merge?

  PRI2

mm/
~~~

o objrmap: concerns over page reclaim performance at high sharing levels,
  and interoperation with nonlinear mappings is hairy.

o Reintroduce and make /proc/sys/vm/freepages writable again so that boxes
  can be tuned for heavy interrupt load.

  Patch exists in -mm.

  PRI1

o oxymoron's async write-error-handling patch

  PRI1

o dropbehind for large files

  PRI2

net/
~~~~

  (davem)

o Real serious use of IPSEC is hampered by lack of MPLS support.  MPLS is a
  switching technology that works by switching based upon fixed length labels
  prepended to packets.  Many people use this and IPSEC to implement VPNs
  over public networks, it is also used for things like traffic engineering.

  A good reference site is:

	http://www.mplsrc.com/

  Anyways, an existing (crappy) implementation exists.  I've almost
  completed a rewrite, I should have something in the tree next week.

  PRI1

o Sometimes we generate IP fragments when it truly isn't necessary.

  The way IP fragmentation is specified, each fragment must be modulo 8
  bytes in length.  So suppose the device has an MTU that is not 0 modulo 8,
  ethernet even classifies in this way.  1500 == (8 * 187) + 4

  Our IP fragmenting engine can fragment on packets that are sized within
  the last modulo 8 bytes of the MTU.  This happens in obscure cases, but it
  does happen.

  I've proposed a fix to Alexey, whereby very late in the output path we
  check the packet, if we fragmented but the data length would fit into the
  MTU we unfragment the packet.

  This is low priority, because technically it creates suboptimal behavior
  rather than mis-operation.

  PRI1

net/*/netfilter/
~~~~~~~~~~~~~~~~

o Lots of misc. cleanups, which are happening slowly.

  PRI2

o davem: Netfilter needs to stop linearizing packets as much as possible.

  Zerocopy output packets are basically undone by netfilter becuase all of
  it assumed it was working with linear socket buffers.

  Rusty is fixing this piece by piece.  He is nearly done with this work. 

  PRI1

power management
~~~~~~~~~~~~~~~~

  (Pat) There is some preliminary work at bk://ldm.bkbits.net/linux-2.5-power,
  though I'm currently in the process of reworking it.  

  It includes: 

o New device power management core code, both for individual devices, 
  and for global state transitions. 

  PRI1

o A generic user interface for triggering system power state transitions.

  PRI1

o Arch-independent code for performing state transitions, that calls 
  platform-specific methods along the way. 

  PRI1

o A better suspend-to-disk mechanism than swsusp. 

  There are various other details to be worked out, which are the real fun
  part.  And of course, driver support, but that is something that can happen
  at any time.  

  (Alan)

  PRI2

o Frame buffer restore codepaths (that requires some deep PCI magic)

  PRI2

o XFree86 hooks

  PRI2

o AGP restoration

  PRI2

o DRI restoration

  (davej/Alan: not super-critical, can crash laptop on restore.  davej
  looking into it.)

  PRI2

o IDE suspend/resume without races (Ben is looking at this a little)

  PRI2

o Pat: There are already CPU device structures; MTRRs should be a
  dynamically registered interface of CPUs, which implies there needs
  to be some other glue to know that there are MTRRs that need to be
  saved/restored.

  PRI1

global
~~~~~~

o 64-bit dev_t.  Seems almost ready, but it's not really known how much
  work is still to do.  Patches exist in -mm but with the recent rise of the
  neo-viro I'm not sure where things are at.

  PRI1

o We need a kernel side API for reporting error events to userspace (could
  be async to 2.6 itself)

  (Prototype core based on netlink exists)

  PRI2

o Kai: Introduce a sane, easy and standard way to build external modules

  PRI2

o Kai: Allow separate src/objdir

  PRI2

o general confusion over firmware policy:

  o do we mandate that it be uploaded from userspace?

  o Is binary-blob-in-kernel-image OK?

  o Each driver (wireless, scsi, etc) seems to do it in a different,
    private manner.

  gregkh: patch exists, drivers can be ported to use new infrastructure at
  any time.

  PRI1

o larger cpumask_t - supporting more than BITS_PER_LONG CPUs.

  wli: patch exists.  ia32, ppc are done.  ppc64 in progress.  Needs work
  for other architectures.

  PRI1

o pavel: ioctl32 emulation should be shared across architectures.  (patch
  exists).

  PRI2

drivers
~~~~~~~

o Alan: Cardbus/PCMCIA requires all Russell's stuff is merged to do
  multiheader right and so on

  PRI1

drivers/acpi/
~~~~~~~~~~~~~

o alan: VIA APIC stuff is one bit of this, there are also some other
  reports that were caused by ACPI not setting level v edge trigger some
  times

  PRI1

o mochel: it seems the acpi irq routing code could use a serious rewrite.

  grover: The problem is the ACPI irq routing code is trying to piggyback
  on the existing MPS-specific data structures, and it's generally a hack. 
  So yes mochel is right, but it is also purging MPS-ities from common code
  as well.  I've done some preliminary work in this area and it doesn't seem
  to break anything (yet) but a rewrite in this area imho should not be
  rushed out the door.  And, I think the above bugs can be fixed w/o the
  rewrite.

  PRI2

o mochel: ACPI suspend doesn't work.  Important, not cricital.  Pat is
  working it.

  PRI2

drivers/block/
~~~~~~~~~~~~~~

o Floppy is almost unusably buggy still

  akpm: we need more people to test & report.

  alan: "Floppy has worked for me since the patches that went in 2.5.69-ac
  and I think -bk somewhere"

  PRI1

drivers/char/
~~~~~~~~~~~~~

o Alan: Multiple serious bugs in the DRI drivers (most now with patches
  thankfully).  "The badness I know about is almost entirely IRQ mishandling.
   DRI failing to mask PCI irqs on exit paths."

  (This is understood and fixed in DRI CVS)

  PRI1

o Various suspect things in AGP.

  PRI1

drivers/ide/
~~~~~~~~~~~~

  (Alan)

o IDE requires bio walking

  "Bartlomiej has IDE multisector working" (does that mean it's fixed?)

  PRI1

o IDE PIO has occasional unexplained PIO disk eating reports

  PRI1

o IDE has multiple zillions of races/hangs in 2.5 still

  PRI1

o IDE scsi needs rewriting

  PRI2

o IDE needs significant reworking to handle Simplex right

  PRI2

o IDE hotplug handling for 2.5 is completely broken still

  PRI2

o There are lots of other IDE bugs that wont go away until the taskfile
  stuff is included, the locking bugs that allow any user to hang the IDE
  layer in 2.5, and some other updates are forward ported.  (esp.  HPT372N).

  PRI1

drivers/isdn/
~~~~~~~~~~~~~

  (Kai, rmk)

o isdn_tty locking is completely broken (cli() and friends)

  PRI2

o fix lots of remaining bugs in the isdn link layer / hisax protocol layer
  / hisax subdrivers, so that at least 99% of the users have a usable ISDN
  subsystem

  PRI1

o fix other drivers

  PRI2

o lots more cleanups, adaption to recent APIs etc

  PRI3

o fixup tty-based ISDN drivers which provide TIOCM* ioctls (see my recent
  3-set patch for serial stuff)

  Alternatively, we could re-introduce the fallback to driver ioctl parsing
  for these if not enough drivers get updated.

  PRI3

drivers/net/
~~~~~~~~~~~~

o davej: Either Wireless network drivers or PCMCIA broke somewhen.  A
  configuration that worked fine under 2.4 doesn't receive any packets.  Need
  to look into this more to make sure I don't have any misconfiguration that
  just 'happened to work' under 2.4

  PRI1

drivers/scsi/
~~~~~~~~~~~~~

o qlogic follies:

  - jejb: Merge the feral driver.  It covers all qlogic chips: 1020 all
    the way up to 23xxx.  mjacob is promising a "major" rewrite which
    eliminates this as a candidate for immediate inclusion.  Panics on my
    parisc hardware, works on my ia64.  BK tree is
    http://linux-scsi.bkbits.net/scsi-isp-2.5

  - qla2xxx: only for FC chips.  Has significant build issues.  hch
    promises to send me a "must fix" list for this.  I plan not to merge this
    until I at least see how Qlogic responds to the issues.  Can't currently
    build this for my only fibre card (a qla2100).  BK tree is at
    http://linux-scsi.bkbits.net/scsi-qla2xxx-2.5

  - I think the best plan currently is not to merge either of these, but
    keep shadow BK trees for them (thus holding out the possibility of
    merger) to see how they evolve.  I agree with hch that feral seems to be
    in the better shape but, barring directions to the contrary, I can't see
    why both shouldn't be included eventually.

  PRI2

arch/i386/
~~~~~~~~~~

o Also PC9800 merge needs finishing to the point we want for 2.6 (not all).

  PRI3

o ES7000 wants merging (now we are all happy with it).  That shouldn't be a
  big problem.

  PRI2

o davej: PAT support (for mtrr exhaustion w/ AGP)

  PRI2

o 2.5.x won't boot on some 440GX

  alan: Problem understood now, feasible fix in 2.4/2.4-ac.  (440GX has two
  IRQ routers, we use the $PIR table with the PIIX, but the 440GX doesnt use
  the PIIX for its IRQ routing).  Fall back to BIOS for 440GX works and Intel
  concurs.

  PRI1

o 2.5.x doesn't handle VIA APIC right yet.

  1. We must write the PCI_INTERRUPT_LINE

  2. We have quirk handlers that seem to trash it.

  PRI1

o ACPI needs the relax patches merging to work on lots of laptops

  alan: ACPI relax stuff is in 2.4-ac, compaq workaround is in next -ac
  coming.  These seem to deliver the goods - toshibas now work a treat.  Some
  other relax bits are being discussed (assume local0 starts 0 etc) and
  progress looks great.  This can occur before 2.6 or during.

  PRI1

o ECC driver questions are not yet sorted (DaveJ is working on this) (Dan
  Hollis)

  alan: ECC - I have some test bits from Dan's stuff - they need no kernel
  core changes for most platforms.  That means we can treat it as a random
  driver merge.

  PRI3

o alan: 2.4 has some fixes for tsc handling bugs.  One where some bioses in
  SMM mode mess up our toggle on the time high/low or mangle the counter and
  one where a few chips need religious use of _p for timer access and we
  don't do that.  This is forward porting little bits of fixup.

  ACPI HZ stuff we can't trap - a lot of ACPI is implemented as outb's
  triggering SMM traps

  PRI1

arch/x86_64/
~~~~~~~~~~~~

  (Andi)

o time handling is broken. Need to move up 2.4 time.c code.

  PRI1

o Another report of a crash at shutdown on Simics with no iommu when all
  memory was used.  Could be related to the one above.

  PRI1

o NMI watchdog seems to tick too fast

  PRI2

o not very well tested. probably more bugs lurking.

  PRI1

o need to coredump 64bit vsyscall code with dwarf2

  PRI2

o move 64bit signal trampolines into vsyscall code and add dwarf2 for it.

  PRI1

o describe kernel assembly with dwarf2 annotations for kgdb (currently
  waiting on some binutils changes for this) 

  PRI3

arch/alpha/
~~~~~~~~~~~

o rth: Ptrace writes are broken.  This means we can't (reliably) set
  breakpoints or modify variables from gdb.

  PRI1

arch/arm/
~~~~~~~~~

o rmk: missing raw keyboard translation tables for all ARM machines. 
  Haven't even looked into this at all.  This could be messy since there
  isn't an ARM architecture standard.  I'm presently hoping that it won't be
  an issue.  If it does, I guess we'll see drivers/char/keyboard.c explode.

  PRI2

arch/others/
~~~~~~~~~~~~

o SH/SH-64 need resyncing, as do some other ports.  No impact on
  mainstream platforms hopefully.

  PRI2

o IA64 needs merging, has impact on core code

  PRI1

arch/s390/
~~~~~~~~~

o A nastly memory management problem causes random crashes.  These appear
  to be fixed/hidden by the objrmap patch, more investigation is needed.

  PRI1

drivers/s390/
~~~~~~~~~~~~~

o Early userspace and 64 bit dev_t will allow the removal of most of
  dasd_devmap.c and dasd_genhd.c.

  PRI2

o The 3270 console driver needs to be replaced with a working one
  (prototype is there, needs to be finished).

  PRI2

o Minor interface changes are pending in cio/ when the z990 machines are
  out.

  There are some more things being worked on that are either post-2.6.0 or
  are likely to remain outside of the official kernel (i.e.  not for your
  list):

  PRI3

o Jan Glauber is working on a fix for the timer issues related to running
  on virtualized CPUs (wall-clock vs.  cpu time).

  PRI1

o new zfcp fibre channel driver

  PRI3

o the qeth driver will become GPL soon

  PRI3

o a block device driver for ramdisks shared among virtual machines

  PRI3

o driver for crypto hardware

  PRI2

o 'claw' network device driver

  PRI3


