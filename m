Return-Path: <linux-kernel-owner+w=401wt.eu-S1753776AbWLPTbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbWLPTbs (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 14:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbWLPTbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 14:31:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:62795 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbWLPTbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 14:31:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=g+wkOR3fMDVUxbXNeVhu7RdO9/C1VM1F/FcHwyQ0gv+4oJY7XlLjohBpbcYili6yJSg7S9Hfx51nJZ6ka3DxGn/9MLkh7OpafUjYGTo6sqa0Mud+pu3O8EfiQJNeyFgWA9BOYTgZ1MOvNkjHYttMN0yRN2av30dhrqscE5hT4wM=
Date: Sat, 16 Dec 2006 19:30:22 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jean-paul.saman@nxp.com
Subject: [-mm patch] noinitramfs cleanup
Message-ID: <20061216193022.GA21145@slug>
References: <20061214225913.3338f677.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 10:59:13PM -0800, Andrew Morton wrote:
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc1/2.6.20-rc1-mm1/
> 
> +disable-init-initramfsc-updated.patch


Jean-Paul,

The following patch silences the following compile time warning introduced
by the disable-init-initramfsc-updated patch:

  CC      init/noinitramfs.o
  init/noinitramfs.c:42: warning : initialization from incompatible pointer type

In addition, I've cleaned up the headers and added some error handling.

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/init/noinitramfs.c b/init/noinitramfs.c
index 01f88c3..f4c1a3a 100644
--- a/init/noinitramfs.c
+++ b/init/noinitramfs.c
@@ -18,25 +18,35 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 #include <linux/init.h>
-#include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/fcntl.h>
-#include <linux/delay.h>
-#include <linux/string.h>
+#include <linux/stat.h>
+#include <linux/kdev_t.h>
 #include <linux/syscalls.h>
 
 /*
  * Create a simple rootfs that is similar to the default initramfs
  */
-static void __init default_rootfs(void)
+static int __init default_rootfs(void)
 {
-	int mkdir_err = sys_mkdir("/dev", 0755);
-	int err = sys_mknod((const char __user *) "/dev/console",
-				S_IFCHR | S_IRUSR | S_IWUSR,
-				new_encode_dev(MKDEV(5, 1)));
-	if (err == -EROFS)
-		printk("Warning: Failed to create a rootfs\n");
-	mkdir_err = sys_mkdir("/root", 0700);
+	int err;
+
+	err = sys_mkdir("/dev", 0755);
+	if (err < 0)
+		goto out;
+
+	err = sys_mknod((const char __user *) "/dev/console",
+			S_IFCHR | S_IRUSR | S_IWUSR,
+			new_encode_dev(MKDEV(5, 1)));
+	if (err < 0)
+		goto out;
+
+	err = sys_mkdir("/root", 0700);
+	if (err < 0)
+		goto out;
+
+	return 0;
+
+out:
+	printk(KERN_WARNING "Failed to create a rootfs\n");
+	return err;
 }
 rootfs_initcall(default_rootfs);
