Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129188AbQKQSs7>; Fri, 17 Nov 2000 13:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129216AbQKQSst>; Fri, 17 Nov 2000 13:48:49 -0500
Received: from [212.93.159.205] ([212.93.159.205]:55821 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S129188AbQKQSsg>;
	Fri, 17 Nov 2000 13:48:36 -0500
Date: Fri, 17 Nov 2000 20:18:27 +0200 (EET)
From: Dan Podeanu <pdan@extreme.ro>
Reply-To: Dan Podeanu <pdan@extreme.ro>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.0-test11-pre6 fails to compile
Message-ID: <Pine.LNX.4.21.0011171937200.24108-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everybody,

When attempting to compile test11-pre6 it crashes out with: 

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686
-DNTFS_IN_LINUX_KERNEL -DNTFS_VERSION=\"000607\"  -c -o inode.o inode.c
inode.c:1054: conflicting types for `new_inode'
/usr/src/linux/include/linux/fs.h:1153: previous declaration of
`new_inode'
make[3]: *** [inode.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.0-test11-pre6/fs/ntfs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11-pre6/fs/ntfs'
make[1]: *** [_subdir_ntfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11-pre6/fs'
make: *** [_dir_fs] Error 2

Indeed, in fs/ntfs/inode.c we have a
static int new_inode (ntfs_volume* vol,int* result) { ... }

while in include/linux/fs.h an
static inline struct inode * new_inode(struct super_block *sb) { ... }

It appears that simply renaming new_inode to, for instance, ntfs_new_inode
makes it compile cleanly

--- fs/ntfs/inode.c.orig        Fri Nov 17 19:40:43 2000
+++ fs/ntfs/inode.c     Fri Nov 17 19:41:49 2000
@@ -1050,7 +1050,7 @@

 /* We have to skip the 16 metafiles and the 8 reserved entries */
 static int
-new_inode (ntfs_volume* vol,int* result)
+ntfs_new_inode (ntfs_volume* vol,int* result)
 {
        int byte,error;
        int bit;
@@ -1236,11 +1236,11 @@
        ntfs_volume* vol=dir->vol;
        int byte,bit;

-       error=new_inode (vol,&(result->i_number));
+       error=ntfs_new_inode (vol,&(result->i_number));
        if(error==ENOSPC){
                error=ntfs_extend_mft(vol);
                if(error)return error;
-               error=new_inode(vol,&(result->i_number));
+               error=ntfs_new_inode(vol,&(result->i_number));
        }
        if(error){
                ntfs_error ("ntfs_get_empty_inode: no free inodes\n");


Compiling also breaks at net/core/dev.c

make[3]: Entering directory `/usr/src/linux-2.4.0-test11-pre6/net/core'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686    -c -o
dev.o dev.c
dev.c: In function `run_sbin_hotplug':
dev.c:2736: `hotplug_path' undeclared (first use in this function)
dev.c:2736: (Each undeclared identifier is reported only once
dev.c:2736: for each function it appears in.)
make[3]: *** [dev.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.0-test11-pre6/net/core'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11-pre6/net/core'
make[1]: *** [_subdir_core] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11-pre6/net'
make: *** [_dir_net] Error 2

After a bit of digging, it appears to me that the whole bottom part of
net/core/dev.c should be wrapped in an #ifdef CONFIG_HOTPLUG, like in:

--- net/core/dev.c.orig Fri Nov 17 19:55:25 2000
+++ net/core/dev.c      Fri Nov 17 20:04:02 2000
@@ -2712,6 +2712,7 @@
  * Currently reported events are listed in netdev_event_names[].
  */

+#ifdef CONFIG_HOTPLUG
 /* /sbin/hotplug ONLY executes for events named here */
 static char *netdev_event_names[] = {
        [NETDEV_REGISTER]       = "register",
@@ -2765,3 +2766,4 @@
                printk (KERN_WARNING "unable to register netdev
notifier\n"
                        KERN_WARNING "/sbin/hotplug will not be run.\n");
 }
+#endif

... and init/main.c

--- init/main.c.orig    Fri Nov 17 20:15:39 2000
+++ init/main.c Fri Nov 17 20:13:52 2000
@@ -712,11 +712,13 @@
        init_pcmcia_ds();               /* Do this last */
 #endif

+#ifdef CONFIG_HOTPLUG
        /* do this after other 'do this last' stuff, because we want
         * to minimize spurious executions of /sbin/hotplug
         * during boot-up
         */
        net_notifier_init();
+#endif

        /* Mount the root filesystem.. */
        mount_root();


After this, everything seems and runs okay.

Be seeing you around.

--
Dan Podeanu,
Extreme Solutions Inc., Bucharest, Romania.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
