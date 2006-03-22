Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWCVKld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWCVKld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 05:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWCVKld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 05:41:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58894 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750851AbWCVKlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 05:41:32 -0500
Date: Wed, 22 Mar 2006 11:41:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: please pull from the trivial tree
Message-ID: <20060322104130.GB3771@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following:

Adrian Bunk:
      Documentation/dvb/get_dvb_firmware: fix firmware URL

Alexey Dobriyan:
      It's UTF-8

Ian McDonald:
      Documentation: Update to BUG-HUNTING

James Ring:
      Fix spelling in E1000_DISABLE_PACKET_SPLIT Kconfig description

Lucas Correia Villa Real:
      fix rwlock usage example

Michal Wronski:
      Remove superfluous NOTIFY_COOKIE_LEN define

Rytchkov Alexey:
      fixed path to moved file in include/linux/device.h

Uwe Zeisberger:
      Fix "frist", "fisrt", typos
      add "tags" to .gitignore


 .gitignore                           |    1 
 Documentation/BUG-HUNTING            |  113 +++++++++++++++++++++++++++
 Documentation/dvb/get_dvb_firmware   |    2 
 Documentation/filesystems/isofs.txt  |    4 
 Documentation/filesystems/jfs.txt    |    2 
 Documentation/filesystems/vfat.txt   |    6 -
 Documentation/spinlocks.txt          |    2 
 drivers/base/platform.c              |    2 
 drivers/block/cciss.c                |    2 
 drivers/net/Kconfig                  |    2 
 drivers/s390/net/claw.c              |    2 
 drivers/scsi/megaraid/megaraid_sas.c |    2 
 fs/befs/linuxvfs.c                   |    2 
 fs/cifs/CHANGES                      |    2 
 fs/fat/dir.c                         |    2 
 fs/fat/inode.c                       |    2 
 fs/isofs/joliet.c                    |    2 
 fs/nls/Kconfig                       |    2 
 include/asm-mips/termbits.h          |    2 
 include/linux/device.h               |    2 
 include/linux/msdos_fs.h             |    2 
 ipc/mqueue.c                         |    1 
 22 files changed, 136 insertions(+), 23 deletions(-)


diff --git a/.gitignore b/.gitignore
index 53e53f2..27fd376 100644
--- a/.gitignore
+++ b/.gitignore
@@ -16,6 +16,7 @@
 #
 # Top-level generic files
 #
+tags
 vmlinux*
 System.map
 Module.symvers
diff --git a/Documentation/BUG-HUNTING b/Documentation/BUG-HUNTING
index ca29242..65b97e1 100644
--- a/Documentation/BUG-HUNTING
+++ b/Documentation/BUG-HUNTING
@@ -1,3 +1,56 @@
+Table of contents
+=================
+
+Last updated: 20 December 2005
+
+Contents
+========
+
+- Introduction
+- Devices not appearing
+- Finding patch that caused a bug
+-- Finding using git-bisect
+-- Finding it the old way
+- Fixing the bug
+
+Introduction
+============
+
+Always try the latest kernel from kernel.org and build from source. If you are
+not confident in doing that please report the bug to your distribution vendor
+instead of to a kernel developer.
+
+Finding bugs is not always easy. Have a go though. If you can't find it don't
+give up. Report as much as you have found to the relevant maintainer. See
+MAINTAINERS for who that is for the subsystem you have worked on.
+
+Before you submit a bug report read REPORTING-BUGS.
+
+Devices not appearing
+=====================
+
+Often this is caused by udev. Check that first before blaming it on the
+kernel.
+
+Finding patch that caused a bug
+===============================
+
+
+
+Finding using git-bisect
+------------------------
+
+Using the provided tools with git makes finding bugs easy provided the bug is
+reproducible.
+
+Steps to do it:
+- start using git for the kernel source
+- read the man page for git-bisect
+- have fun
+
+Finding it the old way
+----------------------
+
 [Sat Mar  2 10:32:33 PST 1996 KERNEL_BUG-HOWTO lm@sgi.com (Larry McVoy)]
 
 This is how to track down a bug if you know nothing about kernel hacking.  
@@ -90,3 +143,63 @@ it does work and it lets non-hackers hel
 because Linux snapshots will let you do this - something that you can't
 do with vendor supplied releases.
 
