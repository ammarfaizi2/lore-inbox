Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWELPOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWELPOb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWELPOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:14:31 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:52369
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932120AbWELPOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:14:30 -0400
Subject: [PATCH] fix kbuild dependencies for synclink drivers
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 12 May 2006 10:14:08 -0500
Message-Id: <1147446848.10079.12.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kbuild dependencies for all synclink drivers
which can cause compile failures if generic HDLC
driver does not match the module/built-in status
of the dependent synclink driver. New variables
are introduced to selectively compile generic HDLC
support for individual synclink drivers with
reverse dependencies to correctly build generic HDLC.

fixes http://bugzilla.kernel.org/show_bug.cgi?id=6465 - 

--- linux-2.6.16/drivers/char/Kconfig	2006-05-12 08:57:17.000000000 -0500
+++ b/drivers/char/Kconfig	2006-05-12 09:22:13.000000000 -0500
@@ -194,40 +194,56 @@
 	  If you want to do that, choose M here.
 
 config SYNCLINK
-	tristate "Microgate SyncLink card support"
+	tristate "SyncLink PCI/ISA support"
 	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
+	select HDLC if SYNCLINK_HDLC
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
+	help
+	  Enable generic HDLC support for the SyncLink PCI/ISA driver.
+	  Generic HDLC implements multiple higher layer networking
+	  protocols for use with synchronous HDLC adapters.
 
 config SYNCLINKMP
 	tristate "SyncLink Multiport support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && PCI
+	select HDLC if SYNCLINKMP_HDLC
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
+	help
+	  Enable generic HDLC support for the SyncLink Multiport driver.
+	  Generic HDLC implements multiple higher layer networking
+	  protocols for use with synchronous HDLC adapters.
 
 config SYNCLINK_GT
 	tristate "SyncLink GT/AC support"
 	depends on SERIAL_NONSTANDARD && PCI
+	select HDLC if SYNCLINK_GT_HDLC
 	help
 	  Support for SyncLink GT and SyncLink AC families of
 	  synchronous and asynchronous serial adapters
 	  manufactured by Microgate Systems, Ltd. (www.microgate.com)
 
+config SYNCLINK_GT_HDLC
+	bool "Generic HDLC support for SyncLink GT/AC"
+	depends on SYNCLINK_GT
+	help
+	  Enable generic HDLC support for the SyncLink GT/AC driver.
+	  Generic HDLC implements multiple higher layer networking
+	  protocols for use with synchronous HDLC adapters.
+
 config N_HDLC
 	tristate "HDLC line discipline support"
 	depends on SERIAL_NONSTANDARD
--- linux-2.6.16/drivers/char/pcmcia/Kconfig	2006-03-19 23:53:29.000000000 -0600
+++ b/drivers/char/pcmcia/Kconfig	2006-05-12 09:22:39.000000000 -0500
@@ -8,15 +8,17 @@
 config SYNCLINK_CS
 	tristate "SyncLink PC Card support"
 	depends on PCMCIA
+	select HDLC if SYNCLINK_CS_HDLC
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
+	help
+	  Enable generic HDLC support for the SyncLink PC Card driver.
+	  Generic HDLC implements multiple higher layer networking
+	  protocols for use with synchronous HDLC adapters.
 
 config CARDMAN_4000
 	tristate "Omnikey Cardman 4000 support"
--- linux-2.6.16/drivers/char/synclink.c	2006-03-23 14:01:29.000000000 -0600
+++ b/drivers/char/synclink.c	2006-05-12 09:36:50.000000000 -0500
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
@@ -322,7 +318,7 @@
 	int dosyncppp;
 	spinlock_t netlock;
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 	struct net_device *netdev;
 #endif
 };
@@ -730,7 +726,7 @@
 
 static int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigned long arg);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
 static void hdlcdev_tx_done(struct mgsl_struct *info);
 static void hdlcdev_rx(struct mgsl_struct *info, char *buf, int size);
@@ -1278,7 +1274,7 @@
 		info->drop_rts_on_tx_done = 0;
 	}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else 
@@ -1343,7 +1339,7 @@
 				info->input_signal_events.dcd_up++;
 			} else
 				info->input_signal_events.dcd_down++;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 			if (info->netcount)
 				hdlc_set_carrier(status & MISCSTATUS_DCD, info->netdev);
 #endif
@@ -4311,7 +4307,7 @@
 		     	info->max_frame_size );
 	}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 	hdlcdev_init(info);
 #endif
 
