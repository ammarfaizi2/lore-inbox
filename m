Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317638AbSFRV5w>; Tue, 18 Jun 2002 17:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317640AbSFRV5u>; Tue, 18 Jun 2002 17:57:50 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:50409 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317638AbSFRV47>;
	Tue, 18 Jun 2002 17:56:59 -0400
Date: Tue, 18 Jun 2002 14:56:56 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir252_headers_init-2.diff
Message-ID: <20020618145655.A7819@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

	Re-diff'd and re-tested my patches with 2.5.22, but otherwise
exact same content. First patch here, second in a second. Hope they
will make it proper in 2.5.23.
	Regards,

	Jean


ir252_headers_init-2.diff :
-------------------------
	o [FEATURE] Use new kernel init/exit style, should fix static builds
	o [FEATURE] Reduce header dependancies
						Before	After
		net/irda/.depend		14917	13617 B
		drivers/net/irda/.depend	16134	14293 B
		irda full recompile		3'13	3'10



diff -u -p --new-file linux/include/net/irda.d9/af_irda.h linux/include/net/irda/af_irda.h
--- linux/include/net/irda.d9/af_irda.h	Wed Dec 31 16:00:00 1969
+++ linux/include/net/irda/af_irda.h	Tue Jun 18 13:51:36 2002
@@ -0,0 +1,82 @@
+/*********************************************************************
+ *                
+ * Filename:      af_irda.h
+ * Version:       1.0
+ * Description:   IrDA sockets declarations
+ * Status:        Stable
+ * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Created at:    Tue Dec  9 21:13:12 1997
+ * Modified at:   Fri Jan 28 13:16:32 2000
+ * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * 
+ *     Copyright (c) 1998-2000 Dag Brattli, All Rights Reserved.
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
+ *      
+ *     This program is free software; you can redistribute it and/or 
+ *     modify it under the terms of the GNU General Public License as 
+ *     published by the Free Software Foundation; either version 2 of 
+ *     the License, or (at your option) any later version.
+ *  
+ *     Neither Dag Brattli nor University of Tromsø admit liability nor
+ *     provide warranty for any of this software. This material is 
+ *     provided "AS-IS" and at no charge.
+ *     
+ ********************************************************************/
+
+#ifndef AF_IRDA_H
+#define AF_IRDA_H
+
+#include <linux/irda.h>
+#include <net/irda/irda.h>
+#include <net/irda/iriap.h>		/* struct iriap_cb */
+#include <net/irda/irias_object.h>	/* struct ias_value */
+#include <net/irda/irlmp.h>		/* struct lsap_cb */
+#include <net/irda/irttp.h>		/* struct tsap_cb */
+#include <net/irda/discovery.h>		/* struct discovery_t */
+
+/* IrDA Socket */
+struct irda_sock {
+	__u32 saddr;          /* my local address */
+	__u32 daddr;          /* peer address */
+
+	struct lsap_cb *lsap; /* LSAP used by Ultra */
+	__u8  pid;            /* Protocol IP (PID) used by Ultra */
+
+	struct tsap_cb *tsap; /* TSAP used by this connection */
+	__u8 dtsap_sel;       /* remote TSAP address */
+	__u8 stsap_sel;       /* local TSAP address */
+	
+	__u32 max_sdu_size_rx;
+	__u32 max_sdu_size_tx;
+	__u32 max_data_size;
+	__u8  max_header_size;
+	struct qos_info qos_tx;
+
+	__u16 mask;           /* Hint bits mask */
+	__u16 hints;          /* Hint bits */
+
+	__u32 ckey;           /* IrLMP client handle */
+	__u32 skey;           /* IrLMP service handle */
+
+	struct ias_object *ias_obj;   /* Our service name + lsap in IAS */
+	struct iriap_cb *iriap;	      /* Used to query remote IAS */
+	struct ias_value *ias_result; /* Result of remote IAS query */
+
+	hashbin_t *cachelog;		/* Result of discovery query */
+	struct discovery_t *cachediscovery;	/* Result of selective discovery query */
+
+	int nslots;           /* Number of slots to use for discovery */
+
+	int errno;            /* status of the IAS query */
+
+	struct sock *sk;
+	wait_queue_head_t query_wait;	/* Wait for the answer to a query */
+	struct timer_list watchdog;	/* Timeout for discovery */
+
+	LOCAL_FLOW tx_flow;
+	LOCAL_FLOW rx_flow;
+};
+
+#define irda_sk(__sk) ((struct irda_sock *)(__sk)->protinfo)
+
+#endif /* AF_IRDA_H */
diff -u -p --new-file linux/include/net/irda.d9/discovery.h linux/include/net/irda/discovery.h
--- linux/include/net/irda.d9/discovery.h	Tue Jun 18 11:59:20 2002
+++ linux/include/net/irda/discovery.h	Tue Jun 18 13:57:31 2002
@@ -10,6 +10,7 @@
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -34,10 +35,22 @@
 #include <asm/param.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irqueue.h>
+#include <net/irda/irqueue.h>		/* irda_queue_t */
+#include <net/irda/irlap_event.h>	/* LAP_REASON */
 
 #define DISCOVERY_EXPIRE_TIMEOUT (2*sysctl_discovery_timeout*HZ)
 #define DISCOVERY_DEFAULT_SLOTS  0
