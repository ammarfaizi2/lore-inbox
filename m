Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161493AbWLAVKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161493AbWLAVKJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbWLAVKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:10:09 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:7864
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1161689AbWLAVKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:10:06 -0500
Subject: [PATCH] generic HDLC synclink config mismatch fix
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 15:09:38 -0600
Message-Id: <1165007378.3836.5.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compile errors on mismatch between generic HDLC
and synclink drivers.

Notes:

generic HDLC support for synclink drivers is *optional*
so you can't just use depend on in Kconfig

This solution is deemed the best after 7 months of review
and criticism by many developers including AKPM. Read the
threads on LKML before posting about this solution.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- a/drivers/char/synclink.c	2006-11-29 15:57:37.000000000 -0600
+++ b/drivers/char/synclink.c	2006-12-01 14:38:13.000000000 -0600
@@ -101,8 +101,10 @@
 #include <linux/hdlc.h>
 #include <linux/dma-mapping.h>
 
-#ifdef CONFIG_HDLC_MODULE
-#define CONFIG_HDLC 1
+#if defined(CONFIG_HDLC) || (defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINK_MODULE))
+#define SYNCLINK_GENERIC_HDLC 1
+#else
+#define SYNCLINK_GENERIC_HDLC 0
 #endif
 
 #define GET_USER(error,value,addr) error = get_user(value,addr)
@@ -320,7 +322,7 @@ struct mgsl_struct {
 	int dosyncppp;
 	spinlock_t netlock;
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	struct net_device *netdev;
 #endif
 };
@@ -728,7 +730,7 @@ static void usc_loopmode_send_done( stru
 
 static int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigned long arg);
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
 static void hdlcdev_tx_done(struct mgsl_struct *info);
 static void hdlcdev_rx(struct mgsl_struct *info, char *buf, int size);
@@ -1276,7 +1278,7 @@ static void mgsl_isr_transmit_status( st
 		info->drop_rts_on_tx_done = 0;
 	}
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else 
@@ -1341,7 +1343,7 @@ static void mgsl_isr_io_pin( struct mgsl
 				info->input_signal_events.dcd_up++;
 			} else
 				info->input_signal_events.dcd_down++;
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 			if (info->netcount) {
 				if (status & MISCSTATUS_DCD)
 					netif_carrier_on(info->netdev);
@@ -4312,7 +4314,7 @@ static void mgsl_add_device( struct mgsl
 		     	info->max_frame_size );
 	}
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	hdlcdev_init(info);
 #endif
 
