Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbUAERIP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUAERIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:08:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:32153 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264971AbUAERIC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:08:02 -0500
Subject: Re: JFS resize=0 problem in 2.6.0
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: lkml@dhtns.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031228153028.GB22247@faraday.dhtns.com>
References: <20031228153028.GB22247@faraday.dhtns.com>
Content-Type: text/plain
Message-Id: <1073322469.30857.64.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 11:07:50 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for not replying sooner.  I was on vacation.

On Sun, 2003-12-28 at 09:30, lkml@dhtns.com wrote:
> Let me know if I'm missing the goal of the code here, but lines 261-273
> of linux-2.6.0/fs/jfs/super.c are:
> 
> case Opt_resize:
> {
> 	char *resize = args[0].from;
> 	if (!resize || !*resize) {    /* LINE 264 HERE */
> 		*newLVSize = sb->s_bdev->bd_inode->i_size >>
> 			sb->s_blocksize_bits;
> 		if (*newLVSize == 0)
> 			printk(KERN_ERR
> 			"JFS: Cannot determine volume size\n");
> 	} else
> 		*newLVSize = simple_strtoull(resize, &resize, 0);
> 	break;
> }
> 
> It seems to me that line 264 is attempting to test for the mount 
> paramater "resize=0", and when it comes across this, resize to the full
> size of the volume.  However, this doesn't work.  I believe it should
> test for the char '0'  (*resize=='0'), not against literal zero.  

Originally, the code accepted "resize" or "resize=" as an indication
that it should resize to the block device size.  Recently, the parsing
code was cleaned up to use the match_token() function, and "resize"
without an argument is no longer accepted.

The following patch should allow the resize option without an argument,
as well as allowing resize=0 to indicate the same thing.

diff -ur linux-2.6.0/fs/jfs/super.c linux/fs/jfs/super.c
--- linux-2.6.0/fs/jfs/super.c	2004-01-05 10:54:19.000000000 -0600
+++ linux/fs/jfs/super.c	2004-01-05 10:54:36.000000000 -0600
@@ -203,7 +203,7 @@
 
 enum {
 	Opt_integrity, Opt_nointegrity, Opt_iocharset, Opt_resize,
-	Opt_errors, Opt_ignore, Opt_err,
+	Opt_resize_nosize, Opt_errors, Opt_ignore, Opt_err,
 };
 
 static match_table_t tokens = {
@@ -211,6 +211,7 @@
 	{Opt_nointegrity, "nointegrity"},
 	{Opt_iocharset, "iocharset=%s"},
 	{Opt_resize, "resize=%u"},
+	{Opt_resize_nosize, "resize"},
 	{Opt_errors, "errors=%s"},
 	{Opt_ignore, "noquota"},
 	{Opt_ignore, "quota"},
@@ -261,7 +262,7 @@
 		case Opt_resize:
 		{
 			char *resize = args[0].from;
-			if (!resize || !*resize) {
+			if (!resize || !*resize || resize == 0) {
 				*newLVSize = sb->s_bdev->bd_inode->i_size >>
 					sb->s_blocksize_bits;
 				if (*newLVSize == 0)
@@ -271,6 +272,15 @@
 				*newLVSize = simple_strtoull(resize, &resize, 0);
 			break;
 		}
+		case Opt_resize_nosize:
+		{
+			*newLVSize = sb->s_bdev->bd_inode->i_size >>
+				sb->s_blocksize_bits;
+			if (*newLVSize == 0)
+				printk(KERN_ERR
+				       "JFS: Cannot determine volume size\n");
+			break;
+		}
 		case Opt_errors:
 		{
 			char *errors = args[0].from;

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