+
+/*
+ *  This type is used by the protocols that transmit 16 bits words in 
+ *  little endian format. A little endian machine stores MSB of word in
+ *  byte[1] and LSB in byte[0]. A big endian machine stores MSB in byte[0] 
+ *  and LSB in byte[1].
+ */
+typedef union {
+	__u16 word;
+	__u8  byte[2];
+} __u16_host_order;
 
 /* Types of discovery */
 typedef enum {
diff -u -p --new-file linux/include/net/irda.d9/ircomm_core.h linux/include/net/irda/ircomm_core.h
--- linux/include/net/irda.d9/ircomm_core.h	Sat Jun  8 22:28:04 2002
+++ linux/include/net/irda/ircomm_core.h	Tue Jun 18 13:51:36 2002
@@ -32,6 +32,7 @@
 #define IRCOMM_CORE_H
 
 #include <net/irda/irda.h>
+#include <net/irda/irqueue.h>
 #include <net/irda/ircomm_event.h>
 
 #define IRCOMM_MAGIC 0x98347298
diff -u -p --new-file linux/include/net/irda.d9/ircomm_event.h linux/include/net/irda/ircomm_event.h
--- linux/include/net/irda.d9/ircomm_event.h	Sat Jun  8 22:29:46 2002
+++ linux/include/net/irda/ircomm_event.h	Tue Jun 18 13:51:36 2002
@@ -31,6 +31,8 @@
 #ifndef IRCOMM_EVENT_H
 #define IRCOMM_EVENT_H
 
+#include <net/irda/irmod.h>
+
 typedef enum {
         IRCOMM_IDLE,
         IRCOMM_WAITI,
diff -u -p --new-file linux/include/net/irda.d9/ircomm_tty.h linux/include/net/irda/ircomm_tty.h
--- linux/include/net/irda.d9/ircomm_tty.h	Sat Jun  8 22:29:14 2002
+++ linux/include/net/irda/ircomm_tty.h	Tue Jun 18 13:51:36 2002
@@ -34,6 +34,7 @@
 #include <linux/serial.h>
 #include <linux/termios.h>
 #include <linux/timer.h>
+#include <linux/tty.h>		/* struct tty_struct */
 
 #include <net/irda/irias_object.h>
 #include <net/irda/ircomm_core.h>
diff -u -p --new-file linux/include/net/irda.d9/irda-usb.h linux/include/net/irda/irda-usb.h
--- linux/include/net/irda.d9/irda-usb.h	Sat Jun  8 22:31:20 2002
+++ linux/include/net/irda/irda-usb.h	Tue Jun 18 13:51:36 2002
@@ -29,8 +29,7 @@
 #include <linux/time.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irlap.h>
-#include <net/irda/irda_device.h>
+#include <net/irda/irda_device.h>      /* struct irlap_cb */
 
 #define RX_COPY_THRESHOLD 200
 #define IRDA_USB_MAX_MTU 2051
diff -u -p --new-file linux/include/net/irda.d9/irda.h linux/include/net/irda/irda.h
--- linux/include/net/irda.d9/irda.h	Sat Jun  8 22:28:49 2002
+++ linux/include/net/irda/irda.h	Tue Jun 18 13:51:36 2002
@@ -10,7 +10,7 @@
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
  * 
  *     Copyright (c) 1998-2000 Dag Brattli, All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *      
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -27,16 +27,13 @@
 #define NET_IRDA_H
 
 #include <linux/config.h>
-#include <linux/skbuff.h>
+#include <linux/skbuff.h>		/* struct sk_buff */
 #include <linux/kernel.h>
-#include <linux/if.h>
+#include <linux/if.h>			/* sa_family_t in <linux/irda.h> */
 #include <linux/irda.h>
 
 typedef __u32 magic_t;
 
-#include <net/irda/qos.h>
-#include <net/irda/irqueue.h>
-
 #ifndef TRUE
 #define TRUE 1
 #endif
@@ -57,8 +54,8 @@ typedef __u32 magic_t;
 #ifndef IRDA_ALIGN
 #  define IRDA_ALIGN __attribute__((aligned))
 #endif
-#ifndef PACK
-#  define PACK __attribute__((packed))
+#ifndef IRDA_PACK
+#  define IRDA_PACK __attribute__((packed))
 #endif
 
 
@@ -115,152 +112,5 @@ if(!(expr)) do { \
 #define IAS_IRLAN_ID  0x34234
 #define IAS_IRCOMM_ID 0x2343
 #define IAS_IRLPT_ID  0x9876
-
-typedef enum { FLOW_STOP, FLOW_START } LOCAL_FLOW;
-
-/* A few forward declarations (to make compiler happy) */
-struct tsap_cb;		/* in <net/irda/irttp.h> */
-struct lsap_cb;		/* in <net/irda/irlmp.h> */
-struct iriap_cb;	/* in <net/irda/iriap.h> */
-struct ias_value;	/* in <net/irda/irias_object.h> */
-struct discovery_t;	/* in <net/irda/discovery.h> */
-
-/* IrDA Socket */
-struct irda_sock {
-	__u32 saddr;          /* my local address */
-	__u32 daddr;          /* peer address */
-
-	struct lsap_cb *lsap; /* LSAP used by Ultra */
-	__u8  pid;            /* Protocol IP (PID) used by Ultra */
-
-	struct tsap_cb *tsap; /* TSAP used by this connection */
-	__u8 dtsap_sel;       /* remote TSAP address */
-	__u8 stsap_sel;       /* local TSAP address */
-	
-	__u32 max_sdu_size_rx;
-	__u32 max_sdu_size_tx;
-	__u32 max_data_size;
-	__u8  max_header_size;
-	struct qos_info qos_tx;
-
-	__u16 mask;           /* Hint bits mask */
-	__u16 hints;          /* Hint bits */
-
-	__u32 ckey;           /* IrLMP client handle */
-	__u32 skey;           /* IrLMP service handle */
-
-	struct ias_object *ias_obj;   /* Our service name + lsap in IAS */
-	struct iriap_cb *iriap;	      /* Used to query remote IAS */
-	struct ias_value *ias_result; /* Result of remote IAS query */
-
-	hashbin_t *cachelog;		/* Result of discovery query */
-	struct discovery_t *cachediscovery;	/* Result of selective discovery query */
-
-	int nslots;           /* Number of slots to use for discovery */
-
-	int errno;            /* status of the IAS query */
-
-	struct sock *sk;
-	wait_queue_head_t query_wait;	/* Wait for the answer to a query */
-	struct timer_list watchdog;	/* Timeout for discovery */
-
-	LOCAL_FLOW tx_flow;
-	LOCAL_FLOW rx_flow;
-};
-
-#define irda_sk(__sk) ((struct irda_sock *)(__sk)->protinfo)
-
-/*
- *  This type is used by the protocols that transmit 16 bits words in 
- *  little endian format. A little endian machine stores MSB of word in
- *  byte[1] and LSB in byte[0]. A big endian machine stores MSB in byte[0] 
- *  and LSB in byte[1].
- */
-typedef union {
-	__u16 word;
-	__u8  byte[2];
-} __u16_host_order;
-
-/* 
- * Per-packet information we need to hide inside sk_buff 
- * (must not exceed 48 bytes, check with struct sk_buff) 
- */
-struct irda_skb_cb {
-	magic_t magic;       /* Be sure that we can trust the information */
-	__u32   next_speed;  /* The Speed to be set *after* this frame */
-	__u16   mtt;         /* Minimum turn around time */
-	__u16   xbofs;       /* Number of xbofs required, used by SIR mode */
-	__u16   next_xbofs;  /* Number of xbofs required *after* this frame */
-	void    *context;    /* May be used by drivers */
-	void    (*destructor)(struct sk_buff *skb); /* Used for flow control */
-	__u16   xbofs_delay; /* Number of xbofs used for generating the mtt */
-	__u8    line;        /* Used by IrCOMM in IrLPT mode */
-};
-
-/* Misc status information */
-typedef enum {
-	STATUS_OK,
-	STATUS_ABORTED,
-	STATUS_NO_ACTIVITY,
-	STATUS_NOISY,
-	STATUS_REMOTE,
-} LINK_STATUS;
-
-typedef enum {
-	LOCK_NO_CHANGE,
-	LOCK_LOCKED,
-	LOCK_UNLOCKED,
-} LOCK_STATUS;
-
-typedef enum { /* FIXME check the two first reason codes */
-	LAP_DISC_INDICATION=1, /* Received a disconnect request from peer */
-	LAP_NO_RESPONSE,       /* To many retransmits without response */
-	LAP_RESET_INDICATION,  /* To many retransmits, or invalid nr/ns */
-	LAP_FOUND_NONE,        /* No devices were discovered */
-	LAP_MEDIA_BUSY,
-	LAP_PRIMARY_CONFLICT,
-} LAP_REASON;
-
-/*  
- *  IrLMP disconnect reasons. The order is very important, since they 
- *  correspond to disconnect reasons sent in IrLMP disconnect frames, so
- *  please do not touch :-)
- */
-typedef enum {
-	LM_USER_REQUEST = 1,  /* User request */
-	LM_LAP_DISCONNECT,    /* Unexpected IrLAP disconnect */
-	LM_CONNECT_FAILURE,   /* Failed to establish IrLAP connection */
-	LM_LAP_RESET,         /* IrLAP reset */
-	LM_INIT_DISCONNECT,   /* Link Management initiated disconnect */
-	LM_LSAP_NOTCONN,      /* Data delivered on unconnected LSAP */
-	LM_NON_RESP_CLIENT,   /* Non responsive LM-MUX client */
-	LM_NO_AVAIL_CLIENT,   /* No available LM-MUX client */
-	LM_CONN_HALF_OPEN,    /* Connection is half open */
-	LM_BAD_SOURCE_ADDR,   /* Illegal source address (i.e 0x00) */
-} LM_REASON;
-#define LM_UNKNOWN 0xff       /* Unspecified disconnect reason */
-
-/*
- *  Notify structure used between transport and link management layers
- */
-typedef struct {
-	int (*data_indication)(void *priv, void *sap, struct sk_buff *skb);
-	int (*udata_indication)(void *priv, void *sap, struct sk_buff *skb);
-	void (*connect_confirm)(void *instance, void *sap, 
-				struct qos_info *qos, __u32 max_sdu_size,
-				__u8 max_header_size, struct sk_buff *skb);
-	void (*connect_indication)(void *instance, void *sap, 
-				   struct qos_info *qos, __u32 max_sdu_size, 
-				   __u8 max_header_size, struct sk_buff *skb);
-	void (*disconnect_indication)(void *instance, void *sap, 
-				      LM_REASON reason, struct sk_buff *);
-	void (*flow_indication)(void *instance, void *sap, LOCAL_FLOW flow);
-	void (*status_indication)(void *instance,
-				  LINK_STATUS link, LOCK_STATUS lock);
-	void *instance; /* Layer instance pointer */
-	char name[16];  /* Name of layer */
-} notify_t;
-
-#define NOTIFY_MAX_NAME 16
 
 #endif /* NET_IRDA_H */
diff -u -p --new-file linux/include/net/irda.d9/irda_device.h linux/include/net/irda/irda_device.h
--- linux/include/net/irda.d9/irda_device.h	Sat Jun  8 22:30:19 2002
+++ linux/include/net/irda/irda_device.h	Tue Jun 18 13:51:36 2002
@@ -11,6 +11,7 @@
  * 
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 1998 Thomas Davis, <ratbert@radiks.net>,
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -29,18 +30,27 @@
  *     
  ********************************************************************/
 
+/*
+ * This header contains all the IrDA definitions a driver really
+ * needs, and therefore the driver should not need to include
+ * any other IrDA headers - Jean II
+ */
+
 #ifndef IRDA_DEVICE_H
 #define IRDA_DEVICE_H
 
 #include <linux/tty.h>
 #include <linux/netdevice.h>
 #include <linux/spinlock.h>
+#include <linux/skbuff.h>		/* struct sk_buff */
 #include <linux/irda.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/qos.h>
-#include <net/irda/irqueue.h>
-#include <net/irda/irlap_frame.h>
+#include <net/irda/qos.h>		/* struct qos_info */
+#include <net/irda/irqueue.h>		/* irda_queue_t */
+
+/* A few forward declarations (to make compiler happy) */
+struct irlap_cb;
 
 /* Some non-standard interface flags (should not conflict with any in if.h) */
 #define IFF_SIR 	0x0001 /* Supports SIR speeds */
@@ -120,6 +130,22 @@ struct dongle_reg {
 	int  (*change_speed)(struct irda_task *task);
 };
 
+/* 
+ * Per-packet information we need to hide inside sk_buff 
+ * (must not exceed 48 bytes, check with struct sk_buff) 
+ */
+struct irda_skb_cb {
+	magic_t magic;       /* Be sure that we can trust the information */
+	__u32   next_speed;  /* The Speed to be set *after* this frame */
+	__u16   mtt;         /* Minimum turn around time */
+	__u16   xbofs;       /* Number of xbofs required, used by SIR mode */
+	__u16   next_xbofs;  /* Number of xbofs required *after* this frame */
+	void    *context;    /* May be used by drivers */
+	void    (*destructor)(struct sk_buff *skb); /* Used for flow control */
+	__u16   xbofs_delay; /* Number of xbofs used for generating the mtt */
+	__u8    line;        /* Used by IrCOMM in IrLPT mode */
+};
+
 /* Chip specific info */
 typedef struct {
 	int cfg_base;         /* Config register IO base */
@@ -157,6 +183,13 @@ typedef struct {
 /* Function prototypes */
 int  irda_device_init(void);
 void irda_device_cleanup(void);
+
+/* IrLAP entry points used by the drivers.
+ * We declare them here to avoid the driver pulling a whole bunch stack
+ * headers they don't really need - Jean II */
+struct irlap_cb *irlap_open(struct net_device *dev, struct qos_info *qos,
+			    char *	hw_name);
+void irlap_close(struct irlap_cb *self);
 
 /* Interface to be uses by IrLAP */
 void irda_device_set_media_busy(struct net_device *dev, int status);
diff -u -p --new-file linux/include/net/irda.d9/iriap.h linux/include/net/irda/iriap.h
--- linux/include/net/irda.d9/iriap.h	Sat Jun  8 22:28:28 2002
+++ linux/include/net/irda/iriap.h	Tue Jun 18 13:51:36 2002
@@ -29,11 +29,10 @@
 #include <linux/types.h>
 #include <linux/skbuff.h>
 
-#include <net/irda/qos.h>
 #include <net/irda/iriap_event.h>
 #include <net/irda/irias_object.h>
-#include <net/irda/irqueue.h>
-#include <net/irda/timer.h>
+#include <net/irda/irqueue.h>		/* irda_queue_t */
+#include <net/irda/timer.h>		/* struct timer_list */
 
 #define IAP_LST 0x80
 #define IAP_ACK 0x40
diff -u -p --new-file linux/include/net/irda.d9/irlap.h linux/include/net/irda/irlap.h
--- linux/include/net/irda.d9/irlap.h	Sat Jun  8 22:29:16 2002
+++ linux/include/net/irda/irlap.h	Tue Jun 18 13:51:36 2002
@@ -11,7 +11,7 @@
  * 
  *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
  *     All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -33,7 +33,11 @@
 #include <linux/netdevice.h>
 #include <linux/timer.h>
 
-#include <net/irda/irlap_event.h>
+#include <net/irda/irqueue.h>		/* irda_queue_t */
+#include <net/irda/qos.h>		/* struct qos_info */
+#include <net/irda/discovery.h>		/* discovery_t */
+#include <net/irda/irlap_event.h>	/* IRLAP_STATE, ... */
+#include <net/irda/irmod.h>		/* struct notify_t */
 
 #define CONFIG_IRDA_DYNAMIC_WINDOW 1
 
@@ -84,6 +88,29 @@
 #define NS_EXPECTED     1
 #define NS_UNEXPECTED   0
 #define NS_INVALID     -1
+
+/*
+ *  Meta information passed within the IrLAP state machine
+ */
+struct irlap_info {
+	__u8 caddr;   /* Connection address */
+	__u8 control; /* Frame type */
+        __u8 cmd;
+
+	__u32 saddr;
+	__u32 daddr;
+	
+	int pf;        /* Poll/final bit set */
+
+	__u8  nr;      /* Sequence number of next frame expected */
+	__u8  ns;      /* Sequence number of frame sent */
+
+	int  S;        /* Number of slots */
+	int  slot;     /* Random chosen slot */
+	int  s;        /* Current slot */
+
+	discovery_t *discovery; /* Discovery information */
+};
 
 /* Main structure of IrLAP */
 struct irlap_cb {
diff -u -p --new-file linux/include/net/irda.d9/irlap_event.h linux/include/net/irda/irlap_event.h
--- linux/include/net/irda.d9/irlap_event.h	Sat Jun  8 22:26:22 2002
+++ linux/include/net/irda/irlap_event.h	Tue Jun 18 13:51:36 2002
@@ -12,7 +12,7 @@
  * 
  *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
  *     All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -35,9 +35,10 @@
 #define IRLAP_EVENT_H
 
 #include <net/irda/irda.h>
-#include <net/irda/discovery.h>
 
+/* A few forward declarations (to make compiler happy) */
 struct irlap_cb;
+struct irlap_info;
 
 /* IrLAP States */
 typedef enum {
@@ -108,27 +109,16 @@ typedef enum {
 } IRLAP_EVENT;
 
 /*
- *  Various things used by the IrLAP state machine
+ * Disconnect reason code
  */
-struct irlap_info {
-	__u8 caddr;   /* Connection address */
-	__u8 control; /* Frame type */
-        __u8 cmd;
-
-	__u32 saddr;
-	__u32 daddr;
-	
-	int pf;        /* Poll/final bit set */
-
-	__u8  nr;      /* Sequence number of next frame expected */
-	__u8  ns;      /* Sequence number of frame sent */
-
-	int  S;        /* Number of slots */
-	int  slot;     /* Random chosen slot */
-	int  s;        /* Current slot */
-
-	discovery_t *discovery; /* Discovery information */
-};
+typedef enum { /* FIXME check the two first reason codes */
+	LAP_DISC_INDICATION=1, /* Received a disconnect request from peer */
+	LAP_NO_RESPONSE,       /* To many retransmits without response */
+	LAP_RESET_INDICATION,  /* To many retransmits, or invalid nr/ns */
+	LAP_FOUND_NONE,        /* No devices were discovered */
+	LAP_MEDIA_BUSY,
+	LAP_PRIMARY_CONFLICT,
+} LAP_REASON;
 
 extern const char *irlap_state[];
 
diff -u -p --new-file linux/include/net/irda.d9/irlap_frame.h linux/include/net/irda/irlap_frame.h
--- linux/include/net/irda.d9/irlap_frame.h	Sat Jun  8 22:26:27 2002
+++ linux/include/net/irda/irlap_frame.h	Tue Jun 18 13:51:36 2002
@@ -11,6 +11,7 @@
  * 
  *     Copyright (c) 1997-1999 Dag Brattli <dagb@cs.uit.no>,
  *     All Rights Reserved.
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -35,8 +36,10 @@
 #include <linux/skbuff.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irlap.h>
-#include <net/irda/qos.h>
+
+/* A few forward declarations (to make compiler happy) */
+struct irlap_cb;
+struct discovery_t;
 
 /* Frame types and templates */
 #define INVALID   0xff
@@ -80,14 +83,14 @@ struct xid_frame {
 	__u8  flags; /* Discovery flags */
 	__u8  slotnr;
 	__u8  version;
-} PACK;
+} IRDA_PACK;
 
 struct test_frame {
 	__u8 caddr;          /* Connection address */
 	__u8 control;
 	__u32 saddr;         /* Source device address */
 	__u32 daddr;         /* Destination device address */
-} PACK;
+} IRDA_PACK;
 
 struct ua_frame {
 	__u8 caddr;
@@ -95,12 +98,12 @@ struct ua_frame {
 
 	__u32 saddr; /* Source device address */
 	__u32 daddr; /* Dest device address */
-} PACK;
+} IRDA_PACK;
 	
 struct i_frame {
 	__u8 caddr;
 	__u8 control;
-} PACK;
+} IRDA_PACK;
 
 struct snrm_frame {
 	__u8  caddr;
@@ -108,11 +111,12 @@ struct snrm_frame {
 	__u32 saddr;
 	__u32 daddr;
 	__u8  ncaddr;
-} PACK;
+} IRDA_PACK;
 
 void irlap_queue_xmit(struct irlap_cb *self, struct sk_buff *skb);
 void irlap_send_discovery_xid_frame(struct irlap_cb *, int S, __u8 s, 
-				    __u8 command, discovery_t *discovery);
+				    __u8 command,
+				    struct discovery_t *discovery);
 void irlap_send_snrm_frame(struct irlap_cb *, struct qos_info *);
 void irlap_send_test_frame(struct irlap_cb *self, __u8 caddr, __u32 daddr, 
 			   struct sk_buff *cmd);
diff -u -p --new-file linux/include/net/irda.d9/irlmp.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda.d9/irlmp.h	Sat Jun  8 22:26:34 2002
+++ linux/include/net/irda/irlmp.h	Tue Jun 18 13:51:36 2002
@@ -11,7 +11,7 @@
  * 
  *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
  *     All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -34,7 +34,7 @@
 
 #include <net/irda/irda.h>
 #include <net/irda/qos.h>
-#include <net/irda/irlap.h>
+#include <net/irda/irlap.h>		/* LAP_MAX_HEADER, ... */
 #include <net/irda/irlmp_event.h>
 #include <net/irda/irqueue.h>
 #include <net/irda/discovery.h>
@@ -90,8 +90,6 @@ typedef struct {
 	DISCOVERY_CALLBACK1 expir_callback;	/* Selective expiration */
 	void *priv;                /* Used to identify client */
 } irlmp_client_t;
-
-struct lap_cb; /* Forward decl. */
 
 /*
  *  Information about each logical LSAP connection
diff -u -p --new-file linux/include/net/irda.d9/irlmp_event.h linux/include/net/irda/irlmp_event.h
--- linux/include/net/irda.d9/irlmp_event.h	Sat Jun  8 22:30:03 2002
+++ linux/include/net/irda/irlmp_event.h	Tue Jun 18 13:51:36 2002
@@ -11,7 +11,7 @@
  * 
  *     Copyright (c) 1997, 1999 Dag Brattli <dagb@cs.uit.no>, 
  *     All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -27,9 +27,11 @@
 #ifndef IRLMP_EVENT_H
 #define IRLMP_EVENT_H
 
+/* A few forward declarations (to make compiler happy) */
 struct irlmp_cb;
 struct lsap_cb;
 struct lap_cb;
+struct discovery_t;
 
 /* LAP states */
 typedef enum {
@@ -94,7 +96,7 @@ struct irlmp_event {
 
 	int reason;
 
-	discovery_t *discovery;
+	struct discovery_t *discovery;
 };
 
 extern const char *irlmp_state[];
diff -u -p --new-file linux/include/net/irda.d9/irmod.h linux/include/net/irda/irmod.h
--- linux/include/net/irda.d9/irmod.h	Sat Jun  8 22:31:31 2002
+++ linux/include/net/irda/irmod.h	Tue Jun 18 13:51:36 2002
@@ -10,7 +10,7 @@
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
  *
  *     Copyright (c) 1998-2000 Dag Brattli, All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *      
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -26,19 +26,76 @@
 #ifndef IRMOD_H
 #define IRMOD_H
 
-#include <net/irda/irda.h>		/* Notify stuff */
+/* Misc status information */
+typedef enum {
+	STATUS_OK,
+	STATUS_ABORTED,
+	STATUS_NO_ACTIVITY,
+	STATUS_NOISY,
+	STATUS_REMOTE,
+} LINK_STATUS;
 
-/* Nothing much here anymore - Maybe this header should be merged in
- * another header like net/irda/irda.h... - Jean II */
+typedef enum {
+	LOCK_NO_CHANGE,
+	LOCK_LOCKED,
+	LOCK_UNLOCKED,
+} LOCK_STATUS;
+
+typedef enum { FLOW_STOP, FLOW_START } LOCAL_FLOW;
+
+/*  
+ *  IrLMP disconnect reasons. The order is very important, since they 
+ *  correspond to disconnect reasons sent in IrLMP disconnect frames, so
+ *  please do not touch :-)
+ */
+typedef enum {
+	LM_USER_REQUEST = 1,  /* User request */
+	LM_LAP_DISCONNECT,    /* Unexpected IrLAP disconnect */
+	LM_CONNECT_FAILURE,   /* Failed to establish IrLAP connection */
+	LM_LAP_RESET,         /* IrLAP reset */
+	LM_INIT_DISCONNECT,   /* Link Management initiated disconnect */
+	LM_LSAP_NOTCONN,      /* Data delivered on unconnected LSAP */
+	LM_NON_RESP_CLIENT,   /* Non responsive LM-MUX client */
+	LM_NO_AVAIL_CLIENT,   /* No available LM-MUX client */
+	LM_CONN_HALF_OPEN,    /* Connection is half open */
+	LM_BAD_SOURCE_ADDR,   /* Illegal source address (i.e 0x00) */
+} LM_REASON;
+#define LM_UNKNOWN 0xff       /* Unspecified disconnect reason */
+
+/* A few forward declarations (to make compiler happy) */
+struct qos_info;		/* in <net/irda/qos.h> */
+
+/*
+ *  Notify structure used between transport and link management layers
+ */
+typedef struct {
+	int (*data_indication)(void *priv, void *sap, struct sk_buff *skb);
+	int (*udata_indication)(void *priv, void *sap, struct sk_buff *skb);
+	void (*connect_confirm)(void *instance, void *sap, 
+				struct qos_info *qos, __u32 max_sdu_size,
+				__u8 max_header_size, struct sk_buff *skb);
+	void (*connect_indication)(void *instance, void *sap, 
+				   struct qos_info *qos, __u32 max_sdu_size, 
+				   __u8 max_header_size, struct sk_buff *skb);
+	void (*disconnect_indication)(void *instance, void *sap, 
+				      LM_REASON reason, struct sk_buff *);
+	void (*flow_indication)(void *instance, void *sap, LOCAL_FLOW flow);
+	void (*status_indication)(void *instance,
+				  LINK_STATUS link, LOCK_STATUS lock);
+	void *instance; /* Layer instance pointer */
+	char name[16];  /* Name of layer */
+} notify_t;
+
+#define NOTIFY_MAX_NAME 16
+
+/* Zero the notify structure */
+void irda_notify_init(notify_t *notify);
 
 /* Locking wrapper - Note the inverted logic on irda_lock().
  * Those function basically return false if the lock is already in the
  * position you want to set it. - Jean II */
 #define irda_lock(lock)		(! test_and_set_bit(0, (void *) (lock)))
 #define irda_unlock(lock)	(test_and_clear_bit(0, (void *) (lock)))
-
-/* Zero the notify structure */
-void irda_notify_init(notify_t *notify);
 
 #endif /* IRMOD_H */
 
diff -u -p --new-file linux/include/net/irda.d9/irttp.h linux/include/net/irda/irttp.h
--- linux/include/net/irda.d9/irttp.h	Sat Jun  8 22:28:10 2002
+++ linux/include/net/irda/irttp.h	Tue Jun 18 13:51:36 2002
@@ -11,6 +11,7 @@
  * 
  *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
  *     All Rights Reserved.
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -31,8 +32,8 @@
 #include <linux/spinlock.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irlmp.h>
-#include <net/irda/qos.h>
+#include <net/irda/irlmp.h>		/* struct lsap_cb */
+#include <net/irda/qos.h>		/* struct qos_info */
 #include <net/irda/irqueue.h>
 
 #define TTP_MAX_CONNECTIONS    LM_MAX_CONNECTIONS
diff -u -p --new-file linux/include/net/irda.d9/timer.h linux/include/net/irda/timer.h
--- linux/include/net/irda.d9/timer.h	Sat Jun  8 22:26:33 2002
+++ linux/include/net/irda/timer.h	Tue Jun 18 13:51:36 2002
@@ -11,7 +11,7 @@
  * 
  *     Copyright (c) 1997, 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
  *     All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -27,15 +27,17 @@
 #ifndef TIMER_H
 #define TIMER_H
 
-#include <linux/netdevice.h>
+#include <linux/timer.h>
 
 #include <asm/param.h>  /* for HZ */
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
-#include <net/irda/irlap.h>
-#include <net/irda/irlmp.h>
-#include <net/irda/irda_device.h>
+
+/* A few forward declarations (to make compiler happy) */
+struct irlmp_cb;
+struct irlap_cb;
+struct lsap_cb;
+struct lap_cb;
 
 /* 
  *  Timeout definitions, some defined in IrLAP p. 92
@@ -81,8 +83,6 @@ inline void irlap_start_backoff_timer(st
 void irlap_start_mbusy_timer(struct irlap_cb *self, int timeout);
 void irlap_stop_mbusy_timer(struct irlap_cb *);
 
-struct lsap_cb;
-struct lap_cb;
 inline void irlmp_start_watchdog_timer(struct lsap_cb *, int timeout);
 inline void irlmp_start_discovery_timer(struct irlmp_cb *, int timeout);
 inline void irlmp_start_idle_timer(struct lap_cb *, int timeout);
diff -u -p --new-file linux/include/net/irda.d9/wrapper.h linux/include/net/irda/wrapper.h
--- linux/include/net/irda.d9/wrapper.h	Sat Jun  8 22:26:29 2002
+++ linux/include/net/irda/wrapper.h	Tue Jun 18 13:51:36 2002
@@ -30,7 +30,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 
-#include <net/irda/irda_device.h>
+#include <net/irda/irda_device.h>	/* iobuff_t */
 
 #define BOF  0xc0 /* Beginning of frame */
 #define XBOF 0xff
diff -u -p linux/drivers/net/irda.d9/actisys.c linux/drivers/net/irda/actisys.c
--- linux/drivers/net/irda.d9/actisys.c	Sat Jun  8 22:30:18 2002
+++ linux/drivers/net/irda/actisys.c	Tue Jun 18 13:51:36 2002
@@ -42,7 +42,6 @@
 #include <linux/init.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/irda_device.h>
 
 /* 
@@ -110,7 +109,7 @@ int __init actisys_init(void)
 	return 0;
 }
 
-void actisys_cleanup(void)
+void __exit actisys_cleanup(void)
 {
 	/* We have to remove both dongles */
 	irda_device_unregister_dongle(&dongle);
@@ -269,7 +268,6 @@ static int actisys_reset(struct irda_tas
 	return ret;
 }
 
-#ifdef MODULE
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> - Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("ACTiSYS IR-220L and IR-220L+ dongle driver");	
 MODULE_LICENSE("GPL");
@@ -281,10 +279,7 @@ MODULE_LICENSE("GPL");
  *    Initialize Actisys module
  *
  */
-int init_module(void)
-{
-	return actisys_init();
-}
+module_init(actisys_init);
 
 /*
  * Function cleanup_module (void)
@@ -292,8 +287,4 @@ int init_module(void)
  *    Cleanup Actisys module
  *
  */
-void cleanup_module(void)
-{
-	actisys_cleanup();
-}
-#endif /* MODULE */
+module_exit(actisys_cleanup);
diff -u -p linux/drivers/net/irda.d9/ali-ircc.c linux/drivers/net/irda/ali-ircc.c
--- linux/drivers/net/irda.d9/ali-ircc.c	Sat Jun  8 22:29:15 2002
+++ linux/drivers/net/irda/ali-ircc.c	Tue Jun 18 13:51:36 2002
@@ -40,8 +40,6 @@
 
 #include <net/irda/wrapper.h>
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
-#include <net/irda/irlap_frame.h>
 #include <net/irda/irda_device.h>
 
 #include <net/irda/ali-ircc.h>
@@ -88,9 +86,7 @@ static char *dongle_types[] = {
 /* Some prototypes */
 static int  ali_ircc_open(int i, chipio_t *info);
 
-#ifdef MODULE
 static int  ali_ircc_close(struct ali_ircc_cb *self);
-#endif /* MODULE */
 
 static int  ali_ircc_setup(chipio_t *info);
 static int  ali_ircc_is_receiving(struct ali_ircc_cb *self);
@@ -228,8 +224,7 @@ int __init ali_ircc_init(void)
  *    Close all configured chips
  *
  */
-#ifdef MODULE
-static void ali_ircc_cleanup(void)
+static void __exit ali_ircc_cleanup(void)
 {
 	int i;
 
@@ -244,7 +239,6 @@ static void ali_ircc_cleanup(void)
 	
 	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End -----------------\n");
 }
-#endif /* MODULE */
 
 /*
  * Function ali_ircc_open (int i, chipio_t *inf)
@@ -387,14 +381,13 @@ static int ali_ircc_open(int i, chipio_t
 }
 
 
-#ifdef MODULE
 /*
  * Function ali_ircc_close (self)
  *
  *    Close driver instance
  *
  */
-static int ali_ircc_close(struct ali_ircc_cb *self)
+static int __exit ali_ircc_close(struct ali_ircc_cb *self)
 {
 	int iobase;
 
@@ -428,7 +421,6 @@ static int ali_ircc_close(struct ali_irc
 	
 	return 0;
 }
-#endif /* MODULE */
 
 /*
  * Function ali_ircc_init_43 (chip, info)
@@ -2288,7 +2280,6 @@ static void FIR2SIR(int iobase)
 	IRDA_DEBUG(1, __FUNCTION__ "(), ----------------- End ------------------\n");
 }
 
-#ifdef MODULE
 MODULE_AUTHOR("Benjamin Kong <benjamin_kong@ali.com.tw>");
 MODULE_DESCRIPTION("ALi FIR Controller Driver");
 MODULE_LICENSE("GPL");
@@ -2301,13 +2292,5 @@ MODULE_PARM_DESC(irq, "IRQ lines");
 MODULE_PARM(dma, "1-4i");
 MODULE_PARM_DESC(dma, "DMA channels");
 
-int init_module(void)
-{
-	return ali_ircc_init();	
-}
-
-void cleanup_module(void)
-{
-	ali_ircc_cleanup();
-}
-#endif /* MODULE */
+module_init(ali_ircc_init);
+module_exit(ali_ircc_cleanup);
diff -u -p linux/drivers/net/irda.d9/ep7211_ir.c linux/drivers/net/irda/ep7211_ir.c
--- linux/drivers/net/irda.d9/ep7211_ir.c	Sat Jun  8 22:26:57 2002
+++ linux/drivers/net/irda/ep7211_ir.c	Tue Jun 18 13:51:36 2002
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/irda_device.h>
 
 #include <asm/io.h>
@@ -123,7 +122,5 @@ MODULE_AUTHOR("Jon McClintock <jonm@blue
 MODULE_DESCRIPTION("EP7211 I/R driver");
 MODULE_LICENSE("GPL");
 		
-#ifdef MODULE
 module_init(ep7211_ir_init);
-#endif /* MODULE */
 module_exit(ep7211_ir_cleanup);
diff -u -p linux/drivers/net/irda.d9/esi.c linux/drivers/net/irda/esi.c
--- linux/drivers/net/irda.d9/esi.c	Sat Jun  8 22:30:20 2002
+++ linux/drivers/net/irda/esi.c	Tue Jun 18 13:51:36 2002
@@ -38,7 +38,6 @@
 #include <linux/init.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/irda_device.h>
 
 static void esi_open(dongle_t *self, struct qos_info *qos);
@@ -60,7 +59,7 @@ int __init esi_init(void)
 	return irda_device_register_dongle(&dongle);
 }
 
-void esi_cleanup(void)
+void __exit esi_cleanup(void)
 {
 	irda_device_unregister_dongle(&dongle);
 }
@@ -133,7 +132,6 @@ static int esi_reset(struct irda_task *t
 	return 0;
 }
 
-#ifdef MODULE
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Extended Systems JetEye PC dongle driver");
 MODULE_LICENSE("GPL");
@@ -144,10 +142,7 @@ MODULE_LICENSE("GPL");
  *    Initialize ESI module
  *
  */
-int init_module(void)
-{
-	return esi_init();
-}
+module_init(esi_init);
 
 /*
  * Function cleanup_module (void)
@@ -155,9 +150,5 @@ int init_module(void)
  *    Cleanup ESI module
  *
  */
-void cleanup_module(void)
-{
-        esi_cleanup();
-}
-#endif /* MODULE */
+module_exit(esi_cleanup);
 
diff -u -p linux/drivers/net/irda.d9/girbil.c linux/drivers/net/irda/girbil.c
--- linux/drivers/net/irda.d9/girbil.c	Sat Jun  8 22:26:27 2002
+++ linux/drivers/net/irda/girbil.c	Tue Jun 18 13:51:36 2002
@@ -29,7 +29,6 @@
 #include <linux/init.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/irda_device.h>
 #include <net/irda/irtty.h>
 
@@ -79,7 +78,7 @@ int __init girbil_init(void)
 	return irda_device_register_dongle(&dongle);
 }
 
-void girbil_cleanup(void)
+void __exit girbil_cleanup(void)
 {
 	irda_device_unregister_dongle(&dongle);
 }
@@ -231,7 +230,6 @@ static int girbil_reset(struct irda_task
 	return ret;
 }
 
-#ifdef MODULE
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Greenwich GIrBIL dongle driver");
 MODULE_LICENSE("GPL");
@@ -243,10 +241,7 @@ MODULE_LICENSE("GPL");
  *    Initialize Girbil module
  *
  */
-int init_module(void)
-{
-	return girbil_init();
-}
+module_init(girbil_init);
 
 /*
  * Function cleanup_module (void)
@@ -254,8 +249,5 @@ int init_module(void)
  *    Cleanup Girbil module
  *
  */
-void cleanup_module(void)
-{
-        girbil_cleanup();
-}
-#endif /* MODULE */
+module_exit(girbil_cleanup);
+
diff -u -p linux/drivers/net/irda.d9/irda-usb.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda.d9/irda-usb.c	Tue Jun 18 11:59:12 2002
+++ linux/drivers/net/irda/irda-usb.c	Tue Jun 18 13:51:36 2002
@@ -65,11 +65,6 @@
 #include <linux/rtnetlink.h>
 #include <linux/usb.h>
 
-#include <net/irda/irda.h>
-#include <net/irda/irlap.h>
-#include <net/irda/irda_device.h>
-#include <net/irda/wrapper.h>
-
 #include <net/irda/irda-usb.h>
 
 /*------------------------------------------------------------------*/
diff -u -p linux/drivers/net/irda.d9/irport.c linux/drivers/net/irda/irport.c
--- linux/drivers/net/irda.d9/irport.c	Sat Jun  8 22:27:25 2002
+++ linux/drivers/net/irda/irport.c	Tue Jun 18 13:51:36 2002
@@ -55,7 +55,6 @@
 #include <asm/io.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/wrapper.h>
 #include <net/irda/irport.h>
 
@@ -121,8 +120,7 @@ int __init irport_init(void)
  *    Close all configured ports
  *
  */
-#ifdef MODULE
-static void irport_cleanup(void)
+static void __exit irport_cleanup(void)
 {
  	int i;
 
@@ -133,7 +131,6 @@ static void irport_cleanup(void)
  			irport_close(dev_self[i]);
  	}
 }
-#endif /* MODULE */
 
 struct irport_cb *
 irport_open(int i, unsigned int iobase, unsigned int irq)
@@ -1026,7 +1023,6 @@ static struct net_device_stats *irport_n
 	return &self->stats;
 }
 
-#ifdef MODULE
 MODULE_PARM(io, "1-4i");
 MODULE_PARM_DESC(io, "Base I/O addresses");
 MODULE_PARM(irq, "1-4i");
@@ -1036,15 +1032,6 @@ MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.
 MODULE_DESCRIPTION("Half duplex serial driver for IrDA SIR mode");
 MODULE_LICENSE("GPL");
 
-
-void cleanup_module(void)
-{
-	irport_cleanup();
-}
-
-int init_module(void)
-{
-	return irport_init();
-}
-#endif /* MODULE */
+module_init(irport_init);
+module_exit(irport_cleanup);
 
diff -u -p linux/drivers/net/irda.d9/irtty.c linux/drivers/net/irda/irtty.c
--- linux/drivers/net/irda.d9/irtty.c	Sat Jun  8 22:28:14 2002
+++ linux/drivers/net/irda/irtty.c	Tue Jun 18 13:51:36 2002
@@ -37,7 +37,6 @@
 #include <net/irda/irda.h>
 #include <net/irda/irtty.h>
 #include <net/irda/wrapper.h>
-#include <net/irda/timer.h>
 #include <net/irda/irda_device.h>
 
 static hashbin_t *irtty = NULL;
@@ -113,8 +112,7 @@ int __init irtty_init(void)
  *    Called when the irda module is removed. Here we remove all instances
  *    of the driver, and the master array.
  */
-#ifdef MODULE
-static void irtty_cleanup(void) 
+static void __exit irtty_cleanup(void) 
 {
 	int ret;
 	
@@ -132,7 +130,6 @@ static void irtty_cleanup(void) 
 	 */
 	hashbin_delete(irtty, NULL);
 }
-#endif /* MODULE */
 
 /* 
  *  Function irtty_open(tty)
@@ -1058,8 +1055,6 @@ static struct net_device_stats *irtty_ne
 	return &self->stats;
 }
 
-#ifdef MODULE
-
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("IrDA TTY device driver");
 MODULE_LICENSE("GPL");
@@ -1074,10 +1069,7 @@ MODULE_PARM_DESC(qos_mtt_bits, "Minimum 
  *    Initialize IrTTY module
  *
  */
-int init_module(void)
-{
-	return irtty_init();
-}
+module_init(irtty_init);
 
 /*
  * Function cleanup_module (void)
@@ -1085,9 +1077,4 @@ int init_module(void)
  *    Cleanup IrTTY module
  *
  */
-void cleanup_module(void)
-{
-	irtty_cleanup();
-}
-
-#endif /* MODULE */
+module_exit(irtty_cleanup);
diff -u -p linux/drivers/net/irda.d9/litelink.c linux/drivers/net/irda/litelink.c
--- linux/drivers/net/irda.d9/litelink.c	Sat Jun  8 22:30:25 2002
+++ linux/drivers/net/irda/litelink.c	Tue Jun 18 13:51:36 2002
@@ -35,7 +35,6 @@
 #include <linux/init.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/irda_device.h>
 
 #define MIN_DELAY 25      /* 15 us, but wait a little more to be sure */
@@ -63,7 +62,7 @@ int __init litelink_init(void)
 	return irda_device_register_dongle(&dongle);
 }
 
-void litelink_cleanup(void)
+void __exit litelink_cleanup(void)
 {
 	irda_device_unregister_dongle(&dongle);
 }
@@ -163,7 +162,6 @@ static int litelink_reset(struct irda_ta
 	return 0;
 }
 
-#ifdef MODULE
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Parallax Litelink dongle driver");	
 MODULE_LICENSE("GPL");
@@ -175,10 +173,7 @@ MODULE_LICENSE("GPL");
  *    Initialize Litelink module
  *
  */
-int init_module(void)
-{
-	return litelink_init();
-}
+module_init(litelink_init);
 
 /*
  * Function cleanup_module (void)
@@ -186,8 +181,4 @@ int init_module(void)
  *    Cleanup Litelink module
  *
  */
-void cleanup_module(void)
-{
-	litelink_cleanup();
-}
-#endif /* MODULE */
+module_exit(litelink_cleanup);
diff -u -p linux/drivers/net/irda.d9/mcp2120.c linux/drivers/net/irda/mcp2120.c
--- linux/drivers/net/irda.d9/mcp2120.c	Sat Jun  8 22:31:27 2002
+++ linux/drivers/net/irda/mcp2120.c	Tue Jun 18 13:51:36 2002
@@ -25,7 +25,6 @@
 #include <linux/init.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/irda_device.h>
 #include <net/irda/irtty.h>
 
@@ -56,7 +55,7 @@ int __init mcp2120_init(void)
 	return irda_device_register_dongle(&dongle);
 }
 
-void mcp2120_cleanup(void)
+void __exit mcp2120_cleanup(void)
 {
 	irda_device_unregister_dongle(&dongle);
 }
@@ -222,7 +221,6 @@ static int mcp2120_reset(struct irda_tas
 	return ret;
 }
 
-#ifdef MODULE
 MODULE_AUTHOR("Felix Tang <tangf@eyetap.org>");
 MODULE_DESCRIPTION("Microchip MCP2120");
 MODULE_LICENSE("GPL");
@@ -234,10 +232,7 @@ MODULE_LICENSE("GPL");
  *    Initialize MCP2120 module
  *
  */
-int init_module(void)
-{
-	return mcp2120_init();
-}
+module_init(mcp2120_init);
 
 /*
  * Function cleanup_module (void)
@@ -245,8 +240,4 @@ int init_module(void)
  *    Cleanup MCP2120 module
  *
  */
-void cleanup_module(void)
-{
-        mcp2120_cleanup();
-}
-#endif /* MODULE */
+module_exit(mcp2120_cleanup);
diff -u -p linux/drivers/net/irda.d9/nsc-ircc.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda.d9/nsc-ircc.c	Sat Jun  8 22:26:26 2002
+++ linux/drivers/net/irda/nsc-ircc.c	Tue Jun 18 13:51:36 2002
@@ -61,8 +61,6 @@
 
 #include <net/irda/wrapper.h>
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
-#include <net/irda/irlap_frame.h>
 #include <net/irda/irda_device.h>
 
 #include <net/irda/nsc-ircc.h>
@@ -123,9 +121,7 @@ static char *dongle_types[] = {
 
 /* Some prototypes */
 static int  nsc_ircc_open(int i, chipio_t *info);
-#ifdef MODULE
 static int  nsc_ircc_close(struct nsc_ircc_cb *self);
-#endif /* MODULE */
 static int  nsc_ircc_setup(chipio_t *info);
 static void nsc_ircc_pio_receive(struct nsc_ircc_cb *self);
 static int  nsc_ircc_dma_receive(struct nsc_ircc_cb *self); 
@@ -225,8 +221,7 @@ int __init nsc_ircc_init(void)
  *    Close all configured chips
  *
  */
-#ifdef MODULE
-static void nsc_ircc_cleanup(void)
+static void __exit nsc_ircc_cleanup(void)
 {
 	int i;
 
@@ -237,7 +232,6 @@ static void nsc_ircc_cleanup(void)
 			nsc_ircc_close(dev_self[i]);
 	}
 }
-#endif /* MODULE */
 
 /*
  * Function nsc_ircc_open (iobase, irq)
@@ -245,7 +239,7 @@ static void nsc_ircc_cleanup(void)
  *    Open driver instance
  *
  */
-static int nsc_ircc_open(int i, chipio_t *info)
+static int __init nsc_ircc_open(int i, chipio_t *info)
 {
 	struct net_device *dev;
 	struct nsc_ircc_cb *self;
@@ -384,14 +378,13 @@ static int nsc_ircc_open(int i, chipio_t
 	return 0;
 }
 
-#ifdef MODULE
 /*
  * Function nsc_ircc_close (self)
  *
  *    Close driver instance
  *
  */
-static int nsc_ircc_close(struct nsc_ircc_cb *self)
+static int __exit nsc_ircc_close(struct nsc_ircc_cb *self)
 {
 	int iobase;
 
@@ -424,7 +417,6 @@ static int nsc_ircc_close(struct nsc_irc
 	
 	return 0;
 }
-#endif /* MODULE */
 
 /*
  * Function nsc_ircc_init_108 (iobase, cfg_base, irq, dma)
@@ -2046,7 +2038,6 @@ static int nsc_ircc_pmproc(struct pm_dev
 	return 0;
 }
 
-#ifdef MODULE
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("NSC IrDA Device Driver");
 MODULE_LICENSE("GPL");
@@ -2063,14 +2054,6 @@ MODULE_PARM_DESC(dma, "DMA channels");
 MODULE_PARM(dongle_id, "i");
 MODULE_PARM_DESC(dongle_id, "Type-id of used dongle");
 
-int init_module(void)
-{
-	return nsc_ircc_init();
-}
-
-void cleanup_module(void)
-{
-	nsc_ircc_cleanup();
-}
-#endif /* MODULE */
+module_init(nsc_ircc_init);
+module_exit(nsc_ircc_cleanup);
 
diff -u -p linux/drivers/net/irda.d9/old_belkin.c linux/drivers/net/irda/old_belkin.c
--- linux/drivers/net/irda.d9/old_belkin.c	Sat Jun  8 22:29:14 2002
+++ linux/drivers/net/irda/old_belkin.c	Tue Jun 18 13:51:36 2002
@@ -36,7 +36,6 @@
 #include <linux/irda.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/irda_device.h>
 
 /*
@@ -90,7 +89,7 @@ int __init old_belkin_init(void)
 	return irda_device_register_dongle(&dongle);
 }
 
-void old_belkin_cleanup(void)
+void __exit old_belkin_cleanup(void)
 {
 	irda_device_unregister_dongle(&dongle);
 }
@@ -149,7 +148,6 @@ static int old_belkin_reset(struct irda_
 	return 0;
 }
 
-#ifdef MODULE
 MODULE_AUTHOR("Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("Belkin (old) SmartBeam dongle driver");	
 MODULE_LICENSE("GPL");
@@ -161,10 +159,7 @@ MODULE_LICENSE("GPL");
  *    Initialize Old-Belkin module
  *
  */
-int init_module(void)
-{
-	return old_belkin_init();
-}
+module_init(old_belkin_init);
 
 /*
  * Function cleanup_module (void)
@@ -172,9 +167,4 @@ int init_module(void)
  *    Cleanup Old-Belkin module
  *
  */
-void cleanup_module(void)
-{
-	old_belkin_cleanup();
-}
-#endif /* MODULE */
-
+module_exit(old_belkin_cleanup);
diff -u -p linux/drivers/net/irda.d9/sa1100_ir.c linux/drivers/net/irda/sa1100_ir.c
--- linux/drivers/net/irda.d9/sa1100_ir.c	Sat Jun  8 22:29:00 2002
+++ linux/drivers/net/irda/sa1100_ir.c	Tue Jun 18 13:51:36 2002
@@ -33,7 +33,6 @@
 #include <linux/pm.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/wrapper.h>
 #include <net/irda/irda_device.h>
 
@@ -1078,9 +1077,7 @@ static void sa1100_irda_net_uninit(struc
 	kfree(si);
 }
 
-#ifdef MODULE
 static
-#endif
 int __init sa1100_irda_init(void)
 {
 	struct net_device *dev;
@@ -1181,10 +1178,8 @@ static int __init sa1100ir_setup(char *l
 
 __setup("sa1100ir=", sa1100ir_setup);
 
-#ifdef MODULE
 module_init(sa1100_irda_init);
 module_exit(sa1100_irda_exit);
-#endif
 
 MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
 MODULE_DESCRIPTION("StrongARM SA1100 IrDA driver");
diff -u -p linux/drivers/net/irda.d9/smc-ircc.c linux/drivers/net/irda/smc-ircc.c
--- linux/drivers/net/irda.d9/smc-ircc.c	Sat Jun  8 22:26:29 2002
+++ linux/drivers/net/irda/smc-ircc.c	Tue Jun 18 13:51:36 2002
@@ -59,8 +59,6 @@
 
 #include <net/irda/wrapper.h>
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
-#include <net/irda/irlap_frame.h>
 #include <net/irda/irda_device.h>
 #include <net/irda/smc-ircc.h>
 #include <net/irda/irport.h>
@@ -1160,15 +1158,12 @@ static int ircc_pmproc(struct pm_dev *de
 	return 0;
 }
 
-#ifdef MODULE
-
 /*
  * Function ircc_close (self)
  *
  *    Close driver instance
  *
  */
-#ifdef MODULE
 static int __exit ircc_close(struct ircc_cb *self)
 {
 	int iobase;
@@ -1207,7 +1202,6 @@ static int __exit ircc_close(struct ircc
 
 	return 0;
 }
-#endif /* MODULE */
 
 int __init smc_init(void)
 {
@@ -1243,5 +1237,3 @@ MODULE_PARM(ircc_sir, "1-4i");
 MODULE_PARM_DESC(ircc_sir, "SIR Base Address");
 MODULE_PARM(ircc_cfg, "1-4i");
 MODULE_PARM_DESC(ircc_cfg, "Configuration register base address");
-
-#endif /* MODULE */
diff -u -p linux/drivers/net/irda.d9/tekram.c linux/drivers/net/irda/tekram.c
--- linux/drivers/net/irda.d9/tekram.c	Sat Jun  8 22:30:25 2002
+++ linux/drivers/net/irda/tekram.c	Tue Jun 18 13:51:36 2002
@@ -29,7 +29,6 @@
 #include <linux/init.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/irda_device.h>
 #include <net/irda/irtty.h>
 
@@ -60,7 +59,7 @@ int __init tekram_init(void)
 	return irda_device_register_dongle(&dongle);
 }
 
-void tekram_cleanup(void)
+void __exit tekram_cleanup(void)
 {
 	irda_device_unregister_dongle(&dongle);
 }
@@ -264,7 +263,6 @@ int tekram_reset(struct irda_task *task)
 	return ret;
 }
 
-#ifdef MODULE
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Tekram IrMate IR-210B dongle driver");
 MODULE_LICENSE("GPL");
@@ -275,10 +273,7 @@ MODULE_LICENSE("GPL");
  *    Initialize Tekram module
  *
  */
-int init_module(void)
-{
-	return tekram_init();
-}
+module_init(tekram_init);
 
 /*
  * Function cleanup_module (void)
@@ -286,8 +281,4 @@ int init_module(void)
  *    Cleanup Tekram module
  *
  */
-void cleanup_module(void)
-{
-        tekram_cleanup();
-}
-#endif /* MODULE */
+module_exit(tekram_cleanup);
diff -u -p linux/drivers/net/irda.d9/toshoboe.c linux/drivers/net/irda/toshoboe.c
--- linux/drivers/net/irda.d9/toshoboe.c	Sat Jun  8 22:26:30 2002
+++ linux/drivers/net/irda/toshoboe.c	Tue Jun 18 13:51:36 2002
@@ -69,8 +69,6 @@ static char *rcsid = "$Id: toshoboe.c,v 
 
 #include <net/irda/wrapper.h>
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
-#include <net/irda/irlap_frame.h>
 #include <net/irda/irda_device.h>
 
 #include <linux/pm.h>
diff -u -p linux/drivers/net/irda.d9/vlsi_ir.c linux/drivers/net/irda/vlsi_ir.c
--- linux/drivers/net/irda.d9/vlsi_ir.c	Sat Jun  8 22:26:51 2002
+++ linux/drivers/net/irda/vlsi_ir.c	Tue Jun 18 13:51:36 2002
@@ -37,7 +37,6 @@
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
 #include <net/irda/wrapper.h>
-#include <net/irda/irlap.h>
 
 #include <net/irda/vlsi_ir.h>
 
diff -u -p linux/drivers/net/irda.d9/w83977af_ir.c linux/drivers/net/irda/w83977af_ir.c
--- linux/drivers/net/irda.d9/w83977af_ir.c	Sat Jun  8 22:29:00 2002
+++ linux/drivers/net/irda/w83977af_ir.c	Tue Jun 18 13:51:36 2002
@@ -56,7 +56,6 @@
 #include <asm/byteorder.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/wrapper.h>
 #include <net/irda/irda_device.h>
 #include <net/irda/w83977af.h>
@@ -135,8 +134,7 @@ int __init w83977af_init(void)
  *    Close all configured chips
  *
  */
-#ifdef MODULE
-void w83977af_cleanup(void)
+void __exit w83977af_cleanup(void)
 {
 	int i;
 
@@ -147,7 +145,6 @@ void w83977af_cleanup(void)
 			w83977af_close(dev_self[i]);
 	}
 }
-#endif /* MODULE */
 
 /*
  * Function w83977af_open (iobase, irq)
@@ -1374,8 +1371,6 @@ static struct net_device_stats *w83977af
 	return &self->stats;
 }
 
-#ifdef MODULE
-
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Winbond W83977AF IrDA Device Driver");
 MODULE_LICENSE("GPL");
@@ -1394,10 +1389,7 @@ MODULE_PARM_DESC(irq, "IRQ lines");
  *    
  *
  */
-int init_module(void)
-{
-	return w83977af_init();
-}
+module_init(w83977af_init);
 
 /*
  * Function cleanup_module (void)
@@ -1405,8 +1397,4 @@ int init_module(void)
  *    
  *
  */
-void cleanup_module(void)
-{
-	w83977af_cleanup();
-}
-#endif /* MODULE */
+module_exit(w83977af_cleanup);
diff -u -p -r linux/net/irda.d9/af_irda.c linux/net/irda/af_irda.c
--- linux/net/irda.d9/af_irda.c	Tue Jun 18 11:59:20 2002
+++ linux/net/irda/af_irda.c	Tue Jun 18 13:51:36 2002
@@ -48,27 +48,17 @@
 #include <linux/socket.h>
 #include <linux/sockios.h>
 #include <linux/init.h>
-#include <linux/if_arp.h>
 #include <linux/net.h>
 #include <linux/irda.h>
 #include <linux/poll.h>
 
+#include <asm/ioctls.h>		/* TIOCOUTQ, TIOCINQ */
 #include <asm/uaccess.h>
 
 #include <net/sock.h>
 #include <net/tcp.h>
 
-#include <net/irda/irda.h>
-#include <net/irda/iriap.h>
-#include <net/irda/irias_object.h>
-#include <net/irda/irlmp.h>
-#include <net/irda/irttp.h>
-#include <net/irda/discovery.h>
-
-extern int  irda_init(void);
-extern void irda_cleanup(void);
-extern int  irlap_driver_rcv(struct sk_buff *, struct net_device *,
-			     struct packet_type *);
+#include <net/irda/af_irda.h>
 
 static int irda_create(struct socket *sock, int protocol);
 
@@ -83,10 +73,6 @@ static struct proto_ops irda_ultra_ops;
 
 #define IRDA_MAX_HEADER (TTP_MAX_HEADER)
 
-#ifdef CONFIG_IRDA_DEBUG
-__u32 irda_debug = IRDA_DEBUG_LEVEL;
-#endif
-
 /*
  * Function irda_data_indication (instance, sap, skb)
  *
@@ -2530,118 +2516,27 @@ SOCKOPS_WRAP(irda_ultra, PF_IRDA);
 #endif /* CONFIG_IRDA_ULTRA */
 
 /*
- * Function irda_device_event (this, event, ptr)
+ * Function irsock_init (pro)
  *
- *    Called when a device is taken up or down
+ *    Initialize IrDA protocol
  *
  */
-static int irda_device_event(struct notifier_block *this, unsigned long event,
-			     void *ptr)
-{
-	struct net_device *dev = (struct net_device *) ptr;
-
-        /* Reject non IrDA devices */
-	if (dev->type != ARPHRD_IRDA)
-		return NOTIFY_DONE;
-
-        switch (event) {
-	case NETDEV_UP:
-		IRDA_DEBUG(3, __FUNCTION__ "(), NETDEV_UP\n");
-		/* irda_dev_device_up(dev); */
-		break;
-	case NETDEV_DOWN:
-		IRDA_DEBUG(3, __FUNCTION__ "(), NETDEV_DOWN\n");
-		/* irda_kill_by_device(dev); */
-		/* irda_rt_device_down(dev); */
-		/* irda_dev_device_down(dev); */
-		break;
-	default:
-		break;
-        }
-
-        return NOTIFY_DONE;
-}
-
-static struct packet_type irda_packet_type =
-{
-	0,	/* MUTTER ntohs(ETH_P_IRDA),*/
-	NULL,
-	irlap_driver_rcv,
-	NULL,
-	NULL,
-};
-
-static struct notifier_block irda_dev_notifier = {
-	irda_device_event,
-	NULL,
-	0
-};
-
-/*
- * Function irda_proc_modcount (inode, fill)
- *
- *    Use by the proc file system functions to prevent the irda module
- *    being removed while the use is standing in the net/irda directory
- */
-void irda_proc_modcount(struct inode *inode, int fill)
-{
-#ifdef MODULE
-#ifdef CONFIG_PROC_FS
-	if (fill)
-		MOD_INC_USE_COUNT;
-	else
-		MOD_DEC_USE_COUNT;
-#endif /* CONFIG_PROC_FS */
-#endif /* MODULE */
-}
-
-/*
- * Function irda_proto_init (pro)
- *
- *    Initialize IrDA protocol layer
- *
- */
-int __init irda_proto_init(void)
+int __init irsock_init(void)
 {
 	sock_register(&irda_family_ops);
 
-	irda_packet_type.type = htons(ETH_P_IRDA);
-        dev_add_pack(&irda_packet_type);
-
-	register_netdevice_notifier(&irda_dev_notifier);
-
-	irda_init();
-	irda_device_init();
 	return 0;
 }
 
-late_initcall(irda_proto_init);
-
 /*
- * Function irda_proto_cleanup (void)
+ * Function irsock_cleanup (void)
  *
- *    Remove IrDA protocol layer
+ *    Remove IrDA protocol
  *
  */
-#ifdef MODULE
-void irda_proto_cleanup(void)
+void __exit irsock_cleanup(void)
 {
-	irda_packet_type.type = htons(ETH_P_IRDA);
-        dev_remove_pack(&irda_packet_type);
-
-        unregister_netdevice_notifier(&irda_dev_notifier);
-
 	sock_unregister(PF_IRDA);
-	irda_cleanup();
 
         return;
 }
-module_exit(irda_proto_cleanup);
-
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
-MODULE_DESCRIPTION("The Linux IrDA Protocol Subsystem");
-MODULE_LICENSE("GPL");
-#ifdef CONFIG_IRDA_DEBUG
-MODULE_PARM(irda_debug, "1l");
-#endif
-#endif /* MODULE */
diff -u -p -r linux/net/irda.d9/ircomm/ircomm_core.c linux/net/irda/ircomm/ircomm_core.c
--- linux/net/irda.d9/ircomm/ircomm_core.c	Tue Jun 18 11:59:20 2002
+++ linux/net/irda/ircomm/ircomm_core.c	Tue Jun 18 13:51:36 2002
@@ -76,8 +76,7 @@ int __init ircomm_init(void)
 	return 0;
 }
 
-#ifdef MODULE
-void ircomm_cleanup(void)
+void __exit ircomm_cleanup(void)
 {
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
@@ -87,7 +86,6 @@ void ircomm_cleanup(void)
 	remove_proc_entry("ircomm", proc_irda);
 #endif /* CONFIG_PROC_FS */
 }
-#endif /* MODULE */
 
 /*
  * Function ircomm_open (client_notify)
@@ -543,18 +541,9 @@ int ircomm_proc_read(char *buf, char **s
 }
 #endif /* CONFIG_PROC_FS */
 
-#ifdef MODULE
 MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("IrCOMM protocol");
 MODULE_LICENSE("GPL");
 
-int init_module(void) 
-{
-	return ircomm_init();
-}
-	
-void cleanup_module(void)
-{
-	ircomm_cleanup();
-}
-#endif /* MODULE */
+module_init(ircomm_init);
+module_exit(ircomm_cleanup);
diff -u -p -r linux/net/irda.d9/ircomm/ircomm_lmp.c linux/net/irda/ircomm/ircomm_lmp.c
--- linux/net/irda.d9/ircomm/ircomm_lmp.c	Sat Jun  8 22:26:52 2002
+++ linux/net/irda/ircomm/ircomm_lmp.c	Tue Jun 18 13:51:36 2002
@@ -35,6 +35,7 @@
 #include <net/irda/irda.h>
 #include <net/irda/irlmp.h>
 #include <net/irda/iriap.h>
+#include <net/irda/irda_device.h>	/* struct irda_skb_cb */
 
 #include <net/irda/ircomm_event.h>
 #include <net/irda/ircomm_lmp.h>
diff -u -p -r linux/net/irda.d9/ircomm/ircomm_tty.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda.d9/ircomm/ircomm_tty.c	Tue Jun 18 11:59:20 2002
+++ linux/net/irda/ircomm/ircomm_tty.c	Tue Jun 18 13:51:36 2002
@@ -141,8 +141,7 @@ int __init ircomm_tty_init(void)
 	return 0;
 }
 
-#ifdef MODULE
-static void __ircomm_tty_cleanup(struct ircomm_tty_cb *self)
+static void __exit __ircomm_tty_cleanup(struct ircomm_tty_cb *self)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
 
@@ -161,7 +160,7 @@ static void __ircomm_tty_cleanup(struct 
  *    Remove IrCOMM TTY layer/driver
  *
  */
-void ircomm_tty_cleanup(void)
+void __exit ircomm_tty_cleanup(void)
 {
 	int ret;
 
@@ -175,7 +174,6 @@ void ircomm_tty_cleanup(void)
 
 	hashbin_delete(ircomm_tty, (FREE_FUNC) __ircomm_tty_cleanup);
 }
-#endif /* MODULE */
 
 /*
  * Function ircomm_startup (self)
@@ -1390,23 +1388,9 @@ done:
 }
 #endif /* CONFIG_PROC_FS */
 
-#ifdef MODULE
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("IrCOMM serial TTY driver");
 MODULE_LICENSE("GPL");
 
-int init_module(void) 
-{
-	return ircomm_tty_init();
-}
-
-void cleanup_module(void)
-{
-	ircomm_tty_cleanup();
-}
-
-#endif /* MODULE */
-
-
-
-
+module_init(ircomm_tty_init);
+module_exit(ircomm_tty_cleanup);
diff -u -p -r linux/net/irda.d9/irda_device.c linux/net/irda/irda_device.c
--- linux/net/irda.d9/irda_device.c	Tue Jun 18 11:59:20 2002
+++ linux/net/irda/irda_device.c	Tue Jun 18 13:51:36 2002
@@ -55,19 +55,6 @@
 #include <net/irda/timer.h>
 #include <net/irda/wrapper.h>
 
-extern int irtty_init(void);
-extern int nsc_ircc_init(void);
-extern int ircc_init(void);
-extern int toshoboe_init(void);
-extern int litelink_init(void);
-extern int w83977af_init(void);
-extern int esi_init(void);
-extern int tekram_init(void);
-extern int actisys_init(void);
-extern int girbil_init(void);
-extern int sa1100_irda_init(void);
-extern int ep7211_ir_init(void);
-
 static void __irda_task_delete(struct irda_task *task);
 
 static hashbin_t *dongles = NULL;
@@ -116,53 +103,13 @@ int __init irda_device_init( void)
 		return -ENOMEM;
 	}
 
-	/*
-	 * Call the init function of the device drivers that has not been
-	 * compiled as a module
-	 */
-#ifdef CONFIG_IRTTY_SIR
-	irtty_init();
-#endif
-#ifdef CONFIG_WINBOND_FIR
-	w83977af_init();
-#endif
-#ifdef CONFIG_SA1100_FIR
-	sa1100_irda_init();
-#endif
-#ifdef CONFIG_NSC_FIR
-	nsc_ircc_init();
-#endif
-#ifdef CONFIG_TOSHIBA_FIR
-	toshoboe_init();
-#endif
-#ifdef CONFIG_SMC_IRCC_FIR
-	ircc_init();
-#endif
-#ifdef CONFIG_ESI_DONGLE
-	esi_init();
-#endif
-#ifdef CONFIG_TEKRAM_DONGLE
-	tekram_init();
-#endif
-#ifdef CONFIG_ACTISYS_DONGLE
-	actisys_init();
-#endif
-#ifdef CONFIG_GIRBIL_DONGLE
-	girbil_init();
-#endif
-#ifdef CONFIG_LITELINK_DONGLE
-	litelink_init();
-#endif
-#ifdef CONFIG_OLD_BELKIN
-	old_belkin_init();
-#endif
-#ifdef CONFIG_EP7211_IR
-	ep7211_ir_init();
-#endif
+	/* We no longer initialise the driver ourselves here, we let
+	 * the system do it for us... - Jean II */
+
 	return 0;
 }
 
-void irda_device_cleanup(void)
+void __exit irda_device_cleanup(void)
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
diff -u -p -r linux/net/irda.d9/iriap.c linux/net/irda/iriap.c
--- linux/net/irda.d9/iriap.c	Tue Jun 18 11:59:20 2002
+++ linux/net/irda/iriap.c	Tue Jun 18 13:51:36 2002
@@ -35,7 +35,6 @@
 
 #include <net/irda/irda.h>
 #include <net/irda/irttp.h>
-#include <net/irda/irmod.h>
 #include <net/irda/irlmp.h>
 #include <net/irda/irias_object.h>
 #include <net/irda/iriap_event.h>
@@ -142,7 +141,7 @@ int __init iriap_init(void)
  *    Initializes the IrIAP layer, called by the module cleanup code in
  *    irmod.c
  */
-void iriap_cleanup(void)
+void __exit iriap_cleanup(void)
 {
 	irlmp_unregister_service(service_handle);
 
diff -u -p -r linux/net/irda.d9/irias_object.c linux/net/irda/irias_object.c
--- linux/net/irda.d9/irias_object.c	Tue Jun 18 11:59:20 2002
+++ linux/net/irda/irias_object.c	Tue Jun 18 13:51:36 2002
@@ -26,7 +26,6 @@
 #include <linux/socket.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/irias_object.h>
 
 hashbin_t *objects = NULL;
diff -u -p -r linux/net/irda.d9/irlan/irlan_common.c linux/net/irda/irlan/irlan_common.c
--- linux/net/irda.d9/irlan/irlan_common.c	Sat Jun  8 22:26:27 2002
+++ linux/net/irda/irlan/irlan_common.c	Tue Jun 18 13:51:36 2002
@@ -155,7 +155,7 @@ int __init irlan_init(void)
 	return 0;
 }
 
-void irlan_cleanup(void) 
+void __exit irlan_cleanup(void) 
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
@@ -1194,8 +1194,6 @@ void irlan_mod_dec_use_count(void)
 #endif
 }
 
