Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbUKXNYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbUKXNYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbUKXNXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:23:37 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:60308 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262659AbUKXNC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:02:58 -0500
Subject: Suspend 2 merge: 26/51: Kconfig and makefile.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101296580.5805.292.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:59:16 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the changes to kernel/power/Makefile|Kconfig

diff -ruN 811-Kconfig-and-Makefile-for-suspend2-old/kernel/power/Kconfig 811-Kconfig-and-Makefile-for-suspend2-new/kernel/power/Kconfig
--- 811-Kconfig-and-Makefile-for-suspend2-old/kernel/power/Kconfig	2004-11-24 09:53:12.000000000 +1100
+++ 811-Kconfig-and-Makefile-for-suspend2-new/kernel/power/Kconfig	2004-11-24 18:51:15.213707144 +1100
@@ -30,6 +30,8 @@
 	bool "Software Suspend (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && PM && SWAP
 	---help---
+	  Pavel's original version.
+
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.
 	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
@@ -73,3 +75,138 @@
 	  suspended image to. It will simply pick the first available swap 
 	  device.
 
+menu "Software Suspend 2"
+
+config SOFTWARE_SUSPEND2_CORE
+	tristate "Software Suspend 2"
+	depends on PM
+	select SOFTWARE_SUSPEND2
+	---help---
+	  Software Suspend 2 is the 'new and improved' suspend support. You
+	  can now build it as modules, but be aware that this requires
+	  initrd support (the modules you use in saving the image have to
+	  be loaded in order for you to be able to resume!)
+	  
+	  See the Software Suspend home page (softwaresuspend.berlios.de)
+	  for FAQs, HOWTOs and other documentation.
+
+	config SOFTWARE_SUSPEND2
+	bool
+
+	if SOFTWARE_SUSPEND2
+		config SOFTWARE_SUSPEND2_WRITER
+		bool
+
+		comment 'Image Storage (you need at least one writer)'
+		depends on SOFTWARE_SUSPEND2_CORE
+	
+		config SOFTWARE_SUSPEND_SWAPWRITER
+			tristate '   Swap Writer'
+			depends on SWAP && SOFTWARE_SUSPEND2_CORE
+			select SOFTWARE_SUSPEND2_WRITER
+			---help---
+			  This option enabled support for storing an image in your
+			  swap space. Swap partitions are supported. Swap file
+			  support is currently broken (16 April 2004).
+
+		comment 'Page Transformers'
+			depends on SOFTWARE_SUSPEND2_WRITER
+
+		if SOFTWARE_SUSPEND2_WRITER
+			config SOFTWARE_SUSPEND_LZF_COMPRESSION
+				tristate '   LZF image compression (Preferred)'
+				---help---
+				  This option enables compression of pages stored during suspending
+				  to disk, using LZF compression. LZF compression is fast and
+				  still achieves a good compression ratio.
+
+				  You probably want to say 'Y'.
+
+			config SOFTWARE_SUSPEND_GZIP_COMPRESSION
+				tristate '   GZIP image Compression (Slow)'
+				depends on SOFTWARE_SUSPEND2_CORE
+				select ZLIB_DEFLATE
+				select ZLIB_INFLATE
+				---help---
+				  This option enables compression of pages stored during Software Suspend
+				  process. Pages are compressed using the zlib library, with a default
+				  setting (in code) of fastest compression (still VERY slow!). If your swap
+				  device is painfully slow compared to your CPU, you might possibly want
+				  this. Then again, you might just want to upgrade your storage (if you
+				  can).
+			  		
+				  Just in case you haven't gotten the hint yet, this option should be off
+				  for most people. If will make your computer take a minute to suspend
+				  when it could take seconds.
+
+			config SOFTWARE_SUSPEND_DEVICE_MAPPER
+				tristate '   Device Mapper support'
+				depends on SOFTWARE_SUSPEND2_CORE && BLK_DEV_DM
+				---help---
+				  This option creates a module which allows Suspend to tell the
+				  device mapper code to allocate enough memory for its work while
+				  suspending. It doesn't do anything else, but without it, dm-crypt
+				  won't work properly.
+
+				  This option should be off for most people.
+
+			comment 'User Interface Options'
+
+			config SOFTWARE_SUSPEND_BOOTSPLASH
+				tristate '  Bootsplash support'
+				depends on SOFTWARE_SUSPEND2_CORE && BOOTSPLASH
+				---help---
+				  This option enables support for Bootsplash (bootsplash.org). Suspend
+				  can set the progress bar value and switch between silent and verbose
+				  modes. (Silent mode is used when the debug level is 0 or 1). 
+				
+			config SOFTWARE_SUSPEND_TEXT_MODE
+				tristate '  Text mode console support'
+				depends on SOFTWARE_SUSPEND2_CORE && VT
+				---help---
+				  This option enables support for a text mode 'nice display'. If you don't
+				  have/want bootsplash support, you probably want this.
+				
+			comment 'General Options'
+
+			config SOFTWARE_SUSPEND_DEFAULT_RESUME2
+				string '   Default resume device name'
+				---help---
+				  You normally need to add a resume2= parameter to your lilo.conf or
+				  equivalent. With this option properly set, the kernel has a value
+				  to default. No damage will be done if the value is invalid.
+
+			config SOFTWARE_SUSPEND_KEEP_IMAGE
+				bool '   Allow Keep Image Mode'
+				---help---
+				  This option allows you to keep and image and reuse it. It is intended
+				  __ONLY__ for use with systems where all filesystems are mounted read-
+				  only (kiosks, for example). To use it, compile this option in and boot
+				  normally. Set the KEEP_IMAGE flag in /proc/software_suspend and suspend.
+				  When you resume, the image will not be removed. You will be unable to turn
+				  off swap partitions (assuming you are using the swap writer), but future
+				  suspends simply do a power-down. The image can be updated using the
+				  kernel command line parameter suspend_act= to turn off the keep image
+				  bit. Keep image mode is a little less user friendly on purpose - it
+				  should not be used without thought!
+
+			comment 'Debugging'
+
+			config SOFTWARE_SUSPEND_DEBUG
+				bool '   Compile in debugging output'
+				---help---
+				  This option enables the inclusion of debugging info in the software
+				  suspend code. Turning it off will reduce the kernel size but make
+				  debugging suspend & resume issues harder to do.
+			
+				  For normal usage, this option can be turned off.
+
+		endif
+
+	endif
+
+endmenu
+
+comment 'Suspend2 depends on EXPERIMENTAL and PM support.'
+	depends on !EXPERIMENTAL || !PM
+
diff -ruN 811-Kconfig-and-Makefile-for-suspend2-old/kernel/power/Makefile 811-Kconfig-and-Makefile-for-suspend2-new/kernel/power/Makefile
--- 811-Kconfig-and-Makefile-for-suspend2-old/kernel/power/Makefile	2004-11-03 21:55:05.000000000 +1100
+++ 811-Kconfig-and-Makefile-for-suspend2-new/kernel/power/Makefile	2004-11-24 18:50:24.503416280 +1100
@@ -6,6 +6,22 @@
 swsusp-smp-$(CONFIG_SMP)	+= smp.o
 
 obj-y				:= main.o process.o console.o pm.o
+
+ifeq ($(CONFIG_SOFTWARE_SUSPEND2),y)
+obj-y	+= suspend_builtin.o proc.o
+endif
+
+suspend_core-objs := io.o memory_pool.o pagedir.o prepare_image.o \
+		range.o suspend.o plugins.o suspend_ui.o utility.o
+
+obj-$(CONFIG_SOFTWARE_SUSPEND2_CORE)		+= suspend_core.o
+obj-$(CONFIG_SOFTWARE_SUSPEND_BOOTSPLASH)	+= suspend_bootsplash.o
+obj-$(CONFIG_SOFTWARE_SUSPEND_TEXT_MODE)	+= suspend_text.o
+obj-$(CONFIG_SOFTWARE_SUSPEND_LZF_COMPRESSION)	+= suspend_lzf.o
+obj-$(CONFIG_SOFTWARE_SUSPEND_GZIP_COMPRESSION)	+= suspend_gzip.o
+obj-$(CONFIG_SOFTWARE_SUSPEND_DEVICE_MAPPER)	+= suspend_dm.o
+obj-$(CONFIG_SOFTWARE_SUSPEND_SWAPWRITER)	+= suspend_block_io.o suspend_swap.o
+
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o $(swsusp-smp-y) disk.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o


