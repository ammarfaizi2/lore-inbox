Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269942AbUJHAVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269942AbUJHAVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269859AbUJHARb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:17:31 -0400
Received: from mail.dif.dk ([193.138.115.101]:30672 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S269941AbUJHAQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:16:26 -0400
Date: Fri, 8 Oct 2004 02:23:51 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] add missing checks of __copy_to_user return value in
 i2o_config.c
In-Reply-To: <4165AEB9.8040608@shadowconnect.com>
Message-ID: <Pine.LNX.4.61.0410080210420.10473@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410052317350.2913@dragon.hygekrogen.localhost>
 <20041006114154.A29243@infradead.org> <Pine.LNX.4.61.0410062159590.2975@dragon.hygekrogen.localhost>
 <4165AEB9.8040608@shadowconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Markus Lidel wrote:

> Hello,
> thanks for fixing i2o_config.

You're welcome.


> In the meantime i've also made a patch, which
> tries to reduce the many return's too.
> Note: i've not touched the passthru stuff yet.
> Please let me know, which you think of it.

> --- a/drivers/message/i2o/i2o_config.c	2004-09-24 11:05:12.044972000 +0200
> +++ b/drivers/message/i2o/i2o_config.c	2004-10-07 22:49:59.786543596 +0200
> @@ -178,18 +178,17 @@
>  	struct i2o_controller *c;
>  	u8 __user *user_iop_table = (void __user *)arg;
>  	u8 tmp[MAX_I2O_CONTROLLERS];
> +	int rc = 0;
 
Purely personal preference, I think "ret" is a more intuitive name for 
that variable.


+	if (copy_from_user(&kcmd, cmd, sizeof(struct i2o_cmd_hrtlct))) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
[...]

+exit:
+	return rc;
 };
 

I prefer the 

if (foo)
	goto return_fault;

[...]

return_ret:
	return ret;
return_fault:
	ret = -EFAULT;
	goto return_ret;

variant. 
Sure, your way results in just a single mov and a single jmp when 
the branch is taken, but, my way has only a single jmp at each branch, 
then a mov and an additional jmp at the end, so for a single branch your 
way wins with   
1 mov + 1 jmp vs my 2 jmp's and 1 mov.
but, when you have a lot those branches my way generates less code. At 5 
branches you have 5 mov + 5 jmp while I'll have 1 mov + 6 jmp.
Also, my way takes up less space in the source, so more code fits on 
screen.

I doubt it matters much since this doesn't look like a very hot code path, 
but I prefer the version that generates the smaller code and takes up less 
space in the source.

Apart from those nitpicks it looks good to me :)


--
Jesper Juhl

