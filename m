Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUGCMxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUGCMxU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 08:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265088AbUGCMxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 08:53:20 -0400
Received: from spoolo2.tiscali.be ([62.235.13.173]:27815 "EHLO
	spoolo2.tiscali.be") by vger.kernel.org with ESMTP id S265087AbUGCMxI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 08:53:08 -0400
Message-ID: <40E6AC41.4050804@tiscali.be>
Date: Sat, 03 Jul 2004 12:53:21 +0000
From: Joel Soete <soete.joel@tiscali.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040624 Debian/1.7-2
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, marcelo.tosatti@cyclades.com
Subject: Some cleanup patches for: '...lvalues is deprecated'
Content-Type: multipart/mixed;
 boundary="------------030803070301050303090008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030803070301050303090008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcelo,

Please appolgies first for wrong presentation of previous post (that was the first and certainly the last time that I used the 
'forwarding' option of this webmail interface :( ).

Here are some backport to clean up some warning of type: use of cast experssion
as lvalues is deprecated.
--- linux-2.4.27-rc2-pa4mm/kernel/sysctl.c.Orig	2004-06-29 09:03:42.000000000 +0200
+++ linux-2.4.27-rc2-pa4mm/kernel/sysctl.c	2004-06-29 10:10:31.588030256 +0200
@@ -890,7 +890,7 @@
  				if (!isspace(c))
  					break;
  				left--;
-				((char *) buffer)++;
+				buffer += sizeof(char);
  			}
  			if (!left)
  				break;
@@ -1043,7 +1043,7 @@
  				if (!isspace(c))
  					break;
  				left--;
-				((char *) buffer)++;
+				buffer += sizeof(char);
  			}
  			if (!left)
  				break;
@@ -1144,7 +1144,7 @@
  				if (!isspace(c))
  					break;
  				left--;
-				((char *) buffer)++;
+				buffer += sizeof(char);
  			}
  			if (!left)
  				break;
=========><=========
--- linux-2.4.27-rc2-pa4mm/fs/readdir.c.Orig	2004-06-29 11:18:46.636488264 +0200
+++ linux-2.4.27-rc2-pa4mm/fs/readdir.c	2004-06-29 11:25:40.281604648 +0200
@@ -264,7 +264,7 @@
  	put_user(reclen, &dirent->d_reclen);
  	copy_to_user(dirent->d_name, name, namlen);
  	put_user(0, dirent->d_name + namlen);
-	((char *) dirent) += reclen;
+	dirent = (void *)dirent + reclen;
  	buf->current_dir = dirent;
  	buf->count -= reclen;
  	return 0;
@@ -347,7 +347,7 @@
  	copy_to_user(dirent, &d, NAME_OFFSET(&d));
  	copy_to_user(dirent->d_name, name, namlen);
  	put_user(0, dirent->d_name + namlen);
-	((char *) dirent) += reclen;
+	dirent = (void *)dirent + reclen;
  	buf->current_dir = dirent;
  	buf->count -= reclen;
  	return 0;
=========><=========
--- linux-2.4.27-rc2-pa4mm/drivers/video/fbcon.c.Orig	2004-06-29 10:47:31.901491304 +0200
+++ linux-2.4.27-rc2-pa4mm/drivers/video/fbcon.c	2004-06-29 11:13:31.846343640 +0200
@@ -1877,7 +1877,10 @@
         font length must be multiple of 256, at least. And 256 is multiple
         of 4 */
      k = 0;
-    while (p > new_data) k += *--(u32 *)p;
+    while (p > new_data) {
+        p = (u8 *)((u32 *)p - 1);
+        k += *(u32 *)p;
+    }
      FNTSUM(new_data) = k;
      /* Check if the same font is on some other console already */
      for (i = 0; i < MAX_NR_CONSOLES; i++) {
=========><=========
--- linux-2.4.27-rc2-pa4mm/lib/crc32.c.Orig	2004-06-29 11:29:31.721420448 +0200
+++ linux-2.4.27-rc2-pa4mm/lib/crc32.c	2004-06-29 11:36:19.964358088 +0200
@@ -99,7 +99,9 @@
  	/* Align it */
  	if(unlikely(((long)b)&3 && len)){
  		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p = (u8 *)b;
+			DO_CRC(*p++);
+			b = (void *)p;
  		} while ((--len) && ((long)b)&3 );
  	}
  	if(likely(len >= 4)){
@@ -120,7 +122,9 @@
  	/* And the last few bytes */
  	if(len){
  		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p = (u8 *)b;
+			DO_CRC(*p++);
+			b = (void *)p;
  		} while (--len);
  	}

@@ -200,7 +204,9 @@
  	/* Align it */
  	if(unlikely(((long)b)&3 && len)){
  		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p = (u8 *)b;
+			DO_CRC(*p++);
+			b = (void *)p;
  		} while ((--len) && ((long)b)&3 );
  	}
  	if(likely(len >= 4)){
@@ -221,7 +227,9 @@
  	/* And the last few bytes */
  	if(len){
  		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p = (u8 *)b;
+			DO_CRC(*p++);
+			b = (void *)p;
  		} while (--len);
  	}
  	return __be32_to_cpu(crc);