-#ifdef MODULE
-
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("The Linux IrDA LAN protocol"); 
 MODULE_LICENSE("GPL");
@@ -1211,10 +1209,7 @@ MODULE_PARM_DESC(access, "Access type DI
  *    Initialize the IrLAN module, this function is called by the
  *    modprobe(1) program.
  */
-int init_module(void) 
-{
-	return irlan_init();
-}
+module_init(irlan_init);
 
 /*
  * Function cleanup_module (void)
@@ -1222,11 +1217,5 @@ int init_module(void) 
  *    Remove the IrLAN module, this function is called by the rmmod(1)
  *    program
  */
-void cleanup_module(void) 
-{
-	/* Free some memory */
- 	irlan_cleanup();
-}
-
-#endif /* MODULE */
+module_exit(irlan_cleanup);
 
diff -u -p -r linux/net/irda.d9/irlap.c linux/net/irda/irlap.c
--- linux/net/irda.d9/irlap.c	Tue Jun 18 11:59:20 2002
+++ linux/net/irda/irlap.c	Tue Jun 18 13:51:36 2002
@@ -89,7 +89,7 @@ int __init irlap_init(void)
 	return 0;
 }
 
-void irlap_cleanup(void)
+void __exit irlap_cleanup(void)
 {
 	ASSERT(irlap != NULL, return;);
 
diff -u -p -r linux/net/irda.d9/irlap_event.c linux/net/irda/irlap_event.c
--- linux/net/irda.d9/irlap_event.c	Tue Jun 18 11:59:20 2002
+++ linux/net/irda/irlap_event.c	Tue Jun 18 13:51:36 2002
@@ -39,6 +39,7 @@
 #include <net/irda/irlap_frame.h>
 #include <net/irda/qos.h>
 #include <net/irda/parameters.h>
+#include <net/irda/irlmp.h>		/* irlmp_flow_indication(), ... */
 
 #include <net/irda/irda_device.h>
 
diff -u -p -r linux/net/irda.d9/irlmp.c linux/net/irda/irlmp.c
--- linux/net/irda.d9/irlmp.c	Tue Jun 18 11:59:21 2002
+++ linux/net/irda/irlmp.c	Tue Jun 18 13:51:36 2002
@@ -35,7 +35,6 @@
 #include <linux/random.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/timer.h>
 #include <net/irda/qos.h>
 #include <net/irda/irlap.h>
@@ -108,7 +107,7 @@ int __init irlmp_init(void)
  *    Remove IrLMP layer
  *
  */
-void irlmp_cleanup(void)
+void __exit irlmp_cleanup(void) 
 {
 	/* Check for main structure */
 	ASSERT(irlmp != NULL, return;);
diff -u -p -r linux/net/irda.d9/irnet/irnet.h linux/net/irda/irnet/irnet.h
--- linux/net/irda.d9/irnet/irnet.h	Sat Jun  8 22:30:52 2002
+++ linux/net/irda/irnet/irnet.h	Tue Jun 18 13:51:36 2002
@@ -222,6 +222,9 @@
  *	o Fix race condition in irnet_connect_indication().
  *	  If the socket was already trying to connect, drop old connection
  *	  and use new one only if acting as primary. See comments.
+ *
+ * v13 - 30.5.02 - Jean II
+ *	o Update module init code
  */
 
 /***************************** INCLUDES *****************************/
@@ -239,6 +242,7 @@
 #include <linux/config.h>
 #include <linux/ctype.h>	/* isspace() */
 #include <asm/uaccess.h>
+#include <linux/init.h>
 
 #include <linux/ppp_defs.h>
 #include <linux/if_ppp.h>
@@ -502,16 +506,11 @@ extern int
 	irda_irnet_init(void);		/* Initialise IrDA part of IrNET */
 extern void
 	irda_irnet_cleanup(void);	/* Teardown IrDA part of IrNET */
-/* --------------------------- PPP PART --------------------------- */
-extern int
-	ppp_irnet_init(void);		/* Initialise PPP part of IrNET */
-extern void
-	ppp_irnet_cleanup(void);	/* Teardown PPP part of IrNET */
 /* ---------------------------- MODULE ---------------------------- */
 extern int
-	init_module(void);		/* Initialise IrNET module */
+	irnet_init(void);		/* Initialise IrNET module */
 extern void
-	cleanup_module(void);		/* Teardown IrNET module  */
+	irnet_cleanup(void);		/* Teardown IrNET module */
 
 /**************************** VARIABLES ****************************/
 
diff -u -p -r linux/net/irda.d9/irnet/irnet_irda.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda.d9/irnet/irnet_irda.c	Sat Jun  8 22:26:52 2002
+++ linux/net/irda/irnet/irnet_irda.c	Tue Jun 18 13:51:36 2002
@@ -1801,7 +1801,7 @@ irnet_proc_read(char *	buf,
 /*
  * Prepare the IrNET layer for operation...
  */
-int
+int __init
 irda_irnet_init(void)
 {
   int		err = 0;
@@ -1844,7 +1844,7 @@ irda_irnet_init(void)
 /*
  * Cleanup at exit...
  */
-void
+void __exit
 irda_irnet_cleanup(void)
 {
   DENTER(MODULE_TRACE, "()\n");
diff -u -p -r linux/net/irda.d9/irnet/irnet_ppp.c linux/net/irda/irnet/irnet_ppp.c
--- linux/net/irda.d9/irnet/irnet_ppp.c	Sat Jun  8 22:31:12 2002
+++ linux/net/irda/irnet/irnet_ppp.c	Tue Jun 18 13:51:36 2002
@@ -1040,7 +1040,7 @@ ppp_irnet_ioctl(struct ppp_channel *	cha
  * Hook our device callbacks in the filesystem, to connect our code
  * to /dev/irnet
  */
-int
+static inline int __init
 ppp_irnet_init(void)
 {
   int err = 0;
@@ -1058,7 +1058,7 @@ ppp_irnet_init(void)
 /*
  * Cleanup at exit...
  */
-void
+static inline void __exit
 ppp_irnet_cleanup(void)
 {
   DENTER(MODULE_TRACE, "()\n");
@@ -1069,13 +1069,12 @@ ppp_irnet_cleanup(void)
   DEXIT(MODULE_TRACE, "\n");
 }
 
-#ifdef MODULE
 /*------------------------------------------------------------------*/
 /*
  * Module main entry point
  */
-int
-init_module(void)
+int __init
+irnet_init(void)
 {
   int err;
 
@@ -1090,11 +1089,19 @@ init_module(void)
 /*
  * Module exit
  */
-void
-cleanup_module(void)
+void __exit
+irnet_cleanup(void)
 {
   irda_irnet_cleanup();
   return ppp_irnet_cleanup();
 }
-#endif /* MODULE */
+
+/*------------------------------------------------------------------*/
+/*
+ * Module magic
+ */
+module_init(irnet_init);
+module_exit(irnet_cleanup);
+MODULE_AUTHOR("Jean Tourrilhes <jt@hpl.hp.com>");
+MODULE_DESCRIPTION("IrNET : Synchronous PPP over IrDA"); 
 MODULE_LICENSE("GPL");
diff -u -p -r linux/net/irda.d9/irproc.c linux/net/irda/irproc.c
--- linux/net/irda.d9/irproc.c	Sat Jun  8 22:26:25 2002
+++ linux/net/irda/irproc.c	Tue Jun 18 13:51:36 2002
@@ -27,9 +27,9 @@
 #include <linux/proc_fs.h>
 #define __NO_VERSION__
 #include <linux/module.h>
+#include <linux/init.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/irlap.h>
 #include <net/irda/irlmp.h>
 
@@ -62,7 +62,7 @@ static struct irda_entry dir[] = {
  *    Register irda entry in /proc file system
  *
  */
-void irda_proc_register(void) 
+void __init irda_proc_register(void) 
 {
 	int i;
 
@@ -81,7 +81,7 @@ void irda_proc_register(void) 
  *    Unregister irda entry in /proc file system
  *
  */
-void irda_proc_unregister(void) 
+void __exit irda_proc_unregister(void) 
 {
 	int i;
 
diff -u -p -r linux/net/irda.d9/irqueue.c linux/net/irda/irqueue.c
--- linux/net/irda.d9/irqueue.c	Sat Jun  8 22:27:35 2002
+++ linux/net/irda/irqueue.c	Tue Jun 18 13:51:36 2002
@@ -36,7 +36,6 @@
 
 #include <net/irda/irda.h>
 #include <net/irda/irqueue.h>
-#include <net/irda/irmod.h>
 
 static irda_queue_t *dequeue_general( irda_queue_t **queue, irda_queue_t* element);
 static __u32 hash( char* name);
diff -u -p -r linux/net/irda.d9/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.d9/irsyms.c	Sat Jun  8 22:31:22 2002
+++ linux/net/irda/irsyms.c	Tue Jun 18 13:51:36 2002
@@ -30,10 +30,9 @@
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
-
+#include <linux/if_arp.h>		/* ARPHRD_IRDA */
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/irlap.h>
 #include <net/irda/irlmp.h>
 #include <net/irda/iriap.h>
@@ -63,6 +62,11 @@ extern int ircomm_tty_init(void);
 extern int irlpt_client_init(void);
 extern int irlpt_server_init(void);
 
+extern int  irsock_init(void);
+extern void irsock_cleanup(void);
+extern int  irlap_driver_rcv(struct sk_buff *, struct net_device *, 
+			     struct packet_type *);
+
 /* IrTTP */
 EXPORT_SYMBOL(irttp_open_tsap);
 EXPORT_SYMBOL(irttp_close_tsap);
@@ -168,45 +172,142 @@ EXPORT_SYMBOL(irtty_unregister_dongle);
 EXPORT_SYMBOL(irtty_set_packet_mode);
 #endif
 
+#ifdef CONFIG_IRDA_DEBUG
+__u32 irda_debug = IRDA_DEBUG_LEVEL;
+#endif
+
+static struct packet_type irda_packet_type = 
+{
+	0,	/* MUTTER ntohs(ETH_P_IRDA),*/
+	NULL,
+	irlap_driver_rcv,
+	NULL,
+	NULL,
+};
+
+/*
+ * Function irda_device_event (this, event, ptr)
+ *
+ *    Called when a device is taken up or down
+ *
+ */
+static int irda_device_event(struct notifier_block *this, unsigned long event,
+			     void *ptr)
+{
+	struct net_device *dev = (struct net_device *) ptr;
+	
+        /* Reject non IrDA devices */
+	if (dev->type != ARPHRD_IRDA) 
+		return NOTIFY_DONE;
+	
+        switch (event) {
+	case NETDEV_UP:
+		IRDA_DEBUG(3, __FUNCTION__ "(), NETDEV_UP\n");
+		/* irda_dev_device_up(dev); */
+		break;
+	case NETDEV_DOWN:
+		IRDA_DEBUG(3, __FUNCTION__ "(), NETDEV_DOWN\n");
+		/* irda_kill_by_device(dev); */
+		/* irda_rt_device_down(dev); */
+		/* irda_dev_device_down(dev); */
+		break;
+	default:
+		break;
+        }
+
+        return NOTIFY_DONE;
+}
+
+static struct notifier_block irda_dev_notifier = {
+	irda_device_event,
+	NULL,
+	0
+};
+
+/*
+ * Function irda_notify_init (notify)
+ *
+ *    Used for initializing the notify structure
+ *
+ */
+void irda_notify_init(notify_t *notify)
+{
+	notify->data_indication = NULL;
+	notify->udata_indication = NULL;
+	notify->connect_confirm = NULL;
+	notify->connect_indication = NULL;
+	notify->disconnect_indication = NULL;
+	notify->flow_indication = NULL;
+	notify->status_indication = NULL;
+	notify->instance = NULL;
+	strncpy(notify->name, "Unknown", NOTIFY_MAX_NAME);
+}
+
+/*
+ * Function irda_init (void)
+ *
+ *  Protocol stack intialisation entry point.
+ *  Initialise the various components of the IrDA stack
+ */
 int __init irda_init(void)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
 
+	/* Lower layer of the stack */
  	irlmp_init();
 	irlap_init();
 	
+	/* Higher layers of the stack */
 	iriap_init();
  	irttp_init();
+	irsock_init();
 	
+	/* Add IrDA packet type (Start receiving packets) */
+	irda_packet_type.type = htons(ETH_P_IRDA);
+        dev_add_pack(&irda_packet_type);
+
+	/* Notifier for Interface changes */
+	register_netdevice_notifier(&irda_dev_notifier);
+
+	/* External APIs */
 #ifdef CONFIG_PROC_FS
 	irda_proc_register();
 #endif
 #ifdef CONFIG_SYSCTL
 	irda_sysctl_register();
 #endif
-	/* 
-	 * Initialize modules that got compiled into the kernel 
-	 */
-#ifdef CONFIG_IRLAN
-	irlan_init();
-#endif
-#ifdef CONFIG_IRCOMM
-	ircomm_init();
-	ircomm_tty_init();
-#endif
+
+	/* Driver/dongle support */
+ 	irda_device_init();
+
 	return 0;
 }
 
+/*
+ * Function irda_cleanup (void)
+ *
+ *  Protocol stack cleanup/removal entry point.
+ *  Cleanup the various components of the IrDA stack
+ */
 void __exit irda_cleanup(void)
 {
+	/* Remove External APIs */
 #ifdef CONFIG_SYSCTL
 	irda_sysctl_unregister();
 #endif	
-
 #ifdef CONFIG_PROC_FS
 	irda_proc_unregister();
 #endif
+
+	/* Remove IrDA packet type (stop receiving packets) */
+	irda_packet_type.type = htons(ETH_P_IRDA);
+        dev_remove_pack(&irda_packet_type);
+	
+	/* Stop receiving interfaces notifications */
+        unregister_netdevice_notifier(&irda_dev_notifier);
+	
 	/* Remove higher layers */
+	irsock_cleanup();
 	irttp_cleanup();
 	iriap_cleanup();
 
@@ -219,21 +320,24 @@ void __exit irda_cleanup(void)
 }
 
 /*
- * Function irda_notify_init (notify)
+ * The IrDA stack must be initialised *before* drivers get initialised,
+ * and *before* higher protocols (IrLAN/IrCOMM/IrNET) get initialised,
+ * otherwise bad things will happen (hashbins will be NULL for example).
+ * Those modules are at module_init()/device_initcall() level.
  *
- *    Used for initializing the notify structure
+ * On the other hand, it needs to be initialised *after* the basic
+ * networking, the /proc/net filesystem and sysctl module. Those are
+ * currently initialised in .../init/main.c (before initcalls).
+ * Also, it needs to be initialised *after* the random number generator.
  *
+ * Jean II
  */
-void irda_notify_init(notify_t *notify)
-{
-	notify->data_indication = NULL;
-	notify->udata_indication = NULL;
-	notify->connect_confirm = NULL;
-	notify->connect_indication = NULL;
-	notify->disconnect_indication = NULL;
-	notify->flow_indication = NULL;
-	notify->status_indication = NULL;
-	notify->instance = NULL;
-	strncpy(notify->name, "Unknown", NOTIFY_MAX_NAME);
-}
-
+subsys_initcall(irda_init);
+module_exit(irda_cleanup);
+ 
+MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> & Jean Tourrilhes <jt@hpl.hp.com>");
+MODULE_DESCRIPTION("The Linux IrDA Protocol Stack"); 
+MODULE_LICENSE("GPL");
+#ifdef CONFIG_IRDA_DEBUG
+MODULE_PARM(irda_debug, "1l");
+#endif
diff -u -p -r linux/net/irda.d9/irsysctl.c linux/net/irda/irsysctl.c
--- linux/net/irda.d9/irsysctl.c	Sat Jun  8 22:29:14 2002
+++ linux/net/irda/irsysctl.c	Tue Jun 18 13:51:36 2002
@@ -27,6 +27,7 @@
 #include <linux/mm.h>
 #include <linux/ctype.h>
 #include <linux/sysctl.h>
+#include <linux/init.h>
 
 #include <net/irda/irda.h>
 #include <net/irda/irias_object.h>
@@ -156,7 +157,7 @@ static struct ctl_table_header *irda_tab
  *    Register our sysctl interface
  *
  */
-int irda_sysctl_register(void)
+int __init irda_sysctl_register(void)
 {
 	irda_table_header = register_sysctl_table(irda_root_table, 0);
 	if (!irda_table_header)
@@ -171,7 +172,7 @@ int irda_sysctl_register(void)
  *    Unregister our sysctl interface
  *
  */
-void irda_sysctl_unregister(void) 
+void __exit irda_sysctl_unregister(void) 
 {
 	unregister_sysctl_table(irda_table_header);
 }
diff -u -p -r linux/net/irda.d9/irttp.c linux/net/irda/irttp.c
--- linux/net/irda.d9/irttp.c	Tue Jun 18 11:59:21 2002
+++ linux/net/irda/irttp.c	Tue Jun 18 13:51:36 2002
@@ -32,7 +32,6 @@
 #include <asm/unaligned.h>
 
 #include <net/irda/irda.h>
-#include <net/irda/irmod.h>
 #include <net/irda/irlap.h>
 #include <net/irda/irlmp.h>
 #include <net/irda/parameters.h>
@@ -107,8 +106,7 @@ int __init irttp_init(void)
  *    Called by module destruction/cleanup code
  *
  */
-#ifdef MODULE
-void irttp_cleanup(void)
+void __exit irttp_cleanup(void) 
 {
 	/* Check for main structure */
 	ASSERT(irttp != NULL, return;);
@@ -126,7 +124,6 @@ void irttp_cleanup(void)
 
 	irttp = NULL;
 }
-#endif
 
 /*************************** SUBROUTINES ***************************/
 
diff -u -p -r linux/net/irda.d9/timer.c linux/net/irda/timer.c
--- linux/net/irda.d9/timer.c	Sat Jun  8 22:30:24 2002
+++ linux/net/irda/timer.c	Tue Jun 18 13:51:36 2002
@@ -11,7 +11,7 @@
  * 
  *     Copyright (c) 1997, 1999 Dag Brattli <dagb@cs.uit.no>, 
  *     All Rights Reserved.
- *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -32,7 +32,7 @@
 #include <net/irda/irda.h>
 #include <net/irda/irtty.h>
 #include <net/irda/irlap.h>
-#include <net/irda/irlmp_event.h>
+#include <net/irda/irlmp.h>
 
 static void irlap_slot_timer_expired(void* data);
 static void irlap_query_timer_expired(void* data);

