Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbUKIQtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUKIQtW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 11:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbUKIQtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 11:49:22 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:28894 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261575AbUKIQtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 11:49:03 -0500
Date: Tue, 9 Nov 2004 17:49:02 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Return better error codes from vfat_valid_longname()
Message-ID: <20041109164902.GA14088@neapel230.server4you.de>
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx> <20041109013848.GC6835@neapel230.server4you.de> <87vfcf3uu0.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87vfcf3uu0.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> lsr@neapel230.server4you.de writes:
> 
> 
>>Currently vfat returns -EINVAL if one tries to create a file or directory
>>with an invalid name. This patch changes vfat_valid_longname() to return
>>a more specific error code.
>>
>>POSIX doesn't define a nice error code for invalid filenames, so I chose
>>EACCES -- unlike EINVAL this is a valid error code of mkdir(2). Hope it
>>sort of fits. (EINVAL did *not* fit; it generally seems to point to
>>problems not with the filename  but with e.g. the flags value of open(2)
>>etc.).
> 
> 
> Yes, the error code for this should be consistent on _system_.
> Until we do it, this change would not be useful.

At least ENAMETOOLONG and ENOENT are properly defined error codes. :)

VFAT returning EACCES when trying to access "forbidden" filenames would
be useful right now because it gives better error messages with current
tools. At least the error msg of touch looks less confusing IMHO
(didn't check much other programs).

And I doubt we'll get an official Linux error code for invalid
filenames soon: according to POSIX there are only two forbidden
characters, '/' and '\0', so anything goes.

Anyway, what do you think about the following patch? I just replaced
EACCES by EINVAL.

Thanks,
René



--- ./fs/vfat/namei.c.orig	2004-11-08 21:33:35.000000000 +0100
+++ ./fs/vfat/namei.c	2004-11-08 21:32:52.000000000 +0100
@@ -184,10 +184,13 @@ static int vfat_valid_longname(const uns
 {
 	const unsigned char *p;
 
-	if (len && name[len-1] == ' ')
-		return 0;
-	if (len >= 256)
-		return 0;
+	if (len == 0)
+		return -ENOENT;
+	if (len > 255)
+		return -ENAMETOOLONG;
+
+	if (name[len-1] == ' ')
+		return -EINVAL;
 
 	/* MS-DOS "device special files" */
 	if (len == 3 || (len > 3 && name[3] == '.')) {	/* basename == 3 */
@@ -195,24 +198,24 @@ static int vfat_valid_longname(const uns
 		    !strnicmp(name, "con", 3) ||
 		    !strnicmp(name, "nul", 3) ||
 		    !strnicmp(name, "prn", 3))
-			return 0;
+			return -EINVAL;
 	}
 	if (len == 4 || (len > 4 && name[4] == '.')) {	/* basename == 4 */
 		/* "com1", "com2", ... */
 		if ('1' <= name[3] && name[3] <= '9') {
 			if (!strnicmp(name, "com", 3) ||
 			    !strnicmp(name, "lpt", 3))
-				return 0;
+				return -EINVAL;
 		}
 	}
 
 	/* check for invalid characters */
 	for (p = name; p < name + len; p++) {
 		if (*p < 0x0020 || strchr("*?<>|\":\\", *p) != NULL)
-			return 0;
+			return -EINVAL;
 	}
 
-	return 1;
+	return 0;
 }
 
 static int vfat_find_form(struct inode *dir, unsigned char *name)
@@ -615,8 +618,9 @@ static int vfat_build_slots(struct inode
 	loff_t offset;
 
 	*slots = 0;
-	if (!vfat_valid_longname(name, len))
-		return -EINVAL;
+	res = vfat_valid_longname(name, len);
+	if (res)
+		return res;
 
 	if(!(page = __get_free_page(GFP_KERNEL)))
 		return -ENOMEM;
