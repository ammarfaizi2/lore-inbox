Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVIBRMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVIBRMd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVIBRMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:12:33 -0400
Received: from gold.veritas.com ([143.127.12.110]:22442 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750723AbVIBRMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:12:32 -0400
Date: Fri, 2 Sep 2005 18:14:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jim Cromie <jim.cromie@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 13-mm1: firmware_loading_store goes berserk on boot.
In-Reply-To: <43188402.40508@gmail.com>
Message-ID: <Pine.LNX.4.61.0509021811290.10183@goblin.wat.veritas.com>
References: <43188402.40508@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Sep 2005 17:12:32.0051 (UTC) FILETIME=[813A4830:01C5AFE1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2005, Jim Cromie wrote:
> 
> during boot, kernel get caught in a hi-speed loop, issuing these msgs.
> from the logs, it appears that the 'repeated' catcher is getting overwhelmed,
> perhaps by message trucation which breaks the pattern.
> Ive edited large chunks of repeats that made it into the log.
> 
> Sep  2 07:59:36 harpo kernel: firmware_loading_store: unexpected value (0)
> Sep  2 07:59:37 harpo last message repeated 83 times

Might this be another of the things fixed by patch Andrew posted earlier?
He wrote...

Or revert gregkh-driver-sysfs-strip_leading_trailing_whitespace.patch. 
Obviously if you write 30\n and the write returns 2 then the shell will
then try to write the \n.  That returns zero and the shell tries again, ad
infinitum.

Rant.  It took me two full days to weed out and fix all the crap people
sent me to get -mm1 into a state where it vaguely compiled and booted.  And
it's untested nonsense like this which wrecks the whole effort for many
testers.

I suppose this is as good as anything....


From: Andrew Morton <akpm@osdl.org>

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/sysfs/file.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff -puN fs/sysfs/file.c~gregkh-driver-sysfs-strip_leading_trailing_whitespace-fix fs/sysfs/file.c
--- devel/fs/sysfs/file.c~gregkh-driver-sysfs-strip_leading_trailing_whitespace-fix	2005-09-02 04:01:40.000000000 -0700
+++ devel-akpm/fs/sysfs/file.c	2005-09-02 04:05:02.000000000 -0700
@@ -202,13 +202,14 @@ fill_write_buffer(struct sysfs_buffer * 
  *	passing the buffer that we acquired in fill_write_buffer().
  */
 
-static int 
-flush_write_buffer(struct dentry * dentry, struct sysfs_buffer * buffer, size_t count)
+static int flush_write_buffer(struct dentry *dentry,
+			struct sysfs_buffer *buffer, size_t count_in)
 {
 	struct attribute * attr = to_attr(dentry);
 	struct kobject * kobj = to_kobj(dentry->d_parent);
 	struct sysfs_ops * ops = buffer->ops;
 	char *x;
+	size_t count = count_in;
 
 	/* locate trailing white space */
 	while ((count > 0) && isspace(buffer->page[count - 1]))
@@ -224,7 +225,8 @@ flush_write_buffer(struct dentry * dentr
 	/* terminate the string */
 	x[count] = '\0';
 
-	return ops->store(kobj, attr, x, count);
+	ops->store(kobj, attr, x, count);
+	return count_in;
 }
 
 
