Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbSKESPm>; Tue, 5 Nov 2002 13:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbSKESPl>; Tue, 5 Nov 2002 13:15:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:21138 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264992AbSKESPZ>;
	Tue, 5 Nov 2002 13:15:25 -0500
Message-ID: <3DC80C3F.E6456D70@digeo.com>
Date: Tue, 05 Nov 2002 10:21:51 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/4] timers: scsi, input, networking
References: <3DC75B04.FE54B2E1@digeo.com> <Pine.LNX.4.44.0211051009290.2777-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Nov 2002 18:21:54.0633 (UTC) FILETIME=[3803E390:01C284F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Hmm.. The subject says "scsi, input, networking", but there is only a scsi
> part to the patch. Messed up patch?
> 

I stuck five micropatches into one email.  Here's a rollup of
the same:

 drivers/input/serio/i8042.c |    1 +
 drivers/scsi/scsi.c         |    2 ++
 net/ipv4/inetpeer.c         |    2 +-
 net/ipv4/route.c            |    2 ++
 net/ipv4/tcp_minisocks.c    |    5 +++--
 5 files changed, 9 insertions(+), 3 deletions(-)

--- 25/drivers/scsi/scsi.c~rollup	Tue Nov  5 10:19:24 2002
+++ 25-akpm/drivers/scsi/scsi.c	Tue Nov  5 10:20:17 2002
@@ -603,6 +603,7 @@ inline void __scsi_release_command(Scsi_
 				 GFP_DMA : 0));
 		if(newSCpnt) {
 			memset(newSCpnt, 0, sizeof(Scsi_Cmnd));
+			init_timer(&newSCpnt->eh_timeout);
 			newSCpnt->host = SDpnt->host;
 			newSCpnt->device = SDpnt;
 			newSCpnt->target = SDpnt->id;
@@ -1551,6 +1552,7 @@ void scsi_build_commandblocks(Scsi_Devic
 	}
 
 	memset(SCpnt, 0, sizeof(Scsi_Cmnd));
+	init_timer(&SCpnt->eh_timeout);
 	SCpnt->host = SDpnt->host;
 	SCpnt->device = SDpnt;
 	SCpnt->target = SDpnt->id;
--- 25/drivers/input/serio/i8042.c~rollup	Tue Nov  5 10:19:35 2002
+++ 25-akpm/drivers/input/serio/i8042.c	Tue Nov  5 10:20:22 2002
@@ -844,6 +844,7 @@ int __init i8042_init(void)
 
 	i8042_port_register(&i8042_kbd_values, &i8042_kbd_port);
 
+	init_timer(&i8042_timer);
 	i8042_timer.function = i8042_timer_func;
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
--- 25/net/ipv4/route.c~rollup	Tue Nov  5 10:19:43 2002
+++ 25-akpm/net/ipv4/route.c	Tue Nov  5 10:20:29 2002
@@ -2526,7 +2526,9 @@ void __init ip_rt_init(void)
 	devinet_init();
 	ip_fib_init();
 
+	init_timer(&rt_flush_timer);
 	rt_flush_timer.function = rt_run_flush;
+	init_timer(&rt_periodic_timer);
 	rt_periodic_timer.function = rt_check_expire;
 
 	/* All the timers, started at system startup tend
--- 25/net/ipv4/inetpeer.c~rollup	Tue Nov  5 10:19:54 2002
+++ 25-akpm/net/ipv4/inetpeer.c	Tue Nov  5 10:20:34 2002
@@ -98,7 +98,7 @@ spinlock_t inet_peer_unused_lock = SPIN_
 
 static void peer_check_expire(unsigned long dummy);
 static struct timer_list peer_periodic_timer =
-	{ .function = &peer_check_expire };
+	TIMER_INITIALIZER(peer_check_expire, 0, 0);
 
 /* Exported for sysctl_net_ipv4.  */
 int inet_peer_gc_mintime = 10 * HZ,
--- 25/net/ipv4/tcp_minisocks.c~rollup	Tue Nov  5 10:20:02 2002
+++ 25-akpm/net/ipv4/tcp_minisocks.c	Tue Nov  5 10:20:40 2002
@@ -428,7 +428,7 @@ static void tcp_twkill(unsigned long);
 
 static struct tcp_tw_bucket *tcp_tw_death_row[TCP_TWKILL_SLOTS];
 static spinlock_t tw_death_lock = SPIN_LOCK_UNLOCKED;
-static struct timer_list tcp_tw_timer = { .function = tcp_twkill };
+static struct timer_list tcp_tw_timer = TIMER_INITIALIZER(tcp_twkill, 0, 0);
 
 static void SMP_TIMER_NAME(tcp_twkill)(unsigned long dummy)
 {
@@ -495,7 +495,8 @@ void tcp_tw_deschedule(struct tcp_tw_buc
 static int tcp_twcal_hand = -1;
 static int tcp_twcal_jiffie;
 static void tcp_twcal_tick(unsigned long);
-static struct timer_list tcp_twcal_timer = {.function = tcp_twcal_tick};
+static struct timer_list tcp_twcal_timer =
+		TIMER_INITIALIZER(tcp_twcal_tick, 0, 0);
 static struct tcp_tw_bucket *tcp_twcal_row[TCP_TW_RECYCLE_SLOTS];
 
 void tcp_tw_schedule(struct tcp_tw_bucket *tw, int timeo)

.
