Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWEVMqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWEVMqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 08:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWEVMqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 08:46:50 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:33235 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750803AbWEVMqt (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 08:46:49 -0400
Message-Id: <200605221246.k4MCkfFl008442@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Michael Buesch <mb@bu3sch.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm3
In-Reply-To: Your message of "Mon, 22 May 2006 13:49:28 +0200."
             <200605221349.28329.mb@bu3sch.de>
From: Valdis.Kletnieks@vt.edu
References: <20060522022709.633a7a7f.akpm@osdl.org> <200605221325.10761.mb@bu3sch.de> <200605221138.k4MBcgd2006492@turing-police.cc.vt.edu>
            <200605221349.28329.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148302001_6073P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 22 May 2006 08:46:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1148302001_6073P
Content-Type: text/plain; charset=us-ascii

On Mon, 22 May 2006 13:49:28 +0200, Michael Buesch said:

> Andrew's comment on this:
> 
> 	What's going on with the need_resched() tricks in there?  (Unobvious, needs
> 	a comment).  From my reading, it'll cause a caller to this function to hang
> 	for arbitrary periods of time if something if causing heavy scheduling
> 	pressure.
> 
> So I decided to remove it and return -EAGAIN, so userspace can retry.
> But seems like it it does not. I thought glibc would handle that.

On the other hand, the *old* code did the same 'need_resched()' test - although
it was slightly different:

               if(need_resched())
                        schedule_timeout_interruptible(1);
                else
                        udelay(200);    /* FIXME: We could poll for 250uS ?? */ 

I tossed the else because we have the poll loop elsewhere (the only delay in
the old code was that udelay).

And it's probably no *great* sin if it blocks for a long time - remember that
we're waiting for more entropy to show up.  And if we don't resched, we basically
end up spinning until we get all the entropy we want.

Note that the current userspace will go and snarf up 2500 (yes, 2500) bytes
of data, and then spend the next half hour or so feeding it into /dev/random
in small chunks once a minute.  At least on my laptop, strace reports the
read as taking 0.46 seconds.  I'm pretty sure we want to resched once in
a while, rather than lock up a CPU for half a second. :)


--==_Exmh_1148302001_6073P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEcbKxcC3lWbTT17ARAuDOAJ0fb+6itN9axDWEGnJd2IEX0b5hgwCfWO7w
Yi9PeiUUx6tJQlcprg8xo7I=
=mteg
-----END PGP SIGNATURE-----

--==_Exmh_1148302001_6073P--
