Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSFCDUQ>; Sun, 2 Jun 2002 23:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSFCDUP>; Sun, 2 Jun 2002 23:20:15 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:47334 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S313711AbSFCDUN>; Sun, 2 Jun 2002 23:20:13 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] i386 "General Options" - begone [take 2]
Date: Mon, 3 Jun 2002 13:18:09 +1000
User-Agent: KMail/1.4.5
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
Cc: trivial@rustcorp.com.au
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_9614K5H48P9TUZQABLUJ"
Message-Id: <200206031318.09634.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_9614K5H48P9TUZQABLUJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

This patch (a minor update on one that I accidently left lkml out of the To:) 
removes the "General Options" top level config menu from the i386 build for 
2.5.20. It didn't describe what it was doing, and it contained a broad 
collection of mostly unrelated configuration options.
To replace it, you now get:
"Power management options (ACPI, APM)", which also includes software suspend.
"Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
"Executable file formats"

While moving software suspend, I also took the chance to tweak the Config.help 
entry.

To all those who don't like the expansion in top level directories - I agree, 
and have the genesis of a plan to build a more logical grouping (eg getting 
the various mass storage options together, getting the various networking 
options together, etc). One step at a time though, especially since that 
would affect multiple architectures.

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
--------------Boundary-00=_9614K5H48P9TUZQABLUJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="config.in-03062002.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config.in-03062002.patch"

diff -Naur -X dontdiff linux-2.5.20-clean/arch/i386/Config.help linux-2.5.20-config-munging/arch/i386/Config.help
--- linux-2.5.20-clean/arch/i386/Config.help	Thu May 30 04:42:46 2002
+++ linux-2.5.20-config-munging/arch/i386/Config.help	Mon Jun  3 12:39:48 2002
@@ -641,7 +641,8 @@
   off or put into a power conserving "sleep" mode if they are not
   being used.  There are two competing standards for doing this: APM
   and ACPI.  If you want to use either one, say Y here and then also
-  to the requisite support below.
+  to the requisite support below. This option is also required for
+  "software suspend", see below.
 
   Power Management is most important for battery powered laptop
   computers; if you have a laptop, check out the Linux Laptop home
@@ -943,13 +944,15 @@
 
 Software Suspend
 CONFIG_SOFTWARE_SUSPEND
-  Enable the possibilty of suspendig machine. It doesn't need APM.
-  You may suspend your machine by either pressing Sysrq-d or with
-  'swsusp' or 'shutdown -z <time>' (patch for sysvinit needed). It
-  creates an image which is saved in your active swaps. By the next
-  booting the kernel detects the saved image, restores the memory from
-  it and then it continues to run as before you've suspended.
-  If you don't want the previous state to continue use the 'noresume'
+  Enable the possibility of suspending the machine. This does not 
+  require APM. You may suspend your machine by either pressing 
+  Sysrq-d or with 'swsusp' or 'shutdown -z <time>' (patch for 
+  sysvinit needed). It creates an image which is saved in your
+  active swap space. The next time the kernel is booted, the saved
+  image is detected and restored to memory. The machine then 
+  continues to run, in the same configuration as before the suspend.
+
+  If you don't want the previous state to continue, use the 'noresume'
   kernel option. However note that your partitions will be fsck'd and
   you must re-mkswap your swap partitions/files.
 
@@ -958,10 +961,12 @@
   involved in suspending. Also in this case there is a risk that buffers
   on disk won't match with saved ones.
 
-  SMP is supported ``as-is''. There's a code for it but doesn't work.
-  There have been problems reported relating SCSI.
+  SMP is supported ``as-is''. That is, there is code to support SMP
+  but doesn't work. There have also been problems reported relating to 
+  SCSI.
   
-  This option is about getting stable. However there is still some
-  absence of features.
+  This option is becoming progressively more stable. However there are
+  still some missing features, and data corruption is always a 
+  possibility.
 
   For more information take a look at Documentation/swsusp.txt.
diff -Naur -X dontdiff linux-2.5.20-clean/arch/i386/config.in linux-2.5.20-config-munging/arch/i386/config.in
--- linux-2.5.20-clean/arch/i386/config.in	Thu May 30 04:42:51 2002
+++ linux-2.5.20-config-munging/arch/i386/config.in	Mon Jun  3 13:01:16 2002
@@ -209,9 +209,30 @@
 endmenu
 
 mainmenu_option next_comment
-comment 'General options'
+comment 'Power management options (ACPI, APM)'
 
-source drivers/acpi/Config.in
+bool 'Power Management support' CONFIG_PM
+if [ "$CONFIG_PM" = "y" ]; then
+   source drivers/acpi/Config.in
+
+   dep_tristate '  Advanced Power Management BIOS support' CONFIG_APM $CONFIG_PM
+   if [ "$CONFIG_APM" != "n" ]; then
+      bool '    Ignore USER SUSPEND' CONFIG_APM_IGNORE_USER_SUSPEND
+      bool '    Enable PM at boot time' CONFIG_APM_DO_ENABLE
+      bool '    Make CPU Idle calls when idle' CONFIG_APM_CPU_IDLE
+      bool '    Enable console blanking using APM' CONFIG_APM_DISPLAY_BLANK
+      bool '    RTC stores time in GMT' CONFIG_APM_RTC_IS_GMT
+      bool '    Allow interrupts during APM BIOS calls' CONFIG_APM_ALLOW_INTS
+      bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
+   fi
+
+   dep_bool 'Software Suspend (EXPERIMENTAL)' CONFIG_SOFTWARE_SUSPEND $CONFIG_EXPERIMENTAL $CONFIG_PM
+fi
+
+endmenu
+
+mainmenu_option next_comment
+comment 'Bus options (PCI, PCMCIA, EISA, MCA, ISA)'
 
 # Visual Workstation support is utterly broken.
 # If you want to see it working mail an VW540 to hch@infradead.org 8)
@@ -260,6 +281,11 @@
    define_bool CONFIG_HOTPLUG_PCI n
 fi
 
+endmenu
+
+mainmenu_option next_comment
+comment 'Executable file formats'
+
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    choice 'Kernel core (/proc/kcore) format' \
 	"ELF		CONFIG_KCORE_ELF	\
@@ -269,19 +295,6 @@
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
-bool 'Power Management support' CONFIG_PM
-
-dep_tristate '  Advanced Power Management BIOS support' CONFIG_APM $CONFIG_PM
-if [ "$CONFIG_APM" != "n" ]; then
-   bool '    Ignore USER SUSPEND' CONFIG_APM_IGNORE_USER_SUSPEND
-   bool '    Enable PM at boot time' CONFIG_APM_DO_ENABLE
-   bool '    Make CPU Idle calls when idle' CONFIG_APM_CPU_IDLE
-   bool '    Enable console blanking using APM' CONFIG_APM_DISPLAY_BLANK
-   bool '    RTC stores time in GMT' CONFIG_APM_RTC_IS_GMT
-   bool '    Allow interrupts during APM BIOS calls' CONFIG_APM_ALLOW_INTS
-   bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
-fi
-
 endmenu
 
 source drivers/mtd/Config.in
@@ -396,10 +409,6 @@
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
-if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-   dep_bool 'Software Suspend' CONFIG_SOFTWARE_SUSPEND $CONFIG_PM
-fi
-
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB

--------------Boundary-00=_9614K5H48P9TUZQABLUJ--

