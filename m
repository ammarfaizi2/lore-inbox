Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267615AbUIDKQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267615AbUIDKQE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267597AbUIDKQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:16:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17628 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269866AbUIDKOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:14:42 -0400
Subject: Re: [RFC/patch] macro_removal_agp_mtrr.diff
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409041053450.25475@skynet>
References: <Pine.LNX.4.58.0409041053450.25475@skynet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D1qu588kYvDyzDovwIXF"
Organization: Red Hat UK
Message-Id: <1094292878.2801.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 04 Sep 2004 12:14:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D1qu588kYvDyzDovwIXF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-09-04 at 12:02, Dave Airlie wrote:
> This patch is the first in the drmfntbl-0-0-2-branch of macro removals
>=20
> This dumps __REALLY_HAVE_AGP and __REALLY_HAVE_MTRR and replaces them wit=
h
> a bitmask of driver features that is checked...
>=20
> I've had to introduce __OS_HAS_AGP and __OS_HAS_MTRR, on Linux these map
> simply to (CONFIG_AGP || CONFIG_AGP_MODULE) and CONFIG_MTRR, however I
> can't remove them completely as we need to build on architectures that
> don't have the AGP or MTRR interfces... but they are much cleaner than th=
e
> old code...


it looks you can nuke most of those.
> -#if __REALLY_HAVE_AGP
> +#if __OS_HAS_AGP
>  	drm_agp_head_t    *agp;	/**< AGP data */
>  #endif

for example does this extra pointer really hurt in the *really* unlikely
case you don't have AGP ?

> +static __inline__ int drm_core_check_feature(struct drm_device *dev, int=
 feature)
> +{
> +	return ((dev->driver_features & feature) ? 1 : 0);
> +}

if you make a drm_core_has_AGP and drm_core_has_MTRR wrapper around
these then...=20


> +#if __OS_HAS_MTRR
> +		if (drm_core_check_feature(dev, DRIVER_USE_MTRR)) {
> +			if ( map->type =3D=3D _DRM_FRAME_BUFFER ||
> +			     (map->flags & _DRM_WRITE_COMBINING) ) {
> +				map->mtrr =3D mtrr_add( map->offset, map->size,
> +						      MTRR_TYPE_WRCOMB, 1 );
> +			}
>  		}

...this would NOT need an ifdef because drm_core_has_MTRR would be a
define to 0 for non-OS_HAS_MTRR machines at which point the compiler
removes the entire code. Eg no ifdef needed and the code gets more
readable.




--=-D1qu588kYvDyzDovwIXF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBOZWOxULwo51rQBIRAqC4AKCTv1wHji+2CC8VwCgMXfvKEwidWQCfaOux
8OMphlYvdNLBG7beTLVlCtw=
=+1ha
-----END PGP SIGNATURE-----

--=-D1qu588kYvDyzDovwIXF--

