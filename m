Return-Path: <linux-kernel-owner+w=401wt.eu-S1030547AbXAHEy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030547AbXAHEy6 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 23:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030548AbXAHEy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 23:54:58 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:3488 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030547AbXAHEy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 23:54:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=afq6CW/gZsUw+dNPW2ype6PYpkl88Q0MpcaT/9tLUGj4WU48LnvkJ/PCv1lisAAPhmMC8yd5a8+yAXz39WtC1Khh9Ujn7Cjo01ijimKPyRzh8unxRoRt/agHgV+8jCPnscWErAvuQl2AJti/Eem4ca4z1C0psC0mD0Big781igc=
Date: Mon, 8 Jan 2007 06:54:28 +0200
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] UCC Ether driver: kmalloc casting cleanups
Message-ID: <20070108045428.GB18610@Ahmed>
Mail-Followup-To: Li Yang-r58472 <LeoLi@freescale.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20070106131832.GE19020@Ahmed> <989B956029373F45A0B8AF029708189006134E@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <989B956029373F45A0B8AF029708189006134E@zch01exm26.fsl.freescale.net>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 11:12:28AM +0800, Li Yang-r58472 wrote:
>
> NACK about the 2 clean-ups above.  Cast from pointer to integer is
> required here.
> 

Hi, here's the modified patch.

A patch to switch kmalloc to kzalloc and clean some redundant kmalloc
casts.

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 8243150..0f58f5f 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -2926,10 +2926,9 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	/* Init Tx bds */
 	for (j = 0; j < ug_info->numQueuesTx; j++) {
 		/* Setup the skbuff rings */
-		ugeth->tx_skbuff[j] =
-		    (struct sk_buff **)kmalloc(sizeof(struct sk_buff *) *
-					       ugeth->ug_info->bdRingLenTx[j],
-					       GFP_KERNEL);
+		ugeth->tx_skbuff[j] = kmalloc(sizeof(struct sk_buff *) *
+					      ugeth->ug_info->bdRingLenTx[j],
+					      GFP_KERNEL);
 
 		if (ugeth->tx_skbuff[j] == NULL) {
 			ugeth_err("%s: Could not allocate tx_skbuff",
@@ -2958,10 +2957,9 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	/* Init Rx bds */
 	for (j = 0; j < ug_info->numQueuesRx; j++) {
 		/* Setup the skbuff rings */
-		ugeth->rx_skbuff[j] =
-		    (struct sk_buff **)kmalloc(sizeof(struct sk_buff *) *
-					       ugeth->ug_info->bdRingLenRx[j],
-					       GFP_KERNEL);
+		ugeth->rx_skbuff[j] = kmalloc(sizeof(struct sk_buff *) *
+					      ugeth->ug_info->bdRingLenRx[j],
+					      GFP_KERNEL);
 
 		if (ugeth->rx_skbuff[j] == NULL) {
 			ugeth_err("%s: Could not allocate rx_skbuff",
@@ -3450,19 +3448,16 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	 * resource.
 	 * This shadow structure keeps a copy of what was done so that the
 	 * allocated resources can be released when the channel is freed.
+	 * *p_init_enet_param_shadow is zeroed by kzalloc
 	 */
-	if (!(ugeth->p_init_enet_param_shadow =
-	     (struct ucc_geth_init_pram *) kmalloc(sizeof(struct ucc_geth_init_pram),
-					      GFP_KERNEL))) {
+	if (!(ugeth->p_init_enet_param_shadow = 
+	      kzalloc(sizeof(struct ucc_geth_init_pram), GFP_KERNEL))) {
 		ugeth_err
 		    ("%s: Can not allocate memory for"
 			" p_UccInitEnetParamShadows.", __FUNCTION__);
 		ucc_geth_memclean(ugeth);
 		return -ENOMEM;
 	}
-	/* Zero out *p_init_enet_param_shadow */
-	memset((char *)ugeth->p_init_enet_param_shadow,
-	       0, sizeof(struct ucc_geth_init_pram));
 
 	/* Fill shadow InitEnet command parameter structure */
 


-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
