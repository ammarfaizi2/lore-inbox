Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313078AbSDDBXg>; Wed, 3 Apr 2002 20:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313079AbSDDBX0>; Wed, 3 Apr 2002 20:23:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41486 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313078AbSDDBXF>; Wed, 3 Apr 2002 20:23:05 -0500
Date: Wed, 3 Apr 2002 17:22:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.5.8-pre1
Message-ID: <Pine.LNX.4.33.0204031714080.12444-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, there's a largish 2.5.8-pre1 patch out there in testing right now.

It syncs up with various sources over the last two weeks - notably USB,
networking, sparc, net drivers, and the beginning of the -dj tree merge.
Some of the merges are known incomplete (eg some drivers do not compile
etc), but testing is always a good idea.

Changelog appended.

			Linus

PS. For people who still haven't noticed - the "I'm leaving Linux and
Transmeta" email was a April fools joke (and not written by me, btw, so 
don't credit me for being funny)

-----
Summary of changes from v2.5.7 to v2.5.8-pre1
============================================

<jes@wildopensource.com> (02/03/15 1.473.4.15)
	acenic net driver update:
	* clean up vlan defines to dramatically reduce number of ifdefs
	* re-optimize private structure across cache line boundaries
	* fix typo(s) in printk/comments

<kai.reichert@udo.edu> (02/03/18 1.538)
	USB printer driver
	
	added HP DeskJet 959C to the quirks list

<paschal@rcsis.com> (02/03/18 1.539)
	USB printer driver
	
	added more printer quirks to the list

<david-b@pacbell.net> (02/03/18 1.540)
	USB hcd.c, non-HS periodic transfers
	
	This patch adds a missing "break", which prevented low and full
	speed periodic transfers from getting through the "hcd" framework
	to the driver (OHCI, for now).  Sigh... :)

<david-b@pacbell.net> (02/03/18 1.541)
	USB mem flags nonpoisonous
	
	This patch completely punts on passing SLAB_POISON, I've
	gotten burnt by it once too many.  Seems like the slab code
	changed somewhere.  I've got a separate patch to make the
	pci_pool code use CONFIG_DEBUG_SLAB, which I'll send
	around.
	    
	Meanwhile, I needed this to get at least EHCI to intialize on
	a 2.5.7-pre1 system.  Please merge.

<david-b@pacbell.net> (02/03/18 1.542)
	USB
	
	Comment and documentation cleanups

<david-b@pacbell.net> (02/03/18 1.543)
	USB
	
	inline cleanup to save a chunk of memory in usb-ohci

<david-b@pacbell.net> (02/03/18 1.544)
	USB echi and Intel ICH
	  
	This updates the Philips tweak so that it also applies
	to late-model ICH chips from Intel.  (Or so I'm told ... :)
	That's at least three EHCI implementations known to
	behave on Linux.  (And one hopes VIA soon too...)
	
	It also cleans up a few comments relating to 64bit DMA;
	recent API spec updates make it look like no games are
	needed with the PCI DMA mask -- it doesn't change the
	segment used by pci_pool allocations, so it just needs
	to get turned on if the overall system does 64bit DMA.
	
	I've a query in to see if those Philips/Intel tweaks are
	chip quirks, or just something the EHCI 1.0 spec isn't
	at all clear about.

<davem@nuts.ninka.net> (02/03/18 1.537.1.1)
	On sparc{,64}, use ptrace_check_attach instead of
	verifying things by hand.

<davem@nuts.ninka.net> (02/03/18 1.537.1.2)
	In Sparc{,64} signal handling, tsk->p_pptr --> tsk->parent

<davem@nuts.ninka.net> (02/03/18 1.537.2.1)
	Fix build error on non-x86.

<david-b@pacbell.net> (02/03/18 1.545)
	This updates linux/Documentation/usb/proc_usb_info.txt to:
	
	    - refer to "usbfs"
	    - describe the /proc/bus/usb/BBB/DDD files
	    - more info about the .../drivers and .../devices
	    - ... generally, gives more information.
	  
	This is ever so slightly forward looking in how it describes
	bandwidth requirements for high speed periodic transfers,
	it's expecting a bugfix patch that's in my queue.  (That info            
	is currently broken/meaningless.)

<johannes@erdfelt.com> (02/03/18 1.546)
	[PATCH] uhci.c 2.4.19-pre3 kmem_cache_alloc flags
	
	My previous patch which cleaned up some of the spinlocks, moved one of
	the spinlocks around a call to kmem_cache_alloc. It would sometimes
	erroneously call it with GFP_KERNEL.
	
	This patch fixes the problem by always calling it with GFP_ATOMIC.
	Thanks to Greg for pointing this out to me.
	
	JE

<johannes@erdfelt.com> (02/03/18 1.547)
	[PATCH] uhci.c 2.4.19-pre3 erroneous completion callback
	
	uhci.c would call the completion callback when the call to submit_urb
	failed. This is a rare situation.
	
	This patch only calls the completion handler if the URB successfully
	completed immediately (as in the case of talking to the virtual root
	hub).
	
	JE

<johannes@erdfelt.com> (02/03/18 1.548)
	[PATCH] uhci.c 2.4.19-pre3 interrupt deadlock
	
	Unfortunately, I left out one line from my spinlock cleanup patch
	recently.
	
	As a result, using interrupt URB's could cause a deadlock on SMP
	kernels.
	
	This should fix the deadlock Greg reported.
	
	JE

<ganesh@tuxtop.vxindia.veritas.com> (02/03/19 1.549)
	USB ipaq driver
	
	Don't submit urbs while holding spinlocks. Not strictly required in
	2.5.x, but it's always better to do less while holding a spinlock.
	Also a good idea to keep 2.{4,5}.x drivers in sync.

<david-b@pacbell.net> (02/03/19 1.550)
	USB usbfs periodic endpoint/bandwidth reporting
	
	This is an updated version of a patch I sent around a
	while back.  It's against 2.5.7-pre1 (so presumably is
	fine on 2.5.7), and addresses feedback against that
	earlier patch.
	  
	It's bugfixes, mostly for highspeed support, to what
	/proc/bus/usb/devices shows:
	  
	- Shows isochronous periods correctly (logarithmic
	  encoding, possibly 1/2/4 microframes if highspeed)
	- Likewise for high-speed interrupt periods (similar)
	- Makes high bandwidth endpoints look like they
	  just do bigger packets (up to 3 KBytes/uframe)
	- Shows highspeed bandwidth correctlly (80% reserved,
	  vs 90% reserved for full/low speed).

<greg@kroah.com> (02/03/19 1.551)
	USB proc_usb_info.txt
	
	documented the fact that the interval is not always reported in ms.

<davem@nuts.ninka.net> (02/03/19 1.537.1.3)
	Update sparc64 defconfig.

<davem@nuts.ninka.net> (02/03/19 1.537.2.2)
	Netfilter enhancement from Harald Welte and Netfilter team.
	Add destroy callback to ip_conntrack_helper, to be used by L4
	protocol trackers.

