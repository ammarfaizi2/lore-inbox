Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVAWNPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVAWNPr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 08:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVAWNPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 08:15:47 -0500
Received: from [213.177.124.23] ([213.177.124.23]:33153 "EHLO sirius.home")
	by vger.kernel.org with ESMTP id S261261AbVAWNPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 08:15:37 -0500
Date: Sun, 23 Jan 2005 16:15:12 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ierdnah <ierdnah@go.ro>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel oops!
Message-Id: <20050123161512.149cc9de.vsu@altlinux.ru>
In-Reply-To: <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
References: <1106437010.32072.0.camel@ierdnac>
	<Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__23_Jan_2005_16_15_12_+0300_z+2ooFhywIi7OnNY"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__23_Jan_2005_16_15_12_+0300_z+2ooFhywIi7OnNY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sat, 22 Jan 2005 22:43:50 -0800 (PST) Linus Torvalds wrote:

> Interesting. That last call trace entry is the call in 
> pty_chars_in_buffer() to
> 
>         /* The ldisc must report 0 if no characters available to be read */
>         count = to->ldisc.chars_in_buffer(to);
> 
> and it looks like it has jumped to address zero.
> 
> However, we _just_ compared the fn pointer to zero immediately before, and 
> while there could certainly have been a race that cleared it in between 
> the test and the call, normally we wouldn't even have re-loaded the value 
> at all, but kept it in a register instead.
> 
> That said, it does act like a race. Somebody clearing the ldisc and racing 
> with somebody using it?
> 
> Can you do a 
> 
> 	gdb vmlinux
> 
> 	disassemble pty_chars_in_buffer
> 
> to show what it looks like (whether it reloads the value, and what the 
> registers are - it looks like either %eax or %edi is all zeroes, but I'd 
> like to verify that it matches your code generation).
> 
> Alan? Any ideas? The tty_select() path seems to take a ldisc reference, 
> but does that guarantee that the ldisc won't _change_?

tty_poll() grabs ldisc reference for the tty it was called with;
however, in this case pty_chars_in_buffer() accesses another ldisc
(tty->link->ldisc) without grabbing a reference to it.  BTW, many other
pty_* functions do the same thing.

Is calling tty_ldisc_ref(tty->link) safe here?  There is a comment
warning about possible deadlocks before pty_write().

--Signature=_Sun__23_Jan_2005_16_15_12_+0300_z+2ooFhywIi7OnNY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB86NjW82GfkQfsqIRAvFOAJ9n8rJcQqO4mT00smlY1YVBqZwKLACbBFgp
azdI2PcoINxCJuRNjrQFTzM=
=9YTN
-----END PGP SIGNATURE-----

--Signature=_Sun__23_Jan_2005_16_15_12_+0300_z+2ooFhywIi7OnNY--
