Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbVIBLLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbVIBLLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 07:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbVIBLLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 07:11:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030409AbVIBLLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 07:11:24 -0400
Date: Fri, 2 Sep 2005 04:09:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.6.13-mm1: PCMCIA problem
Message-Id: <20050902040926.6e02c4e8.akpm@osdl.org>
In-Reply-To: <20050902104319.GB9647@elf.ucw.cz>
References: <20050901035542.1c621af6.akpm@osdl.org>
	<20050901142813.47b349ed.akpm@osdl.org>
	<200509021030.06874.rjw@sisk.pl>
	<200509021037.16536.rjw@sisk.pl>
	<20050902104319.GB9647@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> > One more piece of information.  This is the one that loops:
>  > 
>  > echo 30 > /sys/class/firmware/timeout
> 
>  Try echo -n ...

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
 
 
_

