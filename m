Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316388AbSEQQpQ>; Fri, 17 May 2002 12:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316391AbSEQQpP>; Fri, 17 May 2002 12:45:15 -0400
Received: from [203.94.94.187] ([203.94.94.187]:21764 "EHLO diaspar.net")
	by vger.kernel.org with ESMTP id <S316388AbSEQQpL>;
	Fri, 17 May 2002 12:45:11 -0400
Date: Fri, 17 May 2002 22:09:48 -0600
From: alvin@diaspar.net
To: linux-kernel@vger.kernel.org
Cc: rgooch@atnf.csiro.au
Subject: [patch][devfs] Utility functions to handle /dev/cpu/
Message-ID: <20020517220948.A1660@diaspar.net>
Mail-Followup-To: alvin@diaspar.net, linux-kernel@vger.kernel.org,
	rgooch@atnf.csiro.au
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-sender-OS: Linux 2.4.19-pre8-ac4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,
	These functions are helpers for drivers that may need to (un)register devfs entries across the /dev/cpu/* subtree. Two drivers that need such functionality to work with devfs out-of-the-box are the MSR driver and the CPUID driver on x86.
	Patches made against 2.4.19-pre8-ac4 + cryptoapi.
	Please CC comments, suggestions, flames to: ioshadij@hotmail.com; I've not subscribed to l-k.

Ishan Oshadi Jayawardena

PATCH 1:
--- linux/fs/devfs/base.c.1     Thu May 16 23:39:58 2002
+++ linux/fs/devfs/base.c       Fri May 17 17:04:04 2002
@@ -924,6 +924,25 @@ void devfs_put (devfs_handle_t de)
 }   /*  End Function devfs_put  */
 
 /**
+ *     _devfs_update_dev_cpu - Update the /dev/cpu/ hierarchy
+ * 
+ *  This function should be updated when/if CPU Hotplugging support is added
+ *   so that plugging in/out a CPU will be reflected in the /dev/cpu/ 
+ *   hierarchy.
+ */
+
+void _devfs_update_dev_cpu (void)
+{
+    int tmp;
+    for (tmp = 0; tmp < smp_num_cpus; tmp++)
+    {
+        char path[8];
+        sprintf (path, "cpu/%d", tmp);
+        devfs_mk_dir (NULL, path, NULL);
+    }
+}   /* End Function _devfs_update_dev_cpu */
+
+/**
  *     _devfs_search_dir - Search for a devfs entry in a directory.
  *     @dir:  The directory to search.
  *     @name:  The name of the entry to search for.
@@ -3466,7 +3485,6 @@ static ssize_t stat_read (struct file *f
 }   /*  End Function stat_read  */
 #endif
 
-
 static int __init init_devfs_fs (void)
 {
     int err;
@@ -3500,6 +3518,9 @@ void __init mount_devfs_fs (void)
     err = do_mount ("none", "/dev", "devfs", 0, "");
     if (err == 0) printk (KERN_INFO "Mounted devfs on /dev\n");
     else PRINTK ("(): unable to mount devfs, err: %d\n", err);
+
+    _devfs_update_dev_cpu ();
+
 }   /*  End Function mount_devfs_fs  */
 
 module_init(init_devfs_fs)
--- linux/fs/devfs/util.c.1     Thu May 16 21:37:40 2002
+++ linux/fs/devfs/util.c       Fri May 17 17:02:25 2002
@@ -424,3 +424,56 @@ void devfs_dealloc_unique_number (struct
                number);
 }   /*  End Function devfs_dealloc_unique_number  */
 EXPORT_SYMBOL(devfs_dealloc_unique_number);
