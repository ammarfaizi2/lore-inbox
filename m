Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVKTPbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVKTPbH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 10:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVKTPbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 10:31:07 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:186 "EHLO gepetto.dc.ltu.se")
	by vger.kernel.org with ESMTP id S1751257AbVKTPbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 10:31:05 -0500
Message-ID: <438097D2.9020607@student.ltu.se>
Date: Sun, 20 Nov 2005 16:35:46 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       jgarzik@pobox.com, ashutosh.naik@gmail.com
Subject: Re: [PATCH -mm2] net: Fix compiler-error on dgrs.c when !CONFIG_PCI
References: <E1EdmMo-00020b-00@gondolin.me.apana.org.au>
In-Reply-To: <E1EdmMo-00020b-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

>Richard Knutsson <ricknu-0@student.ltu.se> wrote:
>  
>
>>diff -Narup a/drivers/net/dgrs.c b/drivers/net/dgrs.c
>>--- a/drivers/net/dgrs.c        2005-11-19 20:17:51.000000000 +0100
>>+++ b/drivers/net/dgrs.c        2005-11-19 20:29:52.000000000 +0100
>>@@ -1458,6 +1458,8 @@ static struct pci_driver dgrs_pci_driver
>>       .probe = dgrs_pci_probe,
>>       .remove = __devexit_p(dgrs_pci_remove),
>>};
>>+#else
>>+static struct pci_driver dgrs_pci_driver = {};
>>#endif
>>    
>>
>
>How about something like this?
>
>[NETDRV] dgrs: Fix compiler-error on dgrs.c when !CONFIG_PCI
>  
>
[NETDRV], is that "standard" formating? If so, is there any more? Thanks :)

>The previous patch on this driver removed the #ifdef CONFIG_PCI
>around the pci_register_driver call in order to avoid a warning
>about an unused variable.  This produces an error since the PCI
>driver object is undefined if CONFIG_PCI is not set.
>  
>
Well, not really. The removal of CONFIG_PCI was just a final touch by 
Andrew Morton. The only real change were from having two variables, for 
eisa and pci, to having one common.

>Instead of doing that, we should simply make sure that the
>cardcount variable is always used.
>  
>
Is it not? The problem were that dgrs_pci_driver was not defined if 
!CONFIG_PCI, and because the pci_*-functions have empty shells if 
!CONFIG_PCI, it is quite nice to use them without #ifdef.
So the simplest solution (as I saw it) was to define an empty 
dgrs_pci_driver when CONFIG_PCI is not set.
On the design perspective, I would argue that struct's is more 
appropriate within #ifdef's then functions.

>The following patch does this by making inline function wrappers
>to do the actual registration/deregistration.
>  
>
I must say, I like that eisa gets addressed in the same manner as pci. 
But is it not more appropriate to implement empty eisa-functions if 
!CONFIG_EISA in linux/eisa.h (or equal)?

>This problem was reported by Richard Knutsson.
>
>Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
>Cheers,
>  
>
Thank you for the review,
Richard Knutsson

PS
You realize you have not tushed the cardcount-"problem"? ;)
DS

> diff --git a/drivers/net/dgrs.c b/drivers/net/dgrs.c
> --- a/drivers/net/dgrs.c
> +++ b/drivers/net/dgrs.c
> @@ -1458,6 +1458,25 @@ static struct pci_driver dgrs_pci_driver
>  	.probe = dgrs_pci_probe,
>  	.remove = __devexit_p(dgrs_pci_remove),
>  };
> +
> +static inline int dgrs_register_pci(void)
> +{
> +	return pci_register_driver(&dgrs_pci_driver);
> +}
> +
> +static inline void dgrs_unregister_pci(void)
> +{
> +	pci_unregister_driver(&dgrs_pci_driver);
> +}
> +#else
> +static inline int dgrs_register_pci(void)
> +{
> +	return 0;
> +}
> +
> +static inline int dgrs_unregister_pci(void)
> +{
> +}
>  #endif
>  
>  
> @@ -1520,6 +1539,25 @@ static struct eisa_driver dgrs_eisa_driv
>  		.remove = __devexit_p(dgrs_eisa_remove),
>  	}
>  };
> +
> +static inline int dgrs_register_eisa(void)
> +{
> +	return eisa_driver_register(&dgrs_eisa_driver);
> +}
> +
> +static inline void dgrs_unregister_eisa(void)
> +{
> +	eisa_driver_unregister(&dgrs_eisa_driver);
> +}
> +#else
> +static inline int dgrs_register_eisa(void)
> +{
> +	return 0;
> +}
> +
> +static inline void dgrs_unregister_eisa(void)
> +{
> +}
>  #endif
>  
>  /*
> @@ -1590,25 +1628,21 @@ static int __init dgrs_init_module (void
>  	/*
>  	 *	Find and configure all the cards
>  	 */
> -#ifdef CONFIG_EISA
> -	cardcount = eisa_driver_register(&dgrs_eisa_driver);
> +	cardcount = dgrs_register_eisa();
>  	if (cardcount < 0)
>  		return cardcount;
> -#endif
> -	cardcount = pci_register_driver(&dgrs_pci_driver);
> -	if (cardcount)
> +	cardcount = dgrs_register_pci();
> +	if (cardcount < 0) {
Are you sure it should be "cardcount < 0" and not "cardcount"?
> +		dgrs_unregister_eisa();
Why change the behaviour off this driver?
>  		return cardcount;
> +	}
>  	return 0;
>  }
>  
>  static void __exit dgrs_cleanup_module (void)
>  {
> -#ifdef CONFIG_EISA
> -	eisa_driver_unregister (&dgrs_eisa_driver);
> -#endif
> -#ifdef CONFIG_PCI
> -	pci_unregister_driver (&dgrs_pci_driver);
> -#endif
> +	dgrs_unregister_pci();
> +	dgrs_unregister_eisa();
>  }
>  
>  module_init(dgrs_init_module);


