Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275288AbRJARAC>; Mon, 1 Oct 2001 13:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275289AbRJAQ7w>; Mon, 1 Oct 2001 12:59:52 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:46586 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S275288AbRJAQ7o>; Mon, 1 Oct 2001 12:59:44 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Mon, 1 Oct 2001 10:59:27 -0600
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: /dev/random entropy calculations broken?
Message-ID: <20011001105927.A22795@turbolinux.com>
Mail-Followup-To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
In-Reply-To: <1001461026.9352.156.camel@phantasy> <9or70g$i59$1@abraham.cs.berkeley.edu> <tgadzbr8kq.fsf@mercury.rus.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tgadzbr8kq.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 01, 2001  11:52 +0200, Florian Weimer wrote:
> daw@mozart.cs.berkeley.edu (David Wagner) writes:
> > Incrementing the entropy counter based on externally observable
> > values is dangerous.
> 
> How do you want to collect any entropy with such a requirement in
> place?  Computers tend to send out a lot of information on the air.
>
> BTW, I still think that the entropy estimate for mouse movements is
> much too high.  And the compression function used probably doesn't
> have the intended property.

Has anyone even checked whether the current entropy estimates even work
properly?  I was testing this, and it appears something is terribly wrong.
Check /proc/sys/kernel/random/entropy_avail.  On a system that has been
running any length of time, it should be 4096 (512 bytes * 8 bits of
entropy for a full pool).

Now, "dd if=/dev/random bs=16 count=1 | wc -c" and check entropy_avail
again.  It "loses" thousands of bits of entropy for generating 16 bytes
(128 bits) of random data.  Same thing happens with /dev/urandom consuming
the available entropy.

Now if you do the above test on /dev/random several times in a row, you see
that you really HAVE used up the entropy, because it will return a number
of bytes less than what you requested.  At this point, however, it is at
least consistent, returning a number of bytes = entropy_avail/8.

Ted, any ideas about this?  I'm just looking through the code to see where
the entropy is counted, and where it goes.  It _may_ be a bug with the
entropy_avail value itself, but then why the short reads?  The output values
are at least consistent in that they grow slowly only when kb/mouse/disk
activity happens, and are constant otherwise.

This may be a major source of problems for entropy-poor environments, since
you will basically only be able to read a single random value from /dev/random
before the pool "dries up", regardless of the pool size (I tried with a
4096-byte pool, and the same problem happens).  Hence, in such systems there
would be more of a desire to use the "less secure" network interrupts for
entropy.

Cheers, Andreas

PS - For systems which have _some_ entropy, but just not very much, it is
     possible to increase the size of the pool (if it actually worked ;-)
     so that you can save entropy for periods of high demand.  You can do
     this by "echo 4096 > /proc/sys/kernel/random/poolsize" (or some other
     larger power-of-two size).
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

