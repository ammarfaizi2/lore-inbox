Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTKHAND (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbTKGWLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:11:42 -0500
Received: from h80ad25c7.async.vt.edu ([128.173.37.199]:54400 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263922AbTKGHI2 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 02:08:28 -0500
Message-Id: <200311070708.hA778Pe8008356@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord dev=/dev/hdd in 2.9.0-test9-mm2: lots (LOTS) of error messages 
In-Reply-To: Your message of "Thu, 06 Nov 2003 14:43:14 +0100."
             <20031106134314.GA3282@middle.of.nowhere> 
From: Valdis.Kletnieks@vt.edu
References: <20031106134314.GA3282@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1654963184P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Nov 2003 02:08:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1654963184P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 Nov 2003 14:43:14 +0100, Jurriaan <thunder7@xs4all.nl>  said:
> I tried to burn a CD using this command-line in 2.6.0-test9-mm2:
> 
> sudo cdrecord -v dev="/dev/hdd" -dao -useinfo *.wav
> 
> Result:
> 
> [this about 5 times per second]
> Nov  6 14:37:17 middle kernel: arq->state 4
> Nov  6 14:37:17 middle kernel: Badness in as_put_request at drivers/block/as-
iosched.c:1783

I'm seeing this as well burning an ISO in TAO mode on /dev/hdb, but slightly different traceback:

Nov  6 16:03:06 turing-police kernel: arq->state 4
Nov  6 16:03:07 turing-police kernel: Badness in as_put_request at drivers/block/as-iosched.c:1783
Nov  6 16:03:07 turing-police kernel: Call Trace:
Nov  6 16:03:07 turing-police kernel:  [as_put_request+113/140] as_put_request+0x71/0x8c
Nov  6 16:03:07 turing-police kernel:  [elv_put_request+19/23] elv_put_request+0x13/0x17
Nov  6 16:03:07 turing-police kernel:  [__blk_put_request+91/133] __blk_put_request+0x5b/0x85
Nov  6 16:03:07 turing-police kernel:  [blk_put_request+35/67] blk_put_request+0x23/0x43
Nov  6 16:03:07 turing-police kernel:  [sg_io+955/1072] sg_io+0x3bb/0x430
Nov  6 16:03:07 turing-police kernel:  [scsi_cmd_ioctl+520/1204] scsi_cmd_ioctl+0x208/0x4b4
Nov  6 16:03:07 turing-police kernel:  [avc_has_perm+57/67] avc_has_perm+0x39/0x43
Nov  6 16:03:07 turing-police kernel:  [__copy_from_user_ll+76/90] __copy_from_user_ll+0x4c/0x5a
Nov  6 16:03:07 turing-police kernel:  [cdrom_ioctl+29/3404] cdrom_ioctl+0x1d/0xd4c
Nov  6 16:03:07 turing-police kernel:  [write_chan+432/451] write_chan+0x1b0/0x1c3
Nov  6 16:03:07 turing-police kernel:  [default_wake_function+0/24] default_wake_function+0x0/0x18
Nov  6 16:03:07 turing-police kernel:  [selinux_file_permission+289/300] selinux_file_permission+0x121/0x12c
Nov  6 16:03:07 turing-police kernel:  [idecd_ioctl+55/66] idecd_ioctl+0x37/0x42
Nov  6 16:03:07 turing-police kernel:  [blkdev_ioctl+797/816] blkdev_ioctl+0x31d/0x330
Nov  6 16:03:07 turing-police kernel:  [sys_ioctl+512/583] sys_ioctl+0x200/0x247
Nov  6 16:03:07 turing-police kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov  6 16:03:07 turing-police kernel:  [pfkey_xfrm_state2msg+686/2757] pfkey_xfrm_state2msg+0x2ae/0xac5

(pfkey_xfrm_state2msg()??? But I'm not doing ipsec - is the traceback on crack? ;)

In addition, I end up with a bad burn because *something* is managing to
starve off reading the ISO off disk and we get a buffer underrun.

Under earlier kernels (-test7 or so), the input buffer stayed around 90+%,
here it would start off near empty, get up to about 50%, then slowly go down
till it hit zero, got an underrun, and croaked.  One CD got 9M in, another
got 38M in.  Decided to wait till I had more blanks handy before debugging
more.  (I admit not knowing if the problem is the AS elevator, or
Con's swappiness patch).

Yes, the source disk hda and target CD/RW hdb are on the same IDE
controller, blame Dell.. ;) (though it's worked fine for a year till now).

--==_Exmh_-1654963184P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/q0TocC3lWbTT17ARArcJAJwKOgua0CCV6UvQ16xS/X927wrp7gCg9qya
K3tMZHXKbmhXsiuAbkHiygU=
=Gb3Z
-----END PGP SIGNATURE-----

--==_Exmh_-1654963184P--
