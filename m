Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312915AbSDGXho>; Sun, 7 Apr 2002 19:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312944AbSDGXhn>; Sun, 7 Apr 2002 19:37:43 -0400
Received: from [195.39.17.254] ([195.39.17.254]:27274 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312915AbSDGXhm>;
	Sun, 7 Apr 2002 19:37:42 -0400
Date: Mon, 8 Apr 2002 01:37:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Make swsusp actually work
Message-ID: <20020407233725.GA15559@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There were two bugs, and linux/mm.h one took me *very* long to
find... Well, those bits used for zone should have been marked. Plus I
hack ide_..._suspend code not to panic, and it now seems to
work. [Sorry, 2pm, have to get some sleep.]

Please apply,
								Pavel 

--- linux-ac.clean/drivers/ide/ide-disk.c	Sun Apr  7 10:55:09 2002
+++ linux-swsusp.24/drivers/ide/ide-disk.c	Mon Apr  8 01:22:06 2002
@@ -1567,7 +1567,7 @@
 		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
 
 		if (!hwgroup) continue;
-		hwgroup->handler = hwgroup->handler_save;
+		hwgroup->handler = NULL; /* hwgroup->handler_save; */
 		hwgroup->handler_save = NULL;
 	}
 	driver_blocked = 0;
@@ -1584,6 +1584,7 @@
 		if (hwgroup->handler != panic_box)
 			panic("Handler was not set to panic?");
 		hwgroup->handler_save = NULL;
+		hwgroup->handler = NULL;
 	}
 	driver_blocked = 0;
 }
--- linux-ac.clean/include/linux/mm.h	Sun Apr  7 10:55:12 2002
+++ linux-swsusp.24/include/linux/mm.h	Mon Apr  8 01:04:06 2002
@@ -303,7 +303,9 @@
 #define PG_arch_1		13
 #define PG_reserved		14
 #define PG_launder		15	/* written out by VM pressure.. */
-#define PG_nosave		29
+#define PG_nosave		16
+/* Don't you dare to use high bits, they seem to be used for something else! */
+
 
 /* Make it prettier to test the above... */
 #define UnlockPage(page)	unlock_page(page)


-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
