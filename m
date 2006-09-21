Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWIUX1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWIUX1K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 19:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWIUX1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 19:27:10 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:3037 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932106AbWIUX1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 19:27:08 -0400
X-Sasl-enc: 7T0FrPNKuZAp/X8KqCFo0ZwlexGZUtXi6nSiOxTySFLE 1158881227
Message-ID: <45132018.8070501@imap.cc>
Date: Fri, 22 Sep 2006 01:28:24 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: john stultz <johnstul@us.ibm.com>
Subject: Re: [2.6.18-rc7] printk output delay in syslog wrt dmesg still unfixed
References: <450BF1CC.2070309@imap.cc> <1158691933.18546.3.camel@localhost>
In-Reply-To: <1158691933.18546.3.camel@localhost>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC7FAE8BBE13FA13B9E925076"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC7FAE8BBE13FA13B9E925076
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 19.09.2006 20:52, john stultz wrote:
> You might try git-bisect to find the offending patch.

This turned out to be easier than I expected.
The patch which introduces the problem is:

[a0f1ccfd8d37457a6d8a9e01acebeefcdfcc306e] lockdep: do not recurse in pri=
ntk

Reverting that patch makes the problem disappear in 2.6.18, too.
In fact, it suffices to revert just the last chunk:

@@ -809,8 +815,15 @@ void release_console_sem(void)
        console_may_schedule =3D 0;
        up(&console_sem);
        spin_unlock_irqrestore(&logbuf_lock, flags);
-       if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait=
))
-               wake_up_interruptible(&log_wait);
+       if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait=
)) {
+               /*
+                * If we printk from within the lock dependency code,
+                * from within the scheduler code, then do not lock
+                * up due to self-recursion:
+                */
+               if (!lockdep_internal())
+                       wake_up_interruptible(&log_wait);
+       }
 }
 EXPORT_SYMBOL(release_console_sem);

Hope that helps.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enigC7FAE8BBE13FA13B9E925076
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFEyAsMdB4Whm86/kRAh7BAJ0eRtSBfNhEHAlSu1GbLRjmEOI+SACdFGIj
Vm1OZGVN6/xdCwK9972JQj8=
=zXmw
-----END PGP SIGNATURE-----

--------------enigC7FAE8BBE13FA13B9E925076--
