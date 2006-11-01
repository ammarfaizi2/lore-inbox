Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992799AbWKAT5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992799AbWKAT5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992796AbWKAT5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:57:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992789AbWKAT5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:57:14 -0500
Date: Wed, 1 Nov 2006 11:52:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Ernst Herzberg <earny@net4u.de>,
       Len Brown <lenb@kernel.org>, Adrian Bunk <bunk@stusta.de>,
       Hugh Dickins <hugh@veritas.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>
Subject: Re: 2.6.19-rc <-> ThinkPads
In-Reply-To: <200611012034.06128.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0611011148130.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
 <200611011825.47710.ak@suse.de> <Pine.LNX.4.64.0611011003270.25218@g5.osdl.org>
 <200611012034.06128.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Nov 2006, Andi Kleen wrote:
> 
> Fix race in IO-APIC routing entry setup.
> 
> Interrupt could happen between setting the IO-APIC entry
> and setting its interrupt data.

This doesn't fix anything at all.

The interrupt can come in on another CPU, and if we end up having an 
affinity change due to that, we then have "set_ioapic_affinity_irq()" 
called on that other irq, and it might get to mess with the cpumask 
because we dropped the ioapic_lock.

In other words, the problem is not that interrupts were re-enabled, the 
problem is literally that the locking is _wrong_. 

It's a small window, but we simply should not release the ioapic_lock in 
between setting the routing and doing the "set_native_irq_info()" call.

So I think doing the locking inside "ioapic_write_entry()" is simply 
fundamentally wrong. When you did the cleanup, your commit message talked 
about how it might add a few more lock/unlock things:

    In a few cases the IO APIC lock is taken more often now, but this
    isn't a problem because it's all initialization/shutdown only
    slow path code.

but the point is, this is not about "performance". It's about 
_correctness_.

			Linus
