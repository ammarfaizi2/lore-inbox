Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbWJBR4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbWJBR4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWJBR4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:56:39 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:56292 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S965194AbWJBR4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:56:38 -0400
Date: Mon, 2 Oct 2006 10:52:45 -0700
To: Andrew Morton <akpm@osdl.org>, Pavel Roskin <proski@gnu.org>
Cc: Valdis.Kletnieks@vt.edu, "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
Message-ID: <20061002175245.GA14744@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu> <20060928202931.dc324339.akpm@osdl.org> <200609291519.k8TFJfvw004256@turing-police.cc.vt.edu> <20060929124558.33ef6c75.akpm@osdl.org> <200609300001.k8U01sPI004389@turing-police.cc.vt.edu> <20060929182008.fee2a229.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929182008.fee2a229.akpm@osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 06:20:08PM -0700, Andrew Morton wrote:
> On Fri, 29 Sep 2006 20:01:54 -0400
> > 
> > % grep ioctl /tmp/foo2 | sort -u | more
> > ioctl(13, SIOCGIWESSID, 0xbfbcdb9c)     = 0
> > ioctl(13, SIOCGIWRANGE, 0xbfbcdbdc)     = 0
> > ioctl(13, SIOCGIWRATE, 0xbfbcdbbc)      = 0
> 
> Yes.  The main thing which those WE-21 patches do is to shorten the size of
> various buffers which are used in wireless ioctls.

	Ok, I've found it. Actually, I feel ashamed, as it is a fairly
classical buffer overflow, we put one extra char in a buffer. Now, I
don't understand why it did not blow up on my box ;-)
	New patch. I think it is right, but I would not mind Pavel to
have a look at it. On my box it does not make thing worse.
	Valdis : would you mind trying if this patch fix the problem
you are seeing with WE-21 ? If it fixes it, I'll send it to John...
	Have fun...

	Jean

P.S. : I'll audit the other wireless drivers for the same thing.

-------------------------------------------------

diff -u -p linux/drivers/net/wireless/orinoco.j1.c linux/drivers/net/wireless/orinoco.c
--- linux/drivers/net/wireless/orinoco.j1.c	2006-10-02 10:15:41.000000000 -0700
+++ linux/drivers/net/wireless/orinoco.c	2006-10-02 10:39:20.000000000 -0700
@@ -2456,6 +2456,7 @@ void free_orinocodev(struct net_device *
 /* Wireless extensions                                              */
 /********************************************************************/
 
+/* Return : < 0 -> error code ; >= 0 -> length */
 static int orinoco_hw_get_essid(struct orinoco_private *priv, int *active,
 				char buf[IW_ESSID_MAX_SIZE+1])
 {
@@ -2500,9 +2501,9 @@ static int orinoco_hw_get_essid(struct o
 	len = le16_to_cpu(essidbuf.len);
 	BUG_ON(len > IW_ESSID_MAX_SIZE);
 
-	memset(buf, 0, IW_ESSID_MAX_SIZE+1);
+	memset(buf, 0, IW_ESSID_MAX_SIZE);
 	memcpy(buf, p, len);
-	buf[len] = '\0';
+	err = len;
 
  fail_unlock:
 	orinoco_unlock(priv, &flags);
@@ -3026,17 +3027,18 @@ static int orinoco_ioctl_getessid(struct
 
 	if (netif_running(dev)) {
 		err = orinoco_hw_get_essid(priv, &active, essidbuf);
-		if (err)
+		if (err < 0)
 			return err;
+		erq->length = err;
 	} else {
 		if (orinoco_lock(priv, &flags) != 0)
 			return -EBUSY;
-		memcpy(essidbuf, priv->desired_essid, IW_ESSID_MAX_SIZE + 1);
+		memcpy(essidbuf, priv->desired_essid, IW_ESSID_MAX_SIZE);
+		erq->length = strlen(priv->desired_essid);
 		orinoco_unlock(priv, &flags);
 	}
 
 	erq->flags = 1;
-	erq->length = strlen(essidbuf);
 
 	return 0;
 }
@@ -3074,10 +3076,10 @@ static int orinoco_ioctl_getnick(struct 
 	if (orinoco_lock(priv, &flags) != 0)
 		return -EBUSY;
 
-	memcpy(nickbuf, priv->nick, IW_ESSID_MAX_SIZE+1);
+	memcpy(nickbuf, priv->nick, IW_ESSID_MAX_SIZE);
 	orinoco_unlock(priv, &flags);
 
-	nrq->length = strlen(nickbuf);
+	nrq->length = strlen(priv->nick);
 
 	return 0;
 }
