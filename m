Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317747AbSFSCiP>; Tue, 18 Jun 2002 22:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317748AbSFSCiO>; Tue, 18 Jun 2002 22:38:14 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:47121 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id <S317747AbSFSCiM>; Tue, 18 Jun 2002 22:38:12 -0400
Message-ID: <3D0FEE29.7030509@codeweavers.com>
Date: Tue, 18 Jun 2002 21:36:25 -0500
From: Jeremy White <jwhite@codeweavers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: isofs unhide option:  troubles with Wine
References: <1022301029.2443.28.camel@jwhiteh> 	<87vg9c49xd.fsf@goat.bogus.local>  <1022334596.1262.6.camel@jwhiteh> 	<1022341822.11859.36.camel@irongate.swansea.linux.org.uk> 	<1023123957.8071.140.camel@jwhite> <1023150198.23878.93.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------000408070806050308060409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000408070806050308060409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for the long delay; had to take the kids to Disney World <grin>.

I'm attaching two patches, both against 2.5.20.  Please be gentle,
I'm a kernel newbie.

Patch #1:  bugfix.patch
    Fixes a bug in the parsing of options for the isofs driver.
    Behavior was on an unrecognized option to simply return success.
     A mount -o blatnik,<useful-option>,<useful-option>  
          would silently lose all the useful options.

    This should be applied, imho, regardless.



Patch #2:  reversehide.patch
    I've eliminated the 'unhide' option and made that behavior
        the default (show files with the hidden bit on).
    I've added a 'hide' option which hides files marked with the hidden bit.
    I've also preserved the behavior which hid 'associated' files by 
default,
        and added a 'showassoc' mount option, which will cause the
        driver to show files marked with the associated bit.
        (The prior behavior was that unhide would show both
          hidden and associated files)

    Issues:
        1.  I have no CDs with associated files on them, and thus
             this change is completely untested.  Looks good to me <g>.
        2. Arguably, this same change should be made to the udf
            driver, but I do not have a DVD writer, nor a DVD with
            either hidden or associated files, so I would be unable
            to test any such patch made.  I'm willing to submit a
            patch that compiles, if that would be of value.

Thanks,

Jeremy

Alan Cox wrote:

>On Mon, 2002-06-03 at 18:05, Jeremy White wrote:
>  
>
>>>possible rather than impossible. Question is - why was hide the default
>>>and what was that decision based upon ?
>>>      
>>>
>>I agree with Alan - this is the key question.  
>>
>>I would further argue that silence in response to this question
>>suggests that there was no carefully considered reason;
>>presumably a good hacker just followed the spec, without considering how
>>these CDs are actually used.
>>
>>It further suggests to me that I should prep a patch.
>>    
>>
>
>Go for it. I'll give it a test in the -ac tree happily. If nobody
>screams it can then go upstream.
>  
>



--------------000408070806050308060409
Content-Type: text/plain;
 name="bugfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bugfix.patch"

--- orig/fs/isofs/inode.c	Sun Jun  2 20:44:53 2002
+++ linux-2.5.20/fs/isofs/inode.c	Tue Jun 18 21:12:29 2002
@@ -460,7 +460,7 @@
 		    break;
 		  }
 		}
-		else return 1;
+		else return 0;
 	}
 	return 1;
 }

--------------000408070806050308060409
Content-Type: text/plain;
 name="reversehide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reversehide.patch"

diff -ur orig/Documentation/filesystems/isofs.txt linux-2.5.20/Documentation/filesystems/isofs.txt
--- orig/Documentation/filesystems/isofs.txt	Sun Jun  2 20:44:42 2002
+++ linux-2.5.20/Documentation/filesystems/isofs.txt	Mon Jun 17 20:58:06 2002
@@ -26,6 +26,7 @@
   mode=xxx      Sets the permissions on files to xxx
   nojoliet      Ignore Joliet extensions if they are present.
   norock        Ignore Rock Ridge extensions if they are present.
-  unhide        Show hidden files.
+  hide          Completely strip hidden files from the file system.
+  showassoc     Show files marked with the 'associated' bit
   session=x     Select number of session on multisession CD
   sbsector=xxx  Session begins from sector xxx
diff -ur orig/fs/isofs/dir.c linux-2.5.20/fs/isofs/dir.c
--- orig/fs/isofs/dir.c	Sun Jun  2 20:44:45 2002
+++ linux-2.5.20/fs/isofs/dir.c	Mon Jun 17 21:35:53 2002
@@ -194,12 +194,12 @@
 
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
+                if (  ( sbi->s_hide =='y' && (de->flags[-sbi->s_high_sierra] & 1) ) ||
+                      ( sbi->s_showassoc =='n' && (de->flags[-sbi->s_high_sierra] & 4) ) ) {
+                        filp->f_pos += de_len;
+                        continue;
 		}
 
 		map = 1;
