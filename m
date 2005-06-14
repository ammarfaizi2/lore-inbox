Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVFNSgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVFNSgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVFNSgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:36:38 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60165 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261284AbVFNSgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:36:35 -0400
Message-Id: <200506141836.j5EIaR0G022093@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Why is one sync() not enough? 
In-Reply-To: Your message of "Tue, 14 Jun 2005 17:58:36 +0200."
             <9a87484905061408585c52f96b@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050614094141.GE1467@schottelius.org> <20050614125828.GM446@admingilde.org>
            <9a87484905061408585c52f96b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118774186_3658P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Jun 2005 14:36:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118774186_3658P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <22083.1118774186.1@turing-police.cc.vt.edu>

On Tue, 14 Jun 2005 17:58:36 +0200, Jesper Juhl said:

> actually written. Thus it was common in ages past to run  sync ; sync
> ; halt  when shutting down a system since even though the first sync
> might return before writing was done

Actually, it was:

# sync
# sync
# sync
# halt

If you enter 'sync;sync;sync' all 3 will get scheduled almost on top of each
other when you hit return.  If you hit return on each one, the first one starts
running when you hit return, and hopefully completes while you're typing the second
and third ones.....

'sync' on recent Linux kernels appears to be synchronous and not return until
the data is out the door.  If you're seeing 'sync; unmount; sync' being needed,
the most likely cause is that the *first* sync is bogus (as unmount will flush
the buffers too) - and the *second* sync is flushing out blocks from some file
that was opened in the directory *before you did the mount*:

# cd /usr/local  (with nothing mounted on it, so it's an empty dir in /usr)
# touch foo
# tail -f foo &
# mount /usr/local

Now that 'foo' is an open but unreachable file on the /usr filesystem, and will
likely cause the need for a sync *for /usr* after unmounting /usr/local at system
shutdown.

--==_Exmh_1118774186_3658P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCryOqcC3lWbTT17ARAq3/AJ92I7NdpEv0yxauxC85p3bIBQeGrgCdHjeY
IsRBQAshpvwvfuLQmk5AB/g=
=1sAg
-----END PGP SIGNATURE-----

--==_Exmh_1118774186_3658P--
