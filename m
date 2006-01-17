Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWAQAPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWAQAPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 19:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWAQAPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 19:15:22 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:41431 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751263AbWAQAPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 19:15:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: spereira@tusc.com.au
Subject: Re: [PATCH 3/4 -2.6.15]:x25: 32 bit (socket layer) ioctl emulation for 64 bit kernels
Date: Tue, 17 Jan 2006 01:15:06 +0100
User-Agent: KMail/1.9.1
Cc: YOSHIFUJI Hideaki /
	 =?utf-8?q?=E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E?= 
	<yoshfuji@linux-ipv6.org>,
       acme@ghostprotocols.net, ak@muc.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, pereira.shaun@gmail.com
References: <1137122079.5589.34.camel@spereira05.tusc.com.au> <200601161043.31742.arnd@arndb.de> <1137453135.6553.19.camel@spereira05.tusc.com.au>
In-Reply-To: <1137453135.6553.19.camel@spereira05.tusc.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601170115.07019.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 17. Januar 2006 00:12 schrieb Shaun Pereira:
> +static int compat_x25_subscr_ioctl(unsigned int cmd,
> +               struct compat_x25_subscrip_struct __user *x25_subscr32)
> +{
> +       struct x25_subscrip_struct x25_subscr;
> +       struct x25_neigh *nb;
> +       struct net_device *dev;
> +       int rc = -EINVAL;
> +
> +       if (cmd != SIOCX25GSUBSCRIP && cmd != SIOCX25SSUBSCRIP)
> +               goto out;

btw, the above check is not needed here, but that's not my point.

> +
> +       rc = -EFAULT;
> +       if(copy_from_user(&x25_subscr, x25_subscr32, sizeof(*x25_subscr32))) 
> +               goto out;

Unfortunately, I just found another bug in this code, similar to one you 
already fixed in the sock_get_timestamp handler:
You can't do the copy_from_user like this if the arguments have different 
types. Changing the declaration 'struct x25_subscrip_struct x25_subscr;'
to 'struct compat_x25_subscrip_struct x25_subscr;' should fix this problem,
but please verify that it really works with a test case that relies on the 
contents of x25_subscr->extended.

	Arnd <><
