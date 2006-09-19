Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752026AbWISDxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbWISDxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 23:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbWISDxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 23:53:44 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:41115 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752023AbWISDxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 23:53:43 -0400
Message-ID: <450F69C3.8060603@garzik.org>
Date: Mon, 18 Sep 2006 23:53:39 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: "Robin H. Johnson" <robbat2@gentoo.org>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org> <20060914205050.GE27531@curie-int.orbis-terrarum.net> <20060916203812.GC30391@curie-int.orbis-terrarum.net> <20060916210857.GD30391@curie-int.orbis-terrarum.net> <20060917074929.GD25800@htj.dyndns.org> <20060918034826.GA10116@curie-int.orbis-terrarum.net> <450E13D4.10200@gmail.com>
In-Reply-To: <450E13D4.10200@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Jeff, we've been ignoring PI in ahci_host_init()...
> 
>     for (i = 0; i < probe_ent->n_ports; i++) {
> #if 0 /* BIOSen initialize this incorrectly */
>         if (!(hpriv->port_map & (1 << i)))
>             continue;
> #endif
> 
> The comment suggests that some BIOSen initialize PI incorrectly which 
> will probably result in undetected ports.  Is this true?  Would it be 
> dangerous to honor PI on some controllers?  If so, PI should be used 
> only for controllers which does non-linear port mapping.


The core problem is that this register is write-once after reset, i.e. 
BIOS-initialized.  And my experience with pre-production machines has 
been that after reset _by the driver_, the register was useless until 
initialized to a value... _by the driver_.  Which defeats the purpose of 
the register.

So the info contained in the register is quite useful -- when info is 
contained in the register.  :)

Now, granted, I have only seen this on pre-production machines, hence 
the #if 0.  But also, since the code has been disabled in production, we 
don't know how effective it is across all platforms, and we _do_ know 
that it is ineffective if used directly after a reset.  The write-once 
behavior is documented, and normal.

We can't really know which controllers have a non-linear port mapping, 
because that is dependent on both the silicon and whether or not the 
chip is connected to port X[0-31].  The BIOS knows this, of course :)

We can try to enable the code, but I worry that it will fail in 
situations such as kexec.

	Jeff


