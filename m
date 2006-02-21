Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWBUXDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWBUXDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWBUXDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:03:49 -0500
Received: from cantor.suse.de ([195.135.220.2]:31677 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932152AbWBUXDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:03:48 -0500
Date: Wed, 22 Feb 2006 00:03:46 +0100
From: Karsten Keil <kkeil@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Karsten Keil <kkeil@suse.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de
Subject: Re: [PATCH] ISDN: fix copy_to_user() unused result warning in isdn_ppp
Message-ID: <20060221230346.GA17973@pingi.kke.suse.de>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Karsten Keil <kkeil@suse.de>,
	Kai Germaschewski <kai.germaschewski@gmx.de>,
	isdn4linux@listserv.isdn4linux.de
References: <200602212314.15362.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602212314.15362.jesper.juhl@gmail.com>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15.7-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 11:14:15PM +0100, Jesper Juhl wrote:
> From: Jesper Juhl <jesper.juhl@gmail.com>
> 
> 
> Fix compile warning about copy_to_user() unused result in isdn_ppp.c
>    drivers/isdn/i4l/isdn_ppp.c:785: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> 
> ---
> 
>  drivers/isdn/i4l/isdn_ppp.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.16-rc4-mm1-orig/drivers/isdn/i4l/isdn_ppp.c	2006-01-03 04:21:10.000000000 +0100
> +++ linux-2.6.16-rc4-mm1/drivers/isdn/i4l/isdn_ppp.c	2006-02-21 23:07:57.000000000 +0100
> @@ -782,7 +782,10 @@ isdn_ppp_read(int min, struct file *file
>  	is->first = b;
>  
>  	spin_unlock_irqrestore(&is->buflock, flags);
> -	copy_to_user(buf, save_buf, count);
> +	if (copy_to_user(buf, save_buf, count)) {
> +		kfree(save_buf);
> +		return -EFAULT;
> +	}
>  	kfree(save_buf);
>  
>  	return count;

What about:

--- linux-2.6.16-rc4-mm1-orig/drivers/isdn/i4l/isdn_ppp.c     2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc4-mm1/drivers/isdn/i4l/isdn_ppp.c  2006-02-21 23:07:57.000000000 +0100
@@ -782,7 +782,8 @@ isdn_ppp_read(int min, struct file *file
 	is->first = b;
 
 	spin_unlock_irqrestore(&is->buflock, flags);
-	copy_to_user(buf, save_buf, count);
+	if (copy_to_user(buf, save_buf, count))
+		count = -EFAULT;
 	kfree(save_buf);
 
 	return count;

should result in a conditional move instead of jumps.

But I'm OK with the original patch as well, for both version you can add

Signed-off-by: Karsten Keil <kkeil@suse.de>

-- 
Karsten Keil
SuSE Labs
ISDN development
