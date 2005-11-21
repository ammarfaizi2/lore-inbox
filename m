Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVKUTrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVKUTrL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVKUTrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:47:11 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:45774 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932443AbVKUTrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:47:01 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <438223D9.8010504@s5r6.in-berlin.de>
Date: Mon, 21 Nov 2005 20:45:29 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: bcollins@debian.org, scjody@steamballoon.com,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/csr1212.c: remove dead code
References: <20051120231000.GE16060@stusta.de>
In-Reply-To: <20051120231000.GE16060@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.339) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The Coverity checker spotted that the same check was already done above.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.15-rc1-mm2-full/drivers/ieee1394/csr1212.c.old	2005-11-20 22:50:14.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/ieee1394/csr1212.c	2005-11-20 22:50:36.000000000 +0100
> @@ -1616,12 +1616,8 @@
>  	 * and make cache regions for them */
>  	for (dentry = csr->root_kv->value.directory.dentries_head;
>  	     dentry; dentry = dentry->next) {
> -		if (dentry->kv->key.id == CSR1212_KV_ID_EXTENDED_ROM) {
> +		if (dentry->kv->key.id == CSR1212_KV_ID_EXTENDED_ROM)
>  			csr1212_get_keyval(csr, dentry->kv);
> -
> -			if (ret != CSR1212_SUCCESS)
> -				return ret;
> -		}
>  	}
>  
>  	return CSR1212_SUCCESS;

Yes, this is dead code. But when I looked through csr1212_parse_csr() 
which you are patching here, I wondered why the return code of 
csr1212_get_keyval() is never checked there. csr1212_get_keyval() 
performs memory allocations and bus reads. Shouldn't both calls of 
csr1212_get_keyval() be enclosed in something like this?

	if(!csr1212_get_keyval(...))
		return ~ CSR1212_SUCCESS;

Or for better yet, we should use _csr1212_read_keyval() instead so that 
we get more sensible error codes.
-- 
Stefan Richter
-=====-=-=-= =-== =-=-=
http://arcgraph.de/sr/
