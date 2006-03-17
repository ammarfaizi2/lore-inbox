Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932817AbWCQW6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932817AbWCQW6K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 17:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932818AbWCQW6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 17:58:10 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:9265 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932817AbWCQW6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 17:58:08 -0500
X-IronPort-AV: i="4.03,106,1141632000"; 
   d="scan'208"; a="417334499:sNHT27203680"
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Remapping pages mapped to userspace
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
	<20060309163740.0b589ea4.akpm@osdl.org>
	<1142470579.6994.78.camel@localhost.localdomain>
	<ada3bhjuph2.fsf@cisco.com>
	<1142475069.6994.114.camel@localhost.localdomain>
	<adaslpjt8rg.fsf@cisco.com>
	<1142477579.6994.124.camel@localhost.localdomain>
	<20060315192813.71a5d31a.akpm@osdl.org>
	<1142485103.25297.13.camel@camp4.serpentine.com>
	<20060315213813.747b5967.akpm@osdl.org>
	<Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
	<adad5gmne20.fsf_-_@cisco.com>
	<Pine.LNX.4.61.0603171631240.32660@goblin.wat.veritas.com>
	<1142615848.28538.53.camel@serpentine.pathscale.com>
	<Pine.LNX.4.64.0603170921470.3618@g5.osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 17 Mar 2006 14:58:06 -0800
In-Reply-To: <Pine.LNX.4.64.0603170921470.3618@g5.osdl.org> (Linus Torvalds's message of "Fri, 17 Mar 2006 09:30:26 -0800 (PST)")
Message-ID: <adak6ashe69.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Mar 2006 22:58:06.0858 (UTC) FILETIME=[4119BEA0:01C64A16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Linus> Generally, replacing the mmap with an anonymous zero-mapped
    Linus> mapping would be a horribly bad idea.

    Linus> The fact is, you can't avoid the race of seeing the removed
    Linus> state (which _usually_ means that you will read 0xffffffff
    Linus> from the bus - normal PC's won't result in bus errors
    Linus> etc). Whatever the kernel does, it can do only after the
    Linus> device has already been removed - we no longer live in a
    Linus> world where the administrator can tell the system
    Linus> before-hand that something will go away.

    Linus> Replacing the MMIO map with a zero map would be absolutely
    Linus> horrible. It would be inconsistent, and not even help the
    Linus> fact that the user will haev seen the removed state.

    Linus> In fact, I think even "revert" is pretty useless. You're
    Linus> much better off just sending a perfectly good signal -
    Linus> something that the app will get regardless of whether it
    Linus> reads the MMIO space at that point in time or not. After
    Linus> all, the only thing the "revert" would really do is to send
    Linus> a signal, but then only if the user is trying to access the
    Linus> device.

Hmm, you're probably right for the hot unplug case.  However, there
are a couple of other related situations I've thought of in this context:

 - Module remove: userspace has PCI memory mmap()ed.  The module is
   removed.  Userspace still has access to PCI memory.  And if the
   module is reloaded, userspace still has access to the device that
   the driver doesn't know about, so the driver may hand off the same
   access to another process.

   The obvious solution here is to just take a module reference when
   userspace mmap()s the device.  However unprivileged processes can
   get direct access to IB devices, and it may not be so nice for
   unprivileged processes to be able to hold off module removal.

 - PCI error recovery (or internal device error recovery): if the
   driver detects a problem with the PCI bus or device, it might have
   to reset the device.  The most natural way to model this is as hot
   unplug followed by hot plug.  However we don't want userspace
   processes to keep their BAR mapping across the device reset,
   because the device is probably not set up to handle it right after reset.

   Really in this case at least, revoking an mmap() seems the cleanest
   solution to me.

Any further thoughts?

Thanks,
  Roland
