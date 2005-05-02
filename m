Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVEBCWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVEBCWz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 22:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVEBCWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 22:22:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47120 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261707AbVEBBrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:47:53 -0400
Date: Mon, 2 May 2005 03:47:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cdrom/cm206.c: cleanups
Message-ID: <20050502014747.GK3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global functions static
- remove the following unused global function:
  - cm206_delay

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/cdrom/cm206.c |  114 ++++++++++++++++++------------------------
 1 files changed, 50 insertions(+), 64 deletions(-)

--- linux-2.6.12-rc2-mm2-full/drivers/cdrom/cm206.c.old	2005-04-10 02:05:27.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/drivers/cdrom/cm206.c	2005-04-10 02:14:47.000000000 +0200
@@ -307,7 +307,7 @@
 /* First, we define some polling functions. These are actually
    only being used in the initialization. */
 
-void send_command_polled(int command)
+static void send_command_polled(int command)
 {
 	int loop = POLLOOP;
 	while (!(inw(r_line_status) & ls_transmitter_buffer_empty)
@@ -318,7 +318,7 @@
 	outw(command, r_uart_transmit);
 }
 
-uch receive_echo_polled(void)
+static uch receive_echo_polled(void)
 {
 	int loop = POLLOOP;
 	while (!(inw(r_line_status) & ls_receive_buffer_full) && loop > 0) {
@@ -328,13 +328,13 @@
 	return ((uch) inw(r_uart_receive));
 }
 
-uch send_receive_polled(int command)
+static uch send_receive_polled(int command)
 {
 	send_command_polled(command);
 	return receive_echo_polled();
 }
 
-inline void clear_ur(void)
+static inline void clear_ur(void)
 {
 	if (cd->ur_r != cd->ur_w) {
 		debug(("Deleting bytes from fifo:"));
@@ -439,7 +439,7 @@
 }
 
 /* we have put the address of the wait queue in who */
-void cm206_timeout(unsigned long who)
+static void cm206_timeout(unsigned long who)
 {
 	cd->timed_out = 1;
 	debug(("Timing out\n"));
@@ -448,7 +448,7 @@
 
 /* This function returns 1 if a timeout occurred, 0 if an interrupt
    happened */
-int sleep_or_timeout(wait_queue_head_t * wait, int timeout)
+static int sleep_or_timeout(wait_queue_head_t * wait, int timeout)
 {
 	cd->timed_out = 0;
 	init_timer(&cd->timer);
@@ -465,13 +465,7 @@
 		return 0;
 }
 
-void cm206_delay(int nr_jiffies)
-{
-	DECLARE_WAIT_QUEUE_HEAD(wait);
-	sleep_or_timeout(&wait, nr_jiffies);
-}
-
-void send_command(int command)
+static void send_command(int command)
 {
 	debug(("Sending 0x%x\n", command));
 	if (!(inw(r_line_status) & ls_transmitter_buffer_empty)) {
@@ -490,7 +484,7 @@
 		outw(command, r_uart_transmit);
 }
 
-uch receive_byte(int timeout)
+static uch receive_byte(int timeout)
 {
 	uch ret;
 	cli();
@@ -521,23 +515,23 @@
 	return ret;
 }
 
-inline uch receive_echo(void)
+static inline uch receive_echo(void)
 {
 	return receive_byte(UART_TIMEOUT);
 }
 
-inline uch send_receive(int command)
+static inline uch send_receive(int command)
 {
 	send_command(command);
 	return receive_echo();
 }
 
-inline uch wait_dsb(void)
+static inline uch wait_dsb(void)
 {
 	return receive_byte(DSB_TIMEOUT);
 }
 
-int type_0_command(int command, int expect_dsb)
+static int type_0_command(int command, int expect_dsb)
 {
 	int e;
 	clear_ur();
@@ -552,7 +546,7 @@
 	return 0;
 }
 
-int type_1_command(int command, int bytes, uch * status)
+static int type_1_command(int command, int bytes, uch * status)
 {				/* returns info */
 	int i;
 	if (type_0_command(command, 0))
@@ -564,7 +558,7 @@
 
 /* This function resets the adapter card. We'd better not do this too
  * often, because it tends to generate `lost interrupts.' */
-void reset_cm260(void)
+static void reset_cm260(void)
 {
 	outw(dc_normal | dc_initialize | READ_AHEAD, r_data_control);
 	udelay(10);		/* 3.3 mu sec minimum */
@@ -572,7 +566,7 @@
 }
 
 /* fsm: frame-sec-min from linear address; one of many */
-void fsm(int lba, uch * fsm)
+static void fsm(int lba, uch * fsm)
 {
 	fsm[0] = lba % 75;
 	lba /= 75;
@@ -581,17 +575,17 @@
 	fsm[2] = lba / 60;
 }
 
-inline int fsm2lba(uch * fsm)
+static inline int fsm2lba(uch * fsm)
 {
 	return fsm[0] + 75 * (fsm[1] - 2 + 60 * fsm[2]);
 }
 
-inline int f_s_m2lba(uch f, uch s, uch m)
+static inline int f_s_m2lba(uch f, uch s, uch m)
 {
 	return f + 75 * (s - 2 + 60 * m);
 }
 
-int start_read(int start)
+static int start_read(int start)
 {
 	uch read_sector[4] = { c_read_data, };
 	int i, e;
@@ -613,7 +607,7 @@
 	return 0;
 }
 
-int stop_read(void)
+static int stop_read(void)
 {
 	int e;
 	type_0_command(c_stop, 0);
@@ -630,7 +624,7 @@
    routine takes care of this. Set a flag `background' in the cd
    struct to indicate the process. */
 
-int read_background(int start, int reading)
+static int read_background(int start, int reading)
 {
 	if (cd->background)
 		return -1;	/* can't do twice */
@@ -658,7 +652,7 @@
 
 
 #define MAX_TRIES 100
-int read_sector(int start)
+static int read_sector(int start)
 {
 	int tries = 0;
 	if (cd->background) {
@@ -753,7 +747,7 @@
 /* This command clears the dsb_possible_media_change flag, so we must 
  * retain it.
  */
-void get_drive_status(void)
+static void get_drive_status(void)
 {
 	uch status[2];
 	type_1_command(c_drive_status, 2, status);	/* this might be done faster */
@@ -764,7 +758,7 @@
 			  dsb_drive_not_ready | dsb_tray_not_closed));
 }
 
-void get_disc_status(void)
+static void get_disc_status(void)
 {
 	if (type_1_command(c_disc_status, 7, cd->disc_status)) {
 		debug(("get_disc_status: error\n"));
@@ -801,7 +795,7 @@
 
 /* Empty buffer empties $sectors$ sectors of the adapter card buffer,
  * and then reads a sector in kernel memory.  */
-void empty_buffer(int sectors)
+static void empty_buffer(int sectors)
 {
 	while (sectors >= 0) {
 		transport_data(r_fifo_output_buffer,
@@ -819,7 +813,7 @@
 /* try_adapter. This function determines if the requested sector is
    in adapter memory, or will appear there soon. Returns 0 upon
    success */
-int try_adapter(int sector)
+static int try_adapter(int sector)
 {
 	if (cd->adapter_first <= sector && sector < cd->adapter_last) {
 		/* sector is in adapter memory */
@@ -910,7 +904,7 @@
 */
 
 /* seek seeks to address lba. It does wait to arrive there. */
-void seek(int lba)
+static void seek(int lba)
 {
 	int i;
 	uch seek_command[4] = { c_seek, };
@@ -926,7 +920,7 @@
 	return (bcd >> 4) * 10 + (bcd & 0xf);
 }
 
-inline uch normalize_track(uch track)
+static inline uch normalize_track(uch track)
 {
 	if (track < 1)
 		return 1;
@@ -939,7 +933,7 @@
  * tracks seen in the process. Input $track$ must be between 1 and
  * #-of-tracks+1.  Note that the start of the disc must be in toc[1].fsm. 
  */
-int get_toc_lba(uch track)
+static int get_toc_lba(uch track)
 {
 	int max = 74 * 60 * 75 - 150, min = fsm2lba(cd->toc[1].fsm);
 	int i, lba, l, old_lba = 0;
@@ -991,7 +985,7 @@
 	return lba;
 }
 
-void update_toc_entry(uch track)
+static void update_toc_entry(uch track)
 {
 	track = normalize_track(track);
 	if (!cd->toc[track].track)
@@ -999,7 +993,7 @@
 }
 
 /* return 0 upon success */
-int read_toc_header(struct cdrom_tochdr *hp)
+static int read_toc_header(struct cdrom_tochdr *hp)
 {
 	if (!FIRST_TRACK)
 		get_disc_status();
@@ -1016,7 +1010,7 @@
 	return -1;
 }
 
-void play_from_to_msf(struct cdrom_msf *msfp)
+static void play_from_to_msf(struct cdrom_msf *msfp)
 {
 	uch play_command[] = { c_play,
 		msfp->cdmsf_frame0, msfp->cdmsf_sec0, msfp->cdmsf_min0,
@@ -1032,7 +1026,7 @@
 	cd->dsb = wait_dsb();
 }
 
-void play_from_to_track(int from, int to)
+static void play_from_to_track(int from, int to)
 {
 	uch play_command[8] = { c_play, };
 	int i;
@@ -1059,7 +1053,7 @@
 	cd->dsb = wait_dsb();
 }
 
-int get_current_q(struct cdrom_subchnl *qp)
+static int get_current_q(struct cdrom_subchnl *qp)
 {
 	int i;
 	uch *q = cd->q;
@@ -1093,14 +1087,14 @@
 	return 0;
 }
 
-void invalidate_toc(void)
+static void invalidate_toc(void)
 {
 	memset(cd->toc, 0, sizeof(cd->toc));
 	memset(cd->disc_status, 0, sizeof(cd->disc_status));
 }
 
 /* cdrom.c guarantees that cdte_format == CDROM_MSF */
-void get_toc_entry(struct cdrom_tocentry *ep)
+static void get_toc_entry(struct cdrom_tocentry *ep)
 {
 	uch track = normalize_track(ep->cdte_track);
 	update_toc_entry(track);
@@ -1117,8 +1111,8 @@
  * upon success. Memory checking has been done by cdrom_ioctl(), the
  * calling function, as well as LBA/MSF sanitization.
 */
-int cm206_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
-		      void *arg)
+static int cm206_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
+			     void *arg)
 {
 	switch (cmd) {
 	case CDROMREADTOCHDR:
@@ -1189,7 +1183,7 @@
 	}
 }
 
-int cm206_media_changed(struct cdrom_device_info *cdi, int disc_nr)
+static int cm206_media_changed(struct cdrom_device_info *cdi, int disc_nr)
 {
 	if (cd != NULL) {
 		int r;
@@ -1204,16 +1198,9 @@
 /* The new generic cdrom support. Routines should be concise, most of
    the logic should be in cdrom.c */
 
-/* returns number of times device is in use */
-int cm206_open_files(struct cdrom_device_info *cdi)
-{
-	if (cd)
-		return cd->openfiles;
-	return -1;
-}
 
 /* controls tray movement */
-int cm206_tray_move(struct cdrom_device_info *cdi, int position)
+static int cm206_tray_move(struct cdrom_device_info *cdi, int position)
 {
 	if (position) {		/* 1: eject */
 		type_0_command(c_open_tray, 1);
@@ -1224,7 +1211,7 @@
 }
 
 /* gives current state of the drive */
-int cm206_drive_status(struct cdrom_device_info *cdi, int slot_nr)
+static int cm206_drive_status(struct cdrom_device_info *cdi, int slot_nr)
 {
 	get_drive_status();
 	if (cd->dsb & dsb_tray_not_closed)
@@ -1237,7 +1224,7 @@
 }
 
 /* locks or unlocks door lock==1: lock; return 0 upon success */
-int cm206_lock_door(struct cdrom_device_info *cdi, int lock)
+static int cm206_lock_door(struct cdrom_device_info *cdi, int lock)
 {
 	uch command = (lock) ? c_lock_tray : c_unlock_tray;
 	type_0_command(command, 1);	/* wait and get dsb */
@@ -1248,8 +1235,8 @@
 /* Although a session start should be in LBA format, we return it in 
    MSF format because it is slightly easier, and the new generic ioctl
    will take care of the necessary conversion. */
-int cm206_get_last_session(struct cdrom_device_info *cdi,
-			   struct cdrom_multisession *mssp)
+static int cm206_get_last_session(struct cdrom_device_info *cdi,
+				  struct cdrom_multisession *mssp)
 {
 	if (!FIRST_TRACK)
 		get_disc_status();
@@ -1268,7 +1255,7 @@
 	return 0;
 }
 
-int cm206_get_upc(struct cdrom_device_info *cdi, struct cdrom_mcn *mcn)
+static int cm206_get_upc(struct cdrom_device_info *cdi, struct cdrom_mcn *mcn)
 {
 	uch upc[10];
 	char *ret = mcn->medium_catalog_number;
@@ -1287,7 +1274,7 @@
 	return 0;
 }
 
-int cm206_reset(struct cdrom_device_info *cdi)
+static int cm206_reset(struct cdrom_device_info *cdi)
 {
 	stop_read();
 	reset_cm260();
@@ -1300,7 +1287,7 @@
 	return 0;
 }
 
-int cm206_select_speed(struct cdrom_device_info *cdi, int speed)
+static int cm206_select_speed(struct cdrom_device_info *cdi, int speed)
 {
 	int r;
 	switch (speed) {
@@ -1392,7 +1379,7 @@
    request_region, 15 bits of one port and 6 of another make things
    likely enough to accept the region on the first hit...
  */
-int __init probe_base_port(int base)
+static int __init probe_base_port(int base)
 {
 	int b = 0x300, e = 0x370;	/* this is the range of start addresses */
 	volatile int fool, i;
@@ -1416,7 +1403,7 @@
 
 #if !defined(MODULE) || defined(AUTO_PROBE_MODULE)
 /* Probe for irq# nr. If nr==0, probe for all possible irq's. */
-int __init probe_irq(int nr)
+static int __init probe_irq(int nr)
 {
 	int irqs, irq;
 	outw(dc_normal | READ_AHEAD, r_data_control);	/* disable irq-generation */
@@ -1558,7 +1545,7 @@
 	}
 }
 
-int __cm206_init(void)
+static int __cm206_init(void)
 {
 	parse_options();
 #if !defined(AUTO_PROBE_MODULE)
@@ -1567,7 +1554,7 @@
 	return cm206_init();
 }
 
-void __exit cm206_exit(void)
+static void __exit cm206_exit(void)
 {
 	del_gendisk(cm206_gendisk);
 	put_disk(cm206_gendisk);

