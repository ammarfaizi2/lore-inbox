Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbULRBuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbULRBuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 20:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbULRBuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 20:50:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:42440 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262187AbULRBus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 20:50:48 -0500
Message-ID: <41C38BE0.30004@osdl.org>
Date: Fri, 17 Dec 2004 17:46:08 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: james4765@verizon.net
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] ip2: fix compile warnings
References: <20041217214735.7127.91238.40236@localhost.localdomain>
In-Reply-To: <20041217214735.7127.91238.40236@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

james4765@verizon.net wrote:
> This fixes the following compile errors in the ip2 and ip2main drivers:
> 
>   CC      drivers/char/ip2main.o
> drivers/char/ip2main.c:470: warning: initialization from incompatible pointer type


> diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/ip2main.c linux-2.6.10-rc3-mm1/drivers/char/ip2main.c
> --- linux-2.6.10-rc3-mm1-original/drivers/char/ip2main.c	2004-12-03 16:55:03.000000000 -0500
> +++ linux-2.6.10-rc3-mm1/drivers/char/ip2main.c	2004-12-17 16:24:24.094730049 -0500
> @@ -467,7 +466,7 @@
>  static struct tty_operations ip2_ops = {
>  	.open            = ip2_open,
>  	.close           = ip2_close,
> -	.write           = ip2_write,
> +	.write           = (void *) ip2_write,
>  	.put_char        = ip2_putchar,
>  	.flush_chars     = ip2_flush_chars,
>  	.write_room      = ip2_write_room,

The write() prototype in tty_operations is:
	int  (*write)(struct tty_struct * tty,
		      const unsigned char *buf, int count);

Somehow the cast does eliminate the compiler warning (and give
a false sense of correctness).

However, ip2main.c::ip2_write() should be modified like so:

static int
ip2_write( PTTY tty, const unsigned char *pData, int count)

and drop the cast and fix the ip2_write comment (drop old arg 2),
and fix the ip2_write() prototype.
But then you (someone) will have to decide how to handle the
dropped <user> parameter when calling i2Output()...
I don't know the answer to that.
I just changed <user> to 0 to get a clean build of ip2main.o,
but ip2/i2lib.c still needs some work.

-- 
~Randy
