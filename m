Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132574AbRAXGHl>; Wed, 24 Jan 2001 01:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132585AbRAXGHb>; Wed, 24 Jan 2001 01:07:31 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:1035 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S132574AbRAXGH0>; Wed, 24 Jan 2001 01:07:26 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Date: Wed, 24 Jan 2001 17:06:55 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14958.28927.756597.940445@notabene.cse.unsw.edu.au>
Cc: Linux NFS mailing list <nfs@lists.sourceforge.net>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [NFS] Linux 2.2.18 nfs v3 server bug (was: Incompatible: FreeBSD 4.2 client, Linux 2.2.18 nfsv3 server, read-only export)
In-Reply-To: message from Matthias Andree on Wednesday January 24
In-Reply-To: <20010123015612.H345@quadrajet.flashcom.com>
	<20010123162930.B5443@emma1.emma.line.org>
	<wuofwynsj5.fsf_-_@bg.sics.se>
	<20010123105350.B344@quadrajet.flashcom.com>
	<20010124041437.A28212@emma1.emma.line.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday January 24, matthias.andree@stud.uni-dortmund.de wrote:
> (Please consider removing FreeBSD-stable from the recipient list when
> replying.)
freebsd-stable removed!  reiserfs gone. Who goes next:-? Alan?
> 
> Summary:
> 
> The Linux 2.2.18 NFS v3 server returns bogus and as per RFC-1813 invalid
> NFS3ERR_ROFS to ACCESS procedure calls when exporting a file system
> read-only, when it should instead return "OK" along with the actual
> permissions the client has, ANDed with the permissions the client
> queried. 
> 
> The bug is visible on FreeBSD 4.2-STABLE client which cannot ls The
> mounted file system (NFS v2 is fine since it does not have ACCESS).
> There is no related log entry in the 2.2.19pre7 change log.  I did not
> check Linux 2.4.0, 2.4.0-acX or 2.4.1-preX either.

To summarise the summary of the summary:
I stuffed up when I tried to interpret the error, but after much
sensible correction, here is a patch.  Please try it, and suggest any
other errs that should be tested for (or maybe we should invert the
sense of the test, and test for error codes that ACCESS is allowed to
return.
2.4.0 seems to get it right.

NeilBrown

--- ./fs/nfsd/vfs.c	2001/01/10 05:03:28	1.11
+++ ./fs/nfsd/vfs.c	2001/01/24 06:02:01
@@ -448,7 +448,9 @@
 			error = nfsd_permission(export, dentry, (map->how | NO_OWNER_OVERRIDE));
 			if (error == 0)
 				result |= map->access;
-			else if ((error == nfserr_perm) || (error == nfserr_acces)) {
+			else if ((error == nfserr_perm) ||
+				 (error == nfserr_acces) ||
+				 (error == nfserr_rofs)) {
 				/*
 				 *  This access type is denyed; but the 
 				 *  access query itself succeeds.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
