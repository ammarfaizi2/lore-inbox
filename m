Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310576AbSCLLnW>; Tue, 12 Mar 2002 06:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310561AbSCLLnD>; Tue, 12 Mar 2002 06:43:03 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:38383 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S310552AbSCLLms>; Tue, 12 Mar 2002 06:42:48 -0500
Date: Tue, 12 Mar 2002 13:42:34 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Erik Kline <ekline@ekline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [module/patch] optional /proc/patches ??
Message-ID: <20020312114234.GF128921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Erik Kline <ekline@ekline.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200203112124.g2BLOFP01544@minerva.ekline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203112124.g2BLOFP01544@minerva.ekline.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 01:24:15PM -0800, you [Erik Kline] wrote:
> All,
> 
> I was wondering whether something like a /proc/patches might be useful. This 
> could help list patches applied to a kernel such that "uname -a" and "cat 
> /proc/patches" provides some good information about the kernel, especially 
> stock kernels from distributions. I was able to work up a quick module 
> available at the link below. NOTE: I couldn't solve how to add entries fo a 
> patchlist structure using regular context diffs, but ed diffs work just 
> great. More information in the README attached. I'd very much appreciate any 
> feedback on whether this is useful and how it should actually be implemented, 
> if at all. Please note that my only access to lkml traffic is via Kernel 
> Traffic so I would appreciate being Cc'ed.

This is nice. (It's an idea I've had for sometime, but I've never gotten
around to do anything about it.)

Random notes: 

o Perhaps an URL field for each patch would be nice?
o Below is a patch to make it build on (at least newer) 2.2. 
  I'm a complete newbie here, I should have a look why it doesn't work on
  2.2.16 but does on 2.2.21pre2. Also, what is the correct define for
  MODULE_LICENSE?
o I'm not sure if it's nicer to have the fields separated with ':' or
  pretty printed (some thing like this:

  Foo-patch
    Version: 0.0.1alpha3
    Author: John Doe
    URL: http://bfebbd.org
  Bar-patch
    Version: 0.021alpha3
    Author: John Boe
    URL: http://afebbd.org

  ). It is useful anyway.
o I think you may overflow the buffer if fields are too long. Also, 
  it doesn't work if the patch list is larger than a page (think of redhat 
  , -ac or -aa kernels...)
o I always thought about adding for example /usr/src/linux/PATCHES text file
  that the /proc/patch would then include. I'm not sure it matters, though.  
o Have you looked at proconfig: http://www.it.uc3m.es/~ptb/proconfig/
  (There are other implementations of that idea, see the recent thread on
  linux-kernel http://groups.google.com/groups?hl=en&threadm=20020207203451.GE26826%40bluemug.com&rnum=2&prev=/groups%3Fq%3DHow%2Bto%2Bcheck%2Bthe%2Bkernel%2Bcompile%2Boptions%2B%253F%2Blinux-kernel%26hl%3Den)


Now the only problem is to advogate people to actually use this ;). I'd be
nice to have for example O(1) scheduler or low-latency insert the info line
there.



-- v --

v@iki.fi


--- ../../patchlist-0.0.1/patchlist.c	Mon Mar 11 22:09:29 2002
+++ patchlist.c	Tue Mar 12 13:24:46 2002
@@ -45,7 +45,9 @@
 
 MODULE_AUTHOR("Erik M. A. Kline");
 MODULE_DESCRIPTION("implements /proc/patches read-only informational file");
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,29) // fix me! 2.3.29 is not right even newer 2.2.x support this?
 MODULE_LICENSE("GPL");
+#endif
 EXPORT_NO_SYMBOLS;
 
 
@@ -68,8 +70,13 @@
 };
 
 
-int patch_proc_read( char *buf, char **start, off_t offset,
+static int 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,29)
+patch_proc_read( char *buf, char **start, off_t offset,
                      int count, int *eof, void *data )
+#else
+patch_proc_read( char *buf, char **start, off_t offset, int count, int unused )
+#endif
 {
     int i, len = 0, limit = count - 80;
     struct patch_list_elem *pelem = NULL;
@@ -86,15 +93,46 @@
                         pelem->vers, pelem->authors );
     }
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,29)
     *eof = 1;
+#endif
     return len;
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,29)
+struct proc_dir_entry proc_root_patch =
+{
+      0, sizeof(PATCH_PROCPATH) - 1, PATCH_PROCPATH,
+      S_IFREG | S_IRUGO,
+      1,                    // LNK, DIR or FIL ?
+      0, 0,                 // uid, gid
+      0,                    // size
+      NULL,                 // inode ops
+      &patch_proc_read,     // get_info
+      NULL,                 // fill_inode
+      NULL,                 // next entry
+      NULL,                 // parent entry
+      NULL,                 // subdir entry
+      NULL,                 // void *data
+      NULL,                 // read_proc
+      NULL, 		    // write_proc
+      NULL,                 // readlink_proc
+      0,                    // usage count
+      0,                    // delete flag
+};
+#endif
+
+
 int patch_module_init(void)
 {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,29)
     if ( create_proc_read_entry( PATCH_PROCPATH,
          0, NULL, patch_proc_read, NULL ) == NULL )
         return -ERESTARTSYS;
+#else
+    if ( proc_register (&proc_root, &proc_root_patch) < 0)
+    	return -ERESTARTSYS;
+#endif
 
     return 0;
 }
@@ -103,7 +141,11 @@
 
 void patch_module_exit(void)
 {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,29)
     remove_proc_entry( PATCH_PROCPATH, NULL );
+#else
+    proc_unregister (&proc_root, proc_root_patch.low_ino);
+#endif
 }
 
 module_exit( patch_module_exit );
