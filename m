Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWDXTC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWDXTC6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWDXTC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:02:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7297 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751067AbWDXTC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:02:58 -0400
Date: Mon, 24 Apr 2006 12:02:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
In-Reply-To: <20060424114105.113eecac@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Apr 2006, Stephen Hemminger wrote:
>
> We should fail request_irq() if the SA_SHIRQ but the irq is edge-triggered.

That would be HORRIBLE.

Edge-triggered works perfectly fine for SA_SHIRQ, as long as there is just 
one user and the driver is properly written. Making request_irq() fail 
would break existing and working setups.

If you have a driver that requires level-triggered interrupts, then your 
driver is arguably buggy. NAPI or no NAPI, doesn't matter. Edge-triggered 
interrupts is a fact of life, and deciding that you don't like them is not 
an excuse for saying "they should not work".

You can get an edge by having your driver make sure that it clears the 
interrupt source at some point where it requires an edge.

And yes, that may mean that when you're ready to start taking interrupts 
again, you are required to first read all pending packets, instead of just 
assuming that a level-triggered interrupt will "just happen", but that's 
the harsh reality for writing a driver that actually WORKS.

For a driver writer, there is one rule above _all_ other rules:

	"Reality sucks, deal with it"

That rule is inviolate, and no amount of "I wish", and "it _should_ work 
this way" or "..but the documentation says" matters at all.

If you can't take that rule, don't write drivers, and don't design 
infrastructure for them.

		Linus
