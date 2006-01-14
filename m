Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWANVoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWANVoi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 16:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWANVoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 16:44:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6277 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751090AbWANVoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 16:44:37 -0500
Date: Sat, 14 Jan 2006 13:44:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm3 - disk quotas apparently busticated..
Message-Id: <20060114134414.73c6705b.akpm@osdl.org>
In-Reply-To: <20060114211933.GC21901@atrey.karlin.mff.cuni.cz>
References: <200601122116.k0CLGaiO005357@turing-police.cc.vt.edu>
	<20060114211933.GC21901@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:
>
> > +               } else {
>  > +                       *errp = 0;
>  >                 }
>  >                 return bh;
>  >         }
>  >  err:
>  >         return NULL;
>  >  }
>    Yup, that patch seems to be correct. I'm not sure if Andrew has picked
>  up the patch as it is missing Signed-off-by and also directory of the
>  file being patched (see Documentation/SubmittingPatches for general
>  guidelines). So if Andrew has not responded yet, regenerate the patch
>  and send it to him please. Thanks for the fix.

We ended up with this:

--- devel/fs/ext3/inode.c~ext3-get-blocks-maping-multiple-blocks-at-a-once-ext3_getblk-fix	2006-01-13 12:34:37.000000000 -0800
+++ devel-akpm/fs/ext3/inode.c	2006-01-13 12:35:39.000000000 -0800
@@ -899,8 +899,16 @@ struct buffer_head *ext3_getblk(handle_t
 	dummy.b_state = 0;
 	dummy.b_blocknr = -1000;
 	buffer_trace_init(&dummy.b_history);
-	*errp = ext3_get_blocks_handle(handle, inode, block, 1, &dummy, create, 1);
-	if ((*errp == 1 ) && buffer_mapped(&dummy)) {
+	err = ext3_get_blocks_handle(handle, inode, block, 1,
+					&dummy, create, 1);
+	if (err == 1) {
+		err = 0;
+	} else if (err >= 0) {
+		WARN_ON(1);
+		err = -EIO;
+	}
+	*errp = err;
+	if (!err && buffer_mapped(&dummy)) {
 		struct buffer_head *bh;
 		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
 		if (!bh) {
_

