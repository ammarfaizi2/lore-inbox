Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265518AbTGCXh5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 19:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265527AbTGCXh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 19:37:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63189 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265518AbTGCXhz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 19:37:55 -0400
Message-ID: <3F04C1AA.80107@pobox.com>
Date: Thu, 03 Jul 2003 19:52:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
CC: linux-kernel@vger.kernel.org, mj@ucw.cz, alan@redhat.com
Subject: [PATCH] Re: VIA PCI IRQ router bug fix
References: <5F106036E3D97448B673ED7AA8B2B6B36C352C@scl-exch2k.phoenix.com>
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B36C352C@scl-exch2k.phoenix.com>
Content-Type: multipart/mixed;
 boundary="------------030805090104070508070400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030805090104070508070400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Aleksey Gorelov wrote:
> Hi.
> 
>   I found & fixed a problem with #PIRQD line setup for VIA PCI IRQ
> router. Kernel was not able to receive any interrupts from network card,
> which PCI slot IRQ pin A was routed to PIRQ line D of VIA PCI IRQ
> router. According to VIA specs, PIRQ D routing is out of standard
> 'nibble' scheme.
>   I tested patch with 2.4.20 kernel, it can be applied to 2.4.22-pre2 as
> well.
>   Thanks to my employer (Phoenix Technologies) who kindly allowed me to
> make this patch public.

Thanks much!  Please continue to encourage your employer to contribute 
to open source.  Posting patches like this means that all Linux via 
users have a more stable system to use.


> --- linux-2.4.20/arch/i386/kernel/pci-irq_old.c	2002-11-28 15:53:09.000000000 -0800
> +++ linux-2.4.20/arch/i386/kernel/pci-irq.c	2003-05-21 17:27:40.000000000 -0700
> @@ -198,12 +198,27 @@
>   */
>  static int pirq_via_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
>  {
> -	return read_config_nybble(router, 0x55, pirq);
> +    u8 x;
> +
> +    if ( pirq == 4 ) {
> +        pci_read_config_byte(router, 0x57, &x);
> +        return (x >> 4);
> +    } else {
> +        return read_config_nybble(router, 0x55, pirq);
> +    }
>  }

If you don't mind, I would prefer the attached patch, which is a little 
bit less verbose.

I will make sure this fix is merged into 2.4 and 2.5, if noone beats me 
to it.

	Jeff



--------------030805090104070508070400
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== arch/i386/pci/irq.c 1.25 vs edited =====
--- 1.25/arch/i386/pci/irq.c	Thu Jun 19 17:58:11 2003
+++ edited/arch/i386/pci/irq.c	Thu Jul  3 19:49:14 2003
@@ -196,15 +196,16 @@
 /*
  * The VIA pirq rules are nibble-based, like ALI,
  * but without the ugly irq number munging.
+ * However, PIRQD is in the upper instead of lower 4 bits.
  */
 static int pirq_via_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
-	return read_config_nybble(router, 0x55, pirq);
+	return read_config_nybble(router, 0x55, pirq == 4 ? 5 : pirq);
 }
 
 static int pirq_via_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
-	write_config_nybble(router, 0x55, pirq, irq);
+	write_config_nybble(router, 0x55, pirq == 4 ? 5 : pirq, irq);
 	return 1;
 }
 

--------------030805090104070508070400--

