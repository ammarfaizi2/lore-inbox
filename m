Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbUJ3TUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbUJ3TUn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbUJ3TUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:20:42 -0400
Received: from mail.murom.net ([213.177.124.17]:17860 "EHLO mail.murom.net")
	by vger.kernel.org with ESMTP id S261270AbUJ3TUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:20:17 -0400
Date: Sat, 30 Oct 2004 23:19:55 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.4.28-pre3 tty/ldisc fixes
Message-ID: <20041030191955.GA2310@sirius.home>
References: <20041028183551.GC3253@sirius.home> <Pine.LNX.4.44.0410291426240.13340-200000@dhcp83-105.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410291426240.13340-200000@dhcp83-105.boston.redhat.com>
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.495,
	required 6, autolearn=not spam, AWL 2.40, BAYES_00 -4.90)
X-MailScanner-From: vsu@altlinux.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 29, 2004 at 02:29:43PM -0400, Jason Baron wrote:
>=20
> On Thu, 28 Oct 2004, Sergey Vlasov wrote:
>=20
> > Here the comment is unclosed; is this intentional?  Simply closing it
> > at the same line gives a kernel which cannot complete the system boot
> > process: it prints "init_dev but no ldisc", and then init hangs in
> > uninterruptible sleep with this backtrace:
> >=20
> > Adhoc c0188ab7 <tty_ldisc_ref_wait+47/80>
> > Adhoc c0199c30 <con_write+0/30>
> > Adhoc c0189648 <tty_write+118/270>
> > Adhoc c0139728 <chrdev_open+38/50>
> > Adhoc c01386e3 <dentry_open+e3/190>
> > Adhoc c0138f16 <sys_write+96/f0>
> > Adhoc c01385eb <filp_open+4b/60>
> > Adhoc c014246f <getname+5f/a0>
> > Adhoc c0138937 <sys_open+57/80>
> >=20
>=20
> Here's an updated 2.4 tty patch. I'm not sure if the updated patch would=
=20
> fix the above issue, but it has a lot of changes so it might be worth a=
=20
> try.

This looks better - at least the system boots without hang or oops ;)

However, drivers/net/wan/pc300_tty.c does not compile:

> @@ -699,12 +693,19 @@ static void cpc_tty_rx_task(void * data)
>  			cpc_tty =3D &cpc_tty_area[port];
>  	=09
>  			if ((buf=3Dcpc_tty->buf_rx.first) !=3D 0) {
> -														=09
> -				if (cpc_tty->tty && (cpc_tty->tty->ldisc.receive_buf)) {=20
> -					CPC_TTY_DBG("%s: call line disc. receive_buf\n",cpc_tty->name);
> -					cpc_tty->tty->ldisc.receive_buf(cpc_tty->tty, (const unsigned char =
*)buf->data,=20
> -													&flags, buf->size);
> -				}=09
> +			=09
> +				if(cpc_tty->tty)=20
> +				{
> +					ld =3D tty_ldisc_ref(cpc_tty);
					struct tty_ldisc *ld =3D tty_ldisc_ref(cpc_tty->tty);

> +					if(ld)
> +					{
> +						if (ld->receive_buf)) {
						if (ld->receive_buf) {

> +							CPC_TTY_DBG("%s: call line disc. receive_buf\n",cpc_tty->name);
> +							ld->receive_buf(cpc_tty->tty, (char *)(buf->data), &flags, buf->s=
ize);
> +						}
> +						tty_ldisc_deref(ld);
> +					}
> +				}										=09
>  				cpc_tty->buf_rx.first =3D cpc_tty->buf_rx.first->next;
>  				kfree((unsigned char *)buf);
>  				buf =3D cpc_tty->buf_rx.first;

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBg+lbW82GfkQfsqIRAtqUAJ428mGxljUwRc+svlsJSXISby2ccACeNtOV
N9AMnxtLScRc+JNJSC0XEC0=
=N+Tm
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
