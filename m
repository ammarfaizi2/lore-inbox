Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318601AbSH1CCm>; Tue, 27 Aug 2002 22:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318602AbSH1CCm>; Tue, 27 Aug 2002 22:02:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10884 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318601AbSH1CCl>;
	Tue, 27 Aug 2002 22:02:41 -0400
Date: Tue, 27 Aug 2002 22:07:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Linux v2.5.32
In-Reply-To: <1030487747.7171.4.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0208272105510.6084-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 27 Aug 2002, Alan Cox wrote:

> On Tue, 2002-08-27 at 21:47, Alexander Viro wrote:
> > IDE merge is b0rken wrt partitioning.  Patchset that is supposed to fix
> > that stuff is on ftp.math.psu.edu/pub/viro/IDE/* - waiting for ACK from
> > Alan.
> 
> Bug me in a few days. To be honest I think its more productive to assume
> you are right because I have too much other stuff to deal with during
> the current RH beta to give rapid answers on 2.5 stuff

OK.  Here's the contents of patchset, patches will go in followups (and
not Cc'd to l-k)

1)	moves stuff from ide_register_subdriver() (associating drive with
high-level driver) to ide-probe.c, so that remaining stuff can be safely
called in parallel with IO on other drives [Andre]

2)	finishes introduction of ->reinit() - Jens had missed MOD_DEC_USE_COUNT
on several exits from ide-cd one and forgot to remove the loop from ide-floppy
ide-tape and ide-scsi ones ;-) (->reinit() is the body of loop in ->init() -
stuff that should be done one drive; in 2.5.32 ide-disk one is OK, ide-cd is
OK modulo minor bugs and in the rest it's a copy of ->init())

3)	puts drives on cyclic lists - per-driver ones for drives that had
been claimed by high-level drivers and ata_unused for unclaimed drives.
We put drives on ata_unused in the very end of ideprobe_init() and then
move them to drivers' lists as they are claimed.

4)	checks for media type, ->driver_req, etc. are moved from the
ide_scan_devices() to ->reinit().  ide_scan_devices() had lost first
two arguments (it will completely disappear later).

5)	duplicate calls of ide_cdrom_init(), idedisk_init(), etc. are
removed from ide_init_builtin_drivers() (they were called both from
there (i.e. from ide_init()) and later as module_init() for high-level
drivers).

6)	loops in ide_cdrom_init()/ide_cdrom_exit(), etc. are pulled into
ide_register_module()/ide_unregister_module() resp.

7)	->owner added to ide_driver_t.  MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT
taken out of ->reinit().  ide_reinit_drive() turned into "call ->reinit()
for all high-level drivers that are registered until somebody claims the
drive" (instead of open-coded variant in 2.5.32; cleaner and works correctly
for modular drivers).

8)	That's the central part of the series:
	ide_reinit_drive() turned into ata_attach().  Said beast takes a
drive, tries to feed it to high-level drivers and drops it on the ata_unused
if nobody claims the sucker.  IOW, that's what ide_register_module() used
to do, but for a single drive.
	ideprobe_init() calls ata_attach() instead of putting on ata_unused.
	ide_register_module() eliminated.  Some of the callers do not need
it anymore, some (ide_replace_subdriver()) actually want ata_attach(drive).
	ide_scan_devices() is gone.  There were two remaining callers - in
ide_register_module() and ide_unregister_module().  The former had been
turned into "put driver on the list, empty ata_unused into temporary list
and call ata_attach() on all drives there".  The latter is "remove driver
from the list, call ->cleanup() and ata_attach() for all drives" (->cleanup()
gives the drive up, ata_attach() gives the remaining drivers a shot for
that drive; if nobody claims it - it's put on ata_unused).

9)	->init() for high-level drivers is never called (other than as
module_init() when they are initialized).  Method removed, instances
cleaned up.

10)	instead of messing with ide_module_t, we put ide_driver_t themselves
on a (cyclic) list - said list being the only use of ide_module_t for
high-level drivers.  ide_register_module()/ide_unregister_module() takes
ide_driver_t now (renamed to ide_register_driver()).  /proc/ide/drivers
switched to use of that cyclic list and uses seq_file instead of old
home-grown code.

11)	2.5 bits:
	add_gendisk()/del_gendisk() moved into ->reinit() and ->cleanup() of
ide-{disk,cd,floppy} - i.e. moments when high-levle driver claims/gives up
a drive.
	register_disk() also shifted into ->reinit().
	consequently, revalidate_drives() is gone (it did messy postponed
rereading of partition tables; not needed anymore).  Ditto for ide_geninit().
	regular 2.5 changes in ->revalidate() and BLKRRPART handling - same
as all other block devices.

The reason why we couldn't do just #11 and be done with that is simple -
high-level drivers were rude and considered drives fair game as soon
as they had been probed.  That is *wrong* - we might be still doing
"unsafe" work with the interface (or related interfaces) and any regular
IO at that point is a Bad Thing(tm).  As the result we had to use very
odd logics in partition handling, registering, etc.

New variant lets the probing code to decide when it's safe to put the drives
in circulation - no high-level driver will see a drive until ata_attach()
is called.  Which puts the knowledge of ordering between configuring and
normal IO into the probing code where it belongs.  High-level drivers
don't have to think about it anymore - as soon as drive is given to them
it's safe to do IO on it.

Ordering issues between configuring different interfaces, etc. still
remain where they were - that's a separate story and it belongs to the
low-level driver cleanups.  Moreover, place where we are calling
ata_attach() is very conservative - we do _all_ configuring of interfaces
and then call ata_attach() on everything we'd found.  Eventually, low-level
drivers should be able to do "configure our group of interfaces, then call
ata_attach() on their drives", but that, again, is a separate story -
one I'd happily leave to the folks who do cleanup of low-level drivers.
All ordering issues with high-level drivers are reduced to one rule:
don't call ata_attach() on a drive before it's safe to get IO on it.

The patchset doesn't fix all problems with the driver - code that
went into 2.5 had been derived from 2.4.19 and several megabytes of
fixes went into 2.4.20-ac since then.  However, these fixes are mostly
in low-level drivers, so they shouldn't cause problems with porting and
I'll happily leave that fun to Jens when he comes back.

