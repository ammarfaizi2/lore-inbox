Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbTIYLmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 07:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbTIYLmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 07:42:23 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:41746 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261810AbTIYLmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 07:42:19 -0400
Date: Thu, 25 Sep 2003 13:42:17 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rfc: test whether a device has a partition table
Message-ID: <20030925114217.GB21508@win.tue.nl>
References: <20030924235041.GA21416@win.tue.nl> <Pine.LNX.4.44.0309242137090.1729-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309242137090.1729-100000@home.osdl.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 09:47:01PM -0700, Linus Torvalds wrote:

> On Thu, 25 Sep 2003, Andries Brouwer wrote:

> > My post implicitly suggested the minimal thing to do.
> > It will not be enough - heuristics are never enough -
> > but it probably helps in most cases.
> 
> I don't mind the 0x00/0x80 "boot flag" checks - those look fairly obvious
> and look reasonably safe to add to the partitioning code.
> 
> There are other checks that can be done - verifying that the start/end
> sector values are at all sensible. We do _some_ of that, but only for
> partitions 3 and 4, for example. We could do more - like checking the
> actual sector numbers (but I think some formatters leave them as zero).
> 
> Which actually makes me really nervous - it implies that we've probably 
> seen partitions 1&2 contain garbage there, and the problem is that if 
> you're too careful in checking, you will make a system unusable.

No and yes.

Note that all checks that are there today are mine.
No, the missing check on 1&2 does not mean that there may be garbage there,
it was just the other way around. In a chain of logical partitions inside
an extended partition almost always only slots 1 and 2 are used, and
slots 3 and 4 are zeroed out. But it happens that slots 3 and 4 are used,
so we want to look at them. But sometimes slots 3 and 4 contain complete
garbage, so we trust them much less than slots 1 and 2, and accept them only
when everything really looks right.

It is possible to add more checks, and each time there was reason to do so
we added the minimal check.

> And your random byte checks for power-of-2 make no sense. What are they
> based on?

First you say that they make no sense and then you ask why they make sense?
You might as well just ask.

I don't know whether you want a general or a technical answer.
Let us try the technical one. A FAT bootsector has in bytes 11-12
a little-endian short that gives the number of bytes per sector.
It is almost always 512, but also 1024, 2048, 4096 occur.
A FAT bootsector has in byte 13 the number of sectors per cluster.
It is usually 1, but also 2, 4, 8, 16, 32, 64, 128 occur.

Thus, it is a reasonable test to check these three bytes and
require two powers of two. If that fails, then we do not have
a FAT bootsector (of a type I have ever seen).

Andries

