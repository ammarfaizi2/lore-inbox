Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWFIPrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWFIPrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWFIPrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:47:52 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:36331
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1030229AbWFIPrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:47:51 -0400
Subject: [PATCH] fix generic HDLC synclink mismatch build error
From: Paul Fulghum <paulkf@microgate.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, khc@pm.waw.pl
In-Reply-To: <20060607143138.62855633.rdunlap@xenotime.net>
References: <1149694978.12920.14.camel@amdx2.microgate.com>
	 <20060607143138.62855633.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 10:47:22 -0500
Message-Id: <1149868042.20097.5.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix missing symbol references to hdlc_generic functions.
Switch SYNCLINK drivers from using SELECT to using DEPENDS for HDLC.
However, the DEPENDS values must be restricted to the value
of HDLC (y or m). Includes previously dropped patch from Paul Fulghum
which adds separate config options for generic HDLC for each
synclink driver against which Randy's patch is applied.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- a/drivers/char/Kconfig	2006-06-09 09:47:46.000000000 -0500
+++ b/drivers/char/Kconfig	2006-06-09 09:48:00.000000000 -0500
@@ -195,31 +195,38 @@ config ISI
 	  If you want to do that, choose M here.
 
 config SYNCLINK
-	tristate "Microgate SyncLink card support"
+	tristate "SyncLink PCI/ISA support"
 	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
 	help
-	  Provides support for the SyncLink ISA and PCI multiprotocol serial
-	  adapters. These adapters support asynchronous and HDLC bit
-	  synchronous communication up to 10Mbps (PCI adapter).
-
-	  This driver can only be built as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called synclink.  If you want to do that, say M
-	  here.
+	  Driver for SyncLink ISA and PCI synchronous serial adapters.
+	  These adapters are no longer in production and have
+	  been replaced by the SyncLink GT adapter.
+
+config SYNCLINK_HDLC
+	bool "Generic HDLC support for SyncLink driver"
+	depends on SYNCLINK
+	depends on HDLC=y || HDLC=SYNCLINK
+	help
+	  Enable generic HDLC support for the SyncLink PCI/ISA driver.
+	  Generic HDLC implements multiple higher layer networking
+	  protocols for use with synchronous HDLC adapters.
 
 config SYNCLINKMP
 	tristate "SyncLink Multiport support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && PCI
 	help
-	  Enable support for the SyncLink Multiport (2 or 4 ports)
-	  serial adapter, running asynchronous and HDLC communications up
-	  to 2.048Mbps. Each ports is independently selectable for
-	  RS-232, V.35, RS-449, RS-530, and X.21
-
-	  This driver may be built as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called synclinkmp.  If you want to do that, say M
-	  here.
+	  Driver for SyncLink Multiport (2 or 4 ports) PCI synchronous serial adapter.
+	  These adapters are no longer in production and have
+	  been replaced by the SyncLink GT2 and GT4 adapters.
+
+config SYNCLINKMP_HDLC
+	bool "Generic HDLC support for SyncLink Multiport"
+	depends on SYNCLINKMP
+	depends on HDLC=y || HDLC=SYNCLINKMP
+	help
+	  Enable generic HDLC support for the SyncLink Multiport driver.
+	  Generic HDLC implements multiple higher layer networking
+	  protocols for use with synchronous HDLC adapters.
 
 config SYNCLINK_GT
 	tristate "SyncLink GT/AC support"
@@ -229,6 +236,15 @@ config SYNCLINK_GT
 	  synchronous and asynchronous serial adapters
 	  manufactured by Microgate Systems, Ltd. (www.microgate.com)
 
+config SYNCLINK_GT_HDLC
+	bool "Generic HDLC support for SyncLink GT/AC"
+	depends on SYNCLINK_GT
+	depends on HDLC=y || HDLC=SYNCLINK_GT
+	help
+	  Enable generic HDLC support for the SyncLink GT/AC driver.
+	  Generic HDLC implements multiple higher layer networking
+	  protocols for use with synchronous HDLC adapters.
+
 config N_HDLC
 	tristate "HDLC line discipline support"
 	depends on SERIAL_NONSTANDARD
--- a/drivers/char/pcmcia/Kconfig	2006-06-09 09:47:46.000000000 -0500
+++ b/drivers/char/pcmcia/Kconfig	2006-06-09 09:48:00.000000000 -0500
@@ -9,14 +9,16 @@ config SYNCLINK_CS
 	tristate "SyncLink PC Card support"
 	depends on PCMCIA
 	help
