Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbVHYIuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVHYIuu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 04:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVHYIuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 04:50:50 -0400
Received: from ns2.suse.de ([195.135.220.15]:23457 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964882AbVHYIuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 04:50:50 -0400
Date: Thu, 25 Aug 2005 10:50:39 +0200
From: Kurt Garloff <garloff@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-security-module@wirex.com,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] Call security hooks conditionally if the security_op is filled out.
Message-ID: <20050825085039.GW12218@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Chris Wright <chrisw@osdl.org>, linux-security-module@wirex.com,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20050825012028.720597000@localhost.localdomain> <20050825012149.330707000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fw8vdPO5iEPGjqL+"
Content-Disposition: inline
In-Reply-To: <20050825012149.330707000@localhost.localdomain>
X-Operating-System: Linux 2.6.11.4-21.7-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fw8vdPO5iEPGjqL+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2005 at 06:20:31PM -0700, Chris Wright wrote:
> Call security hooks conditionally if the security_op is filled out.
> Branches can be more efficient than the unconditional indirect function
> call.  Inspired by patch from Kurt Garloff <garloff@suse.de>.
>=20
> Signed-off-by: Chris Wright <chrisw@osdl.org>
> ---
>  include/linux/security.h |  825 +++++++++++++++++++++++-----------------=
-------
>  1 files changed, 411 insertions(+), 414 deletions(-)
>=20
> Index: linus-2.6/include/linux/security.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linus-2.6.orig/include/linux/security.h
> +++ linus-2.6/include/linux/security.h
> @@ -1264,10 +1264,10 @@ static inline int security_init(void)
>  static inline int security_ptrace (struct task_struct * parent, struct t=
ask_struct * child)
>  {
>  #ifdef CONFIG_SECURITY
> -	return security_ops->ptrace (parent, child);
> -#else
> -	return cap_ptrace (parent, child);
> +	if (security_ops->ptrace)
> +		return security_ops->ptrace(parent, child);

You did not like my macro abuse, apparently.
That's too bad, as it allowed you to do changes without changing
hundreds of lines of code.

Just one remark:
Make sure you don't set security_ops->XXX ever back to NULL or you
might take an oops.
Security module unloading is racy and always has been. It's not well
defined at what point in time the new functions become effective.
And we certainly don't want to use locking for performance reasons.
One could think of using RCU, though, thus the security_ops pointer
would only be changed after all CPUs schedule()d ...

In my version of the patches, I maintained the capability_security_ops
structure fully filled-in and pointed security_ops to it, so you'll
always have a valid function pointer. If you wanted to avoid a pointer
compare, I had an integer to look at ...

Thanks for your patches!
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux: SUSE Labs (Director)    <garloff@suse.de>            [Novell Inc]

--Fw8vdPO5iEPGjqL+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDDYZfxmLh6hyYd04RAhiwAJsGh7miovR9rLTh5FmAEe/cjzXmnACg1BBE
dOedIju3297uoUCj0rirCtU=
=0QfU
-----END PGP SIGNATURE-----

--Fw8vdPO5iEPGjqL+--
