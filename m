Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288966AbSAIVa6>; Wed, 9 Jan 2002 16:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289026AbSAIVaj>; Wed, 9 Jan 2002 16:30:39 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:3578 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S288966AbSAIVaU>;
	Wed, 9 Jan 2002 16:30:20 -0500
Date: Wed, 9 Jan 2002 13:30:13 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        coreythomas@charter.net
Subject: Re: Raylink WE patch
Message-ID: <20020109133013.A12131@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020108103459.B10734@bougret.hpl.hp.com> <87r8p0h8u4.fsf@bobo.spike.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87r8p0h8u4.fsf@bobo.spike.home>; from coreythomas@charter.net on Tue, Jan 08, 2002 at 03:43:47PM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	The attached patch fixes Wireless Extension for the raylink
driver. You are now able to set various Wireless Extensions but only
before opening the device (for example using /etc/pcmcia/wireless.opts
schemes). And I also fixed the bug that would crash the driver while
doing so (by not re-calling dl_startup_params()).
	I've tested the patch with kernel 2.4.16 and verified that it
still applies cleanly to 2.4.18-pre2 and 2.5.2-pre10. The patch has
been on my web page since before Chrismas and the maintainer gave
approval for me to submit it directly for inclusion in the kernel (see
below).
	Have fun...

	Jean

P.S. : People that feel adventurous could add the code to stop the
card on device close.

--------------------------
On Tue, Jan 08, 2002 at 03:43:47PM -0500, coreythomas@charter.net wrote:
> Hi Jean,
> 
> XXXXXXXXXXXXX, so I didn't get much done during
> Xmas.  So, feel free to submit it now if it is ready.
--------------------------


--- linux/drivers/net/pcmcia/ray_cs-t1.c	Thu Dec 13 17:53:39 2001
+++ linux/drivers/net/pcmcia/ray_cs.c	Fri Dec 14 11:33:08 2001
@@ -999,7 +999,9 @@ static int ray_event(event_t event, int 
 /*===========================================================================*/
 int ray_dev_init(struct net_device *dev)
 {
+#ifdef RAY_IMMEDIATE_INIT
     int i;
+#endif	/* RAY_IMMEDIATE_INIT */
     ray_dev_t *local = dev->priv;
     dev_link_t *link = local->finder;
 
@@ -1008,6 +1010,7 @@ int ray_dev_init(struct net_device *dev)
         DEBUG(2,"ray_dev_init - device not present\n");
         return -1;
     }
+#ifdef RAY_IMMEDIATE_INIT
     /* Download startup parameters */
     if ( (i = dl_startup_params(dev)) < 0)
     {
@@ -1015,7 +1018,14 @@ int ray_dev_init(struct net_device *dev)
            "returns 0x%x\n",i);
         return -1;
     }
-    
+#else	/* RAY_IMMEDIATE_INIT */
+    /* Postpone the card init so that we can still configure the card,
+     * for example using the Wireless Extensions. The init will happen
+     * in ray_open() - Jean II */
+    DEBUG(1,"ray_dev_init: postponing card init to ray_open() ; Status = %d\n",
+	  local->card_status);
+#endif	/* RAY_IMMEDIATE_INIT */
+
     /* copy mac and broadcast addresses to linux device */
     memcpy(&dev->dev_addr, &local->sparm.b4.a_mac_addr, ADDRLEN);
     memset(dev->broadcast, 0xff, ETH_ALEN);
