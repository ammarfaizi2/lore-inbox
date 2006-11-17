Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424840AbWKQUeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424840AbWKQUeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162433AbWKQUeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:34:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:24196 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1162431AbWKQUeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:34:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=sninigDWuDeSBfZJmf+x0eSRQvDhujpjpOWHONZ8sDJq5LfCa+TQB7dqEReY4LzHLYou90HK6kEVHXr61U3Api6HAKXccS92ZYD+HtZueX+eOg1EAWd/ztv2+1wRph99flOvZH+i7299maUQtmxDQNBCXU2JdvzC4NIlY5Wt1Oo=
From: Christian Hoffmann <chrmhoffmann@gmail.com>
To: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Fri, 17 Nov 2006 21:33:44 +0100
User-Agent: KMail/1.9.5
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <20061117060758.GB25413@shaftnet.org> <20061117154119.GC5158@shaftnet.org>
In-Reply-To: <20061117154119.GC5158@shaftnet.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13388101.dHyx3xWdGv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611172133.50049.chrmhoffmann@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13388101.dHyx3xWdGv
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 17 November 2006 16:41, Stuffed Crust wrote:
> On Fri, Nov 17, 2006 at 01:07:58AM -0500, Stuffed Crust wrote:
> >   http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.19-v7-WIP1.diff
>
>  http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.19-v7-WIP2.diff
>
> This incorporates the latest round of BenH's fixes and changes, but
> backs out the PCI suspend changes, which need independent review and
> testing.
>
> (BenH has promised a little more work before he's ready to sign off,
>  hence the -WIP2 designation)
>
> The following patch contains a rewrite of radeonfb's suspend/resume code
> to use standard PCI subsystem calls.  It applies to 2.6.19-rc6 and also
> on top of the v7-WIP2 patch.
>
>  http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.19-suspend.diff
>
> Christian, if you could see if the latter patch (on top of the -v6b or
> -WIP2 patches) makes a difference for your suspend/resume problems..
>
> And with these patches, I'm going to drop offline for a camping trip
> over the weekend.  I'll pick this stuff back up on Monday.
>
>  - Solomon

Hlo,

it still locks up.=20
=2E..          =20
    pci_set_power_state(pdev, PCI_D0);
    pci_restore_state(pdev);
    if (pci_enable_device(pdev)) {
                rc =3D -ENODEV;
                printk(KERN_ERR "radeonfb (%s): can't enable PCI device !\n=
",
                       pci_name(pdev));
                goto bail;
        }
        pci_set_master(pdev);
        if (pdev->dev.power.power_state.event =3D=3D PM_EVENT_SUSPEND) {
                /* Wakeup chip. Check from config space if we were powered =
off
                 * (todo: additionally, check CLK_PIN_CNTL too)
                 */
                if (rinfo->pm_mode & radeon_pm_off) {
                        if (rinfo->reinit_func !=3D NULL)
                                rinfo->reinit_func(rinfo);
                        else {
                                printk(KERN_ERR "radeonfb (%s): can't resum=
e=20
radeon from"
                                       " D3 cold, need softboot !",=20
pci_name(pdev));
                                rc =3D -EIO;
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
                else if (rinfo->pm_mode & radeon_pm_d2)
                        radeon_set_suspend(rinfo, 0);

                rinfo->asleep =3D 0;
        } else
                radeon_engine_idle();
        goto bail;

When I comment out the rinfo->asleep =3D 0; line, the machine comes back. S=
o it=20
seems that rinfo struct is still corrupted somehow.

Chris

--nextPart13388101.dHyx3xWdGv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARV4crdonrF4PGGDNAQL9UQ/+LvvXhR0AdmyKcde/i05KOpDkcfLZnGUd
ElR1tGM++Qr2z2kukvAQINnh0nT3FmEfBjTE1CYASXzDPVYIk5f+8t0p17XxbvGC
PD/a8b8ya0FmoS18QvhnfKiaBzGvLSrSkZXpVMWVnGW/MPF8bomfa/6ZXUbJuele
0eh+iqLdrBhlM0BxsqKUozRpLM2z4yo+1yikdl6lEH8Gjz2LFFMKIZPtLQ+MGXq1
Bi5RGN8ti2qdJsNpd36Log+wnOhXpHBCflAb/L9mhNblxOVk8+85xZqtrw2NCE6J
Qa3n4trfmiFprv6XKqS849I4ZBNHdsD8R3RtGCRzEqF8n97rU/7692f4abZqtpoz
3bz6vJORQyc/FcosEI9KSbgWa9rXVw7Q1DKNgd3Bh7usSZSMMs7lUGSjrU1zvy3q
l+WKa883shOelkh3oB/GZfPvoHPgKY+mRJBVK6N1TLliYK+GW9LM7Xli6qNteYKl
jLAtiIM8Q7WYnVmUS/kUZWDt/xOBCirOhT/5NjlPm9+YkswW/UWtInXEJaXwnzGJ
O7InFVEp/kX1yFfwA5ZpSW1QI+VVo4KeClIzjVQ3cXHh6OQLRQ8lSMcwhL2FqM/c
3MJ8DFFgb2e4N8RUj0TQZVN6hmAPqmakak2tbf8Sa0DD0Pe4+yLjVrXKWdB6LJj1
4jQJWSe5yPs=
=Vjel
-----END PGP SIGNATURE-----

--nextPart13388101.dHyx3xWdGv--
