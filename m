Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266031AbUFPAQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266031AbUFPAQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 20:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbUFPAQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 20:16:49 -0400
Received: from click.bur.st ([203.34.17.217]:28186 "EHLO click.bur.st")
	by vger.kernel.org with ESMTP id S266031AbUFPAQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 20:16:36 -0400
Date: Wed, 16 Jun 2004 08:16:31 +0800
From: Trent Lloyd <lathiat@bur.st>
To: Bernd Eckenfels <be-mail2004@lina.inka.de>, 253590@bugs.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: Bug#253590: How to turn off IPV6 (link local)
Message-ID: <20040616001630.GB24753@thump.bur.st>
References: <20040614233215.GA10547@lina.inka.de> <20040615023022.GB24269@thump.bur.st> <20040615194657.GA7474@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615194657.GA7474@lina.inka.de>
User-Agent: Mutt/1.3.28i
X-Random-Number: -4.26778455125249e-67
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> > autoconf defines whether it will auto-configure an address if a router
> > advertises the IPv6 prefix for the network to it.
> 
> Yes, but the configure help tells me otherwise. Especially since there are
> two options (autoconfigure and accpet_ra) I dont think the current behavious
> is intended:

Ahh, i see, however you would have to set autoconf to off then *remove*
the link-local addresses, because they are setup before that variable is
changed? [or is there an option for this in the kernel? afaik its just
in proc (sysctl)]

That said, the link-local addresses are *NOT* the issue here, and having
them will not cause said problems, the problem here is the user has 4
real world IPv6 addresses configured by a router on his network + user
configuration (the 6to4 address).

> 
> autoconf - BOOLEAN
>         Configure link-local addresses using L2 hardware addresses.
> 
>         Default: TRUE
> 
> accept_ra - BOOLEAN
>         Accept Router Advertisements; autoconfigure using them.
> 
>         Functional default: enabled if local forwarding is disabled.
>                             disabled if local forwarding is enabled.
> 
> 
> So I think autoconf=0 should avoid  adding the 3ff8 link local  address (as
> well as lo ::1)

loopback will always be configured (like in ipv4)
3ff8 isnt link local, fe80 is.

> 
> > The issue is not having the link local address, because there is no
> > default route and hence the connection should fail.
> 
> No, please check the bug report. The problem with netscape is that it _does_
> fail and not fall back to ipv4. But I think for performance reasons, no ipv6
> application should actually try to contact destinations  which are not in
> the scope of the configured address (dont connect to sitelocal/global of only
> linklocal prefix is  configured)

They won't, it acts on routing, and netscape is also broken in not
falling back.

> > The problem, in the case of thi sbug, is that he has IPv6 configured,
> > but it is not working, 2001: is a real IPv6 address
> 
> That was the initial problem, but we have solved that by turning autoconf
> off. The last email was only with an fe80:: prefix.

Ah right, I didn't see that.

> 
> > Link-local address start with fe80:: and never have a default route so
> > they will not be a problem.
> 
> They are the problem, as you see above because the applications still
> prefers them over ipv4.

It will attempt to connect, yes, but it will do this whether you have
any addresses or not because binding a socket to AF_INET6 suceeds, in
this case netscape is just horrendously broken in not falling back and a
bug should be filed with that program.

> > You can't, but it is not the issue here, you could however not load the
> > module.
> 
> Yes, if it is a module. But see my comment above, I dont think the sysctl
> behaves as documented, and does not behave as expected.

> I can prepare a patch for this, if everybody  agrees. In addition to that, I
> would like to know how application and resolver can be fixed to not use
> incomplete or broken v6 setups (i.e. ignore link local prefix on  non local
> targets without trying to connect). 

Check out http://www.sixlabs.org/talks/, in my IPv6 programming talk I
have code showing how to use getaddrinfo() and try each address until
one suceeds.

Basically, when the application resolves and gets any number of IPv6 and
IPv4 addresses, it should try each in order until one works.

Sorry I mis-understood a little missing an email where you turned off
the global addresses.

If you need any more help, feel free to contact me privately (with
coding problems, etc), however I am limited in time and net access at
the moment so my replies may be a little delayed.

Happy hacking,
Trent
Sixlabs

--
Trent Lloyd <lathiat@bur.st>
Bur.st Networking Inc.