@@ -1245,6 +1255,22 @@ static int ray_dev_ioctl(struct net_devi
       wrq->u.freq.e = 0;
       break;
 
+      /* Set frequency/channel */
+    case SIOCSIWFREQ:
+      /* Reject if card is already initialised */
+      if(local->card_status != CARD_AWAITING_PARAM)
+	{
+	  err = -EBUSY;
+	  break;
+	}
+
+      /* Setting by channel number */
+      if ((wrq->u.freq.m > USA_HOP_MOD) || (wrq->u.freq.e > 0))
+	err = -EOPNOTSUPP;
+      else
+	  local->sparm.b5.a_hop_pattern = wrq->u.freq.m;
+      break;
+
       /* Get current network name (ESSID) */
     case SIOCGIWESSID:
       if (wrq->u.data.pointer)
@@ -1262,6 +1288,46 @@ static int ray_dev_ioctl(struct net_devi
 	}
       break;
 
+      /* Set desired network name (ESSID) */
+    case SIOCSIWESSID:
+      /* Reject if card is already initialised */
+      if(local->card_status != CARD_AWAITING_PARAM)
+	{
+	  err = -EBUSY;
+	  break;
+	}
+
+	if (wrq->u.data.pointer)
+	{
+	    char	card_essid[IW_ESSID_MAX_SIZE + 1];
+	    
+	    /* Check if we asked for `any' */
+	    if(wrq->u.data.flags == 0)
+	    {
+		/* Corey : can you do that ? */
+		err = -EOPNOTSUPP;
+	    }
+	    else
+	    {
+		/* Check the size of the string */
+		if(wrq->u.data.length >
+		   IW_ESSID_MAX_SIZE + 1)
+		{
+		    err = -E2BIG;
+		    break;
+		}
+		copy_from_user(card_essid,
+			       wrq->u.data.pointer,
+			       wrq->u.data.length);
+		card_essid[IW_ESSID_MAX_SIZE] = '\0';
+
+		/* Set the ESSID in the card */
+		memcpy(local->sparm.b5.a_current_ess_id, card_essid,
+		       IW_ESSID_MAX_SIZE);
+	    }
+	}
+	break;
+
       /* Get current Access Point (BSSID in our case) */
     case SIOCGIWAP:
       memcpy(wrq->u.ap_addr.sa_data, local->bss_id, ETH_ALEN);
@@ -1304,6 +1370,34 @@ static int ray_dev_ioctl(struct net_devi
       wrq->u.rts.fixed = 1;
       break;
 
+      /* Set the desired RTS threshold */
+    case SIOCSIWRTS:
+    {
+	int rthr = wrq->u.rts.value;
+
+      /* Reject if card is already initialised */
+      if(local->card_status != CARD_AWAITING_PARAM)
+	{
+	  err = -EBUSY;
+	  break;
+	}
+
+	/* if(wrq->u.rts.fixed == 0) we should complain */
+#if WIRELESS_EXT > 8
+	if(wrq->u.rts.disabled)
+	    rthr = 32767;
+	else
+#endif /* WIRELESS_EXT > 8 */
+	    if((rthr < 0) || (rthr > 2347)) /* What's the max packet size ??? */
+	    {
+		err = -EINVAL;
+		break;
+	    }
+	local->sparm.b5.a_rts_threshold[0] = (rthr >> 8) & 0xFF;
+	local->sparm.b5.a_rts_threshold[1] = rthr & 0xFF;
+    }
+    break;
+
       /* Get the current fragmentation threshold */
     case SIOCGIWFRAG:
       wrq->u.frag.value = (local->sparm.b5.a_frag_threshold[0] << 8)
@@ -1313,6 +1407,35 @@ static int ray_dev_ioctl(struct net_devi
 #endif /* WIRELESS_EXT > 8 */
       wrq->u.frag.fixed = 1;
       break;
+
+      /* Set the desired fragmentation threshold */
+    case SIOCSIWFRAG:
+    {
+	int fthr = wrq->u.frag.value;
+
+      /* Reject if card is already initialised */
+      if(local->card_status != CARD_AWAITING_PARAM)
+	{
+	  err = -EBUSY;
+	  break;
+	}
+
+	/* if(wrq->u.frag.fixed == 0) should complain */
+#if WIRELESS_EXT > 8
+	if(wrq->u.frag.disabled)
+	    fthr = 32767;
+	else
+#endif /* WIRELESS_EXT > 8 */
+	    if((fthr < 256) || (fthr > 2347)) /* To check out ! */
+	    {
+		err = -EINVAL;
+		break;
+	    }
+	local->sparm.b5.a_frag_threshold[0] = (fthr >> 8) & 0xFF;
+	local->sparm.b5.a_frag_threshold[1] = fthr & 0xFF;
+    }
+    break;
+
 #endif	/* WIRELESS_EXT > 7 */
 #if WIRELESS_EXT > 8
 
@@ -1323,6 +1446,33 @@ static int ray_dev_ioctl(struct net_devi
       else
 	wrq->u.mode = IW_MODE_ADHOC;
       break;
+
+      /* Set the current mode of operation */
+    case SIOCSIWMODE:
+    {
+	char card_mode = 1;
+	
+      /* Reject if card is already initialised */
+      if(local->card_status != CARD_AWAITING_PARAM)
+	{
+	  err = -EBUSY;
+	  break;
+	}
+
+	switch (wrq->u.mode)
+	{
+	case IW_MODE_ADHOC:
+	    card_mode = 0;
+	    // Fall through
+	case IW_MODE_INFRA:
+	    local->sparm.b5.a_network_type = card_mode;
+	    break;
+	default:
+	    err = -EINVAL;
+	}
+    }
+    break;
+
 #endif /* WIRELESS_EXT > 8 */
 #if WIRELESS_EXT > 7
       /* ------------------ IWSPY SUPPORT ------------------ */
@@ -1549,6 +1699,21 @@ static int ray_open(struct net_device *d
     if (link->open == 0) local->num_multi = 0;
     link->open++;
 
+    /* If the card is not started, time to start it ! - Jean II */
+    if(local->card_status == CARD_AWAITING_PARAM) {
+	int i;
+
+	DEBUG(1,"ray_open: doing init now !\n");
+
+	/* Download startup parameters */
+	if ( (i = dl_startup_params(dev)) < 0)
+	  {
+	    printk(KERN_INFO "ray_dev_init dl_startup_params failed - "
+		   "returns 0x%x\n",i);
+	    return -1;
+	  }
+     }
+
     if (sniffer) netif_stop_queue(dev);
     else         netif_start_queue(dev);
 
@@ -1571,6 +1736,11 @@ static int ray_dev_close(struct net_devi
     netif_stop_queue(dev);
     if (link->state & DEV_STALE_CONFIG)
 	mod_timer(&link->release, jiffies + HZ/20);
+
+    /* In here, we should stop the hardware (stop card from beeing active)
+     * and set local->card_status to CARD_AWAITING_PARAM, so that while the
+     * card is closed we can chage its configuration.
+     * Probably also need a COR reset to get sane state - Jean II */
 
     MOD_DEC_USE_COUNT;
 