<oliver@oenone.homelinux.org> (02/03/19 1.552)
	USB hpusbscsi driver
	
	Port changes from 2.4:
	  We do request_sense ourselves to comply with
	  the scanner command set

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.3)
	Remove obsolete confusing instructions on tcp_max_syn_backlog
	from IPv4 sysctl documentation.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.4)
	Make pkt_sched.h:PSCHED_TDIFF_SAFE behave sane when measuring
	large time intervals.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.5)
	Remove unused field from TCP struct open_request.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.6)
	Do not fail creating _new_ NOARP entry with EPERM.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.7)
	Old bug in skbuff.c, found by someone, but was lost.
	In __pskb_pull_tail, pskb_expand_head return value test
	was inverted.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.8)
	IPv4 FIB routing fixes:
	- fix device leakage in multipath
	- fix oops due to race by adding spinlock

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.9)
	In IPv4 ICMP:
	pskb_pull really may reallocate packet after the check
	for 8 bytes was removed from ip_input, so set icmp
	header pointer after pskb_pull call not before.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.10)
	Fix for ipv4 tunnel devices:
	- do not make path mtu discovery, when it is disabled :-)

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.11)
	IP input fixes:
	- no need to check for pskb_may_pull() in ip_local_deliver_finish, header
	is guaranteed to be at right place here.
	- remove cleaing ip_summed with IP options, it was required due to
	broken eth_copy_and_csum, but we do not use it any more
	and it happens to break loopback

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.12)
	Terrible bug in ipv4/route.c, mis-sized ip_rt_acct leads to
	complete memory corruption.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.13)
	TCP Input fixes:
	1) Two bugs noticed by Pasi:
	   - Wrong rtt update interval
	   - Forgot to clear retrans_stamp when entering established
	     state
	2) Missing LAST_ACK case of processing segment text (step 7) in
	   tcp_rcv_state_process.
	3) Remove "final cut" code, purism is good not all the times. :-)

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.14)
	UDP fixes:
	- respect multicast interface when connecting

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.15)
	IPV6 addrconf exploit fix:
	- stop external DoS attack feeding lots of IPv6 prefixes

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.16)
	IPv6 neighbour discovery fixes:
	- Answer to neighbour solicitations on SIT, otherwise
	  freebsd does not want to talk to us.
	- Fix wrong structure nd_msg and... use it :-)

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.17)
	TCP ipv6 fixes:
	- Fix open_request lookup bug that was already fixed in ipv4

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.18)
	Port of 2.2.x AF_PACKET bug fix.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.19)
	Fix bug in sch_prio.c where wrong handle was
	being dumped.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.20)
	In sch_sfq.c, allow to descrease length of queue

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.21)
	Add new sysctl, medium_id, to devinet.
	It is used to differentiate the devices by the medium
	they are attached to.  It is used to change proxy_arp behavior:
	the proxy arp feature is enabled for packets forwarded between
	two devices attached to different media.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.22)
	Allow to bind to an already in use local port
	during connect when the connection will still have a unique
	identity.  Fixes port space exhaustion, especially in web
	caches.
	
	Initial work done by Andi Kleen.

<davem@nuts.ninka.net> (02/03/19 1.537.2.23)
	Fix mis-merge of TCP_LAST_ACK fix.

<davem@nuts.ninka.net> (02/03/19 1.537.2.24)
	Update port-allocation changes to coincide with struct sock
	splitup.

<davem@nuts.ninka.net> (02/03/19 1.537.2.25)
	Update port-allocation changes to coincide with struct sock
	splitup.

<davem@nuts.ninka.net> (02/03/19 1.537.2.26)
	Kill unused local var in af_inet.c:inet_stream_connect

<kanojsarcar@yahoo.com> (02/03/19 1.537.1.4)
	Move VPTE_BASE_foo definitions to common
	header instead of scattered all over assembly files.

<eli.kupermann@intel.com> (02/03/20 1.537.3.2)
	e100 net driver update:
	
	1) This patch provides fix for "wake on arp" and "wake on unicast"
	functionality when card is suspended by power management. When e100_suspend
	was called for the device that is in netif_running state the load filter
	command was executed in the asynchronic mode and the order of actions
	required to put device into wake up enabled mode was broken.
	
	The fix enables to execute WOL configure and load filter commands in the
	synchronic mode despite of fact that device is in netif_running state. The
	exec_non_cu_command uses the driver_isolated flag to identify this
	situation. 
	
	2) add EXPORT_NO_SYMBOLS (yay Intel, you have come so far... :))
	
	3) bump version to 2.0.25-pre1

<jgarzik@mandrakesoft.com> (02/03/20 1.537.3.3)
	Merge ethtool initiate-nic-self-test ioctl, and support for it in e100 net drvr.
	
	Contributed by Eli Kupermann @ Intel, modified by me.

<adilger@clusterfs.com> (02/03/20 1.537.4.1)
	Add three scripts for BK users, to Documentation/BK-usage:
	bzsend: good for users who want to send reviewable BK patches
	bz64wrap, unbz64wrap: bzip2 uuencoding wrappers for encapulating BK patches

<tvignaud@mandrakesoft.com> (02/03/20 1.537.4.2)
	Remove silly overdependency on Perl 5.6.1 in BK helper scripts.

<jgarzik@mandrakesoft.com> (02/03/20 1.537.3.4)
	Add support file e100_test to e100 net driver.  Missed in earlier merge.

<jgarzik@mandrakesoft.com> (02/03/20 1.537.3.5)
	Merge dl2k gigabit ethernet driver update vendor:
	* add rio_timer to watch rx condition
	* move poll initiation to rx refill loop
	* use del_timer_sync to avoid race (me)
	* CodingStyle cleanups (me)

<jgarzik@mandrakesoft.com> (02/03/20 1.537.3.6)
	Merge orinoco_plx wireless driver pci ids from 2.4.x.

<jgarzik@mandrakesoft.com> (02/03/20 1.537.4.3)
	Update rocketport serial driver:
	* remove linux 2.1.x backwards compat code (William Stinson)
	* remove ENABLE_PCI define, use CONFIG_PCI instead
	* no need to enclose MODULE_xxx in ifdef MODULE

<jgarzik@mandrakesoft.com> (02/03/20 1.537.4.4)
	Add two AC97 codec ids to old OSS ac97_codec driver.
	
	Contributed by Peter Christy.

<k.kasprzak@box43.pl> (02/03/20 1.537.3.7)
	de620 net driver janitor fixes:
	* free_irq on error
	* check request_region error value

<silicon@falcon.sch.bme.hu> (02/03/20 1.537.4.5)
	Update munish WAN driver to not kfree memory multiple times.

<wstinson@infonie.fr> (02/03/20 1.537.4.6)
	Fix DocBook documentation for ALSA merge,
	basically s#drivers/sound#sound/oss#

<jgarzik@mandrakesoft.com> (02/03/20 1.537.3.8)
	Revert epic100 net driver power sequence "fix", it broke some boards.

<davem@nuts.ninka.net> (02/03/20 1.537.2.27)
	Fix reverse logic in checking sock_writeable return
	in UDP case.  I note in passing that the TCP case is
	wrong because TCP does not use sock_writeable()s

<davem@nuts.ninka.net> (02/03/20 1.537.1.5)
	In sparc64/ebus, handle machines with both RIO and
	non-RIO EBUSes correctly.

<greg@kroah.com> (02/03/20 1.551.1.1)
	USB hub
	
	changed the interval for checking if the device is connected yet or not.
	Thanks to Itai Nahshon <nahshon@actcom.co.il> for the information.

<davem@nuts.ninka.net> (02/03/20 1.537.1.6)
	On sparc64 Schizo PCI controllers, there is no inofixup
	to apply during IRQ building.

<davem@nuts.ninka.net> (02/03/20 1.537.1.7)
	On sparc64, handle assigning ROM and non-standard resources
	properly.

<davem@nuts.ninka.net> (02/03/20 1.537.1.8)
	In Sun GEM/HME drivers, if OpenBoot firmware is not
	available (e.g. i386) fetch the ethernet MAC address
	from the vital-product data contained in the PCI
	ROM of the card.

<davem@nuts.ninka.net> (02/03/20 1.537.1.9)
	Model Sparc64 pci_assign_resource more closely to the
	implementation in drivers/pci/setup-res.c to make it
	easier to track bugs.
	
	Fix calculation of mem_space end on Sparc64 Schizo PCI controllers.
	The decode register is set up for the whole 4GB even though the
	top 2GB is reserved for DMA to/from main memory (ie. IOMMU translated)

<davem@nuts.ninka.net> (02/03/21 1.537.1.10)
	Merge 2.4.x Sun GEM/HME net driver fixes.

<davem@nuts.ninka.net> (02/03/21 1.537.1.11)
	Remove debugging printk while probing MAC address.
	Unregister netdev on shutdown before iounmapping registers.

<davem@nuts.ninka.net> (02/03/21 1.537.1.12)
	Sun HME/GEM driver probing cleanups.

<greg@kroah.com> (02/03/21 1.554)
	USB visor driver
	
	Added support for the Palm m130 device, thanks to Udo Eisenbarth
	<udo.eisenbarth@web.de> for the information.

