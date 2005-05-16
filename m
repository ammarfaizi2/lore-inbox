Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVEPIdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVEPIdq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 04:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVEPIct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 04:32:49 -0400
Received: from h80ad2517.async.vt.edu ([128.173.37.23]:55311 "EHLO
	h80ad2517.async.vt.edu") by vger.kernel.org with ESMTP
	id S261405AbVEPHta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 03:49:30 -0400
Message-Id: <200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: fs <fs@ercist.iscas.ac.cn>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Kenichi Okuyama <okuyama@intellilink.co.jp>
Subject: Re: [RFD] What error should FS return when I/O failure occurs? 
In-Reply-To: Your message of "Mon, 16 May 2005 13:14:25 EDT."
             <1116263665.2434.69.camel@CoolQ> 
From: Valdis.Kletnieks@vt.edu
References: <1116263665.2434.69.camel@CoolQ>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116225327_5152P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 16 May 2005 02:35:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116225327_5152P
Content-Type: text/plain; charset=us-ascii

On Mon, 16 May 2005 13:14:25 EDT, fs said:

> 1. For EXT3 partition , we mount it as RW, but when I/O occurs, the
>    I/O related functions return EROFS(ReadOnly?), while other FSes
>    return EIO.

Only the request that actually caused the I/O error (and thus causing the
system to re-mount the ext3 partition R/O) should get EIO.  EROFS is
the proper error for subsequent requests - because they're being rejected
because the filesystem is R/O.  EIO would be incorrect, because the I/O
wasn't even tried, much less errored - and there's a good chance that
subsequent I/O requests *wouldn't* pull an error. Manwhile, subsequent
requests don't even *know* whether the filesystem was remounted R/O due to
an error, or if some root user said 'mount -o remount,ro'.

> 2. Assume a program doing the following: open - write(async) - close
>    When user-mode app calls sys_write, for EXT2/JFS, no error 
>    returns, for EXT3, EROFS returns, for XFS/ReiserFS, EIO returns.

Remember that the request that actually hits an error could be from a
process that isn't even in existence anymore, if the page has been sitting
in the cache for a while and we're finally sending it to disk.  If you don't
believe me, try this on a machine with lots (1G or 2G or so) memory:

1) cd /usr/src/linux
2) tar cf - . | cat > /dev/null    # just to prime the disk cache
3) make                    # wait a few minutes for it to complete.
4) Now that the 'make' is done, type 'sync' and watch the disk lights blink.

Notice you're syncing the disk blocks written by the various sub-processes
of 'make', all of which are done and long gone.  Who do you report the EIO
to, on what write() request?

(For even more fun - what happens if it's kjournald pushing the blocks out,
not the 'sync' command? ;)

This isn't as easy as it looks....

--==_Exmh_1116225327_5152P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCiD8vcC3lWbTT17ARAv61AJ9VQvzxDM+0NcqiVVvosqGx0wAyWwCffGUb
Z+uMlTwfQfw3m3VvZTRPq8E=
=+T83
-----END PGP SIGNATURE-----

--==_Exmh_1116225327_5152P--
