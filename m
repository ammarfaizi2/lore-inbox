Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWGIXx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWGIXx1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161226AbWGIXx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:53:27 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:32775 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161225AbWGIXx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:53:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=tK2DcrDeEcg9U9eap3wyCg9md2b8k3xjT213fMhMKkcAnv1ZNhSazrR+kwkkIAcf5MaGgmpgv1Joec/lvlkstQ3Qmzd3x/hw+t4YD37upqsvb8lfKSZBOuwlti5DsurnMrABLt5oVedsoZwuqKWROQpj6GBkCxKOkXk+oOGojqk=
Message-ID: <44B196ED.1070804@pol.net>
Date: Mon, 10 Jul 2006 07:53:17 +0800
From: "Antonino A. Daplas" <adaplas@pol.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>	<20060705165255.ab7f1b83.khali@linux-fr.org> <m3bqryv7jx.fsf_-_@defiant.localdomain>
In-Reply-To: <m3bqryv7jx.fsf_-_@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Hi,
> 
> I've attached the second version of the Cirrus Logic I2C patch.
> Supersedes:
> cirrus-logic-framebuffer-i2c-support.patch
> cirrus-logic-framebuffer-i2c-support-fix.patch
> 
> Created against current Linus' tree.
> Thanks.
> 
> Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>
> 


> @@ -2335,6 +2376,36 @@ static int cirrusfb_register(struct cirr
>  		goto err_dealloc_cmap;
>  	}
>  
> +#ifdef CONFIG_FB_CIRRUS_I2C
> +	cinfo->i2c_used = 0;
> +	if (cinfo->btype == BT_ALPINE || cinfo->btype == BT_PICASSO4) {
> +		vga_wseq(cinfo->regbase, 0x08, 0x41); /* DDC mode: SCL */
> +		vga_wseq(cinfo->regbase, 0x08, 0x43); /* DDC mode: SCL + SDA */
> +		cinfo->bit_cirrus_data.setsda = alpine_setsda;
> +		cinfo->bit_cirrus_data.setscl = alpine_setscl;
> +		cinfo->bit_cirrus_data.getsda = alpine_getsda;
> +		cinfo->bit_cirrus_data.getscl = alpine_getscl;
> +		cinfo->bit_cirrus_data.udelay = 5;
> +		cinfo->bit_cirrus_data.mdelay = 1;
> +		cinfo->bit_cirrus_data.timeout = HZ;
> +		cinfo->bit_cirrus_data.data = cinfo;
> +		cinfo->cirrus_ops.owner = THIS_MODULE;
> +		cinfo->cirrus_ops.id = I2C_HW_B_CIRRUS;
> +		cinfo->cirrus_ops.class = I2C_CLASS_DDC;
> +		cinfo->cirrus_ops.algo_data = &cinfo->bit_cirrus_data;
> +		cinfo->cirrus_ops.dev.parent = info->device;
> +		strlcpy(cinfo->cirrus_ops.name, "Cirrus Logic DDC I2C adapter",
> +			I2C_NAME_SIZE);
> +		if (!(err = i2c_bit_add_bus(&cinfo->cirrus_ops))) {
> +			printk(KERN_DEBUG "Initialized Cirrus Logic I2C"
> +			       " adapter\n");
> +			cinfo->i2c_used = 1;
> +		} else
> +			printk(KERN_WARNING "Unable to initialize Cirrus"
> +			       " Logic I2C adapter (result = %i)\n", err);
> +	}
> +#endif

Why don't you create a separate function for this, ie cirrusfb_create_i2c()
or something. This way, we eliminate the #ifdef/#endif inside the function.

> +
>  	DPRINTK ("EXIT, returning 0\n");
>  	return 0;
>  
> @@ -2350,6 +2421,10 @@ static void __devexit cirrusfb_cleanup (
>  	struct cirrusfb_info *cinfo = info->par;
>  	DPRINTK ("ENTER\n");
>  
> +#ifdef CONFIG_FB_CIRRUS_I2C
> +	if (cinfo->i2c_used)
> +		i2c_bit_del_bus(&cinfo->cirrus_ops);
> +#endif

Same here.

Tony