<greg@kroah.com> (02/03/21 1.555)
	USB serial driver core
	
	- Moved all manipulation of port->open_count into the core.  Now the
	  individual driver's open and close functions are called only when the
	  first open() and last close() is called.  Making the drivers a bit
	  smaller and simpler.
	- Fixed a bug if a driver didn't have the owner field set.

<greg@kroah.com> (02/03/21 1.556)
	USB serial drivers
	
	changes due to open_count being handled by the usb-serial core code.

<oliver@oenone.homelinux.org> (02/03/21 1.557)
	USB kaweth driver
	
	added optus@home uep1045a driver to the list of supported devices.

<davem@nuts.ninka.net> (02/03/21 1.537.2.28)
	Add missing KERN_foo printk specifiers to networking.
	Based upon a patch from Denis Vlasenko.

<uzi@uzix.org> (02/03/21 1.537.1.13)
	Merge 2.4.x VGER sparc32 changes into 2.5.x

<laforge@gnumonks.org> (02/03/21 1.537.2.29)
	Add configure Configure.help message and
	respective config option for CONFIG_IP_NF_NAT_LOCAL

<wstinson@infonie.fr> (02/03/21 1.537.1.14)
	Remove explicit initialization of static vars to zero
	in Sparc ports.

<cruault@724.com> (02/03/21 1.537.2.30)
	Make sure outgoing ICMP and TCP resets
	use the most uptodate value of ip_default_ttl sysctl.

<davem@nuts.ninka.net> (02/03/21 1.537.1.15)
	Move bootstr_valid/bootstr_buf back into .data section.
	Add comment explaining that why these must not be moved into the
	.bss section.

<davem@nuts.ninka.net> (02/03/22 1.537.2.31)
	Code (and commentary) in SYN-RECEIVED processing
	assumes that it cannot be reached in the crossed SYN case.
	This is wrong if the original SYNs came from a malicious packet
	generator third party.  This can result in a 4 minute ACK
	fight if the sequence numbers are correct.
	
	The fix is the verify the ACK before we do anything else, which
	should cover all cases.
	
	This bug was discovered by Casper Dik.

<petkan@mastika.> (02/03/22 1.558)
	USB pegasus driver
	
	fix problem which cause hotplug/unplug crash the kernel

<petkan@mastika.> (02/03/22 1.559)
	USB
	
	added rtl8150 usb ethernet driver

<davem@nuts.ninka.net> (02/03/22 1.537.2.32)
	Bump TcpPassiveOpens when tcp_create_openreq_child succeeds.
	We have not been bumping this since we create openreqs in TCP,
	ie. some 6 years ago. :-)

<stewart@inverse.wetlogic.net> (02/03/22 1.560)
	[PATCH] Re: [PATCH] hiddev code and docs cleanup
	
	I took some time to clean up the code a little, and to add the new
	calls to the documentation.  See patch below.
	
	--
	Paul

<greg@kroah.com> (02/03/23 1.561)
	USB visor driver
	  
	added support for the Palm i705 device.
	thanks to Thomas Riemer for the information.

<johannes@erdfelt.com> (02/03/25 1.562)
	[PATCH] 2.4.19-pre3 uhci.c zero packet
	
	Don't know if you saw this on the list or not. Here's a patch which
	fixes zero packet support for uhci.c
	
	- Setup the TD correctly, we weren't shifting the null data size
	- Only add the zero packet if the transfer was a multiple of the
	  endpoint of the size
	
	JE

<davem@nuts.ninka.net> (02/03/25 1.537.1.16)
	Merge 2.4.x sparc64 PCI IRQ routing fixes into 2.5

<uzi@uzix.org> (02/03/25 1.537.1.17)
	Sparc32 cleanups.

<david-b@pacbell.net> (02/03/26 1.563)
	USB ohci-hcd update
	
	It updates the "ohci-hcd" driver to address two issues, one            
	of which could potentially have caused oopses.  First, it takes
	out calls to usb_dec_dev_use() on the submit error path; that's
	already done elsewhere.  (Noted by Georg Acher.)  Second,
	it removes some pointless diagnostics.  One is for schedule
	overrun interrupts, the other is for accessing the frame counter.

<petkan@mastika.lnxw.com> (02/03/26 1.564)
	USB pegasus driver
	
	semaphore cleanup and proper link detection

<davem@nuts.ninka.net> (02/03/26 1.537.1.18)
	Do the slot mapping adjustment to PROM interrupt
	property in pci_intmap_match even if pbm->num_pbm_intmap is
	zero.

<davem@nuts.ninka.net> (02/03/26 1.537.2.33)
	Fix device list locking.
	Based upon a patch from Maxim Krasnyansky.

<laforge@gnumonks.org> (02/03/26 1.537.2.34)
	Big netfilter newnat patch for 2.5.7:
	- support for multiple expected connections
	  (necessary for protocols like H.323, SIP, PPTP)
	- helper-definable limit of unconfirmed expectations
	- timeouts for expectations
	- full graph of connection relations, even after expectation confirmed
	- various changes in the API towards conntrack and NAT helper
	- automatic conntrack helper loading when at helper is loaded
	- NAT mangling of TCP SACK in case of sequence number alteration
	  (no need to delete SACKPERM anymore, I hope Alexey is happy now)

<davem@nuts.ninka.net> (02/03/26 1.537.1.19)
	SunHME driver updates:
	- Fix SMP locking throughout
	- Deal with hw bug involving lost writes to rxring base address
	- Disable Never Give Up mode on transmitter, set TX attempts
	  limit to 16 (the default).  This deals with a possible hang
	  when the TX deadlocks with the PHY when a jabber occurs.
	- Delete some dead code.

<johannes@erdfelt.com> (02/03/27 1.565)
	[PATCH] USB uhci bugfix
	
	The issue was that the poisoning would posing the data *before* it gave
	it to us as well, but I didn't clear out a pointer (qh->urbp) and later
	dereferenced it.
	
	Thanks for the report again and for the pci_pool patch so I could
	troubleshoot it.
	
	JE

<david-b@pacbell.net> (02/03/27 1.566)
	USB ohci-hcd driver update
	  
	      - bugfix: control endpoints can't stall
	      - bugfix: remove bogus intr unlink optimization,
	          by sharing intr/iso code
	      - bugfix: iso submit uses urb->interval
	      - removed iso urb->next ring logic
	          (belongs in hcd layer if anywhere)
	      - simplify/shorten/correct completion handling
	      - in debug, labels setup packets as such
	      - bring CVS ids back up to date

<david-b@pacbell.net> (02/03/27 1.567)
	USB core sanity check
	  
	  Periodically folk have run into problems where usb-ohci oopses
	  due to device refcount bugs ...
	    
	  This is a minor patch to move the sanity check out of usb-ohci
	  into the generic bits of usbcore.    There are comments that
	  suggest a path for a more comprehensive approach too.
	    
	  Applies cleanly against 2.5.7 and I've been testing with it
	  for a while.  I can't think of any reason it shouldn't also go
	  into 2.4, beyond the patch not applying cleanly there ... :)

<davem@nuts.ninka.net> (02/03/27 1.537.2.35)
	Tigon3 net driver fixes:
	- Make use of pci_unmap_xxx storage optimization.
	- In tg3_get_invariants, fix cacheline_sz_reg shifts.
	  On 5703 chips, if latency timer is less than 64, set
	  it to 64.
	- In tg3_test_dma, only run the actual test on 5700/5701
	  chips.  Aparently 5702/5703 revs have some problems.

<davem@nuts.ninka.net> (02/03/27 1.537.1.20)
	In SBUS probing, handle empty SBUS correctly.

<greg@kroah.com> (02/03/27 1.568)
	USB serial console support added

<davem@nuts.ninka.net> (02/03/27 1.537.2.36)
	Tigon3 net driver bug fix:
	- ETHTOOL_GLINK handling forgets to return on success

<greg@kroah.com> (02/03/28 1.569)
	USB serial config.in changes
	
	- make serial console only selectable if the code is not a module.
	- removed lots of CONFIG_EXPERMENTAL dependancies as the drivers have been stable for some time now.

<greg@kroah.com> (02/03/28 1.570)
	USB uhci bug fix.
	
	use proper GFP flag setting for submitting a urb.