@@ -4469,7 +4465,7 @@
 
 	info = mgsl_device_list;
 	while(info) {
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 		hdlcdev_exit(info);
 #endif
 		mgsl_release_resources(info);
@@ -6643,7 +6639,7 @@
 				return_frame = 1;
 		}
 		framesize = 0;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 		{
 			struct net_device_stats *stats = hdlc_stats(info->netdev);
 			stats->rx_errors++;
@@ -6719,7 +6715,7 @@
 						*ptmp);
 			}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 			if (info->netcount)
 				hdlcdev_rx(info,info->intermediate_rxbuffer,framesize);
 			else
@@ -7623,7 +7619,7 @@
 
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 	
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else
@@ -7699,7 +7695,7 @@
  	return usc_InReg( info, CCSR ) & BIT7 ? 1 : 0 ;
 }
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_HDLC
 
 /**
  * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
@@ -8116,7 +8112,7 @@
 	info->netdev = NULL;
 }
 
-#endif /* CONFIG_HDLC */
+#endif /* CONFIG_SYNCLINK_HDLC */
 
 
 static int __devinit synclink_init_one (struct pci_dev *dev,
--- linux-2.6.16/drivers/char/synclinkmp.c	2006-03-19 23:53:29.000000000 -0600
+++ b/drivers/char/synclinkmp.c	2006-05-12 09:37:24.000000000 -0500
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
@@ -281,7 +277,7 @@
 	int dosyncppp;
 	spinlock_t netlock;
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 	struct net_device *netdev;
 #endif
 
@@ -537,7 +533,7 @@
 static void unthrottle(struct tty_struct * tty);
 static void set_break(struct tty_struct *tty, int break_state);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
 static void hdlcdev_tx_done(SLMP_INFO *info);
 static void hdlcdev_rx(SLMP_INFO *info, char *buf, int size);
@@ -1608,7 +1604,7 @@
 	spin_unlock_irqrestore(&info->lock,flags);
 }
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 
 /**
  * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
@@ -2025,7 +2021,7 @@
 	info->netdev = NULL;
 }
 
-#endif /* CONFIG_HDLC */
+#endif /* CONFIG_SYNCLINKMP_HDLC */
 
 
 /* Return next bottom half action to perform.
@@ -2338,7 +2334,7 @@
 			set_signals(info);
 		}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 		if (info->netcount)
 			hdlcdev_tx_done(info);
 		else
@@ -2522,7 +2518,7 @@
 				info->input_signal_events.dcd_up++;
 			} else
 				info->input_signal_events.dcd_down++;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 			if (info->netcount)
 				hdlc_set_carrier(status & SerialSignal_DCD, info->netdev);
 #endif
@@ -3779,7 +3775,7 @@
 		info->irq_level,
 		info->max_frame_size );
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 	hdlcdev_init(info);
 #endif
 }
@@ -3973,7 +3969,7 @@
 	/* release devices */
 	info = synclinkmp_device_list;
 	while(info) {
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 		hdlcdev_exit(info);
 #endif
 		free_dma_bufs(info);
@@ -4975,7 +4971,7 @@
 			info->icount.rxcrc++;
 
 		framesize = 0;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 		{
 			struct net_device_stats *stats = hdlc_stats(info->netdev);
 			stats->rx_errors++;
@@ -5016,7 +5012,7 @@
 					index = 0;
 			}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 			if (info->netcount)
 				hdlcdev_rx(info,info->tmp_rx_buf,framesize);
 			else
@@ -5527,7 +5523,7 @@
 
 	spin_unlock_irqrestore(&info->lock,flags);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINKMP_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else
--- linux-2.6.16/drivers/char/synclink_gt.c	2006-03-24 10:23:31.000000000 -0600
+++ b/drivers/char/synclink_gt.c	2006-05-12 09:38:00.000000000 -0500
@@ -84,10 +84,6 @@
 
 #include "linux/synclink.h"
 
-#ifdef CONFIG_HDLC_MODULE
-#define CONFIG_HDLC 1
-#endif
-
 /*
  * module identification
  */
@@ -171,7 +167,7 @@
 /*
  * generic HDLC support and callbacks
  */
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
 static void hdlcdev_tx_done(struct slgt_info *info);
 static void hdlcdev_rx(struct slgt_info *info, char *buf, int size);
@@ -342,7 +338,7 @@
 	int netcount;
 	int dosyncppp;
 	spinlock_t netlock;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 	struct net_device *netdev;
 #endif
 
@@ -1321,7 +1317,7 @@
 	spin_unlock_irqrestore(&info->lock,flags);
 }
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 
 /**
  * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
@@ -1734,7 +1730,7 @@
 	info->netdev = NULL;
 }
 
-#endif /* ifdef CONFIG_HDLC */
+#endif /* ifdef CONFIG_SYNCLINK_GT_HDLC */
 
 /*
  * get async data from rx DMA buffers
@@ -1965,7 +1961,7 @@
 	} else {
 		info->input_signal_events.dcd_down++;
 	}
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 	if (info->netcount)
 		hdlc_set_carrier(info->signals & SerialSignal_DCD, info->netdev);
 #endif
@@ -2139,7 +2135,7 @@
 			set_signals(info);
 		}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 		if (info->netcount)
 			hdlcdev_tx_done(info);
 		else
@@ -3054,7 +3050,7 @@
 		devstr, info->device_name, info->phys_reg_addr,
 		info->irq_level, info->max_frame_size);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 	hdlcdev_init(info);
 #endif
 }
@@ -3232,7 +3228,7 @@
 	/* release devices */
 	info = slgt_device_list;
 	while(info) {
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 		hdlcdev_exit(info);
 #endif
 		free_dma_bufs(info);
@@ -4135,7 +4131,7 @@
 			info->icount.rxcrc++;
 		framesize = 0;
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 		{
 			struct net_device_stats *stats = hdlc_stats(info->netdev);
 			stats->rx_errors++;
@@ -4175,7 +4171,7 @@
 					i = 0;
 			}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 			if (info->netcount)
 				hdlcdev_rx(info,info->tmp_rbuf, framesize);
 			else
@@ -4462,7 +4458,7 @@
 	info->tx_count = 0;
 	spin_unlock_irqrestore(&info->lock,flags);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_GT_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else
--- linux-2.6.16/drivers/char/pcmcia/synclink_cs.c	2006-03-19 23:53:29.000000000 -0600
+++ b/drivers/char/pcmcia/synclink_cs.c	2006-05-12 09:38:29.000000000 -0500
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
@@ -237,7 +233,7 @@
 	int dosyncppp;
 	spinlock_t netlock;
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 	struct net_device *netdev;
 #endif
 
@@ -394,7 +390,7 @@
 
 static int ioctl_common(MGSLPC_INFO *info, unsigned int cmd, unsigned long arg);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
 static void hdlcdev_tx_done(MGSLPC_INFO *info);
 static void hdlcdev_rx(MGSLPC_INFO *info, char *buf, int size);
@@ -1096,7 +1092,7 @@
 		info->drop_rts_on_tx_done = 0;
 	}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else 
