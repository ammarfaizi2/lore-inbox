Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVAPCpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVAPCpM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVAPCpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:45:11 -0500
Received: from waste.org ([216.27.176.166]:61640 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262406AbVAPCpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:45:00 -0500
Date: Sat, 15 Jan 2005 18:44:46 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: short read from /dev/urandom
Message-ID: <20050116024446.GA3867@waste.org>
References: <41E7509E.4030802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E7509E.4030802@redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 08:54:54PM -0800, Ulrich Drepper wrote:
> The /dev/urandom device is advertised as always returning the requested 
> number of bytes.  Yet, it fails to do this under some situations. 
> Compile this

Here's what random.c says:

 * The two other interfaces are two character devices /dev/random and
 * /dev/urandom.  /dev/random is suitable for use when very high
 * quality randomness is desired (for example, for key generation or
 * one-time pads), as it will only return a maximum of the number of
 * bits of randomness (as estimated by the random number generator)
 * contained in the entropy pool.
 *
 * The /dev/urandom device does not have this limit, and will return
 * as many bytes as are requested.  As more and more random bytes are
 * requested without giving time for the entropy pool to recharge,
 * this will result in random numbers that are merely cryptographically
 * strong.  For many applications, however, this is acceptable.

_Neither_ case mentions signals and the "and will return as many bytes
as requested" is clearly just a restatement of "does not have this
limit". Whoever copied this comment to the manpage was a bit sloppy
and dropped the first clause rather than the second:

       When read, /dev/urandom device will return as many bytes as are
       requested. As a result, if there is not sufficient entropy in
       the entropy pool...

Meanwhile, read(2) says:

	It is not an error if this number is smaller than the number
	of bytes requested; this may happen for example because fewer
	bytes are actually available right now (maybe because we were
	close to end-of-file, or because we are reading from a pipe,
	or from a terminal), or because read() was interrupted by a
	signal.

So anyone doing a read() can expect a short read regardless of the fd
and is quite clear that reads can be interrupted by signals. "It is
not an error". Ever.

-- 
Mathematics is the supreme nostalgia of our time.
