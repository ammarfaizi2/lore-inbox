Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265838AbUA0UoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUA0UoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:44:17 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:4324 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265838AbUA0UoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:44:13 -0500
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Florian Huber <florian.huber@mnet-online.de>
Cc: JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1075232395.11203.94.camel@suprafluid>
References: <1075230933.11207.84.camel@suprafluid>
	 <1075231718.21763.28.camel@shaggy.austin.ibm.com>
	 <1075232395.11203.94.camel@suprafluid>
Content-Type: text/plain
Message-Id: <1075236185.21763.89.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 14:43:05 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-27 at 13:39, Florian Huber wrote:
> On Tue, 2004-01-27 at 20:28, Dave Kleikamp wrote:
> > I wonder if JFS is having trouble getting the partition size.  Can you
> > run jfs_fsck with the -v flag to see what part of the superblock it
> > doesn't like?
> 
> The current device is:  /dev/md2
> Open(...READ/WRITE EXCLUSIVE...) returned rc = 0
> Incorrect jlog length detected in the superblock (P).
> Incorrect jlog length detected in the superblock (S).
> Superblock is corrupt and cannot be repaired 
> since both primary and secondary copies are corrupt.  

My guess is that software raid is stealing a few blocks from the end of
the partition, and JFS doesn't like that, since it's journal goes all
the way to the end.  I've created a patch that will shorten the journal
if it can safely be done.  It was built against the latest jfsutils cvs
tree, but applies to version 1.1.4:
http://www10.software.ibm.com/developer/opensource/jfs/project/pub/jfsutils-1.1.4.tar.gz

Please let me know if this fixes it.  (lkml: Yeah, I know the code is
indented too far.  It's outside the kernel, so give me a break.)

Index: jfsutils/fsck/fsckmeta.c
===================================================================
RCS file: /usr/cvs/jfs/jfsutils/fsck/fsckmeta.c,v
retrieving revision 1.18
diff -u -p -r1.18 fsckmeta.c
--- jfsutils/fsck/fsckmeta.c	17 Dec 2003 20:28:47 -0000	1.18
+++ jfsutils/fsck/fsckmeta.c	27 Jan 2004 20:27:56 -0000
@@ -2124,9 +2124,34 @@ int validate_super(int which_super)
 				}
 				agg_blks_in_aggreg += jlog_length_from_pxd;
 				if (agg_blks_in_aggreg > agg_blks_on_device) {
+					int64_t short_blocks;
+					uint32_t new_jlog_size;
 					/* log length is bad */
 					vs_rc = FSCK_BADSBFJLL;
-					fsck_send_msg(fsck_BADSBFJLL, fsck_ref_msg(which_super));
+					/* Let's try to fix it.  :^) */
+					short_blocks = agg_blks_in_aggreg -
+						agg_blks_on_device;
+					new_jlog_size = (jlog_length_from_pxd -
+							 short_blocks) *
+						sb_ptr->s_bsize;
+					/* logform likes multiples of 16K */
+					new_jlog_size &= 0xfffffC000;
+					/* Don't let it go below 1/2 MB */
+					if (new_jlog_size > (1 << 19)) {
+						printf("The volume seems to have shrunk by %Ld blocks.\n"
+						       "Will attempt to fix.\n",
+						       short_blocks);
+						jlog_length_from_pxd = 
+							new_jlog_size /
+							sb_ptr->s_bsize;
+						PXDlength(&(sb_ptr->s_logpxd),
+							  jlog_length_from_pxd);
+						vs_rc = ujfs_put_superblk(
+							 Dev_IOPort, sb_ptr, 1);
+					}
+					if (vs_rc)
+						fsck_send_msg(fsck_BADSBFJLL,
+							      fsck_ref_msg(which_super));
 				}
 			}
 		}

-- 
David Kleikamp
IBM Linux Technology Center

