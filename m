Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268537AbUJJW72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268537AbUJJW72 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 18:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268541AbUJJW72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 18:59:28 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:8529 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268537AbUJJW7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 18:59:06 -0400
Date: Sun, 10 Oct 2004 15:59:03 -0700
To: adaplas@pol.net
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Problem with current fb_get_color_depth function
Message-ID: <20041010225903.GA2418@darjeeling.triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, adaplas@pol.net,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Antonino, lists, etc.,

I noticed that after 2.6.9-rc1 or so my framebuffer logo stopped
appearing. Well, I dove into the fb layer code, noticed this change from
you:

int fb_get_color_depth(struct fb_info *info)
{
    struct fb_var_screeninfo *var =3D &info->var;

    if (var->green.length =3D=3D var->blue.length &&
        var->green.length =3D=3D var->red.length &&
        !var->green.offset && !var->blue.offset &&
        !var->red.offset)
        return var->green.length;
    else
        return (var->green.length + var->red.length +
            var->blue.length);
}

That was interesting, because here's what radeonfb does:

        switch (var_to_depth(&v)) {
[...]
                case 16:
                        nom =3D 2;
                        den =3D 1;
                        v.red.offset =3D 11;
                        v.green.offset =3D 5;
                        v.blue.offset =3D 0;
                        v.red.length =3D 5;
                        v.green.length =3D 6;
                        v.blue.length =3D 5;
                        v.transp.offset =3D v.transp.length =3D 0;
                        break;
[...]

So somehow that first conditional was firing, although I'm not sure how,
because a printk showed that the depth returned was 6. (fb_get_color_depth
should have jumped to the return (R + G + B) part right after it noticed
blue length was not equal to green length. Creepy.)

Well, whatever. The 224-color logo was ignored. This is what I did to
fix it:

--- a/drivers/video/fbmem.c	2004/09/23 01:19:45	1.102
+++ b/drivers/video/fbmem.c	2004/10/10 22:47:14
@@ -65,10 +65,8 @@
 {
 	struct fb_var_screeninfo *var =3D &info->var;
=20
-	if (var->green.length =3D=3D var->blue.length &&
-	    var->green.length =3D=3D var->red.length &&
-	    !var->green.offset && !var->blue.offset &&
-	    !var->red.offset)
+	/* If grayscale, all values will be equal */
+	if (var->grayscale)
 		return var->green.length;
 	else
 		return (var->green.length + var->red.length +

because on advice from Andrew Suffield and Matthew Garrett the first
conditional was a roundabout way to check for grayscale displays, where
you can't actually have 24 bits (8 + 8 + 8) of gray. So it is suitable
to just return one of the values arbitrarily. But I noticed there was
also a grayscale variable, so I substituted that for the conditional
and my logo reappeared again :)

So is radeonfb or fb_get_color_depth at fault here? Or was the logo
never appropriate for my display in the first place? (Unlikely, the
CLUT224 linux logo always displayed perfectly for me until now.)

Thanks.

--=20
Joshua Kwan

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQWm+t6OILr94RG8mAQJU3RAAiGKuK8prtyltKf/HNqdJpG3GaqW4/OIM
S5oVIXN3SnFba1YUmD0w3AVZFXW/Gc5zL4w9LlZc3bE9VvL/0Xd/aRTMZRyuYz+L
tj142GzOfU87ZQnRWAhFzQE80F00CZIh3oTgbT/Fei01unM0Dorb71cbr/vft8Eq
yOKU9vGi1Ve+815fax/3tIb3vQC17f5AmqCRdlOo2oSDv6cGqKfC6yiYmmuwJNKw
DpmfscRpMhkKJE3zyMVtwT59UD7NX6bR3a/etQYbe0M3c89hhpJr8M5H+y/YQ49Z
I8ifEbFfb849m3DlmNiwzsiuTpv4wYLL/ObJpI/3FexH4RS7o0U2+Tq6pE/yOMZ7
qstQLwvdtsb3ZGpsRO6H/auejXU6bYsWPwDducc7SsbOSUSQQueXJcBNF130qFQ+
k5w6UuxMSeKZX8fXFbptLnvFN0FV6N6rBafsoTCvEM3oTpraNKP2oHvhGrf19gZ6
Ul//IthLOeXr830sAmPiGHdl4smR2T6XyXNJAdzMI3bE5IZjr228GXJZ4ZMoVrqJ
TxOsnipyfYg+S6NtovLZyLHgrqEW/j6QyqNVHk4os7UXPIfEdjzGWGX20QCJb8Y5
E0CcgViqfPFwtwi669Nkzfo3mLvTHgX+wmhKnCv1ZI1XmEajKJWHebuO5pi/sCgU
uNjA5SWym2o=
=b+Tt
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
