Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153890-4055>; Wed, 30 Sep 1998 06:00:15 -0400
Received: from post-11.mail.demon.net ([194.217.242.40]:42751 "EHLO post.mail.demon.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <153933-4055>; Wed, 30 Sep 1998 05:55:47 -0400
Message-ID: <19980930154303.A14398@tantalophile.demon.co.uk>
Date: Wed, 30 Sep 1998 15:43:03 +0100
From: Jamie Lokier <lkd@tantalophile.demon.co.uk>
To: linux-kernel@vger.rutgers.edu
Cc: torvalds@transmeta.com
Subject: [PATCH] Buffer overflow in fs/devpts/root.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux-kernel@vger.rutgers.edu
Reply-To: linux-kernel@vger.rutgers.edu

I haven't tested this, but it should be self explanatory.
I don't even use devpts, I just spotted this while reading.

If you look up a name like /dev/pts/9999 it'd get messy.
If you look up /dev/pts/4294967296, it'd be accepted and a dentry
kept for it.  That's silly.

-- Jamie

--- /usr/src/linux/fs/devpts/root.c	Wed Aug 26 19:18:54 1998
+++ /tmp/root.c	Wed Sep 30 15:39:35 1998
@@ -152,12 +152,16 @@
 		if ( *p < '1' || *p > '9' )
 			return 0;
 		entry = *p++ - '0';
+		if ( entry >= sbi->max_ptys )
+			return 0;
 
 		for ( i = dentry->d_name.len-1 ; i ; i-- ) {
 			if ( *p < '0' || *p > '9' )
 				return 0;
 			entry *= 10;
 			entry += (*p++ - '0');
+			if ( entry >= sbi->max_ptys )
+				return 0;
 		}
 	}
 	
----- end of patch -----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
