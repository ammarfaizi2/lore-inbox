Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265750AbUGDQEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUGDQEV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 12:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUGDQEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 12:04:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4356 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265750AbUGDQEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 12:04:12 -0400
Date: Sun, 4 Jul 2004 17:02:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.6: IPv6 initialisation bug
Message-ID: <20040704170259.A16596@flint.arm.linux.org.uk>
Mail-Followup-To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20040628010200.A15067@flint.arm.linux.org.uk> <20040629.020627.76560474.yoshfuji@linux-ipv6.org> <20040628184758.C9214@flint.arm.linux.org.uk> <20040629.095903.58985982.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040629.095903.58985982.yoshfuji@linux-ipv6.org>; from yoshfuji@linux-ipv6.org on Tue, Jun 29, 2004 at 09:59:03AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 09:59:03AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B wrote:
> In article <20040628184758.C9214@flint.arm.linux.org.uk> (at Mon, 28 Jun 2004 18:47:58 +0100), Russell King <rmk+lkml@arm.linux.org.uk> says:
> > On Tue, Jun 29, 2004 at 02:06:27AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B wrote:
> > > In article <20040628010200.A15067@flint.arm.linux.org.uk> (at Mon, 28 Jun 2004 01:02:01 +0100), Russell King <rmk+lkml@arm.linux.org.uk> says:
> > > 
> > > > Ok, I've just tried 2.6.7 out on my root-NFS'd firewall with IPv6 built
> > > > in, and it doesn't work because of the problem I described below.
> > > :
> > > > What's the solution?
> > > 
> > > Bring lo up before bring others up.
> > > What does prevent you from doing this?
> > > (Do we need some bits to do this automatically?)
> > 
> > When you use root-NFS, the kernel itself brings up the interfaces,
> > and IPv6 immediately comes in and tries to configure itself to them,
> > trying to create the routes.
> > 
> > Unfortunately, the kernel doesn't bring up lo first because it
> > doesn't know to do that.
> 
> Okay, would you try the following patch, please?

This does appear to fix the problem.

> D: Bring loopback device up first
> 
> Signed-Off-By: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> 
> ===== net/ipv4/ipconfig.c 1.38 vs edited =====
> --- 1.38/net/ipv4/ipconfig.c	2004-06-23 09:06:18 +09:00
> +++ edited/net/ipv4/ipconfig.c	2004-06-29 09:53:36 +09:00
> @@ -183,7 +183,14 @@
>  
>  	last = &ic_first_dev;
>  	rtnl_shlock();
> +
> +	/* bring loopback device up first */
> +	if (dev_change_flags(&loopback_dev, loopback_dev.flags | IFF_UP) < 0)
> +		printk(KERN_ERR "IP-Config: Failed to open %s\n", loopback_dev.name);
> +
>  	for (dev = dev_base; dev; dev = dev->next) {
> +		if (dev == &loopback_dev)
> +			continue;
>  		if (user_dev_name[0] ? !strcmp(dev->name, user_dev_name) :
>  		    (!(dev->flags & IFF_LOOPBACK) &&
>  		     (dev->flags & (IFF_POINTOPOINT|IFF_BROADCAST)) &&
> 
> -- 
> Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
> GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
