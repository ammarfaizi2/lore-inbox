Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVEaQCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVEaQCn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVEaQCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:02:43 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:19818 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261920AbVEaQBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:01:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NejHPtixQY01irrLmMOj6+gB/WOnGl9BCmtVAeZiKhtuqaEArCVH4kfpgasZ9vrzv9Di4rNn/16WZ1U0UoelZibcmtIpHCqUG98rqnDe0J/oFnnTc8KHJUqcbBXMscavvsT0dBHakEm22cceSiGw1Jmvg4Tgn4erxj0pwFmyubk=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Subject: Re: potential-null-pointer-dereference-in-amiga-serial-driver.patch added to -mm tree
Date: Tue, 31 May 2005 19:49:15 +0400
User-Agent: KMail/1.7.2
Cc: julien.tinnes@francetelecom.com, linux-kernel@vger.kernel.org
References: <200505310909.j4V98xBR008727@shell0.pdx.osdl.net>
In-Reply-To: <200505310909.j4V98xBR008727@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505311949.15449.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 May 2005 13:08, akpm@osdl.org wrote:
> A pointer is dereferenced before it is null-checked.

> --- 25/drivers/char/amiserial.c~potential-null-pointer-dereference-in-amiga-serial-driver
> +++ 25-akpm/drivers/char/amiserial.c

>  static void rs_put_char(struct tty_struct *tty, unsigned char ch)
>  {
> -	struct async_struct *info = (struct async_struct *)tty->driver_data;
> +	struct async_struct *info;
>  	unsigned long flags;
>  
> +	if (!tty)
> +		return;

Can ->put_char be ever called with tty being NULL? From my reading of
drivers/char/n_tty.c it can't.

Every single time ->put_char is used a-la

	tty->driver->put_char(tty, '\r');

So, tty will be dereferenced before function call. Same for static inline
put_char() there.

> +
> +	info = tty->driver_data;

>  static int rs_write(struct tty_struct * tty, const unsigned char *buf, int count)
>  {

> -	struct async_struct *info = (struct async_struct *)tty->driver_data;
> +	struct async_struct *info;
>  	unsigned long flags;
>  
> +	if (!tty)
> +		return 0;

Same question.

> +
> +	info = tty->driver_data;
