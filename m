Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268525AbUIPRQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268525AbUIPRQK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267659AbUIPRNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:13:39 -0400
Received: from nef.ens.fr ([129.199.96.32]:62216 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S268367AbUIPRJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:09:56 -0400
To: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Suspend2 Merge: Device driver fixes 1/2
In-Reply-To: <1095331532.3855.133.camel@laptop.cunninghams>
References: <1095331532.3855.133.camel@laptop.cunninghams>
Date: Thu, 16 Sep 2004 19:09:49 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <20040916170949.E13E219B98@quatramaran.ens.fr>
From: ebrunet@quatramaran.ens.fr ( =?ISO-8859-1?Q?=C9ric?= Brunet)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.3 (nef.ens.fr [129.199.96.32]); Thu, 16 Sep 2004 19:09:50 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I kept trying to push this patch to Paul Gortmaker (maintainer of
the n2kpci driver), but to no avail. I guess I won't have to any more.

Éric Brunet

> -----Forwarded Message-----
>> From: Éric Brunet <Eric.Brunet@lps.ens.fr>
>> To: Paul Gortmaker <p_gortmaker@yahoo.com>
>> Cc: arekm@pld-linux.org, linux-kernel@vger.kernel.org
>> Subject: PATCH swsuspend for ne2k-pci cards
>> Date: Sat, 21 Aug 2004 14:14:30 +0200
>> 
>> Hi,
>> 
>> Arkadiusz Miskiewicz had some suggestions to improve my patch which
>> adds suspend/resume support to ne2k-pci.c. Actually, he basically rewrote
>> it.
>> 
>> This patch was only tested on my own ne2k clone [Realtek Semiconductor
>> Co., Ltd. RTL-8029(AS)], and it works nicely for me. As 1) it cannot hurt
>> people which are not using swsuspend 2) it can only improve things for
>> people using swsuspend, it would be nice if this patch could go into the
>> kernel.
>> 
>> Thank you,
>> 
>> 	Éric Brunet
>
> diff -ruN linux-2.6.9-rc1/drivers/net/ne2k-pci.c software-suspend-linux-2.6.9-rc1-rev3/drivers/net/ne2k-pci.c
> --- linux-2.6.9-rc1/drivers/net/ne2k-pci.c	2004-09-07 21:58:41.000000000 +1000
> +++ software-suspend-linux-2.6.9-rc1-rev3/drivers/net/ne2k-pci.c	2004-09-09 19:36:24.000000000 +1000
> @@ -653,12 +653,43 @@
>  	pci_set_drvdata(pdev, NULL);
>  }
>  
> +#ifdef CONFIG_PM
> +static int ne2k_pci_suspend (struct pci_dev *pdev, u32 state)
> +{
> +	struct net_device *dev = pci_get_drvdata (pdev);
> +
> +	netif_device_detach(dev);
> +	pci_save_state(pdev, pdev->saved_config_space);
> +	pci_set_power_state(pdev, state);
> +
> +	return 0;
> +}
> +
> +static int ne2k_pci_resume (struct pci_dev *pdev)
> +{
> +	struct net_device *dev = pci_get_drvdata (pdev);
> +
> +	pci_set_power_state(pdev, 0);
> +	pci_restore_state(pdev, pdev->saved_config_space);
> +	NS8390_init(dev, 1);
> +	netif_device_attach(dev);
> +
> +	return 0;
> +}
> +
> +#endif /* CONFIG_PM */
> +
>  
>  static struct pci_driver ne2k_driver = {
>  	.name		= DRV_NAME,
>  	.probe		= ne2k_pci_init_one,
>  	.remove		= __devexit_p(ne2k_pci_remove_one),
>  	.id_table	= ne2k_pci_tbl,
> +#ifdef CONFIG_PM
> +	.suspend	= ne2k_pci_suspend,
> +	.resume		= ne2k_pci_resume,
> +#endif /* CONFIG_PM */
> +
>  };
>  
> -- 
> Nigel Cunningham
> Pastoral Worker
> Christian Reformed Church of Tuggeranong
> PO Box 1004, Tuggeranong, ACT 2901
>
> Many today claim to be tolerant. True tolerance, however, can cope with others
> being intolerant.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