-	  Enable support for the SyncLink PC Card serial adapter, running
-	  asynchronous and HDLC communications up to 512Kbps. The port is
-	  selectable for RS-232, V.35, RS-449, RS-530, and X.21
-
-	  This driver may be built as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called synclinkmp.  If you want to do that, say M
-	  here.
+	  Driver for SyncLink PC Card synchronous serial adapter.
+
+config SYNCLINK_CS_HDLC
+	bool "Generic HDLC support for SyncLink Multiport"
+	depends on SYNCLINK_CS
+	depends on HDLC=y || HDLC=SYNCLINK_CS
+	help
+	  Enable generic HDLC support for the SyncLink PC Card driver.
+	  Generic HDLC implements multiple higher layer networking
+	  protocols for use with synchronous HDLC adapters.
 
 config CARDMAN_4000
 	tristate "Omnikey Cardman 4000 support"
--- a/drivers/char/pcmcia/synclink_cs.c	2006-06-09 09:47:46.000000000 -0500
+++ b/drivers/char/pcmcia/synclink_cs.c	2006-06-09 09:47:52.000000000 -0500
@@ -77,10 +77,6 @@
 #include <pcmcia/cisreg.h>
 #include <pcmcia/ds.h>
 
-#ifdef CONFIG_HDLC_MODULE
-#define CONFIG_HDLC 1
-#endif
-
 #define GET_USER(error,value,addr) error = get_user(value,addr)
 #define COPY_FROM_USER(error,dest,src,size) error = copy_from_user(dest,src,size) ? -EFAULT : 0
 #define PUT_USER(error,value,addr) error = put_user(value,addr)
