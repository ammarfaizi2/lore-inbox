Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVLLXtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVLLXtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVLLXsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:48:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60835 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932281AbVLLXq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:58 -0500
Date: Mon, 12 Dec 2005 23:45:48 GMT
Message-Id: <200512122345.jBCNjmFQ009045@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 10/19] MUTEX: Drivers N-P changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the files of the drivers/n* thru drivers/p* to use
the new mutex functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-drivers-NtoP-2615rc5.diff
 drivers/net/3c527.c                       |    4 ++--
 drivers/net/cassini.h                     |    2 +-
 drivers/net/chelsio/common.h              |    2 +-
 drivers/net/hamradio/6pack.c              |    4 ++--
 drivers/net/hamradio/mkiss.c              |    2 +-
 drivers/net/ibmveth.c                     |    2 +-
 drivers/net/irda/sir-dev.h                |    2 +-
 drivers/net/irda/vlsi_ir.h                |    2 +-
 drivers/net/plip.c                        |    4 ++--
 drivers/net/ppp_async.c                   |    2 +-
 drivers/net/ppp_synctty.c                 |    4 ++--
 drivers/net/sungem.h                      |    2 +-
 drivers/net/wan/cosa.c                    |    2 +-
 drivers/net/wireless/airo.c               |    4 ++--
 drivers/net/wireless/hostap/hostap_wlan.h |    2 +-
 drivers/net/wireless/ipw2100.c            |    4 ++--
 drivers/net/wireless/ipw2100.h            |    4 ++--
 drivers/net/wireless/ipw2200.h            |    2 +-
 drivers/net/wireless/prism54/isl_ioctl.c  |    4 ++--
 drivers/net/wireless/prism54/islpci_dev.c |    4 ++--
 drivers/net/wireless/prism54/islpci_dev.h |    8 ++++----
 drivers/oprofile/event_buffer.h           |    4 ++--
 drivers/oprofile/oprof.c                  |    2 +-
 drivers/pci/hotplug/acpiphp.h             |    2 +-
 drivers/pci/hotplug/acpiphp_glue.c        |    2 +-
 drivers/pci/hotplug/cpci_hotplug_core.c   |    4 ++--
 drivers/pci/hotplug/cpqphp.h              |    2 +-
 drivers/pci/hotplug/cpqphp_ctrl.c         |    6 +++---
 drivers/pci/hotplug/ibmphp_hpc.c          |    6 +++---
 drivers/pci/hotplug/pciehp.h              |    2 +-
 drivers/pci/hotplug/pciehp_ctrl.c         |    4 ++--
 drivers/pci/hotplug/rpadlpar_core.c       |    2 +-
 drivers/pci/hotplug/rpaphp_core.c         |    2 +-
 drivers/pci/hotplug/shpchp.h              |    2 +-
 drivers/pci/hotplug/shpchp_ctrl.c         |    4 ++--
 drivers/pcmcia/soc_common.h               |    2 +-
 drivers/pnp/interface.c                   |    2 +-
 37 files changed, 57 insertions(+), 57 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/3c527.c linux-2.6.15-rc5-mutex/drivers/net/3c527.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/3c527.c	2005-06-22 13:51:53.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/net/3c527.c	2005-12-12 22:08:48.000000000 +0000
@@ -104,7 +104,7 @@ DRV_NAME ".c:v" DRV_VERSION " " DRV_RELD
 #include <linux/completion.h>
 #include <linux/bitops.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/io.h>
@@ -182,7 +182,7 @@ struct mc32_local 
 
 	u16 rx_ring_tail;       /* index to rx de-queue end */ 
 
