Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267679AbUG3Mwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267679AbUG3Mwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 08:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUG3Mwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 08:52:34 -0400
Received: from webmail-benelux.tiscali.be ([62.235.14.106]:13095 "EHLO
	mail.tiscali.be") by vger.kernel.org with ESMTP id S267669AbUG3MwK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 08:52:10 -0400
Date: Fri, 30 Jul 2004 14:51:57 +0200
Message-ID: <40FB9ACA00005567@ocpmta1.freegates.net>
In-Reply-To: <40FB9ACA0000533F@ocpmta1.freegates.net>
From: "Joel Soete" <soete.joel@tiscali.be>
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
To: "Jon Oberheide" <jon@oberheide.org>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Daniel Jacobowitz" <dan@debian.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry but previous time included file were well readable and not this time?
too bad.

So here there are (cut and past? sorry in advance if bad wrapping will occurs)

--- linux-2.4.27-rc3-pa6mm/kernel/sysctl.c.Orig	2004-06-29 09:03:42.000000000
+0200
+++ linux-2.4.27-rc3-pa6mm/kernel/sysctl.c	2004-07-29 11:41:30.021094824
+0200
@@ -883,14 +883,15 @@
 	
 	for (; left && vleft--; i++, first=0) {
 		if (write) {
+			p = buffer;
 			while (left) {
 				char c;
-				if (get_user(c, (char *) buffer))
+				if (get_user(c, p))
 					return -EFAULT;
 				if (!isspace(c))
 					break;
 				left--;
-				((char *) buffer)++;
+				p++;
 			}
 			if (!left)
 				break;
@@ -1036,14 +1037,15 @@
 	
 	for (; left && vleft--; i++, min++, max++, first=0) {
 		if (write) {
+			p = buffer;
 			while (left) {
 				char c;
-				if (get_user(c, (char *) buffer))
+				if (get_user(c, p))
 					return -EFAULT;
 				if (!isspace(c))
 					break;
 				left--;
-				((char *) buffer)++;
+				p++;
 			}
 			if (!left)
 				break;
@@ -1137,14 +1139,15 @@
 	
 	for (; left && vleft--; i++, first=0) {
 		if (write) {
+			p = (char *)buffer;
 			while (left) {
 				char c;
-				if (get_user(c, (char *) buffer))
+				if (get_user(c, p))
 					return -EFAULT;
 				if (!isspace(c))
 					break;
 				left--;
-				((char *) buffer)++;
+				p++;
 			}
 			if (!left)
 				break;
--- linux-2.4.27-rc3-pa6mm/fs/readdir.c.Orig	2004-06-29 11:18:46.000000000
+0200
+++ linux-2.4.27-rc3-pa6mm/fs/readdir.c	2004-07-29 12:54:45.000000000 +0200
@@ -264,7 +264,7 @@
 	put_user(reclen, &dirent->d_reclen);
 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
-	((char *) dirent) += reclen;
+	dirent = (struct linux_dirent *)((char *)dirent + reclen);
 	buf->current_dir = dirent;
 	buf->count -= reclen;
 	return 0;
@@ -347,7 +347,7 @@
 	copy_to_user(dirent, &d, NAME_OFFSET(&d));
 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
-	((char *) dirent) += reclen;
+	dirent = (struct linux_dirent64 *)((char *)dirent + reclen);
 	buf->current_dir = dirent;
 	buf->count -= reclen;
 	return 0;
--- linux-2.4.27-rc3-pa6mm/drivers/video/fbcon.c.Orig	2004-06-29 10:47:31.000000000
+0200
+++ linux-2.4.27-rc3-pa6mm/drivers/video/fbcon.c	2004-07-30 09:21:43.295828520
+0200
@@ -1877,7 +1877,10 @@
        font length must be multiple of 256, at least. And 256 is multiple
        of 4 */
     k = 0;
-    while (p > new_data) k += *--(u32 *)p;
+    while (p > new_data) {
+	p -= 4;
+	k += *(u32 *)p;
+    }
     FNTSUM(new_data) = k;
     /* Check if the same font is on some other console already */
     for (i = 0; i < MAX_NR_CONSOLES; i++) {
=========><=========

> -- Original Message --
> Date: Fri, 30 Jul 2004 11:11:32 +0200
> From: "Joel Soete" <soete.joel@tiscali.be>
> Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
> To: "Jon Oberheide" <jon@oberheide.org>
> Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
>  "Daniel Jacobowitz" <dan@debian.org>,
>  "Vojtech Pavlik" <vojtech@suse.cz>,
>  "Linux Kernel" <linux-kernel@vger.kernel.org>
> 
> 
> Hello *,
> 
> >
> > FYI, lvalue casts are treated as errors in gcc 3.5.
> >
> According to this kind remark, I think so that following attachement patches
> would be interesting.
> Thanks for all relevant remarks to help me to make stuff cleaner.
> 
> Joel
> 
> PS: I don't yet review the lib/crc32.c (sorry I need more effort to review)
> 
> 
> ---------------------------------------------------------------------------
> Tiscali ADSL LIGHT, 19,95 EUR/mois pendant 6 mois, c'est le moment de
faire
> le pas!
> http://reg.tiscali.be/default.asp?lg=fr
> 
> 
> 
> 
> 
> Attachment: drivers-video-fbcon.diff
> 
> 
> Attachment: fs-readdir.diff
> 
> 
> Attachment: kernel-sysctl.diff
> 


---------------------------------------------------------------------------
Tiscali ADSL LIGHT, 19,95 EUR/mois pendant 6 mois, c'est le moment de faire
le pas!
http://reg.tiscali.be/default.asp?lg=fr




