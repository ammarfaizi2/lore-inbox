Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVKUMsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVKUMsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 07:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVKUMsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 07:48:46 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:51333 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932279AbVKUMsp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 07:48:45 -0500
Message-ID: <4381C321.5010805@student.ltu.se>
Date: Mon, 21 Nov 2005 13:52:49 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       jgarzik@pobox.com, ashutosh.naik@gmail.com
Subject: Re: [PATCH -mm2] net: Fix compiler-error on dgrs.c when !CONFIG_PCI
References: <E1EdmMo-00020b-00@gondolin.me.apana.org.au> <438097D2.9020607@student.ltu.se> <20051120204001.GA11043@gondor.apana.org.au>
In-Reply-To: <20051120204001.GA11043@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

>On Sun, Nov 20, 2005 at 04:35:46PM +0100, Richard Knutsson wrote:
>  
>
>>>-#ifdef CONFIG_EISA
>>>-	cardcount = eisa_driver_register(&dgrs_eisa_driver);
>>>+	cardcount = dgrs_register_eisa();
>>>	if (cardcount < 0)
>>>		return cardcount;
>>>-#endif
>>>-	cardcount = pci_register_driver(&dgrs_pci_driver);
>>>-	if (cardcount)
>>>+	cardcount = dgrs_register_pci();
>>>+	if (cardcount < 0) {
>>>      
>>>
>>Are you sure it should be "cardcount < 0" and not "cardcount"?
>>    
>>
>
>Yes if cardcount is >= 0 then the registration was successful.
>
>  
>
>>>+		dgrs_unregister_eisa();
>>>      
>>>
>>Why change the behaviour off this driver?
>>    
>>
>
>Because the driver was buggy.  When this function returns a non-zero
>value, it must return the system to its original state.
>
>That means if the EISA driver has already been registered then it must
>be unregistered.
>
>Cheers,
>  
>
What do you think about this patch? Will you sign it? It is no longer an 
error-warning-fix but a bug-fix (and some cleanup).
I "took" you implementation of dgrs_(un)register_eisa(), especially 
since eisa needed to be unregistered if pci succeeds (I take you word 
for it to be so).
(BTW, this patch is compiled with CONFIG_PCI set, CONFIG_EISA set and 
both set without errors/warnings for dgrs.o.)

This patch requirer the 
"net-fix-compiler-error-on-dgrsc-when-config_pci.patch" (added to the 
-mm tree after 2.6.15-rc1-mm2):

--- devel/drivers/net/dgrs.c~net-fix-compiler-error-on-dgrsc-when-config_pci	2005-11-19 18:00:34.000000000 -0800
+++ devel-akpm/drivers/net/dgrs.c	2005-11-19 18:00:34.000000000 -0800
@@ -1458,6 +1458,8 @@ static struct pci_driver dgrs_pci_driver
 	.probe = dgrs_pci_probe,
 	.remove = __devexit_p(dgrs_pci_remove),
 };
+#else
+static struct pci_driver dgrs_pci_driver = {};
 #endif
 
 

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---

diff -Narup a/drivers/net/dgrs.c b/drivers/net/dgrs.c
--- a/drivers/net/dgrs.c	2005-11-21 11:25:29.000000000 +0100
+++ b/drivers/net/dgrs.c	2005-11-21 11:38:33.000000000 +0100
@@ -1522,6 +1522,26 @@ static struct eisa_driver dgrs_eisa_driv
 		.remove = __devexit_p(dgrs_eisa_remove),
 	}
 };
+
+
+static inline int dgrs_register_eisa(void)
+{
+	return eisa_driver_register(&dgrs_eisa_driver);
+}
+
+static inline void dgrs_unregister_eisa(void)
+{
+	eisa_driver_unregister(&dgrs_eisa_driver);
+}
+
+#else
+
+static inline int dgrs_register_eisa(void)
+{
+	return 0;
+}
+
+static inline void dgrs_unregister_eisa(void) {}
 #endif
 
 /*
@@ -1551,7 +1571,7 @@ MODULE_PARM_DESC(nicmode, "Digi RightSwi
 static int __init dgrs_init_module (void)
 {
 	int	i;
-	int	cardcount = 0;
+	int	cardcount;
 
 	/*
 	 *	Command line variable overrides
@@ -1592,25 +1612,23 @@ static int __init dgrs_init_module (void
 	/*
 	 *	Find and configure all the cards
 	 */
-#ifdef CONFIG_EISA
-	cardcount = eisa_driver_register(&dgrs_eisa_driver);
+
+	cardcount = dgrs_register_eisa();
 	if (cardcount < 0)
 		return cardcount;
-#endif
+
 	cardcount = pci_register_driver(&dgrs_pci_driver);
-	if (cardcount)
+	if (cardcount < 0) {
+		dgrs_unregister_eisa();
 		return cardcount;
+	}
 	return 0;
 }
 
 static void __exit dgrs_cleanup_module (void)
 {
-#ifdef CONFIG_EISA
-	eisa_driver_unregister (&dgrs_eisa_driver);
-#endif
-#ifdef CONFIG_PCI
+	dgrs_unregister_eisa();
 	pci_unregister_driver (&dgrs_pci_driver);
-#endif
 }
 
 module_init(dgrs_init_module);


