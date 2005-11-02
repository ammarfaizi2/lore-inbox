Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965240AbVKBUvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbVKBUvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 15:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965238AbVKBUvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 15:51:31 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:11652 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S965236AbVKBUva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 15:51:30 -0500
Message-ID: <436927CA.3090105@student.ltu.se>
Date: Wed, 02 Nov 2005 21:55:38 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ashutosh Naik <ashutosh.lkml@gmail.com>
CC: netdev@vger.kernel.org, davej@suse.de, acme@conectiva.com.br,
       linux-net@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [PATCH]dgrs - Fixes Warnings when CONFIG_ISA and CONFIG_PCI are
 not enabled
References: <81083a450511012314q4ec69927gfa60cb19ba8f437a@mail.gmail.com>	 <4368878D.4040406@student.ltu.se> <c216304e0511020516o5cfcd0b9u96a3220bf2694928@mail.gmail.com>
In-Reply-To: <c216304e0511020516o5cfcd0b9u96a3220bf2694928@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>>>This patch fixes compiler warnings when CONFIG_ISA and CONFIG_PCI are
>>>not enabled in the dgrc network driver.
>>>
>>>Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>
>>>
>>>--
>>>diff -Naurp linux-2.6.14/drivers/net/dgrs.c
>>>linux-2.6.14-git1/drivers/net/dgrs.c---
>>>linux-2.6.14/drivers/net/dgrs.c     2005-10-28 05:32:08.000000000
>>>+0530
>>>+++ linux-2.6.14-git1/drivers/net/dgrs.c        2005-11-01
>>>10:30:03.000000000 +0530
>>>@@ -1549,8 +1549,12 @@ MODULE_PARM_DESC(nicmode, "Digi RightSwi
>>>static int __init dgrs_init_module (void)  {
>>>       int     i;
>>>-       int eisacount = 0, pcicount = 0;
>>>-
>>>+#ifdef CONFIG_EISA
>>>+       int eisacount = 0;
>>>+#endif
>>>+#ifdef CONFIG_PCI
>>>+       int pcicount = 0;
>>>+#endif
>>>       /*
>>>        *      Command line variable overrides
>>>        *              debug=NNN
>>>-
>>>      
>>>

>>Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
>>
>>---
>>
>>diff -uNr a/drivers/net/dgrs.c b/drivers/net/dgrs.c
>>--- a/drivers/net/dgrs.c        2005-08-29 01:41:01.000000000 +0200
>>+++ b/drivers/net/dgrs.c        2005-10-26 15:53:43.000000000 +0200
>>@@ -1549,7 +1549,7 @@
>> static int __init dgrs_init_module (void)
>> {
>>        int     i;
>>-       int eisacount = 0, pcicount = 0;
>>+       int     count;
>>
>>        /*
>>         *      Command line variable overrides
>>@@ -1591,14 +1591,14 @@
>>         *      Find and configure all the cards
>>         */
>> #ifdef CONFIG_EISA
>>-       eisacount = eisa_driver_register(&dgrs_eisa_driver);
>>-       if (eisacount < 0)
>>-               return eisacount;
>>+       count = eisa_driver_register(&dgrs_eisa_driver);
>>+       if (count < 0)
>>+               return count;
>> #endif
>> #ifdef CONFIG_PCI
>>-       pcicount = pci_register_driver(&dgrs_pci_driver);
>>-       if (pcicount)
>>-               return pcicount;
>>+       count = pci_register_driver(&dgrs_pci_driver);
>>+       if (count)
>>+               return count;
>> #endif
>>        return 0;
>> }
>>    
>>
>
>Well, both of them do the same stuff, but one of these patches needs
>to be committed.
>
>Cheers
>Ashutosh
>  
>
Can both CONFIG_PCI and CONFIG_EISA be undefined at the same time? If 
so, I think you patch is better.
But on line 1015 in the dgrs.c-file (function dgrs_download()) there is 
an if-statement:
    if (priv0->plxreg)
    {    /* PCI bus */
        ...
    }
    else
    {    /* EISA bus */
        ...
from where I got the idea it needs either pci or eisa (or both). If this 
is true, I vote for my patch.

Live long and prosper
/Richard

PS
Rick's mail-address in the file seems invalid. Changed it to 
netdev@vger.kernel.org, since that is the address in the MAINTAINERS-file.
DS

