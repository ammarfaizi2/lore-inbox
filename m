Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751840AbWIGSpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWIGSpT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWIGSpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:45:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53150 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751837AbWIGSpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:45:16 -0400
Date: Thu, 7 Sep 2006 11:45:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>,
       Will Simoneau <simoneau@ele.uri.edu>, cmm@us.ibm.com
Subject: Re: [PATCH] ext3_getblk should handle HOLE correctly
Message-Id: <20060907114500.fe9fcf82.akpm@osdl.org>
In-Reply-To: <1157564346.23501.49.camel@dyn9047017100.beaverton.ibm.com>
References: <1157564346.23501.49.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2006 10:39:06 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> Hi Andrew,
> 
> Its been reported that ext3_getblk() is not doing the right thing
> and triggering following WARN():
> 
> BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
>  <c01c5140> ext3_getblk+0x98/0x2a6  <c03b2806> md_wakeup_thread
> +0x26/0x2a
>  <c01c536d> ext3_bread+0x1f/0x88  <c01cedf9> ext3_quota_read+0x136/0x1ae
>  <c018b683> v1_read_dqblk+0x61/0xac  <c0188f32> dquot_acquire+0xf6/0x107
>  <c01ceaba> ext3_acquire_dquot+0x46/0x68  <c01897d4> dqget+0x155/0x1e7
>  <c018a97b> dquot_transfer+0x3e0/0x3e9  <c016fe52> dput+0x23/0x13e
>  <c01c7986> ext3_setattr+0xc3/0x240  <c0120f66> current_fs_time
> +0x52/0x6a
>  <c017320e> notify_change+0x2bd/0x30d  <c0159246> chown_common+0x9c/0xc5
>  <c02a222c> strncpy_from_user+0x3b/0x68  <c0167fe6> do_path_lookup
> +0xdf/0x266
>  <c016841b> __user_walk_fd+0x44/0x5a  <c01592b9> sys_chown+0x4a/0x55
>  <c015a43c> vfs_write+0xe7/0x13c  <c01695d4> sys_mkdir+0x1f/0x23
>  <c0102a97> syscall_call+0x7/0xb 
> 
> Looking at the code, it looks like its not handle HOLE correctly.
> It ends up returning -EIO.

Strange.  The fs should be spewing these warnings all over the place.  For
some reason this code is hard to trigger.  Why??

> -	if (err == 1) {
> +	/*
> +	 * ext3_get_blocks_handle() returns number of blocks
> +	 * mapped. 0 in case of a HOLE.
> +	 */
> +	if (err > 0) {
>  		err = 0;
> -	} else if (err >= 0) {
> -		WARN_ON(1);
> -		err = -EIO;
>  	}

That removes the warning if ext3_get_blocks_handle() returned a positive
number greater than one.  And it looks like we still need debugging support
in this area.

I reworked it like this:

--- a/fs/ext3/inode.c~ext3_getblk-should-handle-hole-correctly
+++ a/fs/ext3/inode.c
@@ -1010,11 +1010,14 @@ struct buffer_head *ext3_getblk(handle_t
 	buffer_trace_init(&dummy.b_history);
 	err = ext3_get_blocks_handle(handle, inode, block, 1,
 					&dummy, create, 1);
-	if (err == 1) {
+	/*
+	 * ext3_get_blocks_handle() returns number of blocks
+	 * mapped. 0 in case of a HOLE.
+	 */
+	if (err > 0) {
+		if (err > 1)
+			WARN_ON(1);
 		err = 0;
-	} else if (err >= 0) {
-		WARN_ON(1);
-		err = -EIO;
 	}
 	*errp = err;
 	if (!err && buffer_mapped(&dummy)) {
_

ie:

	/*
	 * ext3_get_blocks_handle() returns number of blocks
	 * mapped. 0 in case of a HOLE.
	 */
	if (err > 0) {
		if (err > 1)
			WARN_ON(1);
		err = 0;
	}
	*errp = err;

