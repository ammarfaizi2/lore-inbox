Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbUIJAWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUIJAWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbUIJAWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:22:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:51855 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266310AbUIJAVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:21:38 -0400
Date: Thu, 9 Sep 2004 17:21:35 -0700
From: Chris Wright <chrisw@osdl.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] update: _working_ code to add device+inode check to ipt_owner.c
Message-ID: <20040909172134.G1924@build.pdx.osdl.net>
References: <20040909162200.GB9456@lkcl.net> <20040909091931.K1973@build.pdx.osdl.net> <20040909181034.GF10046@lkcl.net> <20040909114846.V1924@build.pdx.osdl.net> <20040909212514.GA10892@lkcl.net> <20040909160449.E1924@build.pdx.osdl.net> <20040910000819.GA7587@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040910000819.GA7587@lkcl.net>; from lkcl@lkcl.net on Fri, Sep 10, 2004 at 01:08:19AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Luke Kenneth Casson Leighton (lkcl@lkcl.net) wrote:
>  i am not so worried about this scenario _because_:
> 
>  under an selinux system, you would set up a policy which only
>  allowed the good_proc to exec other_good_procs (with the
>  macro can_exec(good_proc, { other_good_proc1, other_good_proc2 })

OK, good.  Although, this does not help xinetd, so we're still trusting
that code.

>  consequently, you'd design your firewall rules (in conjunction with
>  your selinux policy) to add _two_ dev+inode-program-enabled firewall rules
>  to cover the same socket, e.g. apache2 (good_proc) and some cgi script
>  helper (other_good_proc) - one for each program:
> 
> 	 iptables -A INPUT -m tcp --dport=80 -m program --exe=/usr/bin/apache2 -j ACCEPT
> 
>  and:
> 
> 	 iptables -A INPUT -m tcp --dport=80 -m program --exe=/usr/cgi-bin/blahblah -j ACCEPT

Isn't this likely to be in modcgi/modperl/etc instead of fork/exec'd?
This is one specific example (which SELinux doesn't support, so it's
moot there) where changing security domains during execution would
confuse these rules.  E.g. reducing to a more restrictive domain while
executing cgi-scripts.

> > >  so it's a socket: let's take an example - and i'm assuming for now
> > >  that things like passing file descriptors over unix-domain-sockets
> > >  between processes just ... doesn't happen, okay? :)
> > 
> > These do happen, which is part of the problem ;-)
>  
>  i would not consider this to be a problem [in an environment where
>  you specify DENY as the default and ALLOW specific instances]
> 
>  under such circumstances [file descs passed between programs]...
>  you would end up having to create _two_ program-specific rules, like
>  above.
> 
>  one for each of the two programs.

Actually you wouldn't, just one.  It will match, then one of those
processes will get woken up and receive the data, regardless of whether
you meant to allow it.  So, having some security layer involved mediated
file desc passing clearly helps.  Point remains, any match will deliver
data to socket.  However, if socket is shared, it could be a different
process picking up data off of socket.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