+
+/**
+ * devfs_per_cpu_register - Populate /dev/cpu/%d with a device entry.
+ * 
+ * @name: The name of the entry.
+ * @flags: A set of bitwise-ORed flags (DEVFS_FL_*).
+ * @mode: The default file mode.
+ * @ops: The &file_operations or &block_device_operations structure.
+ *         This must not be externally deallocated.
+ * @info: An arbitrary pointer which will be written to 
+ *         the @private_data field of the &file structure 
+ *         passed to the device driver. You can set this 
+ *         to whatever you like, and change it once the file 
+ *         is opened (the next file opened will not see this change).
+ *
+ */
+
+void devfs_per_cpu_register (const char *name, unsigned int flags,
+                               unsigned int major, unsigned int minor_start,
+                               umode_t mode, void *ops, void *info)
+{
+    int i;
+    char path[128];
+
+    for (i = 0; i < smp_num_cpus; i++)
+    {
+       sprintf (path, "cpu/%d/%s", i, name);
+       devfs_register (NULL, path, flags, major, minor_start + i,
+                               mode, ops, info);
+    }
+}   /* End Function devfs_per_cpu_register */
+EXPORT_SYMBOL(devfs_per_cpu_register);
+
+/**
+ * devfs_per_cpu_unregister - Unregister a device entry across /dev/cpu/%d
+ *
+ * @name: The name of the entry.
+ *
+ */
+
+void devfs_per_cpu_unregister (const char *name)
+{
+    int i;
+    char path[128];
+
+    for (i = smp_num_cpus - 1; i >= 0; i--)
+    {
+       sprintf (path, "cpu/%d/%s", i, name);
+       /* NOTE: `type' argument is irrelevent. We always have a name. */
+       devfs_unregister(devfs_get_handle (NULL, path, 0, 0, 0, 0));
+    }
+}   /* End Function devfs_per_cpu_unregister */
+EXPORT_SYMBOL(devfs_per_cpu_unregister);
--- linux/include/linux/devfs_fs_kernel.h.1     Thu May 16 21:47:49 2002
+++ linux/include/linux/devfs_fs_kernel.h       Thu May 16 21:53:01 2002
@@ -107,6 +107,11 @@ extern void devfs_register_series (devfs
                                   unsigned int flags, unsigned int major,
                                   unsigned int minor_start,
                                   umode_t mode, void *ops, void *info);
+extern void devfs_per_cpu_register (const char *name, unsigned int flags,
+                                   unsigned int major, 
+                                   unsigned int minor_start, umode_t mode,
+                                   void *ops, void *info);
+extern void devfs_per_cpu_unregister (const char *name);
 extern int devfs_alloc_major (char type);
 extern void devfs_dealloc_major (char type, int major);
 extern kdev_t devfs_alloc_devnum (char type);
@@ -272,6 +277,19 @@ static inline void devfs_register_series
                                          unsigned int major,
                                          unsigned int minor_start,
                                          umode_t mode, void *ops, void *info)
+{
+    return;
+}
+static inline void devfs_per_cpu_register (const char *name,
+                                          unsigned int flags,
+                                          unsigned int major,
+                                          unsigned int minor_start,
+                                          umode_t mode, void *ops, void *info)
+{
+    return;
+}
+
+static inline void devfs_per_cpu_unregister (const char *name);
 {
     return;
 }
# PATCH 2: This patch uses the above functions to add devfs support to \
# the MSR and CPUID drivers.
--- linux/arch/i386/kernel/msr.c.1      Thu May 16 21:53:13 2002
+++ linux/arch/i386/kernel/msr.c        Thu May 16 22:47:26 2002
@@ -34,6 +34,7 @@
 #include <linux/poll.h>
 #include <linux/smp.h>
 #include <linux/major.h>
+#include <linux/devfs_fs_kernel.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
@@ -250,18 +251,26 @@ static struct file_operations msr_fops =
 
 int __init msr_init(void)
 {
+#ifndef CONFIG_DEVFS_FS
   if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
     printk(KERN_ERR "msr: unable to get major %d for msr\n",
           MSR_MAJOR);
     return -EBUSY;
   }
-  
+#else
+  devfs_per_cpu_register("msr", DEVFS_FL_DEFAULT, 202, 0,
+                       S_IFCHR | S_IRUSR | S_IWUSR, &msr_fops, NULL);
+#endif
   return 0;
 }
 
 void __exit msr_exit(void)
 {
+#ifndef CONFIG_DEVFS_FS
   unregister_chrdev(MSR_MAJOR, "cpu/msr");
+#else
+  devfs_per_cpu_unregister("msr");
+#endif
 }
 
 module_init(msr_init);
--- linux/arch/i386/kernel/cpuid.c.1    Thu May 16 22:01:31 2002
+++ linux/arch/i386/kernel/cpuid.c      Thu May 16 22:47:10 2002
@@ -35,6 +35,7 @@
 #include <linux/poll.h>
 #include <linux/smp.h>
 #include <linux/major.h>