diff -ur orig/fs/isofs/inode.c linux-2.5.20/fs/isofs/inode.c
--- orig/fs/isofs/inode.c	Sun Jun  2 20:44:53 2002
+++ linux-2.5.20/fs/isofs/inode.c	Tue Jun 18 21:14:08 2002
@@ -172,7 +172,8 @@
 	char rock;
 	char joliet;
 	char cruft;
-	char unhide;
+	char hide;
+	char showassoc;
 	char nocompress;
 	unsigned char check;
 	unsigned int blocksize;
@@ -341,7 +342,8 @@
 	popt->rock = 'y';
 	popt->joliet = 'y';
 	popt->cruft = 'n';
-	popt->unhide = 'n';
+	popt->hide = 'n';
+	popt->showassoc = 'n';
 	popt->check = 'u';		/* unset */
 	popt->nocompress = 0;
 	popt->blocksize = 1024;
@@ -367,8 +369,12 @@
 		  popt->joliet = 'n';
 		  continue;
 		}
-	        if (strncmp(this_char,"unhide",6) == 0) {
-		  popt->unhide = 'y';
+	        if (strncmp(this_char,"hide",4) == 0) {
+		  popt->hide = 'y';
+		  continue;
+		}
+	        if (strncmp(this_char,"showassoc",9) == 0) {
+		  popt->showassoc= 'y';
 		  continue;
 		}
 	        if (strncmp(this_char,"cruft",5) == 0) {
@@ -562,7 +568,8 @@
 	printk("joliet = %c\n", opt.joliet);
 	printk("check = %c\n", opt.check);
 	printk("cruft = %c\n", opt.cruft);
-	printk("unhide = %c\n", opt.unhide);
+	printk("hide = %c\n", opt.hide);
+	printk("showassoc= %c\n", opt.showassoc);
 	printk("blocksize = %d\n", opt.blocksize);
 	printk("gid = %d\n", opt.gid);
 	printk("uid = %d\n", opt.uid);
@@ -806,7 +813,8 @@
 	sbi->s_rock = (opt.rock == 'y' ? 2 : 0);
 	sbi->s_rock_offset = -1; /* initial offset, will guess until SP is found*/
 	sbi->s_cruft = opt.cruft;
-	sbi->s_unhide = opt.unhide;
+	sbi->s_hide = opt.hide;
+	sbi->s_showassoc = opt.showassoc;
 	sbi->s_uid = opt.uid;
 	sbi->s_gid = opt.gid;
 	sbi->s_utf8 = opt.utf8;
diff -ur orig/fs/isofs/namei.c linux-2.5.20/fs/isofs/namei.c
--- orig/fs/isofs/namei.c	Sun Jun  2 20:44:52 2002
+++ linux-2.5.20/fs/isofs/namei.c	Mon Jun 17 21:16:08 2002
@@ -140,12 +140,12 @@
 		}
 
 		/*
-		 * Skip hidden or associated files unless unhide is set 
+		 * Skip hidden or associated files unless hide or showassoc, respectively, is set 
 		 */
 		match = 0;
 		if (dlen > 0 &&
-		    (!(de->flags[-sbi->s_high_sierra] & 5)
-		     || sbi->s_unhide == 'y'))
+                    ( sbi->s_hide =='n' || (!(de->flags[-sbi->s_high_sierra] & 1)) ) &&
+                    ( sbi->s_showassoc =='y' || (!(de->flags[-sbi->s_high_sierra] & 4)) ) )
 		{
 			match = (isofs_cmp(dentry,dpnt,dlen) == 0);
 		}
diff -ur orig/include/linux/iso_fs_sb.h linux-2.5.20/include/linux/iso_fs_sb.h
--- orig/include/linux/iso_fs_sb.h	Sun Jun  2 20:44:50 2002
+++ linux-2.5.20/include/linux/iso_fs_sb.h	Mon Jun 17 20:57:47 2002
@@ -20,7 +20,8 @@
 	unsigned char s_cruft; /* Broken disks with high
 				  byte of length containing
 				  junk */
-	unsigned char s_unhide;
+	unsigned char s_hide;
+	unsigned char s_showassoc;
 	unsigned char s_nosuid;
 	unsigned char s_nodev;
 	unsigned char s_nocompress;

--------------000408070806050308060409--

