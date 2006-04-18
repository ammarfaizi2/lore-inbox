Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWDRREm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWDRREm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 13:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWDRREm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 13:04:42 -0400
Received: from smtp-relay.dca.net ([216.158.48.66]:63420 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S1751125AbWDRREl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 13:04:41 -0400
Date: Tue, 18 Apr 2006 13:03:31 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] [PATCH] i2c-i801: Fix resume when PEC is used
Message-ID: <20060418170331.GA3915@jupiter.solarsys.private>
References: <20060418140629.7cb21736.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418140629.7cb21736.khali@linux-fr.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2006-04-18 14:06:29 +0200]:
> Fix for bug #6395:
> Fail to resume on Tecra M2 with ADM1032 and Intel 82801DBM
> 
> The BIOS of the Tecra M2 doesn't like it when it has to reboot or
> resume after the i2c-i801 driver has left the SMBus in PEC mode. So we
> need to add proper .suspend, .resume and .shutdown callbacks to that
> driver, where we clear and restore the PEC mode bit appropriately.

NACK: saved_auxctl is uninitialized in this patch (what happened to
the patch I looked at last night?)

Also, now that I look at it again... wouldn't it be much easier to just
disable PEC again after every transfer?  That's safer too:  the call-
backs might not be enough e.g. if the user hits the reset button after
a PEC transfer.

> Thanks to Daniele Gaffuri for the very good report and contribution.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/i2c/busses/i2c-i801.c |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> --- linux-2.6.17-rc1.orig/drivers/i2c/busses/i2c-i801.c	2006-04-18 09:34:15.000000000 +0200
> +++ linux-2.6.17-rc1/drivers/i2c/busses/i2c-i801.c	2006-04-18 12:47:07.000000000 +0200
> @@ -110,6 +110,7 @@
>  static struct pci_driver i801_driver;
>  static struct pci_dev *I801_dev;
>  static int isich4;
> +static u8 saved_auxctl;
>  
>  static int i801_setup(struct pci_dev *dev)
>  {
> @@ -551,17 +552,46 @@
>  	return i2c_add_adapter(&i801_adapter);
>  }
>  
> +static void i801_shutdown(struct pci_dev *dev)
> +{
> +	if (isich4) {
> +		/* Disable PEC mode before leaving, else some BIOSes will
> +		   fail to resume/reboot. */
> +		outb_p(0, SMBAUXCTL);
> +	}
> +}
> +
>  static void __devexit i801_remove(struct pci_dev *dev)
>  {
>  	i2c_del_adapter(&i801_adapter);
> +	i801_shutdown(dev);
>  	release_region(i801_smba, (isich4 ? 16 : 8));
>  }
>  
> +static int i801_suspend(struct pci_dev *dev, pm_message_t state)
> +{
> +	i801_shutdown(dev);
> +	return pci_save_state(dev);
> +}
> +
> +static int i801_resume(struct pci_dev *dev)
> +{
> +	pci_restore_state(dev);
> +	if (isich4) {
> +		/* Restore PEC mode */
> +		outb_p(saved_auxctl, SMBAUXCTL);
> +	}
> +	return 0;
> +}
> +
>  static struct pci_driver i801_driver = {
>  	.name		= "i801_smbus",
>  	.id_table	= i801_ids,
>  	.probe		= i801_probe,
>  	.remove		= __devexit_p(i801_remove),
> +	.suspend	= i801_suspend,
> +	.resume		= i801_resume,
> +	.shutdown	= i801_shutdown,
>  };
>  
>  static int __init i2c_i801_init(void)
> 

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