=========><=========

hth,
     Joel

PS: because of bad wrapping pb with mail interface I also join original
files

--------------030803070301050303090008
Content-Type: text/plain;
 name="k-2.4.27-rc2_crc32.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="k-2.4.27-rc2_crc32.c.diff"

--- linux-2.4.27-rc2-pa4mm/lib/crc32.c.Orig	2004-06-29 11:29:31.721420448 +0200
+++ linux-2.4.27-rc2-pa4mm/lib/crc32.c	2004-06-29 11:36:19.964358088 +0200
@@ -99,7 +99,9 @@
 	/* Align it */
 	if(unlikely(((long)b)&3 && len)){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p = (u8 *)b;
+			DO_CRC(*p++);
+			b = (void *)p;
 		} while ((--len) && ((long)b)&3 );
 	}
 	if(likely(len >= 4)){
@@ -120,7 +122,9 @@
 	/* And the last few bytes */
 	if(len){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p = (u8 *)b;
+			DO_CRC(*p++);
+			b = (void *)p;
 		} while (--len);
 	}
 
@@ -200,7 +204,9 @@
 	/* Align it */
 	if(unlikely(((long)b)&3 && len)){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p = (u8 *)b;
+			DO_CRC(*p++);
+			b = (void *)p;
 		} while ((--len) && ((long)b)&3 );
 	}
 	if(likely(len >= 4)){
@@ -221,7 +227,9 @@
 	/* And the last few bytes */
 	if(len){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p = (u8 *)b;
+			DO_CRC(*p++);
+			b = (void *)p;
 		} while (--len);
 	}
 	return __be32_to_cpu(crc);

--------------030803070301050303090008
Content-Type: text/plain;
 name="k-2.4.27-rc2_fbcon.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="k-2.4.27-rc2_fbcon.c.diff"

--- linux-2.4.27-rc2-pa4mm/drivers/video/fbcon.c.Orig	2004-06-29 10:47:31.901491304 +0200
+++ linux-2.4.27-rc2-pa4mm/drivers/video/fbcon.c	2004-06-29 11:13:31.846343640 +0200
@@ -1877,7 +1877,10 @@
        font length must be multiple of 256, at least. And 256 is multiple
        of 4 */
     k = 0;
-    while (p > new_data) k += *--(u32 *)p;
+    while (p > new_data) {
+        p = (u8 *)((u32 *)p - 1);
+        k += *(u32 *)p;
+    }
     FNTSUM(new_data) = k;
     /* Check if the same font is on some other console already */
     for (i = 0; i < MAX_NR_CONSOLES; i++) {

--------------030803070301050303090008
Content-Type: text/plain;
 name="k-2.4.27-rc2_readdir.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="k-2.4.27-rc2_readdir.c.diff"

--- linux-2.4.27-rc2-pa4mm/fs/readdir.c.Orig	2004-06-29 11:18:46.636488264 +0200
+++ linux-2.4.27-rc2-pa4mm/fs/readdir.c	2004-06-29 11:25:40.281604648 +0200
@@ -264,7 +264,7 @@
 	put_user(reclen, &dirent->d_reclen);
 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
-	((char *) dirent) += reclen;
+	dirent = (void *)dirent + reclen;
 	buf->current_dir = dirent;
 	buf->count -= reclen;
 	return 0;
@@ -347,7 +347,7 @@
 	copy_to_user(dirent, &d, NAME_OFFSET(&d));
 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
-	((char *) dirent) += reclen;
+	dirent = (void *)dirent + reclen;
 	buf->current_dir = dirent;
 	buf->count -= reclen;
 	return 0;

--------------030803070301050303090008
Content-Type: text/plain;
 name="k-2.4.27-rc2_sysctl.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="k-2.4.27-rc2_sysctl.c.diff"

--- linux-2.4.27-rc2-pa4mm/kernel/sysctl.c.Orig	2004-06-29 09:03:42.000000000 +0200
+++ linux-2.4.27-rc2-pa4mm/kernel/sysctl.c	2004-06-29 10:10:31.588030256 +0200
@@ -890,7 +890,7 @@
 				if (!isspace(c))
 					break;
 				left--;
-				((char *) buffer)++;
+				buffer += sizeof(char);
 			}
 			if (!left)
 				break;
@@ -1043,7 +1043,7 @@
 				if (!isspace(c))
 					break;
 				left--;
-				((char *) buffer)++;
+				buffer += sizeof(char);
 			}
 			if (!left)
 				break;
@@ -1144,7 +1144,7 @@
 				if (!isspace(c))
 					break;
 				left--;
-				((char *) buffer)++;
+				buffer += sizeof(char);
 			}
 			if (!left)
 				break;

--------------030803070301050303090008--
