Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292888AbSCRUt2>; Mon, 18 Mar 2002 15:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292857AbSCRUtU>; Mon, 18 Mar 2002 15:49:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63499 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292850AbSCRUtB>; Mon, 18 Mar 2002 15:49:01 -0500
Date: Mon, 18 Mar 2002 12:47:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.7
Message-ID: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, there's a 2.5.7 out there now, full changelog appended.

NOTE! I'll be gone for a vacation for two weeks, and will not be reading 
email during the time. So please discuss problems on linux-kernel, with 
Dave Jones, Jeff Garzik etc handling patches while I'm away. 

			Linus

-----

	Release notes for v2.5.7



Summary of changes from v2.5.7-pre2 to v2.5.7
============================================

<kai@vaio.(none)> (02/02/10 1.248.8.1)
	Remove duplicate CONFIG_SOUND help entries and put one 
	into drivers/sound/Config.help

<kai@tp1.ruhr-uni-bochum.de> (02/03/16 1.522.1.1)
	Link drivers/fc4/fc4.a only once.

<kai@tp1.ruhr-uni-bochum.de> (02/03/16 1.522.1.2)
	Descend into drivers/parport only if CONFIG_PARPORT is set.

<kai@tp1.ruhr-uni-bochum.de> (02/03/16 1.522.1.3)
	Descend into drivers/hotplug only if CONFIG_HOTPLUG_PCI is set.

<torvalds@home.transmeta.com> (02/03/16 1.522.2.1)
	Fix up ACPI so that it seems to work in the new world order:
	make driverfs initialize early, so that ACPI can come alive
	in a world where you can register devices. 

<dwmw2@infradead.org> (02/03/17 1.525)
	Remove jffs2_sb from struct super_block union.
	Remove FS_REQUIRES_DEV from JFFS2. We never really used the block device anyway.