@@ -1207,7 +1203,7 @@
 	}
 	else
 		info->input_signal_events.dcd_down++;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 	if (info->netcount)
 		hdlc_set_carrier(info->serial_signals & SerialSignal_DCD, info->netdev);
 #endif
@@ -2993,7 +2989,7 @@
 	printk( "SyncLink PC Card %s:IO=%04X IRQ=%d\n",
 		info->device_name, info->io_base, info->irq_level);
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 	hdlcdev_init(info);
 #endif
 }
@@ -3009,7 +3005,7 @@
 				last->next_device = info->next_device;
 			else
 				mgslpc_device_list = info->next_device;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 			hdlcdev_exit(info);
 #endif
 			release_resources(info);
@@ -3941,7 +3937,7 @@
 				return_frame = 1;
 		}
 		framesize = 0;
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 		{
 			struct net_device_stats *stats = hdlc_stats(info->netdev);
 			stats->rx_errors++;
@@ -3975,7 +3971,7 @@
 				++framesize;
 			}
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 			if (info->netcount)
 				hdlcdev_rx(info, buf->data, framesize);
 			else
@@ -4131,7 +4127,7 @@
 
 	spin_unlock_irqrestore(&info->lock,flags);
 	
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 	if (info->netcount)
 		hdlcdev_tx_done(info);
 	else
@@ -4139,7 +4135,7 @@
 		bh_transmit(info);
 }
 
-#ifdef CONFIG_HDLC
+#ifdef CONFIG_SYNCLINK_CS_HDLC
 
 /**
  * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
@@ -4556,5 +4552,5 @@
 	info->netdev = NULL;
 }
 
-#endif /* CONFIG_HDLC */
+#endif /* CONFIG_SYNCLINK_CS_HDLC */
 


