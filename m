Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWFLFJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWFLFJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 01:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWFLFJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 01:09:59 -0400
Received: from pops.net-conex.com ([204.244.176.3]:18918 "EHLO
	mail.net-conex.com") by vger.kernel.org with ESMTP id S1751332AbWFLFJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 01:09:58 -0400
Date: Sun, 11 Jun 2006 22:10:01 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] tmpfs time granularity fix for [acm]time going backwards. Also VFS time granularity bug on creat(). (Repost, more content)
Message-ID: <20060612051001.GA18634@curie-int.vc.shawcable.net>
References: <20060611115421.GE26475@curie-int.vc.shawcable.net> <Pine.LNX.4.64.0606111833220.15060@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606111833220.15060@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2006 at 07:10:31PM +0100, Hugh Dickins wrote:
> On Sun, 11 Jun 2006, Robin H. Johnson wrote:
> > After some digging, I found that this was being caused by tmpfs not hav=
ing a
> > time granularity set, thus inheriting the default 1s granularity.
> That's a great little discovery, and a very good report and analysis:
> thank you.  Seems tmpfs got missed when s_time_gran was added in 2.6.11,
> and I (tmpfs maintainer) failed to notice that patch going past.
Ah, ok, it was mentioned to me there was a maintainer for tmpfs, but I
found no mention of you in the tmpfs source, or MAINTAINERS. Maybe
submit a patch ;-).

> Perhaps we could devise a debug WARN_ON somewhere to check consistent
> granularity; but I don't have the ingenuity right now, and would need
> an additional superblock field or flag to not spam the logs horribly.
> Perhaps it's easier just to delete CURRENT_TIME, converting its users.
Yes, I'd agree that replacing CURRENT_TIME in filesystems with
current_fs_time should be worthwhile for all filesystems - That,
combined with your patch below to ensure they all use s_time_gran,
should ensure safety.

A total removal of CURRENT_TIME wouldn't work, there are a few other
users besides setting [acm]times - however as above, we should be able
to kill it for all filesystems.

However CURRENT_TIME_SEC looks safe to convert, all of it's users are
filesystems.

> Setting that safety aside, the patch below (against 2.6.17-rc6) looks
> to me like all that's currently needed in mainline - but ecryptfs and
> reiser4 in the mm tree will also want fixing, and more discrepancies
> are sure to trickle in later.
I checked at well, and this does cover every filesystem I see in the
mainline.

> If anyone thinks tmpfs is the most important to fix (I would think
> that, wouldn't I?), I can forward your fix to Linus ahead of the rest.
> Or if people agree the patch below is good, I can sign it off and send;
> or FS maintainers extract their own little parts.
I'd appreciate it tmpfs either of the fixes actually making it to
2.6.17, there are a reasonable number of Gentoo users that use tmpfs as
temporary storage to compile stuff, and there's a long-standing argument
that tmpfs wasn't safe for that, due to this bug ;-).

Acked-By: Robin H. Johnson <robbat2@gentoo.org>
[snip]

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFEjPcpPpIsIjIzwiwRArQ1AJ9jbSHTbv4QR7Y185A0PO+oPVMk9wCg8jv8
M5qtncMAxt2n4wWZpnEVFgY=
=oUaV
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
