Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132986AbRADOzS>; Thu, 4 Jan 2001 09:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133053AbRADOzI>; Thu, 4 Jan 2001 09:55:08 -0500
Received: from firebox-ext.surrey.redhat.com ([194.201.25.236]:57070 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S132986AbRADOzC>; Thu, 4 Jan 2001 09:55:02 -0500
Date: Thu, 4 Jan 2001 14:54:58 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        linux-kernel@vger.kernel.org
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
Message-ID: <20010104145458.P23469@redhat.com>
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010104112027.G23469@redhat.com> <20010104145229.E17640@athlon.random> <20010104142043.N23469@redhat.com> <20010104153910.A1507@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="8SdtHY/0P4yzaavF"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010104153910.A1507@athlon.random>; from andrea@suse.de on Thu, Jan 04, 2001 at 03:39:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8SdtHY/0P4yzaavF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 04, 2001 at 03:39:10PM +0100, Andrea Arcangeli wrote:

> As noted yesterday falling into parport_write will silenty lose data when the
> printer is off.

(Actually it depends; I think FIFO/DMA paths are fine, but yes, the
software implementation can lose data.)

> If it's not feasible to make parport_write reliable against
> power-off printer, then I recommend to loop in interruptible mode
> before entering the main loop (waiting the printer to power-on) like
> in latest patch from Peter.

Have I missed a patch?  How do you know whether or not the printer is
on yet?

As I understand it, you can't guarantee anything about any of the
signals when the printer is off, so all you can do is look for
'suspicous' things (like 'no error' and 'paper out').  But some
printers do this during normal operation, and hence the LP_CAREFUL
switch.

Return -EIO when the printer is on and off-line is a bug, sure enough.
That's what the -EAGAIN patch was for, and Peter's patch fixes this
too.

But if you want to avoid losing data when your printer is off you need
to use LP_CAREFUL, and hope printing still works at all (depends on
your printer).

If this goes away:

        if ((status & LP_PERRORP) && !(LP_F(minor) & LP_CAREFUL))
                /* No error. */
                last = 0;

then some people might not be able to print at all.

Tim.
*/

--8SdtHY/0P4yzaavF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6VI7CONXnILZ4yVIRAt6ZAKCfpYIiG0m3rRctfuLbhIByvghW4ACfe/hD
c3maeqZWxGkNCQU+aLyKR2o=
=06Sr
-----END PGP SIGNATURE-----

--8SdtHY/0P4yzaavF--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
