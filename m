Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUIAQuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUIAQuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUIAP5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:57:03 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:64434 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267330AbUIAPvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:45 -0400
Date: Wed, 1 Sep 2004 16:51:22 +0100
Message-Id: <200409011551.i81FpMUY000655@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix leaks in ISOFS.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/isofs/rock.c linux-2.6/fs/isofs/rock.c
--- bk-linus/fs/isofs/rock.c	2004-07-01 17:44:12.000000000 +0100
+++ linux-2.6/fs/isofs/rock.c	2004-08-23 14:08:20.000000000 +0100
@@ -153,6 +153,7 @@ int get_rock_ridge_filename(struct iso_d
     }
   }
   MAYBE_CONTINUE(repeat,inode);
+  if (buffer) kfree(buffer);
   return retnamlen; /* If 0, this file did not have a NM field */
  out:
   if(buffer) kfree(buffer);
@@ -351,7 +352,6 @@ int parse_rock_ridge_inode_internal(stru
     }
   }
   MAYBE_CONTINUE(repeat,inode);
-  return 0;
  out:
   if(buffer) kfree(buffer);
   return 0;
@@ -515,6 +515,8 @@ static int rock_ridge_symlink_readpage(s
 		}
 	}
 	MAYBE_CONTINUE(repeat, inode);
+	if (buffer)
+		kfree(buffer);
 
 	if (rpnt == link)
 		goto fail;