<greg@kroah.com> (02/03/28 1.571)
	USB io_edgeport driver update
	
	fixes to let io_edgeport work properly as a usb serial console

<ganesh@veritas.com> (02/03/28 1.572)
	USB serial core
	
	Module count of a serial converter driver is currently not
	decremented if a disconnect happens while the tty is held open.
	The fix is to close the device in usb_serial_disconnect() so that
	module refcounts are properly updated.

<david-b@pacbell.net> (02/03/28 1.573)
	USB audio driver
	  
	- Makes "audio" set the urb->interval in its periodic URBs,
	  so it can submit through the hcd framework. 

<david-b@pacbell.net> (02/03/28 1.574)
	USB hcd driver updates
	  
	  - Nitpickey bugfix to root hub config descriptors ... can't use
	    the same one for high and full speed, since the encoding
	    is different (255 ms FS == 0xff, 256 ms HS == 0x12).
	  - Related, force period to 1/4 second rather than doing
	    any sanity checking for the roothub timer (from Georg)
	  - Don't "giveback" urbs on submit path errors (from Georg)
	    ... means they don't get completion callbacks
	  - Additional error checks on URB data (from Georg)
	  - Uses <linux/completion.h> for unlink synchronization
	  - The "already unlinking" error case is reported like other
	    unlinking errors (not as success)
	  - Ripped out urb->next handling ... it wasn't compatible
	    with the ISO loop model, and at this point I believe it
	    should be completely replaced with queuing urbs inside
	    of the HCDs.  (Every HCD handles it for ISO, UHCI needs
	    a magic flag to enable it for bulk ...)

<stewart@wetlogic.net> (02/03/28 1.575)
	USB hiddev interface
	
	updated the version number due the previous changes

<davem@nuts.ninka.net> (02/03/28 1.537.1.21)
	Sparc SBUS fix: Make for_all_sbusdev work with an empty SBUS.

<davem@nuts.ninka.net> (02/03/30 1.537.2.37)
	net/core/sock.c needs linux/tcp.h to get at TCP state macros.

<spse@secret.org.uk> (02/04/01 1.576)
	[PATCH] Update to konicawc driver
	
	This patch against 2.5.7 fixes an oops and a memleak in the konicawc driver
	and also adds an option to set the FPS.

<viro@math.psu.edu> (02/04/02 1.537.5.1)
	[PATCH] initrd issue
	
	Fix initrd problem that appeared back in 2.5.2-pre6 when kdev_t type
	changed and comparison function was incorrectly converted..

<dalecki@evision-ventures.com> (02/04/02 1.537.5.2)
	[PATCH] 2.5.7 IDE 23
	
	- Support for additional Promise controller id's (PDC20276).
	
	- Remove code duplication between do_rw_taskfile and do_taskfile.
	   This will evolve into a more reasonable ata_command() function
	   finally. The ata_taskfile function has far too many arguments, but
	   I favour this over having two different code paths for getting
	   actual data to the drive.

<dalecki@evision-ventures.com> (02/04/02 1.537.5.3)
	[PATCH] 2.5.7 IDE 24
	
	- Push BAD_DMA_DRIVE and GOOD_DMA_DRIVE to the ide-pmac.c file, since this is
	   the only place where those get used.
	
	- Kill unused fields from the ide_task_s structure. In esp. we pass a task
	   attached to a request and not the other way around!
	
	- Rename hwif field to channel in struct ide_drive_s.
	
	- Move the request queue to the level where proper serialization has to happen
	   anyway - the channel structure.

<dalecki@evision-ventures.com> (02/04/02 1.537.5.4)
	[PATCH] 2.5.7 IDE 25
	
	- Replace the task_io_reg_t with the simple u8. There is no need to obfuscate
	   the code more then necessary.
	
	- kill some unnecessary type definitions out from hdreg.h.
	
	- Add proper attributes to register files in hdreg.h.
	
	- Don't use raw arrays for tfRegister and hobRegister in ide_task_s.  Use out
	   nice global structures describing the fields in them.  This allows to kill
	   the following defines:
	
	     IDE_DATA_OFFSET
	     IDE_FEATURE_OFFSET
	     IDE_NSECTOR_OFFSET
	     IDE_SECTOR_OFFSET
	     IDE_LCYL_OFFSET
	     IDE_HCYL_OFFSET
	     IDE_SELECT_OFFSET
	     IDE_COMMAND_OFFSET
	
	   and many many others.
	
	- Please have a look at the following in pdc4030.c. It couldn't have worked!
	   This has been fixed in one go with the above change:
	
	   memcpy(args.hobRegister, NULL, sizeof(struct hd_drive_hob_hdr));
	
	- Kill the redundant *_REG_HOB definitions. They don't help readability in any
	   way.

<dalecki@evision-ventures.com> (02/04/02 1.537.5.5)
	[PATCH] 2.5.7 IDE 26
	
	- Mark all members of structures, which get jiffies assigned or involved in
	   ugly timeout calculations with the prefix PADAM_  for easy spotting. This is
	   Polish for "I'm falling down" or "This brings me to the knees" or slag
	   comment for "What a sh..". Please be assured that it doesn't sound vulgar.
	
	   Please grep for it to see immediately why this nomenclature is justified.
	
	- Rename hwifs_s to ata_channel and eliminate ide_hwifs_t as well as the HWIF
	   macro. OK this step makes this patch rather big.

<dalecki@evision-ventures.com> (02/04/02 1.537.5.6)
	[PATCH] 2.5.7 IDE 27
	
	- Make for less terse error messages in ide-tape.c.
	
	- Replaced all timecomparisions done by hand with all the proper timer_after()
	   commands.
	
	- Remove the drive niec1 mechanisms alltogether. There are several reasons for
	   this:
	
	   1. The code implementing it is nonintelliglible and therefore propably
	   broken.
	
	   2. If we have to invent somethig about sceduling drive IO, it should be done
	   on the BIO level.
	
	   3. We may in fact interleave with the IO sceduling on the upper layers and
	   the results of two overlapping signal filters overlapped with each other can
	   be disasterous to the overall throughput. (In fact they *are* most of the
	   time.)
	
	   4. It was not working if you had intermixed modes on different drives
	   DMA versus PIO.
	
	   5. Our goal is to have a driver which is able to share the badwidth
	   properly and shouldn't needing this kind of "tuning".
	
	- Remove unused nice2 from disk struct.
	
	- Rename channel member of ata_channel to unit and device to dev to
	   just prevent wrong interpretations. This prevents constructs like
	   channel->channel...

<dalecki@evision-ventures.com> (02/04/02 1.537.5.7)
	[PATCH] 2.5.7 IDE 28a
	
	- Apply Pavel Macheks suspend resume double resume fix.
	
	- Finally remove the busy field for ata_operations and replace it with
	   MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT.
	
	- Fix ali15xx chipset support by removing initialization differences,
	   apparently caused by mislead interpretation of the specs or a mismatch
	   between the specification and reality.
	
	- Guard calls to ide_set_handler with checks to see whatever the previously
	   installed IRQ handler already served it's purpose.
	
	- Convert timeout checks on poll_timeout to the time_before() interface.
	
	- Consolidate the two different IRQ handlers for multi mode PIO writes into
	   one. The problems remain the same but at least now we will only have to
	   tangle one single problem.

<akpm@zip.com.au> (02/04/02 1.537.5.8)
	[PATCH] ext2_fill_super breakage
	
	In 2.5.7 there is a thinko in the allocation and initialisation
	of the fs-private superblock for ext2.  It's passing the wrong type
	to the sizeof operator (which of course gives the wrong size)
	when allocating and clearing the memory.
	
	Lesson for the day: this is one of the reasons why this idiom:
	
		some_type *p;
	
		p = malloc(sizeof(*p));
		...
		memset(p, 0, sizeof(*p));
	
	is preferable to
	
		some_type *p;
	
		p = malloc(sizeof(some_type));
		...
		memset(p, 0, sizeof(some_type));
	
	I checked the other filesystems.  They're OK (but idiomatically
	impure).  I've added a couple of defensive memsets where
	they were missing.

