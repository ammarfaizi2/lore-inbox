Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132744AbRC2P0w>; Thu, 29 Mar 2001 10:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132751AbRC2P0n>; Thu, 29 Mar 2001 10:26:43 -0500
Received: from smtp01ffm.de.uu.net ([192.76.144.150]:65074 "EHLO
	smtp01ffm.de.uu.net") by vger.kernel.org with ESMTP
	id <S132744AbRC2P0b>; Thu, 29 Mar 2001 10:26:31 -0500
Date: Thu, 29 Mar 2001 17:31:27 +0200
From: Andreas Eckleder <aeckleder@nero.com>
To: linux-kernel@vger.kernel.org
Subject: Proposed changes to isofs driver
Message-ID: <20010329173127.A1236@ahead.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

playing with RockRidge extensions recently I found two issues with the
current implementation of the linux kernel's rockridge reading code:
a) when a SL field describing part of a symbolic link only contains
   a single root component and the rest of the link is continued in the
   following SL fields, the linux kernel will make this link read something
   like '//usr/local/lib' instead of '/usr/local/lib'.
   The reason for this problem is that a '/' will be added to the symlink
   string whenever there's a SL field change, regardless of what's been 
   done before. Unfortunately, the '/' has already been added in case of a
   root component. Although a flag called rootflag is set accordingly to
   indicate that the root item has been processed, this flag is disregarded
   when adding the '/' a second time.
   The attached patch will query the rootflag and add the '/' if it isn't
   already set.
   Please note that other unices, prominently Mac OS X, will read 
   our symbolic link correctly
b) another issue we found with the linux kernel's rockridge code is that,
   although explicitly stated in the rockridge draft standard, the offset
   within a directory entry's system use area to start looking for 
   SUSP fields, cannot be set by means of the 'SP' susp initializer field.
   Also, this field is not being looked for behind eventual XA attributes
   as used on MODE2 ISO9660 filesystems.
   Attached patch will fix this behavior by reading the susp offset as
   provided in the SP.skip field of the 'SP' attribute. It will also look
   for the susp initializer at offset 14 of the system use area if it couldn't
   be found at offset 0 to allow for CDROMs containing both XA and rockridge
   attributes.

Please find the attached patch against Kernel 2.4.2

Regards,
A.Eckleder, Ahead Software GmbH

   

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rockpatch-2.4.2.diff"

diff -u -r linux/fs/isofs/inode.c linux-2.4.2/fs/isofs/inode.c
--- linux/fs/isofs/inode.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.2/fs/isofs/inode.c	Thu Mar 29 15:47:44 2001
@@ -748,6 +748,7 @@
 	s->s_op = &isofs_sops;
 	s->u.isofs_sb.s_mapping = opt.map;
 	s->u.isofs_sb.s_rock = (opt.rock == 'y' ? 2 : 0);
+        s->u.isofs_sb.s_rock_offset = -1; /* initial offset, will guess until SP is found*/
 	s->u.isofs_sb.s_cruft = opt.cruft;
 	s->u.isofs_sb.s_unhide = opt.unhide;
 	s->u.isofs_sb.s_uid = opt.uid;
diff -u -r linux/fs/isofs/rock.c linux-2.4.2/fs/isofs/rock.c
--- linux/fs/isofs/rock.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.2/fs/isofs/rock.c	Thu Mar 29 15:48:28 2001
@@ -31,8 +31,8 @@
    use fields that is compatible with Rock Ridge */
 #define CHECK_SP(FAIL)	       			\
       if(rr->u.SP.magic[0] != 0xbe) FAIL;	\
-      if(rr->u.SP.magic[1] != 0xef) FAIL;
-
+      if(rr->u.SP.magic[1] != 0xef) FAIL;       \
+      inode->i_sb->u.isofs_sb.s_rock_offset=rr->u.SP.skip;
 /* We define a series of macros because each function must do exactly the
    same thing in certain places.  We use the macros to ensure that everything
    is done correctly */
@@ -50,7 +50,14 @@
   {LEN= sizeof(struct iso_directory_record) + DE->name_len[0];	\
   if(LEN & 1) LEN++;						\
   CHR = ((unsigned char *) DE) + LEN;				\
-  LEN = *((unsigned char *) DE) - LEN;}
+  LEN = *((unsigned char *) DE) - LEN;                          \
+  if (inode->i_sb->u.isofs_sb.s_rock_offset!=-1)                \
+  {                                                             \
+     LEN-=inode->i_sb->u.isofs_sb.s_rock_offset;                \
+     CHR+=inode->i_sb->u.isofs_sb.s_rock_offset;                \
+     if (LEN<0) LEN=0;                                          \
+  }                                                             \
+}                                     
 
 #define MAYBE_CONTINUE(LABEL,DEV) \
   {if (buffer) kfree(buffer); \
@@ -220,8 +227,8 @@
   return 0;
 }
 
-int parse_rock_ridge_inode(struct iso_directory_record * de,
-			   struct inode * inode){
+int parse_rock_ridge_inode_internal(struct iso_directory_record * de,
+			            struct inode * inode,int regard_xa){
   int len;
   unsigned char * chr;
   int symlink_len = 0;
@@ -230,6 +237,13 @@
   if (!inode->i_sb->u.isofs_sb.s_rock) return 0;
 
   SETUP_ROCK_RIDGE(de, chr, len);
+  if (regard_xa)
+   {
+     chr+=14;
+     len-=14;
+     if (len<0) len=0;
+   };
+   
  repeat:
   {
     int cnt, sig;
@@ -416,7 +430,7 @@
 			 * If there is another SL record, and this component
 			 * record isn't continued, then add a slash.
 			 */
-			if ((rr->u.SL.flags & 1) && !(oldslp->flags & 1))
+			if ((!rootflag) && (rr->u.SL.flags & 1) && !(oldslp->flags & 1))
 				*rpnt++='/';
 			break;
 		}
@@ -431,6 +445,20 @@
 	return rpnt;
 }
 
+int parse_rock_ridge_inode(struct iso_directory_record * de,
+			   struct inode * inode)
+{
+   int result=parse_rock_ridge_inode_internal(de,inode,0);
+   /* if rockridge flag was reset and we didn't look for attributes
+    * behind eventual XA attributes, have a look there */
+   if ((inode->i_sb->u.isofs_sb.s_rock_offset==-1)
+       &&(inode->i_sb->u.isofs_sb.s_rock==2))
+     {
+	printk(KERN_DEBUG"scanning for RockRidge behind XA attributes\n");
+	result=parse_rock_ridge_inode_internal(de,inode,14);
+     };
+   return result;
+};
 
 /* readpage() for symlinks: reads symlink contents into the page and either
    makes it uptodate and returns 0 or returns error (-EIO) */
diff -u -r linux/include/linux/iso_fs_sb.h linux-2.4.2/include/linux/iso_fs_sb.h
--- linux/include/linux/iso_fs_sb.h	Wed Aug 26 18:54:41 1998
+++ linux-2.4.2/include/linux/iso_fs_sb.h	Thu Mar 29 15:47:44 2001
@@ -13,6 +13,7 @@
 	
 	unsigned char s_high_sierra; /* A simple flag */
 	unsigned char s_mapping;
+        int           s_rock_offset; /* offset of SUSP fields within SU area */
 	unsigned char s_rock;
 	unsigned char s_joliet_level;
 	unsigned char s_utf8;

--0F1p//8PRICkK4MW--
