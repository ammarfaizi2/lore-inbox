Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWAXQkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWAXQkb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 11:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWAXQkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 11:40:31 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:52664 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030400AbWAXQka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 11:40:30 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] USB: Disable clock for MPH ports not in use on Freescale EHCI
Date: Tue, 24 Jan 2006 08:11:55 -0800
User-Agent: KMail/1.7.1
Cc: Kumar Gala <galak@gate.crashing.org>, dbrownell@users.sourceforge.net,
       Randy Vinson <rvinson@mvista.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0601231607080.19842-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0601231607080.19842-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601240811.56050.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 2:08 pm, Kumar Gala wrote:
> In some systems using the Freescale EHCI controller if only one port
> of the multiport host (MPH) is being used the other port must be
> disabled if there is no clock signal.  Since we dont know how someone
> will wire a board, we disable the clock if the port is not enabled.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

> ---
> commit 984d42232fd47ddbeef7c825ec2bafbca9aed5a0
> tree 166532f0cd229b1a6f090c43b3617fd49ff3068a
> parent 2497a5e4242d500178d6d0f0ce4ee9249a38f5dc
> author Kumar Gala <galak@kernel.crashing.org> Mon, 23 Jan 2006 16:13:21 -0600
> committer Kumar Gala <galak@kernel.crashing.org> Mon, 23 Jan 2006 16:13:21 -0600
> 
>  drivers/usb/host/ehci-fsl.c |    7 +++++++
>  drivers/usb/host/ehci-fsl.h |    1 +
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index f40ee41..032fa6b 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -161,6 +161,7 @@ static void mpc83xx_setup_phy(struct ehc
>  			      unsigned int port_offset)
>  {
>  	u32 portsc = 0;
> +
>  	switch (phy_mode) {
>  	case FSL_USB2_PHY_ULPI:
>  		portsc |= PORT_PTS_ULPI;
> @@ -175,6 +176,7 @@ static void mpc83xx_setup_phy(struct ehc
>  		portsc |= PORT_PTS_UTMI;
>  		break;
>  	case FSL_USB2_PHY_NONE:
> +		portsc |= PORT_PHCD;
>  		break;
>  	}
>  	writel(portsc, &ehci->regs->port_status[port_offset]);
> @@ -209,8 +211,13 @@ static void mpc83xx_usb_setup(struct usb
>  
>  		if (pdata->port_enables & FSL_USB2_PORT0_ENABLED)
>  			mpc83xx_setup_phy(ehci, pdata->phy_mode, 0);
> +		else
> +			mpc83xx_setup_phy(ehci, FSL_USB2_PHY_NONE, 0);
> +
>  		if (pdata->port_enables & FSL_USB2_PORT1_ENABLED)
>  			mpc83xx_setup_phy(ehci, pdata->phy_mode, 1);
> +		else
> +			mpc83xx_setup_phy(ehci, FSL_USB2_PHY_NONE, 1);
>  	}
>  
>  	/* put controller in host mode. */
> diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
> index caac0d1..f579254 100644
> --- a/drivers/usb/host/ehci-fsl.h
> +++ b/drivers/usb/host/ehci-fsl.h
> @@ -26,6 +26,7 @@
>  #define PORT_PTS_ULPI		(2<<30)
>  #define	PORT_PTS_SERIAL		(3<<30)
>  #define PORT_PTS_PTW		(1<<28)
> +#define PORT_PHCD		(1<<23)
>  #define FSL_SOC_USB_PORTSC2	0x188
>  #define FSL_SOC_USB_USBMODE	0x1a8
>  #define FSL_SOC_USB_SNOOP1	0x400	/* NOTE: big-endian */
> 
> 
> 
