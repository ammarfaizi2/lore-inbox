Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVEPUgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVEPUgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVEPUgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:36:36 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:13074 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261849AbVEPUgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:36:21 -0400
Message-Id: <200505162035.j4GKZVCc018357@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
Cc: fs@ercist.iscas.ac.cn, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFD] What error should FS return when I/O failure occurs? 
In-Reply-To: Your message of "Tue, 17 May 2005 05:11:13 +0900."
             <20050517.051113.132843723.okuyamak@dd.iij4u.or.jp> 
From: Valdis.Kletnieks@vt.edu
References: <1116263665.2434.69.camel@CoolQ> <200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu>
            <20050517.051113.132843723.okuyamak@dd.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116275730_5623P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 16 May 2005 16:35:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116275730_5623P
Content-Type: text/plain; charset=us-ascii

On Tue, 17 May 2005 05:11:13 +0900, Kenichi Okuyama said:

> According to QuFuPing's test, USB cable was UNPLUGGED. That means,
> device is gone, and device driver instantly (well.. within second or
> two) detected that fact.  How could ext3 mounted device that does
> not exist, as Read Only?

I thought we were talking about write requests - which were getting short-circuited
because the file system was R/O before we even tried to talk to the actual
file system.  No sense in queueing a write I/O when it's known to be R/O.

If you're trying to *read* from the now-absent disk and encounter a page
that's not already in the cache, yes, you'll probably be returning an EIO.

> I don't see the reason why cache is still available.
> # I mean why such a implementation is valid.
> 
> If storage is known to be lost by device driver, we should not use
> that cache anymore.

Why?  If the disk disappeared out from under us because it was an unplugged USB
device, there's at least a possibility of it reappearing via hotplug - presumably
if you verify the UUID that it's the *same* file system, hotplug could do a
'mount -o remount' and recover the situation....

(Of course, this may not be practical if we've already tried a write-out due to
memory pressure or the like, and may not fit well into the innards of the VFS - but
it's certainly not an outrageously daft thing to attempt - "User unplugged before
we finished writing, but we still have all the needed pages, so we can re-drive
the sync to disk as if nothing happened"....)


--==_Exmh_1116275730_5623P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCiQQScC3lWbTT17ARAr9hAJ9NpepLCRx73ETGA+uqSjmxweKI8gCgmzJZ
A17HwQwZ5Qn2pzjYOJQ7T3Y=
=PY+V
-----END PGP SIGNATURE-----

--==_Exmh_1116275730_5623P--
