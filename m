Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275682AbRJBQ6m>; Tue, 2 Oct 2001 12:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275739AbRJBQ6d>; Tue, 2 Oct 2001 12:58:33 -0400
Received: from ns.suse.de ([213.95.15.193]:55309 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S275682AbRJBQ6Z> convert rfc822-to-8bit;
	Tue, 2 Oct 2001 12:58:25 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] NFSv3 symlink bug
X-Yow: I'm using my X-RAY VISION to obtain a rare glimpse of the
 INNER WORKINGS of this POTATO!!
From: Andreas Schwab <schwab@suse.de>
Date: 02 Oct 2001 18:58:53 +0200
Message-ID: <jelmiuj7w2.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.107
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NFSv3 server in the 2.4.10 kernel has a bug in the symlink
implementation.  The target pathname of the symlink is not necessarily
zero terminated when passed to vfs_symlink.  This does not happen with
NFSv2, because it explicitly zero terminates the string when decoding it
from XDR (xdr_decode_string does this), but NFSv3 uses
xdr_decode_string_inplace.  As a result you may get a spurious
ENAMETOOLONG when trying to create a symbolic link on a NFSv3 mounted
filesystem (if the length of the target path is a multiple of four).  If
you don't get an error the created symlink will have random characters
appended, which exposes kernel memory to user space (that's why it's a
security problem).

This patch changes the NFSv3 xdr function to use xdr_decode_string for the
symlink target, which seems to be the easiest solution.  I also considered
adding an additional parameter to vfs_symlink to pass the length, but that
requires changes in each and every filesystem and changes the VFS API.
That could be a task for 2.5.x.

--- linux/fs/nfsd/nfs3xdr.c.~1~	Fri Sep 21 06:02:01 2001
+++ linux/fs/nfsd/nfs3xdr.c	Tue Oct  2 16:12:27 2001
@@ -99,7 +99,11 @@
 	char		*name;
 	int		i;
 
-	if ((p = xdr_decode_string_inplace(p, namp, lenp, NFS3_MAXPATHLEN)) != NULL) {
+	/*
+	 * Cannot use xdr_decode_string_inplace here, the name must be
+	 * zero terminated for vfs_symlink.
+	 */
+	if ((p = xdr_decode_string(p, namp, lenp, NFS3_MAXPATHLEN)) != NULL) {
 		for (i = 0, name = *namp; i < *lenp; i++, name++) {
 			if (*name == '\0')
 				return NULL;

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
