Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWGMAkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWGMAkS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 20:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWGMAkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 20:40:18 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37357
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751481AbWGMAkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 20:40:17 -0400
Date: Wed, 12 Jul 2006 17:40:13 -0700 (PDT)
Message-Id: <20060712.174013.95062313.davem@davemloft.net>
To: rdreier@cisco.com
Cc: ralphc@pathscale.com, rolandd@cisco.com, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: Suggestions for how to remove bus_to_virt()
From: David Miller <davem@davemloft.net>
In-Reply-To: <adar70quzwx.fsf@cisco.com>
References: <1152746967.4572.263.camel@brick.pathscale.com>
	<adar70quzwx.fsf@cisco.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 12 Jul 2006 17:11:26 -0700

> A cleaner solution would be to make the dma_ API really use the device
> it's passed anyway, and allow drivers to override the standard PCI
> stuff nicely.  But that would be major surgery, I guess.

Clean but expensive, you should not force the rest of the kernel
to eat the cost of something you want to do when it's totally
unnecessary for most other users.

For example, x86 never needs to do anything other than a direct
virt_to_phys translation to produce a DMA address, no matter what
bus the device is on.  It's a single simple integer adjustment
that can be done inline in about 2 or 3 instructions at most.

Once you start allowing overrides then even x86 starts to eat the
stupid costs of dereferencing some kind of device ops method.

That doesn't make any sense, and that's why the DMA API works the way
it does now.  It's a platform or bus operation, not a device one.

If you need device level DMA mapping semantics, create them for your
device type.  This is what USB does, btw.


