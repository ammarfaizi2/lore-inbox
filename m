Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030901AbWKOTPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030901AbWKOTPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030913AbWKOTPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:15:51 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:23954 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030901AbWKOTPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:15:49 -0500
Message-ID: <455B6761.3050700@garzik.org>
Date: Wed, 15 Nov 2006 14:15:45 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: David Miller <davem@davemloft.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>	<20061114.190036.30187059.davem@davemloft.net>	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>	<20061114.192117.112621278.davem@davemloft.net>	<s5hbqn99f2v.wl%tiwai@suse.de>	<455B5D22.10408@garzik.org> <s5hslgktu4a.wl%tiwai@suse.de>
In-Reply-To: <s5hslgktu4a.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index e35cfd3..bdb92b3 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -544,6 +544,7 @@ static unsigned int azx_rirb_get_respons
>  		free_irq(chip->irq, chip);
>  		chip->irq = -1;
>  		pci_disable_msi(chip->pci);
> +		pci_intx(chip->pci, 1);
>  		chip->msi = 0;
>  		if (azx_acquire_irq(chip, 1) < 0)
>  			return -1;
> @@ -830,14 +831,15 @@ static irqreturn_t azx_interrupt(int irq
>  {
>  	struct azx *chip = dev_id;
>  	struct azx_dev *azx_dev;
> +	unsigned long flags;
>  	u32 status;
>  	int i;
>  
> -	spin_lock(&chip->reg_lock);
> +	spin_lock_irqsave(&chip->reg_lock, flags);
>  
>  	status = azx_readl(chip, INTSTS);
>  	if (status == 0) {
> -		spin_unlock(&chip->reg_lock);
> +		spin_unlock_irqrestore(&chip->reg_lock, flags);
>  		return IRQ_NONE;
>  	}
>  	
> @@ -867,7 +869,7 @@ static irqreturn_t azx_interrupt(int irq
>  	if (azx_readb(chip, STATESTS) & 0x04)
>  		azx_writeb(chip, STATESTS, 0x04);
>  #endif
> -	spin_unlock(&chip->reg_lock);
> +	spin_unlock_irqrestore(&chip->reg_lock, flags);

ACK the pci_intx() calls, NAK the obviously overweight spinlock changes. 
  The spinlock changes are completely unnecessary.  Just look at any 
other (non-ALSA) PCI driver.  Existing "spin_lock()" is fine for both 
PCI shared irq handlers and MSI irq handlers.

It sounds like you are trying to work around a reentrancy problem that 
does not exist.

Only weird drivers like ps2kbd/mouse or IDE need spin_lock_irqsave(), 
where separate interrupt sources call the same function.

	Jeff



