Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286758AbSBDTCa>; Mon, 4 Feb 2002 14:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbSBDTCO>; Mon, 4 Feb 2002 14:02:14 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:5839 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S286263AbSBDTBl>;
	Mon, 4 Feb 2002 14:01:41 -0500
Date: Mon, 4 Feb 2002 11:01:38 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.3] wavelan_cs.c : new WE api
Message-ID: <20020204110138.B6533@bougret.hpl.hp.com>
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

	This update the wavelan_cs driver in 2.5.3 to the new wireless
API. This also fixes the copy_to/from_user() done with irq disabled
(so Alan will be happy). Tested on 2.5.3.

        Have fun...

        Jean

-----------------------------------------------------

diff -u -p -r linux/drivers/net/wireless-w12/wavelan_cs.c linux/drivers/net/wireless/wavelan_cs.c
--- linux/drivers/net/wireless-w12/wavelan_cs.c	Wed Jan 23 16:41:28 2002
+++ linux/drivers/net/wireless/wavelan_cs.c	Wed Jan 23 16:59:27 2002
@@ -1884,557 +1884,1234 @@ wl_his_gather(device *	dev,
 
 /*------------------------------------------------------------------*/
 /*
- * Perform ioctl : config & info stuff
- * This is here that are treated the wireless extensions (iwconfig)
+ * Wireless Handler : get protocol name
  */
-static int
-wavelan_ioctl(struct net_device *	dev,	/* Device on wich the ioctl apply */
-	      struct ifreq *	rq,	/* Data passed */
-	      int		cmd)	/* Ioctl number */
+static int wavelan_get_name(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
 {
-  ioaddr_t		base = dev->base_addr;
-  net_local *		lp = (net_local *)dev->priv;	/* lp is not unused */
-  struct iwreq *	wrq = (struct iwreq *) rq;
-  psa_t			psa;
-  mm_t			m;
-  unsigned long		flags;
-  int			ret = 0;
-
-#ifdef DEBUG_IOCTL_TRACE
-  printk(KERN_DEBUG "%s: ->wavelan_ioctl(cmd=0x%X)\n", dev->name, cmd);
-#endif
-
-  /* Disable interrupts & save flags */
-  wv_splhi(lp, &flags);
-
-  /* Look what is the request */
-  switch(cmd)
-    {
-      /* --------------- WIRELESS EXTENSIONS --------------- */
-
-    case SIOCGIWNAME:
-      strcpy(wrq->u.name, "Wavelan");
-      break;
+	strcpy(wrqu->name, "WaveLAN");
+	return 0;
+}
 
-    case SIOCSIWNWID:
-      /* Set NWID in wavelan */
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : set NWID
+ */
+static int wavelan_set_nwid(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	ioaddr_t base = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	mm_t m;
+	unsigned long flags;
+	int ret = 0;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Set NWID in WaveLAN. */
 #if WIRELESS_EXT > 8
-      if(!wrq->u.nwid.disabled)
-	{
-	  /* Set NWID in psa */
-	  psa.psa_nwid[0] = (wrq->u.nwid.value & 0xFF00) >> 8;
-	  psa.psa_nwid[1] = wrq->u.nwid.value & 0xFF;
+	if (!wrqu->nwid.disabled) {
+		/* Set NWID in psa */
+		psa.psa_nwid[0] = (wrqu->nwid.value & 0xFF00) >> 8;
+		psa.psa_nwid[1] = wrqu->nwid.value & 0xFF;
 #else	/* WIRELESS_EXT > 8 */
-      if(wrq->u.nwid.on)
-	{
-	  /* Set NWID in psa */
-	  psa.psa_nwid[0] = (wrq->u.nwid.nwid & 0xFF00) >> 8;
-	  psa.psa_nwid[1] = wrq->u.nwid.nwid & 0xFF;
+	if(wrq->u.nwid.on) {
+		/* Set NWID in psa */
+		psa.psa_nwid[0] = (wrq->u.nwid.nwid & 0xFF00) >> 8;
+		psa.psa_nwid[1] = wrq->u.nwid.nwid & 0xFF;
 #endif	/* WIRELESS_EXT > 8 */
-	  psa.psa_nwid_select = 0x01;
-	  psa_write(dev, (char *)psa.psa_nwid - (char *)&psa,
-		    (unsigned char *)psa.psa_nwid, 3);
-
-	  /* Set NWID in mmc */
-	  m.w.mmw_netw_id_l = psa.psa_nwid[1];
-	  m.w.mmw_netw_id_h = psa.psa_nwid[0];
-	  mmc_write(base, (char *)&m.w.mmw_netw_id_l - (char *)&m,
-		    (unsigned char *)&m.w.mmw_netw_id_l, 2);
-	  mmc_out(base, mmwoff(0, mmw_loopt_sel), 0x00);
+		psa.psa_nwid_select = 0x01;
+		psa_write(dev,
+			  (char *) psa.psa_nwid - (char *) &psa,
+			  (unsigned char *) psa.psa_nwid, 3);
+
+		/* Set NWID in mmc. */
+		m.w.mmw_netw_id_l = psa.psa_nwid[1];
+		m.w.mmw_netw_id_h = psa.psa_nwid[0];
+		mmc_write(base,
+			  (char *) &m.w.mmw_netw_id_l -
+			  (char *) &m,
+			  (unsigned char *) &m.w.mmw_netw_id_l, 2);
+		mmc_out(base, mmwoff(0, mmw_loopt_sel), 0x00);
+	} else {
+		/* Disable NWID in the psa. */
+		psa.psa_nwid_select = 0x00;
+		psa_write(dev,
+			  (char *) &psa.psa_nwid_select -
+			  (char *) &psa,
+			  (unsigned char *) &psa.psa_nwid_select,
+			  1);
+
+		/* Disable NWID in the mmc (no filtering). */
+		mmc_out(base, mmwoff(0, mmw_loopt_sel),
+			MMW_LOOPT_SEL_DIS_NWID);
 	}
-      else
-	{
-	  /* Disable nwid in the psa */
-	  psa.psa_nwid_select = 0x00;
-	  psa_write(dev, (char *)&psa.psa_nwid_select - (char *)&psa,
-		    (unsigned char *)&psa.psa_nwid_select, 1);
+	/* update the Wavelan checksum */
+	update_psa_checksum(dev);
 
-	  /* Disable nwid in the mmc (no filtering) */
-	  mmc_out(base, mmwoff(0, mmw_loopt_sel), MMW_LOOPT_SEL_DIS_NWID);
-	}
-      /* update the Wavelan checksum */
-      update_psa_checksum(dev);
-      break;
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
 
-    case SIOCGIWNWID:
-      /* Read the NWID */
-      psa_read(dev, (char *)psa.psa_nwid - (char *)&psa,
-	       (unsigned char *)psa.psa_nwid, 3);
+	return ret;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : get NWID 
+ */
+static int wavelan_get_nwid(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	unsigned long flags;
+	int ret = 0;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Read the NWID. */
+	psa_read(dev,
+		 (char *) psa.psa_nwid - (char *) &psa,
+		 (unsigned char *) psa.psa_nwid, 3);
 #if WIRELESS_EXT > 8
-      wrq->u.nwid.value = (psa.psa_nwid[0] << 8) + psa.psa_nwid[1];
-      wrq->u.nwid.disabled = !(psa.psa_nwid_select);
-      wrq->u.nwid.fixed = 1;	/* Superfluous */
+	wrqu->nwid.value = (psa.psa_nwid[0] << 8) + psa.psa_nwid[1];
+	wrqu->nwid.disabled = !(psa.psa_nwid_select);
+	wrqu->nwid.fixed = 1;	/* Superfluous */
 #else	/* WIRELESS_EXT > 8 */
-      wrq->u.nwid.nwid = (psa.psa_nwid[0] << 8) + psa.psa_nwid[1];
-      wrq->u.nwid.on = psa.psa_nwid_select;
+	wrq->u.nwid.nwid = (psa.psa_nwid[0] << 8) + psa.psa_nwid[1];
+	wrq->u.nwid.on = psa.psa_nwid_select;
 #endif	/* WIRELESS_EXT > 8 */
-      break;
 
-    case SIOCSIWFREQ:
-      /* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable) */
-      if(!(mmc_in(base, mmroff(0, mmr_fee_status)) &
-	   (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY)))
-	ret = wv_set_frequency(base, &(wrq->u.freq));
-      else
-	ret = -EOPNOTSUPP;
-      break;
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
 
-    case SIOCGIWFREQ:
-      /* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable)
-       * (does it work for everybody ? - especially old cards...) */
-      if(!(mmc_in(base, mmroff(0, mmr_fee_status)) &
-	   (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY)))
-	{
-	  unsigned short	freq;
-
-	  /* Ask the EEprom to read the frequency from the first area */
-	  fee_read(base, 0x00 /* 1st area - frequency... */,
-		   &freq, 1);
-	  wrq->u.freq.m = ((freq >> 5) * 5 + 24000L) * 10000;
-	  wrq->u.freq.e = 1;
-	}
-      else
-	{
-	  psa_read(dev, (char *)&psa.psa_subband - (char *)&psa,
-		   (unsigned char *)&psa.psa_subband, 1);
+	return ret;
+}
 
-	  if(psa.psa_subband <= 4)
-	    {
-	      wrq->u.freq.m = fixed_bands[psa.psa_subband];
-	      wrq->u.freq.e = (psa.psa_subband != 0);
-	    }
-	  else
-	    ret = -EOPNOTSUPP;
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : set frequency
+ */
+static int wavelan_set_freq(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	ioaddr_t base = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	unsigned long flags;
+	int ret;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable). */
+	if (!(mmc_in(base, mmroff(0, mmr_fee_status)) &
+	      (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY)))
+		ret = wv_set_frequency(base, &(wrqu->freq));
+	else
+		ret = -EOPNOTSUPP;
+
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
+
+	return ret;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : get frequency
+ */
+static int wavelan_get_freq(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	ioaddr_t base = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	unsigned long flags;
+	int ret = 0;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable).
+	 * Does it work for everybody, especially old cards? */
+	if (!(mmc_in(base, mmroff(0, mmr_fee_status)) &
+	      (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY))) {
+		unsigned short freq;
+
+		/* Ask the EEPROM to read the frequency from the first area. */
+		fee_read(base, 0x00, &freq, 1);
+		wrqu->freq.m = ((freq >> 5) * 5 + 24000L) * 10000;
+		wrqu->freq.e = 1;
+	} else {
+		psa_read(dev,
+			 (char *) &psa.psa_subband - (char *) &psa,
+			 (unsigned char *) &psa.psa_subband, 1);
+
+		if (psa.psa_subband <= 4) {
+			wrqu->freq.m = fixed_bands[psa.psa_subband];
+			wrqu->freq.e = (psa.psa_subband != 0);
+		} else
+			ret = -EOPNOTSUPP;
 	}
-      break;
 
-    case SIOCSIWSENS:
-      /* Set the level threshold */
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
+
+	return ret;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : set level threshold
+ */
+static int wavelan_set_sens(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	ioaddr_t base = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	unsigned long flags;
+	int ret = 0;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Set the level threshold. */
 #if WIRELESS_EXT > 7
-      /* We should complain loudly if wrq->u.sens.fixed = 0, because we
-       * can't set auto mode... */
-      psa.psa_thr_pre_set = wrq->u.sens.value & 0x3F;
+	/* We should complain loudly if wrqu->sens.fixed = 0, because we
+	 * can't set auto mode... */
+	psa.psa_thr_pre_set = wrqu->sens.value & 0x3F;
 #else	/* WIRELESS_EXT > 7 */
-      psa.psa_thr_pre_set = wrq->u.sensitivity & 0x3F;
+	psa.psa_thr_pre_set = wrq->u.sensitivity & 0x3F;
 #endif	/* WIRELESS_EXT > 7 */
-      psa_write(dev, (char *)&psa.psa_thr_pre_set - (char *)&psa,
-	       (unsigned char *)&psa.psa_thr_pre_set, 1);
-      /* update the Wavelan checksum */
-      update_psa_checksum(dev);
-      mmc_out(base, mmwoff(0, mmw_thr_pre_set), psa.psa_thr_pre_set);
-      break;
+	psa_write(dev,
+		  (char *) &psa.psa_thr_pre_set - (char *) &psa,
+		  (unsigned char *) &psa.psa_thr_pre_set, 1);
+	/* update the Wavelan checksum */
+	update_psa_checksum(dev);
+	mmc_out(base, mmwoff(0, mmw_thr_pre_set),
+		psa.psa_thr_pre_set);
 
-    case SIOCGIWSENS:
-      /* Read the level threshold */
-      psa_read(dev, (char *)&psa.psa_thr_pre_set - (char *)&psa,
-	       (unsigned char *)&psa.psa_thr_pre_set, 1);
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
+
+	return ret;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : get level threshold
+ */
+static int wavelan_get_sens(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	unsigned long flags;
+	int ret = 0;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Read the level threshold. */
+	psa_read(dev,
+		 (char *) &psa.psa_thr_pre_set - (char *) &psa,
+		 (unsigned char *) &psa.psa_thr_pre_set, 1);
 #if WIRELESS_EXT > 7
-      wrq->u.sens.value = psa.psa_thr_pre_set & 0x3F;
-      wrq->u.sens.fixed = 1;
+	wrqu->sens.value = psa.psa_thr_pre_set & 0x3F;
+	wrqu->sens.fixed = 1;
 #else	/* WIRELESS_EXT > 7 */
-      wrq->u.sensitivity = psa.psa_thr_pre_set & 0x3F;
+	wrq->u.sensitivity = psa.psa_thr_pre_set & 0x3F;
 #endif	/* WIRELESS_EXT > 7 */
-      break;
+
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
+
+	return ret;
+}
 
 #if WIRELESS_EXT > 8
-    case SIOCSIWENCODE:
-      /* Set encryption key */
-      if(!mmc_encr(base))
-	{
-	  ret = -EOPNOTSUPP;
-	  break;
-	}
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : set encryption key
+ */
+static int wavelan_set_encode(struct net_device *dev,
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu,
+			      char *extra)
+{
+	ioaddr_t base = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	unsigned long flags;
+	psa_t psa;
+	int ret = 0;
 
-      /* Basic checking... */
-      if(wrq->u.encoding.pointer != (caddr_t) 0)
-	{
-	  /* Check the size of the key */
-	  if(wrq->u.encoding.length != 8)
-	    {
-	      ret = -EINVAL;
-	      break;
-	    }
-
-	  /* Copy the key in the driver */
-	  if(copy_from_user(psa.psa_encryption_key, wrq->u.encoding.pointer,
-			    wrq->u.encoding.length))
-	    {
-	      ret = -EFAULT;
-	      break;
-	    }
-
-	  psa.psa_encryption_select = 1;
-	  psa_write(dev, (char *) &psa.psa_encryption_select - (char *) &psa,
-		    (unsigned char *) &psa.psa_encryption_select, 8+1);
-
-	  mmc_out(base, mmwoff(0, mmw_encr_enable),
-		  MMW_ENCR_ENABLE_EN | MMW_ENCR_ENABLE_MODE);
-	  mmc_write(base, mmwoff(0, mmw_encr_key),
-		    (unsigned char *) &psa.psa_encryption_key, 8);
-	}
-
-      if(wrq->u.encoding.flags & IW_ENCODE_DISABLED)
-	{	/* disable encryption */
-	  psa.psa_encryption_select = 0;
-	  psa_write(dev, (char *) &psa.psa_encryption_select - (char *) &psa,
-		    (unsigned char *) &psa.psa_encryption_select, 1);
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
 
-	  mmc_out(base, mmwoff(0, mmw_encr_enable), 0);
+	/* Check if capable of encryption */
+	if (!mmc_encr(base)) {
+		ret = -EOPNOTSUPP;
 	}
-      /* update the Wavelan checksum */
-      update_psa_checksum(dev);
-      break;
 
-    case SIOCGIWENCODE:
-      /* Read the encryption key */
-      if(!mmc_encr(base))
-	{
-	  ret = -EOPNOTSUPP;
-	  break;
+	/* Check the size of the key */
+	if((wrqu->encoding.length != 8) && (wrqu->encoding.length != 0)) {
+		ret = -EINVAL;
 	}
 
-      /* only super-user can see encryption key */
-      if(!capable(CAP_NET_ADMIN))
-	{
-	  ret = -EPERM;
-	  break;
+	if(!ret) {
+		/* Basic checking... */
+		if (wrqu->encoding.length == 8) {
+			/* Copy the key in the driver */
+			memcpy(psa.psa_encryption_key, extra,
+			       wrqu->encoding.length);
+			psa.psa_encryption_select = 1;
+
+			psa_write(dev,
+				  (char *) &psa.psa_encryption_select -
+				  (char *) &psa,
+				  (unsigned char *) &psa.
+				  psa_encryption_select, 8 + 1);
+
+			mmc_out(base, mmwoff(0, mmw_encr_enable),
+				MMW_ENCR_ENABLE_EN | MMW_ENCR_ENABLE_MODE);
+			mmc_write(base, mmwoff(0, mmw_encr_key),
+				  (unsigned char *) &psa.
+				  psa_encryption_key, 8);
+		}
+
+		/* disable encryption */
+		if (wrqu->encoding.flags & IW_ENCODE_DISABLED) {
+			psa.psa_encryption_select = 0;
+			psa_write(dev,
+				  (char *) &psa.psa_encryption_select -
+				  (char *) &psa,
+				  (unsigned char *) &psa.
+				  psa_encryption_select, 1);
+
+			mmc_out(base, mmwoff(0, mmw_encr_enable), 0);
+		}
+		/* update the Wavelan checksum */
+		update_psa_checksum(dev);
 	}
 
-      /* Basic checking... */
-      if(wrq->u.encoding.pointer != (caddr_t) 0)
-	{
-	  psa_read(dev, (char *) &psa.psa_encryption_select - (char *) &psa,
-		   (unsigned char *) &psa.psa_encryption_select, 1+8);
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
 
-	  /* encryption is enabled ? */
-	  if(psa.psa_encryption_select)
-	    wrq->u.encoding.flags = IW_ENCODE_ENABLED;
-	  else
-	    wrq->u.encoding.flags = IW_ENCODE_DISABLED;
-	  wrq->u.encoding.flags |= mmc_encr(base);
-
-	  /* Copy the key to the user buffer */
-	  wrq->u.encoding.length = 8;
-	  if(copy_to_user(wrq->u.encoding.pointer, psa.psa_encryption_key, 8))
-	    ret = -EFAULT;
+	return ret;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : get encryption key
+ */
+static int wavelan_get_encode(struct net_device *dev,
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu,
+			      char *extra)
+{
+	ioaddr_t base = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	unsigned long flags;
+	int ret = 0;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Check if encryption is available */
+	if (!mmc_encr(base)) {
+		ret = -EOPNOTSUPP;
+	} else {
+		/* Read the encryption key */
+		psa_read(dev,
+			 (char *) &psa.psa_encryption_select -
+			 (char *) &psa,
+			 (unsigned char *) &psa.
+			 psa_encryption_select, 1 + 8);
+
+		/* encryption is enabled ? */
+		if (psa.psa_encryption_select)
+			wrqu->encoding.flags = IW_ENCODE_ENABLED;
+		else
+			wrqu->encoding.flags = IW_ENCODE_DISABLED;
+		wrqu->encoding.flags |= mmc_encr(base);
+
+		/* Copy the key to the user buffer */
+		wrqu->encoding.length = 8;
+		memcpy(extra, psa.psa_encryption_key, wrqu->encoding.length);
 	}
-      break;
+
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
+
+	return ret;
+}
 #endif	/* WIRELESS_EXT > 8 */
 
 #ifdef WAVELAN_ROAMING_EXT
 #if WIRELESS_EXT > 5
-    case SIOCSIWESSID:
-      /* Check if disable */
-      if(wrq->u.data.flags == 0)
-	lp->filter_domains = 0;
-      else
-	/* Basic checking... */
-	if(wrq->u.data.pointer != (caddr_t) 0)
-	  {
-	    char	essid[IW_ESSID_MAX_SIZE + 1];
-	    char *	endp;
-
-	    /* Check the size of the string */
-	    if(wrq->u.data.length > IW_ESSID_MAX_SIZE + 1)
-	      {
-		ret = -E2BIG;
-		break;
-	      }
-
-	    /* Copy the string in the driver */
-	    if(copy_from_user(essid, wrq->u.data.pointer, wrq->u.data.length))
-	      {
-		ret = -EFAULT;
-		break;
-	      }
-	    essid[IW_ESSID_MAX_SIZE] = '\0';
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : set ESSID (domain)
+ */
+static int wavelan_set_essid(struct net_device *dev,
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu,
+			     char *extra)
+{
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	unsigned long flags;
+	int ret = 0;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Check if disable */
+	if(wrqu->data.flags == 0)
+		lp->filter_domains = 0;
+	else {
+		char	essid[IW_ESSID_MAX_SIZE + 1];
+		char *	endp;
+
+		/* Terminate the string */
+		memcpy(essid, extra, wrqu->data.length);
+		essid[IW_ESSID_MAX_SIZE] = '\0';
 
 #ifdef DEBUG_IOCTL_INFO
-	    printk(KERN_DEBUG "SetEssid : ``%s''\n", essid);
+		printk(KERN_DEBUG "SetEssid : ``%s''\n", essid);
 #endif	/* DEBUG_IOCTL_INFO */
 
-	    /* Convert to a number (note : Wavelan specific) */
-	    lp->domain_id = simple_strtoul(essid, &endp, 16);
-	    /* Has it worked  ? */
-	    if(endp > essid)
-	      lp->filter_domains = 1;
-	    else
-	      {
-		lp->filter_domains = 0;
-		ret = -EINVAL;
-	      }
-	  }
-      break;
+		/* Convert to a number (note : Wavelan specific) */
+		lp->domain_id = simple_strtoul(essid, &endp, 16);
+		/* Has it worked  ? */
+		if(endp > essid)
+			lp->filter_domains = 1;
+		else {
+			lp->filter_domains = 0;
+			ret = -EINVAL;
+		}
+	}
 
-    case SIOCGIWESSID:
-      /* Basic checking... */
-      if(wrq->u.data.pointer != (caddr_t) 0)
-	{
-	  char		essid[IW_ESSID_MAX_SIZE + 1];
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
+
+	return ret;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : get ESSID (domain)
+ */
+static int wavelan_get_essid(struct net_device *dev,
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu,
+			     char *extra)
+{
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
 
-	  /* Is the domain ID active ? */
-	  wrq->u.data.flags = lp->filter_domains;
+	/* Is the domain ID active ? */
+	wrqu->data.flags = lp->filter_domains;
 
-	  /* Copy Domain ID into a string (Wavelan specific) */
-	  /* Sound crazy, be we can't have a snprintf in the kernel !!! */
-	  sprintf(essid, "%lX", lp->domain_id);
-	  essid[IW_ESSID_MAX_SIZE] = '\0';
+	/* Copy Domain ID into a string (Wavelan specific) */
+	/* Sound crazy, be we can't have a snprintf in the kernel !!! */
+	sprintf(extra, "%lX", lp->domain_id);
+	extra[IW_ESSID_MAX_SIZE] = '\0';
 
-	  /* Set the length */
-	  wrq->u.data.length = strlen(essid) + 1;
+	/* Set the length */
+	wrqu->data.length = strlen(extra) + 1;
 
-	  /* Copy structure to the user buffer */
-	  if(copy_to_user(wrq->u.data.pointer, essid, wrq->u.data.length))
-	    ret = -EFAULT;
-	}
-      break;
+	return 0;
+}
 
-    case SIOCSIWAP:
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : set AP address
+ */
+static int wavelan_set_wap(struct net_device *dev,
+			   struct iw_request_info *info,
+			   union iwreq_data *wrqu,
+			   char *extra)
+{
 #ifdef DEBUG_IOCTL_INFO
-      printk(KERN_DEBUG "Set AP to : %02X:%02X:%02X:%02X:%02X:%02X\n",
-	     wrq->u.ap_addr.sa_data[0],
-	     wrq->u.ap_addr.sa_data[1],
-	     wrq->u.ap_addr.sa_data[2],
-	     wrq->u.ap_addr.sa_data[3],
-	     wrq->u.ap_addr.sa_data[4],
-	     wrq->u.ap_addr.sa_data[5]);
+	printk(KERN_DEBUG "Set AP to : %02X:%02X:%02X:%02X:%02X:%02X\n",
+	       wrqu->ap_addr.sa_data[0],
+	       wrqu->ap_addr.sa_data[1],
+	       wrqu->ap_addr.sa_data[2],
+	       wrqu->ap_addr.sa_data[3],
+	       wrqu->ap_addr.sa_data[4],
+	       wrqu->ap_addr.sa_data[5]);
 #endif	/* DEBUG_IOCTL_INFO */
 
-      ret = -EOPNOTSUPP;	/* Not supported yet */
-      break;
+	return -EOPNOTSUPP;
+}
 
-    case SIOCGIWAP:
-      /* Should get the real McCoy instead of own Ethernet address */
-      memcpy(wrq->u.ap_addr.sa_data, dev->dev_addr, WAVELAN_ADDR_SIZE);
-      wrq->u.ap_addr.sa_family = ARPHRD_ETHER;
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : get AP address
+ */
+static int wavelan_get_wap(struct net_device *dev,
+			   struct iw_request_info *info,
+			   union iwreq_data *wrqu,
+			   char *extra)
+{
+	/* Should get the real McCoy instead of own Ethernet address */
+	memcpy(wrqu->ap_addr.sa_data, dev->dev_addr, WAVELAN_ADDR_SIZE);
+	wrqu->ap_addr.sa_family = ARPHRD_ETHER;
 
-      ret = -EOPNOTSUPP;	/* Not supported yet */
-      break;
+	return -EOPNOTSUPP;
+}
 #endif	/* WIRELESS_EXT > 5 */
 #endif	/* WAVELAN_ROAMING_EXT */
 
 #if WIRELESS_EXT > 8
 #ifdef WAVELAN_ROAMING
-    case SIOCSIWMODE:
-      switch(wrq->u.mode)
-	{
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : set mode
+ */
+static int wavelan_set_mode(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	unsigned long flags;
+	int ret = 0;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+
+	/* Check mode */
+	switch(wrqu->mode) {
 	case IW_MODE_ADHOC:
-	  if(do_roaming)
-	    {
-	      wv_roam_cleanup(dev);
-	      do_roaming = 0;
-	    }
-	  break;
+		if(do_roaming) {
+			wv_roam_cleanup(dev);
+			do_roaming = 0;
+		}
+		break;
 	case IW_MODE_INFRA:
-	  if(!do_roaming)
-	    {
-	      wv_roam_init(dev);
-	      do_roaming = 1;
-	    }
-	  break;
+		if(!do_roaming) {
+			wv_roam_init(dev);
+			do_roaming = 1;
+		}
+		break;
 	default:
-	  ret = -EINVAL;
+		ret = -EINVAL;
 	}
-      break;
 
-    case SIOCGIWMODE:
-      if(do_roaming)
-	wrq->u.mode = IW_MODE_INFRA;
-      else
-	wrq->u.mode = IW_MODE_ADHOC;
-      break;
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
+
+	return ret;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : get mode
+ */
+static int wavelan_get_mode(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	if(do_roaming)
+		wrqu->mode = IW_MODE_INFRA;
+	else
+		wrqu->mode = IW_MODE_ADHOC;
+
+	return 0;
+}
 #endif	/* WAVELAN_ROAMING */
 #endif /* WIRELESS_EXT > 8 */
 
-    case SIOCGIWRANGE:
-      /* Basic checking... */
-      if(wrq->u.data.pointer != (caddr_t) 0)
-	{
-	  struct iw_range	range;
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : get range info
+ */
+static int wavelan_get_range(struct net_device *dev,
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu,
+			     char *extra)
+{
+	ioaddr_t base = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	struct iw_range *range = (struct iw_range *) extra;
+	unsigned long flags;
+	int ret = 0;
 
-	   /* Set the length (very important for backward compatibility) */
-	   wrq->u.data.length = sizeof(struct iw_range);
+	/* Set the length (very important for backward compatibility) */
+	wrqu->data.length = sizeof(struct iw_range);
 
-	   /* Set all the info we don't care or don't know about to zero */
-	   memset(&range, 0, sizeof(range));
+	/* Set all the info we don't care or don't know about to zero */
+	memset(range, 0, sizeof(struct iw_range));
 
 #if WIRELESS_EXT > 10
-	   /* Set the Wireless Extension versions */
-	   range.we_version_compiled = WIRELESS_EXT;
-	   range.we_version_source = 9;	/* Nothing for us in v10 and v11 */
+	/* Set the Wireless Extension versions */
+	range->we_version_compiled = WIRELESS_EXT;
+	range->we_version_source = 9;
 #endif /* WIRELESS_EXT > 10 */
 
-	  /* Set information in the range struct */
-	  range.throughput = 1.4 * 1000 * 1000;	/* don't argue on this ! */
-	  range.min_nwid = 0x0000;
-	  range.max_nwid = 0xFFFF;
-
-	  /* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable) */
-	  if(!(mmc_in(base, mmroff(0, mmr_fee_status)) &
-	       (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY)))
-	    {
-	      range.num_channels = 10;
-	      range.num_frequency = wv_frequency_list(base, range.freq,
-						      IW_MAX_FREQUENCIES);
-	    }
-	  else
-	    range.num_channels = range.num_frequency = 0;
-
-	  range.sensitivity = 0x3F;
-	  range.max_qual.qual = MMR_SGNL_QUAL;
-	  range.max_qual.level = MMR_SIGNAL_LVL;
-	  range.max_qual.noise = MMR_SILENCE_LVL;
+	/* Set information in the range struct.  */
+	range->throughput = 1.4 * 1000 * 1000;	/* don't argue on this ! */
+	range->min_nwid = 0x0000;
+	range->max_nwid = 0xFFFF;
+
+	range->sensitivity = 0x3F;
+	range->max_qual.qual = MMR_SGNL_QUAL;
+	range->max_qual.level = MMR_SIGNAL_LVL;
+	range->max_qual.noise = MMR_SILENCE_LVL;
 #if WIRELESS_EXT > 11
-	  range.avg_qual.qual = MMR_SGNL_QUAL; /* Always max */
-	  /* Need to get better values for those two */
-	  range.avg_qual.level = 30;
-	  range.avg_qual.noise = 8;
+	range->avg_qual.qual = MMR_SGNL_QUAL; /* Always max */
+	/* Need to get better values for those two */
+	range->avg_qual.level = 30;
+	range->avg_qual.noise = 8;
 #endif /* WIRELESS_EXT > 11 */
 
 #if WIRELESS_EXT > 7
-	  range.num_bitrates = 1;
-	  range.bitrate[0] = 2000000;	/* 2 Mb/s */
+	range->num_bitrates = 1;
+	range->bitrate[0] = 2000000;	/* 2 Mb/s */
 #endif /* WIRELESS_EXT > 7 */
 
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable). */
+	if (!(mmc_in(base, mmroff(0, mmr_fee_status)) &
+	      (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY))) {
+		range->num_channels = 10;
+		range->num_frequency = wv_frequency_list(base, range->freq,
+							IW_MAX_FREQUENCIES);
+	} else
+		range->num_channels = range->num_frequency = 0;
+
 #if WIRELESS_EXT > 8
-	  /* Encryption supported ? */
-	  if(mmc_encr(base))
-	    {
-	      range.encoding_size[0] = 8;	/* DES = 64 bits key */
-	      range.num_encoding_sizes = 1;
-	      range.max_encoding_tokens = 1;	/* Only one key possible */
-	    }
-	  else
-	    {
-	      range.num_encoding_sizes = 0;
-	      range.max_encoding_tokens = 0;
-	    }
+	/* Encryption supported ? */
+	if (mmc_encr(base)) {
+		range->encoding_size[0] = 8;	/* DES = 64 bits key */
+		range->num_encoding_sizes = 1;
+		range->max_encoding_tokens = 1;	/* Only one key possible */
+	} else {
+		range->num_encoding_sizes = 0;
+		range->max_encoding_tokens = 0;
+	}
 #endif /* WIRELESS_EXT > 8 */
 
-	  /* Copy structure to the user buffer */
-	  if(copy_to_user(wrq->u.data.pointer, &range,
-			  sizeof(struct iw_range)))
-	    ret = -EFAULT;
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
+
+	return ret;
+}
+
+#ifdef WIRELESS_SPY
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : set spy list
+ */
+static int wavelan_set_spy(struct net_device *dev,
+			   struct iw_request_info *info,
+			   union iwreq_data *wrqu,
+			   char *extra)
+{
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	struct sockaddr *address = (struct sockaddr *) extra;
+	int i;
+	int ret = 0;
+
+	/* Disable spy while we copy the addresses.
+	 * As we don't disable interrupts, we need to do this */
+	lp->spy_number = 0;
+
+	/* Are there are addresses to copy? */
+	if (wrqu->data.length > 0) {
+		/* Copy addresses to the lp structure. */
+		for (i = 0; i < wrqu->data.length; i++) {
+			memcpy(lp->spy_address[i], address[i].sa_data,
+			       WAVELAN_ADDR_SIZE);
+		}
+
+		/* Reset structure. */
+		memset(lp->spy_stat, 0x00, sizeof(iw_qual) * IW_MAX_SPY);
+
+#ifdef DEBUG_IOCTL_INFO
+		printk(KERN_DEBUG
+		       "SetSpy:  set of new addresses is: \n");
+		for (i = 0; i < wrqu->data.length; i++)
+			printk(KERN_DEBUG
+			       "%02X:%02X:%02X:%02X:%02X:%02X \n",
+			       lp->spy_address[i][0],
+			       lp->spy_address[i][1],
+			       lp->spy_address[i][2],
+			       lp->spy_address[i][3],
+			       lp->spy_address[i][4],
+			       lp->spy_address[i][5]);
+#endif			/* DEBUG_IOCTL_INFO */
 	}
+
+	/* Now we can set the number of addresses */
+	lp->spy_number = wrqu->data.length;
+
+	return ret;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : get spy list
+ */
+static int wavelan_get_spy(struct net_device *dev,
+			   struct iw_request_info *info,
+			   union iwreq_data *wrqu,
+			   char *extra)
+{
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	struct sockaddr *address = (struct sockaddr *) extra;
+	int i;
+
+	/* Set the number of addresses */
+	wrqu->data.length = lp->spy_number;
+
+	/* Copy addresses from the lp structure. */
+	for (i = 0; i < lp->spy_number; i++) {
+		memcpy(address[i].sa_data,
+		       lp->spy_address[i],
+		       WAVELAN_ADDR_SIZE);
+		address[i].sa_family = AF_UNIX;
+	}
+	/* Copy stats to the user buffer (just after). */
+	if(lp->spy_number > 0)
+		memcpy(extra  + (sizeof(struct sockaddr) * lp->spy_number),
+		       lp->spy_stat, sizeof(iw_qual) * lp->spy_number);
+
+	/* Reset updated flags. */
+	for (i = 0; i < lp->spy_number; i++)
+		lp->spy_stat[i].updated = 0x0;
+
+	return(0);
+}
+#endif			/* WIRELESS_SPY */
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Private Handler : set quality threshold
+ */
+static int wavelan_set_qthr(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	ioaddr_t base = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	unsigned long flags;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	psa.psa_quality_thr = *(extra) & 0x0F;
+	psa_write(dev,
+		  (char *) &psa.psa_quality_thr - (char *) &psa,
+		  (unsigned char *) &psa.psa_quality_thr, 1);
+	/* update the Wavelan checksum */
+	update_psa_checksum(dev);
+	mmc_out(base, mmwoff(0, mmw_quality_thr),
+		psa.psa_quality_thr);
+
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
+
+	return 0;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Private Handler : get quality threshold
+ */
+static int wavelan_get_qthr(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	unsigned long flags;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	psa_read(dev,
+		 (char *) &psa.psa_quality_thr - (char *) &psa,
+		 (unsigned char *) &psa.psa_quality_thr, 1);
+	*(extra) = psa.psa_quality_thr & 0x0F;
+
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
+
+	return 0;
+}
+
+#ifdef WAVELAN_ROAMING
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Private Handler : set roaming
+ */
+static int wavelan_set_roam(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	unsigned long flags;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Note : should check if user == root */
+	if(do_roaming && (*extra)==0)
+		wv_roam_cleanup(dev);
+	else if(do_roaming==0 && (*extra)!=0)
+		wv_roam_init(dev);
+
+	do_roaming = (*extra);
+
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
+
+	return 0;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Private Handler : get quality threshold
+ */
+static int wavelan_get_roam(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	*(extra) = do_roaming;
+
+	return 0;
+}
+#endif	/* WAVELAN_ROAMING */
+
+#ifdef HISTOGRAM
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Private Handler : set histogram
+ */
+static int wavelan_set_histo(struct net_device *dev,
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu,
+			     char *extra)
+{
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+
+	/* Check the number of intervals. */
+	if (wrqu->data.length > 16) {
+		return(-E2BIG);
+	}
+
+	/* Disable histo while we copy the addresses.
+	 * As we don't disable interrupts, we need to do this */
+	lp->his_number = 0;
+
+	/* Are there ranges to copy? */
+	if (wrqu->data.length > 0) {
+		/* Copy interval ranges to the driver */
+		memcpy(lp->his_range, extra, wrqu->data.length);
+
+		{
+		  int i;
+		  printk(KERN_DEBUG "Histo :");
+		  for(i = 0; i < wrqu->data.length; i++)
+		    printk(" %d", lp->his_range[i]);
+		  printk("\n");
+		}
+
+		/* Reset result structure. */
+		memset(lp->his_sum, 0x00, sizeof(long) * 16);
+	}
+
+	/* Now we can set the number of ranges */
+	lp->his_number = wrqu->data.length;
+
+	return(0);
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Private Handler : get histogram
+ */
+static int wavelan_get_histo(struct net_device *dev,
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu,
+			     char *extra)
+{
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+
+	/* Set the number of intervals. */
+	wrqu->data.length = lp->his_number;
+
+	/* Give back the distribution statistics */
+	if(lp->his_number > 0)
+		memcpy(extra, lp->his_sum, sizeof(long) * lp->his_number);
+
+	return(0);
+}
+#endif			/* HISTOGRAM */
+
+/*------------------------------------------------------------------*/
+/*
+ * Structures to export the Wireless Handlers
+ */
+
+static const struct iw_priv_args wavelan_private_args[] = {
+/*{ cmd,         set_args,                            get_args, name } */
+  { SIOCSIPQTHR, IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | 1, 0, "setqualthr" },
+  { SIOCGIPQTHR, 0, IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | 1, "getqualthr" },
+  { SIOCSIPROAM, IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | 1, 0, "setroam" },
+  { SIOCGIPROAM, 0, IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | 1, "getroam" },
+  { SIOCSIPHISTO, IW_PRIV_TYPE_BYTE | 16,                    0, "sethisto" },
+  { SIOCGIPHISTO, 0,                     IW_PRIV_TYPE_INT | 16, "gethisto" },
+};
+
+#if WIRELESS_EXT > 12
+
+static const iw_handler		wavelan_handler[] =
+{
+	NULL,				/* SIOCSIWNAME */
+	wavelan_get_name,		/* SIOCGIWNAME */
+	wavelan_set_nwid,		/* SIOCSIWNWID */
+	wavelan_get_nwid,		/* SIOCGIWNWID */
+	wavelan_set_freq,		/* SIOCSIWFREQ */
+	wavelan_get_freq,		/* SIOCGIWFREQ */
+#ifdef WAVELAN_ROAMING
+	wavelan_set_mode,		/* SIOCSIWMODE */
+	wavelan_get_mode,		/* SIOCGIWMODE */
+#else	/* WAVELAN_ROAMING */
+	NULL,				/* SIOCSIWMODE */
+	NULL,				/* SIOCGIWMODE */
+#endif	/* WAVELAN_ROAMING */
+	wavelan_set_sens,		/* SIOCSIWSENS */
+	wavelan_get_sens,		/* SIOCGIWSENS */
+	NULL,				/* SIOCSIWRANGE */
+	wavelan_get_range,		/* SIOCGIWRANGE */
+	NULL,				/* SIOCSIWPRIV */
+	NULL,				/* SIOCGIWPRIV */
+	NULL,				/* SIOCSIWSTATS */
+	NULL,				/* SIOCGIWSTATS */
+#ifdef WIRELESS_SPY
+	wavelan_set_spy,		/* SIOCSIWSPY */
+	wavelan_get_spy,		/* SIOCGIWSPY */
+#else	/* WIRELESS_SPY */
+	NULL,				/* SIOCSIWSPY */
+	NULL,				/* SIOCGIWSPY */
+#endif	/* WIRELESS_SPY */
+	NULL,				/* -- hole -- */
+	NULL,				/* -- hole -- */
+#ifdef WAVELAN_ROAMING_EXT
+	wavelan_set_wap,		/* SIOCSIWAP */
+	wavelan_get_wap,		/* SIOCGIWAP */
+	NULL,				/* -- hole -- */
+	NULL,				/* SIOCGIWAPLIST */
+	NULL,				/* -- hole -- */
+	NULL,				/* -- hole -- */
+	wavelan_set_essid,		/* SIOCSIWESSID */
+	wavelan_get_essid,		/* SIOCGIWESSID */
+#else	/* WAVELAN_ROAMING_EXT */
+	NULL,				/* SIOCSIWAP */
+	NULL,				/* SIOCGIWAP */
+	NULL,				/* -- hole -- */
+	NULL,				/* SIOCGIWAPLIST */
+	NULL,				/* -- hole -- */
+	NULL,				/* -- hole -- */
+	NULL,				/* SIOCSIWESSID */
+	NULL,				/* SIOCGIWESSID */
+#endif	/* WAVELAN_ROAMING_EXT */
+#if WIRELESS_EXT > 8
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
+	wavelan_set_encode,		/* SIOCSIWENCODE */
+	wavelan_get_encode,		/* SIOCGIWENCODE */
+#endif	/* WIRELESS_EXT > 8 */
+};
+
+static const iw_handler		wavelan_private_handler[] =
+{
+	wavelan_set_qthr,		/* SIOCIWFIRSTPRIV */
+	wavelan_get_qthr,		/* SIOCIWFIRSTPRIV + 1 */
+#ifdef WAVELAN_ROAMING
+	wavelan_set_roam,		/* SIOCIWFIRSTPRIV + 2 */
+	wavelan_get_roam,		/* SIOCIWFIRSTPRIV + 3 */
+#else	/* WAVELAN_ROAMING */
+	NULL,				/* SIOCIWFIRSTPRIV + 2 */
+	NULL,				/* SIOCIWFIRSTPRIV + 3 */
+#endif	/* WAVELAN_ROAMING */
+#ifdef HISTOGRAM
+	wavelan_set_histo,		/* SIOCIWFIRSTPRIV + 4 */
+	wavelan_get_histo,		/* SIOCIWFIRSTPRIV + 5 */
+#endif	/* HISTOGRAM */
+};
+
+static const struct iw_handler_def	wavelan_handler_def =
+{
+	num_standard:	sizeof(wavelan_handler)/sizeof(iw_handler),
+	num_private:	sizeof(wavelan_private_handler)/sizeof(iw_handler),
+	num_private_args: sizeof(wavelan_private_args)/sizeof(struct iw_priv_args),
+	standard:	(iw_handler *) wavelan_handler,
+	private:	(iw_handler *) wavelan_private_handler,
+	private_args:	(struct iw_priv_args *) wavelan_private_args,
+};
+
+#else /* WIRELESS_EXT > 12 */
+/*------------------------------------------------------------------*/
+/*
+ * Perform ioctl : config & info stuff
+ * This is here that are treated the wireless extensions (iwconfig)
+ */
+static int
+wavelan_ioctl(struct net_device *	dev,	/* Device on wich the ioctl apply */
+	      struct ifreq *	rq,	/* Data passed */
+	      int		cmd)	/* Ioctl number */
+{
+  struct iwreq *	wrq = (struct iwreq *) rq;
+  int			ret = 0;
+
+#ifdef DEBUG_IOCTL_TRACE
+  printk(KERN_DEBUG "%s: ->wavelan_ioctl(cmd=0x%X)\n", dev->name, cmd);
+#endif
+
+  /* Look what is the request */
+  switch(cmd)
+    {
+      /* --------------- WIRELESS EXTENSIONS --------------- */
+
+    case SIOCGIWNAME:
+      wavelan_get_name(dev, NULL, &(wrq->u), NULL);
       break;
 
-    case SIOCGIWPRIV:
-      /* Basic checking... */
-      if(wrq->u.data.pointer != (caddr_t) 0)
-	{
-	  struct iw_priv_args	priv[] =
-	  {	/* cmd,		set_args,	get_args,	name */
-	    { SIOCSIPQTHR, IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | 1, 0, "setqualthr" },
-	    { SIOCGIPQTHR, 0, IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | 1, "getqualthr" },
-	    { SIOCSIPHISTO, IW_PRIV_TYPE_BYTE | 16,	0, "sethisto" },
-	    { SIOCGIPHISTO, 0,	    IW_PRIV_TYPE_INT | 16, "gethisto" },
-	    { SIOCSIPROAM, IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | 1 , 0, "setroam" },
-	    { SIOCGIPROAM, 0, IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | 1, "getroam" },
-	  };
+    case SIOCSIWNWID:
+      ret = wavelan_set_nwid(dev, NULL, &(wrq->u), NULL);
+      break;
 
-	  /* Set the number of ioctl available */
-	  wrq->u.data.length = 6;
+    case SIOCGIWNWID:
+      ret = wavelan_get_nwid(dev, NULL, &(wrq->u), NULL);
+      break;
 
-	  /* Copy structure to the user buffer */
-	  if(copy_to_user(wrq->u.data.pointer, (u_char *) priv,
-		       sizeof(priv)))
+    case SIOCSIWFREQ:
+      ret = wavelan_set_freq(dev, NULL, &(wrq->u), NULL);
+      break;
+
+    case SIOCGIWFREQ:
+      ret = wavelan_get_freq(dev, NULL, &(wrq->u), NULL);
+      break;
+
+    case SIOCSIWSENS:
+      ret = wavelan_set_sens(dev, NULL, &(wrq->u), NULL);
+      break;
+
+    case SIOCGIWSENS:
+      ret = wavelan_get_sens(dev, NULL, &(wrq->u), NULL);
+      break;
+
+#if WIRELESS_EXT > 8
+    case SIOCSIWENCODE:
+      {
+	char keybuf[8];
+	if (wrq->u.encoding.pointer) {
+	  /* We actually have a key to set */
+	  if (wrq->u.encoding.length != 8) {
+	    ret = -EINVAL;
+	    break;
+	  }
+	  if (copy_from_user(keybuf,
+			     wrq->u.encoding.pointer,
+			     wrq->u.encoding.length)) {
 	    ret = -EFAULT;
+	    break;
+	  }
+	} else if (wrq->u.encoding.length != 0) {
+	  ret = -EINVAL;
+	  break;
 	}
+	ret = wavelan_set_encode(dev, NULL, &(wrq->u), keybuf);
+      }
       break;
 
-#ifdef WIRELESS_SPY
-    case SIOCSIWSPY:
-      /* Set the spy list */
+    case SIOCGIWENCODE:
+      if (! capable(CAP_NET_ADMIN)) {
+	ret = -EPERM;
+	break;
+      }
+      {
+	char keybuf[8];
+	ret = wavelan_get_encode(dev, NULL,
+				 &(wrq->u),
+				 keybuf);
+	if (wrq->u.encoding.pointer) {
+	  if (copy_to_user(wrq->u.encoding.pointer,
+			   keybuf,
+			   wrq->u.encoding.length))
+	    ret = -EFAULT;
+	}
+      }
+      break;
+#endif	/* WIRELESS_EXT > 8 */
 
-      /* Check the number of addresses */
-      if(wrq->u.data.length > IW_MAX_SPY)
-	{
+#ifdef WAVELAN_ROAMING_EXT
+#if WIRELESS_EXT > 5
+    case SIOCSIWESSID:
+      {
+	char essidbuf[IW_ESSID_MAX_SIZE+1];
+	if (wrq->u.essid.length > IW_ESSID_MAX_SIZE) {
 	  ret = -E2BIG;
 	  break;
 	}
-      lp->spy_number = wrq->u.data.length;
-
-      /* If there is some addresses to copy */
-      if(lp->spy_number > 0)
-	{
-	  struct sockaddr	address[IW_MAX_SPY];
-	  int			i;
-
-	  /* Copy addresses to the driver */
-	  if(copy_from_user(address, wrq->u.data.pointer,
-			    sizeof(struct sockaddr) * lp->spy_number))
-	    {
-	      ret = -EFAULT;
-	      break;
-	    }
+	if (copy_from_user(essidbuf, wrq->u.essid.pointer,
+			   wrq->u.essid.length)) {
+	  ret = -EFAULT;
+	  break;
+	}
+	ret = wavelan_set_essid(dev, NULL,
+				&(wrq->u),
+				essidbuf);
+      }
+      break;
 
-	  /* Copy addresses to the lp structure */
-	  for(i = 0; i < lp->spy_number; i++)
-	    {
-	      memcpy(lp->spy_address[i], address[i].sa_data,
-		     WAVELAN_ADDR_SIZE);
-	    }
+    case SIOCGIWESSID:
+      {
+	char essidbuf[IW_ESSID_MAX_SIZE+1];
+	ret = wavelan_get_essid(dev, NULL,
+				&(wrq->u),
+				essidbuf);
+	if (wrq->u.essid.pointer)
+	  if ( copy_to_user(wrq->u.essid.pointer,
+			    essidbuf,
+			    wrq->u.essid.length) )
+	    ret = -EFAULT;
+      }
+      break;
 
-	  /* Reset structure... */
-	  memset(lp->spy_stat, 0x00, sizeof(iw_qual) * IW_MAX_SPY);
+    case SIOCSIWAP:
+      ret = wavelan_set_wap(dev, NULL, &(wrq->u), NULL);
+      break;
 
-#ifdef DEBUG_IOCTL_INFO
-	  printk(KERN_DEBUG "SetSpy - Set of new addresses is :\n");
-	  for(i = 0; i < wrq->u.data.length; i++)
-	    printk(KERN_DEBUG "%02X:%02X:%02X:%02X:%02X:%02X\n",
-		   lp->spy_address[i][0],
-		   lp->spy_address[i][1],
-		   lp->spy_address[i][2],
-		   lp->spy_address[i][3],
-		   lp->spy_address[i][4],
-		   lp->spy_address[i][5]);
-#endif	/* DEBUG_IOCTL_INFO */
-	}
+    case SIOCGIWAP:
+      ret = wavelan_get_wap(dev, NULL, &(wrq->u), NULL);
+      break;
+#endif	/* WIRELESS_EXT > 5 */
+#endif	/* WAVELAN_ROAMING_EXT */
 
+#if WIRELESS_EXT > 8
+#ifdef WAVELAN_ROAMING
+    case SIOCSIWMODE:
+      ret = wavelan_set_mode(dev, NULL, &(wrq->u), NULL);
       break;
 
-    case SIOCGIWSPY:
-      /* Get the spy list and spy stats */
+    case SIOCGIWMODE:
+      ret = wavelan_get_mode(dev, NULL, &(wrq->u), NULL);
+      break;
+#endif	/* WAVELAN_ROAMING */
+#endif /* WIRELESS_EXT > 8 */
 
-      /* Set the number of addresses */
-      wrq->u.data.length = lp->spy_number;
+    case SIOCGIWRANGE:
+      {
+	struct iw_range range;
+	ret = wavelan_get_range(dev, NULL,
+				&(wrq->u),
+				(char *) &range);
+	if (copy_to_user(wrq->u.data.pointer, &range,
+			 sizeof(struct iw_range)))
+	  ret = -EFAULT;
+      }
+      break;
 
-      /* If the user want to have the addresses back... */
-      if((lp->spy_number > 0) && (wrq->u.data.pointer != (caddr_t) 0))
+    case SIOCGIWPRIV:
+      /* Basic checking... */
+      if(wrq->u.data.pointer != (caddr_t) 0)
 	{
-	  struct sockaddr	address[IW_MAX_SPY];
-	  int			i;
+	  /* Set the number of ioctl available */
+	  wrq->u.data.length = sizeof(wavelan_private_args) / sizeof(wavelan_private_args[0]);
 
-	  /* Copy addresses from the lp structure */
-	  for(i = 0; i < lp->spy_number; i++)
-	    {
-	      memcpy(address[i].sa_data, lp->spy_address[i],
-		     WAVELAN_ADDR_SIZE);
-	      address[i].sa_family = ARPHRD_ETHER;
-	    }
-
-	  /* Copy addresses to the user buffer */
-	  if(copy_to_user(wrq->u.data.pointer, address,
-		       sizeof(struct sockaddr) * lp->spy_number))
-	    {
-	      ret = -EFAULT;
-	      break;
-	    }
-
-	  /* Copy stats to the user buffer (just after) */
-	  if(copy_to_user(wrq->u.data.pointer +
-		       (sizeof(struct sockaddr) * lp->spy_number),
-		       lp->spy_stat, sizeof(iw_qual) * lp->spy_number))
-	    {
-	      ret = -EFAULT;
-	      break;
-	    }
-
-	  /* Reset updated flags */
-	  for(i = 0; i < lp->spy_number; i++)
-	    lp->spy_stat[i].updated = 0x0;
-	}	/* if(pointer != NULL) */
+	  /* Copy structure to the user buffer */
+	  if(copy_to_user(wrq->u.data.pointer, (u_char *) wavelan_private_args,
+		       sizeof(wavelan_private_args)))
+	    ret = -EFAULT;
+	}
+      break;
+
+#ifdef WIRELESS_SPY
+    case SIOCSIWSPY:
+      {
+	struct sockaddr address[IW_MAX_SPY];
+	/* Check the number of addresses */
+	if (wrq->u.data.length > IW_MAX_SPY) {
+	  ret = -E2BIG;
+	  break;
+	}
+	/* Get the data in the driver */
+	if (wrq->u.data.pointer) {
+	  if (copy_from_user((char *) address,
+			     wrq->u.data.pointer,
+			     sizeof(struct sockaddr) *
+			     wrq->u.data.length)) {
+	    ret = -EFAULT;
+	    break;
+	  }
+	} else if (wrq->u.data.length != 0) {
+	  ret = -EINVAL;
+	  break;
+	}
+	ret = wavelan_set_spy(dev, NULL, &(wrq->u),
+			      (char *) address);
+      }
+      break;
 
+    case SIOCGIWSPY:
+      {
+	char buffer[IW_MAX_SPY * (sizeof(struct sockaddr) +
+				  sizeof(struct iw_quality))];
+	ret = wavelan_get_spy(dev, NULL, &(wrq->u),
+			      buffer);
+	if (wrq->u.data.pointer) {
+	  if (copy_to_user(wrq->u.data.pointer,
+			   buffer,
+			   (wrq->u.data.length *
+			    (sizeof(struct sockaddr) +
+			     sizeof(struct iw_quality)))
+			   ))
+	    ret = -EFAULT;
+	}
+      }
       break;
 #endif	/* WIRELESS_SPY */
 
@@ -2446,34 +3123,21 @@ wavelan_ioctl(struct net_device *	dev,	/
 	  ret = -EPERM;
 	  break;
 	}
-      psa.psa_quality_thr = *(wrq->u.name) & 0x0F;
-      psa_write(dev, (char *)&psa.psa_quality_thr - (char *)&psa,
-	       (unsigned char *)&psa.psa_quality_thr, 1);
-      /* update the Wavelan checksum */
-      update_psa_checksum(dev);
-      mmc_out(base, mmwoff(0, mmw_quality_thr), psa.psa_quality_thr);
+      ret = wavelan_set_qthr(dev, NULL, &(wrq->u), NULL);
       break;
 
     case SIOCGIPQTHR:
-      psa_read(dev, (char *)&psa.psa_quality_thr - (char *)&psa,
-	       (unsigned char *)&psa.psa_quality_thr, 1);
-      *(wrq->u.name) = psa.psa_quality_thr & 0x0F;
+      ret = wavelan_get_qthr(dev, NULL, &(wrq->u), NULL);
       break;
 
 #ifdef WAVELAN_ROAMING
     case SIOCSIPROAM:
       /* Note : should check if user == root */
-      if(do_roaming && (*wrq->u.name)==0)
-	wv_roam_cleanup(dev);
-      else if(do_roaming==0 && (*wrq->u.name)!=0)
-	wv_roam_init(dev);
-
-      do_roaming = (*wrq->u.name);
-	  
+      ret = wavelan_set_roam(dev, NULL, &(wrq->u), NULL);
       break;
 
     case SIOCGIPROAM:
-      *(wrq->u.name) = do_roaming;
+      ret = wavelan_get_roam(dev, NULL, &(wrq->u), NULL);
       break;
 #endif	/* WAVELAN_ROAMING */
 
@@ -2484,44 +3148,44 @@ wavelan_ioctl(struct net_device *	dev,	/
 	{
 	  ret = -EPERM;
 	}
-
-      /* Check the number of intervals */
-      if(wrq->u.data.length > 16)
-	{
-	  ret = -E2BIG;
-	  break;
+      {
+	char buffer[16];
+	/* Check the number of intervals */
+	if(wrq->u.data.length > 16)
+	  {
+	    ret = -E2BIG;
+	    break;
 	}
-      lp->his_number = wrq->u.data.length;
-
-      /* If there is some addresses to copy */
-      if(lp->his_number > 0)
-	{
-	  /* Copy interval ranges to the driver */
-	  if(copy_from_user(lp->his_range, wrq->u.data.pointer,
-			 sizeof(char) * lp->his_number))
-	    {
-	      ret = -EFAULT;
-	      break;
-	    }
-
-	  /* Reset structure... */
-	  memset(lp->his_sum, 0x00, sizeof(long) * 16);
+	/* Get the data in the driver */
+	if (wrq->u.data.pointer) {
+	  if (copy_from_user(buffer,
+			     wrq->u.data.pointer,
+			     sizeof(struct sockaddr) *
+			     wrq->u.data.length)) {
+	    ret = -EFAULT;
+	    break;
+	  }
+	} else if (wrq->u.data.length != 0) {
+	  ret = -EINVAL;
+	  break;
 	}
+	ret = wavelan_set_histo(dev, NULL, &(wrq->u),
+				buffer);
+      }
       break;
 
     case SIOCGIPHISTO:
-      /* Set the number of intervals */
-      wrq->u.data.length = lp->his_number;
-
-      /* Give back the distribution statistics */
-      if((lp->his_number > 0) && (wrq->u.data.pointer != (caddr_t) 0))
-	{
-	  /* Copy data to the user buffer */
-	  if(copy_to_user(wrq->u.data.pointer, lp->his_sum,
-		       sizeof(long) * lp->his_number))
+      {
+	long buffer[16];
+	ret = wavelan_get_histo(dev, NULL, &(wrq->u),
+				(char *) buffer);
+	if (wrq->u.data.pointer) {
+	  if (copy_to_user(wrq->u.data.pointer,
+			   buffer,
+			   (wrq->u.data.length * sizeof(long))))
 	    ret = -EFAULT;
-
-	}	/* if(pointer != NULL) */
+	}
+      }
       break;
 #endif	/* HISTOGRAM */
 
@@ -2531,14 +3195,12 @@ wavelan_ioctl(struct net_device *	dev,	/
       ret = -EOPNOTSUPP;
     }
 
-  /* ReEnable interrupts & restore flags */
-  wv_splx(lp, &flags);
-
 #ifdef DEBUG_IOCTL_TRACE
   printk(KERN_DEBUG "%s: <-wavelan_ioctl()\n", dev->name);
 #endif
   return ret;
 }
+#endif /* WIRELESS_EXT > 12 */
 
 /*------------------------------------------------------------------*/
 /*
@@ -4530,7 +5192,11 @@ wavelan_attach(void)
   dev->watchdog_timeo	= WATCHDOG_JIFFIES;
 
 #ifdef WIRELESS_EXT	/* If wireless extension exist in the kernel */
+#if WIRELESS_EXT > 12
+  dev->wireless_handlers = (struct iw_handler_def *)&wavelan_handler_def;
+#else /* WIRELESS_EXT > 12 */
   dev->do_ioctl = wavelan_ioctl;	/* wireless extensions */
+#endif /* WIRELESS_EXT > 12 */
   dev->get_wireless_stats = wavelan_get_wireless_stats;
 #endif
 
diff -u -p -r linux/drivers/net/wireless-w12/wavelan_cs.p.h linux/drivers/net/wireless/wavelan_cs.p.h
--- linux/drivers/net/wireless-w12/wavelan_cs.p.h	Wed Jan 23 16:19:56 2002
+++ linux/drivers/net/wireless/wavelan_cs.p.h	Wed Jan 23 16:59:19 2002
@@ -394,6 +394,12 @@
  *		o control first busy loop in wv_82593_cmd()
  *		o Extend spinlock protection in wv_hw_config()
  *
+ * Changes made for release in 3.1.33 :
+ * ----------------------------------
+ *	- Optional use new driver API for Wireless Extensions :
+ *		o got rid of wavelan_ioctl()
+ *		o use a bunch of iw_handler instead
+ *
  * Wishes & dreams:
  * ----------------
  *	- Cleanup and integrate the roaming code
@@ -430,6 +436,9 @@
 
 #ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>		/* Wireless extensions */
+#if WIRELESS_EXT > 12
+#include <net/iw_handler.h>
+#endif	/* WIRELESS_EXT > 12 */
 #endif
 
 /* Pcmcia headers that we need */
@@ -498,7 +507,7 @@
 /************************ CONSTANTS & MACROS ************************/
 
 #ifdef DEBUG_VERSION_SHOW
-static const char *version = "wavelan_cs.c : v23 (SMP + wireless extensions) 20/12/00\n";
+static const char *version = "wavelan_cs.c : v24 (SMP + wireless extensions) 11/1/02\n";
 #endif
 
 /* Watchdog temporisation */
@@ -523,8 +532,8 @@ static const char *version = "wavelan_cs
 #define SIOCSIPROAM     SIOCIWFIRSTPRIV + 2	/* Set roaming state */
 #define SIOCGIPROAM     SIOCIWFIRSTPRIV + 3	/* Get roaming state */
 
-#define SIOCSIPHISTO	SIOCIWFIRSTPRIV + 6	/* Set histogram ranges */
-#define SIOCGIPHISTO	SIOCIWFIRSTPRIV + 7	/* Get histogram values */
+#define SIOCSIPHISTO	SIOCIWFIRSTPRIV + 4	/* Set histogram ranges */
+#define SIOCGIPHISTO	SIOCIWFIRSTPRIV + 5	/* Get histogram values */
 
 /*************************** WaveLAN Roaming  **************************/
 #ifdef WAVELAN_ROAMING		/* Conditional compile, see above in options */
@@ -588,6 +597,16 @@ typedef struct iw_quality	iw_qual;
 typedef struct iw_freq		iw_freq;
 typedef struct net_local	net_local;
 typedef struct timer_list	timer_list;
+
+#if WIRELESS_EXT <= 12
+/* Wireless extensions backward compatibility */
+/* Part of iw_handler prototype we need */
+struct iw_request_info
+{
+	__u16		cmd;		/* Wireless Extension command */
+	__u16		flags;		/* More to come ;-) */
+};
+#endif	/* WIRELESS_EXT <= 12 */
 
 /* Basic types */
 typedef u_char		mac_addr[WAVELAN_ADDR_SIZE];	/* Hardware address */

