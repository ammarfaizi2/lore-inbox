Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVCXGUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVCXGUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 01:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVCXGUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 01:20:54 -0500
Received: from smtp818.mail.sc5.yahoo.com ([66.163.170.4]:20046 "HELO
	smtp818.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262413AbVCXGUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 01:20:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] drivers/input/serio/libps2.c: ps2_command: add a missing check
Date: Thu, 24 Mar 2005 00:13:16 -0500
User-Agent: KMail/1.7.2
Cc: Adrian Bunk <bunk@stusta.de>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
References: <20050324031447.GY1948@stusta.de>
In-Reply-To: <20050324031447.GY1948@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503240013.16573.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 March 2005 22:14, Adrian Bunk wrote:
> The Coverity checker noted that while all other uses of param in 
> ps2_command() were guarded by a NULL check, this one wasn't.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc1-mm1-full/drivers/input/serio/libps2.c.old	2005-03-24 02:37:08.000000000 +0100
> +++ linux-2.6.12-rc1-mm1-full/drivers/input/serio/libps2.c	2005-03-24 02:38:28.000000000 +0100
> @@ -106,9 +106,10 @@ int ps2_command(struct ps2dev *ps2dev, u
>  			command == PS2_CMD_RESET_BAT ? 1000 : 200))
>  			goto out;
>  
> -	for (i = 0; i < send; i++)
> -		if (ps2_sendbyte(ps2dev, param[i], 200))
> -			goto out;
> +	if (param)
> +		for (i = 0; i < send; i++)
> +			if (ps2_sendbyte(ps2dev, param[i], 200))
> +				goto out;
>  

I somewhat disagree on this one. If caller specified that command requires
arguments to be sent and it does not provide them I'd rather had it OOPS on
the spot. With receiving, however, caller does not really have control over
number of characters coming from the device so specifying NULL allows just
ignore whatever response there is.

-- 
Dmitry
