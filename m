Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129541AbQLARUn>; Fri, 1 Dec 2000 12:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQLARU2>; Fri, 1 Dec 2000 12:20:28 -0500
Received: from 216-99-201-166.hurrah.com ([216.99.201.166]:33542 "EHLO
	magic.skylab.org") by vger.kernel.org with ESMTP id <S129541AbQLARUO> convert rfc822-to-8bit;
	Fri, 1 Dec 2000 12:20:14 -0500
Date: Fri, 1 Dec 2000 08:49:43 -0800 (PST)
From: "T. Camp" <campt@openmars.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mutliple root devs (take II)
Message-ID: <Pine.LNX.4.21.0012010843470.4856-100000@magic.skylab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A much cleaner patch prompted after right proper chastisement on the
sloppy patch I sent a few days back.  This one is against 2.4-pre11 but so
far as I can tell should be good to go against any of the 2.4 series so
far.

I have not implemented a regex-like syntax as was suggested because 1) you
can still do the same stuff just takes more typing 2) would make for a
fairly large re-ordering of code afterall.

basic idea here is that the kernel will search through a list of root
devices passed to the kernel as arguements before giving up on the rootfs.

ie.

(from lilo:)

linux root=/dev/hda1,/dev/hdc,/dev/hda7

will try each device in order.  You can also split these up into separate
root= statements just fine.

please be sure to directly address me with any feedback as I'm not on the
list.  (I miss linux-kernel-digest).

t. camp


--snip--
diff --recursive --unified --ignore-all-space linux/Documentation/kernel-parameters.txt linux-2.4.0.11/Documentation/kernel-parameters.txt
--- linux/Documentation/kernel-parameters.txt	Tue Sep  5 13:51:14 2000
+++ linux-2.4.0.11/Documentation/kernel-parameters.txt	Mon Nov 27 17:25:04 2000
@@ -473,7 +473,11 @@
 
 	ro		[KNL] Mount root device read-only on boot.
 
-	root=		[KNL] root filesystem.
+	root=		[KNL] root filesystem, comma separated list of up
+                        to eight /dev/ entries will be tried in order
+                        presented until kernel suceeds in mounting a
+                        filesystem, multiple independant 'root=' entries
+                        allowed as well.  
 
 	rw		[KNL] Mount root device read-write on boot.
 
diff --recursive --unified --ignore-all-space linux/fs/super.c linux-2.4.0.11/fs/super.c
--- linux/fs/super.c	Mon Oct 16 12:57:59 2000
+++ linux-2.4.0.11/fs/super.c	Wed Nov 29 16:56:00 2000
@@ -18,6 +18,8 @@
  *    Torbjörn Lindh (torbjorn.lindh@gopta.se), April 14, 1996.
  *  Added devfs support: Richard Gooch <rgooch@atnf.csiro.au>, 13-JAN-1998
  *  Heavily rewritten for 'one fs - one tree' dcache architecture. AV, Mar 2000
+ *  Modifications to mount_root for trying a list of root devices.
+ *                                    Tracy Camp <campt@openmars.com> 11/22/00 
  */
 
 #include <linux/config.h>
@@ -1470,6 +1472,7 @@
 	void *handle;
 	char path[64];
 	int path_start = -1;
+	int root_device_index = 0;
 
 #ifdef CONFIG_ROOT_NFS
 	void *data;
@@ -1528,8 +1531,15 @@
 	}
 #endif
 
-	devfs_make_root (root_device_name);
-	handle = devfs_find_handle (NULL, ROOT_DEVICE_NAME,
+	for(root_device_index = 0; root_device_index < number_root_devs; root_device_index++) {
+		printk("VFS: trying root on %s\n",&root_device_name[root_device_index][0]);
+		if(root_device_name[root_device_index][0] != '\0')
+			{
+			ROOT_DEV = name_to_kdev_t(&root_device_name[root_device_index][0]); /* translate */
+			}
+		devfs_make_root (&root_device_name[root_device_index][0]);
+		handle = devfs_find_handle (NULL, 
+				&root_device_name[root_device_index][0],
 	                            MAJOR (ROOT_DEV), MINOR (ROOT_DEV),
 				    DEVFS_SPECIAL_BLK, 1);
 	if (handle)  /*  Sigh: bd*() functions only paper over the cracks  */
@@ -1566,10 +1576,10 @@
 		 * and bad superblock on root device.
 		 */
 		printk ("VFS: Cannot open root device \"%s\" or %s\n",
-			root_device_name, kdevname (ROOT_DEV));
-		printk ("Please append a correct \"root=\" boot option\n");
-		panic("VFS: Unable to mount root fs on %s",
+			&root_device_name[root_device_index][0], kdevname (ROOT_DEV));
+		printk("VFS: Unable to mount root fs on %s\n",
 			kdevname(ROOT_DEV));
+		continue;
 	}
 
 	check_disk_change(ROOT_DEV);
@@ -1593,7 +1603,10 @@
 		put_filesystem(fs_type);
 	}
 	read_unlock(&file_systems_lock);
