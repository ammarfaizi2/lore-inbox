Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932655AbVJ0Vl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbVJ0Vl6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbVJ0Vl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:41:56 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:60053 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S932236AbVJ0Vlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:41:55 -0400
Message-ID: <436149B7.8080202@free.fr>
Date: Thu, 27 Oct 2005 23:42:15 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Marcel Selhorst <selhorst@crypto.rub.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kylene Jo Hall <kjhall@us.ibm.com>
Subject: Re: [PATCH] Infineon TPM: move infineon driver off pci_dev
References: <435FB8A5.803@crypto.rub.de> <435FBFC4.5060508@free.fr> <4360B889.1010502@crypto.rub.de>
In-Reply-To: <4360B889.1010502@crypto.rub.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Marcel Selhorst wrote:
 > Dear all,
 >
 > the following patch moves the Infineon TPM driver off pci device
 > and makes it a pure pnp-driver. It was tested with IFX0101 and
 > IFX0102 and is now based on the new tpm patchset (1 to 5) from Kylene
 > Hall submitted two days ago. It now also includes pnp-port validation
 > and region requesting.
 >
 > Best regards,
 >
 > Marcel Selhorst
 >
 > Signed-off-by: Marcel Selhorst <selhorst@crypto.rub.de>
 > ---
 >

 > +	/* read IO-ports through PnP */
 > +	if (pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) &&
 > +	    !(pnp_port_flags(dev, 0) & IORESOURCE_DISABLED)) {
&& !(pnp_port_flags(dev, 1) & IORESOURCE_DISABLED)

 > +		TPM_INF_ADDR = pnp_port_start(dev, 0);
 > +		TPM_INF_DATA = (TPM_INF_ADDR + 1);
 > +		TPM_INF_BASE = pnp_port_start(dev, 1);
 > +		TPM_INF_PORT_LEN = pnp_port_len(dev, 1);
 > +		if (!TPM_INF_PORT_LEN)
 > +			return -EINVAL;
When I said to check the lenght I was thinking about
if (pnp_port_len(dev, 1) < 4) return -EINVAL;
According to infineon_tpm_register, the length is at least 4.

I whould also check that pnp_port_len(dev, 0) < 2.





 > +		dev_info(&dev->dev, "Found %s with ID %s\n",
 > +			 dev->name, dev_id->id);
 > +		if (!((TPM_INF_BASE >> 8) & 0xff))
 > +			return -EINVAL;
 > +		/* publish my base address and request region */
 > +		tpm_inf.base = TPM_INF_BASE;
 > +		if (request_region
 > +		    (tpm_inf.base, TPM_INF_PORT_LEN, "tpm_infineon0") == NULL) {
 > +			release_region(tpm_inf.base, TPM_INF_PORT_LEN);
if it failed, you don't need to release the region

a request_region (TPM_INF_ADDR, 2, "tpm_infineon0") could be usefull.

 > +			return -EINVAL;
 > +		}
 >  	} else {

