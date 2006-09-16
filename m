Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWIPMkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWIPMkS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 08:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWIPMkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 08:40:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:52957 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964795AbWIPMkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 08:40:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=W2rBtH3g7nps6LvG/mxJrE4zA9abm/b7VdEckglMgHCq/KYABasZbtpiI302GbQ8Wcg4X241JGUieRX1X4x5ZDDCEtLQzxILSEurrN0hdU5pvh/c+7hjNqv+38e4mKiNA/YvnAstC6Ag1NhD1Y85PVKWsar1RidA5OF22A0v2S0=
Message-ID: <450BF0A1.4040807@gmail.com>
Date: Sat, 16 Sep 2006 14:39:38 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mxser: PCI refcounts
References: <1158329578.29932.38.camel@localhost.localdomain>
In-Reply-To: <1158329578.29932.38.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Switch to pci ref counts for mxser when handling PCI devices. Use
> pci_get_device and drop the reference when we finish and unload.

Please, don't do that. These all drivers need to be rewritten to pci probing 
(for this one I have a patch, but I waited for confirmation of previous 
patchset, but nothing has come, so perhaps I will clone it as NEW/EXPERIMENTAL 
1.9.1-with-pci-probing-driver) and when pci_find_device is there, we can `grep 
-r` it to know, which drivers need that. The same holds for zoran cards, which 
somebody wanted to play with (and rework), but as I can see, nothing happened :/.

[Changes in devices such as mtd are OK in my eyes...]

> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/char/mxser.c linux-2.6.18-rc6-mm1/drivers/char/mxser.c
> --- linux.vanilla-2.6.18-rc6-mm1/drivers/char/mxser.c	2006-09-11 17:00:09.000000000 +0100
> +++ linux-2.6.18-rc6-mm1/drivers/char/mxser.c	2006-09-14 16:14:52.000000000 +0100
> @@ -538,6 +538,7 @@
>  			if (pdev != NULL) {	/* PCI */
>  				release_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2));
>  				release_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3));
> +				pci_dev_put(pdev);
>  			} else {
>  				release_region(mxsercfg[i].ioaddr[0], 8 * mxsercfg[i].ports);
>  				release_region(mxsercfg[i].vector, 1);
> @@ -862,9 +865,9 @@
>  	index = 0;
>  	b = 0;
>  	while (b < n) {
> -		pdev = pci_find_device(mxser_pcibrds[b].vendor,
> +		pdev = pci_get_device(mxser_pcibrds[b].vendor,
>  				mxser_pcibrds[b].device, pdev);
> -			if (pdev == NULL) {
> +		if (pdev == NULL) {
>  			b++;
>  			continue;
>  		}
> @@ -916,6 +919,9 @@
>  			if (mxser_initbrd(m, &hwconf) < 0)
>  				continue;
>  			m++;
> +			/* Keep an extra reference if we succeeded. It will
> +			   be returned at unload time */
> +			pci_dev_get(pdev);
>  		}
>  	}
>  #endif
> 

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