<paschal@rcsis.com> (02/03/17 1.524.1.1)
	USB printer update
	
	- bind to 7/1/2 alternate setting by default, to fix printing with HP
	  LaserJet 1200 and 2200
	- ioctls needed by the GPL user-mode IEEE 1284.4 driver which is part of
	  the HP OfficeJet Linux driver (http://hpoj.sourceforge.net):
	  - dynamic switching between 7/1/[123] alternate settings
	  - sending HP vendor-specific channel-change-request to support
	    memory card readers on HP PhotoSmart printers
	  - inquire more information about the peripheral, including
	    /proc/bus/usb/xx/yy linkage to get even more information
	- fix apparent array overflow (by 1 entry) in usblp_probe when more than
	  the maximum number of USB printers are connected
	- for the 2.2 version, added MODULE_{INC,DEC}_USE_COUNT to prevent rmmoding
	  of printer.o (and subsequent OOPSes) while a USB printer device is open
	- cleaned up the code in a few places by consolidating duplicated code

<stewart@inverse.wetlogic.net> (02/03/17 1.524.1.2)
	USB Urefs for hid-core/hiddev
	
	  I've written a patch Vojtech and I discussed for enhancing the
	hiddev code to optionally provide more detailed output on read().
	The old functionality is still supported by default, and in
	situations where HID usage codes are unique across reports, the
	old method is still preferable due to its terseness.
	    
	  The new method provides the ability to determine exactly which
	value has changed, in cases where the HID usage codes are not  
	unique.  It also provides a means to optionally receive notification
	when input reports are received from the device, whether or not
	any of the values in the report have changed.
	
	  The details of the changes are as follows:
	  
	  - All current code behaves identically
	
	  - A new ioctl pair HIDIOCGFLAG/HIDIOCSFLAG gets and clears
	    flags on the hiddev device.                             
	
	  - If you set the flag HIDDEV_FLAG_UREF, the read() call switches
	    from reading hiddev_event structures to hiddev_usage_ref
	    structures.  The change takes effect immediately, even to
	    already queued events that haven't been read() yet.  Here's
	    an example of enabling FLAG_UREF:                          
	
	    {
	        int flag = HIDDEV_FLAG_UREF;
	        if (ioctl(fd, HIDIOCSFLAG, &flag) != 0) {
	                perror("ioctl");
	                exit(1);
	        }
	    }
	  
	  - With the HIDDEV_FLAG_REPORT set (which is only allowed if
	    HIDDEV_FLAG_UREF is also set), there is a special uref that
	    will be read() in addition to the ones corresponding to
	    changes in the device state: when uref.field_index is set to
	    HID_FIELD_INDEX_NONE, this uref is a notification that the
	    report referred to by report_type and report_id has been
	    received from the device.  This can be useful in situations
	    when the notification of the arrival of a report is useful
	    even if there is no change in state.

<spse@secret.org.uk> (02/03/17 1.524.1.3)
	USB catc driver
	  
	Here is a patch to add support for F5U011 to catc.c driver. The
	patch has been compile tested against 2.5.6 and 2.5.7pre1
	(and tested against 2.5.5-dj1) and should apply cleanly.

<ganesh@tuxtop.vxindia.veritas.com> (02/03/17 1.524.1.4)
	USB serial drivers
	
	Several functions in the serial drivers can be called from bottom
	half or interrupt context. They must use the GFP_ATOMIC flag for
	calls to kmalloc() and usb_submit_urb().
	  
	Functions which must use GFP_ATOMIC:
	1. All *_callback() functions.
	2. Any code which is inside a spinlock.
	3. write(), throttle(), unthrottle(), which may be called by
	   the line discipline in bottom half context.
	  
	Functions which can use GFP_KERNEL:
	1. open(), close(), startup(), shutdown(), set_termios().

<vojtech@suse.cz> (02/03/17 1.524.1.5)
	USB HID driver
	  
	Workaround for the ATEN switches

<tai@imasy.or.jp> (02/03/17 1.524.1.6)
	USB printer patch
	
	added NEC printer to quirks list

<dwmw2@infradead.org> (02/03/17 1.526)
	Switch cramfs and zisofs from zlib_fs to common zlib.
	Remove remnants of zlib_fs.

<davem@nuts.ninka.net> (02/03/17 1.384.4.15)
	Fix netfilter IPv4 conntrack build.

<davem@nuts.ninka.net> (02/03/17 1.384.4.16)
	Make wanpipe build again after struct sock cleanups.
	From Arnaldo Carvalho de Melo.

<paulus@samba.org> (02/03/18 1.524.2.1)
	PPC update - add preempt_count to the ppc thread_info, add
	SI_DETHREAD, plus a couple of minor fixes.

<paulus@samba.org> (02/03/18 1.524.2.2)
	Fix a lockup on some PPC machines running an SMP kernel - we were
	exiting heathrow_modem_enable() with a lock held.

<david-b@pacbell.net> (02/03/18 1.524.2.4)
	[PATCH] PATCH -- pci_pool and CONFIG_DEBUG_SLAB
	
	I got burnt one too many time by mismatches between
	the pci_pool and "real" slabs... something changed in
	mm/slab.c and broke a driver, so I'm going for the real
	fix this time.  Having poisoning that _works_ is a huge
	help in the innards of the USB host controller drivers.
	
	This patch gets rid of some #ifdefs and makes the pci_pool
	code poison memory if CONFIG_DEBUG_SLAB is set.
	The functionality has always been there, but this makes
	it simpler to get at.

<bgerst@didntduck.org> (02/03/18 1.524.2.5)
	[PATCH] struct super_block cleanup - isofs
	
	Seperates isofs_sb_info from struct super_block.

<bgerst@didntduck.org> (02/03/18 1.524.2.6)
	[PATCH] struct super_block cleanup - udf
	
	Seperates udf_sb_info from struct super_block.

<viro@math.psu.edu> (02/03/18 1.525.1.3)
	[PATCH] moving stuff to fs/filesystems.c
	
		file_system_typer-related code moved from fs/super.c to
	fs/filesystems.c

<bgerst@didntduck.org> (02/03/18 1.528)
	[PATCH] struct super_block cleanup - shmem
	
	Seperates shmem_sb_info from struct super_block.

<bgerst@didntduck.org> (02/03/18 1.529)
	[PATCH] struct super_block cleanup - hfs
	
	Seperates hfs_sb_info from struct super_block.

<bgerst@didntduck.org> (02/03/18 1.530)
	[PATCH] struct super_block cleanup - affs
	
	Seperates affs_sb_info from struct super_block.

<pazke@orbita1.ru> (02/03/18 1.531)
	[PATCH] driverfs support for ISAPNP driver
	
	This adds initial driverfs support to ISAPNP driver.  It was approved by
	the ISAPNP maintainer (Jaroslav Kysela).

<perex@suse.cz> (02/03/18 1.532)
	[PATCH] for 2.5.7pre2
	
	- add joystick support for CS46xx driver
	- Audigy code updates
	- fix sound/core/Config.in (wrong dep_tristate usage)
	- rawmidi interface fixes (memory leak)
	- chang spinlock to rwlock in pcm_native.c (streams linking)
	- further fixes of dependencies in Makefiles
	- remove experimental time-sync support from sequencer
	- fix/update for 32-bit -> 64-bit ioctl converter code
	- wavefront driver cleanups
	- CMIPCI driver updates
	- update joystick support in CS4281
	- add detection (not support) of M Audio Delta1010LT
	- add AMD768 PCI ID to intel8x0 driver
	- add joystick code to trident driver
	- remove static variable initialization to zero

<dalecki@evision-ventures.com> (02/03/18 1.533)
	[PATCH] 2.5.7-pre2 IDE 22a
	
	- Apply more patches from Vojtech Pavlik for the handling of host chip setup.
	   Hopefully they are settled now.
	
	- Kill unused CONFIG_BLK_DEV_MODES
	
	- Push register addressing down in to task_vlb_sync.
	
	- Make the taskfile parsing stuff actually readable. This is compressing the
	   code by an incredible amount. We use just one function doing the whole
	   scanning right now. This should make sure that the IRQ handler used by a
	   particular command is always right.  I didn't introduce typos hopefully
	   here.
	
	- Don't call ide_handler_parser as argument for do_taskfile() any longer. We
	   have killed this function by coalescing it's functionality with
	   ide_cmd_type_parser() anyway.
	
	- Kill unused SLC90E66 code, which Vojtech apparently missed in his patch.
	
	- sync up with 2.5.7-pre2
	
	Once again the actual patch is rather big mostly due to the removal of
	some default configuration variables which are not used anylonger. So time for
	the next patch stage.

<hirofumi@mail.parknet.co.jp> (02/03/18 1.534)
	[PATCH] Fix linux/msdos_fs.h for userland (1/2)
	
	The following patch moves MSDOS_SB() and MSDOS_I() into #define
	__KERNEL__.

<hirofumi@mail.parknet.co.jp> (02/03/18 1.535)
	[PATCH] cleanup FAT stuff (2/2)
	
	This patch remove unused variable/function/define, and small indent
	cleanup.

<torvalds@home.transmeta.com> (02/03/18 1.536)
	Include <linux/completion.h> for completion user

<torvalds@home.transmeta.com> (02/03/18 1.537)
	Update version


Summary of changes from v2.5.7-pre1 to v2.5.7-pre2
============================================

<anton@samba.org> (02/03/11 1.384.3.1)
	pcnet32 net driver updates 1/6:
	fix leak in pci memory space on machines with IOMMUs.

<anton@samba.org> (02/03/11 1.384.3.2)
	pcnet32 net driver updates 2/6:
	irq could overflow unsigned char, change to unsigned int
	ioaddr could overflow unsigned int, change to unsigned long

<anton@samba.org> (02/03/11 1.384.3.3)
	pcnet32 net driver updates 3/6:
	protect pcnet32_tx_timeout and pcnet32_set_multicast_list with
	spinlock, fix from Dave Engebretsen

<anton@samba.org> (02/03/11 1.384.3.4)
	pcnet32 net driver updates 4/6:
	Increase device watchdog timeout, fix from Dave Engebretsen.

<anton@samba.org> (02/03/11 1.384.3.5)
	pcnet32 net driver updates 5/6:
	pcnet32_purge_tx_ring can be called from interrupt, so must use
	dev_kfree_skb_any, fix from Dave Engebretsen.

<anton@samba.org> (02/03/11 1.384.3.6)
	pcnet32 net driver updates 6/6:
	perform dwio reset after checking wio, otherwise some cards fail
	the probe, fix from Paul Mackerras

<kai@tp1.ruhr-uni-bochum.de> (02/03/11 1.384.9.1)
	Make USB core init an subsys_initcall, like the other buses.
	
	As it's linked after PCI, usb_init() will be called after pci_init(),
	which is an subsys_initcall, too. Subtle, but right.

<peter@chubb.wattle.id.au> (02/03/11 1.375.25.4)
	[PATCH] HP Sim config patch
	
	Offer loopback driver and network block device support for HP Sim.

<davidm@wailua.hpl.hp.com> (02/03/11 1.375.25.5)
	siginfo.h:
	  Define SI_DETHREAD.

<davidm@wailua.hpl.hp.com> (02/03/11 1.375.25.6)
	smp.c:
	  Remove task-migration IPI.   It's been replaced
	  by Ingo's migration threads.

<davidm@wailua.hpl.hp.com> (02/03/11 1.375.25.7)
	Sync with Linus' v2.5.6 tree.

<davidm@hpl.hp.com> (02/03/12 1.388.1.18)
	[PATCH] Compile fix for kernel/sched.c
	
	Fix init_idle() to initialize preempt_count only if CONFIG_PREEMPT is set.

<jgarzik@mandrakesoft.com> (02/03/12 1.384.10.1)
	e100 net driver updates from Intel:
	* fix zerocopy
	* add suspend/resume

<jgarzik@mandrakesoft.com> (02/03/12 1.384.10.2)
	e100 net driver cleanups from Arjan van de Ven:
	* fix PCI posting bugs
	* remove ia64-specific code, requires an arch workaround/fix instead
	* other misc cleanups and small bug fixes

<arjan@redhat.com> (02/03/12 1.388.2.2)
	Increase eepro100 net driver tx/rx ring sizes, to be more appropriate for 100mbit.

<arjan@redhat.com> (02/03/12 1.388.2.3)
	Add eepro100 rx soft reset function, for handling RX edge cases the driver
	currently does not handle well, if at all.
	
	Author: Steve Parker @ Sun

<arjan@redhat.com> (02/03/12 1.388.2.4)
	Update eepro100 net driver to issue soft rx reset for certain cases, fixing several
	reports of hangs or lockups (of the NIC, not the entire system).
	
	Author: Steve Parker @ Sun

<arjan@redhat.com> (02/03/12 1.388.2.5)
	Update eepro100 net driver to enable/disable its software timer
	at suspend/resume time.

<arjan@redhat.com> (02/03/12 1.388.2.6)
	eepro100 net driver bug fixes:
	* fix chip id test
	* add udelay(1) to "make [the workaround] stick"

<arjan@redhat.com> (02/03/12 1.388.2.7)
	Move pci_enable_device and associated code above first PCI resource info access.

<jgarzik@mandrakesoft.com> (02/03/12 1.388.2.8)
	Build fix: include linux/crc32.h in bmac net driver.
	
	Noticed by Joshua Uziel.

<torvalds@penguin.transmeta.com> (02/03/12 1.420)
	Update defconfig for VLAN and IDE changes

<trond.myklebust@fys.uio.no> (02/03/12 1.421)
	[PATCH] 2.5.6 Fix RPC credentials when coalescing NFS reads/writes...
	
	  The following fixes up a couple of bugs that resulted from the fix
	in 2.5.4 for ETXTBSY: Since the READ requests now only store RPC
	credentials and not the struct file, we need to be careful when
	deciding to coalesce requests on different pages into 1 RPC call that
	we compare the credentials instead of the struct file.

<trond.myklebust@fys.uio.no> (02/03/12 1.422)
	[PATCH] 2.5.6 Fix NFS file creation
	
	  The following patch fixes a bug in NFS file creation. Recently (not
	sure exactly when), open_namei() was changed so that it expects
	vfs_create() to always return a fully instantiated dentry for the new
	file.
	
	The following patch ensures this is done in the cases where the RPC
	CREATE call does not return valid attributes/filehandles. This is
	always the case for NFSv2, and can sometimes be the case for v3...

<trond.myklebust@fys.uio.no> (02/03/12 1.423)
	[PATCH] 2.5.6 correct NFS client handling of EJUKEBOX error...
	
	  The following patch resyncs 2.5.6 with the 2.4.x series w.r.t. the
	handling of the EJUKEBOX error. The latter is an NFS-specific error
	that is returned by servers that support hierarchical storage: it
	notifies the client that the request cannot be completed in a timely
	fashion (Imagine for instance a situation where you have a cdrom
	jukebox system, and the user has just requested a file on another cd).
	
	Under these circumstances, the RFC specifies that the request should
	be retried after suitable timeout during which the server will attempt
	to perform whatever action is required to make the file available
	again.

<jgarzik@mandrakesoft.com> (02/03/12 1.388.2.9)
	tg3 gige net driver update:
	* Merge several bug fixes from vger cvs
	* Merge h/w VLAN support, now that API is in the main tree
	* Add support for TX/RX coalescing

<jgarzik@mandrakesoft.com> (02/03/12 1.388.2.10)
	8139cp net driver updates:
	* Merge support for hardware vlan accel
	* Better wakeup behavior on TX completion
	* dev->mtu setting fixes

<jgarzik@mandrakesoft.com> (02/03/12 1.388.2.11)
	Add several new ethtool commands:
	coalescing, ring params, pause params, hw csum disable/enable,
	scatter-gather enable/disable

<bgerst@didntduck.org> (02/03/12 1.424)
	[PATCH] struct super_block cleanup - ncpfs
	
	Seperates ncp_sb_info from struct super_block.

<bgerst@didntduck.org> (02/03/12 1.425)
	[PATCH] struct super_block cleanup - ext2
	
	Abstract access to ext2_sb_info.

<bgerst@didntduck.org> (02/03/12 1.426)
	[PATCH] struct super_block cleanup - ext2
	
	Complete the ext2 superblock seperation.

<bgerst@didntduck.org> (02/03/12 1.427)
	[PATCH] correction to super_block cleanups
	
	I forgot to zero out the newly allocated memory in the previous patches
	for cramfs and minixfs.

<bgerst@didntduck.org> (02/03/12 1.428)
	[PATCH] correction to super_block cleanups
	
	I forgot to zero out the newly allocated memory in the previous patches
	for ext2 and ncpfs.

<viro@math.psu.edu> (02/03/12 1.429)
	[PATCH] (1/4) smarter nfs_get_sb()
	
	Switch NFS to use of NFS_SB(sb) instead of sb->u.nfs_sb.s_server

<viro@math.psu.edu> (02/03/12 1.430)
	[PATCH] (2/4) smarter nfs_get_sb()
	
	Export sget(9), deactivate_super(9) and set_anon_sb(9)

<viro@math.psu.edu> (02/03/12 1.431)
	[PATCH] (3/4) smarter nfs_get_sb()
	
	Switch NFS to separate allocation of private part of superblock,
	uss explicit sget() instead of get_sb_nodev()

<viro@math.psu.edu> (02/03/12 1.432)
	[PATCH] (4/4) smarter nfs_get_sb()
	
	Add nfs_compare_super() and teaches nfs_get_sb() to look for existing
	superblocks.

<viro@math.psu.edu> (02/03/12 1.433)
	[PATCH] removal of ->u.romfs_i
	

<bgerst@didntduck.org> (02/03/12 1.434)
	[PATCH] struct super_block cleanup - efs
	
	Separates efs_sb_info from struct super_block.

<jgarzik@mandrakesoft.com> (02/03/12 1.415.2.1)
	Make pdev_set_mwi static, at the request of David Miller.

<jgarzik@mandrakesoft.com> (02/03/13 1.415.1.2)
	Fix e100 net driver typo, from last change.
	
	Contributor: Eli Kupermann @ Intel

<dalecki@evision-ventures.com> (02/03/13 1.435)
	[PATCH] IDE 21
	
	If I was to give this patch a name it would be:
	
	"Vojtech Pavlik unleashed from the chains".
	
	So credit where credit is due :-).
	
	Anyway here follows the change log:
	
	Mon Mar 11 23:48:28 CET 2002 ide-clean-21
	
	- Swallow rewritten amd74xx host chip setup code from Vojtech Pavlik.  We can
	   revert it easly if it turns out to be a bad thing. However the code looks
	   quite sane to me. In esp. it doesn't containg that many magic numbers.
	
	- Clean stale white spaces in ide-timing.h tirvial fix.
	
	- Make ide_release_dma return void. It's value is never used anyway.
	
	- Swallow more timing setup code cleanup by Vojtech Pavlik. Apply some
	   cosmetics to it. Port opti621 to the new setup code.
	
	- Kill abuse of ide_do_reset() on error return paths for atapi floppy tape and
	   cd-rom devices. Just stop them. This gives better changes that defect
	   removable media will not cause suddenly broken timings on hard discs
	   containing system data! Even then comments in ide_do_reset() admit, that
	   resetting the whole channel can have adverse effects on the second interface
	   on this channel. And I have too frequently observed linux struggling on
	   defect cd-rom for a far too long time to wish it to continue.
	
	   Oh did I forget to say that the corresponding "how can I break my system fast
	   and reliable" ioctl is gone as well?
	
	   Removing it recovered the fact that the CONFIG_BLK_DEV_IDEDMA_TIMEOUT is
	   completely bogous. I have removed this option therefore as well, because it's
	   playing the same wrack havoc on the devices if enabled. This cat has been in
	   an unfinished and *unfunctional* state anyway.
	
	- Actually add physical suspend code to the power handling code.  Still the
	   resume code isn't finished just jet. This is all subject to change at the
	   point in time when we get to proper command queueing.
	   I think however that Pavel will be interrested in tidding this bit up...
	
	- Resync with 2.5.7-pre1.

