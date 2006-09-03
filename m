Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWICWIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWICWIU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWICWIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:08:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:25868 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750845AbWICWHq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:07:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LyO2zL6lgfKxGKr5GRULRvxMFh0jwFIlWct9fWYEakTdfRCWqNbZ4dAX/AjiNTXGWdM882gMth8Y7306p3th7uYvAbYgOh1IvxWBn4lKMof48QvDHXGgKsorMI0YzQu4mv6JwurPM85AKfVsunqw9OWplWAjgnJbs5l3hzRdvXY=
Message-ID: <5a4c581d0609031507w54a397c4g2876b47b2fbbd45c@mail.gmail.com>
Date: Mon, 4 Sep 2006 00:07:45 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Willy Tarreau" <w@1wt.eu>
Subject: Re: Problems with ipv4 part of Kernels post-2.6.16
Cc: "=?ISO-8859-1?Q?Rog=E9rio_Brito?=" <rbrito@ime.usp.br>,
       linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org,
       "John Heffner" <jheffner@psc.edu>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060903183403.GB604@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060903201335.GA3703@ime.usp.br> <20060903183403.GB604@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/06, Willy Tarreau <w@1wt.eu> wrote:
> Hi Rogério,
>
> On Sun, Sep 03, 2006 at 05:13:35PM -0300, Rogério Brito wrote:
> > Hi, John, David and others developers.
> >
> > I have been trying to keep up with the kernel releases (not only the
> > -rc ones, but also some -mm's) and I noticed something quite strange:
> > with some post 2.6.16 kernels (say, 2.6.17), I can't access (from where
> > I am) the site www.everymac.com, while I can access other sites.
>
> I believe I read on LKML last month that there's a problem on this site
> with window scaling. There's a patch floating around to allow per
> destination window clamping. I believe that you can workaround the
> problem by disabling TCP window scaling :
>
>    echo 0 >/proc/sys/net/ipv4/tcp_window_scaling
>
> Hoping this helps,
> Willy

The above does help while hitting certain websites from behind my
 corporate proxy (while others are okay); same websites can be
 accessed without any issue from my home ISP connection.

I logged an internal ticket for this, will check whether there's been
 any update as of recently; both happens with recent 2.6.18-rc and
 with FC5-latest kernel.

> > This has made me quite curious, because just booting back with a
> > 2.6.16.x kernel, I could access it, which, of course, led me to think
> > this was a problem with the networking part of the kernel.
> >
> > Well, to cut a long story short, yesterday I decided to learn how to use
> > git, grabbed Linus's tree and started a bisection session.
> >
> > After 12 recompilations, I found the following patch being the first
> > suspect (sorry for the line wrapping, but I copied this one from one
> > console to another, since I don't know how to generate it again with
> > git):
> >
> > - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> > rbrito@dumont:/usr/local/media/progs/linux/kernel/linux-git$ git bisect
> > good
> > 7b4f4b5ebceab67ce440a61081a69f0265e17c2a is first bad commit
> > commit 7b4f4b5ebceab67ce440a61081a69f0265e17c2a
> > Author: John Heffner <jheffner@psc.edu>
> > Date:   Sat Mar 25 01:34:07 2006 -0800
> >
> >     [TCP]: Set default max buffers from memory pool size
> >
> >     This patch sets the maximum TCP buffer sizes (available to automatic
> >     buffer tuning, not to setsockopt) based on the TCP memory pool size.
> >     The maximum sndbuf and rcvbuf each will be up to 4 MB, but no more
> >     than 1/128 of the memory pressure threshold.
> >
> >     Signed-off-by: John Heffner <jheffner@psc.edu>
> >     Signed-off-by: David S. Miller <davem@davemloft.net>
> >
> > :040000 040000 514849b6a38c5fb671f3aeae1c0108a0e8e897dc
> > 3b912fd10db444b22262f995fac99f2851363531 M      net
> > rbrito@dumont:/usr/local/media/progs/linux/kernel/linux-git$
> > - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> >
> > I'm currently connected to my provider via cable modem and I'm assigned
> > an IP address via DHCP (actually, I'm using a D-Link DI-524 router in
> > between, but I already tested *without* the router in the middle and the
> > problem remains). The contents of my /etc/sysctl.conf file are attached.
> >
> > My userspace is Debian's testing/etch, regularly upgraded every day. My
> > system is a Duron 1.1GHz, with 512MB of RAM and a KT133 (VIA) chipset,
> > with the network card being a Realtek RTL8139.
> >
> > I would like to point out that this has prevented me from using/testing
> > other newer kernels. :-(
> >
> > If anything else is required, please, don't hesitate to ask. I will try
> > my best to use any patches that may seem relevant, until we can point
> > out what may be happening.
> >
> >
> > Thanks, Rogério Brito.
> >
> > P.S.: Please, I'm not (currently) subscribed to any mailing list.  I'd
> > appreciate if the CCs weren't trimmed.
> > --
> > Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
> > Homepage of the algorithms package : http://algorithms.berlios.de
> > Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
>
> > #
> > # /etc/sysctl.conf - Configuration file for setting system variables
> > # See sysctl.conf (5) for information.
> > #
> >
> > # Uncomment the following to stop low-level messages on console
> > #kernel.printk = 4 4 1 7
> >
> > ##############################################################3
> > # Functions previously found in netbase
> > #
> > #net.ipv4.conf.default.forwarding=1
> > #net.ipv6.conf.default.forwarding=1
> >
> > dev.rtc.max-user-freq=1024
> > net.ipv4.conf.all.accept_redirects=0
> > net.ipv4.conf.all.accept_source_route=0
> > net.ipv4.conf.all.log_martians=1
> > net.ipv4.conf.all.rp_filter=1
> > net.ipv4.conf.default.accept_redirects=0
> > net.ipv4.conf.default.accept_source_route=0
> > net.ipv4.conf.default.log_martians=1
> > net.ipv4.conf.default.rp_filter=1
> > net.ipv4.icmp_echo_ignore_broadcasts=1
> > net.ipv4.tcp_syncookies=1
>
>
> --
> VGER BF report: H 1.33782e-13
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
--alessandro

"What's the name of the word for the precise moment when you
 realize that you've actually forgotten how it felt to make love
 to somebody you really liked a long time ago?"
"There isn't one."
"Oh. I thought maybe there was."
     (The Sandman, dialogue between Delirium and Dream)

-- 
VGER BF report: H 0.0642894
