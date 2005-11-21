Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbVKUWDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVKUWDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVKUWDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:03:25 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:30172 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751094AbVKUWDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:03:24 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <438243E2.6050807@s5r6.in-berlin.de>
Date: Mon, 21 Nov 2005 23:02:10 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jody McIntyre <scjody@steamballoon.com>
CC: Adrian Bunk <bunk@stusta.de>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/csr1212.c: remove dead code
References: <20051120231000.GE16060@stusta.de> <438223D9.8010504@s5r6.in-berlin.de> <20051121214130.GL20781@conscoop.ottawa.on.ca>
In-Reply-To: <20051121214130.GL20781@conscoop.ottawa.on.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.347) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jody McIntyre wrote:
> --- linux.orig/drivers/ieee1394/csr1212.c
> +++ linux/drivers/ieee1394/csr1212.c
> @@ -1610,16 +1610,16 @@ int csr1212_parse_csr(struct csr1212_csr
>  	csr->root_kv->valid = 0;
>  	csr->root_kv->next = csr->root_kv;
>  	csr->root_kv->prev = csr->root_kv;
> -	csr1212_get_keyval(csr, csr->root_kv);
> +	if (_csr1212_read_keyval(csr, csr->root_kv) != CSR1212_SUCCESS)
> +		return ret;

-	csr1212_get_keyval(csr, csr->root_kv);
+	ret = _csr1212_read_keyval(csr, csr->root_kv);
+	if (ret != CSR1212_SUCCESS)
+		return ret;

>  
>  	/* Scan through the Root directory finding all extended ROM regions
>  	 * and make cache regions for them */
>  	for (dentry = csr->root_kv->value.directory.dentries_head;
>  	     dentry; dentry = dentry->next) {
>  		if (dentry->kv->key.id == CSR1212_KV_ID_EXTENDED_ROM) {
> -			csr1212_get_keyval(csr, dentry->kv);
> -
> -			if (ret != CSR1212_SUCCESS)
> +			if (_csr1212_read_keyval(csr, dentry->kv) !=
> +						CSR1212_SUCCESS)
>  				return ret;
>  		}
>  	}
> 

-		if (dentry->kv->key.id == CSR1212_KV_ID_EXTENDED_ROM) {
-			csr1212_get_keyval(csr, dentry->kv);
-
+		if (dentry->kv->key.id == CSR1212_KV_ID_EXTENDED_ROM &&
+		    !dentry->kv->valid) {
+			ret = _csr1212_read_keyval(csr, dentry->kv);
  			if (ret != CSR1212_SUCCESS)
  				return ret;
  		}


Although I am not quite sure if the check for !valid is really required. 
It certainly cannot hurt.
-- 
Stefan Richter
-=====-=-=-= =-== =-=-=
http://arcgraph.de/sr/
