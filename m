Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWAEAhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWAEAhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWAEAhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:37:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5088 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750757AbWAEAhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:37:37 -0500
Date: Wed, 4 Jan 2006 16:39:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: takis@issaris.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cs53l32a: kzalloc conversion
Message-Id: <20060104163929.58a083d8.akpm@osdl.org>
In-Reply-To: <20060103143301.0D98E5BC3@localhost.localdomain>
References: <20060103143301.0D98E5BC3@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

takis@issaris.org (Panagiotis Issaris) wrote:
>
> From: Panagiotis Issaris <takis@issaris.org>
> 
> Conversion of kmalloc+memset to kzalloc.
> 
> Signed-off-by: Panagiotis Issaris <takis@issaris.org>
> 
> ---
> 
>  drivers/media/video/cs53l32a.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> d27ad6f2f4c46ed0b29034c413cc8f948506fdc6
> diff --git a/drivers/media/video/cs53l32a.c b/drivers/media/video/cs53l32a.c
> index 780b352..f9e3b8b 100644
> --- a/drivers/media/video/cs53l32a.c
> +++ b/drivers/media/video/cs53l32a.c
> @@ -146,11 +146,10 @@ static int cs53l32a_attach(struct i2c_ad
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return 0;
>  
> -	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
> +	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
>  	if (client == 0)
>  		return -ENOMEM;
>  
> -	memset(client, 0, sizeof(struct i2c_client));
>  	client->addr = address;
>  	client->adapter = adapter;
>  	client->driver = &i2c_driver;

A quick grep shows that there are ~60 kmalloc+memsets under
drivers/media/video.  So I'd prefer that if we're going to do this, we do
it all in one big hit rather than merging a dribble of little patches.

If someone does this, please also remove the typecasts of the
kmalloc/kzalloc return value, such as

drivers/media/video/mxb.c:      mxb = (struct mxb*)kmalloc(sizeof(struct mxb), GFP_KERNEL);


