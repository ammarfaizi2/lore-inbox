Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVH3TO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVH3TO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVH3TO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:14:27 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57573 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932224AbVH3TOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:14:25 -0400
Date: Tue, 30 Aug 2005 21:13:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Knut Petersen <Knut_Petersen@t-online.de>
cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Jochen Hein <jochen@jochen.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
In-Reply-To: <43149E5B.7040006@t-online.de>
Message-ID: <Pine.LNX.4.61.0508302039160.3743@scrub.home>
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be>
 <43149E5B.7040006@t-online.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-1053673453-1125429223=:3743"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-1053673453-1125429223=:3743
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 30 Aug 2005, Knut Petersen wrote:

> > Probably you can make it even faster by avoiding the multiplication, li=
ke
> >=20
> >    unsigned int offset =3D 0;
> >    for (i =3D 0; i < image.height; i++) {
> > =09dst[offset] =3D src[i];
> > =09offset +=3D pitch;
> >    }
> >=20
>=20
> More than two decades ago I learned to avoid mul and imul. Use shifts, ad=
d and
> lea instead,
> that was the credo those days. The name of the game was CP/M 80/86, a86, =
d86
> and ddt ;-)
>=20
> But let=B4s get serious again.
>=20
> Your proposed change of the patch results in a 21 ms performance decrease=
 on
> my system.
> Yes, I do know that this is hard to believe. I tested a similar variation
> before, and the results
> were even worse.

Could you try the patch below, for a few extra cycles you might want to=20
make it an inline function.

bye, Roman

Index: linux-2.6/drivers/video/fbmem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/video/fbmem.c=092005-08-30 01:55:18.000000000 +0=
200
+++ linux-2.6/drivers/video/fbmem.c=092005-08-30 21:10:25.705462837 +0200
@@ -82,11 +82,11 @@ void fb_pad_aligned_buffer(u8 *dst, u32=20
 {
 =09int i, j;
=20
+=09d_pitch -=3D s_pitch;
 =09for (i =3D height; i--; ) {
 =09=09/* s_pitch is a few bytes at the most, memcpy is suboptimal */
 =09=09for (j =3D 0; j < s_pitch; j++)
-=09=09=09dst[j] =3D src[j];
-=09=09src +=3D s_pitch;
+=09=09=09*dst++ =3D *src++;
 =09=09dst +=3D d_pitch;
 =09}
 }
---1463811837-1053673453-1125429223=:3743--
