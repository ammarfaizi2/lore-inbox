Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTEPXJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTEPXJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:09:27 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:734 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263759AbTEPXJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:09:18 -0400
Date: Fri, 16 May 2003 16:17:17 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6 must-fix, v4
Message-Id: <20030516161717.1e629364.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2003 23:22:05.0622 (UTC) FILETIME=[F6B6B560:01C31C01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/


@@ -13,19 +13,20 @@
 
   - somebody will have to document the tty driver and ldisc API
 
-drivers/char/rtc/
------------------
+- Lack of test cases and/or stress tests is a problem.  Contributions and
+  suggestions are sought.
 
-- rmk: I think we need a generic RTC driver (which is backed by real RTCs).
-   Integrator-based stuff has a 32-bit 1Hz counter RTC with alarm, as has the
-  SA11xx, and probably PXA.  There's another implementation for the RiscPC
-  and ARM26 stuff.  I'd rather not see 4 implementations of the RTC userspace
-  API, but one common implementation so that stuff gets done in a consistent
-  way.
+- Lots of drivers are using cli/sti and are broken.
 
-  We postponed this at the beginning of 2.4 until 2.5 happened.  We're now
-  at 2.5, and I'm about to add at least one more (the Integrator
-  implementation.) This isn't sane imo.
+drivers/tty
+-----------
+
+- viro: we need to fix refcounting for tty_driver (oopsable race, must fix
+  anyway, hopefully about a week until it's merged) then we can do
+  tty/misc/upper levels of sound and hopefully upper level of USB.
+
+  USB is a place where we _really_ need to deal with dynamic allocation of
+  device numbers and that will bite.
 
 drivers/block/
 --------------
@@ -34,6 +35,9 @@
 
   - Need to hoist BIO-split code out of device mapper, use that.
 
+    arjan: "if we add that function, we must be sure that it can split on
+    not-a-page boundaries too otherwise it's useless for a bunch of things"
+
  (neilb)
 
  1/ RAID5 should work fine.  It accepts any sort of bio and always
@@ -66,6 +70,9 @@
 
 - ideraid hasn't been ported to 2.5 at all yet.
 
+  We need to understand whether the proposed BIO split code will suffice
+  for this.
+
 - CD burning.  There are still a few quirks to solve wrt SG_IO and ide-cd.
 
   Jens: The basic hang has been solved (double fault in ide-cd), there still
@@ -78,14 +85,30 @@
 - rmk: unconverted keyboard/mouse drivers (there's a deadline of 2.6.0
   currently on these remaining in my/Linus' tree.)
 
+- viro: large absence of locking.
+
 - synaptic touchpad support
 
+  Apparently there's a userspace `tpconfig'
+
+- andi: also the input keyboard stuff still has unusably obscure config
+  options for standard PC hardware.
+
+- viro: parport is nearly as bad as that and there the code is more hairy. 
+  IMO parport is more of "figure out what API changes are needed for its
+  users, get them done ASAP, then fix generic layer at leisure"
+
 drivers/misc/
 -------------
 
 - rmk: UCB1[23]00 drivers, currently sitting in drivers/misc in the ARM
   tree.  (touchscreen, audio, gpio, type device.)
 
+  These need to be moved out of drivers/misc/ and into real places
+
+- viro: actually, misc.c has a good chance to die.  With cdev-cidr that's
+  trivial.
+
 drivers/net/
 ------------
 
@@ -115,7 +138,15 @@
 
 - alan: Some cardbus crashes the system
 
-- alan: Hotplug locking is hosed
+  (bugzilla, please?)
+
+- We have multiple drivers walking the pci device lists and also using
+  things like pci_find_device in unsafe ways with no refcounting.  I think
+  we have to make pci_find_device etc refcount somewhere and add
+  pci_device_put as was done with networking.
+  http://bugzilla.kernel.org/show_bug.cgi?id=709
+
+  (gregkh will work on this)
 
 drivers/pcmcia/
 ---------------
@@ -124,11 +155,15 @@
   think after RMK's stuff is in most of the pcmcia/cardbus ones go except the
   locking disaster.
 
+  (rmk, brodo: in progress)
+
 drivers/pld/
 ------------
 
 - rmk: EPXA (ARM platform) PLD hotswap drivers (drivers/pld)
 
+  (rmk: will work out what to do here.  maybe drivers/arm/)
+
 drivers/video/
 --------------
 
@@ -178,19 +213,23 @@
   compilable on my platforms, so any updates would be welcome.  Also, are
   some of our non-compiling or unconverted drivers obsolete?
 
-drivers/usb/gadget/
--------------------
+- rmk: I have a pending todo: I need to put the scsi error handling through
+  a workout on my scsi bus from hell to make sure it does the right thing and
+  doesn't get wedged.
 
-- rmk: SA11xx USB client/gadget code (David B has been doing some work on
-  this, and keeps trying to prod me, but unfortunately I haven't had the time
-  to look at his work, sorry David.)
+- qlogic drivers: merge qlogicisp, feral with a view to dropping qlogicfc
+  and qlogicisp
+
+- jejb: and merge the qla2xxx too
 
 fs/
 ---
 
 - ext3 data=journal mode is bust.
 
-- ext3/htree doesn't play right with NFS server.  90% fixed in -mm.
+- ext3/htree readdir can return "." and ".." in unexpected order, which
+  might break buggy userspace apps.  Ted has a fix planned.
+
 
 - AIO/direct-IO writes can race with truncate and wreck filesystems.
 
@@ -202,6 +241,17 @@
   to have a workaround for this so this is at least not triggered so easily,
   but that's not what I'd consider a fix..
 
+- viro: fs/char_dev.c needs removal of aeb stuff and merge of cdev-cidr. 
+  In progress.
+
+- forward-port sct's O_DIRECT fixes
+
+- viro: there is some generic stuff for namei/namespace/super, but that's a
+  slow-merge and can go in 2.6 just fine
+
+- andi: also soft needs to be fixed - there are quite a lot of
+  uninterruptible waits in sunrpc/nfs
+
 kernel/
 -------
 
@@ -215,12 +265,24 @@
 
    Also see Mike Galbraith's work.
 
+  Conclusion: the scheduler has issues, lots of people working on it.  Rick
+  Lindsley, Andrew Theurer.
+
+- drepper: there are at least two big problems with the interaction between
+  futex and O(1).  Ingo has already patches.  But we need much more testing
+  on big boxes.  Only 4p+ machines have problems
+
 - Alan: 32bit uid support is *still* broken for process accounting.
 
   Create a 32bit uid, turn accounting on.  Shock horror it doesn't work
   because the field is 16bit.  We need an acct structure flag day for 2.6
   IMHO
 
+  (alan has patch)
+
+- nasty task refcounting bug is taking ages to track down.  (bugzilla ref?)
+
+
 mm/
 ---
 
@@ -234,6 +296,16 @@
 
 - Proper user level no overcommit also requires a root margin adding
 
+- There's a vmalloc race.  David Woodhouse has a patch, but it had a
+  problem.  Need to revisit it.
+
+- GFP_DMA32 (or something like that).  Lots of ideas.  jejb, zaitcev,
+  willy, arjan, wli.
+
+- access_process_vm() doesn't flush right.  We probably need new flushing
+  primitives to do this (davem?)
+
+
 modules
 -------
 
@@ -252,8 +324,9 @@
   protocol or network device that can be safely unloaded when it is a module.
 
   See:
-        http://pizda.ninka.net/~davem/modules.html
+        http://www.osdl.org/archive/shemminger/modules.html
 
+  (This is "two stage unload")
 
 net/
 ----
@@ -295,7 +368,6 @@
 - There are those mysterious TCP hangs of established state sockets. 
   Someone has to get a good log in order for us to effectively debug this.
 
-
 net/*/netfilter/
 ----------------
 
@@ -321,17 +393,27 @@
   NetWinder and other stuff (there's some fairly fundamental differences in
   the way the mixer needs to be handled for the NetWinder.)
 
+
+  (Issues with forward-porting 2.4 bugfixes.)
+  (Killing off OSS is 2.7 material)
+
+
 global
 ------
 
 - Lots of 2.4 fixes including some security are not in 2.5
 
+- HZ=1000 caused lots of lost timer interrupts.  ACPI or SMM.  (andi,
+  jstultz, arjan)
+
 - There are about 60 or 70 security related checks that need doing
-  (copy_user etc) from Stanford tools
+  (copy_user etc) from Stanford tools.  (badari is looking into this, and
+  hollisb)
 
 - A couple of hundred real looking bugzilla bugs
 
-
+- viro: cdev rework.  Main group is pretty stable and I hope to feed it to
+  Linus RSN.  That's cdev-cidr and ->i_cdev/->i_cindex stuff
 
 
 Not-ready features and speedups
@@ -353,6 +435,50 @@
 
 - The feral.com qlogic driver: needs work.
 
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
+
+drivers/net/wireless/
+---------------------
+
+  (Jean Tourrilhes <jt@bougret.hpl.hp.com>)
+
+- get latest orinoco changes from David.
+
+- get the latest airo.c fixes from CVS.  This will hopefully fix problems
+  people have reported on the LKML.
+
+- get HostAP driver in the kernel.  No consolidation of the 802.11
+  management across driver can happen until this one is in (which is probably
+  2.7.X material).  I think Jouni is mostly ready but didn't find time for
+  it.
+
+- get more wireless drivers into the kernel.  The most "integrable" drivers
+  at this point seem the NWN driver, Pavel's Spectrum driver and the Atmel
+  driver.
+
+- The last two drivers mentioned above are held up by firmware issues (see
+  flamewar on LKML a few days ago).  So maybe fixing those firmware issues
+  should be a requirement for 2.6.X, because we can expect more wireless
+  devices to need firmware upload at startup coming to market.
+
+drivers/usb/gadget/
+-------------------
+
+- rmk: SA11xx USB client/gadget code (David B has been doing some work on
+  this, and keeps trying to prod me, but unfortunately I haven't had the time
+  to look at his work, sorry David.)
 
 fs/
 ---
@@ -534,11 +660,6 @@
 arch/i386/
 ----------
 
-- Andi: i386 sub architectures for common boxes (in particular bigsmp and
-  summit) need to be runtime probed options, not compile time.  Vendors
-  cannot ship an own kernel rpm for all these cases.  (patch is in -mm, works
-  OK).
-
 - Also PC9800 merge needs finishing to the point we want for 2.6 (not all).
 
 - ES7000 wants merging (now we are all happy with it).  That shouldn't be a
@@ -560,23 +681,23 @@
 
 - Kai: Allow separate src/objdir
 
+- general confusion over firmware policy:
 
+  - do we mandate that it be uploaded from userspace?
 
+  - Is binary-blob-in-kernel-image OK?
 
+  - Each driver (wireless, scsi, etc) seems to do it in a different,
+    private manner.
 
-drivers
-=======
 
-- Alan: We have multiple drivers walking the pci device lists and also
-  using things like pci_find_device in unsafe ways with no refcounting.  I
-  think we have to make pci_find_device etc refcount somewhere and add
-  pci_device_put as was done with networking.
 
-- Some network drivers don't even build
 
-- Alan: PCI hotplug is unsafe (locking is totally screwed)
 
-- Ditto cardbus
+drivers
+=======
+
+- Some network drivers don't even build
 
 - Alan: Cardbus/PCMCIA requires all Russell's stuff is merged to do
   multiheader right and so on
@@ -632,8 +753,6 @@
 
 - IDE hotplug handling for 2.5 is completely broken still
 
-- IDE tcq. Either kill it or fix it. Not a "big todo", as such.
-
 - There are lots of other IDE bugs that wont go away until the taskfile
   stuff is included, the locking bugs that allow any user to hang the IDE
   layer in 2.5, and some other updates are forward ported.  (esp.  HPT372N).
@@ -722,6 +841,12 @@
 
 - describe kernel assembly with dwarf2 annotations for kgdb (currently
   waiting on some binutils changes for this) 
+
+arch/alpha/
+-----------
+
+- rth: Ptrace writes are broken.  This means we can't (reliably) set
+  breakpoints or modify variables from gdb.
 
 arch/arm/
 ---------

