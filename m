Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWICUz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWICUz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 16:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWICUz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 16:55:59 -0400
Received: from 1wt.eu ([62.212.114.60]:3090 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S932117AbWICUz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 16:55:57 -0400
Date: Sun, 3 Sep 2006 20:34:03 +0200
From: Willy Tarreau <w@1wt.eu>
To: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org,
       John Heffner <jheffner@psc.edu>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: Problems with ipv4 part of Kernels post-2.6.16
Message-ID: <20060903183403.GB604@1wt.eu>
References: <20060903201335.GA3703@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060903201335.GA3703@ime.usp.br>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rogério,

On Sun, Sep 03, 2006 at 05:13:35PM -0300, Rogério Brito wrote:
> Hi, John, David and others developers.
> 
> I have been trying to keep up with the kernel releases (not only the
> -rc ones, but also some -mm's) and I noticed something quite strange:
> with some post 2.6.16 kernels (say, 2.6.17), I can't access (from where
> I am) the site www.everymac.com, while I can access other sites.

I believe I read on LKML last month that there's a problem on this site
with window scaling. There's a patch floating around to allow per
destination window clamping. I believe that you can workaround the
problem by disabling TCP window scaling :

   echo 0 >/proc/sys/net/ipv4/tcp_window_scaling

Hoping this helps,
Willy


> This has made me quite curious, because just booting back with a
> 2.6.16.x kernel, I could access it, which, of course, led me to think
> this was a problem with the networking part of the kernel.
> 
> Well, to cut a long story short, yesterday I decided to learn how to use
> git, grabbed Linus's tree and started a bisection session.
> 
> After 12 recompilations, I found the following patch being the first
> suspect (sorry for the line wrapping, but I copied this one from one
> console to another, since I don't know how to generate it again with
> git):
> 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> rbrito@dumont:/usr/local/media/progs/linux/kernel/linux-git$ git bisect
> good
> 7b4f4b5ebceab67ce440a61081a69f0265e17c2a is first bad commit
> commit 7b4f4b5ebceab67ce440a61081a69f0265e17c2a
> Author: John Heffner <jheffner@psc.edu>
> Date:   Sat Mar 25 01:34:07 2006 -0800
> 
>     [TCP]: Set default max buffers from memory pool size
> 
>     This patch sets the maximum TCP buffer sizes (available to automatic
>     buffer tuning, not to setsockopt) based on the TCP memory pool size.
>     The maximum sndbuf and rcvbuf each will be up to 4 MB, but no more
>     than 1/128 of the memory pressure threshold.
> 
>     Signed-off-by: John Heffner <jheffner@psc.edu>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> :040000 040000 514849b6a38c5fb671f3aeae1c0108a0e8e897dc
> 3b912fd10db444b22262f995fac99f2851363531 M      net
> rbrito@dumont:/usr/local/media/progs/linux/kernel/linux-git$
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> I'm currently connected to my provider via cable modem and I'm assigned
> an IP address via DHCP (actually, I'm using a D-Link DI-524 router in
> between, but I already tested *without* the router in the middle and the
> problem remains). The contents of my /etc/sysctl.conf file are attached.
> 
> My userspace is Debian's testing/etch, regularly upgraded every day. My
> system is a Duron 1.1GHz, with 512MB of RAM and a KT133 (VIA) chipset,
> with the network card being a Realtek RTL8139.
> 
> I would like to point out that this has prevented me from using/testing
> other newer kernels. :-(
> 
> If anything else is required, please, don't hesitate to ask. I will try
> my best to use any patches that may seem relevant, until we can point
> out what may be happening.
> 
> 
> Thanks, Rogério Brito.
> 
> P.S.: Please, I'm not (currently) subscribed to any mailing list.  I'd
> appreciate if the CCs weren't trimmed.
> -- 
> Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
> Homepage of the algorithms package : http://algorithms.berlios.de
> Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/

> #
> # /etc/sysctl.conf - Configuration file for setting system variables
> # See sysctl.conf (5) for information.
> #
> 
> # Uncomment the following to stop low-level messages on console
> #kernel.printk = 4 4 1 7
> 
> ##############################################################3
> # Functions previously found in netbase
> #
> #net.ipv4.conf.default.forwarding=1
> #net.ipv6.conf.default.forwarding=1
> 
> dev.rtc.max-user-freq=1024
> net.ipv4.conf.all.accept_redirects=0
> net.ipv4.conf.all.accept_source_route=0
> net.ipv4.conf.all.log_martians=1
> net.ipv4.conf.all.rp_filter=1
> net.ipv4.conf.default.accept_redirects=0
> net.ipv4.conf.default.accept_source_route=0
> net.ipv4.conf.default.log_martians=1
> net.ipv4.conf.default.rp_filter=1
> net.ipv4.icmp_echo_ignore_broadcasts=1
> net.ipv4.tcp_syncookies=1


-- 
VGER BF report: H 1.33782e-13
