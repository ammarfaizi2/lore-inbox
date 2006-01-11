Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWAKMxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWAKMxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWAKMxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:53:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:55246 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751466AbWAKMxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:53:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: spereira@tusc.com.au
Subject: Re: [PATCH] net: 32 bit (socket layer) ioctl emulation for 64 bit kernels
Date: Wed, 11 Jan 2006 12:52:39 +0000
User-Agent: KMail/1.9.1
Cc: linux-kenel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>, Andi Kleen <ak@muc.de>,
       SP <pereira.shaun@gmail.com>
References: <1136789216.6653.17.camel@spereira05.tusc.com.au> <200601091054.35010.arnd@arndb.de> <1136960915.5347.10.camel@spereira05.tusc.com.au>
In-Reply-To: <1136960915.5347.10.camel@spereira05.tusc.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601111252.39897.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 January 2006 06:28, Shaun Pereira wrote:
> And the correct x.25 patch, (will build a [PATCH] if this is ok).
> Tested with with xot to a Cisco box. 

Much better now, but

> +       switch(cmd) {
> +               case TIOCOUTQ:
> +               case TIOCINQ:

Looking at how these are handled in x25_ioctl(),
these should be forwarded to x25_ioctl(), because they are
compatible. With your current code you incorrectly return -EINVAL.

> +               case SIOCGSTAMP:

This one actually needs a conversion handler. You could
add a generic compat_sock_get_timestamp() function to net/compat.c
for this.

> +               case SIOCGIFADDR:
> +               case SIOCSIFADDR:
> +               case SIOCGIFDSTADDR:
> +               case SIOCSIFDSTADDR:
> +               case SIOCGIFBRDADDR:
> +               case SIOCSIFBRDADDR:
> +               case SIOCGIFNETMASK:
> +               case SIOCSIFNETMASK:
> +               case SIOCGIFMETRIC:
> +               case SIOCSIFMETRIC:

These all return -EINVAL in x25_ioctl, just do the same here.

For any the cases above, you can also choose not to handle them
in compat_x25_ioctl at all and just return -ENOIOCTLCMD, so they
get forwarded to the conversion code in fs/compat_ioctl.c. 

> +               case SIOCADDRT:
> +               case SIOCDELRT:

These should call x25_route_ioctl() instead of falling through to
to compat_x25_subscr_ioctl(), right?

> +               case SIOCX25GFACILITIES:
> +               case SIOCX25SFACILITIES:
> +               case SIOCX25GCALLUSERDATA:
> +               case SIOCX25SCALLUSERDATA:
> +               case SIOCX25GCAUSEDIAG:
> +               case SIOCX25SCUDMATCHLEN:
> +               case SIOCX25CALLACCPTAPPRV:
> +                       rc = x25_ioctl(sock, cmd, (unsigned long)argp);
> +                       break;
> +               case SIOCX25SENDCALLACCPT:
> +                       rc = x25_ioctl(sock, cmd, (unsigned long)argp);
> +                       break;

I guess these can be combined to a single case list.

        Arnd <><
