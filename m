Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWENOUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWENOUA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 10:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWENOUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 10:20:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:61875 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751425AbWENOUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 10:20:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Jls7loGialLwaVN+v+Xvnb5xYVmBbYnFFjpvmw9A4H+Vx2lnZ0m1AtAifTW+1WPKMqVbC1c+uFFkGwAPitSHjuBByX671p3LVPn6LSgO9XITfr7UFIP+Hsq9FqUt6Kfqwmt6tcCziS+TQq0VDPhD2oT4sDHh5eMp46teWCPqZX0=
Date: Sun, 14 May 2006 18:18:46 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Moxa Technologies <support@moxa.com.tw>,
       Alan Cox <alan@redhat.com>, Martin Mares <mj@ucw.cz>
Subject: Re: [PATCH] fix dangerous pointer derefs and remove pointless casts in MOXA driver
Message-ID: <20060514141845.GB23387@mipter.zuzino.mipt.ru>
References: <200605140349.36122.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605140349.36122.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 03:49:35AM +0200, Jesper Juhl wrote:
> If mxser_write() gets called with a NULL 'tty' pointer, then the initial
> assignment of tty->driver_data to info will explode.

->write() is called via

	tty->driver->write(tty, ...);

See? tty was already dereferenced.

> 'tty' is tested for NULL at the beginning of the function, but at that
> point it is too late.
> Fix the problem by only dereferencing tty after it has been tested.
>
> In mxser_put_char() there's the same problem with the same fix.
>
> This should fix coverity bugs #770 && #771 .

> --- linux-2.6.17-rc4-git2-orig/drivers/char/mxser.c
> +++ linux-2.6.17-rc4-git2/drivers/char/mxser.c
> @@ -877,7 +877,7 @@ static int mxser_init(void)
>
>  static void mxser_do_softint(void *private_)
>  {
> -	struct mxser_struct *info = (struct mxser_struct *) private_;
> +	struct mxser_struct *info = private_;

Please, don't make unrelated changes, ever.

>  	struct tty_struct *tty;
>
>  	tty = info->tty;

> @@ -1078,11 +1077,15 @@ static void mxser_close(struct tty_struc
>  static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int count)
>  {
>  	int c, total = 0;
> -	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
> +	struct mxser_struct *info;
>  	unsigned long flags;
>  
> -	if (!tty || !info->xmit_buf)
> -		return (0);
> +	if (!tty)
> +		return 0;
> +
> +	info = tty->driver_data;
> +	if (!info->xmit_buf)
> +		return 0;
>  
>  	while (1) {
>  		c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1, SERIAL_XMIT_SIZE - info->xmit_head));
> @@ -1114,10 +1117,14 @@ static int mxser_write(struct tty_struct
>  
>  static void mxser_put_char(struct tty_struct *tty, unsigned char ch)
>  {
> -	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
> +	struct mxser_struct *info;
>  	unsigned long flags;
>  
> -	if (!tty || !info->xmit_buf)
> +	if (!tty)
> +		return;
> +
> +	info = tty->driver_data;
> +	if (!info->xmit_buf)
>  		return;
>  
>  	if (info->xmit_cnt >= SERIAL_XMIT_SIZE - 1)

