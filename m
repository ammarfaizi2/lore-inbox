Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUISXtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUISXtc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 19:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUISXtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 19:49:32 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:12751 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264980AbUISXt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 19:49:27 -0400
Message-ID: <414E1B99.4070501@stanford.edu>
Date: Sun, 19 Sep 2004 16:51:53 -0700
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Andy Lutomirski <luto@myrealbox.com>, Hans-Frieder Vogt <hfvogt@arcor.de>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot
 (FIX included)
References: <200409130035.50823.hfvogt@arcor.de> <20040916070211.GA32592@electric-eye.fr.zoreil.com> <200409161320.16526.jdmason@us.ltcfwd.linux.ibm.com> <200409171043.21772.jdmason@us.ltcfwd.linux.ibm.com> <20040917160151.GA29337@electric-eye.fr.zoreil.com> <414DF773.7060402@myrealbox.com> <20040919213952.GA32570@electric-eye.fr.zoreil.com>
In-Reply-To: <20040919213952.GA32570@electric-eye.fr.zoreil.com>
Content-Type: multipart/mixed;
 boundary="------------020901030109090801060303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020901030109090801060303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Francois Romieu wrote:
> Andy Lutomirski <luto@myrealbox.com> :
> [...]
> 
>>FWIW, it looks like init_board is setting PCIDAC in tp->cp_cmd but that 
>>isn't updated to the card until after the rx ring is filled in 
>>r8169_open.  This seems suspicious, since DMA memory is being allocated 
>>possibly in >32-bit addresses but the card hasn't been told to support 
>>that.  Fixing this doesn't seem to help, though...
> 
> 
> rtl8169_hw_start() writes the CPlusCmd register before the ring descriptor
> adresses are set. Can you elaborate why it would not be enough ?

Because rtl8169_init_ring() is called before rtl8169_hw_start() in 
rtl8169_open().  init_ring allocates the recieve buffers, and I'm 
assuming that r8169_alloc_rx_skb() can get >32 bits.

> 
> Btw the r8169 driver in 2.6.9-rcX does not advertise NETIF_F_HIGHDMA: where
> would a >32 bit address come from ?

I was looking at 2.6.9-rc2-mm1, which has (pardon hideous line wrapping):

	if ((sizeof(dma_addr_t) > 4) && !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
		tp->cp_cmd |= PCIDAC;
		dev->features |= NETIF_F_HIGHDMA;
                                  ^^^^^^^^^^^^^^^
	} else {
		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
		if (rc < 0) {
			printk(KERN_ERR PFX "DMA configuration failed.\n");
			goto err_out_free_res;
		}
	}

But I have 512MB RAM, so this probably isn't a problem for me.  I'm 
running x86_64, BTW.

> 
> 
>>Turning off high DMA fixes it.  Maybe it just needs to be disabled until 
>>someone figures out what's going on.
> 
> 
> I am cooking a patch for it (+ check for PCI error).
> 
> As a side note, the r8169 chipset does not like DAC to be enabled on a
> 32bit system. I got the usual PCI error reported while trying it.

Will this be ready for 2.6.9?  Otherwise it would probably be better to 
just disable DAC so the driver keeps working.

On an unrelated note, I just took a look at the PHY timer code.  It 
looks like the PHY timer will never reactivate once it shuts off, which 
means that the resetting is completely deterministic and the printk 
conveys no useful information.  Can we just delete it (patch attached -- 
this computer mangles them)?

What does it do, anyway?  If it is necessary for someone's card (not 
mine) to acquire a gigabit link (which is what it seemed to do in old 
versions of the driver), then we're _still_ broken for the case where 
they drop the link and try to reacquire it.  Would it make sense to 
remove the reset_enable stuff in -mm for awhile and see if anyone complains?


--Andy

--------------020901030109090801060303
Content-Type: text/plain;
 name="r8169-quiet.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="r8169-quiet.txt"

Index: 2.6.9-rc2-mm1/drivers/net/r8169.c
===================================================================
--- 2.6.9-rc2-mm1.orig/drivers/net/r8169.c	2004-09-19 16:43:09.725537944 -0700
+++ 2.6.9-rc2-mm1/drivers/net/r8169.c	2004-09-19 16:50:33.900013160 -0700
@@ -1044,8 +1044,6 @@
 	if (tp->link_ok(ioaddr))
 		goto out_unlock;
 
-	printk(KERN_WARNING PFX "%s: PHY reset until link up\n", dev->name);
-
 	tp->phy_reset_enable(ioaddr);
 
 out_mod_timer:

--------------020901030109090801060303--
