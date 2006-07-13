Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWGME4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWGME4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 00:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWGME4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 00:56:04 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:55437 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932504AbWGME4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 00:56:02 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] Properly unregister reboot notifier in case of failure in ehci hcd
Date: Wed, 12 Jul 2006 21:55:59 -0700
User-Agent: KMail/1.7.1
Cc: Aleksey Gorelov <dared1st@yahoo.com>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <20060712063841.18958.qmail@web81202.mail.mud.yahoo.com>
In-Reply-To: <20060712063841.18958.qmail@web81202.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607122155.59874.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 July 2006 11:38 pm, Aleksey Gorelov wrote:
> Hi,
> 
>   If some problem occurs during ehci startup, for instance, request_irq fails, echi hcd driver
> tries it best to cleanup, but fails to unregister reboot notifier, which in turn leads to crash on
> reboot/poweroff. Below is the patch against current git to fix this.
>   I did not check if the same problem existed for uhci/ohci host drivers.
> 
> Signed off by: Aleks Gorelov <dared1st@yahoo.com>

Acked-by:  David Brownell <dbrownell@users.sourceforge.net>

> 
> --- linux-2.6/drivers/usb/host/ehci-hcd.c-orig	2006-07-11 17:27:54.000000000 -0700
> +++ linux-2.6/drivers/usb/host/ehci-hcd.c	2006-07-11 17:27:20.000000000 -0700
> @@ -483,9 +483,6 @@
>  	}
>  	ehci->command = temp;
>  
> -	ehci->reboot_notifier.notifier_call = ehci_reboot;
> -	register_reboot_notifier(&ehci->reboot_notifier);
> -
>  	return 0;
>  }
>  
> @@ -499,7 +496,6 @@
>  
>  	/* EHCI spec section 4.1 */
>  	if ((retval = ehci_reset(ehci)) != 0) {
> -		unregister_reboot_notifier(&ehci->reboot_notifier);
>  		ehci_mem_cleanup(ehci);
>  		return retval;
>  	}
> @@ -560,6 +556,9 @@
>  	 */
>  	create_debug_files(ehci);
>  
> +	ehci->reboot_notifier.notifier_call = ehci_reboot;
> +	register_reboot_notifier(&ehci->reboot_notifier);
> +
>  	return 0;
>  }
>  
> 
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> linux-usb-devel@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
> 