-	panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));
+	printk("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));
+	} /* end for */
+	printk("VFS: Please append a corrent \"root=\" boot option\n");
+	panic("VFS: Unable to mount any root fs at all");
 
 mount_it:
 	printk ("VFS: Mounted root (%s filesystem)%s.\n",
@@ -1772,6 +1785,15 @@
 		} else 
 			path_release(&devfs_nd);
 	}
+/* this function seems to only be used when after an initrd usage,
+* so the actual value of ROOT_DEV hasn't been determined until mount_root
+* is called, because we try a list of root devices before giving up,
+* this ROOT_DEV global is somewhat misleading now, as its only valid after
+* a call to mount_root because mount_root ignores the ROOT_DEV value
+* except for nfs and ram mount attempts going in, but will realise
+* to not mount RAM again so it should be okay to leave this be.
+*              - 11/22/00 <campt@openmars.com>
+*/               
 	ROOT_DEV = new_root_dev;
 	mount_root();
 #if 1
diff --recursive --unified --ignore-all-space linux/include/linux/fs.h linux-2.4.0.11/include/linux/fs.h
--- linux/include/linux/fs.h	Wed Nov 29 13:15:25 2000
+++ linux-2.4.0.11/include/linux/fs.h	Wed Nov 29 15:38:49 2000
@@ -1229,7 +1229,9 @@
 unsigned long generate_cluster(kdev_t, int b[], int);
 unsigned long generate_cluster_swab32(kdev_t, int b[], int);
 extern kdev_t ROOT_DEV;
-extern char root_device_name[];
+extern char root_device_name[8][64];
+extern int number_root_devs;
+extern kdev_t name_to_kdev_t(char *); /* in init/main.c */
 
 
 extern void show_buffers(void);
diff --recursive --unified --ignore-all-space linux/init/main.c linux-2.4.0.11/init/main.c
--- linux/init/main.c	Fri Nov 17 16:45:57 2000
+++ linux-2.4.0.11/init/main.c	Wed Nov 29 15:39:27 2000
@@ -130,7 +130,8 @@
 
 int root_mountflags = MS_RDONLY;
 char *execute_command;
-char root_device_name[64];
+char root_device_name[8][64];
+int number_root_devs = 0;
 
 
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
@@ -261,10 +262,11 @@
 kdev_t __init name_to_kdev_t(char *line)
 {
 	int base = 0;
+	struct dev_name_struct *dev = root_dev_names;
 
 	if (strncmp(line,"/dev/",5) == 0) {
-		struct dev_name_struct *dev = root_dev_names;
 		line += 5;
+		}
 		do {
 			int len = strlen(dev->name);
 			if (strncmp(line,dev->name,len) == 0) {
@@ -274,7 +276,6 @@
 			}
 			dev++;
 		} while (dev->name);
-	}
 	return to_kdev_t(base + simple_strtoul(line,NULL,base?10:16));
 }
 
@@ -283,15 +284,40 @@
 	int i;
 	char ch;
 
-	ROOT_DEV = name_to_kdev_t(line);
-	memset (root_device_name, 0, sizeof root_device_name);
+/* number_root_devs is initially 0 and not touched except for
+incrementing, so this function should be re-callable with the
+desired results */
 	if (strncmp (line, "/dev/", 5) == 0) line += 5;
-	for (i = 0; i < sizeof root_device_name - 1; ++i)
-	{
+       memset (root_device_name[number_root_devs], 0, sizeof root_device_name[number_root_devs]);       
+	for (i = 0; i < sizeof root_device_name[number_root_devs] - 1; ++i) {
+           ch = line[i];
+           if ( ch == ',') {
+               if(number_root_devs == 0) {
+                       ROOT_DEV = name_to_kdev_t(&root_device_name[number_root_devs][0]);
+                       }
+               number_root_devs++;
+               if(number_root_devs >= 8) {
+                       break;
+		       }
+               i++;             
+               line += i;
+               i = 0;
+               if (strncmp (line, "/dev/", 5) == 0) {
+                       line += 5;
+                       }
 	    ch = line[i];
-	    if ( isspace (ch) || (ch == ',') || (ch == '\0') ) break;
-	    root_device_name[i] = ch;
+               memset (root_device_name[number_root_devs], 0, sizeof root_device_name[number_root_devs]);
+               }
+           if ( isspace (ch) || (ch == '\0') ) {
+               if(number_root_devs == 0) {
+                       ROOT_DEV = name_to_kdev_t(&root_device_name[number_root_devs][0]);
+                       }
+               number_root_devs++;
+               break;
+               }
+           root_device_name[number_root_devs][i] = ch;
 	}
+printk("root_dev_setup number_root_devs: %d\n",number_root_devs);
 	return 1;
 }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