+#include <linux/devfs_fs_kernel.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
@@ -142,18 +143,26 @@ static struct file_operations cpuid_fops
 
 int __init cpuid_init(void)
 {
+#ifndef CONFIG_DEVFS_FS
   if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
     printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
           CPUID_MAJOR);
     return -EBUSY;
   }
-
+#else
+  devfs_per_cpu_register("cpuid", DEVFS_FL_DEFAULT, 203, 0, 
+                       S_IFCHR | S_IRUSR | S_IWUSR, &cpuid_fops, NULL);
+#endif
   return 0;
 }
 
 void __exit cpuid_exit(void)
 {
+#ifndef CONFIG_DEVFS_FS
   unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
+#else
+  devfs_per_cpu_unregister("cpuid");
+#endif
 }
 
 module_init(cpuid_init);

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="devfs-per_cpu-patch-2.4.19-pre8-ac4-cryptoapi"

--- linux/fs/devfs/base.c.1	Thu May 16 23:39:58 2002
+++ linux/fs/devfs/base.c	Fri May 17 17:04:04 2002
@@ -924,6 +924,25 @@ void devfs_put (devfs_handle_t de)
 }   /*  End Function devfs_put  */
 
 /**
+ * 	_devfs_update_dev_cpu - Update the /dev/cpu/ hierarchy
+ * 
+ *  This function should be updated when/if CPU Hotplugging support is added
+ *   so that plugging in/out a CPU will be reflected in the /dev/cpu/ 
+ *   hierarchy.
+ */
+
+void _devfs_update_dev_cpu (void)
+{
+    int tmp;
+    for (tmp = 0; tmp < smp_num_cpus; tmp++)
+    {
+        char path[8];
+        sprintf (path, "cpu/%d", tmp);
+        devfs_mk_dir (NULL, path, NULL);
+    }
+}   /* End Function _devfs_update_dev_cpu */
+
+/**
  *	_devfs_search_dir - Search for a devfs entry in a directory.
  *	@dir:  The directory to search.
  *	@name:  The name of the entry to search for.
@@ -3466,7 +3485,6 @@ static ssize_t stat_read (struct file *f
 }   /*  End Function stat_read  */
 #endif
 
-
 static int __init init_devfs_fs (void)
 {
     int err;
@@ -3500,6 +3518,9 @@ void __init mount_devfs_fs (void)
     err = do_mount ("none", "/dev", "devfs", 0, "");
     if (err == 0) printk (KERN_INFO "Mounted devfs on /dev\n");
     else PRINTK ("(): unable to mount devfs, err: %d\n", err);
+
+    _devfs_update_dev_cpu ();
+
 }   /*  End Function mount_devfs_fs  */
 
 module_init(init_devfs_fs)
--- linux/fs/devfs/util.c.1	Thu May 16 21:37:40 2002
+++ linux/fs/devfs/util.c	Fri May 17 17:02:25 2002
@@ -424,3 +424,56 @@ void devfs_dealloc_unique_number (struct
 		number);
 }   /*  End Function devfs_dealloc_unique_number  */
 EXPORT_SYMBOL(devfs_dealloc_unique_number);
+
+/**
+ * devfs_per_cpu_register - Populate /dev/cpu/%d with a device entry.
+ * 
+ * @name: The name of the entry.
+ * @flags: A set of bitwise-ORed flags (DEVFS_FL_*).
+ * @mode: The default file mode.
+ * @ops: The &file_operations or &block_device_operations structure.
+ *	    This must not be externally deallocated.
+ * @info: An arbitrary pointer which will be written to 
+ * 	    the @private_data field of the &file structure 
+ * 	    passed to the device driver. You can set this 
+ * 	    to whatever you like, and change it once the file 
+ * 	    is opened (the next file opened will not see this change).
+ *
+ */
+
+void devfs_per_cpu_register (const char *name, unsigned int flags,
+				unsigned int major, unsigned int minor_start,
+				umode_t mode, void *ops, void *info)
+{
+    int i;
+    char path[128];
+
+    for (i = 0; i < smp_num_cpus; i++)
+    {
+	sprintf (path, "cpu/%d/%s", i, name);
+	devfs_register (NULL, path, flags, major, minor_start + i,
+				mode, ops, info);
+    }
+}   /* End Function devfs_per_cpu_register */
+EXPORT_SYMBOL(devfs_per_cpu_register);
+
+/**
+ * devfs_per_cpu_unregister - Unregister a device entry across /dev/cpu/%d
+ *
+ * @name: The name of the entry.
+ *
+ */
+
+void devfs_per_cpu_unregister (const char *name)
+{
+    int i;
+    char path[128];
+
+    for (i = smp_num_cpus - 1; i >= 0; i--)
+    {
+	sprintf (path, "cpu/%d/%s", i, name);
+	/* NOTE: `type' argument is irrelevent. We always have a name. */
+	devfs_unregister(devfs_get_handle (NULL, path, 0, 0, 0, 0));
+    }
+}   /* End Function devfs_per_cpu_unregister */
+EXPORT_SYMBOL(devfs_per_cpu_unregister);
--- linux/include/linux/devfs_fs_kernel.h.1	Thu May 16 21:47:49 2002
+++ linux/include/linux/devfs_fs_kernel.h	Thu May 16 21:53:01 2002
@@ -107,6 +107,11 @@ extern void devfs_register_series (devfs
 				   unsigned int flags, unsigned int major,
 				   unsigned int minor_start,
 				   umode_t mode, void *ops, void *info);
