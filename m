Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbTDYT74 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbTDYT74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 15:59:56 -0400
Received: from smtp01.web.de ([217.72.192.180]:51493 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263854AbTDYT7y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 15:59:54 -0400
Date: Fri, 25 Apr 2003 22:25:12 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] Remove unused function from fs/isofs/rock.c
Message-Id: <20030425222512.4d831ebb.l.s.r@web.de>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

find_rock_ridge_relocation() has been unused since 2.4.0-test11 -- time
to bury it. The patch below applies to 2.5 up to the latest -bk, compiles
fine, and is untested.

Is there an active maintainer for isofs?

René



diff -ur linux-2.5.68-bk6/fs/isofs/rock.c~ linux-2.5.68-bk6/fs/isofs/rock.c
--- linux-2.5.68-bk6/fs/isofs/rock.c~	2002-12-16 03:08:09.000000000 +0100
+++ linux-2.5.68-bk6/fs/isofs/rock.c	2003-04-25 21:35:14.000000000 +0200
@@ -84,76 +84,6 @@
     printk("Unable to read rock-ridge attributes\n");    \
   }}
 
-/* This is the inner layer of the get filename routine, and is called
-   for each system area and continuation record related to the file */
-
-int find_rock_ridge_relocation(struct iso_directory_record * de, 
-			       struct inode * inode) {
-  int flag;
-  int len;
-  int retval;
-  unsigned char * chr;
-  CONTINUE_DECLS;
-  flag = 0;
-  
-  /* If this is a '..' then we are looking for the parent, otherwise we
-     are looking for the child */
-  
-  if (de->name[0]==1 && de->name_len[0]==1) flag = 1;
-  /* Return value if we do not find appropriate record. */
-  retval = isonum_733 (de->extent);
-  
-  if (!ISOFS_SB(inode->i_sb)->s_rock) return retval;
-
-  SETUP_ROCK_RIDGE(de, chr, len);
- repeat:
-  {
-    int rrflag, sig;
-    struct rock_ridge * rr;
-    
-    while (len > 1){ /* There may be one byte for padding somewhere */
-      rr = (struct rock_ridge *) chr;
-      if (rr->len == 0) goto out; /* Something got screwed up here */
-      sig = isonum_721(chr);
-      chr += rr->len; 
-      len -= rr->len;
-
-      switch(sig){
-      case SIG('R','R'):
-	rrflag = rr->u.RR.flags[0];
-	if (flag && !(rrflag & RR_PL)) goto out;
-	if (!flag && !(rrflag & RR_CL)) goto out;
-	break;
-      case SIG('S','P'):
-	CHECK_SP(goto out);
-	break;
-      case SIG('C','L'):
-	if (flag == 0) {
-	  retval = isonum_733(rr->u.CL.location);
-	  goto out;
-	}
-	break;
-      case SIG('P','L'):
-	if (flag != 0) {
-	  retval = isonum_733(rr->u.PL.location);
-	  goto out;
-	}
-	break;
-      case SIG('C','E'):
-	CHECK_CE; /* This tells is if there is a continuation record */
-	break;
-      default:
-	break;
-      }
-    }
-  }
-  MAYBE_CONTINUE(repeat, inode);
-  return retval;
- out:
-  if(buffer) kfree(buffer);
-  return retval;
-}
-
 /* return length of name field; 0: not found, -1: to be ignored */
 int get_rock_ridge_filename(struct iso_directory_record * de,
 			    char * retname, struct inode * inode)
diff -ur linux-2.5.68-bk6/include/linux/iso_fs.h~ linux-2.5.68-bk6/include/linux/iso_fs.h
--- linux-2.5.68-bk6/include/linux/iso_fs.h~	2002-12-16 03:08:11.000000000 +0100
+++ linux-2.5.68-bk6/include/linux/iso_fs.h	2003-04-25 21:35:37.000000000 +0200
@@ -224,8 +224,6 @@
 extern int get_rock_ridge_filename(struct iso_directory_record *, char *, struct inode *);
 extern int isofs_name_translate(struct iso_directory_record *, char *, struct inode *);
 
-extern int find_rock_ridge_relocation(struct iso_directory_record *, struct inode *);
-
 int get_joliet_filename(struct iso_directory_record *, unsigned char *, struct inode *);
 int get_acorn_filename(struct iso_directory_record *, char *, struct inode *);
 
