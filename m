Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTFFV1q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTFFV1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 17:27:46 -0400
Received: from [63.205.85.133] ([63.205.85.133]:27602 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262290AbTFFV1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 17:27:37 -0400
Date: Fri, 6 Jun 2003 14:43:17 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Werner Almesberger <wa@almesberger.net>
Cc: "David S. Miller" <davem@redhat.com>, chas@cmf.nrl.navy.mil,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606214317.GD21217@gaz.sfgoth.com>
References: <20030606121339.A3232@almesberger.net> <20030606.081618.108808702.davem@redhat.com> <20030606122616.B3232@almesberger.net> <20030606.082802.124082825.davem@redhat.com> <20030606125416.C3232@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606125416.C3232@almesberger.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> (It's different in the case of
> SVCs, but they're managed by a user space demon. Besides, if
> their device goes away, they die too.)

Yes, in theory it would be nice to have SVCs be able to reroute between
interfaces, but we certainly don't have the infrastructure to do that now
(and I doubt that they'll ever be a significant enough push to demand its
development)  To do that you'd need the kernel to look like a simple
ATM switch and have atmsigd speak NNI to its neighbors (didn't someone have
some code for this WAY back in the dark ages... but it had some unfortunate
license issues... or am I remembering wrong?)

You still would have the the userspace-visible vcc pinned to a ATM device
but it would just be a pseudo-device managed by the virtual switch.  Then
the switch would take care of how to route the SVC.

So in short I agree with you that the current method is best - it makes
no operational sense to deactivate an ATM interface while there are still
open VCs.  Since VCs are intrinsically bound to a {dev,vpi,vci} tuple from
userlands perspective they would be uselss if their dev disappeared (even
if it reappeared later).

One thing I WOULD like to see is way to do something like "ifconfig up/down"
on ATM devices (once the VCs are all down) instead of having all of the
ATM cards with drivers automatically considered "up" like we currently do.
Some types of interfaces (esp *DSL) have rather complicated procedures for
setting up the interface and it would be nice to be able to control this
explicitly.  It'd be really useful to have a third state called "auto"
which would bring it up when the first VCC is opened and down when the last
is closed.  Not only would this be great for DSL (since it would establish
the DSL connection automatically when you run pppd or whatever) but it
would be a sane "least surprise" default.

[Very vaguely related - it would also be nice to have a per-itf flag to
require CAP_NET_BIND_SERVICE for all VCCs instead of just "vpi==0 &&
vci<ATM_NOT_RSV_VCI".  In 99% of deployments there aren't any ATM-native
apps running so you don't want users establishing random ATM vcs]

-Mitch
