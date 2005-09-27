Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVI0FXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVI0FXy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 01:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVI0FXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 01:23:54 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:6508 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964815AbVI0FXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 01:23:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=hmiBSKkVhHJEMKeuR04YvtL4gcWcV85Q6VWM1Znp44qX6pa8snfE9sNrOA4B65qH37tCW6GDdrVp5lilGtChigF+dGZQsRcfy+QLQILTF37ssniTCnl/tlaFq5jYHsz2nPryK2NO8n1xRRfaHj+bdFVZD41v2YbgWMJ9m8RybII=
Date: Tue, 27 Sep 2005 01:24:44 -0400
From: Florin Malita <fmalita@gmail.com>
To: Jay Vosburgh <fubar@us.ibm.com>
Cc: nsxfreddy@gmail.com, akpm@osdl.org, davem@davemloft.net,
       ctindel@users.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, bonding-devel@lists.sourceforge.net
Subject: Re: [PATCH] channel bonding: add support for device-indexed
 parameters
Message-Id: <20050927012444.be5d5311.fmalita@gmail.com>
In-Reply-To: <200509262358.j8QNwM8N012009@death.nxdomain.ibm.com>
References: <20050922091608.5ec2724c.fmalita@gmail.com>
	<200509262358.j8QNwM8N012009@death.nxdomain.ibm.com>
X-Mailer: Sylpheed version 2.1.2 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005 16:58:22 -0700
Jay Vosburgh <fubar@us.ibm.com> wrote:

> Florin Malita <fmalita@gmail.com> wrote:
> >IMHO the "primary" semantics are completely broken right now and this
> >is a possible fix for it.
> 
> 	The distro provided network init scripts are, as far as I know,
> really the main user of the bonding module parameters.  Right now, the
> init scripts will generally load the bonding module multiple times when
> creating multiple bonds with differing parameters.  This works tolerably
> well, although I recall that some users have run afoul of Fedora Core
> kernels that could or would not load any module multiple times.  I don't
> know if that's still the case today.

How can you load a module multiple times on _any_ distro?
More specifically, how exactly do you get past this check in module.c:
http://lxr.linux.no/source/kernel/module.c#L1534

         if (find_module(mod->name)) {
                 err = -EEXIST;
                 goto free_mod;
         }

That means there can only be one bonding instance => there's only one
"primary" parameter for all bonding devices => the semantics are broken.

eth0 \          eth2 \
      bond0           bond1
eth1 /          eth3 /

current semantics: modprobe bonding max_bonds=2 primary=eth0 ...
      => bond0(primary==eth0), bond1(primary==eth0)(!!!)

new/patch semantics: modprobe bonding max_bonds=2 primary=eth0,eth2 ...
      => bond0(primary==eth0), bond1(primary==eth2)

Currently it's impossible to implement multiple
prioritized active/backup bonds - or am I missing something?

> 	In any event, your patch does not provide enough flexibility to
> allow the distro scripts to switch to it (it omits arp_ip_target), so
> the init scripts will be unable to switch.

The patch is not forcing the scripts to switch since the old syntax/ABI
still works (one reason I didn't touch arp_ip_target was to preserve
that). It's simply providing an additional (saner) approach to bonding
configuration which can easily co-exist with the sysfs solution.

> I'm not sure I see the real value.

I'm not sure I see the real value in bonding _without_ the capabilities
provided by this patch 8)

Not being able to set a (different) preferred
interface/primary for each bond device makes it unacceptable for
deployment in our environment.

Florin
