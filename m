Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282934AbRLCIv2>; Mon, 3 Dec 2001 03:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284516AbRLCIu6>; Mon, 3 Dec 2001 03:50:58 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:47807 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284819AbRLCGdu>; Mon, 3 Dec 2001 01:33:50 -0500
Date: Sun, 2 Dec 2001 23:33:41 -0700
Message-Id: <200112030633.fB36Xf617997@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet writes:
> As far as I can see,
> 
> when CONFIG_DEBUG_KERNEL is set
>   and 
> when devfsd is started at boot time
> I get an Oops when remounting, rw the root fs :
> 
> Unable to handle kernel request at va 5a5a5a5e
> ...
> EIP: 0010:[<c01516f9>] Not tainted
> ...
> Process devfsd(pid:15,stackpage=cfd33000)

Ah, ha! I've found the problem. Perversely, I wasn't able to reproduce
this bug until I booted a UP kernel. I've appended the fix. Please try
this out. I have sufficient confidence in this fix that I'll make a
proper release in a few minutes.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

diff -urN linux-2.4.17-pre2/Documentation/filesystems/devfs/ChangeLog linux/Documentation/filesystems/devfs/ChangeLog
--- linux-2.4.17-pre2/Documentation/filesystems/devfs/ChangeLog	Sat Dec  1 10:48:46 2001
+++ linux/Documentation/filesystems/devfs/ChangeLog	Sun Dec  2 23:23:12 2001
@@ -1805,3 +1805,7 @@
 
 - Do not send CREATE, CHANGE, ASYNC_OPEN or DELETE events from devfsd
   or children
+===============================================================================
+Changes for patch v199.1
+
+- Fixed bug in <devfsd_read>: was dereferencing freed pointer
diff -urN linux-2.4.17-pre2/fs/devfs/base.c linux/fs/devfs/base.c
--- linux-2.4.17-pre2/fs/devfs/base.c	Sat Dec  1 10:48:46 2001
+++ linux/fs/devfs/base.c	Sun Dec  2 23:21:10 2001
@@ -569,6 +569,9 @@
 	       Do not send CREATE, CHANGE, ASYNC_OPEN or DELETE events from
 	       devfsd or children.
   v1.2
+    20011202   Richard Gooch <rgooch@atnf.csiro.au>
+	       Fixed bug in <devfsd_read>: was dereferencing freed pointer.
+  v1.3
 */
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -601,7 +604,7 @@
 #include <asm/bitops.h>
 #include <asm/atomic.h>
 
-#define DEVFS_VERSION            "1.2 (20011127)"
+#define DEVFS_VERSION            "1.3 (20011202)"
 
 #define DEVFS_NAME "devfs"
 
@@ -3243,11 +3246,17 @@
     tlen = rpos - *ppos;
     if (done)
     {
+	devfs_handle_t parent;
+
 	spin_lock (&fs_info->devfsd_buffer_lock);
 	fs_info->devfsd_first_event = entry->next;
 	if (entry->next == NULL) fs_info->devfsd_last_event = NULL;
 	spin_unlock (&fs_info->devfsd_buffer_lock);
-	for (; de != NULL; de = de->parent) devfs_put (de);
+	for (; de != NULL; de = parent)
+	{
+	    parent = de->parent;
+	    devfs_put (de);
+	}
 	kmem_cache_free (devfsd_buf_cache, entry);
 	if (ival > 0) atomic_sub (ival, &fs_info->devfsd_overrun_count);
 	*ppos = 0;
