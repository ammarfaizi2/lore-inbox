Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbTEKRMS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 13:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTEKRMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 13:12:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4825 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261789AbTEKRMQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 13:12:16 -0400
Message-ID: <3EBE8768.4000007@pobox.com>
Date: Sun, 11 May 2003 13:24:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Daniel Ritz <daniel.ritz@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@diego.com>
Subject: Re: [bug 2.5.69] xirc2ps_cs, irq 3: nobody cared, shutdown hangs
References: <200305111647.32113.daniel.ritz@gmx.ch> <Pine.LNX.4.50.0305111202510.15337-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0305111202510.15337-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> @@ -1312,7 +1312,7 @@ xirc2ps_interrupt(int irq, void *dev_id,
>  				  */
>  
>      if (!netif_device_present(dev))
> -	return IRQ_NONE;
> +	goto out;
>  
>      ioaddr = dev->base_addr;
>      if (lp->mohawk) { /* must disable the interrupt */
> @@ -1515,6 +1515,7 @@ xirc2ps_interrupt(int irq, void *dev_id,
>       * force an interrupt with this command:
>       *	  PutByte(XIRCREG_CR, EnableIntr|ForceIntr);
>       */
> +  out:
>      return IRQ_RETVAL(handled);
>  } /* xirc2ps_interrupt */


If this patch works, it's mainly a signal to dig deeper.

If netif_device_present() returns false, we think the hardware has 
disappeared.  So that implies a bug in calling netif_device_detach() no 
a bug in the irq handler return value.

This is _especially_ true for pcmcia, even more than pci.  PCI ejects 
(including cardbus) are electrically safe, whereas pcmcia is different. 
  If pcmcia hardware disappears on you, you _really_ don't want to be 
bitbanging its ports.

	Jeff



