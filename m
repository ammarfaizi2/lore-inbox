Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVKPGrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVKPGrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 01:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbVKPGqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 01:46:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:37770 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751214AbVKPGqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 01:46:52 -0500
Date: Tue, 15 Nov 2005 22:31:26 -0800
From: Greg KH <gregkh@suse.de>
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/6] PCI PM: pci_save/restore_state improvements
Message-ID: <20051116063125.GE31375@suse.de>
References: <1132111902.9809.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132111902.9809.59.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 10:31:42PM -0500, Adam Belay wrote:
> This patch makes some improvements to pci_save_state and
> pci_restore_state.  Instead of saving and restoring all standard
> registers (even read-only ones), it only restores necessary registers.
> Also, the command register is handled more carefully.  Let me know if
> I'm missing anything important.
> 
> 
> --- a/drivers/pci/pm.c	2005-11-13 20:32:24.000000000 -0500
> +++ b/drivers/pci/pm.c	2005-11-13 20:29:32.000000000 -0500
> @@ -53,10 +53,13 @@
>   */
>  int pci_save_state(struct pci_dev *dev)
>  {
> -	int i;
> -	/* XXX: 100% dword access ok here? */
> -	for (i = 0; i < 16; i++)
> -		pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
> +	struct pci_dev_config * conf = &dev->saved_config;
> +
> +	pci_read_config_word(dev, PCI_COMMAND, &conf->command);
> +	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &conf->cacheline_size);
> +	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &conf->latency_timer);
> +	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &conf->interrupt_line);

Why are we saving and restoring smaller ammounts of config space now?

thanks,

greg k-h
