Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVBOUDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVBOUDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVBOT7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:59:02 -0500
Received: from mail.murom.net ([213.177.124.17]:13507 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261852AbVBOT6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:58:22 -0500
Date: Tue, 15 Feb 2005 22:58:02 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
Message-Id: <20050215225802.6321e9a8.vsu@altlinux.ru>
In-Reply-To: <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
References: <jebramy75q.fsf@sykes.suse.de>
	<Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__15_Feb_2005_22_58_02_+0300_jexgoBfDBr+lpwkk"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__15_Feb_2005_22_58_02_+0300_jexgoBfDBr+lpwkk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 15 Feb 2005 11:08:07 -0800 (PST) Linus Torvalds wrote:

> On Tue, 15 Feb 2005, Andreas Schwab wrote:
> >
> > Recent kernel are losing bytes on a pty. 
> 
> Great catch.
> 
> I think it may be a n_tty line discipline bug, brought on by the fact that
> the PTY buffering is now 4kB rather than 2kB. 4kB is also the
> N_TTY_BUF_SIZE, and if n_tty has some off-by-one error, that would explain 
> it.
> 
> Does the problem go away if you change the default value of "chunk" (in 
> drivers/char/tty_io.c:do_tty_write) from 4096 to 2048? If so, that means 
> that the pty code has _claimed_ to have written 4kB, and only ever wrote 
> 4kB-1 bytes. That in turn implies that "ldisc.receive_room()" disagrees 
> with "ldisc.receive_buf()".

The problem also goes away after unsetting ECHO on the slave terminal.
This seems to point to this code in n_tty_receive_char():

	if (L_ECHO(tty)) {
		if (tty->read_cnt >= N_TTY_BUF_SIZE-1) {
			put_char('\a', tty); /* beep if no space */
			return;
		}
	.......
	}

This code sets the maximum number of buffered characters to
N_TTY_BUF_SIZE-1, however, put_tty_queue() considers the maximum to be
N_TTY_BUF_SIZE, and n_tty_receive_room() also returns N_TTY_BUF_SIZE for
canonical mode if the canon_data buffer is empty - therefore after
unsetting ECHO bytes are no longer lost.

BTW, for the noncanonical mode n_tty_receive_room() calculates the
result assuming that the buffer can hold at most N_TTY_BUF_SIZE-1
characters - not the full N_TTY_BUF_SIZE.

--Signature=_Tue__15_Feb_2005_22_58_02_+0300_jexgoBfDBr+lpwkk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCElRNW82GfkQfsqIRAszNAKCUc4ic0Sl0gIgVxssR6b+K7hIx5ACeIofo
dYZM5lrz+tk55KWfSxpjiEQ=
=OKMf
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Feb_2005_22_58_02_+0300_jexgoBfDBr+lpwkk--
