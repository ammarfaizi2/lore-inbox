Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTI3Ohx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbTI3Ohx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:37:53 -0400
Received: from thunk.org ([140.239.227.29]:31659 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261539AbTI3Oht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:37:49 -0400
Date: Tue, 30 Sep 2003 10:21:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "David S. Miller" <davem@redhat.com>, bunk@fs.tum.de,
       acme@conectiva.com.br, netdev@oss.sgi.com, pekkas@netcore.fi,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-ID: <20030930142154.GA28501@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	David Woodhouse <dwmw2@infradead.org>,
	"David S. Miller" <davem@redhat.com>, bunk@fs.tum.de,
	acme@conectiva.com.br, netdev@oss.sgi.com, pekkas@netcore.fi,
	lksctp-developers@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20030928225941.GW15338@fs.tum.de> <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de> <20030929220916.19c9c90d.davem@redhat.com> <1064903562.6154.160.camel@imladris.demon.co.uk> <20030930000302.3e1bf8bb.davem@redhat.com> <1064907572.21551.31.camel@hades.cambridge.redhat.com> <20030930010855.095c2c35.davem@redhat.com> <1064910398.21551.41.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064910398.21551.41.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 09:26:38AM +0100, David Woodhouse wrote:
> > The suggestions I see do nothing to enhance the kernel tree as it currently
> > stands.  If you wish to prevent the kernel image from changing due to
> > out-of-tree modules being built, fine, but don't impose this restriction
> > upon in-kernel modules.
> 
> It's a matter of taste. As I said, it's your right to disagree.
> 
> Some time during 2.7 I'm sure one of the many people who agree with
> Adrian and myself will send patches to Linus and he'll get to arbitrate.


FWIW, I agree with Dave.  Most of the time, enabling a device driver
won't cause the core kernel to change, sure.  

However, there will be cases (such as enabling wireless ethernet
drivers as modules, for example) where in order to support those
modules, some new core kernel infrastructure will need to be enabled.

Now, there are a couple of ways ways you can handle this.  One is that
the core infrastructure could have its own CONFIG_infrastructure
boolean, and if that symbol is 'no', then you won't be able to build
those modules until you recompile the base kernel with
CONFIG_infrastructure.  Another is that you can make enabling any one
of the device driver modules "automatically" enable inclusion of the
base core infrastructure.

It then all boils down to tradeoffs and aesthetics.  By making
CONFIG_infrastructure explicit, it makes it more clear what is going
on --- but if it is defaulted on, or if you require that whatever is
under the CONFIG_infrastructure ifdef is always compiled in, then that
way leads to kernel boot.  But if it is defaulted off, then the user
will be forced to recompile the kernel anyway, before he/she can
enable the kernel module in question.  Including CONFIG_infrastructure
explicitly also makes the kernel build process more complex, and can
also make life more confusing to the user --- the question about
whether or not you can build a particular device driver won't even
appear until the user enables CONFIG_infrastructure, and the user may
have a really hard time figuring out that CONFIG_infrastructure is the
way to make a particular device driver appear.

For that reason, I tend to prefer the approach of simply enabling a
device driver, and then letting that force a change in the base kernel
to include any necessary base infrastructure in the kernel if
necessary.  It's simpler from a configuration perspective.  And if the
user types "make modules" after making such a change, ideally the
build system should warn the user that it will be necessary to rebuild
the base kernel before it can build the module.

						- Ted
