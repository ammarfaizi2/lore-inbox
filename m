Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWILIRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWILIRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWILIRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:17:14 -0400
Received: from dea.vocord.ru ([217.67.177.50]:2717 "EHLO
	uganda.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S1751289AbWILIRJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:17:09 -0400
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: [take18 0/4] kevent: Generic event handling mechanism.
In-Reply-To: <115a6230591036@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Tue, 12 Sep 2006 12:41:02 +0400
Message-Id: <1158050462413@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Generic event handling mechanism.

Consider for inclusion.

Changes from 'take17' patchset:
 * Use RB tree instead of hash table. 
	At least for a web sever, frequency of addition/deletion of new kevent 
	is comparable with number of search access, i.e. most of the time events 
	are added, accesed only couple of times and then removed, so it justifies 
	RB tree usage over AVL tree, since the latter does have much slower deletion 
	time (max O(log(N)) compared to 3 ops), 
	although faster search time (1.44*O(log(N)) vs. 2*O(log(N))). 
	So for kevents I use RB tree for now and later, when my AVL tree implementation 
	is ready, it will be possible to compare them.
 * Changed readiness check for socket notifications.

With both above changes it is possible to achieve more than 3380 req/second compared to 2200, 
sometimes 2500 req/second for epoll() for trivial web-server and httperf client on the same hardware.
It is possible that above kevent limit is due to maximum allowed kevents in a time limit, which is 4096 events.

Changes from 'take16' patchset:
 * misc cleanups (__read_mostly, const ...)
 * created special macro which is used for mmap size (number of pages) calculation
 * export kevent_socket_notify(), since it is used in network protocols which can be 
	built as modules (IPv6 for example)

Changes from 'take15' patchset:
 * converted kevent_timer to high-resolution timers, this forces timer API update at
	http://linux-net.osdl.org/index.php/Kevent
 * use struct ukevent* instead of void * in syscalls (documentation has been updated)
 * added warning in kevent_add_ukevent() if ring has broken index (for testing)

Changes from 'take14' patchset:
 * added kevent_wait()
    This syscall waits until either timeout expires or at least one event
    becomes ready. It also commits that @num events from @start are processed
    by userspace and thus can be be removed or rearmed (depending on it's flags).
    It can be used for commit events read by userspace through mmap interface.
    Example userspace code (evtest.c) can be found on project's homepage.
 * added socket notifications (send/recv/accept)

Changes from 'take13' patchset:
 * do not get lock aroung user data check in __kevent_search()
 * fail early if there were no registered callbacks for given type of kevent
 * trailing whitespace cleanup

Changes from 'take12' patchset:
 * remove non-chardev interface for initialization
 * use pointer to kevent_mring instead of unsigned longs
 * use aligned 64bit type in raw user data (can be used by high-res timer if needed)
 * simplified enqueue/dequeue callbacks and kevent initialization
 * use nanoseconds for timeout
 * put number of milliseconds into timer's return data
 * move some definitions into user-visible header
 * removed filenames from comments

Changes from 'take11' patchset:
 * include missing headers into patchset
 * some trivial code cleanups (use goto instead of if/else games and so on)
 * some whitespace cleanups
 * check for ready_callback() callback before main loop which should save us some ticks

Changes from 'take10' patchset:
 * removed non-existent prototypes
 * added helper function for kevent_registered_callbacks
 * fixed 80 lines comments issues
 * added shared between userspace and kernelspace header instead of embedd them in one
 * core restructuring to remove forward declarations
 * s o m e w h i t e s p a c e c o d y n g s t y l e c l e a n u p
 * use vm_insert_page() instead of remap_pfn_range()

Changes from 'take9' patchset:
 * fixed ->nopage method

Changes from 'take8' patchset:
 * fixed mmap release bug
 * use module_init() instead of late_initcall()
 * use better structures for timer notifications

Changes from 'take7' patchset:
 * new mmap interface (not tested, waiting for other changes to be acked)
	- use nopage() method to dynamically substitue pages
	- allocate new page for events only when new added kevent requres it
	- do not use ugly index dereferencing, use structure instead
	- reduced amount of data in the ring (id and flags), 
		maximum 12 pages on x86 per kevent fd

Changes from 'take6' patchset:
 * a lot of comments!
 * do not use list poisoning for detection of the fact, that entry is in the list
 * return number of ready kevents even if copy*user() fails
 * strict check for number of kevents in syscall
 * use ARRAY_SIZE for array size calculation
 * changed superblock magic number
 * use SLAB_PANIC instead of direct panic() call
 * changed -E* return values
 * a lot of small cleanups and indent fixes

Changes from 'take5' patchset:
 * removed compilation warnings about unused wariables when lockdep is not turned on
 * do not use internal socket structures, use appropriate (exported) wrappers instead
 * removed default 1 second timeout
 * removed AIO stuff from patchset

Changes from 'take4' patchset:
 * use miscdevice instead of chardevice
 * comments fixes

Changes from 'take3' patchset:
 * removed serializing mutex from kevent_user_wait()
 * moved storage list processing to RCU
 * removed lockdep screaming - all storage locks are initialized in the same function, so it was learned 
	to differentiate between various cases
 * remove kevent from storage if is marked as broken after callback
 * fixed a typo in mmaped buffer implementation which would end up in wrong index calcualtion 

Changes from 'take2' patchset:
 * split kevent_finish_user() to locked and unlocked variants
 * do not use KEVENT_STAT ifdefs, use inline functions instead
 * use array of callbacks of each type instead of each kevent callback initialization
 * changed name of ukevent guarding lock
 * use only one kevent lock in kevent_user for all hash buckets instead of per-bucket locks
 * do not use kevent_user_ctl structure instead provide needed arguments as syscall parameters
 * various indent cleanups
 * added optimisation, which is aimed to help when a lot of kevents are being copied from userspace
 * mapped buffer (initial) implementation (no userspace yet)

Changes from 'take1' patchset:
 - rebased against 2.6.18-git tree
 - removed ioctl controlling
 - added new syscall kevent_get_events(int fd, unsigned int min_nr, unsigned int max_nr,
			unsigned int timeout, void __user *buf, unsigned flags)
 - use old syscall kevent_ctl for creation/removing, modification and initial kevent 
	initialization
 - use mutuxes instead of semaphores
 - added file descriptor check and return error if provided descriptor does not match
	kevent file operations
 - various indent fixes
 - removed aio_sendfile() declarations.

Thank you.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>


