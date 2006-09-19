Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752015AbWISCKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbWISCKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 22:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbWISCKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 22:10:05 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:49531 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752015AbWISCKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 22:10:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=YezEDuIR0YufyPEGOa2YAky2/oHuEicnpnpdEbNo/eNWhZNDZC2mhSF4fPvPL48OE40684CuXzoAUDJoQqeFhjZoR17phLVleGUX0dACMA3Pc+lIObJjrAL5KvMlmS1JA0alphhtgRrtalg9g6j8fZ0VQBvhVX3jUjmpilFwJ64=  ;
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] USB: consolidate error values from EHCI, UHCI and OHCI _suspend()
Date: Mon, 18 Sep 2006 19:09:52 -0700
User-Agent: KMail/1.7.1
Cc: Jiri Kosina <jikos@jikos.cz>, Andrew Morton <akpm@osdl.org>,
       dbrownell@users.sourceforge.net, weissg@vienna.at,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0609190340310.9787@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0609190340310.9787@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609181909.53498.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 September 2006 6:44 pm, Jiri Kosina wrote:
> Hi,
> 
> EHCI, UHCI and OHCI USB host drivers are not consistent when returining 
> error values from their _suspend() functions, in case that the device is 
> not in suspended state. This could confuse users, so let all three of them 
> return -EBUSY.

Shouldn't you also update uhci_suspend()?  Currently it
just ignores hcd->state ...


> Patch against 2.6.18-rc6-mm2.
> 
> Signed-off-by: Jiri Kosina <jikos@jikos.cz>
> 
> --- linux-2.6.18-rc6-mm2.orig/drivers/usb/host/ehci-pci.c	2006-09-14 16:20:48.000000000 +0200
> +++ linux-2.6.18-rc6-mm2/drivers/usb/host/ehci-pci.c	2006-09-19 03:20:22.000000000 +0200
> @@ -232,7 +232,7 @@ static int ehci_pci_suspend(struct usb_h
>  	 */
>  	spin_lock_irqsave (&ehci->lock, flags);
>  	if (hcd->state != HC_STATE_SUSPENDED) {
> -		rc = -EINVAL;
> +		rc = -EBUSY;
>  		goto bail;
>  	}
>  	writel (0, &ehci->regs->intr_enable);
> --- linux-2.6.18-rc6-mm2.orig/drivers/usb/host/ohci-pci.c	2006-09-14 16:20:48.000000000 +0200
> +++ linux-2.6.18-rc6-mm2/drivers/usb/host/ohci-pci.c	2006-09-19 03:36:35.000000000 +0200
> @@ -130,7 +130,7 @@ static int ohci_pci_suspend (struct usb_
>  	 */
>  	spin_lock_irqsave (&ohci->lock, flags);
>  	if (hcd->state != HC_STATE_SUSPENDED) {
> -		rc = -EINVAL;
> +		rc = -EBUSY;
>  		goto bail;
>  	}
>  	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
> 
> -- 
> Jiri Kosina
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> linux-usb-devel@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
> 
