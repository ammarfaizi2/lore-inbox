Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSFEVAz>; Wed, 5 Jun 2002 17:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316404AbSFEVAy>; Wed, 5 Jun 2002 17:00:54 -0400
Received: from quark.didntduck.org ([216.43.55.190]:50181 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S313711AbSFEVAu>; Wed, 5 Jun 2002 17:00:50 -0400
Message-ID: <3CFE7BFC.8EE5605@didntduck.org>
Date: Wed, 05 Jun 2002 17:00:44 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Problem with new driver model?
In-Reply-To: <Pine.LNX.4.33.0206051336170.654-100000@geena.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> 
> On 5 Jun 2002, Paul Fulghum wrote:
> 
> > When testing the drivers I maintain on 2.5.20, I hit the
> > BUG_ON in include/linux/devices.txt:115.
> 
> There is a patch that should fix this in Linus's tree.
> 
> If you're using bitkeeper, you can pull it from
> linux.bkbits.net/linux-2.5.
> 
> If not, it's appended here.
> 
>         -pat
> 
> +void remove_driver(struct device_driver * drv)
> +{
> +       spin_lock(&device_lock);
> +       atomic_set(&drv->refcount,0);
> +       spin_unlock(&device_lock);
> +       __remove_driver(drv);
> +}
> +
> +/**
> + * put_driver - decrement driver's refcount and clean up if necessary
> + * @drv:       driver in question
> + */
> +void put_driver(struct device_driver * drv)
> +{
> +       if (!atomic_dec_and_lock(&drv->refcount,&device_lock))
> +               return;
> +       spin_unlock(&device_lock);
> +
> +       __remove_driver(drv);
> +}

Shouldn't the calls to __remove_driver be done inside the device_lock?

--

				Brian Gerst
