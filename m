Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTIPWm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 18:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTIPWm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 18:42:26 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:48532 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262524AbTIPWmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 18:42:17 -0400
Date: Tue, 16 Sep 2003 23:41:51 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Vishwas Raman <vishwas@eternal-systems.com>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Incremental update of TCP Checksum
Message-ID: <20030916224151.GC30188@mail.jlokier.co.uk>
References: <3F3C07E2.3000305@eternal-systems.com> <20030821134924.GJ7611@naboo> <3F675B68.8000109@eternal-systems.com> <Pine.LNX.4.53.0309161533030.30081@chaos> <3F6770CE.8040802@eternal-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6770CE.8040802@eternal-systems.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
>If I were to modify a low byte somewhere by subtracting 1,
>would I know that the new checksum, excluding the inversion,
>was 0x0000? No. It could be 0xffff.

You're right about information being thrown away, but wrong because IP
checksums are more rigidly defined than that.

RFC1624 was written because the earlier RFC actually got this wrong.

As long as at least one of the checksummed words is known to be
non-zero, 0x0000 is not a possible value.  This is true of all IP checksums.

There is only one possible value of the non-complemented sum: 0xffff.

So when you subtract 1 from 0x0001, you get 0xffff.

To do this right, instead of subtracting a word, you add the
complement of the word.  After carry-folding, this works out right.

Vishwas Raman wrote:
> Are you then suggesting that instead of trying to do an incremental 
> update of the tcp checksum, I set it to 0 and recalculate it from 
> scratch? But I thought that doing that was a big performance hit. Isn't it?

You don't need to recalculate the sum.  All routers modify the IP
header checksum when they decrement the TTL of a packet - it's a
widely used algorithm.  Equation 3 from RFC1624 is correct :)

Your code looks fine to me.  Are you sure you're verifying the
checksum correctly?

>     while (cksum >> 16)
>     {
>         cksum = (cksum & 0xffff) + (cksum >> 16);
>     }

In general you need to add back the carry bits at most twice, btw.

	cksum = (cksum & 0xffff) + (cksum >> 16);
	cksum += (cksum >> 16);

-- Jamie
