Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUDQDLJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 23:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263613AbUDQDLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 23:11:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16844 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261672AbUDQDLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 23:11:05 -0400
Date: Fri, 16 Apr 2004 23:08:56 -0400
From: Bill Nottingham <notting@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] oops when loading ehci_hcd
Message-ID: <20040417030856.GA3805@nostromo.devel.redhat.com>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20040416082311.GA2756@nostromo.devel.redhat.com> <4080229B.4020307@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4080229B.4020307@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell (david-b@pacbell.net) said: 
> Looks like a cleanup path needs to handle early failure a bit better;
> likely just having ehci_stop test for ehci->async non-null (before
> calling scan-async to clean up any pending work) would suffice.

This patch solves the oops for me - thanks!

Bill

> --- 1.75/drivers/usb/host/ehci-hcd.c	Wed Apr 14 20:20:58 2004
> +++ edited/drivers/usb/host/ehci-hcd.c	Fri Apr 16 11:03:50 2004
> @@ -592,7 +592,8 @@
>  
>  	/* root hub is shut down separately (first, when possible) */
>  	spin_lock_irq (&ehci->lock);
> -	ehci_work (ehci, NULL);
> +	if (ehci->async)
> +		ehci_work (ehci, NULL);
>  	spin_unlock_irq (&ehci->lock);
>  	ehci_mem_cleanup (ehci);
>  

