Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbUDVD2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUDVD2G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 23:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbUDVD2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 23:28:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59882 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262874AbUDVD2C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 23:28:02 -0400
Message-ID: <40873BB5.2000506@pobox.com>
Date: Wed, 21 Apr 2004 23:27:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: Re: b44 needs to reclaim its interrupt after swsusp
References: <20040421000208.GA3160@elf.ucw.cz>
In-Reply-To: <20040421000208.GA3160@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> b44 needs to free/reclaim its interrupt across suspend in order to
> work. This patch makes it work, but I'm not quite sure why its
> needed. Interrupt is listed as IO-APIC-level in /proc/interupts.
> 
> 							Pavel
> 
> --- clean/drivers/net/b44.c	2004-04-21 01:32:52.000000000 +0200
> +++ linux/drivers/net/b44.c	2004-04-21 01:53:18.000000000 +0200
> @@ -1251,7 +1251,7 @@
>  }
>  
>  #if 0
> -/*static*/ void b44_dump_state(struct b44 *bp)
> +void b44_dump_state(struct b44 *bp)
>  {
>  	u32 val32, val32_2, val32_3, val32_4, val32_5;
>  	u16 val16;
> @@ -1874,6 +1874,8 @@
>  	b44_free_rings(bp);
>  
>  	spin_unlock_irq(&bp->lock);
> +
> +	free_irq(dev->irq, dev);
>  	return 0;
>  }
>  
> @@ -1887,6 +1889,9 @@
>  
>  	pci_restore_state(pdev, bp->pci_cfg_state);
>  
> +	if (request_irq(dev->irq, b44_interrupt, SA_SHIRQ, dev->name, dev))
> +		printk("b44: request_irq failed\n");
> +

look ok, with minor nit:  use KERN_xxx prefix in printk


