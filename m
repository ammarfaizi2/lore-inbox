Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312998AbSEPNs3>; Thu, 16 May 2002 09:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313016AbSEPNs2>; Thu, 16 May 2002 09:48:28 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:32266 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S312998AbSEPNs1>; Thu, 16 May 2002 09:48:27 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: msmith@operamail.com (Malcolm Smith), linux-kernel@vger.kernel.org,
        chaffee@cs.berkeley.edu
Subject: Re: [RFC] FAT extension filters
In-Reply-To: <200205151749.g4FHnkt183716@saturn.cs.uml.edu>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 16 May 2002 22:46:41 +0900
Message-ID: <871yccgq7y.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> Using plain old MS-DOS, or Linux right before the
> vfat code was merged, create a file with this name:
> 
> E5 44 05 44 E5 44 44 44   44 E5 05
> 
> On disk it gets stored as this:
> 
> 05 44 05 44 E5 44 44 44   44 E5 05
> ^^
> 
> Now remount or reboot so you don't cheat by
> accident. Do an "ls -l" and note that you
> see the original filename. The 0xE5 is at
> the beginning of the name, and the 0x05 in
> the middle has not been mangled.

Ah, yes. Indeed.

I'll submit the following patch to Linus. Thanks.

diff -urN linux-bk/fs/fat/dir.c linux-2.5.14/fs/fat/dir.c
--- linux-bk/fs/fat/dir.c	Mon May 13 02:28:29 2002
+++ linux-2.5.14/fs/fat/dir.c	Thu May 16 22:39:32 2002
@@ -271,13 +271,10 @@
 				long_slots = 0;
 		}
 
-		for (i = 0; i < 8; i++) {
-			/* see namei.c, msdos_format_name */
-			if (de->name[i] == 0x05)
-				work[i] = 0xE5;
-			else
-				work[i] = de->name[i];
-		}
+		/* see namei.c, msdos_format_name */
+		memcpy(work, de->name, sizeof(de->name));
+		if (de->name[0] == 0x05)
+			work[0] = 0xE5;
 		for (i = 0, j = 0, last_u = 0; i < 8;) {
 			if (!work[i]) break;
 			chl = fat_shortname2uni(nls_disk, &work[i], 8 - i,
@@ -478,13 +475,10 @@
 		dotoffset = 1;
 	}
 
-	for (i = 0; i < 8; i++) {
-		/* see namei.c, msdos_format_name */
-		if (de->name[i] == 0x05)
-			work[i] = 0xE5;
-		else
-			work[i] = de->name[i];
-	}
+	/* see namei.c, msdos_format_name */
+	memcpy(work, de->name, sizeof(de->name));
+	if (de->name[0] == 0x05)
+		work[0] = 0xE5;
 	for (i = 0, j = 0, last = 0, last_u = 0; i < 8;) {
 		if (!(c = work[i])) break;
 		chl = fat_shortname2uni(nls_disk, &work[i], 8 - i,
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
