Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbSBDTEU>; Mon, 4 Feb 2002 14:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSBDTEF>; Mon, 4 Feb 2002 14:04:05 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:9169 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S286263AbSBDTDr>;
	Mon, 4 Feb 2002 14:03:47 -0500
Date: Mon, 4 Feb 2002 11:03:45 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.3] netwave_cs : new WE api
Message-ID: <20020204110345.C6533@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Jeff,

        Same story, just forward to Linus...

        This update the netwave_cs driver in 2.5.3 to the new wireless
API. This also fixes the copy_to/from_user() done with irq disabled
(so Alan will be happy). And, I've also fixed the getsitesurvey
private command by putting it on a SET command. Tested on 2.5.3.

        Have fun...

        Jean

P.S. : By the way, do you like IrDA patches ?

-----------------------------------------------------

diff -u -p -r linux/drivers/net/wireless-w12/netwave_cs.c linux/drivers/net/wireless/netwave_cs.c
--- linux/drivers/net/wireless-w12/netwave_cs.c	Wed Jan 23 16:09:29 2002
+++ linux/drivers/net/wireless/netwave_cs.c	Wed Jan 23 16:44:15 2002
@@ -63,6 +63,9 @@
 
 #ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>
+#if WIRELESS_EXT > 12
+#include <net/iw_handler.h>
+#endif	/* WIRELESS_EXT > 12 */
 #endif
 
 #include <pcmcia/version.h>
@@ -269,6 +272,16 @@ static dev_link_t *dev_list;
    because they generally can't be allocated dynamically.
 */
 
+#if WIRELESS_EXT <= 12
+/* Wireless extensions backward compatibility */
+
+/* Part of iw_handler prototype we need */
+struct iw_request_info
+{
+	__u16		cmd;		/* Wireless Extension command */
+	__u16		flags;		/* More to come ;-) */
+};
+
 /* Wireless Extension Backward compatibility - Jean II
  * If the new wireless device private ioctl range is not defined,
  * default to standard device private ioctl range */
@@ -276,8 +289,11 @@ static dev_link_t *dev_list;
 #define SIOCIWFIRSTPRIV	SIOCDEVPRIVATE
 #endif /* SIOCIWFIRSTPRIV */
 
-#define SIOCGIPSNAP	SIOCIWFIRSTPRIV		/* Site Survey Snapshot */
-/*#define SIOCGIPQTHR	SIOCIWFIRSTPRIV + 1*/
+#else	/* WIRELESS_EXT <= 12 */
+static const struct iw_handler_def	netwave_handler_def;
+#endif	/* WIRELESS_EXT <= 12 */
+
+#define SIOCGIPSNAP	SIOCIWFIRSTPRIV	+ 1	/* Site Survey Snapshot */
 
 #define MAX_ESA 10
 
@@ -483,7 +499,10 @@ static dev_link_t *netwave_attach(void)
     /* wireless extensions */
 #ifdef WIRELESS_EXT
     dev->get_wireless_stats = &netwave_get_wireless_stats;
-#endif
+#if WIRELESS_EXT > 12
+    dev->wireless_handlers = (struct iw_handler_def *)&netwave_handler_def;
+#endif /* WIRELESS_EXT > 12 */
+#endif /* WIRELESS_EXT */
     dev->do_ioctl = &netwave_ioctl;
 
     dev->tx_timeout = &netwave_watchdog;
