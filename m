Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946645AbWKAGUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946645AbWKAGUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946642AbWKAGUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:20:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946640AbWKAGUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:20:45 -0500
Date: Tue, 31 Oct 2006 22:16:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Ernst Herzberg <earny@net4u.de>, Len Brown <lenb@kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Hugh Dickins <hugh@veritas.com>,
       Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.19-rc <-> ThinkPads
In-Reply-To: <20061101055435.GB4933@mellanox.co.il>
Message-ID: <Pine.LNX.4.64.0610312206390.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
 <20061101055435.GB4933@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Nov 2006, Michael S. Tsirkin wrote:
> 
> I've been bisecting ACPI/suspend thinkpad issue myself and I seem to get
> eea0e11c1f0d6ef89e64182b2f1223a4ca2b74a2 good,
> cf4c6a2f27f5db810b69dcb1da7f194489e8ff88 bad.

Very interesting..

That commit cf4c6a2f on the face of it looks like an obvious cleanup, but 
looking closer, it actually changes the order of the apic writes in many 
cases (high word first -> low word first).

It also does something else that looks really really wrong: it turns an 
atomic "update ioapic and set irq-info" into two separate events, where 
interrupts can happen in between. Same goes for resume (instead of 
atomically changing all entries with the ioapic lock held, it now does 
them individually, and locks them individually).

I wonder if the order matters more, though. Andi? We _used_ to write the 
high word first, and I think the order matters. The low word contains the 
enable bit, for example, so when enabling an interrupt, you should write 
the low word last, when you disable it you should write the low word 
first.

And that's exactly what we _used_ to do, and it's what that particular 
commit totally and utterly _broke_.

I think that commit should either be reverted, or the code should be fixed 
to do the writes in the proper order. 

I suspect reverting it is the right thing to do - the patch only 
introduces bugs, an doesn't actually _fix_ anything, it just "cleans 
things up".

Andi, you need to be a hell of a lot more careful! Apparently x86-64 is 
also totally broken in this regard, because somebody didn't realize that 
the ordering _matters_.

		Linus
