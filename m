Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSDACt3>; Sun, 31 Mar 2002 21:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292870AbSDACtT>; Sun, 31 Mar 2002 21:49:19 -0500
Received: from twin.jikos.cz ([217.11.237.146]:4104 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id <S292666AbSDACtN>;
	Sun, 31 Mar 2002 21:49:13 -0500
Date: Mon, 1 Apr 2002 04:49:10 +0200 (CEST)
From: Jirka Kosina <jikos@jikos.cz>
To: linux-kernel@vger.kernel.org
cc: marcelo@conectiva.com.br
Subject: [PATCH] d_path() truncation
Message-ID: <Pine.LNX.4.44.0204010436520.18291-100000@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As I've noticed, there isn't fixed the d_path() long name truncation 
vulnerability 
(http://cert.uni-stuttgart.de/archive/bugtraq/2002/03/msg00384.html) in 
2.4.x up to 2.4.19-pre5 (correct me if I'm wrong).

IMHO this trivial patch fixes it (patch against 2.4.18, no idea about 
2.2.x kernels, should be similar?) - instead of truncating the path with 
no error, caller gets ENAMETOOLONG.

I'm sorry if I've missed something.

Kind regards,

Jirka Kosina.

--- linux/fs/dcache.c.orig	Mon Feb 25 20:38:08 2002
+++ linux/fs/dcache.c	Mon Apr  1 04:16:45 2002
@@ -977,14 +977,17 @@
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
@@ -993,6 +996,8 @@
 		retval -= namelen-1;	/* hit the slash */
 		memcpy(retval, dentry->d_name.name, namelen);
 	}
+	else
+		retval = ERR_PTR(-ENAMETOOLONG);
 	return retval;
 }
 
@@ -1042,8 +1047,11 @@
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



