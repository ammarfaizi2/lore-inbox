Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVBLN3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVBLN3K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 08:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVBLN3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 08:29:10 -0500
Received: from mail.murom.net ([213.177.124.17]:46734 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261402AbVBLN3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 08:29:03 -0500
Date: Sat, 12 Feb 2005 16:28:35 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>,
       Al Borchers <alborchers@steinerpoint.com>, david-b@pacbell.net,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC UPDATE PATCH] add wait_event_*_lock() functions and
 comments
Message-Id: <20050212162835.4b95d635.vsu@altlinux.ru>
In-Reply-To: <200502121238.31478.arnd@arndb.de>
References: <1108105628.420c599cf3558@my.visi.com>
	<20050211195553.GE2372@us.ibm.com>
	<200502121238.31478.arnd@arndb.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__12_Feb_2005_16_28_35_+0300_kp+Rvz1XMMH5jIaJ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__12_Feb_2005_16_28_35_+0300_kp+Rvz1XMMH5jIaJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sat, 12 Feb 2005 12:38:26 +0100 Arnd Bergmann wrote:

> On Freedag 11 Februar 2005 20:55, Nishanth Aravamudan wrote:
> 
> > + * If the macro name contains:
> > + * 	lock, then @lock should be held before calling wait_event*().
> > + * 		It is released before sleeping and grabbed after
> > + * 		waking, saving the current IRQ mask in @flags. This lock
> > + * 		should also be held when changing any variables
> > + * 		affecting the condition and when waking up the process.
> 
> Hmm, I see two problems with that approach:
> 
> 1. It might lead to people not thinking about their locking order
> thoroughly if you introduce a sleeping function that is called with
> a spinlock held. Anyone relying on that lock introduces races because
> it actually is given up by the macro. I'd prefer it to be called 
> without the lock and then have it acquire the lock only to check the
> condition, e.g:
> 
> #define __wait_event_lock(wq, condition, lock, flags)                  \
> do {                                                                   \
>        DEFINE_WAIT(__wait);                                            \
>                                                                        \
>        for (;;) {                                                      \
>                prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);    \
>                spin_lock_irqsave(lock, flags);                         \
>                if (condition)                                          \
>                        break;                                          \
>                spin_unlock_irqrestore(lock, flags);                    \
>                schedule();                                             \
>        }                                                               \
>        spin_unlock_irqrestore(lock, flags);                            \
>        finish_wait(&wq, &__wait);                                      \
> } while (0)

But in this case the result of testing the condition becomes useless
after spin_unlock_irqrestore - someone might grab the lock and change
things.   Therefore the calling code would need to add a loop around
wait_event_lock - and the wait_event_* macros were added precisely to
encapsulate such a loop and avoid the need to code it manually.

--Signature=_Sat__12_Feb_2005_16_28_35_+0300_kp+Rvz1XMMH5jIaJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCDgSGW82GfkQfsqIRAkFzAJ4wRzqtoqzKYUf7Uk5qKiP3AnHJpQCfay9B
5nBbHyslZORlrNMoLPM5jbE=
=/1D4
-----END PGP SIGNATURE-----

--Signature=_Sat__12_Feb_2005_16_28_35_+0300_kp+Rvz1XMMH5jIaJ--