@@ -237,7 +233,7 @@ typedef struct _mgslpc_info {
 	int dosyncppp;
 	spinlock_t netlock;
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 	struct net_device *netdev;
 #endif
 
@@ -394,7 +390,7 @@ static void tx_timeout(unsigned long con
 
 static int ioctl_common(MGSLPC_INFO *info, unsigned int cmd, unsigned long arg);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
 static void hdlcdev_tx_done(MGSLPC_INFO *info);
 static void hdlcdev_rx(MGSLPC_INFO *info, char *buf, int size);
@@ -1062,7 +1058,7 @@ static void tx_done(MGSLPC_INFO *info)
 		info->drop_rts_on_tx_done = 0;
 	}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else 
@@ -1173,7 +1169,7 @@ static void dcd_change(MGSLPC_INFO *info
 	}
 	else
 		info->input_signal_events.dcd_down++;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 	if (info->netcount)
 		hdlc_set_carrier(info->serial_signals & SerialSignal_DCD, info->netdev);
 #endif
@@ -2959,7 +2955,7 @@ static void mgslpc_add_device(MGSLPC_INF
 	printk( "SyncLink PC Card %s:IO=%04X IRQ=%d\n",
 		info->device_name, info->io_base, info->irq_level);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 	hdlcdev_init(info);
 #endif
 }
@@ -2975,7 +2971,7 @@ static void mgslpc_remove_device(MGSLPC_
 				last->next_device = info->next_device;
 			else
 				mgslpc_device_list = info->next_device;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 			hdlcdev_exit(info);
 #endif
 			release_resources(info);
@@ -3907,7 +3903,7 @@ static int rx_get_frame(MGSLPC_INFO *inf
 				return_frame = 1;
 		}
 		framesize = 0;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 		{
 			struct net_device_stats *stats = hdlc_stats(info->netdev);
 			stats->rx_errors++;
@@ -3941,7 +3937,7 @@ static int rx_get_frame(MGSLPC_INFO *inf
 				++framesize;
 			}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 			if (info->netcount)
 				hdlcdev_rx(info, buf->data, framesize);
 			else
@@ -4097,7 +4093,7 @@ static void tx_timeout(unsigned long con
 
 	spin_unlock_irqrestore(&info->lock,flags);
 	
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else
@@ -4105,7 +4101,7 @@ static void tx_timeout(unsigned long con
 		bh_transmit(info);
 }
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 
 /**
  * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
@@ -4522,5 +4518,5 @@ static void hdlcdev_exit(MGSLPC_INFO *in
 	info->netdev = NULL;
 }
 
-#endif /* CONFIG_HDLC */
+#endif /* CONFIG_SYNCLINK_CS_HDLC */
 
--- a/drivers/char/synclink.c	2006-06-09 09:47:46.000000000 -0500
+++ b/drivers/char/synclink.c	2006-06-09 09:47:52.000000000 -0500
@@ -103,10 +103,6 @@
 #include <linux/hdlc.h>
 #include <linux/dma-mapping.h>
 
-#ifdef CONFIG_HDLC_MODULE
-#define CONFIG_HDLC 1
-#endif
-
 #define GET_USER(error,value,addr) error = get_user(value,addr)
 #define COPY_FROM_USER(error,dest,src,size) error = copy_from_user(dest,src,size) ? -EFAULT : 0
 #define PUT_USER(error,value,addr) error = put_user(value,addr)
@@ -322,7 +318,7 @@ struct mgsl_struct {
 	int dosyncppp;
 	spinlock_t netlock;
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 	struct net_device *netdev;
 #endif
 };
@@ -730,7 +726,7 @@ static void usc_loopmode_send_done( stru
 
 static int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigned long arg);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
 static void hdlcdev_tx_done(struct mgsl_struct *info);
 static void hdlcdev_rx(struct mgsl_struct *info, char *buf, int size);
@@ -1278,7 +1274,7 @@ static void mgsl_isr_transmit_status( st
 		info->drop_rts_on_tx_done = 0;
 	}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else 
@@ -1343,7 +1339,7 @@ static void mgsl_isr_io_pin( struct mgsl
 				info->input_signal_events.dcd_up++;
 			} else
 				info->input_signal_events.dcd_down++;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 			if (info->netcount)
 				hdlc_set_carrier(status & MISCSTATUS_DCD, info->netdev);
 #endif
@@ -4311,7 +4307,7 @@ static void mgsl_add_device( struct mgsl
 		     	info->max_frame_size );
 	}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 	hdlcdev_init(info);
 #endif
 
@@ -4469,7 +4465,7 @@ static void synclink_cleanup(void)
 
 	info = mgsl_device_list;
 	while(info) {
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 		hdlcdev_exit(info);
 #endif
 		mgsl_release_resources(info);
@@ -6643,7 +6639,7 @@ static int mgsl_get_rx_frame(struct mgsl
 				return_frame = 1;
 		}
 		framesize = 0;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 		{
 			struct net_device_stats *stats = hdlc_stats(info->netdev);
 			stats->rx_errors++;
@@ -6719,7 +6715,7 @@ static int mgsl_get_rx_frame(struct mgsl
 						*ptmp);
 			}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 			if (info->netcount)
 				hdlcdev_rx(info,info->intermediate_rxbuffer,framesize);
 			else
@@ -7623,7 +7619,7 @@ static void mgsl_tx_timeout(unsigned lon
 
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 	
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else
@@ -7699,7 +7695,7 @@ static int usc_loopmode_active( struct m
  	return usc_InReg( info, CCSR ) & BIT7 ? 1 : 0 ;
 }
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 
 /**
  * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
@@ -8116,7 +8112,7 @@ static void hdlcdev_exit(struct mgsl_str
 	info->netdev = NULL;
 }
 
-#endif /* CONFIG_HDLC */
+#endif /* CONFIG_SYNCLINK_HDLC */
 
 
 static int __devinit synclink_init_one (struct pci_dev *dev,
--- a/drivers/char/synclink_gt.c	2006-06-09 09:47:46.000000000 -0500
+++ b/drivers/char/synclink_gt.c	2006-06-09 09:47:52.000000000 -0500
@@ -84,10 +84,6 @@
 
 #include "linux/synclink.h"
 
-#ifdef CONFIG_HDLC_MODULE
-#define CONFIG_HDLC 1
-#endif
-
 /*
  * module identification
  */
@@ -171,7 +167,7 @@ static void set_break(struct tty_struct 
 /*
  * generic HDLC support and callbacks
  */
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
 static void hdlcdev_tx_done(struct slgt_info *info);
 static void hdlcdev_rx(struct slgt_info *info, char *buf, int size);
@@ -359,7 +355,7 @@ struct slgt_info {
 	int netcount;
 	int dosyncppp;
 	spinlock_t netlock;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 	struct net_device *netdev;
 #endif
 
@@ -1352,7 +1348,7 @@ static void set_break(struct tty_struct 
 	spin_unlock_irqrestore(&info->lock,flags);
 }
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 
 /**
  * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
@@ -1765,7 +1761,7 @@ static void hdlcdev_exit(struct slgt_inf
 	info->netdev = NULL;
 }
 
-#endif /* ifdef CONFIG_HDLC */
+#endif /* ifdef CONFIG_SYNCLINK_GT_HDLC */
 
 /*
  * get async data from rx DMA buffers
@@ -1996,7 +1992,7 @@ static void dcd_change(struct slgt_info 
 	} else {
 		info->input_signal_events.dcd_down++;
 	}
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 	if (info->netcount)
 		hdlc_set_carrier(info->signals & SerialSignal_DCD, info->netdev);
 #endif
@@ -2170,7 +2166,7 @@ static void isr_txeom(struct slgt_info *
 			set_signals(info);
 		}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 		if (info->netcount)
 			hdlcdev_tx_done(info);
 		else
@@ -3290,7 +3286,7 @@ static void add_device(struct slgt_info 
 		devstr, info->device_name, info->phys_reg_addr,
 		info->irq_level, info->max_frame_size);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 	hdlcdev_init(info);
 #endif
 }
@@ -3470,7 +3466,7 @@ static void slgt_cleanup(void)
 	/* release devices */
 	info = slgt_device_list;
 	while(info) {
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 		hdlcdev_exit(info);
 #endif
 		free_dma_bufs(info);
@@ -4373,7 +4369,7 @@ check_again:
 			info->icount.rxcrc++;
 		framesize = 0;
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 		{
 			struct net_device_stats *stats = hdlc_stats(info->netdev);
 			stats->rx_errors++;
@@ -4413,7 +4409,7 @@ check_again:
 					i = 0;
 			}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 			if (info->netcount)
 				hdlcdev_rx(info,info->tmp_rbuf, framesize);
 			else
@@ -4700,7 +4696,7 @@ static void tx_timeout(unsigned long con
 	info->tx_count = 0;
 	spin_unlock_irqrestore(&info->lock,flags);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else
--- a/drivers/char/synclinkmp.c	2006-06-09 09:47:46.000000000 -0500
+++ b/drivers/char/synclinkmp.c	2006-06-09 09:47:52.000000000 -0500
@@ -68,10 +68,6 @@
 #include <linux/workqueue.h>
 #include <linux/hdlc.h>
 
-#ifdef CONFIG_HDLC_MODULE
-#define CONFIG_HDLC 1
-#endif
-
 #define GET_USER(error,value,addr) error = get_user(value,addr)
 #define COPY_FROM_USER(error,dest,src,size) error = copy_from_user(dest,src,size) ? -EFAULT : 0
 #define PUT_USER(error,value,addr) error = put_user(value,addr)
@@ -281,7 +277,7 @@ typedef struct _synclinkmp_info {
 	int dosyncppp;
 	spinlock_t netlock;
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 	struct net_device *netdev;
 #endif
 
@@ -537,7 +533,7 @@ static void throttle(struct tty_struct *
 static void unthrottle(struct tty_struct * tty);
 static void set_break(struct tty_struct *tty, int break_state);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
 static void hdlcdev_tx_done(SLMP_INFO *info);
 static void hdlcdev_rx(SLMP_INFO *info, char *buf, int size);
@@ -1608,7 +1604,7 @@ static void set_break(struct tty_struct 
 	spin_unlock_irqrestore(&info->lock,flags);
 }
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 
 /**
  * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
@@ -2025,7 +2021,7 @@ static void hdlcdev_exit(SLMP_INFO *info
 	info->netdev = NULL;
 }
 
-#endif /* CONFIG_HDLC */
+#endif /* CONFIG_SYNCLINKMP_HDLC */
 
 
 /* Return next bottom half action to perform.
@@ -2338,7 +2334,7 @@ static void isr_txeom(SLMP_INFO * info, 
 			set_signals(info);
 		}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 		if (info->netcount)
 			hdlcdev_tx_done(info);
 		else
@@ -2522,7 +2518,7 @@ void isr_io_pin( SLMP_INFO *info, u16 st
 				info->input_signal_events.dcd_up++;
 			} else
 				info->input_signal_events.dcd_down++;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 			if (info->netcount)
 				hdlc_set_carrier(status & SerialSignal_DCD, info->netdev);
 #endif
@@ -3779,7 +3775,7 @@ void add_device(SLMP_INFO *info)
 		info->irq_level,
 		info->max_frame_size );
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 	hdlcdev_init(info);
 #endif
 }
@@ -3973,7 +3969,7 @@ static void synclinkmp_cleanup(void)
 	/* release devices */
 	info = synclinkmp_device_list;
 	while(info) {
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 		hdlcdev_exit(info);
 #endif
 		free_dma_bufs(info);
@@ -4975,7 +4971,7 @@ CheckAgain:
 			info->icount.rxcrc++;
 
 		framesize = 0;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 		{
 			struct net_device_stats *stats = hdlc_stats(info->netdev);
 			stats->rx_errors++;
@@ -5016,7 +5012,7 @@ CheckAgain:
 					index = 0;
 			}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 			if (info->netcount)
 				hdlcdev_rx(info,info->tmp_rx_buf,framesize);
 			else
@@ -5527,7 +5523,7 @@ void tx_timeout(unsigned long context)
 
 	spin_unlock_irqrestore(&info->lock,flags);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else


