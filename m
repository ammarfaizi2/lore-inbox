Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbUKISgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbUKISgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUKISgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:36:14 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:37086 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261613AbUKISf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:35:57 -0500
Date: Tue, 9 Nov 2004 19:35:56 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Return better error codes from vfat_valid_longname()
Message-ID: <20041109183556.GB15288@neapel230.server4you.de>
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx> <20041109013848.GC6835@neapel230.server4you.de> <87vfcf3uu0.fsf@devron.myhome.or.jp> <20041109164902.GA14088@neapel230.server4you.de> <87bre7j58b.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bre7j58b.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 02:35:00AM +0900, OGAWA Hirofumi wrote:
> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
> 
> > At least ENAMETOOLONG and ENOENT are properly defined error codes. :)
> 
> Ah, yes. IIRC I already fixed the ENOENT case.
> We shouldn't need "len == 0" check, right?

Yes. I removed the check and rediffed the patch against the one I sent
a few minutes ago.

René



--- ./fs/vfat/namei.c.orig	2004-11-09 19:32:40.000000000 +0100
+++ ./fs/vfat/namei.c	2004-11-09 19:32:24.000000000 +0100
@@ -200,10 +200,10 @@ static inline int vfat_is_used_badchars(
 
 static int vfat_valid_longname(const unsigned char *name, unsigned int len)
 {
-	if (len && name[len-1] == ' ')
-		return 0;
+	if (name[len-1] == ' ')
+		return -EINVAL;
 	if (len >= 256)
-		return 0;
+		return -ENAMETOOLONG;
 
 	/* MS-DOS "device special files" */
 	if (len == 3 || (len > 3 && name[3] == '.')) {	/* basename == 3 */
@@ -211,18 +211,18 @@ static int vfat_valid_longname(const uns
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
 
-	return 1;
+	return 0;
 }
 
 static int vfat_find_form(struct inode *dir, unsigned char *name)
@@ -625,8 +625,9 @@ static int vfat_build_slots(struct inode
 	loff_t offset;
 
 	*slots = 0;
-	if (!vfat_valid_longname(name, len))
-		return -EINVAL;
+	res = vfat_valid_longname(name, len);
+	if (res)
+		return res;
 
 	if(!(page = __get_free_page(GFP_KERNEL)))
 		return -ENOMEM;
