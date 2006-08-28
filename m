Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWH1TD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWH1TD7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWH1TD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:03:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16790 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751343AbWH1TD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:03:57 -0400
Date: Mon, 28 Aug 2006 12:03:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miles Lane" <miles.lane@gmail.com>
Cc: "David Miller" <davem@davemloft.net>, "Dan Williams" <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jeremy@goop.org,
       Robert Love <rml@novell.com>
Subject: Re: 2.6.18-rc4-mm[1,2,3] -- Network card not getting assigned an
 "eth" device name
Message-Id: <20060828120328.ae734de0.akpm@osdl.org>
In-Reply-To: <a44ae5cd0608280852p50e72241vff8e3ae101e94185@mail.gmail.com>
References: <a44ae5cd0608270007gc6a919fx9e36562d8023635d@mail.gmail.com>
	<20060827001943.c559d37d.akpm@osdl.org>
	<20060827.003800.95504796.davem@davemloft.net>
	<a44ae5cd0608280852p50e72241vff8e3ae101e94185@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 08:52:02 -0700
"Miles Lane" <miles.lane@gmail.com> wrote:

> On 8/27/06, David Miller <davem@davemloft.net> wrote:
> > From: Andrew Morton <akpm@osdl.org>
> > Date: Sun, 27 Aug 2006 00:19:43 -0700
> >
> > > Jeremy reported that a while back too.  I do not know what is causing it
> > > and as far as I know no net developers have yet looked into it.
> >
> > A debugging patch like this one should help figure out the culprit.
> >
> > If we don't see the gibberish netdevice name printed in the kernel
> > logs, then likely something is corrupting the netdevice structure or
> > the memory holding the name.
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index d4a1ec3..45f9b19 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -738,6 +738,11 @@ int dev_change_name(struct net_device *d
> >
> >         if (!dev_valid_name(newname))
> >                 return -EINVAL;
> > +#if 1
> > +       printk("[%s:%d]: Changing netdevice name from [%s] to [%s]\n",
> > +              current->comm, current->pid,
> > +              dev->name, newname);
> > +#endif
> >
> >         if (strchr(newname, '%')) {
> >                 err = dev_alloc_name(dev, newname);
> >
> 
> Dan, do you have any idea why NetworkManager from Ubuntu 6.06.1
> would be corrupting network device names on recent MM kernels?
> I haven't seen this happening with Ubuntu's kernels.  If you like, I can
> send you my kernel .config file.
> 
> Here's what I get:
> 

grepping for `ioctl' gives:

ioctl(9, SIOCGIWNAME, 0xbfe38d8c)                 = -1 EINVAL (Invalid argument)
ioctl(9, SIOCETHTOOL, 0xbfe38d2c)                 = 0
ioctl(11, SIOCGIFHWADDR, {ifr_name="eth0", ???})  = -1 ENODEV (No such device)
ioctl(11, SIOCGIFFLAGS, {ifr_name="eth0", ???})   = -1 ENODEV (No such device)

Perhaps you could generate the strace output for 2.6.18-rc5, grep that for
ioctl, look for differences?  That initial SIOCGIWNAME failure is fishy.
