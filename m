Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWEQNOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWEQNOR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWEQNOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:14:17 -0400
Received: from kenobi.snowman.net ([70.84.9.186]:62108 "EHLO
	kenobi.snowman.net") by vger.kernel.org with ESMTP id S932259AbWEQNOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:14:16 -0400
Date: Wed, 17 May 2006 09:14:15 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Patrick McHardy <kaber@trash.net>
Cc: Amin Azez <azez@ufomechanic.net>, "David S. Miller" <davem@davemloft.net>,
       willy@w.ods.org, gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
Message-ID: <20060517131415.GS7774@kenobi.snowman.net>
Mail-Followup-To: Patrick McHardy <kaber@trash.net>,
	Amin Azez <azez@ufomechanic.net>,
	"David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
	gcoady.lk@gmail.com, laforge@netfilter.org,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
	marcelo@kvack.org
References: <44647280.1030602@trash.net> <446490BB.10801@ufomechanic.net> <44683AFF.4070200@trash.net> <20060515142834.GL7774@kenobi.snowman.net> <4468CD3C.3000908@trash.net> <20060515192738.GN7774@kenobi.snowman.net> <4468DFF6.5020304@trash.net> <20060515204142.GO7774@kenobi.snowman.net> <20060515210342.GP7774@kenobi.snowman.net> <446AC1FB.5070406@trash.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwgCY5hL6Igino+O"
Content-Disposition: inline
In-Reply-To: <446AC1FB.5070406@trash.net>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.6.16-1-vserver-686 (i686)
X-Uptime: 08:53:56 up 9 days,  6:49, 20 users,  load average: 1.45, 1.77, 1.57
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LwgCY5hL6Igino+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Patrick McHardy (kaber@trash.net) wrote:
> OK, updated patch attached. The TTL is now always kept up-to-date.

Yup, that looks good.  Unfortunately, it looks like the lru_list isn't
being kept track of correctly now.  Perhaps I'm reading it wrong but it
*looks* like recent_entry_init() is only initializing the lru_list for
the local entry but doesn't ever add it to the main table lru_list.  My
guess is you were expecting that to be done by recent_entry_update() but
it's never the case that recent_entry_update() is called directly after
recent_entry_init() due to the 'goto out' (my line 199).  Therefore I'm
afraid that a new entry is never added to the lru_list with the current
setup and if nothing is ever updated you'll end up in a bad situation.

I think you can just drop lines 198 & 199 and modify recent_entry_init()
to not put the initial stamp in.  This way, for a new entry to the list,
recent_entry_init() is called still on 195, the return value is updated
just like it would be for an existing entry, and recent_entry_update()
is called to handle adding the latest stamp and updating the lru_list.

Looking at list.h, I *think* that will work (wasn't sure if
list_move_tail() would be upset about the state of the e->lru_list
coming from INIT_LIST_HEAD but I think the __list_del will effectively
be a no-op and so it'll be fine).

	Thanks,

		Stephen

--LwgCY5hL6Igino+O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEayGnrzgMPqB3kigRAlBmAKCQMnvtFv8cT3I8CFnXo9HvXLYgxgCfepCM
469DZk/CDgk2GwqXkJZW0lc=
=+GXs
-----END PGP SIGNATURE-----

--LwgCY5hL6Igino+O--