<viro@math.psu.edu> (02/04/02 1.537.1.24)
	[PATCH] romfs inode allocation
	
	Obvious romfs fix.

<viro@math.psu.edu> (02/04/02 1.537.1.25)
	[PATCH] conditional system call cleanup
	
	This version of sys_nfsservctl() fix hadn't made DaveM complain.

<viro@math.psu.edu> (02/04/02 1.537.1.26)
	[PATCH] minixfs cleanups (1/4)
	
	Move minix-private stuff to fs/minix/minix.h.

<viro@math.psu.edu> (02/04/02 1.537.1.27)
	[PATCH] minixfs cleanups (2/4)
	
	Clean up the write_super-related code in minixfs

<viro@math.psu.edu> (02/04/02 1.537.1.28)
	[PATCH] minixfs cleanups (3/4)
	
	Kill BKL in minix/itree* (similar to ext2 patches)

<viro@math.psu.edu> (02/04/02 1.537.1.29)
	[PATCH] minixfs cleanups (4/4)
	
	Clean up minix/bitmap.c

<viro@math.psu.edu> (02/04/02 1.537.1.30)
	[PATCH] set_blocksize() in JFS
	
	Use sb_set_blocksize() in JFS instead of trying to do it by hand.

<viro@math.psu.edu> (02/04/02 1.537.1.31)
	[PATCH] hfs compile fix
	
	Fix typo

<viro@math.psu.edu> (02/04/02 1.537.1.32)
	[PATCH] restoring block size upon umount
	
	get_sb_bdev() stores original block size in ->s_old_blocksize and
	kill_block_super() restores it.
	
	This kills 99% of crap with "oh, I've mounted/umounted that device and
	its behaviour had changed" (remaining 1% can be dealt in pretty similar
	ways; ideally I'd like to see ioctls that get/set block size dead and
	gone).

<viro@math.psu.edu> (02/04/02 1.537.1.33)
	[PATCH] fsync_bdev() conversion
	
	Bunch of places converted from fsync_dev/invalidate_buffers to
	fsync_bdev/invalidate_bdev.

<viro@math.psu.edu> (02/04/02 1.537.1.34)
	[PATCH] brw_kiovec() converted to struct block_device *
	
	brw_kiovec() and ll_rw_kiovec() switched to struct block_device *.

<torvalds@penguin.transmeta.com> (02/04/02 1.537.1.35)
	update version and defconfig

<davem@nuts.ninka.net> (02/04/02 1.537.2.38)
	In tcp_v4_send_reset, use inet_sk to get at
	ttl of tcp_socket.

<haveblue@us.ibm.com> (02/04/03 1.537.1.37)
	[PATCH] BKL reduction in do_exit
	
	Push BKL down to the (few) routines that actually need it,
	remove it from the do_exit() path.

<davej@suse.de> (02/04/03 1.537.1.38)
	[PATCH] Hyperthreading binfmt.
	
	Another from 2.4, see comments for details

<davej@suse.de> (02/04/03 1.537.1.39)
	[PATCH] fix broken asm constraint
	
	Simple compile fix.

<greg@kroah.com> (02/04/03 1.537.1.40)
	[PATCH] small fix for mpparse.c
	
	Here's a very tiny bugfix for arch/i386/kernel/mpparse.c in the
	2.4.19-pre2 kernel.  It fixes the problem if there is an error in the
	MP_processor_info() function where the mpc_apicid value is greater than
	MAX_APICS, then we need to decrement the number of valid processors
	before we return (the number was just incremented before the check.)
	
	The patch was written by James Cleverdon.

<davej@suse.de> (02/04/03 1.537.1.41)
	[PATCH] AGPGART capability handling cleanup
	
	Clean up capability handling in AGPGart.
	This came forward from 2.4

<davej@suse.de> (02/04/03 1.537.1.42)
	[PATCH] EFI GUID partition table support.
	
	EFI GUID partition table support from Matt Domsch

<davej@suse.de> (02/04/03 1.537.1.43)
	[PATCH] about locations of various sound files.
	
	introduction of ALSA moved some files around.
	This updates various references.

<davej@suse.de> (02/04/03 1.537.1.44)
	[PATCH] Support for ITE interrupt router
	
	Support for an extra interrupt router.

<adam@nmt.edu> (02/04/03 1.537.1.45)
	[PATCH] 3ware driver update for 2.5.8-pre1
	
	Self explanatory driver update from vendor.

<davej@suse.de> (02/04/03 1.537.1.46)
	[PATCH] watchdog API documentation.
	

<davej@suse.de> (02/04/03 1.537.1.47)
	[PATCH] eicon driver was sleeping with lock held.
	

<davej@suse.de> (02/04/03 1.537.1.48)
	[PATCH] extra codepage support.
	
	Another forward port from 2.4

<davej@suse.de> (02/04/03 1.537.1.49)
	[PATCH] AMD ELAN support.
	
	Add support for AMD Elan.
	(More ELAN patches to follow which rely on CONFIG_MELAN)

<davej@suse.de> (02/04/03 1.537.1.50)
	[PATCH] Cyrix irq router tweak
	
	Another small change from 2.4

<davej@suse.de> (02/04/03 1.537.1.51)
	[PATCH] Cyclades driver region cleanup
	

<davej@suse.de> (02/04/03 1.537.1.52)
	[PATCH] Various completion users.
	
	These files use completion, but don't include header.

<davej@suse.de> (02/04/03 1.537.1.53)
	[PATCH] Document an errata workaround in apic code.
	

<davej@suse.de> (02/04/03 1.537.1.54)
	[PATCH] faster update_atime.
	
	Another 2.4 forward port, original from Andrew Morton.

<davej@suse.de> (02/04/03 1.537.1.55)
	[PATCH] DMI scanner update.
	
	Various quirks from 2.4 and other sources.

<davej@suse.de> (02/04/03 1.537.1.56)
	[PATCH] AMD Elan uses slightly different clock freq
	

<davej@suse.de> (02/04/03 1.537.1.57)
	[PATCH] export rbtree routines for modules.
	

<davej@suse.de> (02/04/03 1.537.1.58)
	[PATCH] Detect get_block() errors in block_read_full_page()
	
	Originally from Anton Altaparmakov..
	
	This causes errors from get_block() in block_read_full_page() to be
	detected and handled properly (by setting page error flag).  Without the
	patch the page (or parts of the page) will contain random data on
	get_block() failing without any form of error being signalled which can
	be catastrophic for filesystems using block_read_full_page() for
	accessing their metadata.  And for normal data it would mean the user
	would see random data instead of what they expected.

<davej@suse.de> (02/04/03 1.537.1.59)
	[PATCH] add AMD Elan resources.
	

<davej@suse.de> (02/04/03 1.537.1.60)
	[PATCH] Extra cards support for MOXA driver
	

<davej@suse.de> (02/04/03 1.537.1.61)
	[PATCH] faster kiobuf init.
	
	Originally from Intel, has been around various vendor trees for a while.
	Aparently worth a noticable speed up in some applications.

<davej@suse.de> (02/04/03 1.537.1.62)
	[PATCH] Fix up broken do while macros.
	

<davej@suse.de> (02/04/03 1.537.1.63)
	[PATCH] document new address space operations.
	

<davej@suse.de> (02/04/03 1.537.1.64)
	[PATCH] fix up broken comment delimiters.
	

<davej@suse.de> (02/04/03 1.537.1.65)
	[PATCH] proc race on task_struct->sig
	
	Originally from Chris Mason <mason@suse.com>..
	
	collect_sigign_sigcatch can race against exit_sighand.  I haven't been
	able to reproduce it, but I think it causes the oops reported in the
	'Kernel Hangs 2.4.16 on heavy io Oracle Tivolie TSM' thread.

<davej@suse.de> (02/04/03 1.537.1.66)
	[PATCH] silence DVD_INVALIDATE_AGID output.
	
	Ancient patch from Jens to hush certain drives which generate a lot of
	printk noise when playing DVDs.

