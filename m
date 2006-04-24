Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWDXT0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWDXT0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWDXT0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:26:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55943 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751104AbWDXT0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:26:01 -0400
Date: Mon, 24 Apr 2006 12:25:57 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
Message-ID: <20060424122557.1b8c6054@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
	<Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2006 12:02:47 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Mon, 24 Apr 2006, Stephen Hemminger wrote:
> >
> > We should fail request_irq() if the SA_SHIRQ but the irq is edge-triggered.
> 
> That would be HORRIBLE.
> 
> Edge-triggered works perfectly fine for SA_SHIRQ, as long as there is just 
> one user and the driver is properly written. Making request_irq() fail 
> would break existing and working setups.

Couldn't we at least warn. Because you will loose irq's if two devices
are sharing an edge triggered irq. If A and B are sharing a edge triggered
IRQ; and both cause a transition, then when A clears it's IRQ the 
shared IRQ will disappear and B's IRQ will be lost.

> If you have a driver that requires level-triggered interrupts, then your 
> driver is arguably buggy. NAPI or no NAPI, doesn't matter. Edge-triggered 
> interrupts is a fact of life, and deciding that you don't like them is not 
> an excuse for saying "they should not work".

Driver's need to be able to depend on not losing interrupts.

> You can get an edge by having your driver make sure that it clears the 
> interrupt source at some point where it requires an edge.

The problem is that IRQ system doesn't tell the driver the trigger status.
If the driver knew that the IRQ was edge triggered, it could do
the necessary workaround.

> For a driver writer, there is one rule above _all_ other rules:
> 
> 	"Reality sucks, deal with it"
> 
> That rule is inviolate, and no amount of "I wish", and "it _should_ work 
> this way" or "..but the documentation says" matters at all.

The kernel should make the driver writer's problems easier not harder.
