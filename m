Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVBDMtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVBDMtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 07:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266246AbVBDMsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 07:48:05 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:50849 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265788AbVBDMq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 07:46:58 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
Date: Fri, 4 Feb 2005 13:36:55 +0100
User-Agent: KMail/1.6.2
Cc: olof@austin.ibm.com (Olof Johansson), linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, trini@kernel.crashing.org,
       paulus@samba.org, anton@samba.org, hpa@zytor.com
References: <20050204072254.GA17565@austin.ibm.com>
In-Reply-To: <20050204072254.GA17565@austin.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_rx2ACsdQv5yQ5uj";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200502041336.59892.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_rx2ACsdQv5yQ5uj
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freedag 04 Februar 2005 08:22, Olof Johansson wrote:
> It's getting pretty old to have see and type cur_cpu_spec->cpu_features
> & CPU_FTR_<feature>, when a shorter and less TLA-ridden macro is more
> readable.
>=20
> This also takes care of the differences between PPC and PPC64 cpu
> features for the common code; most places in PPC could be replaced with
> the macro as well.

I have a somewhat similar patch that does the same to the
systemcfg->platform checks. I'm not sure if we should use the same inline
function for both checks, but I do think that they should be used in a
similar way, e.g. CPU_HAS_FEATURE(x) and PLATFORM_HAS_FEATURE(x).

My implementation of the platform checks tries to be extra clever by turning
runtime checks into compile time checks if possible. This reduces code size
and in some cases execution speed. It can also be used to replace compile
time checks, i.e. it allows us to write

static inline unsigned int readl(const volatile void __iomem *addr)
{
	if (platform_is(PLATFORM_PPC_ISERIES))
		return iSeries_readl(addr);
	if (platform_possible(PLATFORM_PPC_PSERIES))
		return eeh_readl(addr);
	return in_le32();
}

which will always result in the shortest code for any combination of
CONFIG_PPC_ISERIES, CONFIG_PPC_PSERIES and the other platforms.

The required code for this is roughly

enum {
	PPC64_PLATFORM_POSSIBLE =3D
#ifdef CONFIG_PPC_ISERIES
		PLATFORM_ISERIES |
#endif
#ifdef CONFIG_PPC_PSERIES
		PLATFORM_PSERIES |
#endif
#ifdef CONFIG_PPC_PSERIES
		PLATFORM_PSERIES_LPAR |
#endif
#ifdef CONFIG_PPC_POWERMAC
		PLATFORM_POWERMAC |
#endif
#ifdef CONFIG_PPC_MAPLE
		PLATFORM_MAPLE |
#endif
		0,
	PPC64_PLATFORM_ONLY =3D
#ifdef CONFIG_PPC_ISERIES
		PLATFORM_ISERIES &
#endif
#ifdef CONFIG_PPC_PSERIES
		PLATFORM_PSERIES &
#endif
#ifdef CONFIG_PPC_POWERMAC
		PLATFORM_POWERMAC &
#endif
#ifdef CONFIG_PPC_MAPLE
		PLATFORM_MAPLE &
#endif
		-1ul,
};

static inline platform_is(unsigned long platform)
{
	return ((PPC64_PLATFORM_ONLY & platform)=20
	 || (PPC64_PLATFORM_POSSIBLE & platform & systemcfg->platform));
}

static inline platform_possible(unsigned long platform)
{
	reutrn !!(PPC64_PLATFORM_POSSIBLE & platform);
}

The same stuff is obviously possible for cur_cpu_spec->cpu_features as well.
Do you think that it will help there?

	Arnd <><

--Boundary-02=_rx2ACsdQv5yQ5uj
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCA2xr5t5GS2LDRf4RAmW/AKCS4KSLE8HSoEKKxV0OvPS9PygJygCfdNF7
SzqF3zkYQhZxZFuP2ZH0O5A=
=StYX
-----END PGP SIGNATURE-----

--Boundary-02=_rx2ACsdQv5yQ5uj--
