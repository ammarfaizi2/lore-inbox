Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288926AbSAETMz>; Sat, 5 Jan 2002 14:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288927AbSAETMp>; Sat, 5 Jan 2002 14:12:45 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:36365 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288926AbSAETMk>; Sat, 5 Jan 2002 14:12:40 -0500
Message-ID: <3C374F03.D2B9CF8E@zip.com.au>
Date: Sat, 05 Jan 2002 11:07:47 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.2-pre8/fs/ext3/super.c - variation of fix by 
 Andrew Morton
In-Reply-To: <20020105043506.A24538@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ There's some problem with yggdrasil.com MX records ]

"Adam J. Richter" wrote:
> 
>         Andrwe Morton posted a fix for the compilation error in
> linux-2.5.2-pre8/fs/ext3/super.c.  I have changed his test to
> use "!kdev_none()" instead of "!kdev_val()".  It will compile
> to the same opcodes, but I think this way is slightly more proper.
> It may even make a difference some day if the internal representation
> of kdev_val or kdev_none changes in a weird way so that
> kdev_val(NODEV) returns non-zero, although I think this is unlikely.
> 

Thanks, Adam.  The patch did not please the kdev_t purists :)

Current preferred version:



--- linux-2.5.2-pre7/fs/ext3/super.c	Fri Jan  4 18:48:43 2002
+++ 25/fs/ext3/super.c	Sat Jan  5 00:40:24 2002
@@ -47,19 +47,19 @@ static void ext3_clear_journal_err(struc
 				   struct ext3_super_block * es);
 
 #ifdef CONFIG_JBD_DEBUG
-int journal_no_write[2];
+kdev_t journal_no_write[2];
 
 /*
  * Debug code for turning filesystems "read-only" after a specified
  * amount of time.  This is for crash/recovery testing.
  */
 
-static void make_rdonly(kdev_t dev, int *no_write)
+static void make_rdonly(kdev_t dev, kdev_t *no_write)
 {
-	if (dev) {
+	if (!kdev_none(dev)) {
 		printk(KERN_WARNING "Turning device %s read-only\n", 
 		       bdevname(dev));
-		*no_write = 0xdead0000 + dev;
+		*no_write = dev;
 	}
 }
 
@@ -80,8 +80,8 @@ static void setup_ro_after(struct super_
 		printk(KERN_DEBUG "fs will go read-only in %d jiffies\n",
 		       ext3_ro_after);
 		init_waitqueue_head(&sbi->ro_wait_queue);
-		journal_no_write[0] = 0;
-		journal_no_write[1] = 0;
+		journal_no_write[0] = NODEV;
+		journal_no_write[1] = NODEV;
 		sbi->turn_ro_timer.function = turn_fs_readonly;
 		sbi->turn_ro_timer.data = (unsigned long)sb;
 		sbi->turn_ro_timer.expires = jiffies + ext3_ro_after;
@@ -93,8 +93,8 @@ static void setup_ro_after(struct super_
 static void clear_ro_after(struct super_block *sb)
 {
 	del_timer_sync(&EXT3_SB(sb)->turn_ro_timer);
-	journal_no_write[0] = 0;
-	journal_no_write[1] = 0;
+	journal_no_write[0] = NODEV;
+	journal_no_write[1] = NODEV;
 	ext3_ro_after = 0;
 }
 #else
