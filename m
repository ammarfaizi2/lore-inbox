Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVFTKVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVFTKVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVFTKVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:21:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56286 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261317AbVFTKUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:20:00 -0400
Date: Mon, 20 Jun 2005 12:19:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [patch] more SPIN_LOCK_UNLOCKED -> DEFINE_SPINLOCK conversions
Message-ID: <20050620101909.GA22716@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this converts the final 20 DEFINE_SPINLOCK holdouts. (another 580 places 
are already using DEFINE_SPINLOCK). Build tested on x86.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 20 files changed, 20 insertions(+), 20 deletions(-)

--- linux/net/core/pktgen.c.orig
+++ linux/net/core/pktgen.c
@@ -503,7 +503,7 @@ static int pg_delay_d = 0;
 static int pg_clone_skb_d = 0;
 static int debug = 0;
 
-static spinlock_t _thread_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(_thread_lock);
 static struct pktgen_thread *pktgen_threads = NULL;
 
 static char module_fname[128];
--- linux/net/core/netpoll.c.orig
+++ linux/net/core/netpoll.c
@@ -612,7 +612,7 @@ int netpoll_setup(struct netpoll *np)
 	struct net_device *ndev = NULL;
 	struct in_device *in_dev;
 
-	np->poll_lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&np->poll_lock);
 	np->poll_owner = -1;
 
 	if (np->dev_name)
