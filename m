Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWAPJjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWAPJjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWAPJjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:39:53 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:11468 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932304AbWAPJjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:39:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: spereira@tusc.com.au
Subject: Re: 32 bit (socket layer) ioctl emulation for 64 bit kernels
Date: Mon, 16 Jan 2006 10:39:23 +0100
User-Agent: KMail/1.9.1
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Andi Kleen <ak@muc.de>,
       linux-kenel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>, SP <pereira.shaun@gmail.com>
References: <1137045732.5221.21.camel@spereira05.tusc.com.au> <200601131146.48128.arnd@arndb.de> <1137391160.5588.32.camel@spereira05.tusc.com.au>
In-Reply-To: <1137391160.5588.32.camel@spereira05.tusc.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200601161039.24333.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 January 2006 06:59, Shaun Pereira wrote:
> 
> I was wondering if this the compat_sock_get_timestamp function is
> needed? If I were to remove the SIOCGSTAMP case from the
> compat_x25_ioctl function, then a SIOCGSTAMP ioctl system call would
> return -ENOIOCTLCMD which could  then be handled by do_siocgstamp
> handler in the ioctl32_hash_table? (fs/compat_ioctl.c)
> In which case I could remove this patch from the rest of the series.

Yes, that would also work, as I already mentioned (or tried to)
in one of my earlier comments. I would prefer to have this patch
though, because in the long term, I think we should migrate more
stuff away from the hash table and having the function there
means that others can use it as well.

> +       err = -EFAULT;
> +       if(access_ok(VERIFTY_WRITE, ctv, sizeof(*ctv))) {
> +               err = __put_user(sk->sk_stamp.tv_sec, &ctv->tv_sec);
> +               err != __put_user(sk->sk_stamp.tv_usec, &ctv->tv_usec);
> +       }
> +       return err;
> +}

This copies the correct data down to user space now, but might result
in returning an invalid error code.
In the second line you now have 'err != __put_user(...);', which is
a comparison, not an assignment!
For readability, I would simply write that as:

	ret = 0;
	if (put_user(sk->sk_stamp.tv_sec, &ctv->tv_sec) |
	    put_user(sk->sk_stamp.tv_usec, &ctv->tv_usec))
		err = -EFAULT;

You can also write it like your code, but with '|' instead of '!', but
that requires the additional knowledge that __put_user can only ever
return '0' or '-EFAULT' itself and that the bitwise or of those is
therefore also one of these two.

	Arnd <><
