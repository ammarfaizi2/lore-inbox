Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbULFAQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbULFAQx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbULFAQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:16:53 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:7864 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261432AbULFAQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:16:50 -0500
Date: Mon, 6 Dec 2004 11:16:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: [RFC] Strange code in cpu_idle()
Message-Id: <20041206111634.44d6d29c.sfr@canb.auug.org.au>
In-Reply-To: <20041205004557.GA2028@us.ibm.com>
References: <20041205004557.GA2028@us.ibm.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__6_Dec_2004_11_16_34_+1100_49NeqwgKqF5T0f0o"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__6_Dec_2004_11_16_34_+1100_49NeqwgKqF5T0f0o
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Paul,

On Sat, 4 Dec 2004 16:45:57 -0800 "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>
> OK, I believe I found the other end of this:
> 
> static void __exit apm_exit(void)
> {
> 	int	error;
> 
> 	if (set_pm_idle) {
> 		pm_idle = original_pm_idle;
> 		/*
> 		 * We are about to unload the current idle thread pm callback
> 		 * (pm_idle), Wait for all processors to update cached/local
> 		 * copies of pm_idle before proceeding.
> 		 */
> 		synchronize_kernel();
> 	}
> 
> Unfortunately, the idle loop is a quiescent state, so it is
> possible for synchronize_kernel() to return before the idle threads
> have returned.  So I don't believe RCU is useful here.  One other
> approach would be to keep a cpu mask, in which apm_exit() sets all
> bits, and pm_idle() clears its CPU's bit only if it is set.
> Then apm_exit() could wait for all CPU's bits to clear.
> 
> There is probably a better way to do this, but that is what comes
> to mind immediately.
> 
> Thoughts?

None, sorry :-)

I don't even remember that piece of code going in (I certainly didn't
write it), though I can see what it was trying to do.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__6_Dec_2004_11_16_34_+1100_49NeqwgKqF5T0f0o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBs6Tr4CJfqux9a+8RAi4AAKCYCeiIgfG906bhTvKDhlZD5aCnnACgltCu
EQ8GZi5JjXxg5nJO1vMic40=
=d49U
-----END PGP SIGNATURE-----

--Signature=_Mon__6_Dec_2004_11_16_34_+1100_49NeqwgKqF5T0f0o--
