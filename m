Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTD2Ws0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTD2Ws0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:48:26 -0400
Received: from [12.47.58.171] ([12.47.58.171]:64464 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261880AbTD2WsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:48:14 -0400
Date: Tue, 29 Apr 2003 15:57:31 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: must-fix list for 2.6.0
Message-Id: <20030429155731.07811707.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Apr 2003 23:00:26.0126 (UTC) FILETIME=[1F219AE0:01C30EA3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below is a first cut at tracking the major work items which should be
completed for a 2.6 release.

When considering these items it would be useful to have a clear idea of
what a 2.6.0 release is actually _for_.  Obviously, 2.6.0 doesn't mean
"it's finished, ship it".

I'd propose that 2.6.0 means that users can migrate from 2.4.x with a good
expectation that everything which they were using in 2.4 will continue to
work, and that the kernel doesn't crash, doesn't munch their data and
doesn't run like a dog.  Other definitions are welcome.


I shall be maintaining list this so we can understand where we are with
respect to 2.6 readiness.  And so we can look at features and say "no". 
And so we can look at bugs and say "not gating 2.6.0".

Things we should not track here are:

- Regular old bugs.  Please use bugzilla.

- Wishlist items.  This list is not a route for getting commitment for
  inclusion of $FAVEFEATURE.  In fact it's probably a good way of getting the
  feature shot down ;)

- Driver problems.  Most important drivers mostly work OK now.  Please use
  bugzilla.

Things which we should track here are significantly-sized outstanding
development activities which resolve big bugs or which address missing
features & speedups.

I've organised it into three main sections:

a) must-fix bugs which require significant amounts of work/restructuring
   to fix.

b) late features and speedups.

c) Important driver bugs.  This wasn't supposed to be here, but various
   contributors sent me a lot of details, and it would be sad to lose them.



The list is already very long, and very incomplete.  Additions (and
removals!!!) are sought.   Thanks.

And thanks to the various contributors who helped pull this together.



Must-fix bugs
=============

drivers/char/
-------------

- TTY locking is broken (see FIXME in do_tty_hangup())

  "One bug that was found is that the dropping of lock_kernel from do_exit
   caused races in the exit tty cleanup.  There was a patch for that, but I'm
   not sure it was merged."


drivers/block/
--------------

- RAID0 dies on strangely aligned BIOs

  - Need to hoist BIO-split code out of device mapper, use that.

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

- CD burning.  There are still a few quirks to solve wrt SG_IO and ide-cd.

  Jens: The basic hang has been solved (double fault in ide-cd), there still
  seems to be some cases that don't work too well.  Don't really have a
  handle on those :/

- IDE tcq. Either kill it or fix it. Not a "big todo", as such.

drivers/video/
--------------

- Lots of drivers don't compile, others do but don't work.

fs/
---

- NFS client gets an OOM deadlock.

  - Some fixes exist in -mm.  Seem to mostly work.