+Fixing the bug
+==============
+
+Nobody is going to tell you how to fix bugs. Seriously. You need to work it
+out. But below are some hints on how to use the tools.
+
+To debug a kernel, use objdump and look for the hex offset from the crash
+output to find the valid line of code/assembler. Without debug symbols, you
+will see the assembler code for the routine shown, but if your kernel has
+debug symbols the C code will also be available. (Debug symbols can be enabled
+in the kernel hacking menu of the menu configuration.) For example:
+
+    objdump -r -S -l --disassemble net/dccp/ipv4.o
+
+NB.: you need to be at the top level of the kernel tree for this to pick up
+your C files.
+
+If you don't have access to the code you can also debug on some crash dumps
+e.g. crash dump output as shown by Dave Miller.
+
+>    EIP is at ip_queue_xmit+0x14/0x4c0
+>     ...
+>    Code: 44 24 04 e8 6f 05 00 00 e9 e8 fe ff ff 8d 76 00 8d bc 27 00 00
+>    00 00 55 57  56 53 81 ec bc 00 00 00 8b ac 24 d0 00 00 00 8b 5d 08
+>    <8b> 83 3c 01 00 00 89 44  24 14 8b 45 28 85 c0 89 44 24 18 0f 85
+>
+>    Put the bytes into a "foo.s" file like this:
+>
+>           .text
+>           .globl foo
+>    foo:
+>           .byte  .... /* bytes from Code: part of OOPS dump */
+>
+>    Compile it with "gcc -c -o foo.o foo.s" then look at the output of
+>    "objdump --disassemble foo.o".
+>
+>    Output:
+>
+>    ip_queue_xmit:
+>        push       %ebp
+>        push       %edi
+>        push       %esi
+>        push       %ebx
+>        sub        $0xbc, %esp
+>        mov        0xd0(%esp), %ebp        ! %ebp = arg0 (skb)
+>        mov        0x8(%ebp), %ebx         ! %ebx = skb->sk
+>        mov        0x13c(%ebx), %eax       ! %eax = inet_sk(sk)->opt
+
+Another very useful option of the Kernel Hacking section in menuconfig is
+Debug memory allocations. This will help you see whether data has been
+initialised and not set before use etc. To see the values that get assigned
+with this look at mm/slab.c and search for POISON_INUSE. When using this an
+Oops will often show the poisoned data instead of zero which is the default.
+
+Once you have worked out a fix please submit it upstream. After all open
+source is about sharing what you do and don't you want to be recognised for
+your genius?
+
+Please do read Documentation/SubmittingPatches though to help your code get
+accepted.
diff --git a/Documentation/dvb/get_dvb_firmware b/Documentation/dvb/get_dvb_firmware
index bb55f49..15fc8fb 100644
--- a/Documentation/dvb/get_dvb_firmware
+++ b/Documentation/dvb/get_dvb_firmware
@@ -246,7 +246,7 @@ sub vp7041 {
 }
 
 sub dibusb {
-	my $url = "http://www.linuxtv.org/downloads/firmware/dvb-dibusb-5.0.0.11.fw";
+	my $url = "http://www.linuxtv.org/downloads/firmware/dvb-usb-dibusb-5.0.0.11.fw";
 	my $outfile = "dvb-dibusb-5.0.0.11.fw";
 	my $hash = "fa490295a527360ca16dcdf3224ca243";
 
diff --git a/Documentation/filesystems/isofs.txt b/Documentation/filesystems/isofs.txt
index 424585f..758e504 100644
--- a/Documentation/filesystems/isofs.txt
+++ b/Documentation/filesystems/isofs.txt
@@ -9,9 +9,9 @@ when using discs encoded using Microsoft
   iocharset=name Character set to use for converting from Unicode to
 		ASCII.  Joliet filenames are stored in Unicode format, but
 		Unix for the most part doesn't know how to deal with Unicode.
-		There is also an option of doing UTF8 translations with the
+		There is also an option of doing UTF-8 translations with the
 		utf8 option.
-  utf8          Encode Unicode names in UTF8 format. Default is no.
+  utf8          Encode Unicode names in UTF-8 format. Default is no.
 
 Mount options unique to the isofs filesystem.
   block=512     Set the block size for the disk to 512 bytes
diff --git a/Documentation/filesystems/jfs.txt b/Documentation/filesystems/jfs.txt
index 3e992da..bae1286 100644
--- a/Documentation/filesystems/jfs.txt
+++ b/Documentation/filesystems/jfs.txt
@@ -6,7 +6,7 @@ The following mount options are supporte
 
 iocharset=name	Character set to use for converting from Unicode to
 		ASCII.  The default is to do no conversion.  Use
-		iocharset=utf8 for UTF8 translations.  This requires
+		iocharset=utf8 for UTF-8 translations.  This requires
 		CONFIG_NLS_UTF8 to be set in the kernel .config file.
 		iocharset=none specifies the default behavior explicitly.
 
diff --git a/Documentation/filesystems/vfat.txt b/Documentation/filesystems/vfat.txt
index 5ead20c..2001abb 100644
--- a/Documentation/filesystems/vfat.txt
+++ b/Documentation/filesystems/vfat.txt
@@ -28,16 +28,16 @@ iocharset=name -- Character set to use f
 		 know how to deal with Unicode.
 		 By default, FAT_DEFAULT_IOCHARSET setting is used.
 
-		 There is also an option of doing UTF8 translations
+		 There is also an option of doing UTF-8 translations
 		 with the utf8 option.
 
 		 NOTE: "iocharset=utf8" is not recommended. If unsure,
 		 you should consider the following option instead.
 
-utf8=<bool>   -- UTF8 is the filesystem safe version of Unicode that
+utf8=<bool>   -- UTF-8 is the filesystem safe version of Unicode that
 		 is used by the console.  It can be be enabled for the
 		 filesystem with this option. If 'uni_xlate' gets set,
-		 UTF8 gets disabled.
+		 UTF-8 gets disabled.
 
 uni_xlate=<bool> -- Translate unhandled Unicode characters to special
 		 escaped sequences.  This would let you backup and
diff --git a/Documentation/spinlocks.txt b/Documentation/spinlocks.txt
index c212299..a661d68 100644
--- a/Documentation/spinlocks.txt
+++ b/Documentation/spinlocks.txt
@@ -9,7 +9,7 @@ removed soon. So for any new code dynami
    static int __init xxx_init(void)
    {
    	spin_lock_init(&xxx_lock);
-	rw_lock_init(&xxx_rw_lock);
+	rwlock_init(&xxx_rw_lock);
 	...
    }
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 89b2683..83f5c59 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -326,7 +326,7 @@ EXPORT_SYMBOL_GPL(platform_device_regist
  *	platform_device_unregister - unregister a platform-level device
  *	@pdev:	platform device we're unregistering
  *
- *	Unregistration is done in 2 steps. Fisrt we release all resources
+ *	Unregistration is done in 2 steps. First we release all resources
  *	and remove it from the subsystem, then we drop reference count by
  *	calling platform_device_put().
  */
diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 0d65394..62b6f9d 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -2137,7 +2137,7 @@ static void start_io( ctlr_info_t *h)
 			break;
 		}
 
-		/* Get the frist entry from the Request Q */ 
+		/* Get the first entry from the Request Q */ 
 		removeQ(&(h->reqQ), c);
 		h->Qdepth--;
 	
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index e0b1109..00993e8 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1914,7 +1914,7 @@ config E1000_DISABLE_PACKET_SPLIT
 	depends on E1000
 	help
 	  Say Y here if you want to use the legacy receive path for PCI express
-	  hadware.
+	  hardware.
 
 	  If in doubt, say N.
 
diff --git a/drivers/s390/net/claw.c b/drivers/s390/net/claw.c
index a86436a..acd2a3f 100644
--- a/drivers/s390/net/claw.c
+++ b/drivers/s390/net/claw.c
@@ -1404,7 +1404,7 @@ add_claw_reads(struct net_device *dev, s
 
         if ( privptr-> p_read_active_first ==NULL ) {
 #ifdef DEBUGMSG
-                printk(KERN_INFO "%s:%s p_read_active_frist == NULL \n",
+                printk(KERN_INFO "%s:%s p_read_active_first == NULL \n",
 			dev->name,__FUNCTION__);
                 printk(KERN_INFO "%s:%s Read active first/last changed \n",
 			dev->name,__FUNCTION__);
diff --git a/drivers/scsi/megaraid/megaraid_sas.c b/drivers/scsi/megaraid/megaraid_sas.c
index 4f39dd0..84c379f 100644
--- a/drivers/scsi/megaraid/megaraid_sas.c
+++ b/drivers/scsi/megaraid/megaraid_sas.c
@@ -915,7 +915,7 @@ static int megasas_reset_bus_host(struct
 	int ret;
 
 	/*
-	 * Frist wait for all commands to complete
+	 * First wait for all commands to complete
 	 */
 	ret = megasas_generic_reset(scmd);
 
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 2d365cb..dd6048c 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -561,7 +561,7 @@ befs_utf2nls(struct super_block *sb, con
  * @sb: Superblock
  * @src: Input string buffer in NLS format
  * @srclen: Length of input string in bytes
- * @dest: The output string in UTF8 format
+ * @dest: The output string in UTF-8 format
  * @destlen: Length of the output buffer
  * 
  * Converts input string @src, which is in the format of the loaded NLS map,
diff --git a/fs/cifs/CHANGES b/fs/cifs/CHANGES
index d335015..cb68efb 100644
--- a/fs/cifs/CHANGES
+++ b/fs/cifs/CHANGES
@@ -160,7 +160,7 @@ improperly zeroed buffer in CIFS Unix ex
 Version 1.25
 ------------
 Fix internationalization problem in cifs readdir with filenames that map to 
-longer UTF8 strings than the string on the wire was in Unicode.  Add workaround
+longer UTF-8 strings than the string on the wire was in Unicode.  Add workaround
 for readdir to netapp servers. Fix search rewind (seek into readdir to return 
 non-consecutive entries).  Do not do readdir when server negotiates 
 buffer size to small to fit filename. Add support for reading POSIX ACLs from
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index db0de5c..4095bc1 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -114,7 +114,7 @@ static inline int fat_get_entry(struct i
 }
 
 /*
- * Convert Unicode 16 to UTF8, translated Unicode, or ASCII.
+ * Convert Unicode 16 to UTF-8, translated Unicode, or ASCII.
  * If uni_xlate is enabled and we can't get a 1:1 conversion, use a
  * colon as an escape character since it is normally invalid on the vfat
  * filesystem. The following four characters are the hexadecimal digits
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index e7f4aa7..e78d7b4 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1101,7 +1101,7 @@ static int parse_options(char *options, 
 			return -EINVAL;
 		}
 	}
-	/* UTF8 doesn't provide FAT semantics */
+	/* UTF-8 doesn't provide FAT semantics */
 	if (!strcmp(opts->iocharset, "utf8")) {
 		printk(KERN_ERR "FAT: utf8 is not a recommended IO charset"
 		       " for FAT filesystems, filesystem will be case sensitive!\n");
diff --git a/fs/isofs/joliet.c b/fs/isofs/joliet.c
index 2931de7..81a90e1 100644
--- a/fs/isofs/joliet.c
+++ b/fs/isofs/joliet.c
@@ -11,7 +11,7 @@
 #include "isofs.h"
 
 /*
- * Convert Unicode 16 to UTF8 or ASCII.
+ * Convert Unicode 16 to UTF-8 or ASCII.
  */
 static int
 uni16_to_x8(unsigned char *ascii, u16 *uni, int len, struct nls_table *nls)
diff --git a/fs/nls/Kconfig b/fs/nls/Kconfig
index 0ab8f00..976eccc 100644
--- a/fs/nls/Kconfig
+++ b/fs/nls/Kconfig
@@ -491,7 +491,7 @@ config NLS_KOI8_U
 	  (koi8-u) and Belarusian (koi8-ru) character sets.
 
 config NLS_UTF8
-	tristate "NLS UTF8"
+	tristate "NLS UTF-8"
 	depends on NLS
 	help
 	  If you want to display filenames with native language characters
diff --git a/include/asm-mips/termbits.h b/include/asm-mips/termbits.h
index c29c65b..fa6d04d 100644
--- a/include/asm-mips/termbits.h
+++ b/include/asm-mips/termbits.h
@@ -77,7 +77,7 @@ struct termios {
 #define IXANY	0004000		/* Any character will restart after stop.  */
 #define IXOFF	0010000		/* Enable start/stop input control.  */
 #define IMAXBEL	0020000		/* Ring bell when input queue is full.  */
-#define IUTF8	0040000		/* Input is UTF8 */
+#define IUTF8	0040000		/* Input is UTF-8 */
 
 /* c_oflag bits */
 #define OPOST	0000001		/* Perform output processing.  */
diff --git a/include/linux/device.h b/include/linux/device.h
index 5b595fd..10c1693 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -399,7 +399,7 @@ extern struct device * get_device(struct
 extern void put_device(struct device * dev);
 
 
-/* drivers/base/power.c */
+/* drivers/base/power/shutdown.c */
 extern void device_shutdown(void);
 
 
diff --git a/include/linux/msdos_fs.h b/include/linux/msdos_fs.h
index e933e2a..8bcd945 100644
--- a/include/linux/msdos_fs.h
+++ b/include/linux/msdos_fs.h
@@ -199,7 +199,7 @@ struct fat_mount_options {
 		 sys_immutable:1, /* set = system files are immutable */
 		 dotsOK:1,        /* set = hidden and system files are named '.filename' */
 		 isvfat:1,        /* 0=no vfat long filename support, 1=vfat support */
-		 utf8:1,	  /* Use of UTF8 character set (Default) */
+		 utf8:1,	  /* Use of UTF-8 character set (Default) */
 		 unicode_xlate:1, /* create escape sequences for unhandled Unicode */
 		 numtail:1,       /* Does first alias have a numeric '~1' type tail? */
 		 atari:1,         /* Use Atari GEMDOS variation of MS-DOS fs */
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index fd2e26b..85c52fd 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -51,7 +51,6 @@
 #define HARD_MSGMAX 	(131072/sizeof(void*))
 #define DFLT_MSGSIZEMAX 8192	/* max message size */
 
-#define NOTIFY_COOKIE_LEN	32
 
 struct ext_wait_queue {		/* queue of sleeping tasks */
 	struct task_struct *task;

