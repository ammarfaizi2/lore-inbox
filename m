Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315447AbSEBVpL>; Thu, 2 May 2002 17:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315448AbSEBVpK>; Thu, 2 May 2002 17:45:10 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:31142 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315447AbSEBVpI>; Thu, 2 May 2002 17:45:08 -0400
Subject: Re: SEVERE Problems in 2.5.12 at uid0 access
From: Paul Larson <plars@austin.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Bob_Tracy <rct@gherkin.frus.com>, system_lists@nullzone.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0205011417230.12640-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 02 May 2002 16:39:01 -0500
Message-Id: <1020375541.3862.20.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-01 at 13:18, Alexander Viro wrote:
> Yes, it is.  Look for the patch I've posted yesterday (subject was
> something like "[PATCH] missing checks", IIRC).

Before I found this message I was also trying to hunt down this problem
after noticing that 2.5.12 failed unlink08 from LTP.  The thing I think
broke it though was a seemlingly minor change to the handling of the
return value from exec_permission_lite in link_path_walk().  In 2.5.11
it rechecked with permission() if it got an error back from
exec_permission_lite(), but in 2.5.12 it only does this if err ==
-EAGAIN.  This patch also seems to fix the problem, and simply reverts
it back to the original way it was handled rather than adding more code
to exec_permission_lite().  I'll let you decide which is the best way.

Thanks,
Paul Larson

--- linux/fs/namei.c	Thu May  2 18:36:01 2002
+++ linux-fix/fs/namei.c	Thu May  2 18:36:17 2002
@@ -573,7 +573,7 @@
 		unsigned int c;
 
 		err = exec_permission_lite(inode);
-		if (err == -EAGAIN) {
+		if (err) {
 			unlock_nd(nd);
 			err = permission(inode, MAY_EXEC);
 			lock_nd(nd);

