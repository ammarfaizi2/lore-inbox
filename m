Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWBMWxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWBMWxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWBMWxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:53:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030227AbWBMWxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:53:34 -0500
Date: Mon, 13 Feb 2006 14:52:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: jmoyer@redhat.com
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [patch] fix BUG: in fw_realloc_buffer
Message-Id: <20060213145231.0e8863e8.akpm@osdl.org>
In-Reply-To: <17393.2242.720631.636489@segfault.boston.redhat.com>
References: <17393.2242.720631.636489@segfault.boston.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Hi,
> 
> The fw_realloc_buffer routine does not handle an increase in buffer size of
> more than 4k.  It's not clear to me why it expects that it will only get an
> extra 4k of data.  The attached patch modifies fw_realloc_buffer to vmalloc
> as much memory as is requested, instead of what we previously had + 4k.
> 
> I've tested this on my laptop, which would crash occaisionally on boot
> without the patch.  With the patch, it hasn't crashed, but I can't be
> certain that this code path is exercised.
> 
> Comments are very welcome.
> 
> Thanks,
> 
> Jeff
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 
> --- vanilla/drivers/base/firmware_class.c.orig	2006-02-13 15:46:15.000000000 -0500
> +++ vanilla/drivers/base/firmware_class.c	2006-02-13 15:46:04.000000000 -0500
> @@ -211,18 +211,22 @@ static int
>  fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
>  {
>  	u8 *new_data;
> +	int new_size = fw_priv->alloc_size;
>  
>  	if (min_size <= fw_priv->alloc_size)
>  		return 0;
>  
> -	new_data = vmalloc(fw_priv->alloc_size + PAGE_SIZE);
> +	while (new_size < min_size)
> +		new_size += PAGE_SIZE;
> +
> +	new_data = vmalloc(new_size);
>  	if (!new_data) {
>  		printk(KERN_ERR "%s: unable to alloc buffer\n", __FUNCTION__);
>  		/* Make sure that we don't keep incomplete data */
>  		fw_load_abort(fw_priv);
>  		return -ENOMEM;
>  	}
> -	fw_priv->alloc_size += PAGE_SIZE;
> +	fw_priv->alloc_size = new_size;
>  	if (fw_priv->fw->data) {
>  		memcpy(new_data, fw_priv->fw->data, fw_priv->fw->size);
>  		vfree(fw_priv->fw->data);

A little bit neater this way, I think?

--- devel/drivers/base/firmware_class.c~firmware-fix-bug-in-fw_realloc_buffer	2006-02-13 14:45:52.000000000 -0800
+++ devel-akpm/drivers/base/firmware_class.c	2006-02-13 14:52:05.000000000 -0800
@@ -211,18 +211,20 @@ static int
 fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
 {
 	u8 *new_data;
+	int new_size = fw_priv->alloc_size;
 
 	if (min_size <= fw_priv->alloc_size)
 		return 0;
 
-	new_data = vmalloc(fw_priv->alloc_size + PAGE_SIZE);
+	new_size = ALIGN(min_size, PAGE_SIZE);
+	new_data = vmalloc(new_size);
 	if (!new_data) {
 		printk(KERN_ERR "%s: unable to alloc buffer\n", __FUNCTION__);
 		/* Make sure that we don't keep incomplete data */
 		fw_load_abort(fw_priv);
 		return -ENOMEM;
 	}
-	fw_priv->alloc_size += PAGE_SIZE;
+	fw_priv->alloc_size = new_size;
 	if (fw_priv->fw->data) {
 		memcpy(new_data, fw_priv->fw->data, fw_priv->fw->size);
 		vfree(fw_priv->fw->data);
_

