Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264062AbTE3X2T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 19:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbTE3X2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 19:28:19 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:7932 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264062AbTE3X1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 19:27:46 -0400
Date: Fri, 30 May 2003 16:38:21 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: must-fix, version 6
Message-Id: <20030530163821.46dbd19e.akpm@digeo.com>
In-Reply-To: <20030530163720.399a8bac.akpm@digeo.com>
References: <20030530163720.399a8bac.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2003 23:41:06.0663 (UTC) FILETIME=[F09C3F70:01C32704]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Must-fix bugs
=============

drivers/char/
~~~~~~~~~~~~~

o TTY locking is broken.

  o see FIXME in do_tty_hangup().  This causes ppp BUGs in local_bh_enable()

  o Other problems: aviro, dipankar, Alan have details.

  o somebody will have to document the tty driver and ldisc API

o Lack of test cases and/or stress tests is a problem.  Contributions and
  suggestions are sought.

o Lots of drivers are using cli/sti and are broken.

o willy: random.c is completely lockfree, and not in a good way.  i had
  some patches but nothing got seriously tested.

drivers/tty
~~~~~~~~~~~

o viro: we need to fix refcounting for tty_driver (oopsable race, must fix
  anyway, hopefully about a week until it's merged) then we can do
  tty/misc/upper levels of sound and hopefully upper level of USB.

  USB is a place where we _really_ need to deal with dynamic allocation of
  device numbers and that will bite.

drivers/block/
~~~~~~~~~~~~~~

o RAID0 dies on strangely aligned BIOs

  o Need to hoist BIO-split code out of device mapper, use that.

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

o ideraid hasn't been ported to 2.5 at all yet.

  We need to understand whether the proposed BIO split code will suffice
  for this.

o CD burning.  There are still a few quirks to solve wrt SG_IO and ide-cd.

  Jens: The basic hang has been solved (double fault in ide-cd), there still
  seems to be some cases that don't work too well.  Don't really have a
  handle on those :/

o lmb: Last time I looked at the multipath code (2.5.50 or so) it also
  looked pretty broken; I plan to port forward the changes we did on 2.4
  before KS.

o loop.c: fix http://bugzilla.kernel.org/show_bug.cgi?id=192

drivers/input/
~~~~~~~~~~~~~~

o rmk: unconverted keyboard/mouse drivers (there's a deadline of 2.6.0
  currently on these remaining in my/Linus' tree.)

o viro: large absence of locking.

o synaptic touchpad support

  Jens Taprogge <jens.taprogge@rwth-aachen.de> is working on this.

o andi: also the input keyboard stuff still has unusably obscure config
  options for standard PC hardware.

o viro: parport is nearly as bad as that and there the code is more hairy. 
  IMO parport is more of "figure out what API changes are needed for its
  users, get them done ASAP, then fix generic layer at leisure"

drivers/misc/
~~~~~~~~~~~~~

o rmk: UCB1[23]00 drivers, currently sitting in drivers/misc in the ARM
  tree.  (touchscreen, audio, gpio, type device.)

  These need to be moved out of drivers/misc/ and into real places

o viro: actually, misc.c has a good chance to die.  With cdev-cidr that's
  trivial.

drivers/net/
~~~~~~~~~~~~

o rmk: network drivers.  ARM people like to add tonnes of #ifdefs into
  these to customise them to their hardware platform (eg, chip access
  methods, addresses, etc.) I cope with this by not integrating them into my
  tree.  The result is that many ARM platforms can't be built from even my
  tree without extra patches.  This isn't sane, and has bred a culture of
  network drivers not being submitted.  I don't see this changing for 2.6
  though.

drivers/net/irda/
~~~~~~~~~~~~~~~~~

o dongle drivers need to be converted to sir-dev

o irport need to be converted to sir-kthread

o new drivers (irtty-sir/smsc-ircc2/donauboe) need more testing

o rmk: Refuse IrDA initialisation if sizeof(structures) is incorrect (I'm
  not sure if we still need this; I think gcc 2.95.3 on ARM shows this
  problem though.)

drivers/pci/
~~~~~~~~~~~~

o alan: Some cardbus crashes the system

  (bugzilla, please?)

o We have multiple drivers walking the pci device lists and also using
  things like pci_find_device in unsafe ways with no refcounting.  I think
  we have to make pci_find_device etc refcount somewhere and add
  pci_device_put as was done with networking.
  http://bugzilla.kernel.org/show_bug.cgi?id=709

  (gregkh will work on this)

o willy: PCI Domain support.  The 'must-fix' bit of this is getting sysfs
  to present the right interface to userspace so we can adapt pciutils & X to
  use it.

drivers/pcmcia/
~~~~~~~~~~~~~~~

o alan: Most drivers crash the system on eject randomly with timer bugs.  I
  think after RMK's stuff is in most of the pcmcia/cardbus ones go except the
  locking disaster.

  (rmk, brodo: in progress)

drivers/pld/
~~~~~~~~~~~~

o rmk: EPXA (ARM platform) PLD hotswap drivers (drivers/pld)

  (rmk: will work out what to do here.  maybe drivers/arm/)

drivers/video/
~~~~~~~~~~~~~~

o Lots of drivers don't compile, others do but don't work.

drivers/scsi/
~~~~~~~~~~~~~

o hch: large parts of the locking are hosed or not existant

  (Mike Anderson, Patrick Mansfield, Badari Pulavarty)

  o shost->my_devices isn't locked down at all

  o the host list ist locked but not refcounted, mess can happen when the
    spinlock is dropped

  o there are lots of members of struct Scsi_Host/scsi_device/scsi_cmnd
    with very unclear locking, many of them probably want to become
    atomic_t's or bitmaps (for the 1bit bitfields).

  o there's lots of volatile abuse in the scsi code that needs to be
    thought about.

  o there's some global variables incremented without any locks

o Convert am53c974, dpt_i2o, initio and pci2220i to DMA-mapping

o Make inia100, cpqfc, pci2000 and dc390t compile

o Convert

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

o rmk: I have a pending todo: I need to put the scsi error handling through
  a workout on my scsi bus from hell to make sure it does the right thing and
  doesn't get wedged.

o qlogic drivers: merge qlogicisp, feral with a view to dropping qlogicfc
  and qlogicisp

o jejb: and merge the qla2xxx too

fs/
~~~

o ext3 data=journal mode is bust.  (fix is in progress)

o ext3/htree readdir can return "." and ".." in unexpected order, which
  might break buggy userspace apps.  Ted has a fix planned.


o AIO/direct-IO writes can race with truncate and wreck filesystems.

  o Easy fix is to add an rwsem to the inode.

o hch: devfs: there's a fundamental lookup vs devfsd race that's only
  fixable by introducing a lookup vs devfs deadlock.  I can't see how this is
  fixable without getting rid of the current devfsd design.  Mandrake seems
  to have a workaround for this so this is at least not triggered so easily,
  but that's not what I'd consider a fix..

o viro: fs/char_dev.c needs removal of aeb stuff and merge of cdev-cidr. 
  In progress.

o forward-port sct's O_DIRECT fixes

o viro: there is some generic stuff for namei/namespace/super, but that's a
  slow-merge and can go in 2.6 just fine

o andi: also soft needs to be fixed - there are quite a lot of
  uninterruptible waits in sunrpc/nfs

o trond: NFS has a mmap-versus-truncate problem

kernel/sched.c
~~~~~~~~~~~~~~

o "Persistent starvation"

  http://www.hpl.hp.com/research/linux/kernel/o1-starve.php

  ingo: "basically by calling sleep(1) in an infinite loop you can end up
  expiring yourself.  The testcode (test-starve.c) triggers this.  This is
  solved by going to sub-timeslices.  Which i've got done a few weeks ago and
  it has seen some testing by others as well.

o Overeager affinity in presence of repeated yields

  http://www.hpl.hp.com/research/linux/kernel/o1-openmp.php

  ingo: this is valid.  fix is in progress.

o The "thud.c" test app.  This is a exploit for the interactivity
  estimator.  it's unlikely to bite in real-world cases.  Needs watching. 
  Can be ameliorated by setting nice values.

o generic interactivity problems need watching.  We've closed down a number
  of items recently without introducing new ones, so i'm confident this is
  heading in the right direction.

kernel/
~~~~~~~

o Alan: 32bit uid support is *still* broken for process accounting.

  Create a 32bit uid, turn accounting on.  Shock horror it doesn't work
  because the field is 16bit.  We need an acct structure flag day for 2.6
  IMHO

  (alan has patch)

o nasty task refcounting bug is taking ages to track down.  (bugzilla ref?)

o viro: core sysctl code is racy.  And its interaction wiuth sysfs

o gettimeofday goes backwards.  Merge up David M-T's fixes?

o Daniel Jacobowitz <dan@debian.org>: when CLONE_DETACHED threads were
  removed from /proc several approaches were suggested to let procps find out
  about them and none of them were implemented.  There's some real potential
  for badness with these mostly-invisible processes.  Something needs to be
  added so that we can display and detect them.

lib/kobject.c
~~~~~~~~~~~~~

o kobject refcounting (comments from Al Viro):

  _anything_ can grab a temporary reference to kobject.  IOW, if kobject is
  embedded into something that could be freed - it _MUST_ have a destructor
  and that destructor _MUST_ be the destructor for containing object.

  Any violation of the above (and we already have a bunch of those) is a
  user-triggerable memory corruption.

  We can tolerate it for a while in 2.5 (e.g.  during work on susbsystem we
  can decide to switch to that way of handling objects and have subsystem
  vulnerable for a while), but all such windows must be closed before 2.6 and
  during 2.6 we can't open them at all.

mm/
~~~

o Overcommit accounting gets wrong answers

  o gets confused by reclaimable-but-not-freed truncated ext3 pages. 

o GFP_DMA32 (or something like that).  Lots of ideas.  jejb, zaitcev,
  willy, arjan, wli.

o access_process_vm() doesn't flush right.  We probably need new flushing
  primitives to do this (davem?)


modules
~~~~~~~

  (Rusty)

o The .modinfo patch needs to go in.  It's trivial, but it's the major
  missing functionality vs. 2.4.  Keeps bouncing off Linus.

o __module_get(): "I know I have a refcount already and I don't care
  if they're doing rmmod --wait, gimme.".  Keeps bouncing off Linus.

o Per-cpu support inside modules (have patch, in testing).

o shemminger: The module remove rework that Rusty and Dave are working on
  needs to be fixed before 2.6.  Right now, it is impossible to write a
  protocol or network device that can be safely unloaded when it is a module.

  See:
        http://www.osdl.org/archive/shemminger/modules.html

  (This is "two stage unload")

net/
~~~~

  (davem)

o UDP apps can in theory deadlock, because the ip_append_data path can end
  up sleeping while the socket lock is held.

  It is OK to sleep with the socket held held, normally.  But in this case
  the sleep happens while waiting for socket memory/space to become
  available, if another context needs to take the socket lock to free up the
  space we could hang.

  I sent a rough patch on how to fix this to Alexey, and he is analyzing
  the situation.  I expect a final fix from him next week or so.

o Semantics for IPSEC during operations such as TCP connect suck currently.

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

o There are those mysterious TCP hangs of established state sockets. 
  Someone has to get a good log in order for us to effectively debug this.

net/*/netfilter/
~~~~~~~~~~~~~~~~

  (Rusty)

o Handle non-linear skbs everywhere.  This is going in via Dave now.

o Rework conntrack hashing.

o Module relationship bogosity fix (trivial, have patch).

sound/
~~~~~~

o rmk: several OSS drivers for SA11xx-based hardware in need of
  ALSA-ification and L3 bus support code for these.

o rmk: linux/sound/drivers/mpu401/mpu401.c and
  linux/sound/drivers/virmidi.c complained about 'errno' at some time in the
  past, need to confirm whether this is still a problem.

o rmk: need to complete ALSA-ification of the WaveArtist driver for both
  NetWinder and other stuff (there's some fairly fundamental differences in
  the way the mixer needs to be handled for the NetWinder.)


  (Issues with forward-porting 2.4 bugfixes.)
  (Killing off OSS is 2.7 material)


global
~~~~~~

o Lots of 2.4 fixes including some security are not in 2.5

o HZ=1000 caused lots of lost timer interrupts.  ACPI or SMM.  (andi,
  jstultz, arjan)

o There are about 60 or 70 security related checks that need doing
  (copy_user etc) from Stanford tools.  (badari is looking into this, and
  hollisb)

o A couple of hundred real looking bugzilla bugs

o viro: cdev rework.  Main group is pretty stable and I hope to feed it to
  Linus RSN.  That's cdev-cidr and ->i_cdev/->i_cindex stuff




