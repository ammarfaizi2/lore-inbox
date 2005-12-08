Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVLHLck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVLHLck (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 06:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbVLHLck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 06:32:40 -0500
Received: from styx.suse.cz ([82.119.242.94]:1499 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750923AbVLHLcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 06:32:39 -0500
Date: Thu, 8 Dec 2005 12:32:37 +0100
From: Jiri Benc <jbenc@suse.cz>
To: Michael Buesch <mbuesch@freenet.de>
Cc: "David S. Miller" <davem@davemloft.net>, davej@redhat.com,
       jgarzik@pobox.com, josejx@gentoo.org, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       laforge@gnumonks.org, Michael Renzmann <netdev@nospam.otaku42.de>,
       Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051208123237.61367a27@griffin.suse.cz>
In-Reply-To: <200512071434.23706.mbuesch@freenet.de>
References: <4394902C.8060100@pobox.com>
	<20051206151046.GF4038@rama.exocore.com>
	<20051206.151919.72043193.davem@davemloft.net>
	<200512071434.23706.mbuesch@freenet.de>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005 14:34:22 +0100, Michael Buesch wrote:
> I agree with you, and that is exactly what we are doing:
> We take the existing code and add functionality to it. If the
> added functionality is an external module, well, consinder this
> as an extra cookie for devices which do not need MAC handling.

I understand why you are trying to implement "softmac" as a separate
module. But please take a look at following:

1. Fragmentation. Almost every driver (the exception are devices which
do fragmentation in their firmware) needs to pass fragments to the
device one by one. To handle it effectively, you need fragments to be
passed to your hard_start_xmit sequentially (and not all at once). This
is of course solvable by a separate softmac module, if you implement it
as a layer between ieee80211 and a driver.

2. Devices capable to associate with multiple networks. Such a device
needs to be presented to userspace as several network devices. Again, it
is solvable by a separate softmac module, but you need softmac to be
something like a "proxy" for drivers (because you don't want to deal
with multiple net_devices in the driver).

3. WDS. This is nearly the same as above, but in addition you need a
different code for building 802.11 headers. So this will be built on top
of ieee80211 (because you want to use statistics gathering and so) but
at the same time you will have to reimplement the code responsible for
frame encapsulation in a softmac module. Or, you can add the support for
WDS directly to ieee80211, but then you will add the code for handling
of multiple devices there as well.

4. Access point mode. There is a lot of code needed for AP mode support.
It can be easily implemented in softmac module. But that code will be
used even by drivers for devices with complicated firmware (think about
communication with an userspace AP daemon which won't be easy and should
be consistent among drivers). So in the end (we want AP mode working for
all devices supporting it, don't we?) only a few drivers won't use
softmac module.

Those above are some reasons why I prefer complete 802.11 stack to be in
ieee80211 module. Maybe I'm wrong (and I will be more than happy to
advocate the separate softmac module if it turns out that I'm wrong),
but I'm thinking this way:

- If AP, WDS and so on is implemented in a softmac module, only a very
small amount of drivers won't use that module.

- Such softmac module needs to be implemented as a layer between
ieee80211 and a driver. This will lead to code duplication and will be
less effective.

- If AP, WDS and so on is implemented in ieee80211 module, softmac
module will be very tiny (especially compared to ieee80211 module) and
it is not worth effort to implement it as a separate module.

- (Not a strong argument) Most of drivers will use "softmac" anyway
(it's more than a half of drivers as somebody mentioned earlier).

Please, could you send your opinions to this issues and how to solve
them the best way? It seems that many people agree that separate softmac
module is the way to go, so I'm probably wrong with my conclusions. 

Thanks,

-- 
Jiri Benc
SUSE Labs
