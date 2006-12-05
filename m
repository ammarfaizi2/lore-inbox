Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967465AbWLENLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967465AbWLENLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 08:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937541AbWLENLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 08:11:16 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:5978 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937529AbWLENLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 08:11:15 -0500
Subject: Re: [RFC][PATCH] Pseudo-random number generator
From: Jan Glauber <jan.glauber@de.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200612041615.kB4GF7lx031249@turing-police.cc.vt.edu>
References: <1164979155.5882.23.camel@bender>
	 <200612041615.kB4GF7lx031249@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 14:07:27 +0100
Message-Id: <1165324047.6337.39.camel@bender>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 11:15 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 01 Dec 2006 14:19:15 +0100, Jan Glauber said:
> > New s390 machines have hardware support for the generation of pseudo-random
> > numbers. This patch implements a simple char driver that exports this numbers
> > to user-space. Other possible implementations would have been:
> 
> > +	for (i = 0; i < 16; i++) {
> > +		entropy[0] = get_clock();
> > +		entropy[1] = get_clock();
> > +		entropy[2] = get_clock();
> > +		entropy[3] = get_clock();
> 
> By the time this loop completes, we'll have done 64 get_clock() - and if an
> attacker has a good estimate of what the system clock has in it, they'll be
> able to guess all 64 values, since each pass through the loop will have fairly
> predictable timing.  So as a result, the pseudo-random stream will be a *lot*
> less random than one would hope for...

I completely agree. Filling the input buffer with timestamps looks quite
uncomfortable but was exactly what the hardware specification suggested.

At least for the initialisation of the PRNG I preferred get_random_bytes()
over get_clock to get a good initial seed. But get_random_bytes cannot
be used during normal operation since the PRNG read should not block.

> > +		/*
> > +		 * It shouldn't weaken the quality of the random numbers
> > +		 * passing the full 16 bytes from STCKE to the generator.
> > +		 */
> 
> As long as you realize that probably 12 or 13 or even more of those 16 bytes
> are likely predictable (depending exactly how fast the hardware clock ticks),
> and as a result the output stream will also be predictable.

Yes, if an attacker knows the initial clock value a brute-force attack
would be feasible to predict the output. But I don't know if the
hardware completely relies on the clock values or if there is any
internal state which is not visible by an attacker. I will try to find
out more details...

Jan