<vojtech@suse.cz> (02/03/13 1.436)
	[PATCH] Re: [PATCH] IDE 21
	
	In the FIT macro in ide-timing.h the argument got swapped because of a
	typo. All timings generated for VIA and AMD chips are wrong because of
	that. Safe, though, but slow.
	
	This fixes it.

<adam@yggdrasil.com> (02/03/13 1.439)
	[PATCH] Patch: linux-2.5.7-pre1/net/ipv4/ipmr.c did not compile
	
		It looks like sk->num became inet_sk(sk)->num in 2.5.7-pre1,
	but one of these changes was missed in net/ipv4/ipmr.c.  Here is
	the patch.

<pazke@orbita1.ru> (02/03/13 1.440)
	[PATCH] i82092 PCMCIA driver cleanup
	
	This contains some minor changes to i82092.c PCMCIA driver:
		- MODULE_DEVICE_TABLE() added;
		- request_region() and pci_enable_device() return value checks added;
		- some printk() cleanups.

<kraxel@bytesex.org> (02/03/13 1.441)
	[PATCH] v4l: miro radio update
	
	The updates for the radio driver are all very similar:  The individual
	open functions are gone and replaced by the video_exclusive_open/release
	functions in videodev.c.  All userspace copying in the ioctl function is
	gone because video_generic_ioctl handles this now.  The driver source
	files all become slightly shorter because of this.

<kraxel@bytesex.org> (02/03/13 1.442)
	[PATCH] v4l: usbvideo update
	
	This patch adapts the usbvideo module to the videodev changes.  As with
	all usb drivers, the unplug race fix is present here too.

<kraxel@bytesex.org> (02/03/13 1.443)
	[PATCH] v4l: maxiradio update
	
	This patch updates the Maxi FM2000 Radio driver.

<kraxel@bytesex.org> (02/03/13 1.444)
	[PATCH] v4l: maestro radio update
	
	This patch updates the maestro radio driver.

<kraxel@bytesex.org> (02/03/13 1.445)
	[PATCH] v4l: gemtek radio update
	
	This patch updates the gemtek and gemtek pci radio drivers.

<kraxel@bytesex.org> (02/03/13 1.446)
	[PATCH] v4l: cadet radio update
	
	This is the cadet radio driver update.

<kraxel@bytesex.org> (02/03/13 1.447)
	[PATCH] v4l: aimslab radio update
	
	Here comes the aimslab radio driver update.

<kraxel@bytesex.org> (02/03/13 1.448)
	[PATCH] v4l: aztech radio update
	
	Here comes the aztech radio driver update.

<kraxel@bytesex.org> (02/03/13 1.449)
	[PATCH] v4l: radiotrack driver update
	
	This patch updates the radiotrack driver.

<kraxel@bytesex.org> (02/03/13 1.450)
	[PATCH] v4l: sf16fm radio update
	
	This patch updates the sf16fm radio driver.

<kraxel@bytesex.org> (02/03/13 1.451)
	[PATCH] v4l: terratec radio update
	
	This is the update for the terratec radio driver.

<kraxel@bytesex.org> (02/03/13 1.452)
	[PATCH] v4l: typhoon radio update
	
	This is the update for the typhoon radio driver.

<kraxel@bytesex.org> (02/03/13 1.453)
	[PATCH] v4l: cpia parport/usb update
	
	This patch updates the cpia driver.
	
	Additionally to the usual adoptions to the videodev changes done in all
	drivers this patch has a few more changes:
	
	 - some cleanups in the drivers open() function.
	 - Use file->private_data to keep a pointer to the drivers private
	   data.  This allows to unregister the device unconditionally in
	   disconnect(), which in turn fixes some small races in case the
	   device is unplugged while in use.

<kraxel@bytesex.org> (02/03/13 1.454)
	[PATCH] v4l: stv usb camera update
	
	This patch adapts the stv usb camera driver to the videodev changes and
	fixes the unplug race.

<kraxel@bytesex.org> (02/03/13 1.455)
	[PATCH] v4l: ov511 usb cam update
	
	This patch adapts the ov511 driver to the videodev changes.  As Mark
	McClelland already sent in a patch with updates this just deletes the
	now obsolete code for the most part.  The unplug-while-in-use race fix
	is also there.

<kraxel@bytesex.org> (02/03/13 1.456)
	[PATCH] v4l: pwc webcam update
	
	This patch adapts the philips webcam driver to the videodev changes.
	Also has the unplug race fix.

<kraxel@bytesex.org> (02/03/13 1.457)
	[PATCH] v4l:
	
	This patch adapts the se401 driver to the videodev changes and fixes the
	unplug race.

<kraxel@bytesex.org> (02/03/13 1.458)
	[PATCH] v4l: quickcam update
	
	This patch updates the parallel port quickcam drivers (bw+color).

<kraxel@bytesex.org> (02/03/13 1.459)
	[PATCH] v4l: saa5249 videotext driver update
	
	This patch updates the saa5249 videotext driver.

<kraxel@bytesex.org> (02/03/13 1.460)
	[PATCH] v4l: vicam usb camera update
	
	This patch updates the vicam usb camera driver.  videodev adaptions are
	there, and the unplug race fix.  I also did plenty of other small
	cleanups and fixes, lots of forgotten breaks in the big ioctl switch for
	example.  I wouldn't be surprised if the driver didn't work at all ...

<kraxel@bytesex.org> (02/03/13 1.461)
	[PATCH] v4l: trust radio update
	
	This is the update for the trust radio driver.

<kraxel@bytesex.org> (02/03/13 1.462)
	[PATCH] v4l: DSB usb radio driver update
	
	This patch adapts the DSB usb radio driver to the videodev changes.

<kraxel@bytesex.org> (02/03/13 1.463)
	[PATCH] v4l: mediavision pms update
	
	This patch updates the mediavision pms video driver.

<kraxel@bytesex.org> (02/03/13 1.464)
	[PATCH] v4l: w9966 update
	
	This patch updates the Winbond w9966cf parport webcam driver.

<kraxel@suse.de> (02/03/13 1.465)
	[PATCH] snd: btaudio update
	
	This patch updates the btaudio sound driver.  It fixes a bug in the poll
	function, makes the driver a bit more verbose at insmod time, adds a
	insmod option for the pci latency timer and does some minor cleanups.

<kraxel@suse.de> (02/03/13 1.466)
	[PATCH] v4l: bttv i2c audio update
	
	This patch updates the i2c audio chip modules.  It improves the support
	for tda9874x chips.  There are some bugfixes.  It also has alot of small
	cleanups: switch some modules to new initialization, declare lots of
	functions static, ...  which make the patch a bit large.

<kraxel@bytesex.org> (02/03/13 1.467)
	[PATCH] v4l: new videobuf helper module
	
	This patch adds a helper module to manage pci dma buffers for video
	frames.  I've recently started writing a driver for another frame
	grabber / TV card chip and tried to separate out common code to avoid
	duplicating code.  The bttv core update (next mail) depends this patch.

<kraxel@suse.de> (02/03/13 1.468)
	[PATCH] v4l: bttv tuner update
	
	This patch is a update for the tuner module which controls the tuner
	chip on TV cards.  No major changes, lots of small cleanups: make
	functions static, switch to name-based initialization for structs, ...

<kraxel@bytesex.org> (02/03/13 1.469)
	[PATCH] v4l: bttv doc update
	
	This patch updates the documentation for the bttv driver.

<kraxel@bytesex.org> (02/03/13 1.470)
	[PATCH] v4l: major bttv update
	
	This is a major update of the bttv core (0.7.x to 0.8.x).  There are way
	too many changes to list them all, the complete core code for video
	frame capture has been rewritten from scratch.

<eranian@hpl.hp.com> (02/03/13 1.388.1.19)
	[PATCH] Fix ia64 perfmon for 2.5.6
	
	Fix up earlier perfmon breakage.

<petkan@users.sourceforge.net> (02/03/13 1.415.3.2)
	email address changes.

<greg@kroah.com> (02/03/13 1.415.3.3)
	USB pegasus driver
	
	Elcon vendor/device support added.

<greg@kroah.com> (02/03/13 1.415.3.4)
	USB edgeport driver
	
	Fixed bug that prevented multiple edgeport devices from working at once.

<davem@nuts.ninka.net> (02/03/13 1.384.4.11)
	SPX updates from Arnaldo Carvalho de Melo:
	- CodingStyle cleanups
	- Adds MODULE_LICENSE
	- Fix missing release_sock calls
	- Remove leftovers from sock cleanup patches
	- Use skb_queue_purge

<tapio@iptime.fi> (02/03/13 1.415.3.5)
	USB Emagic EMI 2I6 support to kernel
	  
	Here is patch against linuxusb.bkbits.net LINUX_2.4.19-pre2 export, which
	adds Emagic EMI 2|6 usb audio interface firmware loader support to linux
	kernel.
	I also have other kernel patches and emi26 cvs export available at:
	http://www.vtoy.fi/~tapio/emi26.html

<davem@nuts.ninka.net> (02/03/13 1.384.4.12)
	Fix IPv4 multicast router build failure caused
	by struct sock cleanups.

