Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289278AbSA1RUo>; Mon, 28 Jan 2002 12:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289277AbSA1RUi>; Mon, 28 Jan 2002 12:20:38 -0500
Received: from [213.171.51.190] ([213.171.51.190]:47016 "EHLO ns.yauza.ru")
	by vger.kernel.org with ESMTP id <S289278AbSA1RU2>;
	Mon, 28 Jan 2002 12:20:28 -0500
Date: Mon, 28 Jan 2002 20:20:08 +0300
From: Nikita Gergel <fc@yauza.ru>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH} 2.5.3-pre5: fs/reiserfs/procfs.c
Message-Id: <20020128202008.51d51485.fc@yauza.ru>
Organization: YAUZA-Telecom
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-alt-linux)
X-Face: /kH/`k:.@|9\`-o$p/YBn<xFr)I]mglEQW0$I${i4Q;J|JXWbc}de_p8c1;:W~5{WV,.l%B S|A4'A1hnId[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've found some errors while compiling 2.5.3-pre5 with CONFIG_REISERFS_PROC_INFO=y option. Seems that I've found how to fix problem with types conversations, but I'm not fully sure that I'm right.

But I've not fixed one error. It's with conversion from le32_to_cpu(rs->x) and bdevname(kdev_t). In our case we are to convert from __u32 to kdev_t, isn't it impossible? I've no idea...

----- [PATCH] -----

diff -urN linux-2.5.3-pre5/fs/reiserfs/procfs.c linux-2.5.3-pre5-patched/fs/reiserfs/procfs.c
--- linux-2.5.3-pre5/fs/reiserfs/procfs.c   Wed Dec 16 23:20:00 2001
+++ linux-2.5.3-pre5-patched/fs/reiserfs/procfs.c   Fri Jan 11 23:11:02 2002
@@ -30,8 +30,8 @@
  */
 
-static struct super_block *procinfo_prologue( kdev_t dev )
+static struct super_block *procinfo_prologue( kdev_t *dev )
 {
 	struct super_block *result;
 
 	/* get super-block by device */
- 	result = get_super( dev );
+	result = get_super( *dev );
 	if( result != NULL ) {
@@ -78,5 +78,5 @@
 	struct super_block *sb;
 	
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t *) ( int ) data );
 	if( sb == NULL )
 		return -ENOENT;
@@ -135,5 +135,5 @@
 	int len = 0;
 
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t *) ( int ) data );
 	if( sb == NULL )
 		return -ENOENT;
@@ -215,5 +215,5 @@
 	int level;
 
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t *) ( int ) data );
 	if( sb == NULL )
 		return -ENOENT;
@@ -294,5 +294,5 @@
 	int len = 0;
 
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t *) ( int ) data );
 	if( sb == NULL )
 		return -ENOENT;
@@ -337,5 +337,5 @@
 	int len = 0;
 
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t *) ( int ) data );
 	if( sb == NULL )
 		return -ENOENT;
@@ -388,5 +388,5 @@
 	int exact;
 
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t *) ( int ) data );
 	if( sb == NULL )
 		return -ENOENT;
@@ -439,5 +439,5 @@
 	int len = 0;
 
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t *) ( int ) data );
 	if( sb == NULL )
 		return -ENOENT;
@@ -579,5 +579,5 @@
 	return ( sb->u.reiserfs_sb.procdir ) ? create_proc_read_entry
 		( name, 0, sb->u.reiserfs_sb.procdir, func,
-		  ( void * ) ( int ) sb -> s_dev ) : NULL;
+		  &sb->s_dev ) : NULL;
 }

----- [PATCH] ----- 

-- 
Nikita Gergel					System Administrator
Moscow, Russia					YAUZA-Telecom

