Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937007AbWLFSFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937007AbWLFSFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937016AbWLFSFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:05:20 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35567
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S936985AbWLFSFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:05:19 -0500
Date: Wed, 06 Dec 2006 10:05:28 -0800 (PST)
Message-Id: <20061206.100528.75760584.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: jblunck@suse.de, phil_arcwk_endecott@chezphil.org,
       linux-kernel@vger.kernel.org
Subject: Re: Subtleties of __attribute__((packed))
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061206175423.GA9959@flint.arm.linux.org.uk>
References: <1165418558832@dmwebmail.belize.chezphil.org>
	<20061206155439.GA6727@hasse.suse.de>
	<20061206175423.GA9959@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Wed, 6 Dec 2006 17:54:23 +0000

> It does not say "and as such the struct may be aligned to any alignment".

Consider the implication for arrays and pointer arithmetic, it's just
a logical consequence, that's all.  It's why the alignment cannot be
assumed for packed structures.

If you have, for example:

struct example {
	char b;
	short c;
} __attribute__((packed));

And I give you:

extern void foo(struct example *p);

and go:

	foo(p + 1);

It is clear that the compiler must assume that all instances
of a packed structure are not necessarily aligned properly.

Even if "p" is aligned, "p + 1" definitely won't be.  And this
goes for any array indexing of the given packed structure.

That's why every pointer to such a struct must be assumed to be
unaligned in these cases.

So even though the documentation may not say this explicitly, it's an
implicit logical side effect of packed structures.
