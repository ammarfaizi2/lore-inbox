Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbVCPWxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVCPWxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVCPWxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:53:13 -0500
Received: from mail.dif.dk ([193.138.115.101]:17792 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262846AbVCPWwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:52:36 -0500
Date: Wed, 16 Mar 2005 23:54:05 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Eric Youngdale <eric@andante.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][1/2] isofs: kfree handles NULL pointers fine (rock.c)
Message-ID: <Pine.LNX.4.62.0503162340440.2558@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kfree() has no trouble being handed a NULL pointer, so checking for one 
before calling it is redundant. This patch removes the redundant checks in 
fs/isofs/rock.c


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-mm4-orig/fs/isofs/rock.c linux-2.6.11-mm4/fs/isofs/rock.c
--- linux-2.6.11-mm4-orig/fs/isofs/rock.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6.11-mm4/fs/isofs/rock.c	2005-03-16 23:36:30.000000000 +0100
@@ -62,7 +62,7 @@
 }                                     
 
 #define MAYBE_CONTINUE(LABEL,DEV) \
-  {if (buffer) { kfree(buffer); buffer = NULL; } \
+  {kfree(buffer); buffer = NULL; \
   if (cont_extent){ \
     int block, offset, offset1; \
     struct buffer_head * pbh; \
@@ -145,7 +145,7 @@ int get_rock_ridge_filename(struct iso_d
 	retnamlen += rr->len - 5;
 	break;
       case SIG('R','E'):
-	if (buffer) kfree(buffer);
+	kfree(buffer);
 	return -1;
       default:
 	break;
@@ -153,10 +153,10 @@ int get_rock_ridge_filename(struct iso_d
     }
   }
   MAYBE_CONTINUE(repeat,inode);
-  if (buffer) kfree(buffer);
+  kfree(buffer);
   return retnamlen; /* If 0, this file did not have a NM field */
  out:
-  if(buffer) kfree(buffer);
+  kfree(buffer);
   return 0;
 }
 
@@ -355,7 +355,7 @@ parse_rock_ridge_inode_internal(struct i
   }
   MAYBE_CONTINUE(repeat,inode);
  out:
-  if(buffer) kfree(buffer);
+  kfree(buffer);
   return 0;
 }
 
@@ -517,8 +517,7 @@ static int rock_ridge_symlink_readpage(s
 		}
 	}
 	MAYBE_CONTINUE(repeat, inode);
-	if (buffer)
-		kfree(buffer);
+	kfree(buffer);
 
 	if (rpnt == link)
 		goto fail;
@@ -532,8 +531,7 @@ static int rock_ridge_symlink_readpage(s
 
 	/* error exit from macro */
       out:
-	if (buffer)
-		kfree(buffer);
+	kfree(buffer);
 	goto fail;
       out_noread:
 	printk("unable to read i-node block");


