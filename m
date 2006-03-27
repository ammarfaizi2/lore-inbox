Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWC0U5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWC0U5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWC0U5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:57:43 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:26868 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751128AbWC0U5m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:57:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=keDzu/H3cGTmM35TngOpS5PzpGFu1Nx/klcILkVuw3NL9//r3El1YYak0sQ55UP83QbOJQPscElzj8CPL+zWBGkHO3Tk3Is6lFkoQpRcKm+po4bNWTDS/IliUzH93DGxhOVmt2ALHAEdxm8h+wdS476I9c85HmJtT6ajWvTKD1s=
Message-ID: <4807377b0603271257l237c29e6h8ba14cfd3551db8c@mail.gmail.com>
Date: Mon, 27 Mar 2006 12:57:41 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] Lower e100 latency
Cc: akpm@osdl.org, "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20060327223013.674d1970@werewolf.auna.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	 <20060323220711.28fcb82f@werewolf.auna.net>
	 <20060323221342.2352789d@werewolf.auna.net>
	 <4423221D.6020109@garzik.org>
	 <20060327223013.674d1970@werewolf.auna.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/06, J.A. Magallon <jamagallon@able.es> wrote:
> Corrected:
>
> --- linux/drivers/net/e100.c.orig       2006-01-24 09:20:44.000000000 +0100
> +++ linux/drivers/net/e100.c    2006-01-24 09:21:55.000000000 +0100
> @@ -884,10 +884,10 @@
>          * procedure it should be done under lock.
>          */
>         spin_lock_irqsave(&nic->mdio_lock, flags);
> -       for (i = 100; i; --i) {
> +       for (i = 1000; i; --i) {
>                 if (readl(&nic->csr->mdi_ctrl) & mdi_ready)
>                         break;
> -               udelay(20);
> +               udelay(2);

what is the purpose of this patch?  what bug is it solving?  Are we
trying to achieve some goal?  A comment at the very least is
necessary.  I don't like changing timing stuff unless we have some
clear reason.  In fact I sent a patch a while back to a guy who was
complaining about latency in a -RT kernel with e100 and he said this
kind of change made things worse: see the end of:

http://marc.theaimsgroup.com/?l=linux-kernel&m=113808831932769&w=2

The problem in this case is the mii library calling back into our
mdio_read.  eepro100's mdio read hard spins with no delay besides the
ioread32 delay created by reading from an i/o port.  This could
explain the glitching in an RT kernel.

Is this the kind of problem this patch tries to solve?

Thanks,
  Jesse
