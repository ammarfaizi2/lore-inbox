Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266546AbSLJCWV>; Mon, 9 Dec 2002 21:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbSLJCWV>; Mon, 9 Dec 2002 21:22:21 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:50589 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266546AbSLJCWT>; Mon, 9 Dec 2002 21:22:19 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] Fix d_path() truncating excessive long path name vulnerability
Date: Tue, 10 Dec 2002 03:28:21 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Message-Id: <200212100327.18991.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_9JTVTG8HNGHZYPFLX1KM"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_9JTVTG8HNGHZYPFLX1KM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

there isn't fixed the d_path() long name truncation vulnerability
(see http://cert.uni-stuttgart.de/archive/bugtraq/2002/03/msg00384.html) =
in
2.4.x up to 2.4.21-BK.

This trivial patch fixes it. Instead of truncating the path with no error=
,=20
caller gets ENAMETOOLONG.

Patch credits go to Jirka Kosina.

Has been in WOLK and in -aa kernels for ages.

ciao, Marc
--------------Boundary-00=_9JTVTG8HNGHZYPFLX1KM
Content-Type: text/x-diff;
  charset="us-ascii";
  name="getcwd-err-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="getcwd-err-1.patch"

--- linux/fs/dcache.c.orig	Mon Feb 25 20:38:08 2002
+++ linux/fs/dcache.c	Mon Apr  1 04:16:45 2002
@@ -976,14 +976,17 @@
 		parent = dentry->d_parent;
 		namelen = dentry->d_name.len;
 		buflen -= namelen + 1;
-		if (buflen < 0)
-			break;
+		if (buflen < 0){
+			retval = ERR_PTR(-ENAMETOOLONG);
+			goto out;
+		}
 		end -= namelen;
 		memcpy(end, dentry->d_name.name, namelen);
 		*--end = '/';
 		retval = end;
 		dentry = parent;
 	}
+out:
 	return retval;
 global_root:
 	namelen = dentry->d_name.len;
@@ -992,6 +995,8 @@
 		retval -= namelen-1;	/* hit the slash */
 		memcpy(retval, dentry->d_name.name, namelen);
 	}
+	else
+		retval = ERR_PTR(-ENAMETOOLONG);
 	return retval;
 }
 
@@ -1041,8 +1046,11 @@
 		spin_unlock(&dcache_lock);
 
 		error = -ERANGE;
+		
+		if (cwd == ERR_PTR(-ENAMETOOLONG)) error = -ENAMETOOLONG;
+
 		len = PAGE_SIZE + page - cwd;
-		if (len <= size) {
+		if (len <= size && error != -ENAMETOOLONG) {
 			error = len;
 			if (copy_to_user(buf, cwd, len))
 				error = -EFAULT;

--------------Boundary-00=_9JTVTG8HNGHZYPFLX1KM--