<davej@suse.de> (02/04/03 1.537.1.67)
	[PATCH] Simple boot flag specification support.
	
	Originally by Alan. It was in the 2.4-ac tree for ages, much tweaked
	by myself and Thomas Hood. Its main purpose is for skipping the full
	memory test and other time-wasting diagnostics on reboot.

<davej@suse.de> (02/04/03 1.537.1.68)
	[PATCH] sonypi driver update from 2.4
	

<davej@suse.de> (02/04/03 1.537.1.69)
	[PATCH] group #include's together in x86 ioremap.c
	

<davej@suse.de> (02/04/03 1.537.1.70)
	[PATCH] Gameport patch for drivers/sound/mad16.c
	
	From: Michael Haardt <michael@moria.de> for 2.4, munged by me.
	
	the MAD16 driver is able to enable/disable its gameport, but it does
	not register it in the input subsystem.  The appended patch against
	2.4.19-pre4 fixes that and also allows to enable to gameport via kernel
	command line, not only when loaded as module.

<davej@suse.de> (02/04/03 1.537.1.71)
	[PATCH] CREDITS updates
	

<davej@suse.de> (02/04/03 1.537.1.72)
	[PATCH] Various typo fixes.
	
	Mostly harmless but 1-2 break compilation.

<davej@suse.de> (02/04/03 1.537.1.73)
	[PATCH] region handling cleanups for tpqic02
	

<davej@suse.de> (02/04/03 1.537.1.74)
	[PATCH] UDF write support problem in 2.5.7
	
	 From Peter Osterlund <petero2@telia.com>
	
	I can't get UDF write support to work in kernel 2.5.7 or 2.5.7-pre2.
	The problem is that linux/config.h is not included, so CONFIG_UDF_RW
	is undefined and the driver is compiled without write support. This
	patch fixes my problem:

<davej@suse.de> (02/04/03 1.537.1.75)
	[PATCH] unnecessary includes.
	
	A few follow ups to the cleanup done circa 2.5.4

<davej@suse.de> (02/04/03 1.537.1.76)
	[PATCH] Update file list in INDEX
	

<davej@suse.de> (02/04/03 1.537.1.77)
	[PATCH] PCI IDS update.
	
	Mostly from 2.4. Adds some new ones, and removes some dupes.

<davej@suse.de> (02/04/03 1.537.1.78)
	[PATCH] Update bigphysarea URL
	

<davej@suse.de> (02/04/03 1.537.1.79)
	[PATCH] watchdog nowayout for i810-tco
	
	Originally from Matt Domsch.
	Adds a nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.80)
	[PATCH] videodev fixups / generic usercopy helper
	
	Originally from Gerd...
	
	I've just noticed that a hole left in the recent changes which should
	allow the usb v4l drivers to unregister with open file handles.  The
	drivers itself handle it just fine, but video_generic_ioctl() will barf
	when called on unregistered devices.  Oops.
	
	One way to fix this is to expect drivers call the helper function and
	pass a pointer for the function doing the actual work, i.e. handle it
	this way:
	
	driver_ioctl(inode,file,cmd,userptr)
		-> video_usercopy(inode,file,cmd,userptr,func)
			copy_from_user(...)
			-> func(inode,file,cmd,kernelptr);
			copy_to_user(...)
	
	Patch against 2.5.7-pre2 below. It updates videodev.[ch] and adapts
	usbvideo.c to show how the driver changes will look like.
	
	Note that this change makes the usercopy helper function a very generic
	one, it probably could be used for other drivers to (as long as the API
	has sane magic numbers based on _IO*(...) defines) as there is no
	video4linux-related stuff in there any more.  So we might think of
	renaming it an moving it to some more central place (fs/ioctl.c maybe).

<davej@suse.de> (02/04/03 1.537.1.81)
	[PATCH] watchdog nowayout for acquirewdt
	
	Originally from Matt Domsch.
	Adds a nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.82)
	[PATCH] printk levels for vme_scc driver
	

<davej@suse.de> (02/04/03 1.537.1.83)
	[PATCH] watchdog nowayout for eurotechwdt
	
	Originally from Matt Domsch.
	Adds a nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.84)
	[PATCH] watchdog nowayout for ib700wdt
	
	Originally from Matt Domsch.
	Adds a nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.85)
	[PATCH] more then enough typos.
	
	s/more then/more than/

<davej@suse.de> (02/04/03 1.537.1.86)
	[PATCH] remove dead comment
	
	Original from William Lee Irwin III <wli@holomorphy.com>

<davej@suse.de> (02/04/03 1.537.1.87)
	[PATCH] __init/__exit does nothing in prototypes
	

<davej@suse.de> (02/04/03 1.537.1.88)
	[PATCH] reiserfs tools update.
	
	Recommended version bump.

<davej@suse.de> (02/04/03 1.537.1.89)
	[PATCH] Remove guess from bttv docs.
	

<davej@suse.de> (02/04/03 1.537.1.90)
	[PATCH] More verbosity in VIA tweak
	
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.91)
	[PATCH] watchdog nowayout for advantechwdt
	
	Originally from Matt Domsch.
	Adds a nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.92)
	[PATCH] updated documentation for w9966 driver.
	
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.93)
	[PATCH] extra sanity checks for mempool
	

<davej@suse.de> (02/04/03 1.537.1.94)
	[PATCH] khttpd logs wrong debug message on leaving function.
	

<davej@suse.de> (02/04/03 1.537.1.95)
	[PATCH] nbd compile fix.
	

<davej@suse.de> (02/04/03 1.537.1.96)
	[PATCH] strtok -> strsep in adfs
	

<davej@suse.de> (02/04/03 1.537.1.97)
	[PATCH] remove workaround for old binutils.
	
	Modern binutils spits out a warning, fixing this broke older binutils.
	I guess we can do this in 2.5 ?

<davej@suse.de> (02/04/03 1.537.1.98)
	[PATCH] remove bogus return from mtrr driver.
	
	It's amazing what you spot when you Lindent things.

<davej@suse.de> (02/04/03 1.537.1.99)
	[PATCH] strtok->strsep in hpfs
	

<davej@suse.de> (02/04/03 1.537.1.100)
	[PATCH] strtok->strsep in hfs
	

<davej@suse.de> (02/04/03 1.537.1.101)
	[PATCH] typo in pci_set_mwi header
	

<davej@suse.de> (02/04/03 1.537.1.102)
	[PATCH] strtok->strsep in autofs
	

<davej@suse.de> (02/04/03 1.537.1.103)
	[PATCH] strtok->strsep in shmem
	

<davej@suse.de> (02/04/03 1.537.1.104)
	[PATCH] i2c-proc wasn't checking kmalloc result
	

<davej@suse.de> (02/04/03 1.537.1.105)
	[PATCH] compile fix for gemtek-pci radio card
	

<davej@suse.de> (02/04/03 1.537.1.106)
	[PATCH] strtok->strsep for autofs4
	

<davej@suse.de> (02/04/03 1.537.1.107)
	[PATCH] strtok->strsep isofs
	

<davej@suse.de> (02/04/03 1.537.1.108)
	[PATCH] strtok->strsep in usb
	

<davej@suse.de> (02/04/03 1.537.1.109)
	[PATCH] strtok->strsep in jfs
	

<davej@suse.de> (02/04/03 1.537.1.110)
	[PATCH] Only offer ARM PCMCIA on ARM machines.
	

<davej@suse.de> (02/04/03 1.537.1.111)
	[PATCH] strtok->strsep in ntfs
	

<davej@suse.de> (02/04/03 1.537.1.112)
	[PATCH] strtok->strsep for reiserfs
	

<davej@suse.de> (02/04/03 1.537.1.113)
	[PATCH] strtok->strsep in isdn avmb1 capifs
	

<davej@suse.de> (02/04/03 1.537.1.114)
	[PATCH] apply KERNELRELEASE regexp globally in makefile
	
	Handles things like 2.5.7-dj2-extra-foo-voon in Kernelversion.

<davej@suse.de> (02/04/03 1.537.1.115)
	[PATCH] more kbuild cleanup.
	
	Define KBUILD_BASENAME for init/do_mounts

<davej@suse.de> (02/04/03 1.537.1.116)
	[PATCH] Define KBUILD_BASENAME for .i * .s
	
	originally from John Levon <levon@movementarian.org>

