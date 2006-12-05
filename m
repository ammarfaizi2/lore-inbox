Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967865AbWLEGJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967865AbWLEGJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 01:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968039AbWLEGJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 01:09:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:36370 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967865AbWLEGJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 01:09:29 -0500
Subject: Re: [PATCH 2/3] Import fw-ohci driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
       linux-kernel@vger.kernel.org,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <45750A89.7000802@garzik.org>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
	 <20061205052245.7213.39098.stgit@dinky.boston.redhat.com>
	 <45750A89.7000802@garzik.org>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 17:09:07 +1100
Message-Id: <1165298947.29784.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +struct descriptor {
> > +	u32 req_count:16;
> > +
> > +	u32 wait:2;
> > +	u32 branch:2;
> > +	u32 irq:2;
> > +	u32 yy:1;
> > +	u32 ping:1;
> > +
> > +	u32 key:3;
> > +	u32 status:1;
> > +	u32 command:4;
> > +
> > +	u32 data_address;
> > +	u32 branch_address;
> > +
> > +	u32 res_count:16;
> > +	u32 transfer_status:16;
> > +} __attribute__ ((aligned(16)));
> 
> you probably want __le32 annotations for sparse, right?

More than that... he wants no bitfields ! Right now, this code is broken
on some endians (I suspect big, dunno on what Kristian tested).

> 
> And for the last two fields, I bet that using the normal 'u16' type 
> (__le16?) would generate much better code than a bitfield:16 ever would.

Bah, it's endian broken anyway due to bitfield (ab)use.

> 	enum {
> 		constant1	= 1234,
> 		constant2	= 5678,
> 	};
> 
> for constants.  These actually have some type information attached by 
> the compiler, and they show up as symbols in the debugger since they are 
> not stripped out by the C pre-processor.

Note that while this is true for small constants, beware of the fact
that this is highly unrecommended for anything that doesn't fit in a
signed int. gcc has some dodgy extensions allowing non-int enums but you
don't want to go near them. Read a recent discussion with Linus & Viro
(a few days ago iirc) on lkml about it.

Since some of his constants have values up to 0x80000000, I'm not 100%
confident enum is the way to go, but if you are careful with sign, it
could still be.

> > +static void ar_context_run(struct ar_context *ctx)
> > +{
> > +	reg_write(ctx->ohci, ctx->command_ptr, ctx->descriptor_bus | 1);
> > +	reg_write(ctx->ohci, ctx->control_set, CONTEXT_RUN);
> 
> PCI posting?

In that specific case (kicking the context), it doesn't matter much.
It's not a bug per-se not to do it, though you might get better
performances by making sure it's kicked right away.

Ben.


