Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUHIPyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUHIPyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUHIPwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:52:51 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:42637 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266725AbUHIPvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:51:21 -0400
Subject: Re: dynamic /dev security hole?
From: Albert Cahalan <albert@users.sf.net>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Eric Lammerts <eric@lammerts.org>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       Greg KH <greg@kroah.com>, albert@users.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200408091530.55244.mbuesch@freenet.de>
References: <20040808162115.GA7597@kroah.com>
	 <20040809000727.1eaf917b.Ballarin.Marc@gmx.de>
	 <Pine.LNX.4.58.0408090025590.26834@vivaldi.madbase.net>
	 <200408091530.55244.mbuesch@freenet.de>
Content-Type: text/plain
Organization: 
Message-Id: <1092057570.5761.215.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Aug 2004 09:19:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 09:30, Michael Buesch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Quoting Eric Lammerts <eric@lammerts.org>:
> > Just an idea for a fix for this problem: If udev would change the
> > permissions to 000 and ownership to root.root just before it unlinks
> > the device node, the copy would become useless.
> 
> Like this?
> Only compile tested against glibc.

Pretty much, but you must change ownership first to
keep the user from changing the mode back. There are
ways for an evildoer to win this race if you don't
change the ownership first.

Now all we need is revoke() and we're all set.
Ordering: chown, chmod, revoke, unlink

BTW, I'm make revoke() just force re-verification
of file access.

> ===== udev-remove.c 1.31 vs edited =====
> - --- 1.31/udev-remove.c	2004-04-01 04:12:56 +02:00
> +++ edited/udev-remove.c	2004-08-09 15:23:12 +02:00
> @@ -79,6 +79,23 @@
>  	strfieldcat(filename, dev->name);
>  
>  	info("removing device node '%s'", filename);
> +	/* first remove all permissions on the device node.
> +	 * This fixes a security issue. If the user created
> +	 * a hard-link to the device node, he can't use this
> +	 * anymore, if we change permissions.
> +	 */
> +	retval = chmod(filename, 0000);
> +	if (retval) {
> +		info("chmod(%s, 0000) failed with error '%s'",
> +		     filename, strerror(errno));
> +		// we continue nevertheless.
> +	}
> +	retval = chown(filename, 0, 0);
> +	if (retval) {
> +		info("chown(%s, 0, 0) failed with error '%s'",
> +		     filename, strerror(errno));
> +		// we continue nevertheless.
> +	}
>  	retval = unlink(filename);
>  	if (errno == ENOENT)
>  		retval = 0;


