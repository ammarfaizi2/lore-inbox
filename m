Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWEOO2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWEOO2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWEOO2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:28:36 -0400
Received: from kenobi.snowman.net ([70.84.9.186]:43438 "EHLO
	kenobi.snowman.net") by vger.kernel.org with ESMTP id S964908AbWEOO2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:28:35 -0400
Date: Mon, 15 May 2006 10:28:34 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Patrick McHardy <kaber@trash.net>
Cc: Amin Azez <azez@ufomechanic.net>, "David S. Miller" <davem@davemloft.net>,
       willy@w.ods.org, gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
Message-ID: <20060515142834.GL7774@kenobi.snowman.net>
Mail-Followup-To: Patrick McHardy <kaber@trash.net>,
	Amin Azez <azez@ufomechanic.net>,
	"David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
	gcoady.lk@gmail.com, laforge@netfilter.org,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
	marcelo@kvack.org
References: <20060507093640.GF11191@w.ods.org> <egts52hm2epfu4g1b9kqkm4s9cdiv3tvt9@4ax.com> <20060508050748.GA11495@w.ods.org> <20060507.224339.48487003.davem@davemloft.net> <44643BFD.3040708@trash.net> <9a8748490605120409x3851ca4fn14fc9c52500701e4@mail.gmail.com> <44647280.1030602@trash.net> <446490BB.10801@ufomechanic.net> <44683AFF.4070200@trash.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c8JyeaiReRNoiMDS"
Content-Disposition: inline
In-Reply-To: <44683AFF.4070200@trash.net>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.6.16-1-vserver-686 (i686)
X-Uptime: 08:56:02 up 7 days,  6:51, 15 users,  load average: 0.57, 0.94, 1.04
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--c8JyeaiReRNoiMDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Patrick McHardy (kaber@trash.net) wrote:
> Anyway, here goes the first shot at a replacement, it should be fully
> compatible. Comments and testing welcome.

This patch didn't apply cleanly against 2.6.16; I didn't think there had
been other changes since then.  As it was an entire replacement I just
pulled out the '[+ ]' lines from the patch.  Hopefully this doesn't lead
to problems in my review.

It probably would have been better to integrate it with ipset, as I've
mentioned previously.  Other comments:

recent_entry_init() appears to just look for something to delete when
the maximum number of entries has been reached, starting from the hash
position of the address.  The original ipt_recent, quite intentionally,
looked for the *oldest* address to replace.  This meant that the list
only had to be large enough to cover the number of addresses seen in a
given time-period.  This change would mean that the list would need to
be large enough to hold all addresses seen always, to be able to enforce
the time-based rules ipt_recent was written for.

ie: List of 100 addresses.  Highest timeout value in the ruleset is 60
seconds.  Average of 100 individual addresses in a 60-second timeframe.
The old ipt_recent would correctly enforce the 60-second requirement in
the ruleset.  With the new version, as soon as the list was full the
next address could replace any address in the list, even if that address
was only 15 seconds old.

One way to handle this would be to track the highest time value in the
rulesets but as the ruleset is dynamic you could end up throwing away an
address which would have been caught by a rule that was about to be
added.  The old module was written with the expectation of the list
always being full and that it would only be less-than-full shortly after
booting.  By then only removing the oldest entry in the table for each
new address seen the maximum amount of time possible for the given table
size and distinct addresses seen is achieved.

The rest looks good, thanks.

	Stephen

--c8JyeaiReRNoiMDS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEaJASrzgMPqB3kigRAm0EAKCKFc2p3mYr6FBtzIQOCJw6l1uK4ACeKBEa
zEXRvjC7zBx6IcFEpcF8qzs=
=JcO6
-----END PGP SIGNATURE-----

--c8JyeaiReRNoiMDS--