- NFS client runs very slowly consuming 100% CPU under heavy writeout.

  - Unsubtle fix exists in -mm.  (Looks like it's fixed anyway).

- ext3 data=journal mode is bust.

- ext3/htree doesn't play right with NFS server.  90% fixed in -mm.

- AIO/direct-IO writes can race with truncate and wreck filesystems.

  - Easy fix is to only allow the feature for S_ISBLK files.

- davej: NFS seems to have a really bad time for some people.  (Including
  myself on one testbox).  The common factor seems to be a high spec client
  torturing an underpowered NFS server with lots of IO.  (fsx/fsstress etc
  show this up).  Lots of "NFS server cheating" messages get dumped, and a
  whole lot of bogus packets start appearing.  They look severely corrupted,
  (they even crashed ethereal once 8-)


kernel/
-------

- O(1) scheduler starvation, poor behaviour seems unresolved.

  Jens: "I've been running 2.5.67-mm3 on my workstation for two days, and
  it still doesn't feel as good as 2.4.  It's not a disaster like some
  revisisons ago, but it still has occasional CPU "stalls" where it feels
  like a process waits for half a second of so for CPU time.  That's is very
  noticable."

   Also see Mike Galbraith's work.

- Alan: 32bit uid support is *still* broken for process accounting.

  (Test case?)

mm/
---

- Overcommit accounting gets wrong answers

  - underestimates reclaimable slab, gives bogus failures when
    dcache&icache are large.

  - gets confused by reclaimable-but-not-freed truncated ext3 pages. 
    Lame fix exists in -mm.

- Proper user level no overcommit also requires a root margin adding

modules
-------

  (Rusty)

- The .modinfo patch needs to go in.  It's trivial, but it's the major
  missing functionality vs. 2.4.  Keeps bouncing off Linus.

- __module_get(): "I know I have a refcount already and I don't care
  if they're doing rmmod --wait, gimme.".  Keeps bouncing off Linus.

- Per-cpu support inside modules (have patch, in testing).

- driver class code is getting redone.  I have this now working, and will
  send it out in a few days.

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


global
------

- Lots of 2.4 fixes including some security are not in 2.5

- There are about 60 or 70 security related checks that need doing
  (copy_user etc) from Stanford tools

- A couple of hundred real looking bugzilla bugs




Not-ready features and speedups
===============================


drivers/block/
--------------

- Framework for selecting IO schedulers.  This is the main one really. 
  Once this is in place we can drop in new schedulers any old time, no risk.

- Dynamic disk request allocation.  Patch exists.

- Runtime-selectable disk scheduler framework.

- Anticipatory scheduler.  Working OK now, still has problems with seeky
  OLTP-style loads.

- CFQ scheduler.  Seems to work but Jens planning significant rework.

- The feral.com qlogic driver: needs work.


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

- IPV4 output engine changes for IPSEC need to be moved over to IPV6.

  IPV6 ipsec works but gravely suboptimally in some cases.  It is also for
  this reason that the zerocopy UDP stuff isn't functional on the ipv6 side.

  The USAGI project (www.linux-ipv6.org) is working with Alexey on this
  work.

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

- A better suspend-to-disk mechanism that swsusp. 

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

arch/i386/
----------

- Andi: i386 sub architectures for common boxes (in particular bigsmp and
  summit) need to be runtime probed options, not compile time.  Vendors
  cannot ship an own kernel rpm for all these cases.  (patch is in -mm, works
  OK).

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





drivers
=======

- Alan: PCI random reordering from 2.4 to 2.5 isnt understood yet (might be
  fixed now?)

- Alan: We have multiple drivers walking the pci device lists and also
  using things like pci_find_device in unsafe ways with no refcounting.  I
  think we have to make pci_find_device etc refcount somewhere and add
  pci_device_put as was done with networking.

- Lots of network drivers don't even build

- Alan: PCI hotplug is unsafe (locking is totally screwed)

- Ditto cardbus

- Alan: Cardbus/PCMCIA requires all Russell's stuff is merged to do
  multiheader right and so on

drivers/acpi/
-------------

- davej: ACPI has a number of failures right now.  There are a number of
  entries in bugzilla which could all be the same bug.  It manifests as a
  "network card doesn't recieve packets" booting with 'acpi=off noapic' fixes
  it.

- davej: There's also another nasty 'doesnt boot' bug which quite a few
  people (myself included) are seeing on some boxes (especially laptops).

drivers/block/
--------------

- Alan: Partition handling is hosed for DM users.  (I have some partly
  debugged patches in the -ac tree, but Andries objects to them and I think
  his user knows magic options hack is unacceptable too.  Mostly this is
  figuring out the right answer)

- Floppy is almost unusably buggy still

drivers/char/
-------------

- Alan: Multiple serious bugs in the DRI drivers (most now with patches
  thankfully).  "The badness I know about is almost entirely IRQ mishandling.
   DRI failing to mask PCI irqs on exit paths."

- Various suspect things in AGP.

drivers/ide/
------------

  (Alan)

- IDE requires bio walking

- IDE PIO has occasional unexplained PIO disk eating reports

- IDE has multiple zillions of races/hangs in 2.5 still

- IDE eats disks with HPT372N on 2.5.x

- IDE scsi needs rewriting

- IDE needs significant reworking to handle Simplex right

- IDE hotplug handling for 2.5 is completely broken still

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

- fixup the usb-serial core and drivers to provide support for this
  patch.

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

- 2.5.x doesn't handle VIA APIC right yet - dont know why

- ACPI needs the relax patches merging to work on lots of laptops

- ECC driver questions are not yet sorted (DaveJ is working on this)

arch/x86_64/
------------

  (Andi)

- time handling is broken. Need to move up 2.4 time.c code.

- memory corruption with IOMMU pci_free_consistent - often causes crashes
  at shutdown.  This is rather mysterious, the code is basically identical to
  2.4 which works fine.  Can only be seen on systems with >4GB of memory or
  with iommu=force

- Another report of a crash at shutdown on Simics with no iommu when all
  memory was used.  Could be related to the one above.

- change_page_attr corrupts memory/crashes. Breaks some AGP users.

- NMI watchdog seems to tick too fast

- some fixes from 2.4 still need to be merged

- not very well tested. probably more bugs lurking.