@@ -596,6 +615,303 @@ static void netwave_flush_stale_links(vo
 } /* netwave_flush_stale_links */
 
 /*
+ * Wireless Handler : get protocol name
+ */
+static int netwave_get_name(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	strcpy(wrqu->name, "Netwave");
+	return 0;
+}
+
+/*
+ * Wireless Handler : set Network ID
+ */
+static int netwave_set_nwid(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	unsigned long flags;
+	ioaddr_t iobase = dev->base_addr;
+	netwave_private *priv = (netwave_private *) dev->priv;
+	u_char *ramBase = priv->ramBase;
+
+	/* Disable interrupts & save flags */
+	save_flags(flags);
+	cli();
+
+#if WIRELESS_EXT > 8
+	if(!wrqu->nwid.disabled) {
+	    domain = wrqu->nwid.value;
+#else	/* WIRELESS_EXT > 8 */
+	if(wrqu->nwid.on) {
+	    domain = wrqu->nwid.nwid;
+#endif	/* WIRELESS_EXT > 8 */
+	    printk( KERN_DEBUG "Setting domain to 0x%x%02x\n", 
+		    (domain >> 8) & 0x01, domain & 0xff);
+	    wait_WOC(iobase);
+	    writeb(NETWAVE_CMD_SMD, ramBase + NETWAVE_EREG_CB + 0);
+	    writeb( domain & 0xff, ramBase + NETWAVE_EREG_CB + 1);
+	    writeb((domain >>8 ) & 0x01,ramBase + NETWAVE_EREG_CB+2);
+	    writeb(NETWAVE_CMD_EOC, ramBase + NETWAVE_EREG_CB + 3);
+	}
+
+	/* ReEnable interrupts & restore flags */
+	restore_flags(flags);
+    
+	return 0;
+}
+
+/*
+ * Wireless Handler : get Network ID
+ */
+static int netwave_get_nwid(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+#if WIRELESS_EXT > 8
+	wrqu->nwid.value = domain;
+	wrqu->nwid.disabled = 0;
+	wrqu->nwid.fixed = 1;
+#else	/* WIRELESS_EXT > 8 */
+	wrqu->nwid.nwid = domain;
+	wrqu->nwid.on = 1;
+#endif	/* WIRELESS_EXT > 8 */
+
+	return 0;
+}
+
+/*
+ * Wireless Handler : set scramble key
+ */
+static int netwave_set_scramble(struct net_device *dev,
+				struct iw_request_info *info,
+				union iwreq_data *wrqu,
+				char *key)
+{
+	unsigned long flags;
+	ioaddr_t iobase = dev->base_addr;
+	netwave_private *priv = (netwave_private *) dev->priv;
+	u_char *ramBase = priv->ramBase;
+
+	/* Disable interrupts & save flags */
+	save_flags(flags);
+	cli();
+
+	scramble_key = (key[0] << 8) | key[1];
+	wait_WOC(iobase);
+	writeb(NETWAVE_CMD_SSK, ramBase + NETWAVE_EREG_CB + 0);
+	writeb(scramble_key & 0xff, ramBase + NETWAVE_EREG_CB + 1);
+	writeb((scramble_key>>8) & 0xff, ramBase + NETWAVE_EREG_CB + 2);
+	writeb(NETWAVE_CMD_EOC, ramBase + NETWAVE_EREG_CB + 3);
+
+	/* ReEnable interrupts & restore flags */
+	restore_flags(flags);
+    
+	return 0;
+}
+
+/*
+ * Wireless Handler : get scramble key
+ */
+static int netwave_get_scramble(struct net_device *dev,
+				struct iw_request_info *info,
+				union iwreq_data *wrqu,
+				char *key)
+{
+	key[1] = scramble_key & 0xff;
+	key[0] = (scramble_key>>8) & 0xff;
+#if WIRELESS_EXT > 8
+	wrqu->encoding.flags = IW_ENCODE_ENABLED;
+	wrqu->encoding.length = 2;
+#else /* WIRELESS_EXT > 8 */
+	wrqu->encoding.method = 1;
+#endif	/* WIRELESS_EXT > 8 */
+
+	return 0;
+}
+
+#if WIRELESS_EXT > 8
+/*
+ * Wireless Handler : get mode
+ */
+static int netwave_get_mode(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	if(domain & 0x100)
+		wrqu->mode = IW_MODE_INFRA;
+	else
+		wrqu->mode = IW_MODE_ADHOC;
+
+	return 0;
+}
+#endif	/* WIRELESS_EXT > 8 */
+
+/*
+ * Wireless Handler : get range info
+ */
+static int netwave_get_range(struct net_device *dev,
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu,
+			     char *extra)
+{
+	struct iw_range *range = (struct iw_range *) extra;
+	int ret = 0;
+
+	/* Set the length (very important for backward compatibility) */
+	wrqu->data.length = sizeof(struct iw_range);
+
+	/* Set all the info we don't care or don't know about to zero */
+	memset(range, 0, sizeof(struct iw_range));
+
+#if WIRELESS_EXT > 10
+	/* Set the Wireless Extension versions */
+	range->we_version_compiled = WIRELESS_EXT;
+	range->we_version_source = 9;	/* Nothing for us in v10 and v11 */
+#endif /* WIRELESS_EXT > 10 */
+		   
+	/* Set information in the range struct */
+	range->throughput = 450 * 1000;	/* don't argue on this ! */
+	range->min_nwid = 0x0000;
+	range->max_nwid = 0x01FF;
+
+	range->num_channels = range->num_frequency = 0;
+		   
+	range->sensitivity = 0x3F;
+	range->max_qual.qual = 255;
+	range->max_qual.level = 255;
+	range->max_qual.noise = 0;
+		   
+#if WIRELESS_EXT > 7
+	range->num_bitrates = 1;
+	range->bitrate[0] = 1000000;	/* 1 Mb/s */
+#endif /* WIRELESS_EXT > 7 */
+
+#if WIRELESS_EXT > 8
+	range->encoding_size[0] = 2;		/* 16 bits scrambling */
+	range->num_encoding_sizes = 1;
+	range->max_encoding_tokens = 1;	/* Only one key possible */
+#endif /* WIRELESS_EXT > 8 */
+
+	return ret;
+}
+
+/*
+ * Wireless Private Handler : get snapshot
+ */
+static int netwave_get_snap(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	unsigned long flags;
+	ioaddr_t iobase = dev->base_addr;
+	netwave_private *priv = (netwave_private *) dev->priv;
+	u_char *ramBase = priv->ramBase;
+
+	/* Disable interrupts & save flags */
+	save_flags(flags);
+	cli();
+
+	/* Take snapshot of environment */
+	netwave_snapshot( priv, ramBase, iobase);
+	wrqu->data.length = priv->nss.length;
+	memcpy(extra, (u_char *) &priv->nss, sizeof( struct site_survey));
+
+	priv->lastExec = jiffies;
+
+	/* ReEnable interrupts & restore flags */
+	restore_flags(flags);
+    
+	return(0);
+}
+
+/*
+ * Structures to export the Wireless Handlers
+ *     This is the stuff that are treated the wireless extensions (iwconfig)
+ */
+
+static const struct iw_priv_args netwave_private_args[] = {
+/*{ cmd,         set_args,                            get_args, name } */
+  { SIOCGIPSNAP, 0, 
+    IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | sizeof(struct site_survey), 
+    "getsitesurvey" },
+};
+
+#if WIRELESS_EXT > 12
+
+static const iw_handler		netwave_handler[] =
+{
+	NULL,				/* SIOCSIWNAME */
+	netwave_get_name,		/* SIOCGIWNAME */
+	netwave_set_nwid,		/* SIOCSIWNWID */
+	netwave_get_nwid,		/* SIOCGIWNWID */
+	NULL,				/* SIOCSIWFREQ */
+	NULL,				/* SIOCGIWFREQ */
+	NULL,				/* SIOCSIWMODE */
+	netwave_get_mode,		/* SIOCGIWMODE */
+	NULL,				/* SIOCSIWSENS */
+	NULL,				/* SIOCGIWSENS */
+	NULL,				/* SIOCSIWRANGE */
+	netwave_get_range,		/* SIOCGIWRANGE */
+	NULL,				/* SIOCSIWPRIV */
+	NULL,				/* SIOCGIWPRIV */
+	NULL,				/* SIOCSIWSTATS */
+	NULL,				/* SIOCGIWSTATS */
+	NULL,				/* SIOCSIWSPY */
+	NULL,				/* SIOCGIWSPY */
+	NULL,				/* -- hole -- */
+	NULL,				/* -- hole -- */
+	NULL,				/* SIOCSIWAP */
+	NULL,				/* SIOCGIWAP */
+	NULL,				/* -- hole -- */
+	NULL,				/* SIOCGIWAPLIST */
+	NULL,				/* -- hole -- */
+	NULL,				/* -- hole -- */
+	NULL,				/* SIOCSIWESSID */
+	NULL,				/* SIOCGIWESSID */
+	NULL,				/* SIOCSIWNICKN */
+	NULL,				/* SIOCGIWNICKN */
+	NULL,				/* -- hole -- */
+	NULL,				/* -- hole -- */
+	NULL,				/* SIOCSIWRATE */
+	NULL,				/* SIOCGIWRATE */
+	NULL,				/* SIOCSIWRTS */
+	NULL,				/* SIOCGIWRTS */
+	NULL,				/* SIOCSIWFRAG */
+	NULL,				/* SIOCGIWFRAG */
+	NULL,				/* SIOCSIWTXPOW */
+	NULL,				/* SIOCGIWTXPOW */
+	NULL,				/* SIOCSIWRETRY */
+	NULL,				/* SIOCGIWRETRY */
+	netwave_set_scramble,		/* SIOCSIWENCODE */
+	netwave_get_scramble,		/* SIOCGIWENCODE */
+};
+
+static const iw_handler		netwave_private_handler[] =
+{
+	NULL,				/* SIOCIWFIRSTPRIV */
+	netwave_get_snap,		/* SIOCIWFIRSTPRIV + 1 */
+};
+
+static const struct iw_handler_def	netwave_handler_def =
+{
+	num_standard:	sizeof(netwave_handler)/sizeof(iw_handler),
+	num_private:	sizeof(netwave_private_handler)/sizeof(iw_handler),
+	num_private_args: sizeof(netwave_private_args)/sizeof(struct iw_priv_args),
+	standard:	(iw_handler *) netwave_handler,
+	private:	(iw_handler *) netwave_private_handler,
+	private_args:	(struct iw_priv_args *) netwave_private_args,
+};
+#endif /* WIRELESS_EXT > 12 */
+
+/*
  * Function netwave_ioctl (dev, rq, cmd)
  *
  *     Perform ioctl : config & info stuff
@@ -606,56 +922,28 @@ static int netwave_ioctl(struct net_devi
 			 struct ifreq *rq,	 /* Data passed */
 			 int	cmd)	     /* Ioctl number */
 {
-    unsigned long flags;
     int			ret = 0;
 #ifdef WIRELESS_EXT
-    ioaddr_t iobase = dev->base_addr;
-    netwave_private *priv = (netwave_private *) dev->priv;
-    u_char *ramBase = priv->ramBase;
+#if WIRELESS_EXT <= 12
     struct iwreq *wrq = (struct iwreq *) rq;
 #endif
+#endif
 	
     DEBUG(0, "%s: ->netwave_ioctl(cmd=0x%X)\n", dev->name, cmd);
 	
-    /* Disable interrupts & save flags */
-    save_flags(flags);
-    cli();
-
     /* Look what is the request */
     switch(cmd) {
 	/* --------------- WIRELESS EXTENSIONS --------------- */
 #ifdef WIRELESS_EXT
+#if WIRELESS_EXT <= 12
     case SIOCGIWNAME:
-	/* Get name */
-	strcpy(wrq->u.name, "Netwave");
+	netwave_get_name(dev, NULL, &(wrq->u), NULL);
 	break;
     case SIOCSIWNWID:
-	/* Set domain */
-#if WIRELESS_EXT > 8
-	if(!wrq->u.nwid.disabled) {
-	    domain = wrq->u.nwid.value;
-#else	/* WIRELESS_EXT > 8 */
-	if(wrq->u.nwid.on) {
-	    domain = wrq->u.nwid.nwid;
-#endif	/* WIRELESS_EXT > 8 */
-	    printk( KERN_DEBUG "Setting domain to 0x%x%02x\n", 
-		    (domain >> 8) & 0x01, domain & 0xff);
-	    wait_WOC(iobase);
-	    writeb(NETWAVE_CMD_SMD, ramBase + NETWAVE_EREG_CB + 0);
-	    writeb( domain & 0xff, ramBase + NETWAVE_EREG_CB + 1);
-	    writeb((domain >>8 ) & 0x01,ramBase + NETWAVE_EREG_CB+2);
-	    writeb(NETWAVE_CMD_EOC, ramBase + NETWAVE_EREG_CB + 3);
-	} break;
+	ret = netwave_set_nwid(dev, NULL, &(wrq->u), NULL);
+	break;
     case SIOCGIWNWID:
-	/* Read domain*/
-#if WIRELESS_EXT > 8
-	wrq->u.nwid.value = domain;
-	wrq->u.nwid.disabled = 0;
-	wrq->u.nwid.fixed = 1;
-#else	/* WIRELESS_EXT > 8 */
-	wrq->u.nwid.nwid = domain;
-	wrq->u.nwid.on = 1;
-#endif	/* WIRELESS_EXT > 8 */
+	ret = netwave_get_nwid(dev, NULL, &(wrq->u), NULL);
 	break;
 #if WIRELESS_EXT > 8	/* Note : The API did change... */
     case SIOCGIWENCODE:
@@ -663,10 +951,7 @@ static int netwave_ioctl(struct net_devi
 	if(wrq->u.encoding.pointer != (caddr_t) 0)
 	  {
 	    char	key[2];
-	    key[1] = scramble_key & 0xff;
-	    key[0] = (scramble_key>>8) & 0xff;
-	    wrq->u.encoding.flags = IW_ENCODE_ENABLED;
-	    wrq->u.encoding.length = 2;
+	    ret = netwave_get_scramble(dev, NULL, &(wrq->u), key);
 	    if(copy_to_user(wrq->u.encoding.pointer, key, 2))
 	      ret = -EFAULT;
 	  }
@@ -681,127 +966,68 @@ static int netwave_ioctl(struct net_devi
 		ret = -EFAULT;
 		break;
 	      }
-	    scramble_key = (key[0] << 8) | key[1];
-	    wait_WOC(iobase);
-	    writeb(NETWAVE_CMD_SSK, ramBase + NETWAVE_EREG_CB + 0);
-	    writeb(scramble_key & 0xff, ramBase + NETWAVE_EREG_CB + 1);
-	    writeb((scramble_key>>8) & 0xff, ramBase + NETWAVE_EREG_CB + 2);
-	    writeb(NETWAVE_CMD_EOC, ramBase + NETWAVE_EREG_CB + 3);
+	    ret = netwave_set_scramble(dev, NULL, &(wrq->u), key);
 	  }
 	break;
     case SIOCGIWMODE:
-      /* Mode of operation */
-	if(domain & 0x100)
-	  wrq->u.mode = IW_MODE_INFRA;
-	else
-	  wrq->u.mode = IW_MODE_ADHOC;
-      break;
+	/* Mode of operation */
+	ret = netwave_get_mode(dev, NULL, &(wrq->u), NULL);
+	break;
 #else /* WIRELESS_EXT > 8 */
     case SIOCGIWENCODE:
 	/* Get scramble key */
-	wrq->u.encoding.code = scramble_key;
-	wrq->u.encoding.method = 1;
+	ret = netwave_get_scramble(dev, NULL, &(wrq->u),
+				   (char *) &wrq->u.encoding.code);
 	break;
     case SIOCSIWENCODE:
 	/* Set  scramble key */
-	scramble_key = wrq->u.encoding.code;
-	wait_WOC(iobase);
-	writeb(NETWAVE_CMD_SSK, ramBase + NETWAVE_EREG_CB + 0);
-	writeb(scramble_key & 0xff, ramBase + NETWAVE_EREG_CB + 1);
-	writeb((scramble_key>>8) & 0xff, ramBase + NETWAVE_EREG_CB + 2);
-	writeb(NETWAVE_CMD_EOC, ramBase + NETWAVE_EREG_CB + 3);
+	ret = netwave_set_scramble(dev, NULL, &(wrq->u),
+				   (char *) &wrq->u.encoding.code);
 	break;
 #endif /* WIRELESS_EXT > 8 */
    case SIOCGIWRANGE:
        /* Basic checking... */
        if(wrq->u.data.pointer != (caddr_t) 0) {
-	   struct iw_range	range;
-		   
-	   /* Set the length (very important for backward compatibility) */
-	   wrq->u.data.length = sizeof(struct iw_range);
-
-	   /* Set all the info we don't care or don't know about to zero */
-	   memset(&range, 0, sizeof(range));
-
-#if WIRELESS_EXT > 10
-	   /* Set the Wireless Extension versions */
-	   range.we_version_compiled = WIRELESS_EXT;
-	   range.we_version_source = 9;	/* Nothing for us in v10 and v11 */
-#endif /* WIRELESS_EXT > 10 */
-		   
-	   /* Set information in the range struct */
-	   range.throughput = 450 * 1000;	/* don't argue on this ! */
-	   range.min_nwid = 0x0000;
-	   range.max_nwid = 0x01FF;
-
-	   range.num_channels = range.num_frequency = 0;
-		   
-	   range.sensitivity = 0x3F;
-	   range.max_qual.qual = 255;
-	   range.max_qual.level = 255;
-	   range.max_qual.noise = 0;
-		   
-#if WIRELESS_EXT > 7
-	   range.num_bitrates = 1;
-	   range.bitrate[0] = 1000000;	/* 1 Mb/s */
-#endif /* WIRELESS_EXT > 7 */
-
-#if WIRELESS_EXT > 8
-	   range.encoding_size[0] = 2;		/* 16 bits scrambling */
-	   range.num_encoding_sizes = 1;
-	   range.max_encoding_tokens = 1;	/* Only one key possible */
-#endif /* WIRELESS_EXT > 8 */
-
-	   /* Copy structure to the user buffer */
-	   if(copy_to_user(wrq->u.data.pointer, &range,
-			sizeof(struct iw_range)))
-	     ret = -EFAULT;
+           struct iw_range range;
+	   ret = netwave_get_range(dev, NULL, &(wrq->u), (char *) &range);
+	   if (copy_to_user(wrq->u.data.pointer, &range,
+			    sizeof(struct iw_range)))
+	       ret = -EFAULT;
        }
        break;
     case SIOCGIWPRIV:
 	/* Basic checking... */
 	if(wrq->u.data.pointer != (caddr_t) 0) {
-	    struct iw_priv_args	priv[] =
-	    {	/* cmd,		set_args,	get_args,	name */
-		{ SIOCGIPSNAP, IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | 0, 
-		  sizeof(struct site_survey), 
-		  "getsitesurvey" },
-	    };
-			
 	    /* Set the number of ioctl available */
-	    wrq->u.data.length = 1;
+	    wrq->u.data.length = sizeof(netwave_private_args) / sizeof(netwave_private_args[0]);
 			
 	    /* Copy structure to the user buffer */
-	    if(copy_to_user(wrq->u.data.pointer, (u_char *) priv,
-			 sizeof(priv)))
+	    if(copy_to_user(wrq->u.data.pointer,
+			    (u_char *) netwave_private_args,
+			    sizeof(netwave_private_args)))
 	      ret = -EFAULT;
 	} 
 	break;
     case SIOCGIPSNAP:
 	if(wrq->u.data.pointer != (caddr_t) 0) {
-	    /* Take snapshot of environment */
-	    netwave_snapshot( priv, ramBase, iobase);
-	    wrq->u.data.length = priv->nss.length;
+	    char buffer[sizeof( struct site_survey)];
+	    ret = netwave_get_snap(dev, NULL, &(wrq->u), buffer);
 	    /* Copy structure to the user buffer */
 	    if(copy_to_user(wrq->u.data.pointer, 
-			 (u_char *) &priv->nss,
-			 sizeof( struct site_survey)))
+			    buffer,
+			    sizeof( struct site_survey)))
 	      {
 		printk(KERN_DEBUG "Bad buffer!\n");
 		break;
 	      }
-
-	    priv->lastExec = jiffies;
 	}
 	break;
-#endif
+#endif /* WIRELESS_EXT <= 12 */
+#endif /* WIRELESS_EXT */
     default:
 	ret = -EOPNOTSUPP;
     }
 	
-    /* ReEnable interrupts & restore flags */
-    restore_flags(flags);
-    
     return ret;
 }
 
