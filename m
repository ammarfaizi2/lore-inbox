Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVCEQWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVCEQWR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVCEQNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:13:51 -0500
Received: from mx2.mail.ru ([194.67.23.122]:36131 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S262111AbVCEQGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 11:06:11 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: "Panagiotis Issaris" <panagiotis.issaris@mech.kuleuven.ac.be>
Subject: Re: [PATCH] EFI missing failure handling
Date: Sat, 5 Mar 2005 19:06:29 +0200
User-Agent: KMail/1.6.2
Cc: Matt_Domsch@dell.com, linux-kernel@vger.kernel.org
References: <20050305153841.GA7808@mech.kuleuven.ac.be>
In-Reply-To: <20050305153841.GA7808@mech.kuleuven.ac.be>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503051906.31518.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 March 2005 17:38, Panagiotis Issaris wrote:

> The EFI driver allocates memory and writes into it without checking the
> success of the allocation:
> 
> 668     efi_char16_t *variable_name = kmalloc(1024, GFP_KERNEL);
> ...
> 696     memset(variable_name, 0, 1024);

> --- linux-2.6.11-orig/drivers/firmware/efivars.c
> +++ linux-2.6.11-pi/drivers/firmware/efivars.c
> @@ -670,6 +670,9 @@ efivars_init(void)

> +	if (!variable_name)
> +		return -ENOMEM;
> +
>  	if (!efi_enabled)
>  		return -ENODEV; 

I'd better move kmalloc() and checking for success down right before
memset(). Otherwise you leak if efi_enabled == 0.

Oh, and efivars_init() wants to return "error", not unconditionally 0.

	Alexey