-	struct semaphore cmd_mutex;    /* Serialises issuing of execute commands */
+	struct mutex cmd_mutex; /* Serialises issuing of execute commands */
         struct completion execution_cmd; /* Card has completed an execute command */
 	struct completion xceiver_cmd;   /* Card has completed a tx or rx command */
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/cassini.h linux-2.6.15-rc5-mutex/drivers/net/cassini.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/cassini.h	2005-11-01 13:19:09.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/cassini.h	2005-12-12 21:16:15.000000000 +0000
@@ -4284,7 +4284,7 @@ struct cas {
 	 * (ie. not power managed) */
 	int hw_running;
 	int opened;
-	struct semaphore pm_sem; /* open/close/suspend/resume */
+	struct mutex pm_sem; /* open/close/suspend/resume */
 
 	struct cas_init_block *init_block;
 	struct cas_tx_desc *init_txds[MAX_TX_RINGS];
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/chelsio/common.h linux-2.6.15-rc5-mutex/drivers/net/chelsio/common.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/chelsio/common.h	2005-11-01 13:19:09.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/chelsio/common.h	2005-12-12 21:18:32.000000000 +0000
@@ -213,7 +213,7 @@ struct adapter {
 	struct work_struct stats_update_task;
 	struct timer_list stats_update_timer;
 
-	struct semaphore mib_mutex;
+	struct mutex mib_mutex;
 	spinlock_t tpi_lock;
 	spinlock_t work_lock;
 	/* guards async operations */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/hamradio/6pack.c linux-2.6.15-rc5-mutex/drivers/net/hamradio/6pack.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/hamradio/6pack.c	2005-11-01 13:19:10.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/hamradio/6pack.c	2005-12-12 22:08:48.000000000 +0000
@@ -34,7 +34,7 @@
 #include <linux/init.h>
 #include <linux/ip.h>
 #include <linux/tcp.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/atomic.h>
 
 #define SIXPACK_VERSION    "Revision: 0.3.0"
@@ -124,7 +124,7 @@ struct sixpack {
 	struct timer_list	tx_t;
 	struct timer_list	resync_t;
 	atomic_t		refcnt;
-	struct semaphore	dead_sem;
+	struct mutex		dead_sem;
 	spinlock_t		lock;
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/hamradio/mkiss.c linux-2.6.15-rc5-mutex/drivers/net/hamradio/mkiss.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/hamradio/mkiss.c	2005-12-08 16:23:42.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/hamradio/mkiss.c	2005-12-12 21:16:51.000000000 +0000
@@ -85,7 +85,7 @@ struct mkiss {
 #define CRC_MODE_SMACK_TEST	4
 
 	atomic_t		refcnt;
-	struct semaphore	dead_sem;
+	struct mutex		dead_sem;
 };
 
 /*---------------------------------------------------------------------------*/
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/ibmveth.c linux-2.6.15-rc5-mutex/drivers/net/ibmveth.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/ibmveth.c	2005-12-08 16:23:42.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/ibmveth.c	2005-12-12 22:08:48.000000000 +0000
@@ -48,7 +48,7 @@
 #include <linux/mm.h>
 #include <linux/ethtool.h>
 #include <linux/proc_fs.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/hvcall.h>
 #include <asm/atomic.h>
 #include <asm/iommu.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/irda/sir-dev.h linux-2.6.15-rc5-mutex/drivers/net/irda/sir-dev.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/irda/sir-dev.h	2004-06-18 13:41:36.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/net/irda/sir-dev.h	2005-12-12 21:15:51.000000000 +0000
@@ -30,7 +30,7 @@ struct irda_request {
 };
 
 struct sir_fsm {
-	struct semaphore	sem;
+	struct mutex		sem;
 	struct irda_request	rq;
 	unsigned		state, substate;
 	int			param;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/irda/vlsi_ir.h linux-2.6.15-rc5-mutex/drivers/net/irda/vlsi_ir.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/irda/vlsi_ir.h	2005-11-01 13:19:10.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/irda/vlsi_ir.h	2005-12-12 21:15:45.000000000 +0000
@@ -761,7 +761,7 @@ typedef struct vlsi_irda_dev {
 	struct timeval		last_rx;
 
 	spinlock_t		lock;
-	struct semaphore	sem;
+	struct mutex		sem;
 
 	u8			resume_ok;	
 	struct proc_dir_entry	*proc_entry;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/plip.c linux-2.6.15-rc5-mutex/drivers/net/plip.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/plip.c	2005-08-30 13:56:19.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/net/plip.c	2005-12-12 22:08:48.000000000 +0000
@@ -116,7 +116,7 @@ static const char version[] = "NET3 PLIP
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/byteorder.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 /* Maximum number of devices to support. */
 #define PLIP_MAX  8
@@ -229,7 +229,7 @@ struct net_local {
 	                              struct hh_cache *hh);
 	spinlock_t lock;
 	atomic_t kill_timer;
-	struct semaphore killed_timer_sem;
+	struct mutex killed_timer_sem;
 };
 
 static inline void enable_parport_interrupts (struct net_device *dev)
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/ppp_async.c linux-2.6.15-rc5-mutex/drivers/net/ppp_async.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/ppp_async.c	2005-12-08 16:23:43.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/ppp_async.c	2005-12-12 21:18:00.000000000 +0000
@@ -66,7 +66,7 @@ struct asyncppp {
 	struct tasklet_struct tsk;
 
 	atomic_t	refcnt;
-	struct semaphore dead_sem;
+	struct mutex	dead_sem;
 	struct ppp_channel chan;	/* interface to generic ppp layer */
 	unsigned char	obuf[OBUFSIZE];
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/ppp_synctty.c linux-2.6.15-rc5-mutex/drivers/net/ppp_synctty.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/ppp_synctty.c	2005-08-30 13:56:19.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/net/ppp_synctty.c	2005-12-12 22:08:48.000000000 +0000
@@ -44,7 +44,7 @@
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #define PPP_VERSION	"2.4.2"
 
@@ -70,7 +70,7 @@ struct syncppp {
 	struct tasklet_struct tsk;
 
 	atomic_t	refcnt;
-	struct semaphore dead_sem;
+	struct mutex	dead_sem;
 	struct ppp_channel chan;	/* interface to generic ppp layer */
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/sungem.h linux-2.6.15-rc5-mutex/drivers/net/sungem.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/sungem.h	2005-11-01 13:19:10.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/sungem.h	2005-12-12 21:16:30.000000000 +0000
@@ -988,7 +988,7 @@ struct gem {
 	/* cell enable count, protected by lock */
 	int			cell_enabled;  
 	
-	struct semaphore	pm_sem;
+	struct mutex		pm_sem;
 
 	u32			msg_enable;
 	u32			status;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/wan/cosa.c linux-2.6.15-rc5-mutex/drivers/net/wan/cosa.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/wan/cosa.c	2005-12-08 16:23:43.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/wan/cosa.c	2005-12-12 21:17:43.000000000 +0000
@@ -131,7 +131,7 @@ struct channel_data {
 	int (*tx_done)(struct channel_data *channel, int size);
 
 	/* Character device parts */
-	struct semaphore rsem, wsem;
+	struct mutex rsem, wsem;
 	char *rxdata;
 	int rxsize;
 	wait_queue_head_t txwaitq, rxwaitq;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/airo.c linux-2.6.15-rc5-mutex/drivers/net/wireless/airo.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/airo.c	2005-12-08 16:23:43.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/wireless/airo.c	2005-12-12 20:11:38.000000000 +0000
@@ -1176,7 +1176,7 @@ struct airo_info {
 	unsigned short *flash;
 	tdsRssiEntry *rssi;
 	struct task_struct *task;
-	struct semaphore sem;
+	struct mutex sem;
 	pid_t thr_pid;
 	wait_queue_head_t thr_wait;
 	struct completion thr_exited;
@@ -2718,7 +2718,7 @@ static struct net_device *_init_airo_car
 	}
         ai->dev = dev;
 	spin_lock_init(&ai->aux_lock);
-	sema_init(&ai->sem, 1);
+	init_MUTEX(&ai->sem);
 	ai->config.len = 0;
 	ai->pci = pci;
 	init_waitqueue_head (&ai->thr_wait);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/hostap/hostap_wlan.h linux-2.6.15-rc5-mutex/drivers/net/wireless/hostap/hostap_wlan.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/hostap/hostap_wlan.h	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/wireless/hostap/hostap_wlan.h	2005-12-12 21:17:35.000000000 +0000
@@ -637,7 +637,7 @@ struct local_info {
 			      * when removing entries from the list.
 			      * TX and RX paths can use read lock. */
 	spinlock_t cmdlock, baplock, lock;
-	struct semaphore rid_bap_sem;
+	struct mutex rid_bap_sem;
 	u16 infofid; /* MAC buffer id for info frame */
 	/* txfid, intransmitfid, next_txtid, and next_alloc are protected by
 	 * txfidlock */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/ipw2100.c linux-2.6.15-rc5-mutex/drivers/net/wireless/ipw2100.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/ipw2100.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/wireless/ipw2100.c	2005-12-12 20:12:25.000000000 +0000
@@ -6413,8 +6413,8 @@ static struct net_device *ipw2100_alloc_
 	strcpy(priv->nick, "ipw2100");
 
 	spin_lock_init(&priv->low_lock);
-	sema_init(&priv->action_sem, 1);
-	sema_init(&priv->adapter_sem, 1);
+	init_MUTEX(&priv->action_sem);
+	init_MUTEX(&priv->adapter_sem);
 
 	init_waitqueue_head(&priv->wait_command_queue);
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/ipw2100.h linux-2.6.15-rc5-mutex/drivers/net/wireless/ipw2100.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/ipw2100.h	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/wireless/ipw2100.h	2005-12-12 20:12:15.000000000 +0000
@@ -588,8 +588,8 @@ struct ipw2100_priv {
 	int inta_other;
 
 	spinlock_t low_lock;
-	struct semaphore action_sem;
-	struct semaphore adapter_sem;
+	struct mutex action_sem;
+	struct mutex adapter_sem;
 
 	wait_queue_head_t wait_command_queue;
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/ipw2200.h linux-2.6.15-rc5-mutex/drivers/net/wireless/ipw2200.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/ipw2200.h	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/wireless/ipw2200.h	2005-12-12 21:17:20.000000000 +0000
@@ -1120,7 +1120,7 @@ struct ipw_priv {
 	struct ieee80211_device *ieee;
 
 	spinlock_t lock;
-	struct semaphore sem;
+	struct mutex sem;
 
 	/* basic pci-network driver stuff */
 	struct pci_dev *pci_dev;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/prism54/isl_ioctl.c linux-2.6.15-rc5-mutex/drivers/net/wireless/prism54/isl_ioctl.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/prism54/isl_ioctl.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/wireless/prism54/isl_ioctl.c	2005-12-12 20:24:32.000000000 +0000
@@ -1255,7 +1255,7 @@ prism54_set_raw(struct net_device *ndev,
 void
 prism54_acl_init(struct islpci_acl *acl)
 {
-	sema_init(&acl->sem, 1);
+	init_MUTEX(&acl->sem);
 	INIT_LIST_HEAD(&acl->mac_list);
 	acl->size = 0;
 	acl->policy = MAC_POLICY_OPEN;
@@ -1686,7 +1686,7 @@ void
 prism54_wpa_ie_init(islpci_private *priv)
 {
 	INIT_LIST_HEAD(&priv->bss_wpa_list);
-	sema_init(&priv->wpa_sem, 1);
+	init_MUTEX(&priv->wpa_sem);
 }
 
 void
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/prism54/islpci_dev.c linux-2.6.15-rc5-mutex/drivers/net/wireless/prism54/islpci_dev.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/prism54/islpci_dev.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/wireless/prism54/islpci_dev.c	2005-12-12 20:13:30.000000000 +0000
@@ -850,10 +850,10 @@ islpci_setup(struct pci_dev *pdev)
 	init_waitqueue_head(&priv->reset_done);
 
 	/* init the queue read locks, process wait counter */
-	sema_init(&priv->mgmt_sem, 1);
+	init_MUTEX(&priv->mgmt_sem);
 	priv->mgmt_received = NULL;
 	init_waitqueue_head(&priv->mgmt_wqueue);
-	sema_init(&priv->stats_sem, 1);
+	init_MUTEX(&priv->stats_sem);
 	spin_lock_init(&priv->slock);
 
 	/* init state machine with off#1 state */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/prism54/islpci_dev.h linux-2.6.15-rc5-mutex/drivers/net/wireless/prism54/islpci_dev.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/net/wireless/prism54/islpci_dev.h	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/wireless/prism54/islpci_dev.h	2005-12-12 20:13:24.000000000 +0000
@@ -55,7 +55,7 @@ struct islpci_acl {
    enum { MAC_POLICY_OPEN=0, MAC_POLICY_ACCEPT=1, MAC_POLICY_REJECT=2 } policy;
    struct list_head mac_list;  /* a list of mac_entry */
    int size;   /* size of queue */
-   struct semaphore sem;   /* accessed in ioctls and trap_work */
+   struct mutex sem;   /* accessed in ioctls and trap_work */
 };
 
 struct islpci_membuf {
@@ -88,7 +88,7 @@ typedef struct {
 	
 	/* Take care of the wireless stats */
 	struct work_struct stats_work;
-	struct semaphore stats_sem;
+	struct mutex stats_sem;
 	/* remember when we last updated the stats */
 	unsigned long stats_timestamp;
 	/* The first is accessed under semaphore locking.
@@ -165,7 +165,7 @@ typedef struct {
 	wait_queue_head_t reset_done;
 
 	/* used by islpci_mgt_transaction */
-	struct semaphore mgmt_sem; /* serialize access to mailbox and wqueue */
+	struct mutex mgmt_sem; /* serialize access to mailbox and wqueue */
 	struct islpci_mgmtframe *mgmt_received;	  /* mbox for incoming frame */
 	wait_queue_head_t mgmt_wqueue;            /* waitqueue for mbox */
 
@@ -178,7 +178,7 @@ typedef struct {
 	int wpa; /* WPA mode enabled */
 	struct list_head bss_wpa_list;
 	int num_bss_wpa;
-	struct semaphore wpa_sem;
+	struct mutex wpa_sem;
 
 	struct work_struct reset_task;
 	int reset_task_pending;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/oprofile/event_buffer.h linux-2.6.15-rc5-mutex/drivers/oprofile/event_buffer.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/oprofile/event_buffer.h	2005-08-30 13:56:21.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/oprofile/event_buffer.h	2005-12-12 22:08:48.000000000 +0000
@@ -11,7 +11,7 @@
 #define EVENT_BUFFER_H
 
 #include <linux/types.h> 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
  
 int alloc_event_buffer(void);
 
@@ -46,6 +46,6 @@ extern struct file_operations event_buff
 /* mutex between sync_cpu_buffers() and the
  * file reading code.
  */
-extern struct semaphore buffer_sem;
+extern struct mutex buffer_sem;
  
 #endif /* EVENT_BUFFER_H */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/oprofile/oprof.c linux-2.6.15-rc5-mutex/drivers/oprofile/oprof.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/oprofile/oprof.c	2005-03-02 12:08:20.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/oprofile/oprof.c	2005-12-12 22:08:48.000000000 +0000
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/oprofile.h>
 #include <linux/moduleparam.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "oprof.h"
 #include "event_buffer.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/acpiphp_glue.c linux-2.6.15-rc5-mutex/drivers/pci/hotplug/acpiphp_glue.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/acpiphp_glue.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/acpiphp_glue.c	2005-12-12 22:08:48.000000000 +0000
@@ -46,7 +46,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/smp_lock.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "../pci.h"
 #include "pci_hotplug.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/acpiphp.h linux-2.6.15-rc5-mutex/drivers/pci/hotplug/acpiphp.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/acpiphp.h	2005-08-30 13:56:21.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/acpiphp.h	2005-12-12 21:42:44.000000000 +0000
@@ -118,7 +118,7 @@ struct acpiphp_slot {
 	struct acpiphp_bridge *bridge;	/* parent */
 	struct list_head funcs;		/* one slot may have different
 					   objects (i.e. for each function) */
-	struct semaphore crit_sect;
+	struct mutex	crit_sect;
 
 	u32		id;		/* slot id (serial #) for hotplug core */
 	u8		device;		/* pci device# */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/cpci_hotplug_core.c linux-2.6.15-rc5-mutex/drivers/pci/hotplug/cpci_hotplug_core.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/cpci_hotplug_core.c	2005-06-22 13:51:55.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/cpci_hotplug_core.c	2005-12-12 21:42:53.000000000 +0000
@@ -60,8 +60,8 @@ static int slots;
 static atomic_t extracting;
 int cpci_debug;
 static struct cpci_hp_controller *controller;
-static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
-static struct semaphore thread_exit;		/* guard ensure thread has exited before calling it quits */
+static struct mutex event_semaphore;	/* mutex for process loop (up if something to process) */
+static struct mutex thread_exit;	/* guard ensure thread has exited before calling it quits */
 static int thread_finished = 1;
 
 static int enable_slot(struct hotplug_slot *slot);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/cpqphp_ctrl.c linux-2.6.15-rc5-mutex/drivers/pci/hotplug/cpqphp_ctrl.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/cpqphp_ctrl.c	2005-01-04 11:13:24.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/cpqphp_ctrl.c	2005-12-12 21:43:08.000000000 +0000
@@ -45,13 +45,13 @@ static int configure_new_function(struct
 			u8 behind_bridge, struct resource_lists *resources);
 static void interrupt_event_handler(struct controller *ctrl);
 
-static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
-static struct semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
+static struct mutex event_semaphore;	/* mutex for process loop (up if something to process) */
+static struct mutex event_exit;		/* guard ensure thread has exited before calling it quits */
 static int event_finished;
 static unsigned long pushbutton_pending;	/* = 0 */
 
 /* things needed for the long_delay function */
-static struct semaphore		delay_sem;
+static struct mutex		delay_sem;
 static wait_queue_head_t	delay_wait;
 
 /* delay is in jiffies to wait for */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/cpqphp.h linux-2.6.15-rc5-mutex/drivers/pci/hotplug/cpqphp.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/cpqphp.h	2005-01-04 11:13:24.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/cpqphp.h	2005-12-12 21:43:24.000000000 +0000
@@ -286,7 +286,7 @@ struct event_info {
 struct controller {
 	struct controller *next;
 	u32 ctrl_int_comp;
-	struct semaphore crit_sect;	/* critical section semaphore */
+	struct mutex crit_sect;		/* critical section semaphore */
 	void __iomem *hpc_reg;		/* cookie for our pci controller location */
 	struct pci_resource *mem_head;
 	struct pci_resource *p_mem_head;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/ibmphp_hpc.c linux-2.6.15-rc5-mutex/drivers/pci/hotplug/ibmphp_hpc.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/ibmphp_hpc.c	2005-06-22 13:51:55.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/ibmphp_hpc.c	2005-12-12 21:41:50.000000000 +0000
@@ -101,10 +101,10 @@ static int to_debug = FALSE;
 //----------------------------------------------------------------------------
 static int ibmphp_shutdown;
 static int tid_poll;
-static struct semaphore sem_hpcaccess;	// lock access to HPC
-static struct semaphore semOperations;	// lock all operations and
+static struct mutex sem_hpcaccess;	// lock access to HPC
+static struct mutex semOperations;	// lock all operations and
 					// access to data structures
-static struct semaphore sem_exit;	// make sure polling thread goes away
+static struct mutex sem_exit;		// make sure polling thread goes away
 //----------------------------------------------------------------------------
 // local function prototypes
 //----------------------------------------------------------------------------
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/pciehp_ctrl.c linux-2.6.15-rc5-mutex/drivers/pci/hotplug/pciehp_ctrl.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/pciehp_ctrl.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/pciehp_ctrl.c	2005-12-12 21:41:30.000000000 +0000
@@ -37,8 +37,8 @@
 
 static void interrupt_event_handler(struct controller *ctrl);
 
-static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
-static struct semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
+static struct mutex event_semaphore;	/* mutex for process loop (up if something to process) */
+static struct mutex event_exit;		/* guard ensure thread has exited before calling it quits */
 static int event_finished;
 static unsigned long pushbutton_pending;	/* = 0 */
 static unsigned long surprise_rm_pending;	/* = 0 */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/pciehp.h linux-2.6.15-rc5-mutex/drivers/pci/hotplug/pciehp.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/pciehp.h	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/pciehp.h	2005-12-12 21:41:59.000000000 +0000
@@ -95,7 +95,7 @@ struct php_ctlr_state_s {
 #define MAX_EVENTS		10
 struct controller {
 	struct controller *next;
-	struct semaphore crit_sect;	/* critical section semaphore */
+	struct mutex crit_sect;	/* critical section semaphore */
 	struct php_ctlr_state_s *hpc_ctlr_handle; /* HPC controller handle */
 	int num_slots;			/* Number of slots on ctlr */
 	int slot_num_inc;		/* 1 or -1 */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/rpadlpar_core.c linux-2.6.15-rc5-mutex/drivers/pci/hotplug/rpadlpar_core.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/rpadlpar_core.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/rpadlpar_core.c	2005-12-12 22:08:48.000000000 +0000
@@ -19,7 +19,7 @@
 #include <linux/string.h>
 
 #include <asm/pci-bridge.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/rtas.h>
 #include <asm/vio.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/rpaphp_core.c linux-2.6.15-rc5-mutex/drivers/pci/hotplug/rpaphp_core.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/rpaphp_core.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/rpaphp_core.c	2005-12-12 21:42:32.000000000 +0000
@@ -40,7 +40,7 @@
 #include "pci_hotplug.h"
 
 int debug;
-static struct semaphore rpaphp_sem;
+static struct mutex rpaphp_sem;
 LIST_HEAD(rpaphp_slot_head);
 int num_slots;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/shpchp_ctrl.c linux-2.6.15-rc5-mutex/drivers/pci/hotplug/shpchp_ctrl.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/shpchp_ctrl.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/shpchp_ctrl.c	2005-12-12 21:42:10.000000000 +0000
@@ -37,8 +37,8 @@
 
 static void interrupt_event_handler(struct controller *ctrl);
 
-static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
-static struct semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
+static struct mutex event_semaphore;	/* mutex for process loop (up if something to process) */
+static struct mutex event_exit;		/* guard ensure thread has exited before calling it quits */
 static int event_finished;
 static unsigned long pushbutton_pending;	/* = 0 */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/shpchp.h linux-2.6.15-rc5-mutex/drivers/pci/hotplug/shpchp.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pci/hotplug/shpchp.h	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/shpchp.h	2005-12-12 21:42:20.000000000 +0000
@@ -79,7 +79,7 @@ struct event_info {
 
 struct controller {
 	struct controller *next;
-	struct semaphore crit_sect;	/* critical section semaphore */
+	struct mutex crit_sect;	/* critical section semaphore */
 	struct php_ctlr_state_s *hpc_ctlr_handle; /* HPC controller handle */
 	int num_slots;			/* Number of slots on ctlr */
 	int slot_num_inc;		/* 1 or -1 */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pcmcia/soc_common.h linux-2.6.15-rc5-mutex/drivers/pcmcia/soc_common.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pcmcia/soc_common.h	2005-08-30 13:56:22.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/pcmcia/soc_common.h	2005-12-12 21:30:49.000000000 +0000
@@ -133,7 +133,7 @@ extern void soc_common_pcmcia_get_timing
 
 
 extern struct list_head soc_pcmcia_sockets;
-extern struct semaphore soc_pcmcia_sockets_lock;
+extern struct mutex soc_pcmcia_sockets_lock;
 
 extern int soc_common_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops, int first, int nr);
 extern int soc_common_drv_pcmcia_remove(struct device *dev);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/pnp/interface.c linux-2.6.15-rc5-mutex/drivers/pnp/interface.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/pnp/interface.c	2005-08-30 13:56:22.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/pnp/interface.c	2005-12-12 21:41:07.000000000 +0000
@@ -305,7 +305,7 @@ static ssize_t pnp_show_current_resource
 	return ret;
 }
 
-extern struct semaphore pnp_res_mutex;
+extern struct mutex pnp_res_mutex;
 
 static ssize_t
 pnp_set_current_resources(struct device * dmdev, struct device_attribute *attr, const char * ubuf, size_t count)
