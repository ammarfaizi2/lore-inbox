Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424731AbWKPWRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424731AbWKPWRs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424737AbWKPWRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:17:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:12593 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424731AbWKPWRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:17:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=IIT4Ayv/qCw/YeRnjaUQEA3kX94nwvOt7OsJm8TMG3YM3vtb+LSwjpReskQO8pKCTTHhmSeRtb+4BXJHeJbOJ27kim35ilrrEK5rlxIY3JkygJTOrueiaBYXpLrcgO4gE87b+kgYLqs1bRGu7z0E0n5PsPzWuEdtb5Kr/iyYA/g=
From: Christian Hoffmann <chrmhoffmann@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Thu, 16 Nov 2006 23:17:26 +0100
User-Agent: KMail/1.9.5
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <1163555308.5940.177.camel@localhost.localdomain> <200611151109.06956.rjw@sisk.pl>
In-Reply-To: <200611151109.06956.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2539656.VEzSQKyLSm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611162317.30880.chrmhoffmann@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2539656.VEzSQKyLSm
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


> >
> > Well, if you acquire the console sem you need to release it too :-)
>
> Or the console semaphore is acquired too many times.
>
> Christian, could you please add release_console_sem() before 'return 0'
> and see if that makes the code work again?  If not, could you add a
> printk() in kernel/printk.c/acquire_console_sem() to see how many times it
> is called?

Ok, I did that and the machine resumes OK. Now I have the impression that=20
accessing the rinfo struct here:

if (pdev->dev.power.power_state.event =3D=3D PM_EVENT_SUSPEND) {
                /* Wakeup chip. Check from config space if we were powered =
off
                 * (todo: additionally, check CLK_PIN_CNTL too)
                 */
                if ((rinfo->pm_mode & radeon_pm_off) &&
                        radeon_restore_pci_cfg(rinfo)) {
                        if (rinfo->reinit_func !=3D NULL) {
                                rinfo->reinit_func(rinfo);
                                }
                        else {
                                goto bail;
                        }
                }
                /* If we support D2, try to resume... we should check what =
was=20
our
                 * state though... (were we really in D2 state ?). Right no=
w,=20
this code
                 * is only enable on Macs so it's fine.
                 */
                else if (rinfo->pm_mode & radeon_pm_d2){
                        radeon_set_suspend(rinfo, 0);
                }
                rinfo->asleep =3D 0; ////makes it crash
        } else {
                radeon_engine_idle();
        }

makes the resume fail. The machine locks up. I started xorg without drm/dri=
=20
and then it goes a little further and locks up in the next steps:       =20

/* Restore display & engine */
radeon_write_mode (rinfo, &rinfo->state, 1);

But it starts to get too complicated for me :(

Chris

--nextPart2539656.VEzSQKyLSm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARVzjetonrF4PGGDNAQKMRg/+KXgOaXQ9P8k8OZ0hZWGoZafBm/6q7Czw
ugfiBETifwbqRN1vEJD3aTKghJ/UFkItKssV4kqdkhssrxvAhPXW8YaGR3+JWkPv
YMmLxlMaY+KuFNd81KgUz0ogcVX736pH9CMVjyCmP1ex7+sQQJD2ZVDcm2hde3UL
9R+Fsj+osDe79GJzTr1PuZ+ZWIc8/F0xTXzM7zvLz9HzYW7SgEmYI3v9mGOBsAGv
JSlhzwLNgtz04JLB9VDbvypxriudPxIsFqws2Vd6N23JXQ/47KTCjvGFMV7Z5PxG
aCftdxz97fnRt/DnFz85jRrku8+fVVg/Rlj3EHsAu+UbrFn6fQgGFH95kJEjF9/V
fX2rCC2xgLJK9Mm2MCQ+KJ5IJXPyLQO8yHDIFs/5ZGRdPafaH7OqNIy49/vaxQ7I
ynCo7ga8Q3rq/tqXemdT6x8YKnjiH7VPIlFbiHggWBWmt+2Mef6ThSJc1Zfx3CwU
QxEF79cooefW3vX/9sGUgyS4d2L+HTR6YYm+a5ys3wHjh2v87H2iTL7GtZEP8Ocy
zvNVbChiQNFuvpZyS2iuMgnrZoRqf+j85AENfbx5jPJc3t+Xj7In/+jG5g/Pcz5F
8uN+EhyrAoe95GsRw9wGP4jQnUiCSaltUxxvhnhmsU1QoOgk4yvJDO9FfHtxoscX
HofHrY8rX1w=
=Ba+c
-----END PGP SIGNATURE-----

--nextPart2539656.VEzSQKyLSm--
