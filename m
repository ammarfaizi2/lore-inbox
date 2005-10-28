Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVJ1Dcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVJ1Dcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 23:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVJ1Dcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 23:32:46 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:17370 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965078AbVJ1Dcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 23:32:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=qPSYvCOYAIxV/WNjM8+FZKOpdqGOUhzL2rEGlqU9XV9i+OGVvFec5ImuDOh4qid1DRTwAT95UfZN8Ss/luruu+PctUbzC7USzrbyFLN5nc9v43/ipTBT1ZAAULtDhpzv8AMQBl1oIElp+Yye6aTh/ZeroJJBrTupM8BHiWpLIV4=
Message-ID: <750c918d0510272032k79211b44vee825864d0f26438@mail.gmail.com>
Date: Fri, 28 Oct 2005 01:32:44 -0200
From: Davi Arnaut <davi.lkml@gmail.com>
To: Ben Greear <greearb@candelatech.com>
Subject: Re: kernel BUG at mm/slab.c:1488! (2.6.13.2)
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2558_15542837.1130470364806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2558_15542837.1130470364806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

> It seems that something still tries to load the ext3 module, and I get th=
e
> BUG seen below.  If I remove the ext3 module and re-build the initrd,
> the error goes away.

The attached patch should fix it.

Signed-of-by: Davi Arnaut <davi.arnaut@gmail.com>

------=_Part_2558_15542837.1130470364806
Content-Type: text/x-patch; name=ext3-already-registered.patch; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ext3-already-registered.patch"

diff --git a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -2639,7 +2639,14 @@ static struct file_system_type ext3_fs_t
 
 static int __init init_ext3_fs(void)
 {
-	int err = init_ext3_xattr();
+	int err;
+
+        if (get_fs_type(ext3_fs_type.name)) {
+          printk(KERN_WARNING "EXT3-fs: already registered\n");
+          return -1;
+        }
+
+        err = init_ext3_xattr();
 	if (err)
 		return err;
 	err = init_inodecache();

------=_Part_2558_15542837.1130470364806--
