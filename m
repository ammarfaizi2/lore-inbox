Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755495AbWKPXBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495AbWKPXBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 18:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755496AbWKPXBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 18:01:15 -0500
Received: from outmx007.isp.belgacom.be ([195.238.5.234]:16573 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1755495AbWKPXBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 18:01:14 -0500
Message-ID: <455CEDC5.40200@trollprod.org>
Date: Fri, 17 Nov 2006 00:01:25 +0100
From: Olivier Nicolas <olivn@trollprod.org>
User-Agent: Thunderbird 2.0b1pre (X11/20061115)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Jeff Garzik <jeff@garzik.org>, "Lu, Yinghai" <yinghai.lu@amd.com>,
       David Miller <davem@davemloft.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>	<20061114.190036.30187059.davem@davemloft.net>	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>	<20061114.192117.112621278.davem@davemloft.net>	<s5hbqn99f2v.wl%tiwai@suse.de>	<455B5D22.10408@garzik.org>	<s5hslgktu4a.wl%tiwai@suse.de>	<455B6761.3050700@garzik.org> <s5hodr7u0ve.wl%tiwai@suse.de>
In-Reply-To: <s5hodr7u0ve.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Wed, 15 Nov 2006 14:15:45 -0500,
> Jeff Garzik wrote:
>> ACK the pci_intx() calls, NAK the obviously overweight spinlock changes. 
>>   The spinlock changes are completely unnecessary.  Just look at any 
>> other (non-ALSA) PCI driver.  Existing "spin_lock()" is fine for both 
>> PCI shared irq handlers and MSI irq handlers.
>>
>> It sounds like you are trying to work around a reentrancy problem that 
>> does not exist.
>>
>> Only weird drivers like ps2kbd/mouse or IDE need spin_lock_irqsave(), 
>> where separate interrupt sources call the same function.
> 
> OK, I revised it, also referring to a similar patch by Yinghai.
> I think we can simplify the change like below.
> Olivier, could you test this patch, too?

Applied to 2.6.19-rc6, the module tries MSI but this time no IRQ get 
disabled. The result is equivalent to 2.6.19-rc6


ALSA sound/pci/hda/hda_intel.c:543: hda_intel: No response from codec, 
disabling MSI...
hda_codec: Unknown model for AD1988, trying auto-probe from BIOS...


Full details:
http://olivn.trollprod.com/19-rc6/19-rc6-takashi-routeirq1.dmesg
http://olivn.trollprod.com/19-rc6/19-rc6-takashi-routeirq1.irq

Olivier



> 
> (Here the first chunk (enable_msi=1) is just for testing.
>  The patch isn't for merge yet.)
> 
> 
> Takashi
> 
> ---
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index e35cfd3..130ee12 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -55,7 +55,7 @@ static char *model;
>  static int position_fix;
>  static int probe_mask = -1;
>  static int single_cmd;
> -static int enable_msi;
> +static int enable_msi = 1;
>  
>  module_param(index, int, 0444);
>  MODULE_PARM_DESC(index, "Index value for Intel HD audio interface.");
> @@ -1380,7 +1380,8 @@ static int __devinit azx_init_stream(str
>  
>  static int azx_acquire_irq(struct azx *chip, int do_disconnect)
>  {
> -	if (request_irq(chip->pci->irq, azx_interrupt, IRQF_DISABLED|IRQF_SHARED,
> +	if (request_irq(chip->pci->irq, azx_interrupt,
> +			chip->msi ? 0 : IRQF_SHARED,
>  			"HDA Intel", chip)) {
>  		printk(KERN_ERR "hda-intel: unable to grab IRQ %d, "
>  		       "disabling device\n", chip->pci->irq);
> @@ -1389,6 +1390,7 @@ static int azx_acquire_irq(struct azx *c
>  		return -1;
>  	}
>  	chip->irq = chip->pci->irq;
> +	pci_intx(chi->pci, !chip->msi);
>  	return 0;
>  }
>  


-- 
Laudator temporis acti (Horace, 173)
Donner c'est donner, repeindre ses volets