<ganesh@tuxtop.vxindia.veritas.com> (02/03/13 1.415.3.6)
	USB ipaq driver
	
	Fixed a panic caused by the line discipline echoing characters. It
	also fixes a problem where the echoing messes up ppp chat.

<davem@nuts.ninka.net> (02/03/13 1.384.7.15)
	Sparc64 updates:
	1) Fix EBUS register probing
	2) Add some missing ioctl32 translations
	3) Add sys_futex entries for sparc/sparc64
	4) Add platform-specific pcibios_set_mwi implementation
	   for sparc64
	5) Fix set_brkpkt implementation so it works on UltraSPARC-III

<bfennema@falcon.csc.calpoly.edu> (02/03/13 1.474)
	[PATCH] udf patch for 2.5.7-pre1 (part 1/4)
	
	This patch adds some missing byte swaps needed for big endian archs.

<bfennema@falcon.csc.calpoly.edu> (02/03/13 1.475)
	[PATCH] udf patch for 2.5.7-pre1 (part 2/4)
	
	This patch fixes writing the descriptor version for udf revisions >= 2.0

<bfennema@falcon.csc.calpoly.edu> (02/03/13 1.476)
	[PATCH] udf patch for 2.5.7-pre1 (part 3/4)
	
	This patch fixes an extent preallocation bug and adds missing sb_bread == NULL
	checks.

<bfennema@falcon.csc.calpoly.edu> (02/03/13 1.477)
	[PATCH] udf patch for 2.5.7-pre1 (part 4/4)
	
	This patch moves the udf spec header files into the fs/udf directory and
	removes all the non-standard sized typedefs.

<davidm@wailua.hpl.hp.com> (02/03/13 1.388.1.20)
	offsets.h:
	  Update offsets.h
	defconfig:
	  Update defconfig.

<davidm@hpl.hp.com> (02/03/13 1.388.1.21)
	[PATCH] More 2.5.6 sync up.
	
	Take advantage of new per-CPU scheme.

<davem@nuts.ninka.net> (02/03/13 1.384.7.16)
	Sparc64 build fix:
	Kill references to obsolete BLK{F}RA{SET,GET} ioctls.

<davem@nuts.ninka.net> (02/03/13 1.384.4.13)
	Integrate NAPI work done by Jamal Hadi Salim,
	Robert Olsson, and Alexey Kuznetsov.  This changeset adds
	the framework and implementation, but drivers need to be
	ported to NAPI in order to take advantage of the new
	facilities.  NAPI is fully backwards compatible, current
	drivers will continue to work as they always have.
	
	NAPI is a way for dealing with high packet load.  It allows
	the driver to disable the RX interrupts on the card and enter
	a polling mode.  Another way to describe NAPI would be as
	implicit mitigation.  Once the device enters this polling
	mode, it will exit back to interrupt based processing when
	the receive packet queue is purged.
	
	A full porting and description document is found at:
	Documentation/networking/NAPI_HOWTO.txt
	and this also makes reference to Usenix papers on the
	web and other such resources available on NAPI.
	
	NAPI has been found to not only increase packet processing
	rates, it also gives greater fairness to the other interfaces
	in the system which are not experiencing high packet load.

<davidm@hpl.hp.com> (02/03/13 1.388.4.1)
	[PATCH] More 2.5.6 sync up.
	
	Take advantage of new per-CPU scheme.

<davem@nuts.ninka.net> (02/03/13 1.384.7.17)
	Stack overflow debugging support.
	From Kanoj Sarcar.

<davem@nuts.ninka.net> (02/03/13 1.384.7.18)
	Verify stack more accurately in sparc64 stack overflow
	debugger by taking the FPU save area depth into
	consideration.

<jgarzik@mandrakesoft.com> (02/03/13 1.473.2.1)
	Small cleanups for the PCI MWI feature:
	* Generic helper function name change, s/pdev_set_mwi/pci_generic_prep_mwi/
	* Fix: Generic helper function ifdef'd out if arch function present
	* PCI MWI arch handler name change, s/pcibios_set_mwi/pcibios_prep_mwi/
	* Fix typos and speling errors in comments.
	* Cleanup printk message a bit.

<davem@nuts.ninka.net> (02/03/13 1.384.7.19)
	On sparc64, do not put PAGE_OFFSET in g4 anymore,
	put current task there instead.

<davidm@wailua.hpl.hp.com> (02/03/14 1.473.1.2)
	Make main-title more concise.
	Rename "General setup" to "Processor type and features".
	Move ACPI types after the point where HP_SIM gets defined.
	Pick up HP Ski configuration options from arch/ia64/hp/Config.in.

<stelian@popies.net> (02/03/14 1.473.3.1)
	Port the MotionEye driver to the new video4linux API.

<sawa@yamamoto.gr.jp> (02/03/15 1.473.4.1)
	Fix bug in at1700 net driver:
	RX_MODE was not set for the multicast case.  Set it.  Fixes multicast.

<bcrl@redhat.com> (02/03/15 1.473.4.2)
	Updates to ns83820 gige net driver:
	* Use likely() and unlikely() for better branch prediction
	* Various small cleanups
	* Much improved interrupt mitigation
	* Much improved throughput

<eli.kupermann@intel.com> (02/03/15 1.473.4.3)
	e100 net driver update 1/4:
	- minor changes to the license from our technical writer [still GPL ;-)]

<eli.kupermann@intel.com> (02/03/15 1.473.4.4)
	e100 net driver update 2/4:
	- remove dummy defines and also ia64 specific [Arjan's notes  [:-)] ]
	- fixed problem in e100_check_options function reported by our Q/A

<eli.kupermann@intel.com> (02/03/15 1.473.4.5)
	e100 net driver update 3/4:
	- added pci flushing in the e100_set_intr_mask function (pci posting bug)
	- better logic in the prepare_xmit_buff function moving some tx
	buffer initialization code to the start of the function.

<eli.kupermann@intel.com> (02/03/15 1.473.4.6)
	e100 net driver update 4/4:
	- switch to yield function as suggested by you, Arjan and Andrew.
	- fixed broken logic in the use of time_before/time_after - possible
	bug cause in previous design - in most of the places we were going to sleep
	and than check if time expires before checking if condition is satisfied.
	If, for example, we needed to wait up to 3 jiffies we could do
	schedule_timeout(1) and get up after 4 ticks check that time expired and go
	away crying about failure without checking that condition is OK.(in fact I
	saw it happen on one SMP platform here).

<jes@wildopensource.com> (02/03/15 1.473.4.8)
	acenic gige net driver updates:
	* various small cleanups
	* ETHTOOL_GDRVINFO support

<jes@wildopensource.com> (02/03/15 1.473.4.9)
	acenic gige net driver fixes:
	* fix Tigon I support
	* fix memory leak

<jgarzik@mandrakesoft.com> (02/03/15 1.473.4.10)
	acenic gige net driver update: merge VLAN support from 2.4.x kernel

<linux-m68k.org@mandrakesoft.com> (02/03/15 1.473.2.2)
	clgenfb fixes for zorro bus.  clgenfb should work again on m68k.

<wstinson@infonie.fr> (02/03/15 1.473.2.3)
	Fix rocketport serial driver for kdev_t changes in early 2.5.x series.

<wstinson@infonie.fr> (02/03/15 1.473.2.4)
	Janitor: request_region cleanups for stallion serial driver

<p_gortmaker@yahoo.com> (02/03/15 1.473.4.11)
	lance net driver update:  mark lance_probe as __init

<nahshon@actcom.co.il> (02/03/15 1.473.2.5)
	Fix via audio recording, when frag size < page size.

<silicon@falcon.sch.bme.hu> (02/03/15 1.473.2.6)
	Add new slicecom/munish WAN driver.

<jt@bougret.hpl.hp.com> (02/03/15 1.473.4.12)
	Convert hp100 net driver to PCI DMA mapping API.  (fixes build)

<jgarzik@mandrakesoft.com> (02/03/15 1.473.4.13)
	Don't include linux/delay.h twice in eepro100 net driver.
	
	Noticed by Alan Cox.

<jgarzik@mandrakesoft.com> (02/03/15 1.473.4.14)
	Fix e1000 net driver build with newer binutils.

<davem@nuts.ninka.net> (02/03/15 1.384.4.14)
	Netfilter updates from Harald Welte and myself:
	1) implement missing ip_conntrack_protocol_unregister function
	2) export ip_conntrack_unexpect_related symbol
	3) add support for destination nat on locally initiated connections
	4) add hooks for the filtering of ARP packets

<jgarzik@mandrakesoft.com> (02/03/15 1.473.2.7)
	Add BK kernel howto text and some helper scripts to
	new subdirectory linux/Documentation/BK-usage.

<j-nomura@ce.jp.nec.com> (02/03/15 1.473.1.4)
	[PATCH] Fix IA-32 Intercept code.
	
	(ia32_intercept): The code for Locked data reference fault is 4, not 3.

<kai@tp1.ruhr-uni-bochum.de> (02/03/15 1.473.6.1)
	Fix drivers/pnp/Makefile to correctly list multi-part
	objects in $(list-multi), instead of $(multi-objs)

<kai@tp1.ruhr-uni-bochum.de> (02/03/15 1.473.6.2)
	Improve Rules.make to automatically generate link rules for composite
	objects.
	
	Current behavior is not changed at all, but see the next cset for what
	it's good for.
	

