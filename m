Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVLMHzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVLMHzl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 02:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVLMHzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 02:55:41 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:22928 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750711AbVLMHzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 02:55:40 -0500
Date: Tue, 13 Dec 2005 08:54:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213075441.GB6765@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212161944.3185a3f9.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> I'd have thought that the way to do this is to simply reimplement 
> down(), up(), down_trylock(), etc using the new xchg-based code and to 
> then hunt down those few parts of the kernel which actually use the 
> old semaphore's counting feature and convert them to use down_sem(), 
> up_sem(), etc.  And rename all the old semaphore code: 
> s/down/down_sem/etc.

even better than that, why not use the solution that we've implemented 
for the -rt patchset, more than a year ago?

the solution i took was this:

- i did not touch the 'struct semaphore' namespace, but introduced a
  'struct compat_semaphore'.

- i introduced a 'type-sensitive' macro wrapper that switches down() 
  (and the other APIs) to either to the assembly variant (if the 
  variable's type is struct compat_semaphore), or switches it to the new 
  generic mutex (if the type is struct semaphore), at build-time. There 
  is no runtime overhead due to this build-time-switching.

- for many months we worked with upstream maintainers to convert dozens
  of mutex users over to struct completion, where this was appropriate.

all this simplified the 'compatibility conversion' to the patch below.  
No other non-generic changes are needed.

	Ingo

----
convert the remaining users of 'full Linux semaphore semantics' over to 
compat_semaphore.

 drivers/acpi/osl.c                        |   12 ++++++------
 drivers/ieee1394/ieee1394_types.h         |    2 +-
 drivers/ieee1394/nodemgr.c                |    2 +-
 drivers/ieee1394/raw1394-private.h        |    2 +-
 drivers/media/dvb/dvb-core/dvb_frontend.c |    2 +-
 drivers/media/dvb/dvb-core/dvb_frontend.h |    2 +-
 drivers/net/3c527.c                       |    2 +-
 drivers/net/hamradio/6pack.c              |    2 +-
 drivers/net/hamradio/mkiss.c              |    2 +-
 drivers/net/plip.c                        |    5 ++++-
 drivers/net/ppp_async.c                   |    2 +-
 drivers/net/ppp_synctty.c                 |    2 +-
 drivers/pci/hotplug/cpci_hotplug_core.c   |    4 ++--
 drivers/pci/hotplug/cpqphp_ctrl.c         |    4 ++--
 drivers/pci/hotplug/ibmphp_hpc.c          |    2 +-
 drivers/pci/hotplug/pciehp_ctrl.c         |    4 ++--
 drivers/pci/hotplug/shpchp_ctrl.c         |    4 ++--
 drivers/scsi/aacraid/aacraid.h            |    4 ++--
 drivers/scsi/aic7xxx/aic79xx_osm.h        |    2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.h        |    2 +-
 drivers/scsi/qla2xxx/qla_def.h            |    2 +-
 drivers/usb/storage/usb.h                 |    2 +-
 fs/xfs/linux-2.6/mutex.h                  |    2 +-
 fs/xfs/linux-2.6/sema.h                   |    2 +-
 fs/xfs/linux-2.6/xfs_buf.h                |    4 ++--
 include/linux/jffs2_fs_i.h                |   10 +++++++++-
 include/linux/jffs2_fs_sb.h               |    6 +++---
 include/linux/parport.h                   |    2 +-
 include/pcmcia/ss.h                       |    2 +-
 include/scsi/scsi_transport_spi.h         |    2 +-
 30 files changed, 54 insertions(+), 43 deletions(-)

Index: linux/drivers/acpi/osl.c
===================================================================
--- linux.orig/drivers/acpi/osl.c
+++ linux/drivers/acpi/osl.c
@@ -728,14 +728,14 @@ void acpi_os_delete_lock(acpi_handle han
 acpi_status
 acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle * handle)
 {
-	struct semaphore *sem = NULL;
+	struct compat_semaphore *sem = NULL;
 
 	ACPI_FUNCTION_TRACE("os_create_semaphore");
 
-	sem = acpi_os_allocate(sizeof(struct semaphore));
+	sem = acpi_os_allocate(sizeof(struct compat_semaphore));
 	if (!sem)
 		return_ACPI_STATUS(AE_NO_MEMORY);
-	memset(sem, 0, sizeof(struct semaphore));
+	memset(sem, 0, sizeof(struct compat_semaphore));
 
 	sema_init(sem, initial_units);
 
@@ -758,7 +758,7 @@ EXPORT_SYMBOL(acpi_os_create_semaphore);
 
 acpi_status acpi_os_delete_semaphore(acpi_handle handle)
 {
-	struct semaphore *sem = (struct semaphore *)handle;
+	struct compat_semaphore *sem = (struct compat_semaphore *)handle;
 
 	ACPI_FUNCTION_TRACE("os_delete_semaphore");
 
@@ -787,7 +787,7 @@ EXPORT_SYMBOL(acpi_os_delete_semaphore);
 acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
 {
 	acpi_status status = AE_OK;
-	struct semaphore *sem = (struct semaphore *)handle;
+	struct compat_semaphore *sem = (struct compat_semaphore *)handle;
 	int ret = 0;
 
 	ACPI_FUNCTION_TRACE("os_wait_semaphore");
@@ -868,7 +868,7 @@ EXPORT_SYMBOL(acpi_os_wait_semaphore);
  */
 acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units)
 {
-	struct semaphore *sem = (struct semaphore *)handle;
+	struct compat_semaphore *sem = (struct compat_semaphore *)handle;
 
 	ACPI_FUNCTION_TRACE("os_signal_semaphore");
 
Index: linux/drivers/ieee1394/ieee1394_types.h
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_types.h
+++ linux/drivers/ieee1394/ieee1394_types.h
@@ -19,7 +19,7 @@ struct hpsb_tlabel_pool {
 	spinlock_t lock;
 	u8 next;
 	u32 allocations;
-	struct semaphore count;
+	struct compat_semaphore count;
 };
 
 #define HPSB_TPOOL_INIT(_tp)			\
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c
+++ linux/drivers/ieee1394/nodemgr.c
@@ -114,7 +114,7 @@ struct host_info {
 	struct hpsb_host *host;
 	struct list_head list;
 	struct completion exited;
-	struct semaphore reset_sem;
+	struct compat_semaphore reset_sem;
 	int pid;
 	char daemon_name[15];
 	int kill_me;
Index: linux/drivers/ieee1394/raw1394-private.h
===================================================================
--- linux.orig/drivers/ieee1394/raw1394-private.h
+++ linux/drivers/ieee1394/raw1394-private.h
@@ -29,7 +29,7 @@ struct file_info {
 
         struct list_head req_pending;
         struct list_head req_complete;
-        struct semaphore complete_sem;
+        struct compat_semaphore complete_sem;
         spinlock_t reqlists_lock;
         wait_queue_head_t poll_wait_complete;
 
Index: linux/drivers/media/dvb/dvb-core/dvb_frontend.c
===================================================================
--- linux.orig/drivers/media/dvb/dvb-core/dvb_frontend.c
+++ linux/drivers/media/dvb/dvb-core/dvb_frontend.c
@@ -95,7 +95,7 @@ struct dvb_frontend_private {
 	struct dvb_device *dvbdev;
 	struct dvb_frontend_parameters parameters;
 	struct dvb_fe_events events;
-	struct semaphore sem;
+	struct compat_semaphore sem;
 	struct list_head list_head;
 	wait_queue_head_t wait_queue;
 	pid_t thread_pid;
Index: linux/drivers/media/dvb/dvb-core/dvb_frontend.h
===================================================================
--- linux.orig/drivers/media/dvb/dvb-core/dvb_frontend.h
+++ linux/drivers/media/dvb/dvb-core/dvb_frontend.h
@@ -86,7 +86,7 @@ struct dvb_fe_events {
 	int			  eventr;
 	int			  overflow;
 	wait_queue_head_t	  wait_queue;
-	struct semaphore	  sem;
+	struct compat_semaphore	  sem;
 };
 
 struct dvb_frontend {
Index: linux/drivers/net/3c527.c
===================================================================
--- linux.orig/drivers/net/3c527.c
+++ linux/drivers/net/3c527.c
@@ -182,7 +182,7 @@ struct mc32_local 
 
 	u16 rx_ring_tail;       /* index to rx de-queue end */ 
 
-	struct semaphore cmd_mutex;    /* Serialises issuing of execute commands */
+	struct compat_semaphore cmd_mutex;    /* Serialises issuing of execute commands */
         struct completion execution_cmd; /* Card has completed an execute command */
 	struct completion xceiver_cmd;   /* Card has completed a tx or rx command */
 };
Index: linux/drivers/net/hamradio/6pack.c
===================================================================
--- linux.orig/drivers/net/hamradio/6pack.c
+++ linux/drivers/net/hamradio/6pack.c
@@ -124,7 +124,7 @@ struct sixpack {
 	struct timer_list	tx_t;
 	struct timer_list	resync_t;
 	atomic_t		refcnt;
-	struct semaphore	dead_sem;
+	struct compat_semaphore	dead_sem;
 	spinlock_t		lock;
 };
 
Index: linux/drivers/net/hamradio/mkiss.c
===================================================================
--- linux.orig/drivers/net/hamradio/mkiss.c
+++ linux/drivers/net/hamradio/mkiss.c
@@ -85,7 +85,7 @@ struct mkiss {
 #define CRC_MODE_SMACK_TEST	4
 
 	atomic_t		refcnt;
-	struct semaphore	dead_sem;
+	struct compat_semaphore	dead_sem;
 };
 
 /*---------------------------------------------------------------------------*/
Index: linux/drivers/net/plip.c
===================================================================
--- linux.orig/drivers/net/plip.c
+++ linux/drivers/net/plip.c
@@ -229,7 +229,10 @@ struct net_local {
 	                              struct hh_cache *hh);
 	spinlock_t lock;
 	atomic_t kill_timer;
-	struct semaphore killed_timer_sem;
+	/*
+	 * PREEMPT_RT: this isnt a mutex, it should be struct completion.
+	 */
+	struct compat_semaphore killed_timer_sem;
 };
 
 static inline void enable_parport_interrupts (struct net_device *dev)
Index: linux/drivers/net/ppp_async.c
===================================================================
--- linux.orig/drivers/net/ppp_async.c
+++ linux/drivers/net/ppp_async.c
@@ -66,7 +66,7 @@ struct asyncppp {
 	struct tasklet_struct tsk;
 
 	atomic_t	refcnt;
-	struct semaphore dead_sem;
+	struct compat_semaphore dead_sem;
 	struct ppp_channel chan;	/* interface to generic ppp layer */
 	unsigned char	obuf[OBUFSIZE];
 };
Index: linux/drivers/net/ppp_synctty.c
===================================================================
--- linux.orig/drivers/net/ppp_synctty.c
+++ linux/drivers/net/ppp_synctty.c
@@ -70,7 +70,7 @@ struct syncppp {
 	struct tasklet_struct tsk;
 
 	atomic_t	refcnt;
-	struct semaphore dead_sem;
+	struct compat_semaphore dead_sem;
 	struct ppp_channel chan;	/* interface to generic ppp layer */
 };
 
Index: linux/drivers/pci/hotplug/cpci_hotplug_core.c
===================================================================
--- linux.orig/drivers/pci/hotplug/cpci_hotplug_core.c
+++ linux/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -60,8 +60,8 @@ static int slots;
 static atomic_t extracting;
 int cpci_debug;
 static struct cpci_hp_controller *controller;
-static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
-static struct semaphore thread_exit;		/* guard ensure thread has exited before calling it quits */
+static struct compat_semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
+static struct compat_semaphore thread_exit;		/* guard ensure thread has exited before calling it quits */
 static int thread_finished = 1;
 
 static int enable_slot(struct hotplug_slot *slot);
Index: linux/drivers/pci/hotplug/cpqphp_ctrl.c
===================================================================
--- linux.orig/drivers/pci/hotplug/cpqphp_ctrl.c
+++ linux/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -45,8 +45,8 @@ static int configure_new_function(struct
 			u8 behind_bridge, struct resource_lists *resources);
 static void interrupt_event_handler(struct controller *ctrl);
 
-static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
-static struct semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
+static struct compat_semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
+static struct compat_semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
 static int event_finished;
 static unsigned long pushbutton_pending;	/* = 0 */
 
Index: linux/drivers/pci/hotplug/ibmphp_hpc.c
===================================================================
--- linux.orig/drivers/pci/hotplug/ibmphp_hpc.c
+++ linux/drivers/pci/hotplug/ibmphp_hpc.c
@@ -104,7 +104,7 @@ static int tid_poll;
 static struct semaphore sem_hpcaccess;	// lock access to HPC
 static struct semaphore semOperations;	// lock all operations and
 					// access to data structures
-static struct semaphore sem_exit;	// make sure polling thread goes away
+static struct compat_semaphore sem_exit;	// make sure polling thread goes away
 //----------------------------------------------------------------------------
 // local function prototypes
 //----------------------------------------------------------------------------
Index: linux/drivers/pci/hotplug/pciehp_ctrl.c
===================================================================
--- linux.orig/drivers/pci/hotplug/pciehp_ctrl.c
+++ linux/drivers/pci/hotplug/pciehp_ctrl.c
@@ -37,8 +37,8 @@
 
 static void interrupt_event_handler(struct controller *ctrl);
 
-static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
-static struct semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
+static struct compat_semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
+static struct compat_semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
 static int event_finished;
 static unsigned long pushbutton_pending;	/* = 0 */
 static unsigned long surprise_rm_pending;	/* = 0 */
Index: linux/drivers/pci/hotplug/shpchp_ctrl.c
===================================================================
--- linux.orig/drivers/pci/hotplug/shpchp_ctrl.c
+++ linux/drivers/pci/hotplug/shpchp_ctrl.c
@@ -37,8 +37,8 @@
 
 static void interrupt_event_handler(struct controller *ctrl);
 
-static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
-static struct semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
+static struct compat_semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
+static struct compat_semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
 static int event_finished;
 static unsigned long pushbutton_pending;	/* = 0 */
 
Index: linux/drivers/scsi/aacraid/aacraid.h
===================================================================
--- linux.orig/drivers/scsi/aacraid/aacraid.h
+++ linux/drivers/scsi/aacraid/aacraid.h
@@ -735,7 +735,7 @@ struct aac_fib_context {
 	u32			unique;		// unique value representing this context
 	ulong			jiffies;	// used for cleanup - dmb changed to ulong
 	struct list_head	next;		// used to link context's into a linked list
-	struct semaphore 	wait_sem;	// this is used to wait for the next fib to arrive.
+	struct compat_semaphore	wait_sem;	// this is used to wait for the next fib to arrive.
 	int			wait;		// Set to true when thread is in WaitForSingleObject
 	unsigned long		count;		// total number of FIBs on FibList
 	struct list_head	fib_list;	// this holds fibs and their attachd hw_fibs
@@ -804,7 +804,7 @@ struct fib {
 	 *	This is the event the sendfib routine will wait on if the
 	 *	caller did not pass one and this is synch io.
 	 */
-	struct semaphore 	event_wait;
+	struct compat_semaphore	event_wait;
 	spinlock_t		event_lock;
 
 	u32			done;	/* gets set to 1 when fib is complete */
Index: linux/drivers/scsi/aic7xxx/aic79xx_osm.h
===================================================================
--- linux.orig/drivers/scsi/aic7xxx/aic79xx_osm.h
+++ linux/drivers/scsi/aic7xxx/aic79xx_osm.h
@@ -390,7 +390,7 @@ struct ahd_platform_data {
 	spinlock_t		 spin_lock;
 	u_int			 qfrozen;
 	struct timer_list	 reset_timer;
-	struct semaphore	 eh_sem;
+	struct compat_semaphore	 eh_sem;
 	struct Scsi_Host        *host;		/* pointer to scsi host */
 #define AHD_LINUX_NOIRQ	((uint32_t)~0)
 	uint32_t		 irq;		/* IRQ for this adapter */
Index: linux/drivers/scsi/aic7xxx/aic7xxx_osm.h
===================================================================
--- linux.orig/drivers/scsi/aic7xxx/aic7xxx_osm.h
+++ linux/drivers/scsi/aic7xxx/aic7xxx_osm.h
@@ -394,7 +394,7 @@ struct ahc_platform_data {
 	spinlock_t		 spin_lock;
 	u_int			 qfrozen;
 	struct timer_list	 reset_timer;
-	struct semaphore	 eh_sem;
+	struct compat_semaphore	 eh_sem;
 	struct Scsi_Host        *host;		/* pointer to scsi host */
 #define AHC_LINUX_NOIRQ	((uint32_t)~0)
 	uint32_t		 irq;		/* IRQ for this adapter */
Index: linux/drivers/scsi/qla2xxx/qla_def.h
===================================================================
--- linux.orig/drivers/scsi/qla2xxx/qla_def.h
+++ linux/drivers/scsi/qla2xxx/qla_def.h
@@ -2411,7 +2411,7 @@ typedef struct scsi_qla_host {
 	spinlock_t	mbx_reg_lock;   /* Mbx Cmd Register Lock */
 
 	struct semaphore mbx_cmd_sem;	/* Serialialize mbx access */
-	struct semaphore mbx_intr_sem;  /* Used for completion notification */
+	struct compat_semaphore mbx_intr_sem;  /* Used for completion notification */
 
 	uint32_t	mbx_flags;
 #define  MBX_IN_PROGRESS	BIT_0
Index: linux/drivers/usb/storage/usb.h
===================================================================
--- linux.orig/drivers/usb/storage/usb.h
+++ linux/drivers/usb/storage/usb.h
@@ -171,7 +171,7 @@ struct us_data {
 	dma_addr_t		iobuf_dma;
 
 	/* mutual exclusion and synchronization structures */
-	struct semaphore	sema;		 /* to sleep thread on	    */
+	struct compat_semaphore	sema;		 /* to sleep thread on	    */
 	struct completion	notify;		 /* thread begin/end	    */
 	wait_queue_head_t	delay_wait;	 /* wait during scan, reset */
 
Index: linux/fs/xfs/linux-2.6/mutex.h
===================================================================
--- linux.orig/fs/xfs/linux-2.6/mutex.h
+++ linux/fs/xfs/linux-2.6/mutex.h
@@ -28,7 +28,7 @@
  * callers.
  */
 #define MUTEX_DEFAULT		0x0
-typedef struct semaphore	mutex_t;
+typedef struct compat_semaphore	mutex_t;
 
 #define mutex_init(lock, type, name)		sema_init(lock, 1)
 #define mutex_destroy(lock)			sema_init(lock, -99)
Index: linux/fs/xfs/linux-2.6/sema.h
===================================================================
--- linux.orig/fs/xfs/linux-2.6/sema.h
+++ linux/fs/xfs/linux-2.6/sema.h
@@ -27,7 +27,7 @@
  * sema_t structure just maps to struct semaphore in Linux kernel.
  */
 
-typedef struct semaphore sema_t;
+typedef struct compat_semaphore sema_t;
 
 #define init_sema(sp, val, c, d)	sema_init(sp, val)
 #define initsema(sp, val)		sema_init(sp, val)
Index: linux/fs/xfs/linux-2.6/xfs_buf.h
===================================================================
--- linux.orig/fs/xfs/linux-2.6/xfs_buf.h
+++ linux/fs/xfs/linux-2.6/xfs_buf.h
@@ -114,7 +114,7 @@ typedef int (*page_buf_bdstrat_t)(struct
 #define PB_PAGES	2
 
 typedef struct xfs_buf {
-	struct semaphore	pb_sema;	/* semaphore for lockables  */
+	struct compat_semaphore	pb_sema;	/* semaphore for lockables  */
 	unsigned long		pb_queuetime;	/* time buffer was queued   */
 	atomic_t		pb_pin_count;	/* pin count		    */
 	wait_queue_head_t	pb_waiters;	/* unpin waiters	    */
@@ -134,7 +134,7 @@ typedef struct xfs_buf {
 	page_buf_iodone_t	pb_iodone;	/* I/O completion function */
 	page_buf_relse_t	pb_relse;	/* releasing function */
 	page_buf_bdstrat_t	pb_strat;	/* pre-write function */
-	struct semaphore	pb_iodonesema;	/* Semaphore for I/O waiters */
+	struct compat_semaphore	pb_iodonesema;	/* Semaphore for I/O waiters */
 	void			*pb_fspriv;
 	void			*pb_fspriv2;
 	void			*pb_fspriv3;
Index: linux/include/linux/jffs2_fs_i.h
===================================================================
--- linux.orig/include/linux/jffs2_fs_i.h
+++ linux/include/linux/jffs2_fs_i.h
@@ -14,7 +14,15 @@ struct jffs2_inode_info {
 	   before letting GC proceed. Or we'd have to put ugliness
 	   into the GC code so it didn't attempt to obtain the i_sem
 	   for the inode(s) which are already locked */
-	struct semaphore sem;
+	/*
+	 * (On PREEMPT_RT: while use of ei->sem is mostly mutex-alike, the
+	 * SLAB cache keeps the semaphore locked, which breaks the strict
+	 * "owner must exist" properties of rt_mutexes. Fix it the easy
+	 * way: by going to a compat_semaphore. But the real fix would be
+	 * to cache inodes in an unlocked state and lock them when
+	 * allocating a new inode.)
+	 */
+	struct compat_semaphore sem;
 
 	/* The highest (datanode) version number used for this ino */
 	uint32_t highest_version;
Index: linux/include/linux/jffs2_fs_sb.h
===================================================================
--- linux.orig/include/linux/jffs2_fs_sb.h
+++ linux/include/linux/jffs2_fs_sb.h
@@ -35,7 +35,7 @@ struct jffs2_sb_info {
 	struct completion gc_thread_start; /* GC thread start completion */
 	struct completion gc_thread_exit; /* GC thread exit completion port */
 
-	struct semaphore alloc_sem;	/* Used to protect all the following
+	struct compat_semaphore alloc_sem; /* Used to protect all the following
 					   fields, and also to protect against
 					   out-of-order writing of nodes. And GC. */
 	uint32_t cleanmarker_size;	/* Size of an _inline_ CLEANMARKER
@@ -93,7 +93,7 @@ struct jffs2_sb_info {
 	/* Sem to allow jffs2_garbage_collect_deletion_dirent to
 	   drop the erase_completion_lock while it's holding a pointer
 	   to an obsoleted node. I don't like this. Alternatives welcomed. */
-	struct semaphore erase_free_sem;
+	struct compat_semaphore erase_free_sem;
 
 	uint32_t wbuf_pagesize; /* 0 for NOR and other flashes with no wbuf */
 
@@ -104,7 +104,7 @@ struct jffs2_sb_info {
 	uint32_t wbuf_len;
 	struct jffs2_inodirty *wbuf_inodes;
 
-	struct rw_semaphore wbuf_sem;	/* Protects the write buffer */
+	struct compat_rw_semaphore wbuf_sem;	/* Protects the write buffer */
 
 	/* Information about out-of-band area usage... */
 	struct nand_oobinfo *oobinfo;
Index: linux/include/linux/parport.h
===================================================================
--- linux.orig/include/linux/parport.h
+++ linux/include/linux/parport.h
@@ -254,7 +254,7 @@ enum ieee1284_phase {
 struct ieee1284_info {
 	int mode;
 	volatile enum ieee1284_phase phase;
-	struct semaphore irq;
+	struct compat_semaphore irq;
 };
 
 /* A parallel port */
Index: linux/include/pcmcia/ss.h
===================================================================
--- linux.orig/include/pcmcia/ss.h
+++ linux/include/pcmcia/ss.h
@@ -243,7 +243,7 @@ struct pcmcia_socket {
 #endif
 
 	/* state thread */
-	struct semaphore		skt_sem;	/* protects socket h/w state */
+	struct compat_semaphore		skt_sem;	/* protects socket h/w state */
 
 	struct task_struct		*thread;
 	struct completion		thread_done;
Index: linux/include/scsi/scsi_transport_spi.h
===================================================================
--- linux.orig/include/scsi/scsi_transport_spi.h
+++ linux/include/scsi/scsi_transport_spi.h
@@ -51,7 +51,7 @@ struct spi_transport_attrs {
 	unsigned int support_qas; /* supports quick arbitration and selection */
 	/* Private Fields */
 	unsigned int dv_pending:1; /* Internal flag */
-	struct semaphore dv_sem; /* semaphore to serialise dv */
+	struct compat_semaphore dv_sem; /* semaphore to serialise dv */
 };
 
 enum spi_signal_type {