--- linux/fs/xfs/support/ktrace.c.orig
+++ linux/fs/xfs/support/ktrace.c
@@ -170,7 +170,7 @@ ktrace_enter(
 	void            *val14,
 	void            *val15)
 {
-	static lock_t   wrap_lock = SPIN_LOCK_UNLOCKED;
+	static DEFINE_SPINLOCK(wrap_lock);
 	unsigned long	flags;
 	int             index;
 	ktrace_entry_t  *ktep;
--- linux/arch/ppc/syslib/qspan_pci.c.orig
+++ linux/arch/ppc/syslib/qspan_pci.c
@@ -94,7 +94,7 @@
 #define mk_config_type1(bus, dev, offset) \
 	mk_config_addr(bus, dev, offset) | 1;
 
-static spinlock_t pcibios_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(pcibios_lock);
 
 int qspan_pcibios_read_config_byte(unsigned char bus, unsigned char dev_fn,
 				  unsigned char offset, unsigned char *val)
--- linux/arch/ppc/syslib/mv64x60.c.orig
+++ linux/arch/ppc/syslib/mv64x60.c
@@ -32,7 +32,7 @@
 
 
 u8		mv64x60_pci_exclude_bridge = 1;
-spinlock_t	mv64x60_lock = SPIN_LOCK_UNLOCKED;
+DEFINE_SPINLOCK(mv64x60_lock);
 
 static phys_addr_t 	mv64x60_bridge_pbase = 0;
 static void 		*mv64x60_bridge_vbase = 0;
--- linux/arch/ppc/platforms/hdpu.c.orig
+++ linux/arch/ppc/platforms/hdpu.c
@@ -58,7 +58,7 @@ static void parse_bootinfo(unsigned long
 static void hdpu_set_l1pe(void);
 static void hdpu_cpustate_set(unsigned char new_state);
 #ifdef CONFIG_SMP
-static spinlock_t timebase_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(timebase_lock);
 static unsigned int timebase_upper = 0, timebase_lower = 0;
 extern int smp_tb_synchronized;
 
--- linux/arch/sparc/lib/atomic32.c.orig
+++ linux/arch/sparc/lib/atomic32.c
@@ -20,7 +20,7 @@ spinlock_t __atomic_hash[ATOMIC_HASH_SIZ
 
 #else /* SMP */
 
-static spinlock_t dummy = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(dummy);
 #define ATOMIC_HASH_SIZE	1
 #define ATOMIC_HASH(a)		(&dummy)
 
--- linux/arch/arm/mach-pxa/corgi_ssp.c.orig
+++ linux/arch/arm/mach-pxa/corgi_ssp.c
@@ -22,7 +22,7 @@
 #include <asm/arch/corgi.h>
 #include <asm/arch/pxa-regs.h>
 
-static spinlock_t corgi_ssp_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(corgi_ssp_lock);
 static struct ssp_dev corgi_ssp_dev;
 static struct ssp_state corgi_ssp_state;
 
--- linux/arch/ppc64/kernel/pmc.c.orig
+++ linux/arch/ppc64/kernel/pmc.c
@@ -26,7 +26,7 @@ static void dummy_perf(struct pt_regs *r
 	mtspr(SPRN_MMCR0, mmcr0);
 }
 
-static spinlock_t pmc_owner_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(pmc_owner_lock);
 static void *pmc_owner_caller; /* mostly for debugging */
 perf_irq_t perf_irq = dummy_perf;
 
--- linux/arch/mips/kernel/i8259.c.orig
+++ linux/arch/mips/kernel/i8259.c
@@ -31,7 +31,7 @@ void disable_8259A_irq(unsigned int irq)
  * moves to arch independent land
  */
 
-spinlock_t i8259A_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t DEFINE_SPINLOCK(i8259A_lock);
 
 static void end_8259A_irq (unsigned int irq)
 {
--- linux/arch/mips/kernel/gdb-stub.c.orig
+++ linux/arch/mips/kernel/gdb-stub.c
@@ -176,7 +176,7 @@ int kgdb_enabled;
 /*
  * spin locks for smp case
  */
-static spinlock_t kgdb_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(kgdb_lock);
 static spinlock_t kgdb_cpulock[NR_CPUS] = { [0 ... NR_CPUS-1] = SPIN_LOCK_UNLOCKED};
 
 /*
--- linux/arch/mips/kernel/genrtc.c.orig
+++ linux/arch/mips/kernel/genrtc.c
@@ -14,7 +14,7 @@
 #include <asm/rtc.h>
 #include <asm/time.h>
 
-static spinlock_t mips_rtc_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(mips_rtc_lock);
 
 unsigned int get_rtc_time(struct rtc_time *time)
 {
--- linux/arch/ia64/kernel/perfmon.c.orig
+++ linux/arch/ia64/kernel/perfmon.c
@@ -497,7 +497,7 @@ typedef struct {
 static pfm_stats_t		pfm_stats[NR_CPUS];
 static pfm_session_t		pfm_sessions;	/* global sessions information */
 
-static spinlock_t pfm_alt_install_check = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(pfm_alt_install_check);
 static pfm_intr_handler_desc_t  *pfm_alt_intr_handler;
 
 static struct proc_dir_entry 	*perfmon_dir;
--- linux/arch/ia64/sn/kernel/xpnet.c.orig
+++ linux/arch/ia64/sn/kernel/xpnet.c
@@ -130,7 +130,7 @@ struct net_device *xpnet_device;
  */
 static u64 xpnet_broadcast_partitions;
 /* protect above */
-static spinlock_t xpnet_broadcast_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(xpnet_broadcast_lock);
 
 /*
  * Since the Block Transfer Engine (BTE) is being used for the transfer
--- linux/drivers/net/mv643xx_eth.c.orig
+++ linux/drivers/net/mv643xx_eth.c
@@ -95,7 +95,7 @@ static char mv643xx_driver_version[] = "
 static void __iomem *mv643xx_eth_shared_base;
 
 /* used to protect MV643XX_ETH_SMI_REG, which is shared across ports */
-static spinlock_t mv643xx_eth_phy_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(mv643xx_eth_phy_lock);
 
 static inline u32 mv_read(int offset)
 {
--- linux/drivers/parisc/iosapic.c.orig
+++ linux/drivers/parisc/iosapic.c
@@ -215,7 +215,7 @@ static inline void iosapic_write(void __
 #define IOSAPIC_IRDT_ID_EID_SHIFT              0x10
 
 
-static spinlock_t iosapic_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(iosapic_lock);
 
 static inline void iosapic_eoi(void __iomem *addr, unsigned int data)
 {
--- linux/drivers/scsi/ch.c.orig
+++ linux/drivers/scsi/ch.c
@@ -117,7 +117,7 @@ typedef struct {
 } scsi_changer;
 
 static LIST_HEAD(ch_devlist);
-static spinlock_t ch_devlist_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(ch_devlist_lock);
 static int ch_devcount;
 
 static struct scsi_driver ch_template =
--- linux/drivers/video/backlight/corgi_bl.c.orig
+++ linux/drivers/video/backlight/corgi_bl.c
@@ -29,7 +29,7 @@
 static int corgibl_powermode = FB_BLANK_UNBLANK;
 static int current_intensity = 0;
 static int corgibl_limit = 0;
-static spinlock_t bl_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(bl_lock);
 
 static void corgibl_send_intensity(int intensity)
 {
--- linux/drivers/video/geode/display_gx1.c.orig
+++ linux/drivers/video/geode/display_gx1.c
@@ -22,7 +22,7 @@
 #include "geodefb.h"
 #include "display_gx1.h"
 
-static spinlock_t gx1_conf_reg_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(gx1_conf_reg_lock);
 
 static u8 gx1_read_conf_reg(u8 reg)
 {
--- linux/include/linux/netfilter_ipv4/lockhelp.h.orig
+++ linux/include/linux/netfilter_ipv4/lockhelp.h
@@ -106,7 +106,7 @@ do {								\
 } while(0)
 
 #else
-#define DECLARE_LOCK(l) spinlock_t l = SPIN_LOCK_UNLOCKED
+#define DECLARE_LOCK(lockname) DEFINE_SPINLOCK(lockname)
 #define DECLARE_LOCK_EXTERN(l) extern spinlock_t l
 #define DECLARE_RWLOCK(l) rwlock_t l = RW_LOCK_UNLOCKED
 #define DECLARE_RWLOCK_EXTERN(l) extern rwlock_t l
