Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVGTMIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVGTMIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 08:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVGTMIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 08:08:42 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:56704 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261178AbVGTMIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 08:08:41 -0400
Message-ID: <42DE3E03.1070401@gmail.com>
Date: Wed, 20 Jul 2005 14:05:23 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rth@twiddle.net,
       dhowells@redhat.com, kumar.gala@freescale.com, davem@davemloft.net,
       mhw@wittsend.com, Rogier Wolff <R.E.Wolff@bitwizard.nl>,
       nils@kernelconcepts.de, Lionel.Bouton@inet6.fr,
       benh@kernel.crashing.org, mchehab@brturbo.com.br, laredo@gnu.org,
       rbultje@ronald.bitfreak.net, middelin@polyware.nl, philb@gnu.org,
       tim@cyberelk.net, campbell@torque.net, andrea@suse.de, mulix@mulix.org
Subject: Re: [PATCH] pci_find_device --> pci_get_device
References: <42DC4873.2080807@gmail.com> <200507191820.35472@bilbo.math.uni-mannheim.de> <42DE2A31.7080505@gmail.com> <200507201319.42050@bilbo.math.uni-mannheim.de>
In-Reply-To: <200507201319.42050@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer napsal(a):

>Am Mittwoch, 20. Juli 2005 12:40 schrieb Jiri Slaby:
>  
>
>>Rolf Eike Beer napsal(a):
>>    
>>
>>>Your patch to arch/sparc64/kernel/ebus.c is broken, the removed and added
>>>parts do not match in behaviour.
>>>      
>>>
>>I can't still see the difference.
>>    
>>
>
>diff --git a/arch/sparc64/kernel/ebus.c b/arch/sparc64/kernel/ebus.c
>--- a/arch/sparc64/kernel/ebus.c
>+++ b/arch/sparc64/kernel/ebus.c
>@@ -527,8 +527,15 @@ static struct pci_dev *find_next_ebus(st
> {
> 	struct pci_dev *pdev = start;
> 
>-	do {
>-		pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
>+    while (pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev))
>+		if (pdev->device == PCI_DEVICE_ID_SUN_EBUS ||
>+			pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS)
>+			break;
>+
>+	*is_rio_p = !!(pdev && (pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS));
>+	
>+/*	do { // BEFORE \/           AFTER ^
>+ *		pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
> 		if (pdev &&
> 		    (pdev->device == PCI_DEVICE_ID_SUN_EBUS ||
> 		     pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS))
>  
>
The code was:
  do {
      pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
        if (pdev &&
            (pdev->device == PCI_DEVICE_ID_SUN_EBUS ||
             pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS))
            break;
    } while (pdev != NULL);

    if (pdev && (pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS))
        *is_rio_p = 1;
    else
        *is_rio_p = 0;

and I changed to:
    while (pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev))
        if (pdev->device == PCI_DEVICE_ID_SUN_EBUS ||
            pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS)
            break;

    *is_rio_p = !!(pdev && (pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS));

Is there any difference? I don't see any, but... The reading of diff 
file in this case is not the best, maybe...

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

