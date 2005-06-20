Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVFTKK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVFTKK4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFTKK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:10:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:54172 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261309AbVFTKIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:08:25 -0400
Date: Mon, 20 Jun 2005 12:04:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org
Subject: [patch] timer initialization cleanup: DEFINE_TIMER
Message-ID: <20050620100456.GA22624@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch, ontop of Oleg's timer patches, cleans up timer 
initialization by introducing DEFINE_TIMER a'ka DEFINE_SPINLOCK. Build 
and boot-tested on x86. A similar patch has been been in the -RT tree 
for some time.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 49 files changed, 68 insertions(+), 99 deletions(-)

--- linux/net/core/dst.c.orig
+++ linux/net/core/dst.c
@@ -39,8 +39,7 @@ static unsigned long dst_gc_timer_inc = 
 static void dst_run_gc(unsigned long);
 static void ___dst_free(struct dst_entry * dst);
 
-static struct timer_list dst_gc_timer =
-	TIMER_INITIALIZER(dst_run_gc, DST_GC_MIN, 0);
+static DEFINE_TIMER(dst_gc_timer, dst_run_gc, DST_GC_MIN, 0);
 
 static void dst_run_gc(unsigned long dummy)
 {
--- linux/net/core/dev.c.orig
+++ linux/net/core/dev.c
@@ -161,7 +161,7 @@ static struct list_head ptype_all;		/* T
 
 #ifdef OFFLINE_SAMPLE
 static void sample_queue(unsigned long dummy);
-static struct timer_list samp_timer = TIMER_INITIALIZER(sample_queue, 0, 0);
+static DEFINE_TIMER(samp_timer, sample_queue, 0, 0);
 #endif
 
 /*
--- linux/net/atm/mpc.c.orig
+++ linux/net/atm/mpc.c
@@ -105,7 +105,7 @@ extern void mpc_proc_clean(void);
 
 struct mpoa_client *mpcs = NULL; /* FIXME */
 static struct atm_mpoa_qos *qos_head = NULL;
-static struct timer_list mpc_timer = TIMER_INITIALIZER(NULL, 0, 0);
+static DEFINE_TIMER(mpc_timer, NULL, 0, 0);
 
 
 static struct mpoa_client *find_mpc_by_itfnum(int itf)
--- linux/net/netrom/nr_loopback.c.orig
+++ linux/net/netrom/nr_loopback.c
@@ -17,7 +17,7 @@
 static void nr_loopback_timer(unsigned long);
 
 static struct sk_buff_head loopback_queue;
-static struct timer_list loopback_timer = TIMER_INITIALIZER(nr_loopback_timer, 0, 0);
+static DEFINE_TIMER(loopback_timer, nr_loopback_timer, 0, 0);
 
 void __init nr_loopback_init(void)
 {
--- linux/net/sched/sch_api.c.orig
+++ linux/net/sched/sch_api.c
@@ -1203,7 +1203,7 @@ EXPORT_SYMBOL(psched_time_base);
  * with 32-bit get_cycles(). Safe up to 4GHz CPU.
  */
 static void psched_tick(unsigned long);
-static struct timer_list psched_timer = TIMER_INITIALIZER(psched_tick, 0, 0);
+static DEFINE_TIMER(psched_timer, psched_tick, 0, 0);
 
 static void psched_tick(unsigned long dummy)
 {
--- linux/net/decnet/dn_route.c.orig
+++ linux/net/decnet/dn_route.c
@@ -117,8 +117,7 @@ static struct dn_rt_hash_bucket *dn_rt_h
 static unsigned dn_rt_hash_mask;
 
 static struct timer_list dn_route_timer;
-static struct timer_list dn_rt_flush_timer =
-		TIMER_INITIALIZER(dn_run_flush, 0, 0);
+static DEFINE_TIMER(dn_rt_flush_timer, dn_run_flush, 0, 0);
 int decnet_dst_gc_interval = 2;
 
 static struct dst_ops dn_dst_ops = {
--- linux/net/ipv6/ip6_flowlabel.c.orig
+++ linux/net/ipv6/ip6_flowlabel.c
@@ -50,7 +50,7 @@ static atomic_t fl_size = ATOMIC_INIT(0)
 static struct ip6_flowlabel *fl_ht[FL_HASH_MASK+1];
 
 static void ip6_fl_gc(unsigned long dummy);
-static struct timer_list ip6_fl_gc_timer = TIMER_INITIALIZER(ip6_fl_gc, 0, 0);
+static DEFINE_TIMER(ip6_fl_gc_timer, ip6_fl_gc, 0, 0);
 
 /* FL hash table lock: it protects only of GC */
 
--- linux/net/ipv6/ip6_fib.c.orig
+++ linux/net/ipv6/ip6_fib.c
@@ -92,7 +92,7 @@ static struct fib6_node * fib6_repair_tr
 
 static __u32 rt_sernum;
 
-static struct timer_list ip6_fib_timer = TIMER_INITIALIZER(fib6_run_gc, 0, 0);
+static DEFINE_TIMER(ip6_fib_timer, fib6_run_gc, 0, 0);
 
 struct fib6_walker_t fib6_walker_list = {
 	.prev	= &fib6_walker_list,
--- linux/net/ipv6/addrconf.c.orig
+++ linux/net/ipv6/addrconf.c
@@ -122,8 +122,7 @@ DEFINE_RWLOCK(addrconf_lock);
 
 static void addrconf_verify(unsigned long);
 
-static struct timer_list addr_chk_timer =
-			TIMER_INITIALIZER(addrconf_verify, 0, 0);
+static DEFINE_TIMER(addr_chk_timer, addrconf_verify, 0, 0);
 static DEFINE_SPINLOCK(addrconf_verify_lock);
 
 static void addrconf_join_anycast(struct inet6_ifaddr *ifp);
--- linux/net/ipv4/inetpeer.c.orig
+++ linux/net/ipv4/inetpeer.c
@@ -99,8 +99,7 @@ DEFINE_SPINLOCK(inet_peer_unused_lock);
 #define PEER_MAX_CLEANUP_WORK 30
 
 static void peer_check_expire(unsigned long dummy);
-static struct timer_list peer_periodic_timer =
-	TIMER_INITIALIZER(peer_check_expire, 0, 0);
+static DEFINE_TIMER(peer_periodic_timer, peer_check_expire, 0, 0);
 
 /* Exported for sysctl_net_ipv4.  */
 int inet_peer_gc_mintime = 10 * HZ,
--- linux/net/ipv4/tcp_minisocks.c.orig
+++ linux/net/ipv4/tcp_minisocks.c
@@ -420,7 +420,7 @@ static void tcp_twkill(unsigned long);
 
 static struct hlist_head tcp_tw_death_row[TCP_TWKILL_SLOTS];
 static DEFINE_SPINLOCK(tw_death_lock);
-static struct timer_list tcp_tw_timer = TIMER_INITIALIZER(tcp_twkill, 0, 0);
+static DEFINE_TIMER(tcp_tw_timer, tcp_twkill, 0, 0);
 static void twkill_work(void *);
 static DECLARE_WORK(tcp_twkill_work, twkill_work, NULL);
 static u32 twkill_thread_slots;
@@ -549,8 +549,7 @@ void tcp_tw_deschedule(struct tcp_tw_buc
 static int tcp_twcal_hand = -1;
 static int tcp_twcal_jiffie;
 static void tcp_twcal_tick(unsigned long);
-static struct timer_list tcp_twcal_timer =
-		TIMER_INITIALIZER(tcp_twcal_tick, 0, 0);
+static DEFINE_TIMER(tcp_twcal_timer, tcp_twcal_tick, 0, 0);
 static struct hlist_head tcp_twcal_row[TCP_TW_RECYCLE_SLOTS];
 
 static void tcp_tw_schedule(struct tcp_tw_bucket *tw, int timeo)
--- linux/sound/oss/sys_timer.c.orig
+++ linux/sound/oss/sys_timer.c
@@ -28,8 +28,7 @@ static unsigned long prev_event_time;
 
 static void     poll_def_tmr(unsigned long dummy);
 static DEFINE_SPINLOCK(lock);
-
-static struct timer_list def_tmr = TIMER_INITIALIZER(poll_def_tmr, 0, 0);
+static DEFINE_TIMER(def_tmr, poll_def_tmr, 0, 0);
 
 static unsigned long
 tmr2ticks(int tmr_value)
--- linux/sound/oss/midibuf.c.orig
+++ linux/sound/oss/midibuf.c
@@ -50,7 +50,7 @@ static struct midi_parms parms[MAX_MIDI_
 static void midi_poll(unsigned long dummy);
 
 
-static struct timer_list poll_timer = TIMER_INITIALIZER(midi_poll, 0, 0);
+static DEFINE_TIMER(poll_timer, midi_poll, 0, 0);
 
 static volatile int open_devs;
 static DEFINE_SPINLOCK(lock);
--- linux/sound/oss/uart6850.c.orig
+++ linux/sound/oss/uart6850.c
@@ -78,8 +78,7 @@ static void (*midi_input_intr) (int dev,
 static void poll_uart6850(unsigned long dummy);
 
 
-static struct timer_list uart6850_timer =
-		TIMER_INITIALIZER(poll_uart6850, 0, 0);
+static DEFINE_TIMER(uart6850_timer, poll_uart6850, 0, 0);
 
 static void uart6850_input_loop(void)
 {
--- linux/sound/oss/soundcard.c.orig
+++ linux/sound/oss/soundcard.c
@@ -682,8 +682,7 @@ static void do_sequencer_timer(unsigned 
 }
 
 
-static struct timer_list seq_timer =
-		TIMER_INITIALIZER(do_sequencer_timer, 0, 0);
+static DEFINE_TIMER(seq_timer, do_sequencer_timer, 0, 0);
 
 void request_sound_timer(int count)
 {
--- linux/mm/page-writeback.c.orig
+++ linux/mm/page-writeback.c
@@ -368,10 +368,8 @@ int wakeup_bdflush(long nr_pages)
 static void wb_timer_fn(unsigned long unused);
 static void laptop_timer_fn(unsigned long unused);
 
-static struct timer_list wb_timer =
-			TIMER_INITIALIZER(wb_timer_fn, 0, 0);
-static struct timer_list laptop_mode_wb_timer =
-			TIMER_INITIALIZER(laptop_timer_fn, 0, 0);
+static DEFINE_TIMER(wb_timer, wb_timer_fn, 0, 0);
+static DEFINE_TIMER(laptop_mode_wb_timer, laptop_timer_fn, 0, 0);
 
 /*
  * Periodic writeback of "old" data.
--- linux/arch/ppc/8xx_io/cs4218_tdm.c.orig
+++ linux/arch/ppc/8xx_io/cs4218_tdm.c
@@ -1380,7 +1380,7 @@ static void cs_nosound(unsigned long xx)
 	spin_unlock_irqrestore(&cs4218_lock, flags);
 }
 
-static struct timer_list beep_timer = TIMER_INITIALIZER(cs_nosound, 0, 0);
+static DEFINE_TIMER(beep_timer, cs_nosound, 0, 0);
 };
 
 static void cs_mksound(unsigned int hz, unsigned int ticks)
--- linux/arch/i386/kernel/time.c.orig
+++ linux/arch/i386/kernel/time.c
@@ -326,8 +326,7 @@ unsigned long get_cmos_time(void)
 }
 static void sync_cmos_clock(unsigned long dummy);
 
-static struct timer_list sync_cmos_timer =
-                                      TIMER_INITIALIZER(sync_cmos_clock, 0, 0);
+static DEFINE_TIMER(sync_cmos_timer, sync_cmos_clock, 0, 0);
 
 static void sync_cmos_clock(unsigned long dummy)
 {
--- linux/arch/m68k/mac/macboing.c.orig
+++ linux/arch/m68k/mac/macboing.c
@@ -56,8 +56,7 @@ static void ( *mac_special_bell )( unsig
 /*
  * our timer to start/continue/stop the bell
  */
-static struct timer_list mac_sound_timer =
-		TIMER_INITIALIZER(mac_nosound, 0, 0);
+static DEFINE_TIMER(mac_sound_timer, mac_nosound, 0, 0);
 
 /*
  * Sort of initialize the sound chip (called from mac_mksound on the first
--- linux/arch/m68k/amiga/amisound.c.orig
+++ linux/arch/m68k/amiga/amisound.c
@@ -63,7 +63,7 @@ void __init amiga_init_sound(void)
 }
 
 static void nosound( unsigned long ignored );
-static struct timer_list sound_timer = TIMER_INITIALIZER(nosound, 0, 0);
+static DEFINE_TIMER(sound_timer, nosound, 0, 0);
 
 void amiga_mksound( unsigned int hz, unsigned int ticks )
 {
--- linux/drivers/net/atari_bionet.c.orig
+++ linux/drivers/net/atari_bionet.c
@@ -155,7 +155,7 @@ static int bionet_close(struct net_devic
 static struct net_device_stats *net_get_stats(struct net_device *dev);
 static void bionet_tick(unsigned long);
 
-static struct timer_list bionet_timer = TIMER_INITIALIZER(bionet_tick, 0, 0);
+static DEFINE_TIMER(bionet_timer, bionet_tick, 0, 0);
 
 #define STRAM_ADDR(a)	(((a) & 0xff000000) == 0)
 
--- linux/drivers/net/atari_pamsnet.c.orig
+++ linux/drivers/net/atari_pamsnet.c
@@ -165,7 +165,7 @@ static void pamsnet_tick(unsigned long);
 
 static irqreturn_t pamsnet_intr(int irq, void *data, struct pt_regs *fp);
 
-static struct timer_list pamsnet_timer = TIMER_INITIALIZER(pamsnet_tick, 0, 0);
+static DEFINE_TIMER(pamsnet_timer, pamsnet_tick, 0, 0);
 
 #define STRAM_ADDR(a)	(((a) & 0xff000000) == 0)
 
--- linux/drivers/net/hamradio/yam.c.orig
+++ linux/drivers/net/hamradio/yam.c
@@ -170,7 +170,7 @@ static char ax25_bcast[7] =
 static char ax25_test[7] =
 {'L' << 1, 'I' << 1, 'N' << 1, 'U' << 1, 'X' << 1, ' ' << 1, '1' << 1};
 
-static struct timer_list yam_timer = TIMER_INITIALIZER(NULL, 0, 0);
+static DEFINE_TIMER(yam_timer, NULL, 0, 0);
 
 /* --------------------------------------------------------------------- */
 
--- linux/drivers/net/cris/eth_v10.c.orig
+++ linux/drivers/net/cris/eth_v10.c
@@ -384,8 +384,8 @@ static unsigned int mdio_phy_addr; /* Tr
 static unsigned int network_tr_ctrl_shadow = 0;
 
 /* Network speed indication. */
-static struct timer_list speed_timer = TIMER_INITIALIZER(NULL, 0, 0);
-static struct timer_list clear_led_timer = TIMER_INITIALIZER(NULL, 0, 0);
+static DEFINE_TIMER(speed_timer, NULL, 0, 0);
+static DEFINE_TIMER(clear_led_timer, NULL, 0, 0);
 static int current_speed; /* Speed read from transceiver */
 static int current_speed_selection; /* Speed selected by user */
 static unsigned long led_next_time;
@@ -393,7 +393,7 @@ static int led_active;
 static int rx_queue_len;
 
 /* Duplex */
-static struct timer_list duplex_timer = TIMER_INITIALIZER(NULL, 0, 0);
+static DEFINE_TIMER(duplex_timer, NULL, 0, 0);
 static int full_duplex;
 static enum duplex current_duplex;
 
--- linux/drivers/char/tpm/tpm_nsc.c.orig
+++ linux/drivers/char/tpm/tpm_nsc.c
@@ -56,8 +56,7 @@
 static int wait_for_stat(struct tpm_chip *chip, u8 mask, u8 val, u8 * data)
 {
 	int expired = 0;
-	struct timer_list status_timer =
-	    TIMER_INITIALIZER(tpm_time_expired, jiffies + 10 * HZ,
+	DEFINE_TIMER(status_timer, tpm_time_expired, jiffies + 10 * HZ,
 			      (unsigned long) &expired);
 
 	/* status immediately available check */
@@ -85,8 +84,7 @@ static int nsc_wait_for_ready(struct tpm
 {
 	int status;
 	int expired = 0;
-	struct timer_list status_timer =
-	    TIMER_INITIALIZER(tpm_time_expired, jiffies + 100,
+	DEFINE_TIMER(status_timer, tpm_time_expired, jiffies + 100,
 			      (unsigned long) &expired);
 
 	/* status immediately available check */
--- linux/drivers/char/watchdog/mixcomwd.c.orig
+++ linux/drivers/char/watchdog/mixcomwd.c
@@ -59,7 +59,7 @@ static unsigned long mixcomwd_opened; /*
 
 static int watchdog_port;
 static int mixcomwd_timer_alive;
-static struct timer_list mixcomwd_timer = TIMER_INITIALIZER(NULL, 0, 0);
+static DEFINE_TIMER(mixcomwd_timer, NULL, 0, 0);
 static char expect_close;
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
--- linux/drivers/char/watchdog/softdog.c.orig
+++ linux/drivers/char/watchdog/softdog.c
@@ -80,8 +80,7 @@ MODULE_PARM_DESC(soft_noboot, "Softdog a
 
 static void watchdog_fire(unsigned long);
 
-static struct timer_list watchdog_ticktock =
-		TIMER_INITIALIZER(watchdog_fire, 0, 0);
+static DEFINE_TIMER(watchdog_ticktock, watchdog_fire, 0, 0);
 static unsigned long timer_alive;
 static char expect_close;
 
--- linux/drivers/char/istallion.c.orig
+++ linux/drivers/char/istallion.c
@@ -781,7 +781,7 @@ static struct file_operations	stli_fsiom
  *	much cheaper on host cpu than using interrupts. It turns out to
  *	not increase character latency by much either...
  */
-static struct timer_list stli_timerlist = TIMER_INITIALIZER(stli_poll, 0, 0);
+static DEFINE_TIMER(stli_timerlist, stli_poll, 0, 0);
 
 static int	stli_timeron;
 
--- linux/drivers/char/hangcheck-timer.c.orig
+++ linux/drivers/char/hangcheck-timer.c
@@ -149,8 +149,7 @@ static unsigned long long hangcheck_tsc,
 
 static void hangcheck_fire(unsigned long);
 
-static struct timer_list hangcheck_ticktock =
-		TIMER_INITIALIZER(hangcheck_fire, 0, 0);
+static DEFINE_TIMER(hangcheck_ticktock, hangcheck_fire, 0, 0);
 
 
 static void hangcheck_fire(unsigned long data)
--- linux/drivers/char/cyclades.c.orig
+++ linux/drivers/char/cyclades.c
@@ -865,7 +865,7 @@ static void cyz_poll(unsigned long);
 static long cyz_polling_cycle = CZ_DEF_POLL;
 
 static int cyz_timeron = 0;
-static struct timer_list cyz_timerlist = TIMER_INITIALIZER(cyz_poll, 0, 0);
+static DEFINE_TIMER(cyz_timerlist, cyz_poll, 0, 0);
 
 #else /* CONFIG_CYZ_INTR */
 static void cyz_rx_restart(unsigned long);
--- linux/drivers/char/keyboard.c.orig
+++ linux/drivers/char/keyboard.c
@@ -233,8 +233,7 @@ static void kd_nosound(unsigned long ign
 	}
 }
 
-static struct timer_list kd_mksound_timer =
-		TIMER_INITIALIZER(kd_nosound, 0, 0);
+static DEFINE_TIMER(kd_mksound_timer, kd_nosound, 0, 0);
 
 void kd_mksound(unsigned int hz, unsigned int ticks)
 {
--- linux/drivers/char/ip2main.c.orig
+++ linux/drivers/char/ip2main.c
@@ -255,7 +255,7 @@ static unsigned long bh_counter = 0;
  * selected, the board is serviced periodically to see if anything needs doing.
  */
 #define  POLL_TIMEOUT   (jiffies + 1)
-static struct timer_list PollTimer = TIMER_INITIALIZER(ip2_poll, 0, 0);
+static DEFINE_TIMER(PollTimer, ip2_poll, 0, 0);
 static char  TimerOn;
 
 #ifdef IP2DEBUG_TRACE
--- linux/drivers/atm/iphase.c.orig
+++ linux/drivers/atm/iphase.c
@@ -79,7 +79,7 @@ static IADEV *ia_dev[8];
 static struct atm_dev *_ia_dev[8];
 static int iadev_count;
 static void ia_led_timer(unsigned long arg);
-static struct timer_list ia_timer = TIMER_INITIALIZER(ia_led_timer, 0, 0);
+static DEFINE_TIMER(ia_timer, ia_led_timer, 0, 0);
 static int IA_TX_BUF = DFL_TX_BUFFERS, IA_TX_BUF_SZ = DFL_TX_BUF_SZ;
 static int IA_RX_BUF = DFL_RX_BUFFERS, IA_RX_BUF_SZ = DFL_RX_BUF_SZ;
 static uint IADebugFlag = /* IF_IADBG_ERR | IF_IADBG_CBR| IF_IADBG_INIT_ADAPTER
--- linux/drivers/atm/idt77105.c.orig
+++ linux/drivers/atm/idt77105.c
@@ -50,10 +50,8 @@ static void idt77105_stats_timer_func(un
 static void idt77105_restart_timer_func(unsigned long);
 
 
-static struct timer_list stats_timer =
-    TIMER_INITIALIZER(idt77105_stats_timer_func, 0, 0);
-static struct timer_list restart_timer =
-    TIMER_INITIALIZER(idt77105_restart_timer_func, 0, 0);
+static DEFINE_TIMER(stats_timer, idt77105_stats_timer_func, 0, 0);
+static DEFINE_TIMER(restart_timer, idt77105_restart_timer_func, 0, 0);
 static int start_timer = 1;
 static struct idt77105_priv *idt77105_all = NULL;
 
--- linux/drivers/scsi/pluto.c.orig
+++ linux/drivers/scsi/pluto.c
@@ -95,8 +95,7 @@ int __init pluto_detect(Scsi_Host_Templa
 	int i, retry, nplutos;
 	fc_channel *fc;
 	Scsi_Device dev;
-	struct timer_list fc_timer =
-		TIMER_INITIALIZER(pluto_detect_timeout, 0, 0);
+	struct DEFINE_TIMER(fc_timer, pluto_detect_timeout, 0, 0);
 
 	tpnt->proc_name = "pluto";
 	fcscount = 0;
--- linux/drivers/sbus/char/aurora.c.orig
+++ linux/drivers/sbus/char/aurora.c
@@ -871,8 +871,7 @@ static irqreturn_t aurora_interrupt(int 
 #ifdef AURORA_INT_DEBUG
 static void aurora_timer (unsigned long ignored);
 
-static struct timer_list aurora_poll_timer =
-			TIMER_INITIALIZER(aurora_timer, 0, 0);
+static DEFINE_TIMER(aurora_poll_timer, aurora_timer, 0, 0);
 
 static void
 aurora_timer (unsigned long ignored)
--- linux/drivers/cdrom/aztcd.c.orig
+++ linux/drivers/cdrom/aztcd.c
@@ -297,7 +297,7 @@ static char azt_auto_eject = AZT_AUTO_EJ
 
 static int AztTimeout, AztTries;
 static DECLARE_WAIT_QUEUE_HEAD(azt_waitq);
-static struct timer_list delay_timer = TIMER_INITIALIZER(NULL, 0, 0);
+static DEFINE_TIMER(delay_timer, NULL, 0, 0);
 
 static struct azt_DiskInfo DiskInfo;
 static struct azt_Toc Toc[MAX_TRACKS];
--- linux/drivers/cdrom/sjcd.c.orig
+++ linux/drivers/cdrom/sjcd.c
@@ -151,7 +151,7 @@ static struct sjcd_stat statistic;
 /*
  * Timer.
  */
-static struct timer_list sjcd_delay_timer = TIMER_INITIALIZER(NULL, 0, 0);
+static DEFINE_TIMER(sjcd_delay_timer, NULL, 0, 0);
 
 #define SJCD_SET_TIMER( func, tmout )           \
     ( sjcd_delay_timer.expires = jiffies+tmout,         \
--- linux/drivers/cdrom/sbpcd.c.orig
+++ linux/drivers/cdrom/sbpcd.c
@@ -742,13 +742,10 @@ static struct sbpcd_drive *current_drive
 unsigned long cli_sti; /* for saving the processor flags */
 #endif
 /*==========================================================================*/
-static struct timer_list delay_timer =
-		TIMER_INITIALIZER(mark_timeout_delay, 0, 0);
-static struct timer_list data_timer =
-		TIMER_INITIALIZER(mark_timeout_data, 0, 0);
+static DEFINE_TIMER(delay_timer, mark_timeout_delay, 0, 0);
+static DEFINE_TIMER(data_timer, mark_timeout_data, 0, 0);
 #if 0
-static struct timer_list audio_timer =
-		TIMER_INITIALIZER(mark_timeout_audio, 0, 0);
+static DEFINE_TIMER(audio_timer, mark_timeout_audio, 0, 0);
 #endif
 /*==========================================================================*/
 /*
--- linux/drivers/cdrom/optcd.c.orig
+++ linux/drivers/cdrom/optcd.c
@@ -264,7 +264,7 @@ inline static int flag_low(int flag, uns
 static int sleep_timeout;	/* max # of ticks to sleep */
 static DECLARE_WAIT_QUEUE_HEAD(waitq);
 static void sleep_timer(unsigned long data);
-static struct timer_list delay_timer = TIMER_INITIALIZER(sleep_timer, 0, 0);
+static DEFINE_TIMER(delay_timer, sleep_timer, 0, 0);
 static DEFINE_SPINLOCK(optcd_lock);
 static struct request_queue *opt_queue;
 
--- linux/drivers/cdrom/gscd.c.orig
+++ linux/drivers/cdrom/gscd.c
@@ -146,7 +146,7 @@ static int AudioStart_f;
 static int AudioEnd_m;
 static int AudioEnd_f;
 
-static struct timer_list gscd_timer = TIMER_INITIALIZER(NULL, 0, 0);
+static DEFINE_TIMER(gscd_timer, NULL, 0, 0);
 static DEFINE_SPINLOCK(gscd_lock);
 static struct request_queue *gscd_queue;
 
--- linux/drivers/acorn/block/fd1772.c.orig
+++ linux/drivers/acorn/block/fd1772.c
@@ -376,19 +376,15 @@ static void do_fd_request(request_queue_
 
 /************************* End of Prototypes **************************/
 
-static struct timer_list motor_off_timer =
-	TIMER_INITIALIZER(fd_motor_off_timer, 0, 0);
+static DEFINE_TIMER(motor_off_timer, fd_motor_off_timer, 0, 0);
 
 #ifdef TRACKBUFFER
-static struct timer_list readtrack_timer =
-	TIMER_INITIALIZER(fd_readtrack_check, 0, 0);
+static DEFINE_TIMER(readtrack_timer, fd_readtrack_check, 0, 0);
 #endif
 
-static struct timer_list timeout_timer =
-	TIMER_INITIALIZER(fd_times_out, 0, 0);
+static DEFINE_TIMER(timeout_timer, fd_times_out, 0, 0);
 
-static struct timer_list fd_timer =
-	TIMER_INITIALIZER(check_change, 0, 0);
+static DEFINE_TIMER(fd_timer, check_change, 0, 0);
 
 /* DAG: Haven't got a clue what this is? */
 int stdma_islocked(void)
--- linux/drivers/usb/host/hc_crisv10.c.orig
+++ linux/drivers/usb/host/hc_crisv10.c
@@ -178,8 +178,8 @@ static __u8 root_hub_hub_des[] =
 	0xff   /*  __u8  PortPwrCtrlMask; *** 7 ports max *** */
 };
 
-static struct timer_list bulk_start_timer = TIMER_INITIALIZER(NULL, 0, 0);
-static struct timer_list bulk_eot_timer = TIMER_INITIALIZER(NULL, 0, 0);
+static DEFINE_TIMER(bulk_start_timer, NULL, 0, 0);
+static DEFINE_TIMER(bulk_eot_timer, NULL, 0, 0);
 
 /* We want the start timer to expire before the eot timer, because the former might start
    traffic, thus making it unnecessary for the latter to time out. */
--- linux/drivers/block/acsi_slm.c.orig
+++ linux/drivers/block/acsi_slm.c
@@ -268,7 +268,7 @@ static int slm_get_pagesize( int device,
 /************************* End of Prototypes **************************/
 
 
-static struct timer_list slm_timer = TIMER_INITIALIZER(slm_test_ready, 0, 0);
+static DEFINE_TIMER(slm_timer, slm_test_ready, 0, 0);
 
 static struct file_operations slm_fops = {
 	.owner =	THIS_MODULE,
--- linux/drivers/block/floppy.c.orig
+++ linux/drivers/block/floppy.c
@@ -626,7 +626,7 @@ static inline void debugt(const char *me
 #endif /* DEBUGT */
 
 typedef void (*timeout_fn) (unsigned long);
-static struct timer_list fd_timeout = TIMER_INITIALIZER(floppy_shutdown, 0, 0);
+static DEFINE_TIMER(fd_timeout, floppy_shutdown, 0, 0);
 
 static const char *timeout_message;
 
@@ -1010,7 +1010,7 @@ static void schedule_bh(void (*handler) 
 	schedule_work(&floppy_work);
 }
 
-static struct timer_list fd_timer = TIMER_INITIALIZER(NULL, 0, 0);
+static DEFINE_TIMER(fd_timer, NULL, 0, 0);
 
 static void cancel_activity(void)
 {
--- linux/drivers/block/ps2esdi.c.orig
+++ linux/drivers/block/ps2esdi.c
@@ -99,8 +99,7 @@ static DECLARE_WAIT_QUEUE_HEAD(ps2esdi_i
 static int no_int_yet;
 static int ps2esdi_drives;
 static u_short io_base;
-static struct timer_list esdi_timer =
-		TIMER_INITIALIZER(ps2esdi_reset_timer, 0, 0);
+static DEFINE_TIMER(esdi_timer, ps2esdi_reset_timer, 0, 0);
 static int reset_status;
 static int ps2esdi_slot = -1;
 static int tp720esdi = 0;	/* Is it Integrated ESDI of ThinkPad-720? */
--- linux/drivers/block/acsi.c.orig
+++ linux/drivers/block/acsi.c
@@ -371,7 +371,7 @@ static int acsi_revalidate (struct gendi
 /************************* End of Prototypes **************************/
 
 
-struct timer_list acsi_timer = TIMER_INITIALIZER(acsi_times_out, 0, 0);
+DEFINE_TIMER(acsi_timer, acsi_times_out, 0, 0);
 
 
 #ifdef CONFIG_ATARI_SLM
--- linux/drivers/block/ataflop.c.orig
+++ linux/drivers/block/ataflop.c
@@ -371,16 +371,10 @@ static int floppy_release( struct inode 
 
 /************************* End of Prototypes **************************/
 
-static struct timer_list motor_off_timer =
-	TIMER_INITIALIZER(fd_motor_off_timer, 0, 0);
-static struct timer_list readtrack_timer =
-	TIMER_INITIALIZER(fd_readtrack_check, 0, 0);
-
-static struct timer_list timeout_timer =
-	TIMER_INITIALIZER(fd_times_out, 0, 0);
-
-static struct timer_list fd_timer =
-	TIMER_INITIALIZER(check_change, 0, 0);
+static DEFINE_TIMER(motor_off_timer, fd_motor_off_timer, 0, 0);
+static DEFINE_TIMER(readtrack_timer, fd_readtrack_check, 0, 0);
+static DEFINE_TIMER(timeout_timer, fd_times_out, 0, 0);
+static DEFINE_TIMER(fd_timer, check_change, 0, 0);
 	
 static inline void start_motor_off_timer(void)
 {
--- linux/include/linux/timer.h.orig
+++ linux/include/linux/timer.h
@@ -32,6 +32,10 @@ extern struct timer_base_s __init_timer_
 		.magic = TIMER_MAGIC,				\
 	}
 
+#define DEFINE_TIMER(_name, _function, _expires, _data)		\
+	struct timer_list _name =				\
+		TIMER_INITIALIZER(_function, _expires, _data)
+
 void fastcall init_timer(struct timer_list * timer);
 
 /***
