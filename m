Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVIENxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVIENxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 09:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVIENxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 09:53:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38089 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932213AbVIENxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 09:53:08 -0400
Date: Mon, 5 Sep 2005 15:52:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: update documentation
Message-ID: <20050905135242.GC1979@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This updates documentation a bit (mostly removing obsolete stuff), and
marks swsusp as no longer experimental in config.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -1,22 +1,20 @@
-From kernel/suspend.c:
+Some warnings, first.
 
  * BIG FAT WARNING *********************************************************
  *
- * If you have unsupported (*) devices using DMA...
- *				...say goodbye to your data.
- *
  * If you touch anything on disk between suspend and resume...
  *				...kiss your data goodbye.
  *
- * If your disk driver does not support suspend... (IDE does)
- *				...you'd better find out how to get along
- *				   without your data.
- *
- * If you change kernel command line between suspend and resume...
- *			        ...prepare for nasty fsck or worse.
+ * If you do resume from initrd after your filesystems are mounted...
+ *				...bye bye root partition.
+ *			[this is actually same case as above]
  *
- * If you change your hardware while system is suspended...
- *			        ...well, it was not good idea.
+ * If you have unsupported (*) devices using DMA, you may have some
+ * problems. If your disk driver does not support suspend... (IDE does),
+ * it may cause some problems, too. If you change kernel command line 
+ * between suspend and resume, it may do something wrong. If you change 
+ * your hardware while system is suspended... well, it was not good idea;
+ * but it will probably only crash.
  *
  * (*) suspend/resume support is needed to make it safe.
 
@@ -30,6 +28,13 @@ echo shutdown > /sys/power/disk; echo di
 echo platform > /sys/power/disk; echo disk > /sys/power/state
 
 
+Encrypted suspend image:
+------------------------
+If you want to store your suspend image encrypted with a temporary
+key to prevent data gathering after resume you must compile
+crypto and the aes algorithm into the kernel - modules won't work
+as they cannot be loaded at resume time.
+
 
 Article about goals and implementation of Software Suspend for Linux
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -85,11 +90,6 @@ resume.
 You have your server on UPS. Power died, and UPS is indicating 30
 seconds to failure. What do you do? Suspend to disk.
 
-Ethernet card in your server died. You want to replace it. Your
-server is not hotplug capable. What do you do? Suspend to disk,
-replace ethernet card, resume. If you are fast your users will not
-even see broken connections.
-
 
 Q: Maybe I'm missing something, but why don't the regular I/O paths work?
 
@@ -117,31 +117,6 @@ Q: Does linux support ACPI S4?
 
 A: Yes. That's what echo platform > /sys/power/disk does.
 
-Q: My machine doesn't work with ACPI. How can I use swsusp than ?
-
-A: Do a reboot() syscall with right parameters. Warning: glibc gets in
-its way, so check with strace:
-
-reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 0xd000fce2)
-
-(Thanks to Peter Osterlund:)
-
-#include <unistd.h>
-#include <syscall.h>
-
-#define LINUX_REBOOT_MAGIC1     0xfee1dead
-#define LINUX_REBOOT_MAGIC2     672274793
-#define LINUX_REBOOT_CMD_SW_SUSPEND     0xD000FCE2
-
-int main()
-{
-    syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
-            LINUX_REBOOT_CMD_SW_SUSPEND, 0);
-    return 0;
-}
-
-Also /sys/ interface should be still present.
-
 Q: What is 'suspend2'?
 
 A: suspend2 is 'Software Suspend 2', a forked implementation of
@@ -312,9 +287,45 @@ system is shut down or suspended. Additi
 suspend image to prevent sensitive data from being stolen after
 resume.
 
-Q: Why we cannot suspend to a swap file?
+Q: Why can't we suspend to a swap file?
 
 A: Because accessing swap file needs the filesystem mounted, and
 filesystem might do something wrong (like replaying the journal)
-during mount. [Probably could be solved by modifying every filesystem
-to support some kind of "really read-only!" option. Patches welcome.]
+during mount.
+
+There are few ways to get that fixed:
+
+1) Probably could be solved by modifying every filesystem to support
+some kind of "really read-only!" option. Patches welcome.
+
+2) suspend2 gets around that by storing absolute positions in on-disk
+image (and blocksize), with resume parameter pointing directly to
+suspend header.
+
+Q: Is there a maximum system RAM size that is supported by swsusp?
+
+A: It should work okay with highmem.
+
+Q: Does swsusp (to disk) use only one swap partition or can it use
+multiple swap partitions (aggregate them into one logical space)?
+
+A: Only one swap partition, sorry.
+
+Q: If my application(s) causes lots of memory & swap space to be used
+(over half of the total system RAM), is it correct that it is likely
+to be useless to try to suspend to disk while that app is running?
+
+A: No, it should work okay, as long as your app does not mlock()
+it. Just prepare big enough swap partition.
+
+Q: What information is usefull for debugging suspend-to-disk problems?
+
+A: Well, last messages on the screen are always useful. If something
+is broken, it is usually some kernel driver, therefore trying with as
+little as possible modules loaded helps a lot. I also prefer people to
+suspend from console, preferably without X running. Booting with
+init=/bin/bash, then swapon and starting suspend sequence manually
+usually does the trick. Then it is good idea to try with latest
+vanilla kernel.
+
+
diff --git a/Documentation/power/video.txt b/Documentation/power/video.txt
--- a/Documentation/power/video.txt
+++ b/Documentation/power/video.txt
@@ -120,6 +120,7 @@ IBM ThinkPad T42p (2373-GTG)	s3_bios (2)
 IBM TP X20			??? (*)
 IBM TP X30			s3_bios (2)
 IBM TP X31 / Type 2672-XXH      none (1), use radeontool (http://fdd.com/software/radeon/) to turn off backlight.
+IBM TP X32			none (1), but backlight is on and video is trashed after long suspend
 IBM Thinkpad X40 Type 2371-7JG  s3_bios,s3_mode (4)
 Medion MD4220			??? (*)
 Samsung P35			vbetool needed (6)
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -28,7 +28,7 @@ config PM_DEBUG
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on EXPERIMENTAL && PM && SWAP && ((X86 && SMP) || ((FVR || PPC32 || X86) && !SMP))
+	depends on PM && SWAP && (X86 || ((FVR || PPC32) && !SMP))
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.

-- 
if you have sharp zaurus hardware you don't need... you know my address