<kai@tp1.ruhr-uni-bochum.de> (02/03/15 1.473.6.3)
	Remove link rules for multi-part drivers in drivers/isdn/*/Makefile.

<dhowells@redhat.com> (02/03/15 1.483)
	[PATCH] wait4() WIFSTOPPED starvation fix #1/2
	
	This patch (#1) just converts the task_struct to use struct list_head rather
	than direct pointers for maintaining the children list.

<torvalds@home.transmeta.com> (02/03/15 1.484)
	Cleanup: use list macros for task list

<dhowells@redhat.com> (02/03/15 1.485)
	[PATCH] wait4() WIFSTOPPED starvation fix #2/2
	
	This patch actually fixes the starvation bug in sys_wait4() by moving any
	process which is serviced for stoppage to the end of the child list.

<rmk@arm.linux.org.uk> (02/03/15 1.486)
	[PATCH] 2.5 and 2.4: fix PCI IO BAR flags
	
	There is a problem where the resource flags sometimes contain bits from
	the address part of the PCI BAR, especially when you have the low address
	bit set for an IO BAR.
	
	(bit 3 of a PCI IO BAR is an address bit, and (bar & 0xf) propagates this
	to res->flags).
	
	This exists in Ivan Kokshaysky PCI patches, and so far hasn't made it into
	the kernel.  It's required for IDE on certain ARM machines to even work.

<rmk@arm.linux.org.uk> (02/03/15 1.487)
	[PATCH] 2.4 and 2.5: remove Alt-Sysrq-L
	
	The following patch removes Alt-Sysrq-L and its associated hack to kill
	of PID1, the init process.  This is a mis-feature.
	
	If PID1 is killed, the kernel immediately enters an infinite loop in the
	depths of do_exit() with interrupts disabled, completely locking the
	machine.  Obviously you can only reach for the reset button or power
	switch after this, leaving you with dirty filesystems.

<rmk@arm.linux.org.uk> (02/03/15 1.488)
	[PATCH] 2.4 and 2.5: fix /proc/kcore
	
	As mentioned on May 11 on LKML, here is a patch to fix /proc/kcore for
	architectures which do not have RAM located at physical address 0.

<viro@math.psu.edu> (02/03/15 1.490)
	[PATCH] fs/libfs.c
	
		Linus, I've taken a bunch of common methods into fs/libfs.c and
	killed the (duplicated) instances in filesystems.  There will be more -
	ideally I'd like to get a library that would make writing small filesystems
	trivial.

<viro@math.psu.edu> (02/03/15 1.491)
	[PATCH] fix for leaks in nfsd
	
	Several exits in exp_export() forget to call path_release().  Fixed.

<viro@math.psu.edu> (02/03/15 1.492)
	[PATCH] nfsd as filesystem
	
	* introduces a new filesystem - nfsd.  No, it's not a typo.  It's a small
	  tree with fixed topology defined by nfsd and IO on its files does what
	  we used to do by hand in nfsctl.c.
	* turns sys_nfsservctl() into a sequence of open()/write()/read()/close()
	  It works as it used to - we don't need nfsd to be mounted anywhere, etc.
	* nfsd_linkage ugliness is gone.
	* getfs and getfh demonstrate (rather trivial) example of "descriptor as
	  transaction descriptor" behaviour.
	* we are fairly close to the situation when driver-defined filesystems can
	  be done with practically zero code overhead.  We are still not there, but
	  it's a matter of adding a couple of helpers for populating the tree.
	
		One thing we get immediately is a cleanup of sys_nfsservctl() -
	it got _much_ better.  Moreover, we get an alternative interface that
	uses normal file IO and can be used without magic syscalls.

<viro@math.psu.edu> (02/03/15 1.493)
	[PATCH] proc_pid_make_inode() fix
	
		In case if proc_pid_make_inode() steps on exiting task we do
	iput() and return NULL.  Unfortunately, in that case inode->i_ino
	doesn't look like inumber of a per-process inode and we take the
	wrong path in proc_delete_inode().  I.e. do dput(PDE(inode)).  Which
	is left uninitialized...
	
		We used to get out with that almost by accident - that code
	worked only because we had zeroed out one field of union and that
	guaranteed that another field would be NULL.  It worked, but broke
	at the first occasion.

<viro@math.psu.edu> (02/03/15 1.494)
	[PATCH] nfsd-as-fs NULL ptr fix
	
	It needs the following patch

<torvalds@home.transmeta.com> (02/03/15 1.495)
	Fix up architectures for task list changes

<bgerst@didntduck.org> (02/03/15 1.496)
	[PATCH] Cleanup F00F bug code
	
	This changes the F00F bug workaround code to use the fixmap facilities
	instead of touching the page tables directly.  It also removes the
	assumption that only 686's don't have the bug.  I have confirmation that
	the patch works on buggy pentiums. 

<bgerst@didntduck.org> (02/03/15 1.497)
	[PATCH] Fix NR_IRQS when no IO apic
	
	NR_IRQS should be 16 when the IO apic is not configured, as the 8259 PIC
	cannot generate any more interrupts.  It also fixes a bug where the IDT
	gets populated with random addresses, since only 16 entry stubs are
	created. 

<bgerst@didntduck.org> (02/03/15 1.498)
	[PATCH] struct super_block cleanup - msdos/vfat
	
	Seperates msdos_sb_info from struct super_block for msdos and vfat.
	Umsdos is terminally broken and is not included.

<bgerst@didntduck.org> (02/03/15 1.499)
	[PATCH] struct super_block cleanup - smbfs
	
	Seperates smb_sb_info from struct super_block.

<bgerst@didntduck.org> (02/03/15 1.500)
	[PATCH] struct super_block cleanup - qnx4
	
	Seperates qnx4_sb_info from struct super_block.

<bgerst@didntduck.org> (02/03/15 1.501)
	[PATCH] struct super_block cleanup - msdos/vfat
	
	Don't print out FAT superblock warnings if the IO failed.

<mikpe@csd.uu.se> (02/03/15 1.503)
	[PATCH] boot_cpu_data corruption on SMP x86
	
	The patch below eliminates a case of boot_cpu_data corruption
	on SMP x86 machines. This was first observed on SMP Athlons,
	but it also affects SMP Intel boxes in a less serious way.
	
	When the secondary processors boot and execute head.S:checkCPUtype,
	the code performs a 32-bit write of a small constant to the
	byte-sized variable boot_cpu_data.x86 (X86 in head.S). Since the
	write is 32-bit, it also writes zeros to the following 3 bytes,
	which clobbers the x86_vendor, x86_model, and x86_mask fields
	previously set up by check_bugs()'s call to identify_cpu().
	Thus, after smp_init(), boot_cpu_data will _always_ identify
	the CPU as an Intel (X86_VENDOR_INTEL == 0 in processor.h) with
	model 0 and stepping 0.
	
	The effect in standard kernels is not catastrophic, since:
	(a) most SMP x86 boxes are Intel
	(b) most uses of x86_vendor occur before smp_init() or reference
	    the SMP cpu_data[] array
	(c) most post-boot references to boot_cpu_data occur in the
	    cpu_has_XXX macros which only read the x86_capability[] array
	However, third-party extensions (like my x86 performance-monitoring
	conters driver) can get seriously confused by this mis-identification.

<agrover@groveronline.com> (02/03/15 1.504)
	[PATCH] ACPI patch 1/9
	
	This is the first of 9 patches. We did a complete rewrite of the
	Linux-specific code, so we wait for things to stabilize before submitting.
	There will be more updates, but *much* smaller.
	
	#1 - this updates the header file.

<agrover@groveronline.com> (02/03/15 1.505)
	[PATCH] ACPI patch 2/9
	
	This patch adds in the new drivers.
	
	- Support for driverfs
	- File/code layout more in the Linux style
	- improvements to battery, processor, and thermal support

<agrover@groveronline.com> (02/03/15 1.506)
	[PATCH] ACPI patch 3/9
	
	This patch updates the acpi IA32 arch-specific files. Part of this is
	taking what was acpitable.c and implementing it with better integration
	with the rest of the ACPI code.

<agrover@groveronline.com> (02/03/15 1.507)
	[PATCH] ACPI patch 4/9
	
	This is the config.in and makefile changes for the latest code. The most
	(only) interesting thing probably is ACPI is no longer flagged experimental.

<agrover@groveronline.com> (02/03/15 1.508)
	[PATCH] ACPI patch 5/9
	
	This is the update to the core interpreter code.

<agrover@groveronline.com> (02/03/15 1.509)
	[PATCH] ACPI patch 6/9
	
	This removes the old OSPM code. It lived under drivers/acpi/ospm/*, but
	the new code just lives in drivers/acpi, and removes some unnecessary
	abstraction that this old code had.

<agrover@groveronline.com> (02/03/15 1.510)
	[PATCH] ACPI patch 7/9
	
	This updates the Configure.help, both in arch/i386, and in drivers/acpi.

<agrover@groveronline.com> (02/03/15 1.511)
	[PATCH] ACPI patch 8/9
	
	This patch removes arch/i386/kernel/acpitable.c. As mentioned previously,
	the new ACPI code integrates this, so it's no longer needed.

<agrover@groveronline.com> (02/03/15 1.512)
	[PATCH] ACPI patch 9/9
	
	If you could only review one of the 9 patches, this would be the one.
	
	- removes acpitable.c vestiges
	- adds ACPI IRQ routing support to PCI (disableable via pci=noacpi option)
	- adds code to get a <1MB page for sleep, and ACPI boot to setup.c
	- allocates another page in the fixmap for ACPI
	- changes driverfs a little to work better with ACPI.

<torvalds@home.transmeta.com> (02/03/15 1.514)
	Fix overenthusiastic ia64 merge.
	
	That preempt_count really is supposed to be unconditional,
	architectures please take note and add to your thread info.

<davidm@napali.hpl.hp.com> (02/03/15 1.515)
	[PATCH] binfmt_elf.c: do SET_PERSONALITY() for static binaries
	
	Pick up binfmt_elf.c SET_PERSONALITY() fix from 2.4.18.

<cr@sap.com> (02/03/15 1.516)
	[PATCH] sync shmem.c in 2.5 to 2.4
	
	The appended patch brings the fixes applied in 2.4 to shmem.c to 2.5.
	
	In Detail:
	- Add needed checks for shmem_file_write and shmem_symlink
	- Add Documentation/filesystems/tmpfs.txt and adjust Config.help
	- Add uid and gid mount options
	- Make the error messages more user friendly

<torvalds@home.transmeta.com> (02/03/15 1.517)
	Trivial compile fix

<rem@osdl.org> (02/03/15 1.518)
	[PATCH] 2.5.7-pre1 Code cleanup for BSD accounting.
	
	Clean up BSD accounting locking code..

<torvalds@home.transmeta.com> (02/03/15 1.519)
	Fix up ACPI device breakage.
	
	For some reason the ACPI people continue to make the mistake
	of thinking that they are the root of the system.  Disabuse
	them of that notion.

<torvalds@home.transmeta.com> (02/03/15 1.520)
	Make sk_flags unsigned long, since we do bit operations on it

<torvalds@home.transmeta.com> (02/03/15 1.521)
	Update kernel version

<torvalds@penguin.transmeta.com> (02/03/15 1.522)
	update


Summary of changes from v2.5.6 to v2.5.7-pre1
============================================

<torvalds@penguin.transmeta.com> (02/03/08 1.385)
	Fix parport_cs compile troubles

<torvalds@penguin.transmeta.com> (02/03/08 1.386)
	Split out "msync" logic into a file of its own. No actual code
	changes.

<torvalds@penguin.transmeta.com> (02/03/08 1.387)
	msync cleanups

<torvalds@penguin.transmeta.com> (02/03/08 1.388)
	mm cleanup: split out mincore() system call from filemap.c

<torvalds@home.transmeta.com> (02/03/08 1.389)
	Fix missing '!' in set_fs_altroot() 

<davidm@wailua.hpl.hp.com> (02/03/09 1.369.15.1)
	ia64-patches

<davidm@wailua.hpl.hp.com> (02/03/09 1.369.15.2)
	This patch got dropped from the VM_DATA_DEFAULT_FLAGS patch sent earlier.

<davidm@wailua.hpl.hp.com> (02/03/09 1.369.15.3)
	Update EFI RTC driver to version 0.3.

<davidm@wailua.hpl.hp.com> (02/03/09 1.369.15.4)
	Fix two typos in comments.

<ch@hpl.hp.com> (02/03/09 1.375.2.18)
	[PATCH] 1033/1: latest 2.5.x badge4 def-config

<davidm@wailua.hpl.hp.com> (02/03/09 1.369.15.5)
	p4

<davidm@wailua.hpl.hp.com> (02/03/09 1.369.15.6)
	pci.c:
	  Print values of type dma_addr_t by casting to unsigned long and using the %lx format.

<davidm@wailua.hpl.hp.com> (02/03/09 1.369.15.7)
	as-flags.diff

<stefan.eletzhofer@eletztrick.de> (02/03/09 1.375.2.19)
	[PATCH] 1008/1: PCMCIA MECR handling
	This patch changes PCMCIA MECR handling such that:
		- MECR is changed in one function only and atomically
		- a additional callback for boards to allow them to
		  tweak BS values on a per-socket basis
	
	Note: I don't know wether or not tish changes are WIP or done
	already. If so, please drop it and send me a note.
	
	Changes files:
	linux/drivers/pcmcia/sa1100_generic.h
	linux/drivers/pcmcia/sa1100_generic.c
	

<xkaspa06@stud.fee.vutbr.cz> (02/03/09 1.375.2.20)
	[PATCH] 1039/1: EXPORT_SYMBOL(dma_spin_lock) for ALSA
	
	Even I do not realy use any ISA code of ALSA on my iPAQ I need it for compilation. As I build ALSA as modules, the dma_spin_lock symbol is missing.
	
	I have seen both definitions of dma_spin_lock (in kernel/dma.c and arch/arm/kernel/dma.c) same as EXPORT_SYMBOL in kernel/ksyms.c, but I think, exporting it in arch/arm/kernel/dma.c should be better then making confusion in kernel/ksyms.c
	
	2Russel: If you don't think this is good solution, we should discuss this in linux-arm-kernel mailing list
	

<src@flint.arm.linux.org.uk> (02/03/09 1.384.1.1)
	Update Makefile, sa1110 cpufreq code.  Drop static flash mapping from
	system3.c

<davidm@wailua.hpl.hp.com> (02/03/09 1.375.25.2)
	Fixup bad merge.

<xkaspa06@stud.fee.vutbr.cz> (02/03/09 1.384.1.3)
	[PATCH] 1036/1: allow APM to be build as module (for 2.5.5) (modified)
	
	This is updated version of patch 1002/1 . As build system in 2.5.5 kernel allows same name of .c files in different directories when computing dependencies and versioning information, the patch becomes simple. Now it just modify appropriate Makefile (in arch/arm/mach-sa1100) and exports one symbol in arch/arm/mach-sa10/pm.c)
	
	This patch replace 1002/1.
	
	(Hope, this is what you want Russel :)

<davidm@wailua.hpl.hp.com> (02/03/09 1.375.25.3)
	Fix formatting in Makefile.

<rmk@flint.arm.linux.org.uk> (02/03/10 1.375.12.3)
	Re-jig ARMv3 and up page table handing for better correctness with
	Ingo's highmem code.  This also helps with Riel's rmap VM, and
	eliminates the slab overhead for these processors.
	
	For more information, see:
	http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2002-March/008089.html

<jamey@crl.dec.com> (02/03/10 1.384.1.4)
	[PATCH] 889/1: updated jornada720 config file
	
	Updates the jornada720 config file to build with 2.4.17-rmk4

<rmk@flint.arm.linux.org.uk> (02/03/10 1.384.2.1)
	Make iq80310_gettimeoffset() return the currect time delta.
	Remove redundant irq_enter/irq_exit calls.

<rmk@flint.arm.linux.org.uk> (02/03/10 1.384.2.2)
	Fix up couple of bugs in Integrator PCI code.

<nico@cam.org> (02/03/10 1.384.1.5)
	[PATCH] 995/1: better EBSA110 idle
	
	This should bring better performances as all interrupts are always run with 
	clock switching enabled and the idle spinning always with the lower clock.
	
	This also keeps the brokenness of that architecture localized while 
	preserving the sanity of the common SA idle function.
	

<rmk@flint.arm.linux.org.uk> (02/03/10 1.384.2.3)
	Tidy up abort handler selection.  Use new glue.h to select relevant
	handler to allow for better optimisation.

<rmk@flint.arm.linux.org.uk> (02/03/10 1.384.2.4)
	Split out copy_user_page/clear_user_page to allow more efficient
	selection depending on processor features.

<rusty@rustcorp.com.au> (02/03/10 1.390)
	[PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
	
	Fast user-space mutex implementation, allowing user space to do all
	of the normal handling, with a minimal fallback to kernel space for
	when there is lock contention.
	
	The kernel space implementation does not keep any per-lock data
	structures, but instead does a fast hash on the physical page and offset
	of the user-space lock when contended.  Thus no build/teardown costs, or
	any scalability costs wrt metadata.
	
	Updated syscall numbers for 2.5.6, and changed FUTEX_UP/DOWN definitions
	to be more logical for future expansions (eg.  r/w).

<davem@nuts.ninka.net> (02/03/11 1.384.4.1)
	Move IP-specific identity information
	out of struct sock.
	Fix -EFAULT handling in TCP direct user copy handling.
	Use struct initializers in IPV6 ndisc code.

<davem@nuts.ninka.net> (02/03/11 1.384.4.2)
	Remove bogus tw->tb NULL check in
	tcp_timewait_kill.  This is what made the following
	bug harder to find:
	Put new timewait buckets into the bind hash _FIRST_
	before they appear into the established hash to
	kill some races with socket creation/lookup.

<davem@nuts.ninka.net> (02/03/11 1.384.4.3)
	Avoid using read/modify/write cycles to
	set frag_off field of IPv4 header in hot paths.
	Use __constant_htons as appropriate.

<davem@nuts.ninka.net> (02/03/11 1.384.4.4)
	Do not report inode numbers as negative
	in networking procfs nodes

<davem@nuts.ninka.net> (02/03/11 1.384.4.5)
	Export ip_net_protocol_{register,unregister}
	and ip_nat_used_tuple.
	Minor cleanups to conntrack/irc modules/configuration.
	From Harald Welte and the netfilter team.

<davem@nuts.ninka.net> (02/03/11 1.384.4.6)
	Never set IP_DF for ICMP packets.

<davem@nuts.ninka.net> (02/03/11 1.384.4.7)
	RED packet scheduler bug fixes from
	Jamal Hadi Salim.

<davem@nuts.ninka.net> (02/03/11 1.384.4.8)
	Make sock_writeable (used mostly by datagram
	protocols) more reasonable.  Kill all references
	to SOCK_MIN_WRITE_SPACE and kill its definition.
	Replace with appropriate sock_writeable calls.

<davem@nuts.ninka.net> (02/03/11 1.384.4.9)
	sock_register inet6_family_ops before we do init
	calls which might try to create ipv6 sockets.

<davem@nuts.ninka.net> (02/03/11 1.384.4.10)
	Major revamp of VLAN layer:
	1) Add hw acceleration hooks for device drivers.
	2) Move private declarations out of public includes.
	3) Mark file local functions and data as static.
	4) Use a small hash table for VLAN group lookups.
	5) Correct all the locking and device ref counting.
	6) No longer mark it as CONFIG_EXPERIMENTAL.

<davem@nuts.ninka.net> (02/03/11 1.384.5.1)
	Fix scheduler deadlock on some platforms.
	
	Some platforms need to grab mm->page_table_lock during switch_mm().
	On the other hand code like swap_out() in mm/vmscan.c needs to hold
	mm->page_table_lock during wakeups which needs to grab the runqueue
	lock.  This creates a conflict and the resolution chosen here is to
	not hold the runqueue lock during context_switch().
	
	The implementation is specifically a "frozen" state implemented as a
	spinlock, which is held around the context_switch() call.  This allows
	the runqueue lock to be dropped during this time yet prevent another cpu
	from running the "not switched away from yet" task.

<davem@nuts.ninka.net> (02/03/11 1.384.5.2)
	Fix CAN_MIGRATE_TASK macro to use p arg it gets
	instead of tmp explicitly.

<davem@nuts.ninka.net> (02/03/11 1.384.5.3)
	Use cpu_logical_map as appropriate.

<davem@nuts.ninka.net> (02/03/11 1.384.5.4)
	If cache_decay_ticks is large enough, the migration
	thread startup at boot time can fail.
	Fix this by temporarily setting cache_decay_ticks
	to zero around migration thread startup.

<davem@nuts.ninka.net> (02/03/11 1.384.6.1)
	Add back check_pgt_cache call.
	Add nop definition for x86.

<davem@nuts.ninka.net> (02/03/11 1.384.6.2)
	Fix typos.

<rmk@flint.arm.linux.org.uk> (02/03/11 1.384.1.8)
	Fix up spinlocking/IRQ handling in SCSI drivers for Acorn machines.

<rmk@flint.arm.linux.org.uk> (02/03/11 1.384.1.9)
	Bug fixes for Acorn network drivers.

<rmk@flint.arm.linux.org.uk> (02/03/11 1.384.1.10)
	Update Acorn serial drivers.

<davem@nuts.ninka.net> (02/03/11 1.384.7.1)
	Sparc64 updates mostly build fixes:
	1) Update for schedule_tail and switch_to arg changes.
	2) Update for PTE highmem.
	3) Add random ioctls to ioctl32 translations.
	4) Kill migration IPI.
	5) Fixup scheduler bitmap function and move into bitops.h

<davem@nuts.ninka.net> (02/03/11 1.384.7.2)
	Do not expand stack for non-faulting loads

<davem@nuts.ninka.net> (02/03/11 1.384.7.3)
	Fix PCI IRQ probing for some bridging situations.
	Use PCI_SLOT instead of hard-coded shift.

<davem@nuts.ninka.net> (02/03/11 1.384.7.4)
	Use pci_memspace_mask instead of hard-coded
	value 0xffffffff.

<davem@nuts.ninka.net> (02/03/11 1.384.7.5)
	Work around some hw bugs in Schizo PCI controllers.

<davem@nuts.ninka.net> (02/03/11 1.384.7.6)
	Use dma_addr_t for hblock_dvma.
	Make device probe failure more robust.

<davem@nuts.ninka.net> (02/03/11 1.384.7.7)
	Init FHC controller registers earlier so that
	Zilog interrupt mappings are not clobbered on
	Sun Enterprise servers.
	Fix some FHC register offsets.
	Sometimes IPIs can allow BHs to run with interrupts
	disabled, fix that by rescheduling them to normal
	PIL based interrupts.

<davem@nuts.ninka.net> (02/03/11 1.384.7.8)
	Read lock around files->fd[] accesses.

<davem@nuts.ninka.net> (02/03/11 1.384.7.9)
	Add SI_DETHREAD

<davem@nuts.ninka.net> (02/03/11 1.384.7.10)
	Add per_cpu linker script bits for Sparc.

<bcrl@toomuch.toronto.redhat.com> (02/03/11 1.384.8.1)
	Avoid looping in write_inode_now since the sync_one changes now ensure __sync_one 
	is called once the inode is unlocked.

<dalecki@evision-ventures.com> (02/03/11 1.388.1.1)
	[PATCH] 2.5.6 IDE 18
	
	No fixes for new problems which occured since today, just syncup.
	
	 - Remove help text about suitable compiler versions, which is obsoleted
	   by the overall kernel reality.
	
	 - Remove traces of not progressing work in progress code for the
	   CONFIG_BLK_DEV_ADMA option as well as the empty ide-adma.c file as
	   well as CONFIG_BLK_DEV_IDEDMA_TCQ.
	
	 - Remove redundant CONFIG_BLK_DEV_IDE != n check in ide/Config.in. Hugh,
	   this is a tricky one...
	
	 - Add EXPORT_SYMBOL(ide_fops) again, since it's used in ide-cd.c add a
	   note there that this is actually possibly adding the same device twice
	   to the devfs stuff.
	
	 - Finally change the MAINTAINER entry. Just too many persons bogged me
	   about it and it doesn't take me too much time apparently.
	
	 - Apply sis.patch.20020304_1.
	
	 - Don't call ide_release_dma twice in cleanup_ata, since ide_unregister
	   is already calling it for us. Change prototype of ide_unregister to
	   take a hwif as parameter and disable an ioctl for removing/scanning
	   hwif from the list of handled interfaces. I see no reasons for having
	   it and doing it is the fastest DOS attack on my home system I know
	   about it. Contrary to the comments found here and there, hdparm
	   doesn't use it. There are better hot plugging interfaces coming to the
	   kernel right now anyway.
	
	 - Wrap invalidate_drives in ide_unregister under the ide_lock instead of
	   disabling and enabling interrupts during this operation. There are
	   plenty of other places where the IDE drivers are enabling and
	   disabling interrupts just to protect some data structures.
	
	 - Don't call destroy_proc_ide_drives(hwif) for every single drive out
	   there.This routine takes a hwif as a parameter.
	
	 - Resync with the instable 2.5.6...

<dalecki@evision-ventures.com> (02/03/11 1.388.1.2)
	[PATCH] 2.5.6 IDE 19
	
	 - Fix oversight in replacement of sti() cli() pairs for data structure
	   access protection.  This finally resolvs my problems with the 2.5.6
	   kernel series.  Now I'm in fact quite puzzled how it was even possible
	   for the system to get into the init stage without this fix..
	
	 - Fix usage of CONFIG_BLK_DEV_IDE_MODULES instead of
	   CONFIG_BLK_DEV_IDE_MODULE.
	
	 - Make idescsi_init global for usage in systems without module support
	   enabled.
	
	 - Apply Pavels Macheks patch for suspend support.  Whatever some persons
	   argue that it's not fully implemented, I think that we are in
	   development series right now.  I don't buy the mock-up examples for
	   problems with either outdated or broken hardware.  Micro Drives are
	   for example expected to be drop in replacements for CF cards in
	   digital cameras and I would rather expect them to be very tolerant
	   about the driver in front of them.  And then the WB caches of IDE
	   devices are not caches in the sense of a MESI cache, they are more
	   like buffer caches and should therefore flush them self after s short
	   period of inactivity without the application of any special flush
	   command.  The upcoming explicit flushing commands in the ATA standard
	   are about data integrity guarantees in high reliability systems, like
	   DB servers for example, and not about simple cache validity.
	
	 - Apply Vojtech Pavliks fix to the VIA host chip initialization code.
	
	 - Add missing if-defs around PIO timing tables.
	
	 - Fix max() min() related compile warnings in IDE-scsi.

<jt@bougret.hpl.hp.com> (02/03/11 1.388.1.3)
	[PATCH] New wireless driver API part 2
	
		Quick summary : this patch build on the first part to offer
	two important new features :
			o Wireless Events
			o Wireless Cell Scanning
		Wireless Events are events generated by device, driver or the
	wireless subsystem. It allows for example a device to notify user
	space when it register to a new cell (roaming) or loose contact with
	the current Access Points. Currently, the other defined events include
	some configuration changes and packet drop due to excessive retries,
	more may come in the future. All those events are useful for MobileIP,
	V-Handoff and Ad-Hoc routing.
		Wireless Cell Scanning is a generic API to allow device/drive
	to report Wireless Cells discovered (including ESSID, frequency and
	QoS). This is similar to what is available in WindowsXP (except that
	it's compliant to Wireless Extensions).
	
		This patch has been submitted for review on this list a couple
	of time in January, has been on my web page since and used intensively
	by other people. It was rediffed to 2.5.6. Driver patches have been
	submitted to maintainers.

<vojtech@suse.cz> (02/03/11 1.388.1.5)
	[PATCH] My AMD IDE driver, v2.7
	
	This patch replaces the current AMD IDE driver (by Andre Hedrick) by
	mine. Myself I think my implementation is much cleaner, but I'll leave
	upon others to judge that. My driver also additionally supports the
	AMD-8111 IDE.
	
	It's well tested, and I'd like to have this in the kernel instead of
	what's there now.

<rem@osdl.org> (02/03/11 1.388.1.6)
	[PATCH] 2.5.6-pre3 Fix small race in BSD accounting
	
	Below is a patch to remove a small race in kernel/acct.c.

<rem@osdl.org> (02/03/11 1.388.1.7)
	[PATCH] 2.5.6-pre3 Fix small race in BSD accounting
	
	While looking at the bug fix for part 1 I coded up this patch
	to change the BSD accounting code to use a spinlock instead
	of the BKL.

<alan@lxorguk.ukuu.org.uk> (02/03/11 1.388.1.8)
	[PATCH] 2.5.6-pre3 Fix BSD accounting rlimit
	
	Fix rlimit on accounting file.

<akpm@zip.com.au> (02/03/11 1.388.1.10)
	[PATCH] fix layout of mapped files
	
	If you create a shared mapping of a sparse file, dirty it
	and then run msync, all the file's blocks are laid out
	backwards.
	
	This is because filemap_sync puts the lowest-index page at
	mapping->dirty_pages.prev and the highest at mapping->dirty_pages.next.
	
	I think that by walking the dirty pages list in ascending file
	offset order as we instantiate their disk mappings we will generally
	get better layout.

<neilb@cse.unsw.edu.au> (02/03/11 1.388.1.11)
	[PATCH] PATCH - knfsd fixes for 2.5.6
	
	Fix a few kNFSd problems.
	
	1/ export svc_reserve which was introduced for NFS/TCP support.
	    Without this we cannot load nfsd.o as a module
	2/ the hash chain of clients was being changed (to put the found
	   entry at the top of the list) while we only had a read-lock.
	   This could corrupt the list and cause big problems.
	   For now, just disable this code.  Might add a lock later...
	3/ lockd was calling exp_getclient without getting a readlock
	   on the export table first.
	4/ Add Config.help entry for CONFIG_NFSD_TCP

<viro@math.psu.edu> (02/03/11 1.388.1.12)
	[PATCH] (1/4) ->kill_sb() switchover
	
	New method - ->kill_sb().  It will eventually replace current
	fs/super.c::shutdown_super() - i.e. it's called when fs driver
	must shut the superblock down, remove it from all lists, etc.

<viro@math.psu.edu> (02/03/11 1.388.1.13)
	[PATCH] (2/4) ->kill_sb() switchover
	
	FS_LITTER filesystems (ramfs-like) switched to use of ->kill_sb().
	FS_LITTER is gone.

<viro@math.psu.edu> (02/03/11 1.388.1.14)
	[PATCH] (3/4) ->kill_sb() switchover
	
	The rest of nodev filesystems switched.

<viro@math.psu.edu> (02/03/11 1.388.1.15)
	[PATCH] (4/4) ->kill_sb() switchover
	
	bdev filesystems switched.  Changes documented in Locking and porting.

<viro@math.psu.edu> (02/03/11 1.388.1.16)
	[PATCH] fix for get_sb_bdev() bug
	
		Grr...  When loop in get_sb_bdev() had been switched from
	global list of superblock to per-type one, we should have switched
	from sb_entry(p) (aka. list_entry(p, struct super_block, s_list)) to
	list_entry(p, struct super_block, s_instances).
	
		As it is, we end up with false negatives all the time.  I.e.
	second mount from the same block device with the same type gices
	a new superblock.  With obvious nasty results...
	
		This fixes that.

<rmk@flint.arm.linux.org.uk> (02/03/12 1.384.1.11)
	Add /dev/rtc support for Acorn machines.

<rmk@flint.arm.linux.org.uk> (02/03/12 1.384.1.12)
	Update ARM tree for 2.5.6

<davem@nuts.ninka.net> (02/03/11 1.384.7.11)
	Update sparc64 defconfig.

<davem@nuts.ninka.net> (02/03/11 1.384.7.12)
	Add sys_sendfile64 to sparc syscall tables.

<dwmw2@infradead.org> (02/03/12 1.388.3.1)
	Update to 2002-03-12 JFFS2 development tree. Main features:
	 - Preliminary version of NAND flash support.
	 - Locking documentation and fixes (including BKL removal because it's superfluous).
	 - Performance improvements - especially for mount time. 
	 - Annoying stuff like i_nlink on directories fixed.
	 - Portability cleanups.

<davem@nuts.ninka.net> (02/03/12 1.384.7.13)
	Fix sys32_sendfile64 implementation.

<neilb@cse.unsw.edu.au> (02/03/12 1.393)
	[PATCH] PATCH - knfsd in 2.5.6 - fsid= export option
	
	Support fsid=<number> export option to be device number independent
	
	This patch was largely supplied by Steven Whitehouse <steve@gw.chygwyn.com>
	
	A new export option "NFSEXP_FSID" indicates that the ex_dev passed down
	is a user specified number, not a device number.
	It should be used in fsid_type==1 filehandles to identify the
	the exportpoint rather than the devid and inode (as in fsid_type == 0).
	This allows filehandles to be device-number independent so that when Linux
	changes device numbers on you (after reboot), your filesystems wont go stale.
	
	User-space support for this is in the nfs-utils CVS and will be in
	the next release (any release > 1.0).

<sfr@canb.auug.org.au> (02/03/12 1.394)
	[PATCH] dnotify
	
	The following patch makes directory notifications per thread group instead
	of per process tree as they are now.  This means, in particular, that if
	a child closes a file descriptor that has a directory open with notifies
	enabled, the notification will not be removed.
	
	Thanks to Andrea for the push in the right direction.

<bgerst@didntduck.org> (02/03/12 1.395)
	[PATCH] struct superblock cleanup - minixfs
	
	Start of cleaning up the union of filesystem-specific structures in
	struct super_block.  The goal is to remove dependence on filesystem
	headers in fs.h. 
	
	This patch abstracts the access to the minix_sb_info structure through
	the function minix_sb(). 

<bgerst@didntduck.org> (02/03/12 1.396)
	[PATCH] struct superblock cleanup - minixfs
	
	Switch to using kmalloc to allocate the minix superblock structure.

<sfr@canb.auug.org.au> (02/03/12 1.397)
	[PATCH] DMI patch for broken Dell laptop
	
	This adds DMI recognition for anohter broken Dell laptop BIOS (BIOS
	version A12 on the Insiron 2500).
	
	Reported by Mihnea-Costin Grigore <mgc8@totalnet.ro>.

<john@deater.net> (02/03/12 1.398)
	[PATCH] pci=usepirqmask option.
	
	Last week I sent you a patch adding a config option to honor the pirq mask
	in the PCI routing table.  On your suggestion, Cory Bell made it a command
	line option using the pci= interface and we both agree with you, it's
	-much- cleaner this way.
	
	Patch against 2.5.6 (Cory's submitting for 2.4, I've tested and submitting
	towards 2.5).  All credit goes to Cory Bell, with only minor input and
	testing from myself.

<viro@math.psu.edu> (02/03/12 1.399)
	[PATCH] (1/2) fs/super.c cleanups
	
	New helper - sget().  get_sb_bdev() and get_anon_super()
	switched to using it.  Basically, it's get_anon_super()
	done right (and get_anon_super() itself will probably
	die).

<viro@math.psu.edu> (02/03/12 1.400)
	[PATCH] (2/2) fs/super.c cleanups
	
	kill_super() and deactivate_super() merged.
	
	Next step will be to export these suckers - after that we will be finally
	done with infrastructure for filesystems with nontrivial ->get_sb().

<sfr@canb.auug.org.au> (02/03/12 1.401)
	[PATCH] Trivial APM update part 1
	
	This is the first of a series of patches I have got from Thomas Hood
	that modify the apm code mainly for better self documentation.
	
	This one does:
	
	Variable "waiting_for_resume" is renamed 'ignore_sys_suspend'.
	The reason for the change is that this flag variable is
	employed in a manner analogous to that of other flag variables
	named 'ignore ...'.  When the flag is set, the driver needs to
	ignore further system suspends.  The driver does not "wait"
	in the usual sense of that word.  The only sense in which the
	driver waits is the sense in which it needs to continue to
	ignore system suspends until certain events occur.  One such
	event is a resume.  However, another such event is the vetoing
	of the suspend request by a driver.  So it would be more
	accurate to call the flag 'waiting_for_resume_or_suspend_reject'
	or something like that.  But for the reason mentioned first,
	an even better name is 'ignore_sys_suspend'.

<sfr@canb.auug.org.au> (02/03/12 1.402)
	[PATCH] Trivial apm update: eliminate 0 initializers
	
	Second in a series of patches from Thomas Hood.
	
	This patch eliminates the 0 initializers on three
	static variables inside the apm_cpu_idle function.
	These initializers are superfluous.
	
	The initializers are replaced with comments whose
	purpose is to indicate that the code relies upon the
	fact that these variables are initialized to zero
	at load time.

<sfr@canb.auug.org.au> (02/03/12 1.403)
	[PATCH] Trivial apm patch: move apm_error up
	
	Here is the third one.
	
	This patch moves the apm_error() function higher
	in the file so that it is adjacent to the error_table
	that it uses.  This makes the code easier to read.
	The beginning of the file is an appropriate place
	for "utility" functions of this kind.  This is a pure
	move, with no changes made to the function.

<sfr@canb.auug.org.au> (02/03/12 1.404)
	[PATCH] APM:  move 'ignore_normal_resume = 1'
	
	This is number four and actually fixes a bug.
	
	This patch moves the setting of the ignore_normal_resume flag
	prior to the sti(); otherwise BIOS-generated normal resume
	events slip through unignored.

<sfr@canb.auug.org.au> (02/03/12 1.405)
	[PATCH] Trivial APM patch: set_system_power_state
	
	Number 5 from Thomas Hood
	
	This patch renames the static function "apm_set_power_state"
	to 'set_system_power_state'.
	
	Generally, the prefix 'apm_' is required to prevent external
	name collisions on exported functions.  This is a static function,
	so the prefix isn't required for that purpose.  The prefix might
	also indicate that this function has something particularly
	to do with the apm subsystem; but that's not the case here.  This
	function is simply a wrapper for set_power_state(), inserting the
	argument which sets the power state for the whole system.
	My main motivation for wanting to change this name is clearly
	to indicate the difference between this function and
	set_power_state().  Also, I would like to export set_power_state()
	someday in the future, but this is a separate issue.

<sfr@canb.auug.org.au> (02/03/12 1.406)
	[PATCH] APM patch: change implementation of ALWAYS_CALL_BUSY
	
	Number 6
	
	This patch cleans up the way the ALWAYS_CALL_BUSY macro
	forces calling of the APM BIOS busy routine.  Instead
	of storing a false value in clock_slowed, we disjoin
	clock_slowed with the value of ALWAYS_CALL_BUSY.  This
	simplifies the code.

<sfr@canb.auug.org.au> (02/03/12 1.407)
	[PATCH] APM patch: apm_cpu_idle cleanups
	
	Number 7.
	
	This patch contains four cleanup changes whose aim
	is better code self-documentation (the best way to
	document IMHO).  They are sent together because they
	overlap.
	
	1. Rename the variable "sys_idle" to 'original_pm_idle'.
	This is where we store the value that we find in pm_idle before
	we substitute the address of our own apm_cpu_idle() function.
	In principle we have no idea whose address this is, so
	the variable name shouldn't imply that we know that this is
	the address of a system idle function; it should simply
	indicate that it is the original value of pm_idle.
	
	2. Variable "apm_is_idle" is renamed 'apm_idle_done'.
	This flag indicates when apm_do_idle() has been called.
	It is a premise of apm_cpu_idle()'s operation that it is
	not known whether the apm_do_idle() function really idles
	the CPU.  The name of the flag should not lead one to
	believe otherwise.
	
	3. Variable "t1" is renamed 'bucket'.  The variable is not
	a time but a countdown ("bucket"), so the variable name
	should not lead one to believe it is some sort of time
	value.
	
	4. A default: case is added to the switch in order to
	remind the reader that there is a third possible return
	value from apm_do_idle().

<bgerst@didntduck.org> (02/03/12 1.408)
	[PATCH] struct super_block cleanup - cramfs
	
	Seperates cramfs_sb_info from struct super_block.

<kraxel@bytesex.org> (02/03/12 1.410)
	[PATCH] video4linux doc fix
	
	This patch updates/fixes the video4linux API documantation.  The current
	description for mmap() based capture is unclear and somewhat misleading.

<kraxel@bytesex.org> (02/03/12 1.411)
	[PATCH] miropcm20 build fix
	
	This patch fixes the build failure of the miro radio driver due to
	the new location of the sound drivers in the tree (alsa merge).

<kraxel@bytesex.org> (02/03/12 1.412)
	[PATCH] videodev redesign
	
	This patch is a redesign for videodev.[ch].  Changes:
	
	- drop the function pointers (read/write/mmap/poll/...) from struct
	  video_device, use struct file_operations directly instead.
	  Dispatching to different drivers by minor number is done the same way
	  soundcore.o handles this: swap file->f_fops at open() time.
	
	- also drop the now obsolete video_red/write/mmap/poll/...  functions
	  from videodev.c
	
	- Stop using the BKL, use a mutex to protect open,register+unregister
	  calls against races.
	
	- provide a video_generic_ioctl() function which can (and should) be
	  used by v4l drivers to handle copying from and to userspace.
	
	- provide video_exclusive_open/release functions which can be used by
	  v4l drivers to make sure only one process at a time opens the
	  device.  They can be hooked directly into struct file_operations if
	  some driver has nothing to initialize at open time (which is true
	  for many drivers in drivers/media/radio/).
	
	The move from function pointers in struct video_device to struct
	file_operations does break all existing v4l drivers.  Thus I have a
	large number of patches for the drivers in the kernel tree.  Most of it
	is just the adoption to the videodev.[ch] changes, but I've also fixed a
	small bug there and there while walking througth the source files.

<kraxel@bytesex.org> (02/03/12 1.413)
	[PATCH] es1370 virt_to_bus fix
	
	This patch fixes the es1370 build problems due to virt_to_bus()
	being gone.

<davem@nuts.ninka.net> (02/03/12 1.384.7.14)
	Include asm/page.h in sparc64 thread_info.h

<torvalds@penguin.transmeta.com> (02/03/12 1.419)
	Update kernel version


