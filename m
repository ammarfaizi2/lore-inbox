Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272382AbTHNOLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 10:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272385AbTHNOLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 10:11:00 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:53474 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S272382AbTHNOK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 10:10:59 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: David Woodhouse <dwmw2@infradead.org>
To: Yury Umanets <umka@namesys.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Daniel Egger <degger@fhm.edu>,
       Hans Reiser <reiser@namesys.com>, Nikita Danilov <Nikita@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <1060837469.17622.6.camel@haron.namesys.com>
References: <Pine.LNX.3.96.1030813160910.12417A-100000@gatekeeper.tmr.com>
	 <1060837469.17622.6.camel@haron.namesys.com>
Content-Type: text/plain
Message-Id: <1060870255.4803.49.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (dwmw2) 
Date: Thu, 14 Aug 2003 15:10:55 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-14 at 06:04, Yury Umanets wrote:
> Yes, you are right. Device driver cannot take care about leveling.

The hardware device driver doesn't. The 'translation layer' does, in the
case where you are using a traditional block-based file system. 

If you consider the translation layer and the underlying raw hardware
driver together to form the 'device driver' from the filesystem's
perspective and in the context of the above sentence, then you're
incorrect -- it can, and in general it _does_ take care of wear
levelling.

> It is able only to take care about simple caching (one erase block) in 
> order to make wear out smaller and do not read/write whole block if one 
> sector should be written.

Whatever meaning of 'device driver' you meant to use -- no.

The raw hardware driver provides only raw read/write/erase
functionality; no caching is appropriate. 

The optional translation layer which simulates a block device provides
far more than simple caching -- it provides wear levelling, bad block
management, etc. All using a standard layout on the flash hardware for
portability.

(Except in the special case of the 'mtdblock' translation layer, which
is not suitable for anything but read-only operation on devices without
any bad blocks to be worked around.)

> Part of a filesystem called "block allocator" should take care about 
> leveling.

That's insufficient. In a traditional file system, blocks get
overwritten without being freed and reallocated -- the allocator isn't
always involved. 

If you want to teach a file system about flash and wear levelling, you
end up ditching the pretence that it's a block device entirely and
working directly with the flash hardware driver. 

Either that or use a translation layer which does it _all_ for the file
system and then just use a standard file system on that simulated block
device.

Between those two extremes, very little actually makes sense.

If you introduce the gratuitous extra 'block device' abstraction layer
which doesn't really fit the reality of flash hardware very well at all,
you end up wanting to violate the layering in so many ways that you
realise you really shouldn't have been pretending to be a block device
in the first place.

-- 
dwmw2

