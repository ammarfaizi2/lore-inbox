Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbULYSgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbULYSgG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 13:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbULYSgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 13:36:06 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:40579 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261536AbULYSfy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 13:35:54 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Jeremy Huddleston <eradicator@gentoo.org>
Subject: Re: [PATCH][2/2] - catch ignored copy_*_user() - fs/compat_ioctl.c
Date: Sat, 25 Dec 2004 19:34:38 +0100
User-Agent: KMail/1.6.2
References: <1103976267.1006.34.camel@cid.outersquare.org>
In-Reply-To: <1103976267.1006.34.camel@cid.outersquare.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200412251934.48509.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jeremy,

On Saturday 25 December 2004 13:04, Jeremy Huddleston wrote:
> And one more...

Patch attached not inlined, so you have to figure yourself :-(

Could you do the "binary OR trick"?

Such that

if (__put_user() || __put_user() || __put_user()) return -EFAULT;

becomes:

err  = __put_user();
err |= __put_user();
err |= __put_user();
if (err) return -EFAULT;

This saves branches, which speeds up code for the common case
and reduces size. Downside is more faults, but this hurts only for
broken software, which deserves this behavior ;-)

This optimization works only if:
 - function returns either zero or exact the same value.
 - we don't mind having all these other calls executed,
   even if the first failed already.

Which is true for __put_user() and __get_user(), 
but works the other way around for __copy_{from,to}_user().
But since 0 is succes on __copy_{from,to}_user(), you
can even do this trick there and have only ONE branch instead
of 3-6 in your code.

You'll find this pattern in many places in the Kernel.


Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBzbLGU56oYWuOrkARAlGkAJ4nm909AVDY96Q9PKE92tbGKbAUygCfT+64
oRC6L0uwFbL14o0ThhGnMY0=
=Mj1F
-----END PGP SIGNATURE-----
