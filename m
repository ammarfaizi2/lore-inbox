Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263780AbTEYVRd (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 17:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbTEYVRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 17:17:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3466 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263780AbTEYVRb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 17:17:31 -0400
Date: Sun, 25 May 2003 22:30:40 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
   Alexander Viro <aviro@redhat.com>
Subject: Re: oops with bk kernel as of 2003-05-25T13:00:00-07
Message-ID: <20030525213040.GH6270@parcelfarce.linux.theplanet.co.uk>
References: <3ED12727.1080907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED12727.1080907@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 01:27:19PM -0700, Ulrich Drepper wrote:
> Call Trace:
>  [<c0157a4e>] cdev_add+0x63/0x65
>  [<c01579c8>] exact_match+0x0/0x5
>  [<c01579cd>] exact_lock+0x0/0x1e
>  [<c01575d1>] register_chrdev+0xc6/0x10f
>  [<c039ec53>] init_netlink+0x1f/0x58
>  [<c039ec2e>] netlink_proto_init+0x47/0x4d
>  [<c0382880>] do_initcalls+0x27/0x93
>  [<c012ddc3>] init_workqueues+0xf/0x26
>  [<c01050a8>] init+0x4c/0x1a8
>  [<c010505c>] init+0x0/0x1a8
>  [<c0108a15>] kernel_thread_helper+0x5/0xb
 
> I looked at the code and the problem is that cdev_map == NULL when
> cdev_add is called.  cdev_map is initialized in a constructor.  Maybe
> the wrong order or a race...

Gack...  We have

subsys_initcall(chrdev_init);
in fs/char_dev.c
and
core_initcall(netlink_proto_init);
in net/netlink/af_netlink.c

Guess which one wins...  What a mess...  How about the following (untested,
but AFAICS should work)

diff -urN linux/fs/char_dev.c linux2/fs/char_dev.c
--- linux/fs/char_dev.c	Sun May 25 08:01:46 2003
+++ linux2/fs/char_dev.c	Sun May 25 17:26:04 2003
@@ -457,11 +457,9 @@
 	return NULL;
 }
 
-static int __init chrdev_init(void)
+void __init cdev_init(void)
 {
 	subsystem_register(&cdev_subsys);
 	kset_register(&kset_dynamic);
 	cdev_map = kobj_map_init(base_probe, &cdev_subsys);
-	return 0;
 }
-subsys_initcall(chrdev_init);
diff -urN linux/fs/dcache.c linux2/fs/dcache.c
--- linux/fs/dcache.c	Sat May 24 18:49:58 2003
+++ linux2/fs/dcache.c	Sun May 25 17:25:40 2003
@@ -1606,6 +1606,7 @@
 EXPORT_SYMBOL(d_genocide);
 
 extern void bdev_cache_init(void);
+extern void cdev_init(void);
 
 void __init vfs_caches_init(unsigned long mempages)
 {
@@ -1626,4 +1627,5 @@
 	files_init(mempages); 
 	mnt_init(mempages);
 	bdev_cache_init();
+	cdev_init();
 }
