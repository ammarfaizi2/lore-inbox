Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWDYETi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWDYETi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 00:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWDYETi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 00:19:38 -0400
Received: from h80ad2557.async.vt.edu ([128.173.37.87]:52436 "EHLO
	h80ad2557.async.vt.edu") by vger.kernel.org with ESMTP
	id S1751371AbWDYETi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 00:19:38 -0400
Message-Id: <200604250419.k3P4JGvR005842@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Greg KH <greg@kroah.com>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 1/4] kref: warn kref_put() with unreferenced kref 
In-Reply-To: Your message of "Mon, 24 Apr 2006 20:51:28 PDT."
             <20060425035128.GB18085@kroah.com> 
From: Valdis.Kletnieks@vt.edu
References: <20060424083333.217677000@localhost.localdomain> <20060424083341.613638000@localhost.localdomain>
            <20060425035128.GB18085@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145938755_2527P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Apr 2006 00:19:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145938755_2527P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Apr 2006 20:51:28 PDT, Greg KH said:
> On Mon, Apr 24, 2006 at 04:33:34PM +0800, Akinobu Mita wrote:

> > --- 2.6-git.orig/lib/kref.c
> > +++ 2.6-git/lib/kref.c
> > @@ -49,6 +49,7 @@ void kref_get(struct kref *kref)
> >   */
> >  int kref_put(struct kref *kref, void (*release)(struct kref *kref))
> >  {
> > +	WARN_ON(atomic_read(&kref->refcount) < 1);
> 
> How can this ever be true?  If the refcount _ever_ goes below 1, the
> object is freed.

Maybe it should BUG_ON instead in that case. ;)

And strictly speaking, as long as the kref.c stuff is the only stuff to
play with ->refcount, that *should* be true.  On the other hand, if somebody
has a bad pointer that just did a fandango on core, it would be a nice thing
to know that.  Looking at the *next* few lines:

        if ((atomic_read(&kref->refcount) == 1) ||
            (atomic_dec_and_test(&kref->refcount))) {
                release(kref); 
                return 1; 
        }    
        return 0;

If we managed to get a -1 smashed in there, this won't actually trigger
for another 2**32-2 or so kref_put calls - the first test is for "exactly 1",
and the dec_and_test is for "exactly zero"...

--==_Exmh_1145938755_2527P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFETaNDcC3lWbTT17ARAma9AKCYbiw9HMVCGBdvZ94/0YwqzyTShACg/iYL
MJQu7wuTBo4iK6lqvCf03ZQ=
=2Pno
-----END PGP SIGNATURE-----

--==_Exmh_1145938755_2527P--
