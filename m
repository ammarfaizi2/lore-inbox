Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWCKQJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWCKQJO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 11:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWCKQJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 11:09:13 -0500
Received: from penta.pentaserver.com ([66.45.247.194]:14220 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1751203AbWCKQJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 11:09:13 -0500
Message-ID: <4412F27E.5090705@gmail.com>
Date: Sat, 11 Mar 2006 19:53:34 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/media/dvb/bt8xx/dst_ca.c: fix 2 memory leaks
References: <20060311151142.GP21864@stusta.de>
In-Reply-To: <20060311151142.GP21864@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The Coverity checker spotted that thre was a memory leak if the second 
> or third kmalloc() failed.
>
> Besides this, I've also consolidated the three error handlings into one.
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
>  drivers/media/dvb/bt8xx/dst_ca.c |   19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> --- linux-2.6.16-rc5-mm3-full/drivers/media/dvb/bt8xx/dst_ca.c.old	2006-03-11 14:36:59.000000000 +0100
> +++ linux-2.6.16-rc5-mm3-full/drivers/media/dvb/bt8xx/dst_ca.c	2006-03-11 15:28:26.000000000 +0100
> @@ -473,18 +473,17 @@ static int dst_ca_ioctl(struct inode *in
>  	void __user *arg = (void __user *)ioctl_arg;
>  	int result = 0;
>  
> -	if ((p_ca_message = (struct ca_msg *) kmalloc(sizeof (struct ca_msg), GFP_KERNEL)) == NULL) {
> -		dprintk(verbose, DST_CA_ERROR, 1, " Memory allocation failure");
> -		return -ENOMEM;
> -	}
> -	if ((p_ca_slot_info = (struct ca_slot_info *) kmalloc(sizeof (struct ca_slot_info), GFP_KERNEL)) == NULL) {
> -		dprintk(verbose, DST_CA_ERROR, 1, " Memory allocation failure");
> -		return -ENOMEM;
> -	}
> -	if ((p_ca_caps = (struct ca_caps *) kmalloc(sizeof (struct ca_caps), GFP_KERNEL)) == NULL) {
> +	p_ca_message = (struct ca_msg *) kmalloc(sizeof (struct ca_msg), GFP_KERNEL);
> +	p_ca_slot_info = (struct ca_slot_info *) kmalloc(sizeof (struct ca_slot_info), GFP_KERNEL);
> +	p_ca_caps = (struct ca_caps *) kmalloc(sizeof (struct ca_caps), GFP_KERNEL);
> +
> +
> +	if (!p_ca_message || !p_ca_slot_info || !p_ca_caps) {
>  		dprintk(verbose, DST_CA_ERROR, 1, " Memory allocation failure");
> -		return -ENOMEM;
> +		result = -ENOMEM;
> +		goto free_mem_and_exit;
>  	}
> +
>  	/*	We have now only the standard ioctl's, the driver is upposed to handle internals.	*/
>  	switch (cmd) {
>  	case CA_SEND_MSG:
>
> -
>   


Yeah, it is better indeed. Would you mind if i schedule this for a 
little while later, since i have a couple of other fixes/additions as well ?


Thanks,
Manu