<davej@suse.de> (02/04/03 1.537.1.117)
	[PATCH] MP1.4 SPEC compliance.
	

<davej@suse.de> (02/04/03 1.537.1.118)
	[PATCH] strtok->strsep in affs
	

<davej@suse.de> (02/04/03 1.537.1.119)
	[PATCH] Small fix to pci_alloc_consistent()
	
	Original from Badari Pulavarty <pbadari@us.ibm.com>:
	
	pci_alloc_consistent() is returning zone DMA memory to highmem
	enabled drivers when it really should have been returning zone NORMAL.
	
	Found this while testing qlogicfc driver for > 4GB support.

<davej@suse.de> (02/04/03 1.537.1.120)
	[PATCH] strtok->strsep in atari config
	

<davej@suse.de> (02/04/03 1.537.1.121)
	[PATCH] wrong return codes in ipc shm
	
	We always returned success even when we had no ->vm_ops

<davej@suse.de> (02/04/03 1.537.1.122)
	[PATCH] devexit fix for i82092
	
	In light of the 'lets use this for shutdowns' this will eventually
	be ripped out, but for now it makes sense to include it so that we
	can build it again on modern binutils

<davej@suse.de> (02/04/03 1.537.1.123)
	[PATCH] Fix race in JFS
	
	From Christoph Hellwig
	
	http://oss.software.ibm.com/pipermail/jfs-patches/2002-March/000045.html

<davej@suse.de> (02/04/03 1.537.1.124)
	[PATCH] malloc.h -> slab.h
	
	malloc.h is no more.

<davej@suse.de> (02/04/03 1.537.1.125)
	[PATCH] add EISA port to /proc/ioports
	

<davej@suse.de> (02/04/03 1.537.1.126)
	[PATCH] Fix reiserfs oops with seperate journal dev
	
	From Oleg@namesys.

<davej@suse.de> (02/04/03 1.537.1.127)
	[PATCH] strtok->strsep in alpha setup
	

<davej@suse.de> (02/04/03 1.537.1.128)
	[PATCH] watchdog nowayout for sbc60xxwdt
	
	Originally from Matt Domsch.
	Adds a nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.129)
	[PATCH] Remove address member from scatterlist docs.
	
	The element is dead, so update the docs to reflect reality.

<davej@suse.de> (02/04/03 1.537.1.130)
	[PATCH] extra PIIX entries for IRQ routers.
	

<davej@suse.de> (02/04/03 1.537.1.131)
	[PATCH] Allow use of 256 loop devices
	
	Because 256 is rounder than 255 I guess 8-)

<davej@suse.de> (02/04/03 1.537.1.132)
	[PATCH] watchdog nowayout for shwdt
	
	Originally from Matt Domsch.
	Adds a nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.133)
	[PATCH] updates for make rpm
	
	- install .config in /boot
	- provide kernel-drm package if drm is compiled
	- handle extra '-' marks so that linux-2.5.8-dj3-voon works.

<davej@suse.de> (02/04/03 1.537.1.134)
	[PATCH] DMI entries for HP Pavillion laptops.
	
	These things have USB IRQ routing problems we can work around..

<davej@suse.de> (02/04/03 1.537.1.135)
	[PATCH] Clean up CONFIG_HIGHMEM & HIGHPTE options.
	
	Makes CONFIG_HIGHPTE an option instead of derived.
	Original from Steven Cole.

<davej@suse.de> (02/04/03 1.537.1.136)
	[PATCH] watchdog nowayout for machzwd
	
	Originally from Matt Domsch.
	Adds a nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.137)
	[PATCH] watchdog nowayout for softdog
	
	Originally from Matt Domsch.
	Adds a nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.138)
	[PATCH] watchdog nowayout for wdt_pci
	
	Originally from Matt Domsch.
	Adds a nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.139)
	[PATCH] watchdog nowayout for wdt
	
	Originally from Matt Domsch.
	Adds a nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.140)
	[PATCH] missing includes.
	
	There still seem to be some casualties since the include file shakeup a
	few revisions back, this adds quite a few missing ones, more to come.

<davej@suse.de> (02/04/03 1.537.1.141)
	[PATCH] Christoph Hellwig contact update
	
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.142)
	[PATCH] watchdog nowayout for mixcomwd
	
	Originally from Matt Domsch.
	Adds a nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.143)
	[PATCH] seq_file for /proc/partitions (take 2)
	
	Original from Randy Dunlap <rddunlap@osdl.org>...

<davej@suse.de> (02/04/03 1.537.1.144)
	[PATCH] document <asm-i386/io.h> functions.
	
	The second hunk also contains a fix from Badari Pulavarty to make
	page_to_phys() work on pages >4GB. Without this, we truncate the
	physical address to 32bit

<davej@suse.de> (02/04/03 1.537.1.145)
	[PATCH] kdev_t fixes.
	
	The usual search and replace type operations from various people
	to various drivers..

<davej@suse.de> (02/04/03 1.537.1.146)
	[PATCH] x86 microcode driver update
	
	From Tigran via 2.4

<davej@suse.de> (02/04/03 1.537.1.147)
	[PATCH] Pentium 4 NMI watchdog support
	
	From Mikael via 2.4.

<davej@suse.de> (02/04/03 1.537.1.148)
	[PATCH] jiffies wrap fixes.
	
	Some from 2.4, some from the kernel janitor team,..

<davej@suse.de> (02/04/03 1.537.1.149)
	[PATCH] Add missing MODULE_LICENSE tags
	
	Still a few out there.. Most of these from 2.4

<davej@suse.de> (02/04/03 1.537.1.150)
	[PATCH] Add support for National Semiconductor x86's.
	
	These are mostly Cyrix-alike, but for some quirks we work around.

<davej@suse.de> (02/04/03 1.537.1.151)
	[PATCH] watchdog nowayout for wdt977
	
	Originally from Matt Domsch.
	Adds a nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
	From 2.4

<davej@suse.de> (02/04/03 1.537.1.152)
	[PATCH] PPP documentation.
	
	From Paul via 2.4

<davej@suse.de> (02/04/03 1.537.1.153)
	[PATCH] x86 bluesmoke update.
	
	o  Make MCE compile time optional	(Paul Gortmaker)
	o  P4 thermal trip monitoring.		(Zwane Mwaikambo)
	o  Non-fatal MCE logging.		(Me)

<davej@suse.de> (02/04/03 1.537.1.154)
	[PATCH] pnpbios driver update.
	
	Update from Thomas..
	
	Here are the additional bits from the -ac tree, diffed
	against 2.5.6 + 2.5.5-dj3 patch.  The changes include:
	
	- Improve some comments
	- Postpone starting the kernel thread (Alan Cox)
	- Call kernel thread 'kpnpbiosd' instead of 'kpnpbios'
	- Consolidate printing of error messages to save space
	- Add __init and __exit tags and return appropriate error codes
	- Print slightly more consistent messages
	- Get closer to supporting build-as-module

<davej@suse.de> (02/04/03 1.537.1.155)
	[PATCH] Remove last remaining bits of strtok.
	

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.156)
	update for i386 config.in changes

<christopher@intel.com> (02/04/03 1.537.6.2)
	e1000 net drvr update 1/13:
	License update, the "GNU General Public License" was incorrectly
	referred to as the "GNU Public License".

<christopher@intel.com> (02/04/03 1.537.6.3)
	e1000 net drvr update 2/13:
	Update to low level hardware code.  Adds support for the new 
	82540 device.  Replaces e1000_mac.c e1000_mac.h e1000_phy.c and 
	e1000_phy.h with e1000_hw.c and e1000_hw.c.  Changes to the 
	makefile, header includes, and some minor function syntax 
	changes to get the driver working with the new code.

<christopher@intel.com> (02/04/03 1.537.6.4)
	e1000 net drvr update 3/13:
	Search and replace of adapter->shared with adapter->hw 
	throughout the driver.  This matches the naming used in 
	e1000_hw.c and is more correct.

