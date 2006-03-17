Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWCQRah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWCQRah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWCQRah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:30:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030225AbWCQRah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:30:37 -0500
Date: Fri, 17 Mar 2006 09:30:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: Hugh Dickins <hugh@veritas.com>, Roland Dreier <rdreier@cisco.com>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Remapping pages mapped to userspace (was: [PATCH 10 of 20] ipath
 - support for userspace apps using core driver)
In-Reply-To: <1142615848.28538.53.camel@serpentine.pathscale.com>
Message-ID: <Pine.LNX.4.64.0603170921470.3618@g5.osdl.org>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> 
 <ada4q27fban.fsf@cisco.com>  <1141948516.10693.55.camel@serpentine.pathscale.com>
  <ada1wxbdv7a.fsf@cisco.com>  <1141949262.10693.69.camel@serpentine.pathscale.com>
  <20060309163740.0b589ea4.akpm@osdl.org>  <1142470579.6994.78.camel@localhost.localdomain>
  <ada3bhjuph2.fsf@cisco.com>  <1142475069.6994.114.camel@localhost.localdomain>
  <adaslpjt8rg.fsf@cisco.com>  <1142477579.6994.124.camel@localhost.localdomain>
  <20060315192813.71a5d31a.akpm@osdl.org>  <1142485103.25297.13.camel@camp4.serpentine.com>
  <20060315213813.747b5967.akpm@osdl.org>  <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
  <adad5gmne20.fsf_-_@cisco.com>  <Pine.LNX.4.61.0603171631240.32660@goblin.wat.veritas.com>
 <1142615848.28538.53.camel@serpentine.pathscale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Mar 2006, Bryan O'Sullivan wrote:
> 
> It would be unfortunate if userspace were spinning on a chip register,
> waiting for the register to transition from zero to non-zero, and we
> replaced that mapping with an anonymous page.  In that case, userspace
> could potentially spin forever, having no way to detect the demise of
> the device.

Generally, replacing the mmap with an anonymous zero-mapped mapping would 
be a horribly bad idea.

The fact is, you can't avoid the race of seeing the removed state (which 
_usually_ means that you will read 0xffffffff from the bus - normal PC's 
won't result in bus errors etc). Whatever the kernel does, it can do only 
after the device has already been removed - we no longer live in a world 
where the administrator can tell the system before-hand that something 
will go away.

Replacing the MMIO map with a zero map would be absolutely horrible. It 
would be inconsistent, and not even help the fact that the user will haev 
seen the removed state.

In fact, I think even "revert" is pretty useless. You're much better off 
just sending a perfectly good signal - something that the app will get 
regardless of whether it reads the MMIO space at that point in time or 
not. After all, the only thing the "revert" would really do is to send a 
signal, but then only if the user is trying to access the device.

Anyway, zap_page_range() would do what you want, but it's not exported, 
and I'm not convinced it's even something we want to export. You can only 
zap a page range from within the context of the zappee, not from an 
external module/driver.

[ Maybe it works if somebody else calls it, maybe it doesn't. I wouldn't 
  bet on it, and more importantly, I can pretty much _guarantee_ that a 
  driver will get the "struct mm_struct" reference counting wrong. ]

		Linus