@@ -4470,7 +4472,7 @@ static void synclink_cleanup(void)
 
 	info = mgsl_device_list;
 	while(info) {
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 		hdlcdev_exit(info);
 #endif
 		mgsl_release_resources(info);
@@ -6644,7 +6646,7 @@ static int mgsl_get_rx_frame(struct mgsl
 				return_frame = 1;
 		}
 		framesize = 0;
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 		{
 			struct net_device_stats *stats = hdlc_stats(info->netdev);
 			stats->rx_errors++;
@@ -6720,7 +6722,7 @@ static int mgsl_get_rx_frame(struct mgsl
 						*ptmp);
 			}
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 			if (info->netcount)
 				hdlcdev_rx(info,info->intermediate_rxbuffer,framesize);
 			else
@@ -7624,7 +7626,7 @@ static void mgsl_tx_timeout(unsigned lon
 
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 	
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else
@@ -7700,7 +7702,7 @@ static int usc_loopmode_active( struct m
  	return usc_InReg( info, CCSR ) & BIT7 ? 1 : 0 ;
 }
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 
 /**
  * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
--- a/drivers/char/pcmcia/synclink_cs.c	2006-11-29 15:57:37.000000000 -0600
+++ b/drivers/char/pcmcia/synclink_cs.c	2006-12-01 14:38:25.000000000 -0600
@@ -75,8 +75,10 @@
 #include <pcmcia/cisreg.h>
 #include <pcmcia/ds.h>
 
-#ifdef CONFIG_HDLC_MODULE
-#define CONFIG_HDLC 1
+#if defined(CONFIG_HDLC) || (defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINK_CS_MODULE))
+#define SYNCLINK_GENERIC_HDLC 1
+#else
+#define SYNCLINK_GENERIC_HDLC 0
 #endif
 
 #define GET_USER(error,value,addr) error = get_user(value,addr)
@@ -235,7 +237,7 @@ typedef struct _mgslpc_info {
 	int dosyncppp;
 	spinlock_t netlock;
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	struct net_device *netdev;
 #endif
 
@@ -392,7 +394,7 @@ static void tx_timeout(unsigned long con
 
 static int ioctl_common(MGSLPC_INFO *info, unsigned int cmd, unsigned long arg);
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
 static void hdlcdev_tx_done(MGSLPC_INFO *info);
 static void hdlcdev_rx(MGSLPC_INFO *info, char *buf, int size);
@@ -1060,7 +1062,7 @@ static void tx_done(MGSLPC_INFO *info)
 		info->drop_rts_on_tx_done = 0;
 	}
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else 
@@ -1171,7 +1173,7 @@ static void dcd_change(MGSLPC_INFO *info
 	}
 	else
 		info->input_signal_events.dcd_down++;
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	if (info->netcount) {
 		if (info->serial_signals & SerialSignal_DCD)
 			netif_carrier_on(info->netdev);
@@ -2960,7 +2962,7 @@ static void mgslpc_add_device(MGSLPC_INF
 	printk( "SyncLink PC Card %s:IO=%04X IRQ=%d\n",
 		info->device_name, info->io_base, info->irq_level);
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	hdlcdev_init(info);
 #endif
 }
@@ -2976,7 +2978,7 @@ static void mgslpc_remove_device(MGSLPC_
 				last->next_device = info->next_device;
 			else
 				mgslpc_device_list = info->next_device;
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 			hdlcdev_exit(info);
 #endif
 			release_resources(info);
@@ -3908,7 +3910,7 @@ static int rx_get_frame(MGSLPC_INFO *inf
 				return_frame = 1;
 		}
 		framesize = 0;
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 		{
 			struct net_device_stats *stats = hdlc_stats(info->netdev);
 			stats->rx_errors++;
@@ -3942,7 +3944,7 @@ static int rx_get_frame(MGSLPC_INFO *inf
 				++framesize;
 			}
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 			if (info->netcount)
 				hdlcdev_rx(info, buf->data, framesize);
 			else
@@ -4098,7 +4100,7 @@ static void tx_timeout(unsigned long con
 
 	spin_unlock_irqrestore(&info->lock,flags);
 	
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else
@@ -4106,7 +4108,7 @@ static void tx_timeout(unsigned long con
 		bh_transmit(info);
 }
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 
 /**
  * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
--- a/drivers/char/synclink_gt.c	2006-11-29 15:57:37.000000000 -0600
+++ b/drivers/char/synclink_gt.c	2006-12-01 14:37:50.000000000 -0600
@@ -83,8 +83,10 @@
 
 #include "linux/synclink.h"
 
-#ifdef CONFIG_HDLC_MODULE
-#define CONFIG_HDLC 1
+#if defined(CONFIG_HDLC) || (defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINK_GT_MODULE))
+#define SYNCLINK_GENERIC_HDLC 1
+#else
+#define SYNCLINK_GENERIC_HDLC 0
 #endif
 
 /*
@@ -171,7 +173,7 @@ static void set_break(struct tty_struct 
 /*
  * generic HDLC support and callbacks
  */
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
 static void hdlcdev_tx_done(struct slgt_info *info);
 static void hdlcdev_rx(struct slgt_info *info, char *buf, int size);
@@ -359,7 +361,7 @@ struct slgt_info {
 	int netcount;
 	int dosyncppp;
 	spinlock_t netlock;
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	struct net_device *netdev;
 #endif
 
@@ -1354,7 +1356,7 @@ static void set_break(struct tty_struct 
 	spin_unlock_irqrestore(&info->lock,flags);
 }
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 
 /**
  * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
@@ -2002,7 +2004,7 @@ static void dcd_change(struct slgt_info 
 	} else {
 		info->input_signal_events.dcd_down++;
 	}
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	if (info->netcount) {
 		if (info->signals & SerialSignal_DCD)
 			netif_carrier_on(info->netdev);
@@ -2180,7 +2182,7 @@ static void isr_txeom(struct slgt_info *
 			set_signals(info);
 		}
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 		if (info->netcount)
 			hdlcdev_tx_done(info);
 		else
@@ -3306,7 +3308,7 @@ static void add_device(struct slgt_info 
 		devstr, info->device_name, info->phys_reg_addr,
 		info->irq_level, info->max_frame_size);
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	hdlcdev_init(info);
 #endif
 }
@@ -3488,7 +3490,7 @@ static void slgt_cleanup(void)
 	/* release devices */
 	info = slgt_device_list;
 	while(info) {
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 		hdlcdev_exit(info);
 #endif
 		free_dma_bufs(info);
@@ -4433,7 +4435,7 @@ check_again:
 			framesize = 0;
 	}
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	if (framesize == 0) {
 		struct net_device_stats *stats = hdlc_stats(info->netdev);
 		stats->rx_errors++;
@@ -4476,7 +4478,7 @@ check_again:
 				framesize++;
 			}
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 			if (info->netcount)
 				hdlcdev_rx(info,info->tmp_rbuf, framesize);
 			else
@@ -4779,7 +4781,7 @@ static void tx_timeout(unsigned long con
 	info->tx_count = 0;
 	spin_unlock_irqrestore(&info->lock,flags);
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else
--- a/drivers/char/synclinkmp.c	2006-11-29 15:57:37.000000000 -0600
+++ b/drivers/char/synclinkmp.c	2006-12-01 14:38:02.000000000 -0600
@@ -67,8 +67,10 @@
 #include <linux/workqueue.h>
 #include <linux/hdlc.h>
 
-#ifdef CONFIG_HDLC_MODULE
-#define CONFIG_HDLC 1
+#if defined(CONFIG_HDLC) || (defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINKMP_MODULE))
+#define SYNCLINK_GENERIC_HDLC 1
+#else
+#define SYNCLINK_GENERIC_HDLC 0
 #endif
 
 #define GET_USER(error,value,addr) error = get_user(value,addr)
@@ -280,7 +282,7 @@ typedef struct _synclinkmp_info {
 	int dosyncppp;
 	spinlock_t netlock;
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	struct net_device *netdev;
 #endif
 
@@ -536,7 +538,7 @@ static void throttle(struct tty_struct *
 static void unthrottle(struct tty_struct * tty);
 static void set_break(struct tty_struct *tty, int break_state);
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
 static void hdlcdev_tx_done(SLMP_INFO *info);
 static void hdlcdev_rx(SLMP_INFO *info, char *buf, int size);
@@ -1607,7 +1609,7 @@ static void set_break(struct tty_struct 
 	spin_unlock_irqrestore(&info->lock,flags);
 }
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 
 /**
  * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
@@ -2339,7 +2341,7 @@ static void isr_txeom(SLMP_INFO * info, 
 			set_signals(info);
 		}
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 		if (info->netcount)
 			hdlcdev_tx_done(info);
 		else
@@ -2523,7 +2525,7 @@ void isr_io_pin( SLMP_INFO *info, u16 st
 				info->input_signal_events.dcd_up++;
 			} else
 				info->input_signal_events.dcd_down++;
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 			if (info->netcount) {
 				if (status & SerialSignal_DCD)
 					netif_carrier_on(info->netdev);
@@ -3783,7 +3785,7 @@ void add_device(SLMP_INFO *info)
 		info->irq_level,
 		info->max_frame_size );
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	hdlcdev_init(info);
 #endif
 }
@@ -3977,7 +3979,7 @@ static void synclinkmp_cleanup(void)
 	/* release devices */
 	info = synclinkmp_device_list;
 	while(info) {
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 		hdlcdev_exit(info);
 #endif
 		free_dma_bufs(info);
@@ -4979,7 +4981,7 @@ CheckAgain:
 			info->icount.rxcrc++;
 
 		framesize = 0;
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 		{
 			struct net_device_stats *stats = hdlc_stats(info->netdev);
 			stats->rx_errors++;
@@ -5020,7 +5022,7 @@ CheckAgain:
 					index = 0;
 			}
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 			if (info->netcount)
 				hdlcdev_rx(info,info->tmp_rx_buf,framesize);
 			else
@@ -5531,7 +5533,7 @@ void tx_timeout(unsigned long context)
 
 	spin_unlock_irqrestore(&info->lock,flags);
 
-#ifdef CONFIG_HDLC
+#if SYNCLINK_GENERIC_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else


