Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSBDS7A>; Mon, 4 Feb 2002 13:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286263AbSBDS6r>; Mon, 4 Feb 2002 13:58:47 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:30666 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S284933AbSBDS6I>;
	Mon, 4 Feb 2002 13:58:08 -0500
Date: Mon, 4 Feb 2002 10:58:01 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.3] wavelan.c : new WE api
Message-ID: <20020204105801.A6533@bougret.hpl.hp.com>
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

	As you have some style, would you mind forwarding that to Linus ?

	This update the wavelan driver in 2.5.3 to the new wireless
API (that you reviewed earlier). Apart from that, no changes. Tested
on 2.5.3.

	Have fun...

	Jean

----------------------------------------------------------

diff -u -p -r linux/drivers/net/wireless-w12/wavelan.c linux/drivers/net/wireless/wavelan.c
--- linux/drivers/net/wireless-w12/wavelan.c	Wed Jan 23 16:09:29 2002
+++ linux/drivers/net/wireless/wavelan.c	Wed Jan 23 16:50:49 2002
@@ -1786,170 +1786,287 @@ static inline void wl_his_gather(device 
 
 /*------------------------------------------------------------------*/
 /*
- * Perform ioctl for configuration and information.
- * It is here that the wireless extensions are treated (iwconfig).
+ * Wireless Handler : get protocol name
  */
-static int wavelan_ioctl(struct net_device *dev,	/* device on which the ioctl is applied */
-			 struct ifreq *rq,	/* data passed */
-			 int cmd)
-{				/* ioctl number */
+static int wavelan_get_name(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	strcpy(wrqu->name, "WaveLAN");
+	return 0;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : set NWID
+ */
+static int wavelan_set_nwid(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
 	unsigned long ioaddr = dev->base_addr;
 	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
-	struct iwreq *wrq = (struct iwreq *) rq;
 	psa_t psa;
 	mm_t m;
 	unsigned long flags;
 	int ret = 0;
-	int err = 0;
 
-#ifdef DEBUG_IOCTL_TRACE
-	printk(KERN_DEBUG "%s: ->wavelan_ioctl(cmd=0x%X)\n", dev->name,
-	       cmd);
-#endif
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Set NWID in WaveLAN. */
+	if (!wrqu->nwid.disabled) {
+		/* Set NWID in psa */
+		psa.psa_nwid[0] = (wrqu->nwid.value & 0xFF00) >> 8;
+		psa.psa_nwid[1] = wrqu->nwid.value & 0xFF;
+		psa.psa_nwid_select = 0x01;
+		psa_write(ioaddr, lp->hacr,
+			  (char *) psa.psa_nwid - (char *) &psa,
+			  (unsigned char *) psa.psa_nwid, 3);
+
+		/* Set NWID in mmc. */
+		m.w.mmw_netw_id_l = psa.psa_nwid[1];
+		m.w.mmw_netw_id_h = psa.psa_nwid[0];
+		mmc_write(ioaddr,
+			  (char *) &m.w.mmw_netw_id_l -
+			  (char *) &m,
+			  (unsigned char *) &m.w.mmw_netw_id_l, 2);
+		mmc_out(ioaddr, mmwoff(0, mmw_loopt_sel), 0x00);
+	} else {
+		/* Disable NWID in the psa. */
+		psa.psa_nwid_select = 0x00;
+		psa_write(ioaddr, lp->hacr,
+			  (char *) &psa.psa_nwid_select -
+			  (char *) &psa,
+			  (unsigned char *) &psa.psa_nwid_select,
+			  1);
+
+		/* Disable NWID in the mmc (no filtering). */
+		mmc_out(ioaddr, mmwoff(0, mmw_loopt_sel),
+			MMW_LOOPT_SEL_DIS_NWID);
+	}
+	/* update the Wavelan checksum */
+	update_psa_checksum(dev, ioaddr, lp->hacr);
+
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
+
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
+	unsigned long ioaddr = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	unsigned long flags;
+	int ret = 0;
 
 	/* Disable interrupts and save flags. */
 	wv_splhi(lp, &flags);
 	
-	/* Look what is the request */
-	switch (cmd) {
-		/* --------------- WIRELESS EXTENSIONS --------------- */
-
-	case SIOCGIWNAME:
-		strcpy(wrq->u.name, "WaveLAN");
-		break;
-
-	case SIOCSIWNWID:
-		/* Set NWID in WaveLAN. */
-		if (!wrq->u.nwid.disabled) {
-			/* Set NWID in psa */
-			psa.psa_nwid[0] =
-			    (wrq->u.nwid.value & 0xFF00) >> 8;
-			psa.psa_nwid[1] = wrq->u.nwid.value & 0xFF;
-			psa.psa_nwid_select = 0x01;
-			psa_write(ioaddr, lp->hacr,
-				  (char *) psa.psa_nwid - (char *) &psa,
-				  (unsigned char *) psa.psa_nwid, 3);
+	/* Read the NWID. */
+	psa_read(ioaddr, lp->hacr,
+		 (char *) psa.psa_nwid - (char *) &psa,
+		 (unsigned char *) psa.psa_nwid, 3);
+	wrqu->nwid.value = (psa.psa_nwid[0] << 8) + psa.psa_nwid[1];
+	wrqu->nwid.disabled = !(psa.psa_nwid_select);
+	wrqu->nwid.fixed = 1;	/* Superfluous */
 
-			/* Set NWID in mmc. */
-			m.w.mmw_netw_id_l = psa.psa_nwid[1];
-			m.w.mmw_netw_id_h = psa.psa_nwid[0];
-			mmc_write(ioaddr,
-				  (char *) &m.w.mmw_netw_id_l -
-				  (char *) &m,
-				  (unsigned char *) &m.w.mmw_netw_id_l, 2);
-			mmc_out(ioaddr, mmwoff(0, mmw_loopt_sel), 0x00);
-		} else {
-			/* Disable NWID in the psa. */
-			psa.psa_nwid_select = 0x00;
-			psa_write(ioaddr, lp->hacr,
-				  (char *) &psa.psa_nwid_select -
-				  (char *) &psa,
-				  (unsigned char *) &psa.psa_nwid_select,
-				  1);
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
 
-			/* Disable NWID in the mmc (no filtering). */
-			mmc_out(ioaddr, mmwoff(0, mmw_loopt_sel),
-				MMW_LOOPT_SEL_DIS_NWID);
-		}
-		/* update the Wavelan checksum */
-		update_psa_checksum(dev, ioaddr, lp->hacr);
-		break;
+	return ret;
+}
 
-	case SIOCGIWNWID:
-		/* Read the NWID. */
-		psa_read(ioaddr, lp->hacr,
-			 (char *) psa.psa_nwid - (char *) &psa,
-			 (unsigned char *) psa.psa_nwid, 3);
-		wrq->u.nwid.value =
-		    (psa.psa_nwid[0] << 8) + psa.psa_nwid[1];
-		wrq->u.nwid.disabled = !(psa.psa_nwid_select);
-		wrq->u.nwid.fixed = 1;	/* Superfluous */
-		break;
-
-	case SIOCSIWFREQ:
-		/* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable). */
-		if (!(mmc_in(ioaddr, mmroff(0, mmr_fee_status)) &
-		      (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY)))
-			ret = wv_set_frequency(ioaddr, &(wrq->u.freq));
-		else
-			ret = -EOPNOTSUPP;
-		break;
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : set frequency
+ */
+static int wavelan_set_freq(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	unsigned long ioaddr = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	unsigned long flags;
+	int ret;
 
-	case SIOCGIWFREQ:
-		/* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable).
-		 * Does it work for everybody, especially old cards? */
-		if (!(mmc_in(ioaddr, mmroff(0, mmr_fee_status)) &
-		      (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY))) {
-			unsigned short freq;
-
-			/* Ask the EEPROM to read the frequency from the first area. */
-			fee_read(ioaddr, 0x00, &freq, 1);
-			wrq->u.freq.m = ((freq >> 5) * 5 + 24000L) * 10000;
-			wrq->u.freq.e = 1;
-		} else {
-			psa_read(ioaddr, lp->hacr,
-				 (char *) &psa.psa_subband - (char *) &psa,
-				 (unsigned char *) &psa.psa_subband, 1);
-
-			if (psa.psa_subband <= 4) {
-				wrq->u.freq.m =
-				    fixed_bands[psa.psa_subband];
-				wrq->u.freq.e = (psa.psa_subband != 0);
-			} else
-				ret = -EOPNOTSUPP;
-		}
-		break;
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable). */
+	if (!(mmc_in(ioaddr, mmroff(0, mmr_fee_status)) &
+	      (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY)))
+		ret = wv_set_frequency(ioaddr, &(wrqu->freq));
+	else
+		ret = -EOPNOTSUPP;
 
-	case SIOCSIWSENS:
-		/* Set the level threshold. */
-		/* We should complain loudly if wrq->u.sens.fixed = 0, because we
-		 * can't set auto mode... */
-		psa.psa_thr_pre_set = wrq->u.sens.value & 0x3F;
-		psa_write(ioaddr, lp->hacr,
-			  (char *) &psa.psa_thr_pre_set - (char *) &psa,
-			  (unsigned char *) &psa.psa_thr_pre_set, 1);
-		/* update the Wavelan checksum */
-		update_psa_checksum(dev, ioaddr, lp->hacr);
-		mmc_out(ioaddr, mmwoff(0, mmw_thr_pre_set),
-			psa.psa_thr_pre_set);
-		break;
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
 
-	case SIOCGIWSENS:
-		/* Read the level threshold. */
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
+	unsigned long ioaddr = dev->base_addr;
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
+	if (!(mmc_in(ioaddr, mmroff(0, mmr_fee_status)) &
+	      (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY))) {
+		unsigned short freq;
+
+		/* Ask the EEPROM to read the frequency from the first area. */
+		fee_read(ioaddr, 0x00, &freq, 1);
+		wrqu->freq.m = ((freq >> 5) * 5 + 24000L) * 10000;
+		wrqu->freq.e = 1;
+	} else {
 		psa_read(ioaddr, lp->hacr,
-			 (char *) &psa.psa_thr_pre_set - (char *) &psa,
-			 (unsigned char *) &psa.psa_thr_pre_set, 1);
-		wrq->u.sens.value = psa.psa_thr_pre_set & 0x3F;
-		wrq->u.sens.fixed = 1;
-		break;
-
-	case SIOCSIWENCODE:
-		/* Set encryption key */
-		if (!mmc_encr(ioaddr)) {
+			 (char *) &psa.psa_subband - (char *) &psa,
+			 (unsigned char *) &psa.psa_subband, 1);
+
+		if (psa.psa_subband <= 4) {
+			wrqu->freq.m = fixed_bands[psa.psa_subband];
+			wrqu->freq.e = (psa.psa_subband != 0);
+		} else
 			ret = -EOPNOTSUPP;
-			break;
-		}
+	}
 
-		/* Basic checking... */
-		if (wrq->u.encoding.pointer != (caddr_t) 0) {
-			/* Check the size of the key */
-			if (wrq->u.encoding.length != 8) {
-				ret = -EINVAL;
-				break;
-			}
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
 
-			/* Copy the key in the driver */
-			wv_splx(lp, &flags);
-			err = copy_from_user(psa.psa_encryption_key,
-					     wrq->u.encoding.pointer,
-					     wrq->u.encoding.length);
-			wv_splhi(lp, &flags);
-			if (err) {
-				ret = -EFAULT;
-				break;
-			}
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
+	unsigned long ioaddr = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	unsigned long flags;
+	int ret = 0;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Set the level threshold. */
+	/* We should complain loudly if wrqu->sens.fixed = 0, because we
+	 * can't set auto mode... */
+	psa.psa_thr_pre_set = wrqu->sens.value & 0x3F;
+	psa_write(ioaddr, lp->hacr,
+		  (char *) &psa.psa_thr_pre_set - (char *) &psa,
+		  (unsigned char *) &psa.psa_thr_pre_set, 1);
+	/* update the Wavelan checksum */
+	update_psa_checksum(dev, ioaddr, lp->hacr);
+	mmc_out(ioaddr, mmwoff(0, mmw_thr_pre_set),
+		psa.psa_thr_pre_set);
+
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
+	unsigned long ioaddr = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	unsigned long flags;
+	int ret = 0;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Read the level threshold. */
+	psa_read(ioaddr, lp->hacr,
+		 (char *) &psa.psa_thr_pre_set - (char *) &psa,
+		 (unsigned char *) &psa.psa_thr_pre_set, 1);
+	wrqu->sens.value = psa.psa_thr_pre_set & 0x3F;
+	wrqu->sens.fixed = 1;
+
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
+
+	return ret;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : set encryption key
+ */
+static int wavelan_set_encode(struct net_device *dev,
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu,
+			      char *extra)
+{
+	unsigned long ioaddr = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	unsigned long flags;
+	psa_t psa;
+	int ret = 0;
 
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+
+	/* Check if capable of encryption */
+	if (!mmc_encr(ioaddr)) {
+		ret = -EOPNOTSUPP;
+	}
+
+	/* Check the size of the key */
+	if((wrqu->encoding.length != 8) && (wrqu->encoding.length != 0)) {
+		ret = -EINVAL;
+	}
+
+	if(!ret) {
+		/* Basic checking... */
+		if (wrqu->encoding.length == 8) {
+			/* Copy the key in the driver */
+			memcpy(psa.psa_encryption_key, extra,
+			       wrqu->encoding.length);
 			psa.psa_encryption_select = 1;
+
 			psa_write(ioaddr, lp->hacr,
 				  (char *) &psa.psa_encryption_select -
 				  (char *) &psa,
@@ -1963,7 +2080,8 @@ static int wavelan_ioctl(struct net_devi
 				  psa_encryption_key, 8);
 		}
 
-		if (wrq->u.encoding.flags & IW_ENCODE_DISABLED) {	/* disable encryption */
+		/* disable encryption */
+		if (wrqu->encoding.flags & IW_ENCODE_DISABLED) {
 			psa.psa_encryption_select = 0;
 			psa_write(ioaddr, lp->hacr,
 				  (char *) &psa.psa_encryption_select -
@@ -1975,350 +2093,430 @@ static int wavelan_ioctl(struct net_devi
 		}
 		/* update the Wavelan checksum */
 		update_psa_checksum(dev, ioaddr, lp->hacr);
-		break;
+	}
+
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
 
-	case SIOCGIWENCODE:
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
+	unsigned long ioaddr = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	unsigned long flags;
+	int ret = 0;
+
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Check if encryption is available */
+	if (!mmc_encr(ioaddr)) {
+		ret = -EOPNOTSUPP;
+	} else {
 		/* Read the encryption key */
-		if (!mmc_encr(ioaddr)) {
-			ret = -EOPNOTSUPP;
-			break;
-		}
+		psa_read(ioaddr, lp->hacr,
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
+		wrqu->encoding.flags |= mmc_encr(ioaddr);
 
-		/* only super-user can see encryption key */
-		if (!capable(CAP_NET_ADMIN)) {
-			ret = -EPERM;
-			break;
-		}
+		/* Copy the key to the user buffer */
+		wrqu->encoding.length = 8;
+		memcpy(extra, psa.psa_encryption_key, wrqu->encoding.length);
+	}
 
-		/* Basic checking... */
-		if (wrq->u.encoding.pointer != (caddr_t) 0) {
-			/* Verify the user buffer */
-			ret =
-			    verify_area(VERIFY_WRITE,
-					wrq->u.encoding.pointer, 8);
-			if (ret)
-				break;
-
-			psa_read(ioaddr, lp->hacr,
-				 (char *) &psa.psa_encryption_select -
-				 (char *) &psa,
-				 (unsigned char *) &psa.
-				 psa_encryption_select, 1 + 8);
-
-			/* encryption is enabled ? */
-			if (psa.psa_encryption_select)
-				wrq->u.encoding.flags = IW_ENCODE_ENABLED;
-			else
-				wrq->u.encoding.flags = IW_ENCODE_DISABLED;
-			wrq->u.encoding.flags |= mmc_encr(ioaddr);
-
-			/* Copy the key to the user buffer */
-			wrq->u.encoding.length = 8;
-			wv_splx(lp, &flags);
-			if (copy_to_user(wrq->u.encoding.pointer,
-					 psa.psa_encryption_key, 8))
-				ret = -EFAULT;
-			wv_splhi(lp, &flags);
-		}
-		break;
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
 
-	case SIOCGIWRANGE:
-		/* basic checking */
-		if (wrq->u.data.pointer != (caddr_t) 0) {
-			struct iw_range range;
-
-			/* Set the length (very important for backward
-			 * compatibility) */
-			wrq->u.data.length = sizeof(struct iw_range);
-
-			/* Set all the info we don't care or don't know
-			 * about to zero */
-			memset(&range, 0, sizeof(range));
-
-			/* Set the Wireless Extension versions */
-			range.we_version_compiled = WIRELESS_EXT;
-			range.we_version_source = 9;
-
-			/* Set information in the range struct.  */
-			range.throughput = 1.6 * 1000 * 1000;	/* don't argue on this ! */
-			range.min_nwid = 0x0000;
-			range.max_nwid = 0xFFFF;
-
-			/* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable). */
-			if (!(mmc_in(ioaddr, mmroff(0, mmr_fee_status)) &
-			      (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY))) {
-				range.num_channels = 10;
-				range.num_frequency =
-				    wv_frequency_list(ioaddr, range.freq,
-						      IW_MAX_FREQUENCIES);
-			} else
-				range.num_channels = range.num_frequency =
-				    0;
-
-			range.sensitivity = 0x3F;
-			range.max_qual.qual = MMR_SGNL_QUAL;
-			range.max_qual.level = MMR_SIGNAL_LVL;
-			range.max_qual.noise = MMR_SILENCE_LVL;
-			range.avg_qual.qual = MMR_SGNL_QUAL; /* Always max */
-			/* Need to get better values for those two */
-			range.avg_qual.level = 30;
-			range.avg_qual.noise = 8;
-
-			range.num_bitrates = 1;
-			range.bitrate[0] = 2000000;	/* 2 Mb/s */
-
-			/* Encryption supported ? */
-			if (mmc_encr(ioaddr)) {
-				range.encoding_size[0] = 8;	/* DES = 64 bits key */
-				range.num_encoding_sizes = 1;
-				range.max_encoding_tokens = 1;	/* Only one key possible */
-			} else {
-				range.num_encoding_sizes = 0;
-				range.max_encoding_tokens = 0;
-			}
+	return ret;
+}
 
-			/* Copy structure to the user buffer. */
-			wv_splx(lp, &flags);
-			if (copy_to_user(wrq->u.data.pointer,
-					 &range,
-					 sizeof(struct iw_range)))
-				ret = -EFAULT;
-			wv_splhi(lp, &flags);
-		}
-		break;
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Handler : get range info
+ */
+static int wavelan_get_range(struct net_device *dev,
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu,
+			     char *extra)
+{
+	unsigned long ioaddr = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	struct iw_range *range = (struct iw_range *) extra;
+	unsigned long flags;
+	int ret = 0;
 
-	case SIOCGIWPRIV:
-		/* Basic checking */
-		if (wrq->u.data.pointer != (caddr_t) 0) {
-			struct iw_priv_args priv[] = {
-				/* { cmd,
-				     set_args,
-				     get_args,
-				     name } */
-				{ SIOCSIPQTHR,
-				  IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | 1,
-				  0,
-				  "setqualthr" },
-				{ SIOCGIPQTHR,
-				  0,
-				  IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | 1,
-				  "getqualthr" },
-				{ SIOCSIPHISTO,
-				  IW_PRIV_TYPE_BYTE | 16,
-				  0,
-				  "sethisto" },
-				{ SIOCGIPHISTO,
-				  0,
-				  IW_PRIV_TYPE_INT | 16,
-				 "gethisto" },
-			};
-
-			/* Set the number of available ioctls. */
-			wrq->u.data.length = 4;
-
-			/* Copy structure to the user buffer. */
-			wv_splx(lp, &flags);
-			if (copy_to_user(wrq->u.data.pointer,
-					      (u8 *) priv,
-					      sizeof(priv)))
-				ret = -EFAULT;
-			wv_splhi(lp, &flags);
-		}
-		break;
+	/* Set the length (very important for backward compatibility) */
+	wrqu->data.length = sizeof(struct iw_range);
 
-#ifdef WIRELESS_SPY
-	case SIOCSIWSPY:
-		/* Set the spy list */
+	/* Set all the info we don't care or don't know about to zero */
+	memset(range, 0, sizeof(struct iw_range));
 
-		/* Check the number of addresses. */
-		if (wrq->u.data.length > IW_MAX_SPY) {
-			ret = -E2BIG;
-			break;
-		}
-		lp->spy_number = wrq->u.data.length;
+	/* Set the Wireless Extension versions */
+	range->we_version_compiled = WIRELESS_EXT;
+	range->we_version_source = 9;
+
+	/* Set information in the range struct.  */
+	range->throughput = 1.6 * 1000 * 1000;	/* don't argue on this ! */
+	range->min_nwid = 0x0000;
+	range->max_nwid = 0xFFFF;
+
+	range->sensitivity = 0x3F;
+	range->max_qual.qual = MMR_SGNL_QUAL;
+	range->max_qual.level = MMR_SIGNAL_LVL;
+	range->max_qual.noise = MMR_SILENCE_LVL;
+	range->avg_qual.qual = MMR_SGNL_QUAL; /* Always max */
+	/* Need to get better values for those two */
+	range->avg_qual.level = 30;
+	range->avg_qual.noise = 8;
 
-		/* Are there are addresses to copy? */
-		if (lp->spy_number > 0) {
-			struct sockaddr address[IW_MAX_SPY];
-			int i;
-
-			/* Copy addresses to the driver. */
-			wv_splx(lp, &flags);
-			err = copy_from_user(address,
-					     wrq->u.data.pointer,
-					     sizeof(struct sockaddr)
-					     * lp->spy_number);
-			wv_splhi(lp, &flags);
-			if (err) {
-				ret = -EFAULT;
-				break;
-			}
+	range->num_bitrates = 1;
+	range->bitrate[0] = 2000000;	/* 2 Mb/s */
 
-			/* Copy addresses to the lp structure. */
-			for (i = 0; i < lp->spy_number; i++) {
-				memcpy(lp->spy_address[i],
-				       address[i].sa_data,
-				       WAVELAN_ADDR_SIZE);
-			}
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	/* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable). */
+	if (!(mmc_in(ioaddr, mmroff(0, mmr_fee_status)) &
+	      (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY))) {
+		range->num_channels = 10;
+		range->num_frequency = wv_frequency_list(ioaddr, range->freq,
+							IW_MAX_FREQUENCIES);
+	} else
+		range->num_channels = range->num_frequency = 0;
+
+	/* Encryption supported ? */
+	if (mmc_encr(ioaddr)) {
+		range->encoding_size[0] = 8;	/* DES = 64 bits key */
+		range->num_encoding_sizes = 1;
+		range->max_encoding_tokens = 1;	/* Only one key possible */
+	} else {
+		range->num_encoding_sizes = 0;
+		range->max_encoding_tokens = 0;
+	}
+
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
 
-			/* Reset structure. */
-			memset(lp->spy_stat, 0x00,
-			       sizeof(iw_qual) * IW_MAX_SPY);
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
 
 #ifdef DEBUG_IOCTL_INFO
+		printk(KERN_DEBUG
+		       "SetSpy:  set of new addresses is: \n");
+		for (i = 0; i < wrqu->data.length; i++)
 			printk(KERN_DEBUG
-			       "SetSpy:  set of new addresses is: \n");
-			for (i = 0; i < wrq->u.data.length; i++)
-				printk(KERN_DEBUG
-				       "%02X:%02X:%02X:%02X:%02X:%02X \n",
-				       lp->spy_address[i][0],
-				       lp->spy_address[i][1],
-				       lp->spy_address[i][2],
-				       lp->spy_address[i][3],
-				       lp->spy_address[i][4],
-				       lp->spy_address[i][5]);
-#endif				/* DEBUG_IOCTL_INFO */
-		}
+			       "%02X:%02X:%02X:%02X:%02X:%02X \n",
+			       lp->spy_address[i][0],
+			       lp->spy_address[i][1],
+			       lp->spy_address[i][2],
+			       lp->spy_address[i][3],
+			       lp->spy_address[i][4],
+			       lp->spy_address[i][5]);
+#endif			/* DEBUG_IOCTL_INFO */
+	}
 
-		break;
+	/* Now we can set the number of addresses */
+	lp->spy_number = wrqu->data.length;
 
-	case SIOCGIWSPY:
-		/* Get the spy list and spy stats. */
+	return ret;
+}
 
-		/* Set the number of addresses */
-		wrq->u.data.length = lp->spy_number;
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
 
-		/* Does the user want to have the addresses back? */
-		if ((lp->spy_number > 0)
-		    && (wrq->u.data.pointer != (caddr_t) 0)) {
-			struct sockaddr address[IW_MAX_SPY];
-			int i;
-
-			/* Copy addresses from the lp structure. */
-			for (i = 0; i < lp->spy_number; i++) {
-				memcpy(address[i].sa_data,
-				       lp->spy_address[i],
-				       WAVELAN_ADDR_SIZE);
-				address[i].sa_family = AF_UNIX;
-			}
+	/* Set the number of addresses */
+	wrqu->data.length = lp->spy_number;
 
-			/* Copy addresses to the user buffer. */
-			wv_splx(lp, &flags);
-			err = copy_to_user(wrq->u.data.pointer,
-					   address,
-					   sizeof(struct sockaddr)
-					   * lp->spy_number);
-
-			/* Copy stats to the user buffer (just after). */
-			err |= copy_to_user(wrq->u.data.pointer
-					    + (sizeof(struct sockaddr)
-					       * lp->spy_number),
-					    lp->spy_stat,
-					    sizeof(iw_qual) * lp->spy_number);
-			wv_splhi(lp, &flags);
-			if (err) {
-				ret = -EFAULT;
-				break;
-			}
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
 
-			/* Reset updated flags. */
-			for (i = 0; i < lp->spy_number; i++)
-				lp->spy_stat[i].updated = 0x0;
-		}
-		/* if(pointer != NULL) */
-		break;
-#endif				/* WIRELESS_SPY */
+	return(0);
+}
+#endif			/* WIRELESS_SPY */
 
-		/* ------------------ PRIVATE IOCTL ------------------ */
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Private Handler : set quality threshold
+ */
+static int wavelan_set_qthr(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	unsigned long ioaddr = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	unsigned long flags;
 
-	case SIOCSIPQTHR:
-		if (!capable(CAP_NET_ADMIN)) {
-			ret = -EPERM;
-			break;
-		}
-		psa.psa_quality_thr = *(wrq->u.name) & 0x0F;
-		psa_write(ioaddr, lp->hacr,
-			  (char *) &psa.psa_quality_thr - (char *) &psa,
-			  (unsigned char *) &psa.psa_quality_thr, 1);
-		/* update the Wavelan checksum */
-		update_psa_checksum(dev, ioaddr, lp->hacr);
-		mmc_out(ioaddr, mmwoff(0, mmw_quality_thr),
-			psa.psa_quality_thr);
-		break;
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	psa.psa_quality_thr = *(extra) & 0x0F;
+	psa_write(ioaddr, lp->hacr,
+		  (char *) &psa.psa_quality_thr - (char *) &psa,
+		  (unsigned char *) &psa.psa_quality_thr, 1);
+	/* update the Wavelan checksum */
+	update_psa_checksum(dev, ioaddr, lp->hacr);
+	mmc_out(ioaddr, mmwoff(0, mmw_quality_thr),
+		psa.psa_quality_thr);
 
-	case SIOCGIPQTHR:
-		psa_read(ioaddr, lp->hacr,
-			 (char *) &psa.psa_quality_thr - (char *) &psa,
-			 (unsigned char *) &psa.psa_quality_thr, 1);
-		*(wrq->u.name) = psa.psa_quality_thr & 0x0F;
-		break;
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
 
-#ifdef HISTOGRAM
-	case SIOCSIPHISTO:
-		/* Verify that the user is root. */
-		if (!capable(CAP_NET_ADMIN)) {
-			ret = -EPERM;
-			break;
-		}
+	return 0;
+}
 
-		/* Check the number of intervals. */
-		if (wrq->u.data.length > 16) {
-			ret = -E2BIG;
-			break;
-		}
-		lp->his_number = wrq->u.data.length;
+/*------------------------------------------------------------------*/
+/*
+ * Wireless Private Handler : get quality threshold
+ */
+static int wavelan_get_qthr(struct net_device *dev,
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu,
+			    char *extra)
+{
+	unsigned long ioaddr = dev->base_addr;
+	net_local *lp = (net_local *) dev->priv;	/* lp is not unused */
+	psa_t psa;
+	unsigned long flags;
 
-		/* Are there addresses to copy? */
-		if (lp->his_number > 0) {
-			/* Copy interval ranges to the driver */
-			wv_splx(lp, &flags);
-			err = copy_from_user(lp->his_range,
-					     wrq->u.data.pointer,
-					     sizeof(char) * lp->his_number);
-			wv_splhi(lp, &flags);
-			if (err) {
-				ret = -EFAULT;
-				break;
-			}
+	/* Disable interrupts and save flags. */
+	wv_splhi(lp, &flags);
+	
+	psa_read(ioaddr, lp->hacr,
+		 (char *) &psa.psa_quality_thr - (char *) &psa,
+		 (unsigned char *) &psa.psa_quality_thr, 1);
+	*(extra) = psa.psa_quality_thr & 0x0F;
+
+	/* Enable interrupts and restore flags. */
+	wv_splx(lp, &flags);
 
-			/* Reset structure. */
-			memset(lp->his_sum, 0x00, sizeof(long) * 16);
+	return 0;
+}
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
 		}
-		break;
 
-	case SIOCGIPHISTO:
-		/* Set the number of intervals. */
-		wrq->u.data.length = lp->his_number;
-
-		/* Give back the distribution statistics */
-		if ((lp->his_number > 0)
-		    && (wrq->u.data.pointer != (caddr_t) 0)) {
-			/* Copy data to the user buffer. */
-			wv_splx(lp, &flags);
-			if (copy_to_user(wrq->u.data.pointer,
-					 lp->his_sum,
-					 sizeof(long) * lp->his_number);
-				ret = -EFAULT;
-			wv_splhi(lp, &flags);
+		/* Reset result structure. */
+		memset(lp->his_sum, 0x00, sizeof(long) * 16);
+	}
 
-		}		/* if(pointer != NULL) */
-		break;
-#endif				/* HISTOGRAM */
+	/* Now we can set the number of ranges */
+	lp->his_number = wrqu->data.length;
 
-		/* ------------------- OTHER IOCTL ------------------- */
+	return(0);
+}
 
-	default:
-		ret = -EOPNOTSUPP;
-	}	/* switch (cmd) */
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
 
-	/* Enable interrupts and restore flags. */
-	wv_splx(lp, &flags);
+	/* Set the number of intervals. */
+	wrqu->data.length = lp->his_number;
 
-#ifdef DEBUG_IOCTL_TRACE
-	printk(KERN_DEBUG "%s: <-wavelan_ioctl()\n", dev->name);
-#endif
-	return ret;
+	/* Give back the distribution statistics */
+	if(lp->his_number > 0)
+		memcpy(extra, lp->his_sum, sizeof(long) * lp->his_number);
+
+	return(0);
 }
+#endif			/* HISTOGRAM */
+
+/*------------------------------------------------------------------*/
+/*
+ * Structures to export the Wireless Handlers
+ */
+
+static const iw_handler		wavelan_handler[] =
+{
+	NULL,				/* SIOCSIWNAME */
+	wavelan_get_name,		/* SIOCGIWNAME */
+	wavelan_set_nwid,		/* SIOCSIWNWID */
+	wavelan_get_nwid,		/* SIOCGIWNWID */
+	wavelan_set_freq,		/* SIOCSIWFREQ */
+	wavelan_get_freq,		/* SIOCGIWFREQ */
+	NULL,				/* SIOCSIWMODE */
+	NULL,				/* SIOCGIWMODE */
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
+	/* Bummer ! Why those are only at the end ??? */
+	wavelan_set_encode,		/* SIOCSIWENCODE */
+	wavelan_get_encode,		/* SIOCGIWENCODE */
+};
+
+static const iw_handler		wavelan_private_handler[] =
+{
+	wavelan_set_qthr,		/* SIOCIWFIRSTPRIV */
+	wavelan_get_qthr,		/* SIOCIWFIRSTPRIV + 1 */
+#ifdef HISTOGRAM
+	wavelan_set_histo,		/* SIOCIWFIRSTPRIV + 2 */
+	wavelan_get_histo,		/* SIOCIWFIRSTPRIV + 3 */
+#endif	/* HISTOGRAM */
+};
+
+static const struct iw_priv_args wavelan_private_args[] = {
+/*{ cmd,         set_args,                            get_args, name } */
+  { SIOCSIPQTHR, IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | 1, 0, "setqualthr" },
+  { SIOCGIPQTHR, 0, IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | 1, "getqualthr" },
+  { SIOCSIPHISTO, IW_PRIV_TYPE_BYTE | 16,                    0, "sethisto" },
+  { SIOCGIPHISTO, 0,                     IW_PRIV_TYPE_INT | 16, "gethisto" },
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
 
 /*------------------------------------------------------------------*/
 /*
@@ -4069,8 +4267,8 @@ static int __init wavelan_config(device 
 #endif				/* SET_MAC_ADDRESS */
 
 #ifdef WIRELESS_EXT		/* if wireless extension exists in the kernel */
-	dev->do_ioctl = wavelan_ioctl;
 	dev->get_wireless_stats = wavelan_get_wireless_stats;
+	dev->wireless_handlers = (struct iw_handler_def *)&wavelan_handler_def;
 #endif
 
 	dev->mtu = WAVELAN_MTU;
diff -u -p -r linux/drivers/net/wireless-w12/wavelan.p.h linux/drivers/net/wireless/wavelan.p.h
--- linux/drivers/net/wireless-w12/wavelan.p.h	Wed Jan 23 16:19:42 2002
+++ linux/drivers/net/wireless/wavelan.p.h	Wed Jan 23 16:50:49 2002
@@ -345,6 +345,12 @@
  *	- Fix spinlock stupid bugs that I left in. The driver is now SMP
  *		compliant and doesn't lockup at startup.
  *
+ * Changes made for release in 2.5.2 :
+ * ---------------------------------
+ *	- Use new driver API for Wireless Extensions :
+ *		o got rid of wavelan_ioctl()
+ *		o use a bunch of iw_handler instead
+ *
  * Wishes & dreams:
  * ----------------
  *	- roaming (see Pcmcia driver)
@@ -379,6 +385,7 @@
 #include	<linux/init.h>
 
 #include <linux/wireless.h>		/* Wireless extensions */
+#include <net/iw_handler.h>		/* Wireless handlers */
 
 /* WaveLAN declarations */
 #include	"i82586.h"
@@ -436,7 +443,7 @@
 /************************ CONSTANTS & MACROS ************************/
 
 #ifdef DEBUG_VERSION_SHOW
-static const char	*version	= "wavelan.c : v23 (SMP + wireless extensions) 05/10/00\n";
+static const char	*version	= "wavelan.c : v24 (SMP + wireless extensions) 11/12/01\n";
 #endif
 
 /* Watchdog temporisation */
@@ -449,11 +456,9 @@ static const char	*version	= "wavelan.c 
 
 #define SIOCSIPQTHR	SIOCIWFIRSTPRIV		/* Set quality threshold */
 #define SIOCGIPQTHR	SIOCIWFIRSTPRIV + 1	/* Get quality threshold */
-#define SIOCSIPLTHR	SIOCIWFIRSTPRIV + 2	/* Set level threshold */
-#define SIOCGIPLTHR	SIOCIWFIRSTPRIV + 3	/* Get level threshold */
 
-#define SIOCSIPHISTO	SIOCIWFIRSTPRIV + 6	/* Set histogram ranges */
-#define SIOCGIPHISTO	SIOCIWFIRSTPRIV + 7	/* Get histogram values */
+#define SIOCSIPHISTO	SIOCIWFIRSTPRIV + 2	/* Set histogram ranges */
+#define SIOCGIPHISTO	SIOCIWFIRSTPRIV + 3	/* Get histogram values */
 
 /****************************** TYPES ******************************/
 
