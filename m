Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUDGCAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 22:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbUDGCAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 22:00:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:23010 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263435AbUDGCAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 22:00:37 -0400
Date: Tue, 6 Apr 2004 19:00:34 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] reiserfs v3 fixes and features
Message-ID: <20040406190034.E22989@build.pdx.osdl.net>
References: <1081274618.30828.30.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1081274618.30828.30.camel@watt.suse.com>; from mason@suse.com on Tue, Apr 06, 2004 at 02:03:39PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

* Chris Mason (mason@suse.com) wrote:
> Most of these are from Jeff Mahoney and I, they include:
> 
> bug fixes
> logging optimizations
> data=ordered support
> xattrs
> acls
> quotas
> error messages with device names (based on Oleg's 2.4 patch)
> block allocator improvements

Would you consider adding the bd_claim on external journal bdev I posted
a while back?  Hans didn't seem to flat out reject, and you agreed one
journal per bdev was sufficient.

Patch below, updated to 2.6.5-linus, and applies with fuzz atop your
series.linus.  I also have the reiserfsprogs update if you're interested.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


===== fs/reiserfs/journal.c 1.78 vs edited =====
--- 1.78/fs/reiserfs/journal.c	Wed Feb 18 19:42:22 2004
+++ edited/fs/reiserfs/journal.c	Tue Apr  6 16:57:04 2004
@@ -1891,10 +1891,13 @@
     result = 0;
 
     if( journal -> j_dev_file != NULL ) {
+	if (journal -> j_dev_bd && (super -> s_bdev != journal -> j_dev_bd))
+		bd_release( journal -> j_dev_bd );
 	result = filp_close( journal -> j_dev_file, NULL );
 	journal -> j_dev_file = NULL;
 	journal -> j_dev_bd = NULL;
     } else if( journal -> j_dev_bd != NULL ) {
+	bd_release( journal -> j_dev_bd );
 	result = blkdev_put( journal -> j_dev_bd );
 	journal -> j_dev_bd = NULL;
     }
@@ -1933,8 +1936,17 @@
 			printk( "sh-458: journal_init_dev: cannot init journal device\n '%s': %i", 
 				__bdevname(jdev, b), result );
 			return result;
-		} else if (jdev != super->s_dev)
+		} else if (jdev != super->s_dev) {
+			result = bd_claim(journal->j_dev_bd, journal);
+			if (result) {
+				printk("%s: unable to claim %s\n", __func__,
+					bdevname(journal->j_dev_bd, b));
+				blkdev_put(journal->j_dev_bd);
+				journal->j_dev_bd = NULL;
+				return result;
+			}
 			set_blocksize(journal->j_dev_bd, super->s_blocksize);
+		}
 		return 0;
 	}
 
@@ -1947,6 +1959,17 @@
 		} else  {
 			/* ok */
 			journal->j_dev_bd = I_BDEV(jdev_inode);
+			if (super->s_bdev != journal->j_dev_bd) {
+				result = bd_claim(journal->j_dev_bd, journal);
+				if (result) {
+					printk("%s: unable to claim %s\n", __func__,
+						bdevname(journal->j_dev_bd, b));
+					filp_close(journal->j_dev_file, NULL);
+					journal->j_dev_file = NULL;
+					journal->j_dev_bd = NULL;
+					return result;
+				}
+			}
 			set_blocksize(journal->j_dev_bd, super->s_blocksize);
 		}
 	} else {
