Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132652AbRDOMyq>; Sun, 15 Apr 2001 08:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132651AbRDOMyg>; Sun, 15 Apr 2001 08:54:36 -0400
Received: from 13dyn209.delft.casema.net ([212.64.76.209]:12299 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132636AbRDOMy2>; Sun, 15 Apr 2001 08:54:28 -0400
Message-Id: <200104151253.OAA27090@abraracourcix.bitwizard.nl>
Subject: [PATCH] NTFS comment expanded, small fix.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <Linus.Torvalds@Helsinki.FI>,
        linux-kernel@vger.kernel.org
Date: Sun, 15 Apr 2001 14:53:58 +0200 (CEST)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I am studying an NTFS problem, and came across the NTFS fixup mechanism. 

It took me much too long to understand the fixup mechanism, even though
a comment tried to explain it. So I rewrote the comment. 

Also, the "start" value that is read from the record, could be much 
larger than expected, which could lead to accessing random data. The
fixup should fail then, and this is also patched below. 

Patch attached. 

				Roger. 

--------------------------------------------------------------------

diff -ur linux-2.4.3.clean/fs/ntfs/super.c linux-2.4.3.ntfs_fix/fs/ntfs/super.c
--- linux-2.4.3.clean/fs/ntfs/super.c	Sun Apr 15 14:48:05 2001
+++ linux-2.4.3.ntfs_fix/fs/ntfs/super.c	Sun Apr 15 14:47:48 2001
@@ -30,6 +30,22 @@
  * . the magic identifier is wrong
  * . the size is given and does not match the number of sectors
  * . a fixup is invalid
+ ******
+ * Somehow that comment may sound usable to the person who wrote it, but 
+ * in fact it took me over an hour to figure it out. That's not what 
+ * comments are for. So let me try to explain it: 
+ *
+ * A record contains a fixup-area. The size of this area is S+1 words,
+ * with S the number of sectors in the record. 
+ *
+ * The first word of the fixup area is a random word. 
+ * The last word of every sector should contain this random word. 
+ * The rest of the fixup area contains the original contents of that
+ * last word of each sector of the record. 
+ * the position and length of the fixup area are stored at offset 4 
+ * and 6 in the record.  
+ *
+ * Hope this helps. -- REW
  */
 int ntfs_fixup_record(ntfs_volume *vol, char *record, char *magic, int size)
 {
@@ -42,6 +58,8 @@
 	count=NTFS_GETU16(record+6);
 	count--;
 	if(size && vol->blocksize*count != size)
+		return 0;
+	if (start >= size) 
 		return 0;
 	fixup = NTFS_GETU16(record+start);
 	start+=2;
Only in linux-2.4.3.ntfs_fix/fs/ntfs: super.c.orig


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
