Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTFYBT7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 21:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTFYBTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 21:19:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47879 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264432AbTFYBR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 21:17:29 -0400
Date: Tue, 24 Jun 2003 18:31:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>, <macro@ds2.pg.gda.pl>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] unexpected IO-APIC update
In-Reply-To: <20030624161003.20fbbbd4.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0306241825280.1041-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jun 2003, Randy.Dunlap wrote:
>
> +	if (reg_01.version >= 0x20)
> +		*(int *)&reg_03 = io_apic_read(apic, 3);

There's a lot of these 

	*(int *)&reg_03

kinds of things there, and the fact is, gcc's alias analysis doesn't like 
them, _and_ they are ugly.

The alias analysis I could care less about, since a good alias analysis
would take static address information into account, and gcc at least last
time I looked wasn't. So we don't even bother using it for now.

We may want to reconsider that eventually, though, since more recent
versions of gcc at least try to make their alias analysis useful with
things like "attribute((may_alias))"  or whatever the syntax was.

But the ugliness part I care about, and I wonder if it wouldn't be better 
in this case to just make the register definition a "union", and have 
something like

	union reg_03 {
		u32 value;
		struct {
			u32 boot_DT:1,
			    reserved:31;
		} bits;
	};

and then you can avoid the ugly dereference/cast/address-of thing, and 
just say

	reg_03.value

or

	reg_03.bits.boot_DT

which looks a lot cleaner.

This is what unions are _designed_ for.

		Linus

