Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVHHRmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVHHRmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVHHRmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:42:37 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:9398 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932148AbVHHRmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:42:36 -0400
Message-ID: <42F7998D.8030606@zabbo.net>
Date: Mon, 08 Aug 2005 10:42:37 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Kristen Accardi <kristen.c.accardi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 6700/6702PXH quirk
References: <1123259263.8917.9.camel@whizzy> <20050805183505.GA32405@kroah.com> <1123279513.4706.7.camel@whizzy> <20050805225712.GD3782@kroah.com> <20050806033455.GA23679@havoc.gtf.org>
In-Reply-To: <20050806033455.GA23679@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> <pedantic>
> 
> FWIW, compilers generate AWFUL code for bitfields.  Bitfields are
> really tough to do optimally, whereas bit flags ["unsigned int flags &
> bitmask"] are the familiar ints and longs that the compiler is well
> tuned to optimize.

I wouldn't have chosen the micro-optimization argument against bitfields
because people who use them as booleans will be more than willing to
trade minuscule performance degredation in non-critical paths for
heaping piles of legibility:

	if (!foo->enabled)
	if (!(foo->flags & FOO_FLAG_ENABLED)

No, I would have chosen the maintenance risk of forgetting that they're
really 1 bit wide scalars which truncate on assignment.

	struct foo {
		unsigned enabled:1;
	};

	int some_thing_is_enabled(thing) {
		return thing->whatever & some_high_bit;
	}

	foo->enabled = some_thing_is_enabled()

Requiring people to remember that they want !!() around assignments
seems much more dangerous.  They'll get left out to "optimize" current
behaviour, leaving land mines in the tree for future maintainers.

- z
