Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUCBDBX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 22:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbUCBDBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 22:01:23 -0500
Received: from main.gmane.org ([80.91.224.249]:57550 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261264AbUCBDBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 22:01:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Mike <Mike@kordik.net>
Subject: Re: [PATCH] Re: 2.6.3-bk9 QA testing: firewire good, USB printing dead
Date: Mon, 01 Mar 2004 22:01:18 -0500
Message-ID: <pan.2004.03.02.03.01.15.267828@kordik.net>
References: <1077933682.14653.23.camel@wave.gentoo.org> <20040228021040.GA14836@kroah.com> <20040229095139.GH3149@suse.de> <20040301074348.GA7646@ip68-4-255-84.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: user-0c936ii.cable.mindspring.com
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004 23:43:48 -0800, Barry K. Nathan wrote:

> Does this patch (following my signature) fix the printer hangs? (It does
> for me.)
> 
> BTW, it's also an attachment on OSDL bugzilla #2221:
> http://bugme.osdl.org/show_bug.cgi?id=2221
> 
> -Barry K. Nathan <barryn@pobox.com>
> 
> diff -ruN linux-2.6.3-bk2/drivers/usb/class/usblp.c
> linux-2.6.3-bk2-bkn1/drivers/usb/class/usblp.c ---
> linux-2.6.3-bk2/drivers/usb/class/usblp.c	2004-02-29 23:18:26.000000000
> -0800 +++ linux-2.6.3-bk2-bkn1/drivers/usb/class/usblp.c	2004-02-29
> 23:17:24.000000000 -0800 @@ -603,7 +603,7 @@
>  {
>  	DECLARE_WAITQUEUE(wait, current);
>  	struct usblp *usblp = file->private_data;
> -	int timeout, err = 0, transfer_length; +	int timeout, err = 0,
> transfer_length = 0;
>  	size_t writecount = 0;
>  
>  	while (writecount < count) {
> @@ -654,6 +654,16 @@
>  			continue;
>  		}
>  
> +		/* We must increment writecount here, and not at the +		 * end of the
> loop. Otherwise, the final loop iteration may +		 * be skipped, leading
> to incomplete printer output. +		 */
> +		writecount += transfer_length;
> +		if (writecount == count) {
> +			up (&usblp->sem);
> +			break;
> +		}
> +
>  		transfer_length=(count - writecount); if (transfer_length >
>  		USBLP_BUF_SIZE)
>  			transfer_length = USBLP_BUF_SIZE;
> @@ -677,8 +687,6 @@
>  			break;
>  		}
>  		up (&usblp->sem);
> -
> -		writecount += transfer_length;
>  	}
>  
>  	return count;
I also applied this patch to 2.6.4-rc1-mm1 and my printer problem seems to
be solved. This is the first time in two weeks that printing has worked
properly for me. Thx :)

