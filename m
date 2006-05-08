Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWEHANp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWEHANp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 20:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWEHANp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 20:13:45 -0400
Received: from thunk.org ([69.25.196.29]:52701 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751236AbWEHANp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 20:13:45 -0400
Date: Sun, 7 May 2006 20:13:33 -0400
From: Theodore Tso <tytso@mit.edu>
To: Matt Mackall <mpm@selenic.com>
Cc: Thiago Galesi <thiagogalesi@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060508001333.GA17138@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Matt Mackall <mpm@selenic.com>,
	Thiago Galesi <thiagogalesi@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20060505203436.GW15445@waste.org> <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org> <20060506.170810.74552888.davem@davemloft.net> <20060507045920.GH15445@waste.org> <82ecf08e0605070613o7b217a2bw4c71c3a8c33bed28@mail.gmail.com> <20060507160013.GM15445@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060507160013.GM15445@waste.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 11:00:14AM -0500, Matt Mackall wrote:
> Yes, CRC-16 was a rhetorical device. MD4 would not have been. 

MD4 is succeptible to a 2nd pre-image attack, yes.  This means that
given a specific message and its MD4 checksum, you can find another
message which will have the same MD4 checksum.  But that doesn't help
you at all if you only have the MD4 checksum.  And even the 2nd
pre-image attack still requires O(2**40) operations.  That's within
the reach of modern CPU's yes, but that simply gives you a *second*
pre-image that has the same MD4 checksum as original message.  

In order to crack the entropy pool, you need a large number of outputs
from /dev/random, and be able to find a large number of pre-images
very rapidly.  This is the main reason why I believe the entropy
accounting is still useful.  Even if the entropy accounting is off by
several orders of magnitude, it is still useful, since the attacks
that we're talking about will very likely require a huge number of
data points.  For example, the most powerful cryptoanalytic attack
against DES still requires 2**43 plaintext/ciphertext pairs.

But in answer to your question, what should we do, my suggestion would
be to sample all interrupts, and calculate the estimated entropy
credits as we to day, but scaled by an amount that can range from 0 to
100%.  This amount can be configured by system administrators, and
will have intelligent defaults for each device driver to the amount of
entropy should be credited for a particular device.  If we care, we
can set the default percentage scalaing factor for platforms with no
TSC reguster and HZ=100 to be zero.  But for most normal/modern
platforms, I would argue the default scaling factor should be 100%.

The bottom line is this is much ado about nothing.  As I have said,
most programs use /dev/urandom, not /dev/random; the only really
appropriate use of /dev/random is to generate long-term public/private
keypairs, or perhaps to seed some other cryptographic random number
generator (like /dev/urandom).

						- Ted