<christopher@intel.com> (02/04/03 1.537.6.5)
	e1000 net drvr update 4/13:
	Updated transmit path.  Breaks the transmit path up to make it 
	more understandable.  Aggressively reclaim resources by checking
	for completed transmits before queuing each new frame to avoid 
	stalling the driver by delaying interrupts to long.

<christopher@intel.com> (02/04/03 1.537.6.6)
	e1000 net drvr update 5/13:
	VLAN hardware offload.

<christopher@intel.com> (02/04/03 1.537.6.7)
	e1000 net drvr update 6/13:
	Replace LIST_LEN macro use with the standard ARRAY_SIZE.

<christopher@intel.com> (02/04/03 1.537.6.8)
	e1000 net drvr update 7/13:
	Adaptive Inter-Frame Spacing to reduce collisions and improve 
	half duplex transmit performance.

<christopher@intel.com> (02/04/03 1.537.6.9)
	e1000 net drvr updates 8/13:
	Minor receive cleanup, queue empty buffers to the hardware in 
	groups of 16 to reduce unneeded fetches and improve PCI 
	efficiency.

<christopher@intel.com> (02/04/03 1.537.6.10)
	e1000 net drvr update 9/13:
	change_mtu cleanup.  Allows frame sizes up to 2k on the 82542
	instead of limiting the MTU to 1500, so that the 82542 can be 
	used with software 802.1q VLANs.

<christopher@intel.com> (02/04/03 1.537.6.11)
	e1000 net drvr updates 10/13:
	ProcFS code updates, check for page boundaries.

<christopher@intel.com> (02/04/03 1.537.6.12)
	e1000 net drvr updates 11/13:
	Bump version to 4.2.8-k1, use EXPORT_NO_SYMBOLS, minor changes
	to ensure that reported link information is always correct, 
	remove magic numbers in calls to memset.

<christopher@intel.com> (02/04/03 1.537.6.13)
	e1000 net drvr update 12/13:
	Update a few stale comments

<christopher@intel.com> (02/04/03 1.537.6.14)
	e1000 net drvr update 13/13:
	Whitespace cleanup

<davej@suse.de> (02/04/03 1.537.6.15)
	Small net driver fixes/cleanups related to setting
	dev->last_rx equal to jiffies.

<davej@suse.de> (02/04/03 1.537.6.16)
	net driver janitor fixes:
	* region resource handling
	* do-while macro definitions
	* error cleanup

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.157)
	Fix missing include due to do_exit() BKL movement

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.158)
	strtok -> strsep fixes

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.159)
	Fix compile without EISA support

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.160)
	Header file cleanup fixes

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.161)
	vmalloc_to_page() should be usable for everybody (see discussion
	on kernel mailing list)

<p_gortmaker@yahoo.com> (02/04/03 1.537.8.2)
	s/extern inline/static inline/ for net drivers:
	aironet4500, arlan, e2100, baycom, soundmodem

<p_gortmaker@yahoo.com> (02/04/03 1.537.8.3)
	These net drivers init dev->rmem_start/end but do not use these at all 
	(probably as a result of copying skeleton or similar).  Removed this as 
	a step in the goal to remove rmem_start/end from netdev struct entirely.

<p_gortmaker@yahoo.com> (02/04/03 1.537.8.4)
	drivers/net/sb1000.c does not use any ISA memory for I/O but does (ab)use
	the rmem_end field to store an I/O port address in.  As rmem_end is going
	away, this does a s/rmem_end/mem_start/g since mem_start is otherwise 
	unused in sb1000.

<p_gortmaker@yahoo.com> (02/04/03 1.537.8.5)
	The struct netdev rmem_start and rmem_end entries are specific to 8390
	based net cards and hence these should be moved into the dev->priv
	for these cards.
	
	This patch adds rmem_start and rmem_end to dev->priv in 8390.h, and does:
	
	        s/dev->rmem_/ei_local.rmem_/g   on all 8390 shared mem drivers.

<p_gortmaker@yahoo.com> (02/04/03 1.537.8.6)
	Enable multiple ISA ethernet probes at boot (old behaviour was to quit
	once eth0 was found) - it is long since anyone shipped or built kernels
	with all the ISA drivers compiled in.
	
	This change will eliminate the need for adding "ether=...." at the boot 
	prompt for a lot of users who build their own kernels and have multiple
	ISA ethercards at standard (i.e. probed) I/O addresses.
	
	Also got sick of counting zeros, so did a struct init cleanup,
	i.e. {1,0,0,0,0,0,0,0,9}  -> {one:1, nine:9}

<p_gortmaker@yahoo.com> (02/04/03 1.537.8.7)
	finally, remove rmem_{start,end} from struct net_device.
	one more step closer to killing off ether=

<davej@suse.de> (02/04/03 1.537.8.8)
	Remove old 2.2.x wait queue compat code from cosa wan driver.

<davej@suse.de> (02/04/03 1.537.8.9)
	Merge new tc35815 net driver from 2.4.x.

<davej@suse.de> (02/04/03 1.537.8.10)
	jiffies wrap fixes for net drivers atp, yam, and sb1000.

<jgarzik@mandrakesoft.com> (02/04/03 1.537.8.11)
	Merge new sun3 82586 net driver from 2.4.x.
	

<davej@suse.de> (02/04/03 1.537.8.12)
	Merge SIByte SB1250 net driver from 2.4.x.

<jgarzik@mandrakesoft.com> (02/04/03 1.537.1.164)
	Remove unused, and now deprecated, references to
	dev->rmem_{start,end} in skfp and smctr drivers.

<jgarzik@mandrakesoft.com> (02/04/03 1.537.1.165)
	Clean up tg3 net drver PCI DMA mapping, and in the process
	fix the build on ia32.
	
	Author: Dave Miller

<greg@kroah.com> (02/04/03 1.577)
	USB HID driver
	
	removed CONFIG_USB_HIDDEV #ifdefs in the driver.

<petkan@users.sourceforge.net> (02/04/03 1.578)
	USB rtl8150 driver
	
	fix the "small packet" problem and debug messages cleanup

<johannes@erdfelt.com> (02/04/03 1.579)
	USB UHCI driver
	
	The patch ensures that uhci.c doesn't use urb->status after the
	completion callback if it doesn't need to.

<Romain.Lievin@esisar.inpg.fr> (02/04/03 1.580)
	USB tiusb
	
	added tiusb driver
	some tweaks to the driver done by greg@kroah.com

<vojtech@suse.cz> (02/04/03 1.581)
	USB 64bit fixes

<sl@lineo.com> (02/04/03 1.582)
	USB safe_serial
	
	added safe_serial driver
	tweaks to the driver done by greg@kroah.com to get things to work on 2.5

<dbrownell@users.sourceforge.net> (02/04/03 1.583)
	USB ohci driver fixes
	  
	   - An oopsable bug affecting unlink of interrupt
	     transfers. Fix mirrors one done ages ago for ISO.
	     (Original patch by Matt Hughes)
	   - Better cleanup on init failure (Matthew Frederickson)
	   - fixes the problem Stuart reported, where interrupt urbs
	     couldn't be unlinked from their completion handlers, and it
	     also makes OHCI return the correct status code for async
	     unlink requests (-EINPROGRESS not zero).

<greg@kroah.com> (02/04/03 1.584)
	USB
	
	Updated the CREDITS, Config.help, Config.in, and Makefile to be up to date
	with the last round of USB changes.

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.166)
	Get rid of duplicated EISA_bus variable

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.167)
	oops, lost end parenthesis

<davej@suse.de> (02/04/03 1.537.1.168)
	[PATCH] The last? strtok fixes.
	
	Hopefully this is all of them..

<rml@tech9.net> (02/04/03 1.537.1.169)
	[PATCH] simple preemption debug check
	
	This simple check was first suggested by Andrew Morton.  Pretty basic -
	whines if a task exits with a nonzero preempt_count value.
	
	I put an identical check in the 2.4 preempt-kernel patch and - sure
	enough - it was found that XFS essentially disables preemption as it
	destroys data structures containing locks without first unlocking.  The
	SGI folks are working on that.
	
	Anyhow, its a quick and clean solution to debugging potential problems.
	Patch is against 2.5.7, please apply.
	
		Robert Love


