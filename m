Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTKYC0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 21:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTKYC0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 21:26:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:21943 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261892AbTKYC0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 21:26:23 -0500
Date: Mon, 24 Nov 2003 18:24:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: jt@hpl.hp.com
cc: linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Pavel Roskin <proski@gnu.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
In-Reply-To: <Pine.LNX.4.58.0311241759470.1599@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0311241819030.1599@home.osdl.org>
References: <20031124235727.GA2467@bougret.hpl.hp.com>
 <Pine.LNX.4.58.0311241759470.1599@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Nov 2003, Linus Torvalds wrote:
>
> We don't ever try to autoprobe for PCI interrupts, because it's fragile
> and tends to cause lockups on any hardware where the irq is shared with
> something else

Side note as way of explanation: autoprobing for ISA interrupts only works
because they are edge-triggered, so even if they are shared - which is
against the ISA spec, but commonly done anyway - the autoprobe would just
fail, not lock up the machine.

PCI interrupts are not only _routinely_ shared (making them fundamentally
harder to probe for), but they are level-triggered, so if you don't shut
them off in the interrupt handler, you end up with a dead machine that
constantly takes interrupts.

These days, our improved irq handler infrastructure could actually pick
out the shared interrupts from the probed ones (now that drivers return a
status word saying whether the irq was for an existing driver or not), so
we could some day allow even PCI drivers to autodetect the irq if
everything else fails.

But it's _very_ rare to see it fail. The 2.4.x cardbus driver does the
same thing, and I don't know of any consistent failure patterns. What kind
of strange machine is this, Jean? Prototype with a broken BIOS?

		Linus
