Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161385AbWATD2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161385AbWATD2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 22:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161476AbWATD2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 22:28:39 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:36057 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161385AbWATD2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 22:28:39 -0500
Subject: Re: [PATCH] bitmap: Support for pages > BITS_PER_LONG.
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Paul Jackson <pj@sgi.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, an Molton <spyro@f2s.com>, tony@atomide.com,
       jamey.hicks@hp.com, joshua@joshuawise.com, david-b@pacbell.net,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20060118191157.f653b09d.pj@sgi.com>
References: <20060119014812.GB18181@linux-sh.org>
	 <20060118191157.f653b09d.pj@sgi.com>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 21:28:30 -0600
Message-Id: <1137727710.3571.51.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 19:11 -0800, Paul Jackson wrote:
> Could you look Mundt's patch, and see if it looks ok?

Not being on lkml, this was harder than it sounds, but I eventually
found the actual patch on marc.  However, no, it doesn't look right.

This:

> +		/* find space in the bitmap */
> +		for (j = 0; j < span; j++)
> +			if ((bitmap[index + j] & (mask << offset))) {


Is wrong.  You're looking for an unset span of order bits at a given
offset.  So you get the byte offset for the first, then all the
following bitmap[n] need to be zero until you need to do an offset in
reverse for the last bit.  i.e. (assuming BITS_PER_LONG=32) for a span
of 126 at offset 1, you check

bitmap[0] & 0xfffffffe == 0
bitmap[1] & 0xffffffff == 0
bitmap[2] & 0xffffffff == 0
bitmap[3] & 0x7fffffff == 0

and so on.

> +				space = 0;
> +				break;
> +			}
> +
> +		/* keep looking */
> +		if (unlikely(!space))
> +			continue;
> +
> +		for (j = 0; j < span; j++)
> +			/* set region in bitmap */
> +			bitmap[index + j] |= (mask << offset);

Likewise, you'd have to or in what you checked above.

James


