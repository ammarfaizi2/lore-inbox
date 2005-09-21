Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVIUPYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVIUPYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVIUPYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:24:18 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:34999 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750992AbVIUPYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:24:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=RIBfe3kCwjYfM2ki/speff/APjVMchyrlpWvP4o5RmXDDlbkU+mrEr1MZhkIIY3iSbJCbMwHvuLFNwhR2LbLtq3rBCZdp84XGWOan7tEWFHcqh9AOjcvOoahIb/N+vmKnCdSYoA6brj2sS88gzvl36xc9e1v0u1Dikh0s3LT3Ww=
Date: Wed, 21 Sep 2005 19:34:50 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jayakumar.alsa@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: + cleanup-for-cs5535-audio-driver.patch added to -mm tree
Message-ID: <20050921153450.GA2420@mipter.zuzino.mipt.ru>
References: <200509211021.j8LALVbj001716@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509211021.j8LALVbj001716@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 03:20:55AM -0700, akpm@osdl.org wrote:
>      Cleanup for CS5535 audio driver

> --- devel/sound/pci/cs5535audio/cs5535audio.c
> +++ devel-akpm/sound/pci/cs5535audio/cs5535audio.c

> +static void wait_till_cmd_acked(cs5535audio_t *cs5535au, unsigned long timeout)
> +{
> +	unsigned long tmp;
> +	do {
> +		tmp = cs_readl(cs5535au, ACC_CODEC_CNTL);
> +		if (!(tmp & CMD_NEW))
> +			break;
> +		msleep(10);
> +	} while (--timeout);
> +	if (!timeout)
> +		snd_printk(KERN_ERR "Failure writing to cs5535 codec\n");
> +}

Looks wrong. Should be something like

	unsigned long end_jiffies = jiffies + timeout;

	while (1) {
		if (!(cs_readl(cs5535au, ACC_CODEC_CNTL) & CMD_NEW))
			break;
		if (time_after(end_jiffies, jiffies))
			break;
		msleep(10);
	}
		and printk somewhere