+extern void devfs_per_cpu_register (const char *name, unsigned int flags,
+				    unsigned int major, 
+				    unsigned int minor_start, umode_t mode,
+				    void *ops, void *info);
+extern void devfs_per_cpu_unregister (const char *name);
 extern int devfs_alloc_major (char type);
 extern void devfs_dealloc_major (char type, int major);
 extern kdev_t devfs_alloc_devnum (char type);
@@ -272,6 +277,19 @@ static inline void devfs_register_series
 					  unsigned int major,
 					  unsigned int minor_start,
 					  umode_t mode, void *ops, void *info)
+{
+    return;
+}
+static inline void devfs_per_cpu_register (const char *name,
+					   unsigned int flags,
+					   unsigned int major,
+					   unsigned int minor_start,
+					   umode_t mode, void *ops, void *info)
+{
+    return;
+}
+
+static inline void devfs_per_cpu_unregister (const char *name);
 {
     return;
 }

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=devfsize-cpuid-msr

--- linux/arch/i386/kernel/msr.c.1	Thu May 16 21:53:13 2002
+++ linux/arch/i386/kernel/msr.c	Thu May 16 22:47:26 2002
@@ -34,6 +34,7 @@
 #include <linux/poll.h>
 #include <linux/smp.h>
 #include <linux/major.h>
+#include <linux/devfs_fs_kernel.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
@@ -250,18 +251,26 @@ static struct file_operations msr_fops =
 
 int __init msr_init(void)
 {
+#ifndef CONFIG_DEVFS_FS
   if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
     printk(KERN_ERR "msr: unable to get major %d for msr\n",
 	   MSR_MAJOR);
     return -EBUSY;
   }
-  
+#else
+  devfs_per_cpu_register("msr", DEVFS_FL_DEFAULT, 202, 0,
+			S_IFCHR | S_IRUSR | S_IWUSR, &msr_fops, NULL);
+#endif
   return 0;
 }
 
 void __exit msr_exit(void)
 {
+#ifndef CONFIG_DEVFS_FS
   unregister_chrdev(MSR_MAJOR, "cpu/msr");
+#else
+  devfs_per_cpu_unregister("msr");
+#endif
 }
 
 module_init(msr_init);
--- linux/arch/i386/kernel/cpuid.c.1	Thu May 16 22:01:31 2002
+++ linux/arch/i386/kernel/cpuid.c	Thu May 16 22:47:10 2002
@@ -35,6 +35,7 @@
 #include <linux/poll.h>
 #include <linux/smp.h>
 #include <linux/major.h>
+#include <linux/devfs_fs_kernel.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
@@ -142,18 +143,26 @@ static struct file_operations cpuid_fops
 
 int __init cpuid_init(void)
 {
+#ifndef CONFIG_DEVFS_FS
   if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
     printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
 	   CPUID_MAJOR);
     return -EBUSY;
   }
-
+#else
+  devfs_per_cpu_register("cpuid", DEVFS_FL_DEFAULT, 203, 0, 
+			S_IFCHR | S_IRUSR | S_IWUSR, &cpuid_fops, NULL);
+#endif
   return 0;
 }
 
 void __exit cpuid_exit(void)
 {
+#ifndef CONFIG_DEVFS_FS
   unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
+#else
+  devfs_per_cpu_unregister("cpuid");
+#endif
 }
 
 module_init(cpuid_init);

--vkogqOf2sHV7VnPd--
