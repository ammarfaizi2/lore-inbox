Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVFCExA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVFCExA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 00:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVFCExA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 00:53:00 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:60128 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S261204AbVFCEwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 00:52:35 -0400
Message-ID: <429FE0E9.2080408@codeweavers.com>
Date: Thu, 02 Jun 2005 23:47:37 -0500
From: Jeremy White <jwhite@codeweavers.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed;
 boundary="------------050005070701040008070907"
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: jwhite@codeweavers.com
Subject: [PATCH linux-2.6.12-rc5 (w/tabs)] isofs: show hidden files, add granularity
 for assoc/hidden files flags
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050005070701040008070907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The current isofs treatment of hidden files is flawed in
two ways.  First, it does not provide sufficient
granularity; it hides both 'hidden' files and 'associated'
files (resource fork for Mac files).  Second, the
default behavior to completely strip hidden files,
while an admirable implementation of the spec, is
a poor choice given the real world use of hidden files
as a poor mans copy protection scheme for MSDOS and Windows
based systems.  A longer description of this is available
here:
   http://www.uwsg.iu.edu/hypermail/linux/kernel/0205.3/0267.html

This patch was originally built after a few private
conversations with Alan Cox; I shamefully failed
to persist in seeing it go forward, I hope to make amends now.

This patch introduces granularity by allowing explicit
control for both hidden and associated files.  It also
reverses the default so that by default, hidden files
are treated as regular files on the iso9660 file system.

This allow Wine to process Windows CDs,
including those that are hybrid Mac/Windows CDs properly
and completely, without our having to go muck up peoples
fstabs as we do now.  (I have tested this with such
a hybrid + hidden CD and have verified that this patch
works as claimed).

Cheers,

Signed-off-by:  Jeremy White <jwhite@codeweavers.com>

--------------050005070701040008070907
Content-Type: text/x-patch;
 name="reversehide.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reversehide.diff"

--- linux-2.6.12-rc5/Documentation/filesystems/isofs.txt	2005-03-02 01:38:13.000000000 -0600
+++ jpw/Documentation/filesystems/isofs.txt	2005-06-02 22:26:23.000000000 -0500
@@ -26,7 +26,11 @@
   mode=xxx      Sets the permissions on files to xxx
   nojoliet      Ignore Joliet extensions if they are present.
   norock        Ignore Rock Ridge extensions if they are present.
-  unhide        Show hidden files.
+  hide		Completely strip hidden files from the file system.
+  showassoc	Show files marked with the 'associated' bit
+  unhide	Deprecated; showing hidden files is now default;
+		If given, it is a synonym for 'showassoc' which will
+		recreate previous unhide behavior
   session=x     Select number of session on multisession CD
   sbsector=xxx  Session begins from sector xxx
 
--- linux-2.6.12-rc5/fs/isofs/dir.c	2005-05-31 18:57:37.000000000 -0500
+++ jpw/fs/isofs/dir.c	2005-06-02 22:30:08.000000000 -0500
@@ -193,12 +193,12 @@
 
 		/* Handle everything else.  Do name translation if there
 		   is no Rock Ridge NM field. */
-		if (sbi->s_unhide == 'n') {
-			/* Do not report hidden or associated files */
-			if (de->flags[-sbi->s_high_sierra] & 5) {
-				filp->f_pos += de_len;
-				continue;
-			}
+
+		/* Do not report hidden files if so instructed, or associated files unless instructed to do so */
+		if (  ( sbi->s_hide =='y' && (de->flags[-sbi->s_high_sierra] & 1) ) ||
+		      ( sbi->s_showassoc =='n' && (de->flags[-sbi->s_high_sierra] & 4) ) ) {
+			filp->f_pos += de_len;
+			continue;
 		}
 
 		map = 1;
--- linux-2.6.12-rc5/fs/isofs/inode.c	2005-05-31 18:57:37.000000000 -0500
+++ jpw/fs/isofs/inode.c	2005-06-02 22:33:35.000000000 -0500
@@ -153,7 +153,8 @@
 	char rock;
 	char joliet;
 	char cruft;
-	char unhide;
+	char hide;
+	char showassoc;
 	char nocompress;
 	unsigned char check;
 	unsigned int blocksize;
@@ -318,13 +319,15 @@
 	Opt_block, Opt_check_r, Opt_check_s, Opt_cruft, Opt_gid, Opt_ignore,
 	Opt_iocharset, Opt_map_a, Opt_map_n, Opt_map_o, Opt_mode, Opt_nojoliet,
 	Opt_norock, Opt_sb, Opt_session, Opt_uid, Opt_unhide, Opt_utf8, Opt_err,
-	Opt_nocompress,
+	Opt_nocompress, Opt_hide, Opt_showassoc,
 };
 
 static match_table_t tokens = {
 	{Opt_norock, "norock"},
 	{Opt_nojoliet, "nojoliet"},
 	{Opt_unhide, "unhide"},
+	{Opt_hide, "hide"},
+	{Opt_showassoc, "showassoc"},
 	{Opt_cruft, "cruft"},
 	{Opt_utf8, "utf8"},
 	{Opt_iocharset, "iocharset=%s"},
@@ -365,7 +368,8 @@
 	popt->rock = 'y';
 	popt->joliet = 'y';
 	popt->cruft = 'n';
-	popt->unhide = 'n';
+	popt->hide = 'n';
+	popt->showassoc = 'n';
 	popt->check = 'u';		/* unset */
 	popt->nocompress = 0;
 	popt->blocksize = 1024;
@@ -398,8 +402,12 @@
 		case Opt_nojoliet:
 			popt->joliet = 'n';
 			break;
+		case Opt_hide:
+			popt->hide = 'y';
+			break;
 		case Opt_unhide:
-			popt->unhide = 'y';
+		case Opt_showassoc:
+			popt->showassoc = 'y';
 			break;
 		case Opt_cruft:
 			popt->cruft = 'y';
@@ -792,7 +800,8 @@
 	sbi->s_rock = (opt.rock == 'y' ? 2 : 0);
 	sbi->s_rock_offset = -1; /* initial offset, will guess until SP is found*/
 	sbi->s_cruft = opt.cruft;
-	sbi->s_unhide = opt.unhide;
+	sbi->s_hide = opt.hide;
+	sbi->s_showassoc = opt.showassoc;
 	sbi->s_uid = opt.uid;
 	sbi->s_gid = opt.gid;
 	sbi->s_utf8 = opt.utf8;
--- linux-2.6.12-rc5/fs/isofs/namei.c	2005-05-31 18:57:37.000000000 -0500
+++ jpw/fs/isofs/namei.c	2005-06-02 22:28:38.000000000 -0500
@@ -131,12 +131,12 @@
 		}
 
 		/*
-		 * Skip hidden or associated files unless unhide is set 
+		 * Skip hidden or associated files unless hide or showassoc, respectively, is set 
 		 */
 		match = 0;
 		if (dlen > 0 &&
-		    (!(de->flags[-sbi->s_high_sierra] & 5)
-		     || sbi->s_unhide == 'y'))
+		    ( sbi->s_hide =='n' || (!(de->flags[-sbi->s_high_sierra] & 1)) ) &&
+		    ( sbi->s_showassoc =='y' || (!(de->flags[-sbi->s_high_sierra] & 4)) ) )
 		{
 			match = (isofs_cmp(dentry,dpnt,dlen) == 0);
 		}

--------------050005070701040008070907--
