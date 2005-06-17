Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVFQHWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVFQHWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 03:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVFQHWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 03:22:53 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:64483 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261887AbVFQHWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 03:22:51 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] fealnx.c calls dev_kfree_skb from atomic context. fix it
Date: Fri, 17 Jun 2005 10:22:24 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wonsCFfGKJtaJdt"
Message-Id: <200506171022.24460.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_wonsCFfGKJtaJdt
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jeff,

Just a resend. Applies with offset to 2.6.12-rc2
--
vda

--Boundary-00=_wonsCFfGKJtaJdt
Content-Type: text/x-diff;
  charset="koi8-r";
  name="fealnx_skbfree.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fealnx_skbfree.patch"

I believe I actually saw 'Badness' message because I used
wrong function.

No need to check and use exactly matching function,
This is not a fast path.

diff -urN linux-2.6.6-bk7.src/drivers/net/fealnx.c linux-2.6.6-bk7-fealnx.src/drivers/net/fealnx.c
--- linux-2.6.6-bk7.src/drivers/net/fealnx.c	Thu May 20 21:38:05 2004
+++ linux-2.6.6-bk7-fealnx.src/drivers/net/fealnx.c	Thu May 20 21:43:31 2004
@@ -1435,8 +1435,7 @@
 		if (cur->skbuff) {
 			pci_unmap_single(np->pci_dev, cur->buffer,
 				cur->skbuff->len, PCI_DMA_TODEVICE);
-			dev_kfree_skb(cur->skbuff);
-			/* or dev_kfree_skb_irq(cur->skbuff); ? */
+			dev_kfree_skb_any(cur->skbuff);
 			cur->skbuff = NULL;
 		}
 		cur->status = 0;

--Boundary-00=_wonsCFfGKJtaJdt--

