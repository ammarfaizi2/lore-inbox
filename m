Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264607AbTEPXKj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264616AbTEPXKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:10:39 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:4574 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264607AbTEPXJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:09:53 -0400
Date: Fri, 16 May 2003 16:17:53 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix, v4
Message-Id: <20030516161753.08470617.akpm@digeo.com>
In-Reply-To: <20030516161717.1e629364.akpm@digeo.com>
References: <20030516161717.1e629364.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2003 23:22:41.0059 (UTC) FILETIME=[0BD5F730:01C31C02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The whole thing:


Must-fix bugs
=============

drivers/char/
-------------

- TTY locking is broken.

  - see FIXME in do_tty_hangup().  This causes ppp BUGs in local_bh_enable()

  - Other problems: aviro, dipankar, Alan have details.

  - somebody will have to document the tty driver and ldisc API

- Lack of test cases and/or stress tests is a problem.  Contributions and
  suggestions are sought.

- Lots of drivers are using cli/sti and are broken.

drivers/tty
-----------

- viro: we need to fix refcounting for tty_driver (oopsable race, must fix
  anyway, hopefully about a week until it's merged) then we can do
  tty/misc/upper levels of sound and hopefully upper level of USB.

  USB is a place where we _really_ need to deal with dynamic allocation of
  device numbers and that will bite.

drivers/block/
--------------

- RAID0 dies on strangely aligned BIOs

  - Need to hoist BIO-split code out of device mapper, use that.

    arjan: "if we add that function, we must be sure that it can split on
    not-a-page boundaries too otherwise it's useless for a bunch of things"

 (neilb)

 1/ RAID5 should work fine.  It accepts any sort of bio and always
    submits a 1-page bio to the underlying device, and if my
    understanding is correct, every device must be able to handle a
    single page bio, no matter what the alignment (which is why raid0
    has a problem - it doesn't). 

 2/ RAID1 works pretty well.  The only improvement needed is to define
    a merge_bvec_fn function which passes the question down to lower
    layers.  This should be easy except for the small fact that it is
    impossible :-)  There is no enforced pairing between calls to
    merge_bvec_fn and submit_bh, so it is possible that a hot spare
    with different restrictions could get swapped in between the one
    and the other and could confuse things.  I suspect that can be
    worked around somehow though...

       Someone sent me a patch that is sorely needed - it allows you
       to simply call blk_queue_stack() (or somethink like that), and it will
       get your stacked limits set appropriately.

 3/ I just realised that raid0 is easier than I had previously
    thought.  We don't need the completely functional bio splitting
    that dm has.  We only need to be able to split a bio that has just
    one page as the use of merge_bvec_fn will ensure that we never get
    a larger bio that we cannot handle.  And splitting a bio with only
    one page is a lot easier.  I now have code in my tree that
    implements this quite cleanly and will probably post a patch
    during the week.

- ideraid hasn't been ported to 2.5 at all yet.

  We need to understand whether the proposed BIO split code will suffice
  for this.

- CD burning.  There are still a few quirks to solve wrt SG_IO and ide-cd.

  Jens: The basic hang has been solved (double fault in ide-cd), there still
  seems to be some cases that don't work too well.  Don't really have a
  handle on those :/

drivers/input/
--------------

- rmk: unconverted keyboard/mouse drivers (there's a deadline of 2.6.0
  currently on these remaining in my/Linus' tree.)

- viro: large absence of locking.

- synaptic touchpad support

  Apparently there's a userspace `tpconfig'

- andi: also the input keyboard stuff still has unusably obscure config
  options for standard PC hardware.

- viro: parport is nearly as bad as that and there the code is more hairy. 
  IMO parport is more of "figure out what API changes are needed for its
  users, get them done ASAP, then fix generic layer at leisure"

drivers/misc/
-------------

- rmk: UCB1[23]00 drivers, currently sitting in drivers/misc in the ARM
  tree.  (touchscreen, audio, gpio, type device.)

  These need to be moved out of drivers/misc/ and into real places

- viro: actually, misc.c has a good chance to die.  With cdev-cidr that's
  trivial.

drivers/net/
------------

- rmk: network drivers.  ARM people like to add tonnes of #ifdefs into
  these to customise them to their hardware platform (eg, chip access
  methods, addresses, etc.) I cope with this by not integrating them into my
  tree.  The result is that many ARM platforms can't be built from even my
  tree without extra patches.  This isn't sane, and has bred a culture of
  network drivers not being submitted.  I don't see this changing for 2.6
  though.

drivers/net/irda/
-----------------

- dongle drivers need to be converted to sir-dev

- irport need to be converted to sir-kthread

- new drivers (irtty-sir/smsc-ircc2/donauboe) need more testing

- rmk: Refuse IrDA initialisation if sizeof(structures) is incorrect (I'm
  not sure if we still need this; I think gcc 2.95.3 on ARM shows this
  problem though.)

drivers/pci/
------------

- alan: Some cardbus crashes the system

  (bugzilla, please?)

- We have multiple drivers walking the pci device lists and also using
  things like pci_find_device in unsafe ways with no refcounting.  I think
  we have to make pci_find_device etc refcount somewhere and add
  pci_device_put as was done with networking.
  http://bugzilla.kernel.org/show_bug.cgi?id=709

  (gregkh will work on this)

drivers/pcmcia/
---------------

- alan: Most drivers crash the system on eject randomly with timer bugs.  I
  think after RMK's stuff is in most of the pcmcia/cardbus ones go except the
  locking disaster.

  (rmk, brodo: in progress)

drivers/pld/
------------

- rmk: EPXA (ARM platform) PLD hotswap drivers (drivers/pld)

  (rmk: will work out what to do here.  maybe drivers/arm/)

drivers/video/
--------------

- Lots of drivers don't compile, others do but don't work.

drivers/scsi/
-------------

- hch: large parts of the locking are hosed or not existant

  (Mike Anderson, Patrick Mansfield, Badari Pulavarty)

  - shost->my_devices isn't locked down at all

  - the host list ist locked but not refcounted, mess can happen when the
    spinlock is dropped

  - there are lots of members of struct Scsi_Host/scsi_device/scsi_cmnd
    with very unclear locking, many of them probably want to become
    atomic_t's or bitmaps (for the 1bit bitfields).

  - there's lots of volatile abuse in the scsi code that needs to be
    thought about.

  - there's some global variables incremented without any locks

- Convert am53c974, dpt_i2o, initio and pci2220i to DMA-mapping

- Make inia100, cpqfc, pci2000 and dc390t compile

- Convert

   wd33c99 based: a2091 a3000 gpv11 mvme174 sgiwd93 53c7xx based:
   amiga7xxx bvme6000 mvme16x initio am53c974 pci2000 pci2220i qla1280
   sym53c8xx dc390t

  To new error handling

  I think the sym53c8xx could probably be pulled out of the tree because
  the sym_2 replaces it.  I'm also looking at converting the qla1280.

  It also might be possible to shift the 53c7xx based drivers over to
  53c700 which does the new EH stuff, but I don't have the hardware to check
  such a shift.

  For the non-compiling stuff, I've probably missed a few that just aren't
  compilable on my platforms, so any updates would be welcome.  Also, are
  some of our non-compiling or unconverted drivers obsolete?

- rmk: I have a pending todo: I need to put the scsi error handling through
  a workout on my scsi bus from hell to make sure it does the right thing and
  doesn't get wedged.

- qlogic drivers: merge qlogicisp, feral with a view to dropping qlogicfc
  and qlogicisp

- jejb: and merge the qla2xxx too

fs/
---

- ext3 data=journal mode is bust.

- ext3/htree readdir can return "." and ".." in unexpected order, which
  might break buggy userspace apps.  Ted has a fix planned.


- AIO/direct-IO writes can race with truncate and wreck filesystems.

  - Easy fix is to only allow the feature for S_ISBLK files.

- hch: devfs: there's a fundamental lookup vs devfsd race that's only
  fixable by introducing a lookup vs devfs deadlock.  I can't see how this is
  fixable without getting rid of the current devfsd design.  Mandrake seems
  to have a workaround for this so this is at least not triggered so easily,
  but that's not what I'd consider a fix..

- viro: fs/char_dev.c needs removal of aeb stuff and merge of cdev-cidr. 
  In progress.

- forward-port sct's O_DIRECT fixes

- viro: there is some generic stuff for namei/namespace/super, but that's a
  slow-merge and can go in 2.6 just fine

- andi: also soft needs to be fixed - there are quite a lot of
  uninterruptible waits in sunrpc/nfs

kernel/
-------

- O(1) scheduler starvation, poor behaviour seems unresolved.

  Jens: "I've been running 2.5.67-mm3 on my workstation for two days, and
  it still doesn't feel as good as 2.4.  It's not a disaster like some
  revisisons ago, but it still has occasional CPU "stalls" where it feels
  like a process waits for half a second of so for CPU time.  That's is very
  noticable."

   Also see Mike Galbraith's work.

  Conclusion: the scheduler has issues, lots of people working on it.  Rick
  Lindsley, Andrew Theurer.

- drepper: there are at least two big problems with the interaction between
  futex and O(1).  Ingo has already patches.  But we need much more testing
  on big boxes.  Only 4p+ machines have problems

- Alan: 32bit uid support is *still* broken for process accounting.

  Create a 32bit uid, turn accounting on.  Shock horror it doesn't work
  because the field is 16bit.  We need an acct structure flag day for 2.6
  IMHO

  (alan has patch)

- nasty task refcounting bug is taking ages to track down.  (bugzilla ref?)


mm/
---

- Overcommit accounting gets wrong answers

  - underestimates reclaimable slab, gives bogus failures when
    dcache&icache are large.

  - gets confused by reclaimable-but-not-freed truncated ext3 pages. 
    Lame fix exists in -mm.

- Proper user level no overcommit also requires a root margin adding

- There's a vmalloc race.  David Woodhouse has a patch, but it had a
  problem.  Need to revisit it.

- GFP_DMA32 (or something like that).  Lots of ideas.  jejb, zaitcev,
  willy, arjan, wli.

- access_process_vm() doesn't flush right.  We probably need new flushing
  primitives to do this (davem?)


modules
-------

  (Rusty)

- The .modinfo patch needs to go in.  It's trivial, but it's the major
  missing functionality vs. 2.4.  Keeps bouncing off Linus.

- __module_get(): "I know I have a refcount already and I don't care
  if they're doing rmmod --wait, gimme.".  Keeps bouncing off Linus.

- Per-cpu support inside modules (have patch, in testing).

- shemminger: The module remove rework that Rusty and Dave are working on
  needs to be fixed before 2.6.  Right now, it is impossible to write a
  protocol or network device that can be safely unloaded when it is a module.

  See:
        http://www.osdl.org/archive/shemminger/modules.html

  (This is "two stage unload")

net/
----

  (davem)

- UDP apps can in theory deadlock, because the ip_append_data path can end
  up sleeping while the socket lock is held.

  It is OK to sleep with the socket held held, normally.  But in this case
  the sleep happens while waiting for socket memory/space to become
  available, if another context needs to take the socket lock to free up the
  space we could hang.

  I sent a rough patch on how to fix this to Alexey, and he is analyzing
  the situation.  I expect a final fix from him next week or so.

- Semantics for IPSEC during operations such as TCP connect suck currently.

  When we first try to connect to a destination, we may need to ask the
  IPSEC key management daemon to resolve the IPSEC routes for us.  For the
  purposes of what the kernel needs to do, you can think of it like ARP.  We
  can't send the packet out properly until we resolve the path.

  What happens now for IPSEC is basically this:

  O_NONBLOCK: returns -EAGAIN over and over until route is resolved

  !O_NONBLOCK: Sleeps until route is resolved

  These semantics are total crap.  The solution, which Alexey is working
  on, is to allow incomplete routes to exist.  These "incomplete" routes
  merely put the packet onto a "resolution queue", and once the key manager
  does it's thing we finish the output of the packet.  This is precisely how
  ARP works.

  I don't know when Alexey will be done with this.

- There are those mysterious TCP hangs of established state sockets. 
  Someone has to get a good log in order for us to effectively debug this.

net/*/netfilter/
----------------

  (Rusty)

- Handle non-linear skbs everywhere.  This is going in via Dave now.

- Rework conntrack hashing.

- Module relationship bogosity fix (trivial, have patch).

sound/
------

- rmk: several OSS drivers for SA11xx-based hardware in need of
  ALSA-ification and L3 bus support code for these.

- rmk: linux/sound/drivers/mpu401/mpu401.c and
  linux/sound/drivers/virmidi.c complained about 'errno' at some time in the
  past, need to confirm whether this is still a problem.

- rmk: need to complete ALSA-ification of the WaveArtist driver for both
  NetWinder and other stuff (there's some fairly fundamental differences in
  the way the mixer needs to be handled for the NetWinder.)


  (Issues with forward-porting 2.4 bugfixes.)
  (Killing off OSS is 2.7 material)


global
------

- Lots of 2.4 fixes including some security are not in 2.5

- HZ=1000 caused lots of lost timer interrupts.  ACPI or SMM.  (andi,
  jstultz, arjan)

- There are about 60 or 70 security related checks that need doing
  (copy_user etc) from Stanford tools.  (badari is looking into this, and
  hollisb)

- A couple of hundred real looking bugzilla bugs

- viro: cdev rework.  Main group is pretty stable and I hope to feed it to
  Linus RSN.  That's cdev-cidr and ->i_cdev/->i_cindex stuff


Not-ready features and speedups
===============================


drivers/block/
--------------

- Framework for selecting IO schedulers.  This is the main one really. 
  Once this is in place we can drop in new schedulers any old time, no risk.

- Runtime-selectable disk scheduler framework.

- Anticipatory scheduler.  Working OK now, still has problems with seeky
  OLTP-style loads.

- CFQ scheduler.  Seems to work but Jens planning significant rework.

- The feral.com qlogic driver: needs work.

drivers/char/rtc/
-----------------

- rmk: I think we need a generic RTC driver (which is backed by real RTCs).
   Integrator-based stuff has a 32-bit 1Hz counter RTC with alarm, as has the
  SA11xx, and probably PXA.  There's another implementation for the RiscPC
  and ARM26 stuff.  I'd rather not see 4 implementations of the RTC userspace
  API, but one common implementation so that stuff gets done in a consistent
  way.

  We postponed this at the beginning of 2.4 until 2.5 happened.  We're now
  at 2.5, and I'm about to add at least one more (the Integrator
  implementation.) This isn't sane imo.

drivers/net/wireless/
---------------------

  (Jean Tourrilhes <jt@bougret.hpl.hp.com>)

- get latest orinoco changes from David.

- get the latest airo.c fixes from CVS.  This will hopefully fix problems
  people have reported on the LKML.

- get HostAP driver in the kernel.  No consolidation of the 802.11
  management across driver can happen until this one is in (which is probably
  2.7.X material).  I think Jouni is mostly ready but didn't find time for
  it.

- get more wireless drivers into the kernel.  The most "integrable" drivers
  at this point seem the NWN driver, Pavel's Spectrum driver and the Atmel
  driver.

- The last two drivers mentioned above are held up by firmware issues (see
  flamewar on LKML a few days ago).  So maybe fixing those firmware issues
  should be a requirement for 2.6.X, because we can expect more wireless
  devices to need firmware upload at startup coming to market.

drivers/usb/gadget/
-------------------

- rmk: SA11xx USB client/gadget code (David B has been doing some work on
  this, and keeps trying to prod me, but unfortunately I haven't had the time
  to look at his work, sorry David.)

fs/
---

- reiserfs_file_write() speedup.  There are concerns that some applications
  do the wrong thing with large stat.st_blksize.

- ext3 lock_kernel() removal: that part works OK and is mergeable.  But
  we'll also need to make lock_journal() a spinlock, and that's deep surgery.

- 32bit quota needs a lot more testing but may work now

- Integrate Chris Mason's 2.4 reiserfs ordered data and data journaling
  patches.  They make reiserfs a lot safer.

- (Trond:) Yes: I'm still working on an atomic "open()", i.e.  one
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

- rmk: update acorn partition parsing code - making all acorn schemes
  appear in check.c so we don't have to duplicate the scanning of multiple
  types, and adding support for eesox partitions.


kernel/
-------

  (Rusty)

- Zippel's Reference count simplification.  Tricky code, but cuts about 120
  lines from module.c.  Patch exists, needs stressing.

- /proc/kallsyms.  What most people really wanted from /proc/ksyms.  Patch
  exists.

- Fix module-failed-init races by starting module "disabled".  Patch
  exists, requires some subsystems (ie.  add_partition) to explicitly say
  "make module live now".  Without patch we are no worse off than 2.4 etc. 

- Integrate userspace irq balancing daemon.

- kexec.  Seems to work, is in -mm.

- rmk: modules / /proc/kcore / vmalloc This needs sorting and testing to
  ensure that stuff like gdb vmlinux /proc/kcore works as expected.  I
  believe this is the only show stopper preventing any ARM platform being
  built in Linus' kernel.

- rmk: lib/inflate.c must not use static variables (causes these to be
  referenced via GOTOFF relocations in PIC decompressor.  We have a PIC
  decompressor to avoid having to hard code a per platform zImage link
  address into the makefiles.)

mm/
---

- objrmap: concerns over page reclaim performance at high sharing levels,
  and interoperation with nonlinear mappings is hairy.

- Readd and make /proc/sys/vm/freepages writable again so that boxes can be
  tuned for heavy interrupt load.

net/
----

  (davem)

- Real serious use of IPSEC is hampered by lack of MPLS support.  MPLS is a
  switching technology that works by switching based upon fixed length labels
  prepended to packets.  Many people use this and IPSEC to implement VPNs
  over public networks, it is also used for things like traffic engineering.

  A good reference site is:

	http://www.mplsrc.com/

  Anyways, an existing (crappy) implementation exists.  I've almost
  completed a rewrite, I should have something in the tree next week.

- Sometimes we generate IP fragments when it truly isn't necessary.

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

net/*/netfilter/
----------------

- Lots of misc. cleanups, which are happening slowly.

- davem: Netfilter needs to stop linearizing packets as much as possible.

  Zerocopy output packets are basically undone by netfilter becuase all of
  it assumed it was working with linear socket buffers.

  Rusty is fixing this piece by piece.  He is nearly done with this work. 

power management
----------------

  (Pat) There is some preliminary work at bk://ldm.bkbits.net/linux-2.5-power,
  though I'm currently in the process of reworking it.  

  It includes: 

- New device power management core code, both for individual devices, 
  and for global state transitions. 

- A generic user interface for triggering system power state transitions.

- Arch-independent code for performing state transitions, that calls 
  platform-specific methods along the way. 

- A better suspend-to-disk mechanism than swsusp. 

  There are various other details to be worked out, which are the real fun
  part.  And of course, driver support, but that is something that can happen
  at any time.  

  (Alan)

- PCI locking

- Frame buffer restore codepaths (that requires some deep PCI magic)

- XFree86 hooks

- AGP restoration

- DRI restoration

- IDE suspend/resume without races (Ben is looking at this a little)

- How to deal with devices that babble (some stuff we have to global IRQ
  off to save, and global IRQ on -after- we recover with APM)

- Pat's swsusp rework?

- Pat: There are already CPU device structures; MTRRs should be a
  dynamically registered interface of CPUs, which implies there needs
  to be some other glue to know that there are MTRRs that need to be
  saved/restored.

arch/i386/
----------

- Also PC9800 merge needs finishing to the point we want for 2.6 (not all).

- ES7000 wants merging (now we are all happy with it).  That shouldn't be a
  big problem.

global
------

- 64-bit dev_t.  Seems almost ready, but it's not really known how much
  work is still to do.  Patches exist in -mm but with the recent rise of the
  neo-viro I'm not sure where things are at.

- We need a kernel side API for reporting error events to userspace (could
  be async to 2.6 itself)

  (Prototype core based on netlink exists)

- Kai: Introduce a sane, easy and standard way to build external modules

- Kai: Allow separate src/objdir

- general confusion over firmware policy:

  - do we mandate that it be uploaded from userspace?

  - Is binary-blob-in-kernel-image OK?

  - Each driver (wireless, scsi, etc) seems to do it in a different,
    private manner.





drivers
=======

- Some network drivers don't even build

- Alan: Cardbus/PCMCIA requires all Russell's stuff is merged to do
  multiheader right and so on

drivers/acpi/
-------------

- davej: ACPI has a number of failures right now.  There are a number of
  entries in bugzilla which could all be the same bug.  It manifests as a
  "network card doesn't recieve packets" booting with 'acpi=off noapic' fixes
  it.

  alan: VIA APIC stuff is one bit of this, there are also some other
  reports that were caused by ACPI not setting level v edge trigger some
  times

- davej: There's also another nasty 'doesnt boot' bug which quite a few
  people (myself included) are seeing on some boxes (especially laptops).

drivers/block/
--------------

- Floppy is almost unusably buggy still

drivers/char/
-------------

- Alan: Multiple serious bugs in the DRI drivers (most now with patches
  thankfully).  "The badness I know about is almost entirely IRQ mishandling.
   DRI failing to mask PCI irqs on exit paths."

  (might be fixed due to DRI updates?)

- Various suspect things in AGP.

drivers/ide/
------------

  (Alan)

- IDE requires bio walking

  "Bartlomiej has IDE multisector working" (does that mean it's fixed?)


- IDE PIO has occasional unexplained PIO disk eating reports

- IDE has multiple zillions of races/hangs in 2.5 still

- IDE scsi needs rewriting

- IDE needs significant reworking to handle Simplex right

- IDE hotplug handling for 2.5 is completely broken still

- There are lots of other IDE bugs that wont go away until the taskfile
  stuff is included, the locking bugs that allow any user to hang the IDE
  layer in 2.5, and some other updates are forward ported.  (esp.  HPT372N).

drivers/isdn/
-------------

  (Kai, rmk)

- isdn_tty locking is completely broken (cli() and friends)

- fix lots of remaining bugs in the isdn link layer / hisax protocol layer
  / hisax subdrivers, so that at least 99% of the users have a usable ISDN
  subsystem

- fix other drivers

- lots more cleanups, adaption to recent APIs etc

- fixup tty-based ISDN drivers which provide TIOCM* ioctls (see my recent
  3-set patch for serial stuff)

  Alternatively, we could re-introduce the fallback to driver ioctl parsing
  for these if not enough drivers get updated.

drivers/net/
------------

- davej: Either Wireless network drivers or PCMCIA broke somewhen.  A
  configuration that worked fine under 2.4 doesn't receive any packets.  Need
  to look into this more to make sure I don't have any misconfiguration that
  just 'happened to work' under 2.4


drivers/scsi/
-------------

- Half of SCSI doesn't compile

arch/i386/
----------

- 2.5.x won't boot on some 440GX

  alan: Problem understood now, feasible fix in 2.4/2.4-ac.  (440GX has two
  IRQ routers, we use the $PIR table with the PIIX, but the 440GX doesnt use
  the PIIX for its IRQ routing).  Fall back to BIOS for 440GX works and Intel
  concurs.

- 2.5.x doesn't handle VIA APIC right yet.

  1. We must write the PCI_INTERRUPT_LINE

  2. We have quirk handlers that seem to trash it.

- ACPI needs the relax patches merging to work on lots of laptops

- ECC driver questions are not yet sorted (DaveJ is working on this)

- PC9800 is not fully merged - most of this I think is 2.7 stuff but a few
  bits might be 2.6 candidate

arch/x86_64/
------------

  (Andi)

- time handling is broken. Need to move up 2.4 time.c code.

- Another report of a crash at shutdown on Simics with no iommu when all
  memory was used.  Could be related to the one above.

- NMI watchdog seems to tick too fast

- some fixes from 2.4 still need to be merged

- not very well tested. probably more bugs lurking.

- 32bit vsyscalls seem to be broken

- 32bit elf coredumps are broken

- need to coredump 64bit vsyscall code with dwarf2

- move 64bit signal trampolines into vsyscall code and add dwarf2 for it.

- describe kernel assembly with dwarf2 annotations for kgdb (currently
  waiting on some binutils changes for this) 

arch/alpha/
-----------

- rth: Ptrace writes are broken.  This means we can't (reliably) set
  breakpoints or modify variables from gdb.

arch/arm/
---------

- rmk: missing raw keyboard translation tables for all ARM machines. 
  Haven't even looked into this at all.  This could be messy since there
  isn't an ARM architecture standard.  I'm presently hoping that it won't be
  an issue.  If it does, I guess we'll see drivers/char/keyboard.c explode.

arch/others/
------------

- SH3/SH3-64 need resyncing, as do some other ports.  No impact on
  mainstream platforms hopefully.


