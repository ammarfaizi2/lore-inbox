Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136210AbRD2UQm>; Sun, 29 Apr 2001 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136214AbRD2UQd>; Sun, 29 Apr 2001 16:16:33 -0400
Received: from front6.grolier.fr ([194.158.96.56]:52167 "EHLO
	front6.grolier.fr") by vger.kernel.org with ESMTP
	id <S136210AbRD2UQ1> convert rfc822-to-8bit; Sun, 29 Apr 2001 16:16:27 -0400
Date: Sun, 29 Apr 2001 19:05:05 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Steffen Persvold <sp@scali.no>
cc: lkml <linux-kernel@vger.kernel.org>, davej@suse.de, troels@thule.no
Subject: Re: ServerWorks LE and MTRR
In-Reply-To: <3AEC6384.C59FAC9@scali.no>
Message-ID: <Pine.LNX.4.10.10104291846080.1226-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Apr 2001, Steffen Persvold wrote:

> Hi all,
> 
> I just compiled 2.4.4 and are running it on a Serverworks LE motherboard.
> Whenever I try to add a write-combining region, it gets rejected. I took a peek
> in the arch/i386/kernel/mtrr.c and found that this is just as expected with
> v1.40 of the code. It is great that the mtrr code checks and prevents the user
> from doing something that could eventually lead to data corruption. Using
> write-combining on PCI acesses can lead to this on certain LE revisions but
> _not_ all (only rev < 5). Therefore please consider my small patch to allow the
> good ones to be able to use write-combining. I have several rev 06 and they are
> working fine with this patch.

You wrote that 'only rev < 5' can lead to data corruption, but your patch
seems to disallow use of write combining for rev 5 too.

Could you clarify?

  Gérard.

PS:
>From what hat did you get this information ? as it seems that ServerWorks
require NDA for letting know technical information on their chipsets.

> Best regards,
> -- 
>  Steffen Persvold                        Systems Engineer
>  Email  : mailto:sp@scali.com            Scali AS (http://www.scali.com)
>  Norway : Tel  : (+47) 2262 8950         Olaf Helsets vei 6
>           Fax  : (+47) 2262 8951         N-0621 Oslo, Norway
> 
>  USA    : Tel  : (+1) 713 706 0544       10500 Richmond Avenue, Suite 190
>                                          Houston, Texas 77042, USA
> 
> diff -Nur linux/arch/i386/kernel/mtrr.c.~1~ linux/arch/i386/kernel/mtrr.c
> --- linux/arch/i386/kernel/mtrr.c.~1~	Wed Apr 11 21:02:27 2001
> +++ linux/arch/i386/kernel/mtrr.c	Sun Apr 29 10:18:06 2001
> @@ -480,6 +480,7 @@
>  {
>      unsigned long config, dummy;
>      struct pci_dev *dev = NULL;
> +    u8 rev;
>      
>     /* ServerWorks LE chipsets have problems with  write-combining 
>        Don't allow it and  leave room for other chipsets to be tagged */
> @@ -489,7 +490,9 @@
>          case PCI_VENDOR_ID_SERVERWORKS:
>   	    switch (dev->device) {
>  	    case PCI_DEVICE_ID_SERVERWORKS_LE:
> -		return 0;
> +		pci_read_config_byte(dev, PCI_CLASS_REVISION, &rev);
> +		if (rev <= 5)
> +		    return 0;
>  		break;
>  	    default:
>  		break;
> -

