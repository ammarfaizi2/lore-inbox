Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVBHCLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVBHCLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 21:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVBHCLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 21:11:03 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:18439 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261385AbVBHCKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 21:10:48 -0500
Message-Id: <200502080210.j182Aioh007619@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BSD Secure Levels: claim block dev in file struct rather than inode struct, 2.6.11-rc2-mm1 (3/8) 
In-Reply-To: Your message of "Tue, 08 Feb 2005 01:48:40 GMT."
             <cu95po$3ch$1@abraham.cs.berkeley.edu> 
From: Valdis.Kletnieks@vt.edu
References: <20050207192108.GA776@halcrow.us> <20050207193129.GB834@halcrow.us> <20050207142603.A469@build.pdx.osdl.net> <200502072241.j17MfTfP027969@turing-police.cc.vt.edu>
            <cu95po$3ch$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1107828644_17298P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Feb 2005 21:10:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1107828644_17298P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <20601.1107828643.1@turing-police.cc.vt.edu>

On Tue, 08 Feb 2005 01:48:40 GMT, David Wagner said:

> How would /etc/passwd get clobbered?  Are you thinking that a tmp
> cleaner run by cron might delete /tmp/whatever (i.e., delete the hardlink
> you created above)?  But deleting /tmp/whatever is safe; it doesn't affect
> /etc/passwd.  I'm guessing I'm probably missing something.

The attack is to hardlink some tempfile name to some file you want over-written.
This usually involves just a little bit of work, such as recognizing that a given
root cronjob uses an unsafe predictable filename in /tmp (look at the Bugtraq or
Full-Disclosure archives, there's plenty).  Then you set a little program that
sleep()s till a few seconds before the cronjob runs, does a getpid(), and then
sprays hardlinks into the next 15 or 20 things that mktemp() will generate...

Consider how bash implements "here" scripts:

#!/bin/bash
echo << EOF
some trash
EOF

Now let's look at the strace (snipped for brevity..)

statfs("/tmp", {f_type="EXT2_SUPER_MAGIC", f_bsize=1024, f_blocks=253871, f_bfree=213773, f_bavail=200666, f_files=65536, f_ffree=65445, f_fsid={0, 0}, f_namelen=255, f_frsize=1024}) = 0
time(NULL)                              = 1107828098
open("/tmp/sh-thd-1107848098", O_WRONLY|O_CREAT|O_TRUNC|O_EXCL|O_LARGEFILE, 0600) = 3
dup(3)                                  = 4
fcntl64(4, F_GETFL)                     = 0x8001 (flags O_WRONLY|O_LARGEFILE)
fstat64(4, {st_mode=S_IFREG|0600, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7d71000
_llseek(4, 0, [0], SEEK_CUR)            = 0
write(4, "some trash\n", 11)            = 11
close(4)                                = 0
munmap(0xb7d71000, 4096)                = 0
open("/tmp/sh-thd-1107848098", O_RDONLY|O_LARGEFILE) = 4
close(3)                                = 0
unlink("/tmp/sh-thd-1107848098")        = 0
fcntl64(0, F_GETFD)                     = 0
fcntl64(0, F_DUPFD, 10)                 = 10
fcntl64(0, F_GETFD)                     = 0
fcntl64(10, F_SETFD, FD_CLOEXEC)        = 0
dup2(4, 0)                              = 0
close(4)                                = 0

Wow - if my /tmp was on the same partition, and I'd hard-linked that
file to /etc/passwd, it would be toast now if root had run it.

You usually can't control what gets written - but often it's sufficient for the
attacker to simply get a file clobbered....

--==_Exmh_1107828644_17298P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCCB+kcC3lWbTT17ARAk6cAJsGraJ70YanDb/7BKDJaFcrZROK/ACfeg/4
PMGCx4VYkpMalFt05xyHdCM=
=kzJ1
-----END PGP SIGNATURE-----

--==_Exmh_1107828644_17298P--
