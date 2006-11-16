Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424742AbWKPWVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424742AbWKPWVW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424743AbWKPWVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:21:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16826 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424742AbWKPWVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:21:21 -0500
Subject: [PATCH] hfs: correct return value in hfs_fill_super()
From: Eric Paris <eparis@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zippel@linux-m68k.org
Content-Type: text/plain
Date: Thu, 16 Nov 2006 17:18:53 -0500
Message-Id: <1163715533.22367.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When an invalid hfs filesystem image is mounted it may cause a number of
different oops.  One filesystem image which triggers this problem can be
found at:

http://projects.info-pull.com/mokb/MOKB-14-11-2006.html

it was created using the fsfuzzer program which can be found at:

http://people.redhat.com/sgrubb/files

Other such images which oops due to this same bug can be found using the
fsfuzzer.

Inside hfs_fill_super() the return value 'res' is set equal to
hfs_cat_find_brec().  If the return from  hfs_cat_find_brec() is failure
it will go to the error path and error out with an error return value.
If however hfs_cat_find_brec() returns success but then any of the
subsequent operations fail it will jump to the error path but the return
value will still be set to success from the hfs_cat_find_brec() call.
This patch simply sets a default return value of -EINVAL after the call
to hfs_cat_find_brec() so the error path will return an error instead of
success.

Although the link above shows the crash in SELinux code this is clearly
an hfs bug.  In this particular case hfs_iget() is unable to get the
root_inode and so it goes to bail_no_root: because of this bug we return
success and the s_root in the superblock struct is still 0 (since it was
initialized that way).  Later when SELinux actually tries to use the
super block s_root we panic since we are trying to deference a null
pointer.

Signed-off-by: Eric Paris <eparis@redhat.com>

 fs/hfs/super.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index d43b4fc..ab5484e 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -390,6 +390,7 @@ static int hfs_fill_super(struct super_b
 		hfs_find_exit(&fd);
 		goto bail_no_root;
 	}
+	res = -EINVAL;
 	root_inode = hfs_iget(sb, &fd.search_key->cat, &rec);
 	hfs_find_exit(&fd);
 	if (!root_inode)


