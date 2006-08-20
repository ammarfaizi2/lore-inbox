Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWHTKQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWHTKQG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 06:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWHTKQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 06:16:06 -0400
Received: from 1wt.eu ([62.212.114.60]:45584 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750710AbWHTKQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 06:16:03 -0400
Date: Sun, 20 Aug 2006 12:15:28 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andi Kleen <ak@suse.de>
Cc: Solar Designer <solar@openwall.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] getsockopt() early argument sanity checking
Message-ID: <20060820101528.GE602@1wt.eu>
References: <20060819230532.GA16442@openwall.com> <200608201034.43588.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608201034.43588.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 10:34:43AM +0200, Andi Kleen wrote:
> On Sunday 20 August 2006 01:05, Solar Designer wrote:
> > I propose the attached patch (extracted from 2.4.33-ow1) for inclusion
> > into 2.4.34-pre.
> > 
> > (2.6 kernels could benefit from the same change, too, but at the moment
> > I am dealing with proper submission of generic changes like this that
> > are a part of 2.4.33-ow1.)
> 
> In general I don't think it makes sense to submit stuff for 2.4 
> that isn't in 2.6.

I generally agree with you on this, but I think that when they are just
preventive measures, they can be applied in whatever order, provided that
they don't get lost.

> > The patch makes getsockopt(2) sanity-check the value pointed to by
> > the optlen argument early on.  This is a security hardening measure
> > intended to prevent exploitation of certain potential vulnerabilities in
> > socket type specific getsockopt() code on UP systems.
> 
> It's not only insufficient on SMP, but even on UP where a thread
> can sleep in get_user and another one can run in this time.

Valid point.

> Doing a check that is inherently racy everywhere doesn't seem like
> a security improvement to me. If there is really a length checking bug somewhere 
> it needs to be fixed in a race-free way.

The only race-free solution would be to add an argument to all getsockopt()
functions and pass them the decoded value. There are other places where
multiple get_user() are performed on optlen, with some useless tests (eg
in net/ipv4/tcp.c, len is checked for <0 after having been compared to
sizeof(int) as unsigned int) and all those places would benefit from this.

But I don't want to induce such large changes in this kernel. The goal of
this test is a preventive measure to catch easily exploitable errors that
might have remained undetected. For instance, a quick glance shows this
portion of code in net/ipv4/raw.c (both 2.4 and 2.6) :

static int raw_seticmpfilter(struct sock *sk, char *optval, int optlen)
{
        if (optlen > sizeof(struct icmp_filter))
                optlen = sizeof(struct icmp_filter);
        if (copy_from_user(&sk->tp_pinfo.tp_raw4.filter, optval, optlen))
                return -EFAULT;
        return 0;
}

It only relies on sock_setsockopt() refusing optlen values < sizeof(int),
and this is not documented. Having part of this code being copied for use
in another code path would open a breach for optlen < 0.

> If not then there is no need for a change.

There are two tests in this patch :

  - one on the validity of the optlen address. This one is race-free and
    should be conserved anyway.

  - one on the optlen range which is valid for most cases but which is
    subject to a race condition and which might be circumvented by
    carefully written code and with some luck as in all race conditions
    issues.

Some will say that this last one offers a first level of protection by
transforming determinist attacks into racy attacks which make potential
vulnerabilities much harder to exploit by code injection. I'm one of them.

Others will consider it totally useless because it does not cover all cases,
but I think it is against the general principle of precaution we try to
apply in security.

> -Andi

Regards,
Willy

